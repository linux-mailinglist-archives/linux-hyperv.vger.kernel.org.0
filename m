Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7EE48CC98
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 20:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350626AbiALT4i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 14:56:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33330 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357564AbiALTzS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 14:55:18 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 340F020B7187;
        Wed, 12 Jan 2022 11:55:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 340F020B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642017316;
        bh=3mfx9vvdbj/peEwxVRo3SoegOw8Ms2ugb7oz/swdAwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjrYjwv/CW6lp0RRP29uQDrQiqIXxB0qm+yNfNMFnAPbZAD0yifeyD2qdc6ZC+Kku
         b1ffgOq9t0LLh3kRpis5obT44NmyZRaG6BdhQAR8a2xSrg5QvmSI4+kTspV9FtJRBI
         xZzFWD6x6UB8e7VBUhrAUW17/n42n+VgtVd+vDHI=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 5/9] drivers: hv: dxgkrnl: Implement sharing resources and sync objects
Date:   Wed, 12 Jan 2022 11:55:10 -0800
Message-Id: <292d966345ac8daf70abc6220a19efd0f810057f.1641937420.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641937419.git.iourit@linux.microsoft.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement IOCTLs for sharing dxgresource and dxgsyncobject objects between
processes in the virtual machine.

Resources and sync objects are shared using FD (file descriptor) handles.
The name "NT handle" is used to be compatible with Windows implementation.

An FD handle is created by the LX_DXSHAREOBJECTS ioctl. The given FD
handle could be sent to another process using any Linux API.

To use a shared object in WDDM API calls, the object needs to be opened
using its FD handle. An object could be opened by the following ioctls:
LX_DXOPENRESOURCEFROMNTHANDLE,
LX_DXOPENSYNCOBJECTFROMNTHANDLE2.

LX_DXQUERYRESOURCEINFOFROMNTHANDLE is used to query private driver
data of a shared resource object. This private data needs to be used
to actually open the object using LX_DXOPENRESOURCEFROMNTHANDLE.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgvmbus.c | 190 +++++++
 drivers/hv/dxgkrnl/ioctl.c    | 936 +++++++++++++++++++++++++++++++++-
 2 files changed, 1123 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 4fe799eb8968..6fc0771f383d 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -690,6 +690,142 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process)
 	return ret;
 }
 
