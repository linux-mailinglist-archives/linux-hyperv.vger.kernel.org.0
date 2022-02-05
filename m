Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ACC4AA5DB
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379099AbiBECem (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:42 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45108 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379019AbiBECe0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:26 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2C16120B8760;
        Fri,  4 Feb 2022 18:34:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C16120B8760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028466;
        bh=LHFlARVfrvYGBVgoaLmkeoVY7a4xLhgT894jLDs/UwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ReV1Mzh5MpRMoF23uaCSXE/x330Bjlzo59CZclBTSeCGm4xG9OICrG59jD09NRdGQ
         9stM500e2wVqPPSYXwjMqr5bnCIrzJPos7riO8RJ4jMGookS0QR+dH1NtxF+8is2/1
         yiEG5xX9k66zEe/SVEYp7YNLj7dZp+VQBn9NutbI=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 16/24] drivers: hv: dxgkrnl: Mmap(unmap) CPU address to device allocation: LX_DXLOCK2, LX_DXUNLOCK2
Date:   Fri,  4 Feb 2022 18:34:14 -0800
Message-Id: <6f9cd2927847c32e3fe7fa45290e9c9d40787758.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

- LX_DXLOCK2(D3DKMTLock2) maps a CPU virtual address to a compute
  device allocation. The allocation could be located in system
  memory or local device memory.
  When the device allocation is created from the guest system memory
  (existing sysmem allocation), the allocation CPU address is known
  and is returned to the caller.
  For other CPU visible allocations the code flow is the following:
  1. A VM bus message is sent to the host
  2. The host allocates a portion of the guest IO space and maps it
     to the allocation backing store. The IO space address is returned
     back to the guest.
  3. The guest allocates a CPU virtual address and maps it to the IO
     space (dxg_map_iospace).
  4. The CPU VA is returned back to the caller
  cpu_address_mapped and cpu_address_refcount are used to track how
  many times an allocation was mapped.

- LX_DXUNLOCK2(D3DKMTUnlock2) unmaps a CPU virtual address from
  a compute device allocation.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  11 +++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  14 +++
 drivers/hv/dxgkrnl/dxgvmbus.c   | 107 +++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c      | 161 ++++++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index f4e1d402fdbe..e28f5d3e4210 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -885,6 +885,15 @@ void dxgallocation_stop(struct dxgallocation *alloc)
 		vfree(alloc->pages);
 		alloc->pages = NULL;
 	}
+	dxgprocess_ht_lock_exclusive_down(alloc->process);
+	if (alloc->cpu_address_mapped) {
+		dxg_unmap_iospace(alloc->cpu_address,
+				  alloc->num_pages << PAGE_SHIFT);
+		alloc->cpu_address_mapped = false;
+		alloc->cpu_address = NULL;
+		alloc->cpu_address_refcount = 0;
+	}
+	dxgprocess_ht_lock_exclusive_up(alloc->process);
 }
 
 void dxgallocation_free_handle(struct dxgallocation *alloc)
@@ -926,6 +935,8 @@ void dxgallocation_destroy(struct dxgallocation *alloc)
 	}
 	if (alloc->priv_drv_data)
 		vfree(alloc->priv_drv_data);
