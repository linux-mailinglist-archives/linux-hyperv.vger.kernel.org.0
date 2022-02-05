Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA34B4AA5E1
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379118AbiBECeo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45084 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379024AbiBECe0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:26 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id A89A620B8764;
        Fri,  4 Feb 2022 18:34:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A89A620B8764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028466;
        bh=sSxpXZZdqewSu/72oXnc+RjB2wtST49wbWTvhCc+OlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQptrbSl/2DFJuIubFeFcp6rs6j0hw6SbKJD/J5IUzIujzAhNZHT1jJ5GdZmaACkS
         Y9t0REaR9Iw4rb9YAZalyKk31uBHsc/PVvaFo/uRI/OA7vhew7/RH1D6EmXl+t2y9D
         k87DNk5wixoicsaji3p+0RykHkvzCP5820kLcfP8=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 19/24] drivers: hv: dxgkrnl: Simple IOCTLs LX_DXESCAPE, LX_DXMARKDEVICEASERROR, LX_DXQUERYSTATISTICS, LX_DXQUERYCLOCKCALIBRATION
Date:   Fri,  4 Feb 2022 18:34:17 -0800
Message-Id: <07c352a82707304cc5836313b97dfd97be8c7354.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

    These IOCTLs are logically simple:
    - input data is read
    - a message is sent to the host
    - the result is returned to the caller

    - LX_DXESCAPE (D3DKMTEscape)
      This IOCTL is used to send/receive private data between user mode
      driver and kernel mode driver. This is an extension of the WDDM APIs.

    - LX_DXMARKDEVICEASERROR (D3DKMTMarkDeviceAsError)
      The IOCTL is used to bring the dxgdevice object to the error state.
      Subsequent calls to use the device object will fail.

    - LX_DXQUERYSTATISTICS (D3DKMTQuerystatistics)
      The IOCTL is used to query various statistics from the compute device
      on the host.

    - LX_DXQUERYCLOCKCALIBRATION
      The IOCTL queries clock from the compute device.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  14 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 167 +++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 193 ++++++++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 2efad824ae72..8310dd9b7843 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -830,6 +830,9 @@ int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
 				      struct d3dddi_updateallocproperty *args,
 				      struct d3dddi_updateallocproperty *__user
 				      inargs);
+int dxgvmb_send_mark_device_as_error(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmt_markdeviceaserror *args);
 int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 					struct dxgadapter *adapter,
 					struct d3dkmt_setallocationpriority *a);
@@ -856,6 +859,11 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 				       struct dxgadapter *adapter,
 				       struct d3dkmt_submitcommandtohwqueue *a);
+int dxgvmb_send_query_clock_calibration(struct dxgprocess *process,
+					struct dxgadapter *adapter,
+					struct d3dkmt_queryclockcalibration *a,
+					struct d3dkmt_queryclockcalibration
+					*__user inargs);
 int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
 				       struct dxgadapter *adapter,
 				       struct d3dkmt_flushheaptransitions *arg);
@@ -868,6 +876,9 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				      struct dxgadapter *adapter,
 				      struct d3dkmt_queryallocationresidency
 				      *args);
+int dxgvmb_send_escape(struct dxgprocess *process,
+		       struct dxgadapter *adapter,
+		       struct d3dkmt_escape *args);
 int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 				  struct dxgadapter *adapter,
 				  struct d3dkmt_queryvideomemoryinfo *args,
@@ -897,6 +908,9 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 				  void *prive_alloc_data,
 				  u32 *res_priv_data_size,
 				  void *priv_res_data);