+int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
+				    struct dxgvmbuschannel *channel,
+				    struct d3dkmt_opensyncobjectfromnthandle2
+				    *args,
+				    struct dxgsyncobject *syncobj)
+{
+	struct dxgkvmb_command_opensyncobject *command;
+	struct dxgkvmb_command_opensyncobject_return result = { };
+	int ret;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vm_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_OPENSYNCOBJECT,
+				 process->host_handle);
+	command->device = args->device;
+	command->global_sync_object = syncobj->shared_owner->host_shared_handle;
+	command->flags = args->flags;
+	if (syncobj->monitored_fence)
+		command->engine_affinity =
+			args->monitored_fence.engine_affinity;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_sync_msg(channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+
+	dxgglobal_release_channel_lock();
+
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result.status);
+	if (ret < 0)
+		goto cleanup;
+
+	args->sync_object = result.sync_object;
+	if (syncobj->monitored_fence) {
+		void *va = dxg_map_iospace(result.guest_cpu_physical_address,
+					   PAGE_SIZE, PROT_READ | PROT_WRITE,
+					   true);
+		if (va == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		args->monitored_fence.fence_value_cpu_va = va;
+		args->monitored_fence.fence_value_gpu_va =
+		    result.gpu_virtual_address;
+		syncobj->mapped_address = va;
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
+					struct d3dkmthandle object,
+					struct d3dkmthandle *shared_handle)
+{
+	struct dxgkvmb_command_createntsharedobject *command;
+	int ret;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vm_to_host_init2(&command->hdr,
+				 DXGK_VMBCOMMAND_CREATENTSHAREDOBJECT,
+				 process->host_handle);
+	command->object = object;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_sync_msg(dxgglobal_get_dxgvmbuschannel(),
+				   msg.hdr, msg.size, shared_handle,
+				   sizeof(*shared_handle));
+
+	dxgglobal_release_channel_lock();
+
+	if (ret < 0)
+		goto cleanup;
+	if (shared_handle->v == 0) {
+		pr_err("failed to create NT shared object");
+		ret = -ENOTRECOVERABLE;
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_destroy_nt_shared_object(struct d3dkmthandle shared_handle)
+{
+	struct dxgkvmb_command_destroyntsharedobject *command;
+	int ret;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vm_to_host_init1(&command->hdr,
+				 DXGK_VMBCOMMAND_DESTROYNTSHAREDOBJECT);
+	command->shared_handle = shared_handle;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(dxgglobal_get_dxgvmbuschannel(),
+					    msg.hdr, msg.size);
+
+	dxgglobal_release_channel_lock();
+
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_destroy_sync_object(struct dxgprocess *process,
 				    struct d3dkmthandle sync_object)
 {
@@ -1495,6 +1631,60 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_open_resource(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dkmthandle device,
+			      struct d3dkmthandle global_share,
+			      u32 allocation_count,
+			      u32 total_priv_drv_data_size,
+			      struct d3dkmthandle *resource_handle,
+			      struct d3dkmthandle *alloc_handles)
+{
+	struct dxgkvmb_command_openresource *command;
+	struct dxgkvmb_command_openresource_return *result;
+	struct d3dkmthandle *handles;
+	int ret;
+	int i;
+	u32 result_size = allocation_count * sizeof(struct d3dkmthandle) +
+			   sizeof(*result);
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	ret = init_message_res(&msg, adapter, process, sizeof(*command),
+			       result_size);
+	if (ret)
+		goto cleanup;
+	command = msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_OPENRESOURCE,
+				   process->host_handle);
+	command->device = device;
+	command->nt_security_sharing = 1;
+	command->global_share = global_share;
+	command->allocation_count = allocation_count;
+	command->total_priv_drv_data_size = total_priv_drv_data_size;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result->status);
+	if (ret < 0)
+		goto cleanup;
+
+	*resource_handle = result->resource;
+	handles = (struct d3dkmthandle *) &result[1];
+	for (i = 0; i < allocation_count; i++)
+		alloc_handles[i] = handles[i];
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 				  enum d3dkmdt_standardallocationtype alloctype,
 				  struct d3dkmdt_gdisurfacedata *alloc_data,
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index f484b0da702c..2086f7347ba3 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -37,6 +37,61 @@ static char *errorstr(int ret)
 	return ret < 0 ? "err" : "";
 }
 
+static int dxgsyncobj_release(struct inode *inode, struct file *file)
+{
+	struct dxgsharedsyncobject *syncobj = file->private_data;
+
+	dev_dbg(dxgglobaldev, "%s: %p", __func__, syncobj);
+	mutex_lock(&syncobj->fd_mutex);
+	kref_get(&syncobj->ssyncobj_kref);
+	syncobj->host_shared_handle_nt_reference--;
+	if (syncobj->host_shared_handle_nt_reference == 0) {
+		if (syncobj->host_shared_handle_nt.v) {
+			dxgvmb_send_destroy_nt_shared_object(
+					syncobj->host_shared_handle_nt);
+			dev_dbg(dxgglobaldev, "Syncobj host_handle_nt destroyed: %x",
+				    syncobj->host_shared_handle_nt.v);
+			syncobj->host_shared_handle_nt.v = 0;
+		}
+		kref_put(&syncobj->ssyncobj_kref, dxgsharedsyncobj_release);
+	}
+	mutex_unlock(&syncobj->fd_mutex);
+	kref_put(&syncobj->ssyncobj_kref, dxgsharedsyncobj_release);
+	return 0;
+}
+
+static const struct file_operations dxg_syncobj_fops = {
+	.release = dxgsyncobj_release,
+};
+
+static int dxgsharedresource_release(struct inode *inode, struct file *file)
+{
+	struct dxgsharedresource *resource = file->private_data;
+
+	dev_dbg(dxgglobaldev, "%s: %p", __func__, resource);
+	mutex_lock(&resource->fd_mutex);
+	kref_get(&resource->sresource_kref);
+	resource->host_shared_handle_nt_reference--;
+	if (resource->host_shared_handle_nt_reference == 0) {
+		if (resource->host_shared_handle_nt.v) {
+			dxgvmb_send_destroy_nt_shared_object(
+					resource->host_shared_handle_nt);
+			dev_dbg(dxgglobaldev,
+				"Resource host_handle_nt destroyed: %x",
+				resource->host_shared_handle_nt.v);
+			resource->host_shared_handle_nt.v = 0;
+		}
+		kref_put(&resource->sresource_kref, dxgsharedresource_destroy);
+	}
+	mutex_unlock(&resource->fd_mutex);
+	kref_put(&resource->sresource_kref, dxgsharedresource_destroy);
+	return 0;
+}
+
+static const struct file_operations dxg_resource_fops = {
+	.release = dxgsharedresource_release,
+};
+
 static int dxgk_open_adapter_from_luid(struct dxgprocess *process,
 						   void *__user inargs)
 {
@@ -219,6 +274,97 @@ dxgkp_enum_adapters(struct dxgprocess *process,
 	return ret;
 }
 
+static int dxgsharedresource_seal(struct dxgsharedresource *shared_resource)
+{
+	int ret = 0;
+	int i = 0;
+	u8 *private_data;
+	u32 data_size;
+	struct dxgresource *resource;
+	struct dxgallocation *alloc;
+
+	dev_dbg(dxgglobaldev, "Sealing resource: %p", shared_resource);
+
+	down_write(&shared_resource->adapter->shared_resource_list_lock);
+	if (shared_resource->sealed) {
+		dev_dbg(dxgglobaldev, "Resource already sealed");
+		goto cleanup;
+	}
+	shared_resource->sealed = 1;
+	if (!list_empty(&shared_resource->resource_list_head)) {
+		resource =
+		    list_first_entry(&shared_resource->resource_list_head,
+				     struct dxgresource,
+				     shared_resource_list_entry);
+		dev_dbg(dxgglobaldev, "First resource: %p", resource);
+		mutex_lock(&resource->resource_mutex);
+		list_for_each_entry(alloc, &resource->alloc_list_head,
+				    alloc_list_entry) {
+			dev_dbg(dxgglobaldev, "Resource alloc: %p %d", alloc,
+				    alloc->priv_drv_data->data_size);
+			shared_resource->allocation_count++;
+			shared_resource->alloc_private_data_size +=
+			    alloc->priv_drv_data->data_size;
+			if (shared_resource->alloc_private_data_size <
+			    alloc->priv_drv_data->data_size) {
+				pr_err("alloc private data overflow");
+				ret = -EINVAL;
+				goto cleanup1;
+			}
+		}
+		if (shared_resource->alloc_private_data_size == 0) {
+			ret = -EINVAL;
+			goto cleanup1;
+		}
+		shared_resource->alloc_private_data =
+			vzalloc(shared_resource->alloc_private_data_size);
+		if (shared_resource->alloc_private_data == NULL) {
+			ret = -EINVAL;
+			goto cleanup1;
+		}
+		shared_resource->alloc_private_data_sizes =
+			vzalloc(sizeof(u32)*shared_resource->allocation_count);
+		if (shared_resource->alloc_private_data_sizes == NULL) {
+			ret = -EINVAL;
+			goto cleanup1;
+		}
+		private_data = shared_resource->alloc_private_data;
+		data_size = shared_resource->alloc_private_data_size;
+		i = 0;
+		list_for_each_entry(alloc, &resource->alloc_list_head,
+				    alloc_list_entry) {
+			u32 alloc_data_size = alloc->priv_drv_data->data_size;
+
+			if (alloc_data_size) {
+				if (data_size < alloc_data_size) {
+					pr_err("Invalid private data size");
+					ret = -EINVAL;
+					goto cleanup1;
+				}
+				shared_resource->alloc_private_data_sizes[i] =
+				    alloc_data_size;
+				memcpy(private_data,
+				       alloc->priv_drv_data->data,
+				       alloc_data_size);
+				vfree(alloc->priv_drv_data);
+				alloc->priv_drv_data = NULL;
+				private_data += alloc_data_size;
+				data_size -= alloc_data_size;
+			}
+			i++;
+		}
+		if (data_size != 0) {
+			pr_err("Data size mismatch");
+			ret = -EINVAL;
+		}
+cleanup1:
+		mutex_unlock(&resource->resource_mutex);
+	}
+cleanup:
+	up_write(&shared_resource->adapter->shared_resource_list_lock);
+	return ret;
+}
+
 static int
 dxgk_enum_adapters(struct dxgprocess *process, void *__user inargs)
 {
@@ -1644,6 +1790,148 @@ dxgk_destroy_sync_object(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_open_sync_object_nt(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_opensyncobjectfromnthandle2 args;
+	struct dxgsyncobject *syncobj = NULL;
+	struct dxgsharedsyncobject *syncobj_fd = NULL;
+	struct file *file = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dddi_synchronizationobject_flags flags = { };
+	int ret;
+	bool device_lock_acquired = false;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	args.sync_object.v = 0;
+
+	if (args.device.v) {
+		device = dxgprocess_device_by_handle(process, args.device);
+		if (device == NULL) {
+			return -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		pr_err("device handle is missing");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0)
+		goto cleanup;
+
+	device_lock_acquired = true;
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	file = fget(args.nt_handle);
+	if (!file) {
+		pr_err("failed to get file from handle: %llx",
+			   args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (file->f_op != &dxg_syncobj_fops) {
+		pr_err("invalid fd: %llx", args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	syncobj_fd = file->private_data;
+	if (syncobj_fd == NULL) {
+		pr_err("invalid private data: %llx", args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	flags.shared = 1;
+	flags.nt_security_sharing = 1;
+	syncobj = dxgsyncobject_create(process, device, adapter,
+				       syncobj_fd->type, flags);
+	if (syncobj == NULL) {
+		pr_err("failed to create sync object");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	dxgsharedsyncobj_add_syncobj(syncobj_fd, syncobj);
+
+	ret = dxgvmb_send_open_sync_object_nt(process, &dxgglobal->channel,
+					      &args, syncobj);
+	if (ret < 0) {
+		pr_err("failed to open sync object on host: %x",
+			syncobj_fd->host_shared_handle.v);
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	ret = hmgrtable_assign_handle(&process->handle_table, syncobj,
+				      HMGRENTRY_TYPE_DXGSYNCOBJECT,
+				      args.sync_object);
+	if (ret >= 0) {
+		syncobj->handle = args.sync_object;
+		kref_get(&syncobj->syncobj_kref);
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret >= 0)
+		goto success;
+	pr_err("%s failed to copy output args", __func__);
+
+cleanup:
+
+	if (syncobj) {
+		dxgsyncobject_destroy(process, syncobj);
+		syncobj = NULL;
+	}
+
+	if (args.sync_object.v)
+		dxgvmb_send_destroy_sync_object(process, args.sync_object);
+
+success:
+
+	if (file)
+		fput(file);
+	if (syncobj)
+		kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device_lock_acquired)
+		dxgdevice_release_lock_shared(device);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_open_sync_object(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not supported", __func__);
+	return -ENOTTY;
+}
+
 static int
 dxgk_signal_sync_object(struct dxgprocess *process, void *__user inargs)
 {
@@ -2123,10 +2411,13 @@ dxgk_wait_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
 	if (args.async_event == 0) {
 		dxgadapter_release_lock_shared(adapter);
 		adapter = NULL;
-		ret = wait_for_completion_killable(&local_event);
-		if (ret)
-			pr_err("%s: wait_for_completion_killable failed: %d",
+		ret = wait_for_completion_interruptible(&local_event);
+		if (ret) {
+			pr_err("%s: wait_completion_interruptible failed: %d",
 			       __func__, ret);
+			ret = -ERESTARTSYS;
+		}
+
 	}
 
 cleanup:
@@ -2295,6 +2586,631 @@ dxgk_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgsharedsyncobj_get_host_nt_handle(struct dxgsharedsyncobject *syncobj,
+				    struct dxgprocess *process,
+				    struct d3dkmthandle objecthandle)
+{
+	int ret = 0;
+
+	mutex_lock(&syncobj->fd_mutex);
+	if (syncobj->host_shared_handle_nt_reference == 0) {
+		ret = dxgvmb_send_create_nt_shared_object(process,
+			objecthandle,
+			&syncobj->host_shared_handle_nt);
+		if (ret < 0)
+			goto cleanup;
+		dev_dbg(dxgglobaldev, "Host_shared_handle_ht: %x",
+			    syncobj->host_shared_handle_nt.v);
+		kref_get(&syncobj->ssyncobj_kref);
+	}
+	syncobj->host_shared_handle_nt_reference++;
+cleanup:
+	mutex_unlock(&syncobj->fd_mutex);
+	return ret;
+}
+
+static int
+dxgsharedresource_get_host_nt_handle(struct dxgsharedresource *resource,
+				     struct dxgprocess *process,
+				     struct d3dkmthandle objecthandle)
+{
+	int ret = 0;
+
+	mutex_lock(&resource->fd_mutex);
+	if (resource->host_shared_handle_nt_reference == 0) {
+		ret = dxgvmb_send_create_nt_shared_object(process,
+					objecthandle,
+					&resource->host_shared_handle_nt);
+		if (ret < 0)
+			goto cleanup;
+		dev_dbg(dxgglobaldev, "Resource host_shared_handle_ht: %x",
+			    resource->host_shared_handle_nt.v);
+		kref_get(&resource->sresource_kref);
+	}
+	resource->host_shared_handle_nt_reference++;
+cleanup:
+	mutex_unlock(&resource->fd_mutex);
+	return ret;
+}
+
+enum dxg_sharedobject_type {
+	DXG_SHARED_SYNCOBJECT,
+	DXG_SHARED_RESOURCE
+};
+
+static int get_object_fd(enum dxg_sharedobject_type type,
+				     void *object, int *fdout)
+{
+	struct file *file;
+	int fd;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		pr_err("get_unused_fd_flags failed: %x", fd);
+		return -ENOTRECOVERABLE;
+	}
+
+	switch (type) {
+	case DXG_SHARED_SYNCOBJECT:
+		file = anon_inode_getfile("dxgsyncobj",
+					  &dxg_syncobj_fops, object, 0);
+		break;
+	case DXG_SHARED_RESOURCE:
+		file = anon_inode_getfile("dxgresource",
+					  &dxg_resource_fops, object, 0);
+		break;
+	default:
+		return -EINVAL;
+	};
+	if (IS_ERR(file)) {
+		pr_err("anon_inode_getfile failed: %x", fd);
+		put_unused_fd(fd);
+		return -ENOTRECOVERABLE;
+	}
+
+	fd_install(fd, file);
+	*fdout = fd;
+	return 0;
+}
+
+static int
+dxgk_share_objects(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_shareobjects args;
+	enum hmgrentry_type object_type;
+	struct dxgsyncobject *syncobj = NULL;
+	struct dxgresource *resource = NULL;
+	struct dxgsharedsyncobject *shared_syncobj = NULL;
+	struct dxgsharedresource *shared_resource = NULL;
+	struct d3dkmthandle *handles = NULL;
+	int object_fd = 0;
+	void *obj = NULL;
+	u32 handle_size;
+	int ret;
+	u64 tmp = 0;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count == 0 || args.object_count > 1) {
+		pr_err("invalid object count %d", args.object_count);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	handle_size = args.object_count * sizeof(struct d3dkmthandle);
+
+	handles = vzalloc(handle_size);
+	if (handles == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	ret = copy_from_user(handles, args.objects, handle_size);
+	if (ret) {
+		pr_err("%s failed to copy object handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	dev_dbg(dxgglobaldev, "Sharing handle: %x", handles[0].v);
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+	object_type = hmgrtable_get_object_type(&process->handle_table,
+						handles[0]);
+	obj = hmgrtable_get_object(&process->handle_table, handles[0]);
+	if (obj == NULL) {
+		pr_err("invalid object handle %x", handles[0].v);
+		ret = -EINVAL;
+	} else {
+		switch (object_type) {
+		case HMGRENTRY_TYPE_DXGSYNCOBJECT:
+			syncobj = obj;
+			if (syncobj->shared) {
+				kref_get(&syncobj->syncobj_kref);
+				shared_syncobj = syncobj->shared_owner;
+			} else {
+				pr_err("sync object is not shared");
+				syncobj = NULL;
+				ret = -EINVAL;
+			}
+			break;
+		case HMGRENTRY_TYPE_DXGRESOURCE:
+			resource = obj;
+			if (resource->shared_owner) {
+				kref_get(&resource->resource_kref);
+				shared_resource = resource->shared_owner;
+			} else {
+				resource = NULL;
+				pr_err("resource object is not shared");
+				ret = -EINVAL;
+			}
+			break;
+		default:
+			pr_err("invalid object type %d", object_type);
+			ret = -EINVAL;
+			break;
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+
+	if (ret < 0)
+		goto cleanup;
+
+	switch (object_type) {
+	case HMGRENTRY_TYPE_DXGSYNCOBJECT:
+		ret = get_object_fd(DXG_SHARED_SYNCOBJECT, shared_syncobj,
+				    &object_fd);
+		if (ret >= 0)
+			ret =
+			    dxgsharedsyncobj_get_host_nt_handle(shared_syncobj,
+								process,
+								handles[0]);
+		break;
+	case HMGRENTRY_TYPE_DXGRESOURCE:
+		ret = get_object_fd(DXG_SHARED_RESOURCE, shared_resource,
+				    &object_fd);
+		if (ret >= 0)
+			ret = dxgsharedresource_get_host_nt_handle(
+				shared_resource, process, handles[0]);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret < 0)
+		goto cleanup;
+
+	dev_dbg(dxgglobaldev, "Object FD: %x", object_fd);
+
+	tmp = (u64) object_fd;
+
+	ret = copy_to_user(args.shared_handle, &tmp, sizeof(u64));
+	if (ret < 0)
+		pr_err("%s failed to copy shared handle", __func__);
+
+cleanup:
+	if (ret < 0) {
+		if (object_fd > 0)
+			put_unused_fd(object_fd);
+	}
+
+	if (handles)
+		vfree(handles);
+
+	if (syncobj)
+		kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
+
+	if (resource)
+		kref_put(&resource->resource_kref, dxgresource_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_query_resource_info(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not supported", __func__);
+	return -ENOTTY;
+}
+
+static int
+dxgk_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryresourceinfofromnthandle args;
+	int ret;
+	struct dxgdevice *device = NULL;
+	struct dxgsharedresource *shared_resource = NULL;
+	struct file *file = NULL;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	file = fget(args.nt_handle);
+	if (!file) {
+		pr_err("failed to get file from handle: %llx",
+			   args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (file->f_op != &dxg_resource_fops) {
+		pr_err("invalid fd: %llx", args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	shared_resource = file->private_data;
+	if (shared_resource == NULL) {
+		pr_err("invalid private data: %llx", args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0) {
+		kref_put(&device->device_kref, dxgdevice_release);
+		device = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgsharedresource_seal(shared_resource);
+	if (ret < 0)
+		goto cleanup;
+
+	args.private_runtime_data_size =
+	    shared_resource->runtime_private_data_size;
+	args.resource_priv_drv_data_size =
+	    shared_resource->resource_private_data_size;
+	args.allocation_count = shared_resource->allocation_count;
+	args.total_priv_drv_data_size =
+	    shared_resource->alloc_private_data_size;
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret < 0)
+		pr_err("%s failed to copy output args", __func__);
+
+cleanup:
+
+	if (file)
+		fput(file);
+	if (device)
+		dxgdevice_release_lock_shared(device);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+int
+assign_resource_handles(struct dxgprocess *process,
+			struct dxgsharedresource *shared_resource,
+			struct d3dkmt_openresourcefromnthandle *args,
+			struct d3dkmthandle resource_handle,
+			struct dxgresource *resource,
+			struct dxgallocation **allocs,
+			struct d3dkmthandle *handles)
+{
+	int ret;
+	int i;
+	u8 *cur_priv_data;
+	u32 total_priv_data_size = 0;
+	struct d3dddi_openallocationinfo2 open_alloc_info = { };
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	ret = hmgrtable_assign_handle(&process->handle_table, resource,
+				      HMGRENTRY_TYPE_DXGRESOURCE,
+				      resource_handle);
+	if (ret < 0)
+		goto cleanup;
+	resource->handle = resource_handle;
+	resource->handle_valid = 1;
+	cur_priv_data = args->total_priv_drv_data;
+	for (i = 0; i < args->allocation_count; i++) {
+		ret = hmgrtable_assign_handle(&process->handle_table, allocs[i],
+					      HMGRENTRY_TYPE_DXGALLOCATION,
+					      handles[i]);
+		if (ret < 0)
+			goto cleanup;
+		allocs[i]->alloc_handle = handles[i];
+		allocs[i]->handle_valid = 1;
+		open_alloc_info.allocation = handles[i];
+		if (shared_resource->alloc_private_data_sizes)
+			open_alloc_info.priv_drv_data_size =
+			    shared_resource->alloc_private_data_sizes[i];
+		else
+			open_alloc_info.priv_drv_data_size = 0;
+
+		total_priv_data_size += open_alloc_info.priv_drv_data_size;
+		open_alloc_info.priv_drv_data = cur_priv_data;
+		cur_priv_data += open_alloc_info.priv_drv_data_size;
+
+		ret = copy_to_user(&args->open_alloc_info[i],
+				   &open_alloc_info,
+				   sizeof(open_alloc_info));
+		if (ret < 0) {
+			pr_err("%s failed to copy alloc info", __func__);
+			goto cleanup;
+		}
+	}
+	args->total_priv_drv_data_size = total_priv_data_size;
+cleanup:
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (ret < 0) {
+		for (i = 0; i < args->allocation_count; i++)
+			dxgallocation_free_handle(allocs[i]);
+		dxgresource_free_handle(resource);
+	}
+	dev_dbg(dxgglobaldev, "%s end %x", __func__, ret);
+	return ret;
+}
+
+int
+open_resource(struct dxgprocess *process,
+	      struct d3dkmt_openresourcefromnthandle *args,
+	      __user struct d3dkmthandle *res_out,
+	      __user u32 *total_driver_data_size_out)
+{
+	int ret = 0;
+	int i;
+	struct d3dkmthandle *alloc_handles = NULL;
+	int alloc_handles_size = sizeof(struct d3dkmthandle) *
+				 args->allocation_count;
+	struct dxgsharedresource *shared_resource = NULL;
+	struct dxgresource *resource = NULL;
+	struct dxgallocation **allocs = NULL;
+	struct d3dkmthandle global_share = {};
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmthandle resource_handle = {};
+	struct file *file = NULL;
+
+	dev_dbg(dxgglobaldev, "Opening resource handle: %llx", args->nt_handle);
+
+	file = fget(args->nt_handle);
+	if (!file) {
+		pr_err("failed to get file from handle: %llx",
+				args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (file->f_op != &dxg_resource_fops) {
+		pr_err("invalid fd type: %llx", args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	shared_resource = file->private_data;
+	if (shared_resource == NULL) {
+		pr_err("invalid private data: %llx",
+				args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (kref_get_unless_zero(&shared_resource->sresource_kref) == 0)
+		shared_resource = NULL;
+	else
+		global_share = shared_resource->host_shared_handle_nt;
+
+	if (shared_resource == NULL) {
+		pr_err("Invalid shared resource handle: %x",
+			   (u32)args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	dev_dbg(dxgglobaldev, "Shared resource: %p %x", shared_resource,
+		    global_share.v);
+
+	device = dxgprocess_device_by_handle(process, args->device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0) {
+		kref_put(&device->device_kref, dxgdevice_release);
+		device = NULL;
+		goto cleanup;
+	}
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgsharedresource_seal(shared_resource);
+	if (ret < 0)
+		goto cleanup;
+
+	if (args->allocation_count != shared_resource->allocation_count ||
+	    args->private_runtime_data_size <
+	    shared_resource->runtime_private_data_size ||
+	    args->resource_priv_drv_data_size <
+	    shared_resource->resource_private_data_size ||
+	    args->total_priv_drv_data_size <
+	    shared_resource->alloc_private_data_size) {
+		ret = -EINVAL;
+		pr_err("Invalid data sizes");
+		goto cleanup;
+	}
+
+	alloc_handles = vzalloc(alloc_handles_size);
+	if (alloc_handles == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	allocs = vzalloc(sizeof(void *) * args->allocation_count);
+	if (allocs == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	resource = dxgresource_create(device);
+	if (resource == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	dxgsharedresource_add_resource(shared_resource, resource);
+
+	for (i = 0; i < args->allocation_count; i++) {
+		allocs[i] = dxgallocation_create(process);
+		if (allocs[i] == NULL)
+			goto cleanup;
+		ret = dxgresource_add_alloc(resource, allocs[i]);
+		if (ret < 0)
+			goto cleanup;
+	}
+
+	ret = dxgvmb_send_open_resource(process, adapter,
+					device->handle, global_share,
+					args->allocation_count,
+					args->total_priv_drv_data_size,
+					&resource_handle, alloc_handles);
+	if (ret < 0) {
+		pr_err("dxgvmb_send_open_resource failed");
+		goto cleanup;
+	}
+
+	if (shared_resource->runtime_private_data_size) {
+		ret = copy_to_user(args->private_runtime_data,
+				shared_resource->runtime_private_data,
+				shared_resource->runtime_private_data_size);
+		if (ret < 0) {
+			pr_err("%s failed to copy runtime data", __func__);
+			goto cleanup;
+		}
+	}
+
+	if (shared_resource->resource_private_data_size) {
+		ret = copy_to_user(args->resource_priv_drv_data,
+				shared_resource->resource_private_data,
+				shared_resource->resource_private_data_size);
+		if (ret < 0) {
+			pr_err("%s failed to copy resource data", __func__);
+			goto cleanup;
+		}
+	}
+
+	if (shared_resource->alloc_private_data_size) {
+		ret = copy_to_user(args->total_priv_drv_data,
+				shared_resource->alloc_private_data,
+				shared_resource->alloc_private_data_size);
+		if (ret < 0) {
+			pr_err("%s failed to copy alloc data", __func__);
+			goto cleanup;
+		}
+	}
+
+	ret = assign_resource_handles(process, shared_resource, args,
+				      resource_handle, resource, allocs,
+				      alloc_handles);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(res_out, &resource_handle,
+			   sizeof(struct d3dkmthandle));
+	if (ret < 0) {
+		pr_err("%s failed to copy resource handle to user", __func__);
+		goto cleanup;
+	}
+
+	ret = copy_to_user(total_driver_data_size_out,
+			   &args->total_priv_drv_data_size, sizeof(u32));
+	if (ret < 0)
+		pr_err("%s failed to copy total driver data size", __func__);
+
+cleanup:
+
+	if (ret < 0) {
+		if (resource_handle.v) {
+			struct d3dkmt_destroyallocation2 tmp = { };
+
+			tmp.flags.assume_not_in_use = 1;
+			tmp.device = args->device;
+			tmp.resource = resource_handle;
+			ret = dxgvmb_send_destroy_allocation(process, device,
+							     &tmp, NULL);
+		}
+		if (resource)
+			dxgresource_destroy(resource);
+	}
+
+	if (file)
+		fput(file);
+	if (allocs)
+		vfree(allocs);
+	if (shared_resource)
+		kref_put(&shared_resource->sresource_kref,
+			 dxgsharedresource_destroy);
+	if (alloc_handles)
+		vfree(alloc_handles);
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		dxgdevice_release_lock_shared(device);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
+static int
+dxgk_open_resource(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not supported", __func__);
+	return -ENOTTY;
+}
+
+static int
+dxgk_open_resource_nt(struct dxgprocess *process,
+				      void *__user inargs)
+{
+	struct d3dkmt_openresourcefromnthandle args;
+	struct d3dkmt_openresourcefromnthandle *__user args_user = inargs;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = open_resource(process, &args,
+			    &args_user->resource,
+			    &args_user->total_priv_drv_data_size);
+
+cleanup:
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_render(struct dxgprocess *process, void *__user inargs)
 {
@@ -2409,6 +3325,12 @@ void init_ioctls(void)
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x23 */ dxgk_get_shared_resource_adapter_luid,
 		  LX_DXGETSHAREDRESOURCEADAPTERLUID);
+	SET_IOCTL(/*0x28 */ dxgk_open_resource,
+		  LX_DXOPENRESOURCE);
+	SET_IOCTL(/*0x29 */ dxgk_open_sync_object,
+		  LX_DXOPENSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x2b */ dxgk_query_resource_info,
+		  LX_DXQUERYRESOURCEINFO);
 	SET_IOCTL(/*0x2d */ dxgk_render,
 		  LX_DXRENDER);
 	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
@@ -2423,4 +3345,12 @@ void init_ioctls(void)
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
+	SET_IOCTL(/*0x3f */ dxgk_share_objects,
+		  LX_DXSHAREOBJECTS);
+	SET_IOCTL(/*0x40 */ dxgk_open_sync_object_nt,
+		  LX_DXOPENSYNCOBJECTFROMNTHANDLE2);
+	SET_IOCTL(/*0x41 */ dxgk_query_resource_info_nt,
+		  LX_DXQUERYRESOURCEINFOFROMNTHANDLE);
+	SET_IOCTL(/*0x42 */ dxgk_open_resource_nt,
+		  LX_DXOPENRESOURCEFROMNTHANDLE);
 }
-- 
2.32.0