+	if (alloc->cpu_address_mapped)
+		pr_err("Alloc IO space is mapped: %p", alloc);
 	vfree(alloc);
 }
 
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 892c95a11368..fa46abf0350a 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -691,6 +691,8 @@ struct dxgallocation {
 	struct d3dkmthandle		alloc_handle;
 	/* Set to 1 when allocation belongs to resource. */
 	u32				resource_owner:1;
+	/* Set to 1 when 'cpu_address' is mapped to the IO space. */
+	u32				cpu_address_mapped:1;
 	/* Set to 1 when the allocatio is mapped as cached */
 	u32				cached:1;
 	u32				handle_valid:1;
@@ -698,6 +700,11 @@ struct dxgallocation {
 	struct vmbus_gpadl		gpadl;
 	/* Number of pages in the 'pages' array */
 	u32				num_pages;
+	/*
+	 * How many times dxgk_lock2 is called to allocation, which is mapped
+	 * to IO space.
+	 */
+	u32				cpu_address_refcount;
 	/*
 	 * CPU address from the existing sysmem allocation, or
 	 * mapped to the CPU visible backing store in the IO space
@@ -811,6 +818,13 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 				     d3dkmt_waitforsynchronizationobjectfromcpu
 				     *args,
 				     u64 cpu_event);
+int dxgvmb_send_lock2(struct dxgprocess *process,
+		      struct dxgadapter *adapter,
+		      struct d3dkmt_lock2 *args,
+		      struct d3dkmt_lock2 *__user outargs);
+int dxgvmb_send_unlock2(struct dxgprocess *process,
+			struct dxgadapter *adapter,
+			struct d3dkmt_unlock2 *args);
 int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_createhwqueue *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index b5225756ee6e..a064efa320cf 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2294,6 +2294,113 @@ int dxgvmb_send_wait_sync_object_gpu(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_lock2(struct dxgprocess *process,
+		      struct dxgadapter *adapter,
+		      struct d3dkmt_lock2 *args,
+		      struct d3dkmt_lock2 *__user outargs)
+{
+	int ret;
+	struct dxgkvmb_command_lock2 *command;
+	struct dxgkvmb_command_lock2_return result = { };
+	struct dxgallocation *alloc = NULL;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_LOCK2, process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result.status);
+	if (ret < 0)
+		goto cleanup;
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	alloc = hmgrtable_get_object_by_type(&process->handle_table,
+					     HMGRENTRY_TYPE_DXGALLOCATION,
+					     args->allocation);
+	if (alloc == NULL) {
+		pr_err("%s invalid alloc", __func__);
+		ret = -EINVAL;
+	} else {
+		if (alloc->cpu_address) {
+			args->data = alloc->cpu_address;
+			if (alloc->cpu_address_mapped)
+				alloc->cpu_address_refcount++;
+		} else {
+			u64 offset = (u64)result.cpu_visible_buffer_offset;
+
+			args->data = dxg_map_iospace(offset,
+					alloc->num_pages << PAGE_SHIFT,
+					PROT_READ | PROT_WRITE, alloc->cached);
+			if (args->data) {
+				alloc->cpu_address_refcount = 1;
+				alloc->cpu_address_mapped = true;
+				alloc->cpu_address = args->data;
+			}
+		}
+		if (args->data == NULL) {
+			ret = -ENOMEM;
+		} else {
+			ret = copy_to_user(&outargs->data, &args->data,
+					   sizeof(args->data));
+			if (ret) {
+				pr_err("%s failed to copy data", __func__);
+				ret = -EINVAL;
+				alloc->cpu_address_refcount--;
+				if (alloc->cpu_address_refcount == 0) {
+					dxg_unmap_iospace(alloc->cpu_address,
+					   alloc->num_pages << PAGE_SHIFT);
+					alloc->cpu_address_mapped = false;
+					alloc->cpu_address = NULL;
+				}
+			}
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_unlock2(struct dxgprocess *process,
+			struct dxgadapter *adapter,
+			struct d3dkmt_unlock2 *args)
+{
+	int ret;
+	struct dxgkvmb_command_unlock2 *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_UNLOCK2,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_createhwqueue *args,
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index bb6eab08898f..12a4593c6aa5 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3180,6 +3180,163 @@ dxgk_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_lock2(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_lock2 args;
+	struct d3dkmt_lock2 *__user result = inargs;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgallocation *alloc = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	args.data = NULL;
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	alloc = hmgrtable_get_object_by_type(&process->handle_table,
+					     HMGRENTRY_TYPE_DXGALLOCATION,
+					     args.allocation);
+	if (alloc == NULL) {
+		ret = -EINVAL;
+	} else {
+		if (alloc->cpu_address) {
+			ret = copy_to_user(&result->data,
+					   &alloc->cpu_address,
+					   sizeof(args.data));
+			if (ret == 0) {
+				args.data = alloc->cpu_address;
+				if (alloc->cpu_address_mapped)
+					alloc->cpu_address_refcount++;
+			} else {
+				pr_err("%s Failed to copy cpu address",
+					__func__);
+				ret = -EINVAL;
+			}
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (ret < 0)
+		goto cleanup;
+	if (args.data)
+		goto success;
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
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
+
+	ret = dxgvmb_send_lock2(process, adapter, &args, result);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+success:
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_unlock2(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_unlock2 args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgallocation *alloc = NULL;
+	bool done = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	alloc = hmgrtable_get_object_by_type(&process->handle_table,
+					     HMGRENTRY_TYPE_DXGALLOCATION,
+					     args.allocation);
+	if (alloc == NULL) {
+		ret = -EINVAL;
+	} else {
+		if (alloc->cpu_address == NULL) {
+			pr_err("Allocation is not locked: %p", alloc);
+			ret = -EINVAL;
+		} else if (alloc->cpu_address_mapped) {
+			if (alloc->cpu_address_refcount > 0) {
+				alloc->cpu_address_refcount--;
+				if (alloc->cpu_address_refcount != 0) {
+					done = true;
+				} else {
+					dxg_unmap_iospace(alloc->cpu_address,
+						alloc->num_pages << PAGE_SHIFT);
+					alloc->cpu_address_mapped = false;
+					alloc->cpu_address = NULL;
+				}
+			} else {
+				pr_err("Invalid cpu access refcount");
+				done = true;
+			}
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (done)
+		goto success;
+	if (ret < 0)
+		goto cleanup;
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
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
+
+	ret = dxgvmb_send_unlock2(process, adapter, &args);
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+success:
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_get_device_state(struct dxgprocess *process, void *__user inargs)
 {
@@ -4011,6 +4168,8 @@ void init_ioctls(void)
 		  LX_DXDESTROYPAGINGQUEUE);
 	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x25 */ dxgk_lock2,
+		  LX_DXLOCK2);
 	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x32 */ dxgk_signal_sync_object_gpu,
@@ -4023,6 +4182,8 @@ void init_ioctls(void)
 		  LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE);
 	SET_IOCTL(/*0x36 */ dxgk_submit_signal_to_hwqueue,
 		  LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE);
+	SET_IOCTL(/*0x37 */ dxgk_unlock2,
+		  LX_DXUNLOCK2);
 	SET_IOCTL(/*0x3a */ dxgk_wait_sync_object_cpu,
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x3b */ dxgk_wait_sync_object_gpu,
-- 
2.35.1