+int dxgvmb_send_query_statistics(struct dxgprocess *process,
+				 struct dxgadapter *adapter,
+				 struct d3dkmt_querystatistics *args);
 int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
 			  void *command,
 			  u32 cmd_size);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 684d9cecc804..f7fcbf62f95b 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1774,6 +1774,48 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_query_clock_calibration(struct dxgprocess *process,
+					struct dxgadapter *adapter,
+					struct d3dkmt_queryclockcalibration
+					*args,
+					struct d3dkmt_queryclockcalibration
+					*__user inargs)
+{
+	struct dxgkvmb_command_queryclockcalibration *command;
+	struct dxgkvmb_command_queryclockcalibration_return result;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_QUERYCLOCKCALIBRATION,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(&inargs->clock_data, &result.clock_data,
+			   sizeof(result.clock_data));
+	if (ret) {
+		pr_err("%s failed to copy clock data", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = ntstatus2int(result.status);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
 				       struct dxgadapter *adapter,
 				       struct d3dkmt_flushheaptransitions *args)
@@ -1870,6 +1912,70 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_escape(struct dxgprocess *process,
+		       struct dxgadapter *adapter,
+		       struct d3dkmt_escape *args)
+{
+	int ret;
+	struct dxgkvmb_command_escape *command = NULL;
+	u32 cmd_size = sizeof(*command);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	cmd_size = cmd_size - sizeof(args->priv_drv_data[0]) +
+	    args->priv_drv_data_size;
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_ESCAPE,
+				   process->host_handle);
+	command->adapter = args->adapter;
+	command->device = args->device;
+	command->type = args->type;
+	command->flags = args->flags;
+	command->priv_drv_data_size = args->priv_drv_data_size;
+	command->context = args->context;
+	if (args->priv_drv_data_size) {
+		ret = copy_from_user(command->priv_drv_data,
+				     args->priv_drv_data,
+				     args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s failed to copy priv data", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   command->priv_drv_data,
+				   args->priv_drv_data_size);
+	if (ret < 0)
+		goto cleanup;
+
+	if (args->priv_drv_data_size) {
+		ret = copy_to_user(args->priv_drv_data,
+				   command->priv_drv_data,
+				   args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s failed to copy priv data", __func__);
+			ret = -EINVAL;
+		}
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 				  struct dxgadapter *adapter,
 				  struct d3dkmt_queryvideomemoryinfo *args,
@@ -2606,6 +2712,31 @@ int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_mark_device_as_error(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmt_markdeviceaserror *args)
+{
+	struct dxgkvmb_command_markdeviceaserror *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_MARKDEVICEASERROR,
+				   process->host_handle);
+	command->args = *args;
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 				struct dxgadapter *adapter,
 				struct d3dkmt_setallocationpriority *args)
@@ -3087,3 +3218,39 @@ int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 		pr_debug("err: %s %d", __func__, ret);
 	return ret;
 }
+
+int dxgvmb_send_query_statistics(struct dxgprocess *process,
+				 struct dxgadapter *adapter,
+				 struct d3dkmt_querystatistics *args)
+{
+	struct dxgkvmb_command_querystatistics *command;
+	struct dxgkvmb_command_querystatistics_return *result;
+	int ret;
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	ret = init_message_res(&msg, adapter, process, sizeof(*command),
+			       sizeof(*result));
+	if (ret)
+		goto cleanup;
+	command = msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_QUERYSTATISTICS,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+
+	args->result = result->result;
+	ret = ntstatus2int(result->status);
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 8dd5b64a7dd5..6c9b6e6ea296 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -153,6 +153,66 @@ static int dxgk_open_adapter_from_luid(struct dxgprocess *process,
 	return ret;
 }
 
+static int dxgk_query_statistics(struct dxgprocess *process,
+				 void __user *inargs)
+{
+	struct d3dkmt_querystatistics *args;
+	int ret;
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+	struct winluid tmp;
+
+	pr_debug("ioctl: %s", __func__);
+
+	args = vzalloc(sizeof(struct d3dkmt_querystatistics));
+	if (args == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = copy_from_user(args, inargs, sizeof(*args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dxgadapter_acquire_lock_shared(entry) == 0) {
+			if (*(u64 *) &entry->luid ==
+			    *(u64 *) &args->adapter_luid) {
+				adapter = entry;
+				break;
+			}
+			dxgadapter_release_lock_shared(entry);
+		}
+	}
+	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
+	if (adapter) {
+		tmp = args->adapter_luid;
+		args->adapter_luid = adapter->host_adapter_luid;
+		ret = dxgvmb_send_query_statistics(process, adapter, args);
+		if (ret >= 0) {
+			args->adapter_luid = tmp;
+			ret = copy_to_user(inargs, args, sizeof(*args));
+			if (ret) {
+				pr_err("%s failed to copy args", __func__);
+				ret = -EINVAL;
+			}
+		}
+		dxgadapter_release_lock_shared(adapter);
+	}
+
+cleanup:
+	if (args)
+		vfree(args);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgkp_enum_adapters(struct dxgprocess *process,
 		    union d3dkmt_enumadapters_filter filter,
@@ -3401,6 +3461,43 @@ dxgk_update_alloc_property(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_mark_device_as_error(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_markdeviceaserror args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	pr_debug("ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	device->execution_state = _D3DKMT_DEVICEEXECUTION_RESET;
+	ret = dxgvmb_send_mark_device_as_error(process, adapter, &args);
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_query_alloc_residency(struct dxgprocess *process, void *__user inargs)
 {
@@ -3560,6 +3657,54 @@ dxgk_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_query_clock_calibration(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryclockcalibration args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	bool adapter_locked = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	adapter_locked = true;
+
+	args.adapter = adapter->host_handle;
+	ret = dxgvmb_send_query_clock_calibration(process, adapter,
+						  &args, inargs);
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy output args", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	return ret;
+}
+
 static int
 dxgk_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 {
@@ -3607,6 +3752,46 @@ dxgk_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_escape(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_escape args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	bool adapter_locked = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	adapter_locked = true;
+
+	args.adapter = adapter->host_handle;
+	ret = dxgvmb_send_escape(process, adapter, &args);
+
+cleanup:
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_query_vidmem_info(struct dxgprocess *process, void *__user inargs)
 {
@@ -4507,6 +4692,8 @@ void init_ioctls(void)
 		  LX_DXQUERYADAPTERINFO);
 	SET_IOCTL(/*0xa */ dxgk_query_vidmem_info,
 		  LX_DXQUERYVIDEOMEMORYINFO);
+	SET_IOCTL(/*0xd */ dxgk_escape,
+		  LX_DXESCAPE);
 	SET_IOCTL(/*0xe */ dxgk_get_device_state,
 		  LX_DXGETDEVICESTATE);
 	SET_IOCTL(/*0xf */ dxgk_submit_command,
@@ -4547,6 +4734,8 @@ void init_ioctls(void)
 		  LX_DXINVALIDATECACHE);
 	SET_IOCTL(/*0x25 */ dxgk_lock2,
 		  LX_DXLOCK2);
+	SET_IOCTL(/*0x26 */ dxgk_mark_device_as_error,
+		  LX_DXMARKDEVICEASERROR);
 	SET_IOCTL(/*0x28 */ dxgk_open_resource,
 		  LX_DXOPENRESOURCE);
 	SET_IOCTL(/*0x29 */ dxgk_open_sync_object,
@@ -4581,6 +4770,8 @@ void init_ioctls(void)
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU);
 	SET_IOCTL(/*0x3c */ dxgk_get_allocation_priority,
 		  LX_DXGETALLOCATIONPRIORITY);
+	SET_IOCTL(/*0x3d */ dxgk_query_clock_calibration,
+		  LX_DXQUERYCLOCKCALIBRATION);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
 	SET_IOCTL(/*0x3f */ dxgk_share_objects,
@@ -4591,6 +4782,8 @@ void init_ioctls(void)
 		  LX_DXQUERYRESOURCEINFOFROMNTHANDLE);
 	SET_IOCTL(/*0x42 */ dxgk_open_resource_nt,
 		  LX_DXOPENRESOURCEFROMNTHANDLE);
+	SET_IOCTL(/*0x43 */ dxgk_query_statistics,
+		  LX_DXQUERYSTATISTICS);
 	SET_IOCTL(/*0x44 */ dxgk_share_object_with_host,
 		  LX_DXSHAREOBJECTWITHHOST);
 }
-- 
2.35.1

