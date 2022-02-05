Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655FF4AA5E3
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379132AbiBECes (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:48 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45156 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379031AbiBECe1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:27 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5C33420B876A;
        Fri,  4 Feb 2022 18:34:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C33420B876A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028467;
        bh=eDbYbBvNHVyaqdTAIrUnMr41QRli6VRpvJQ+JXeSjyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=akc2WSDNEyr9QRwprFRiVIZbPVA17oed+kAIzsku/GnxtOs9RvpZJCurm1E1/sIZx
         mzGapU7MOADPcYuGLORCw0MLednI6BZWA8PUP6eW9M0e7tIZphnoQSR9EFg179vGfG
         a4ytO1GRpm1o+SUNm10Rz2TEeGuKfwyomnH9zLTs=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 23/24] drivers: hv: dxgkrnl: IOCTLs to handle GPU virtual addressing (GPU VA)
Date:   Fri,  4 Feb 2022 18:34:21 -0800
Message-Id: <4d66df0e8d589163add6afbc40be340b7740df8d.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

LX_DXRESERVEGPUVIRTUALADDRESS(D3DKMTReserveGpuVertualAddress)
LX_DXFREEGPUVIRTUALADDRESS(D3DKMTFreeGpuVertualAddress)
LX_DXMAPGPUVIRTUALADDRESS(D3DKMTMapGpuVertualAddress)
LX_DXUPDATEGPUVIRTUALADDRESS(D3DKMTUpdateGpuVertualAddress)

WDDM supports accessing GPU memory by using GPU VAs.
Each process has a dedicated GPU VA address space.
A GPU VA could be reserved, mapped to a GPU allocation, updated or
freed.
The video memory manager on the host updates GPU page tables for
the GPU virtual addresses.
The IOCTLs are simply forwarded to the host and return results to
the caller.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  10 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 150 ++++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 230 ++++++++++++++++++++++++++++++++++
 3 files changed, 390 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 70cb31654aac..4a2b4c7611ff 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -791,6 +791,16 @@ int dxgvmb_send_evict(struct dxgprocess *pr, struct dxgadapter *adapter,
 int dxgvmb_send_submit_command(struct dxgprocess *pr,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_submitcommand *args);
+int dxgvmb_send_map_gpu_va(struct dxgprocess *pr, struct d3dkmthandle h,
+			   struct dxgadapter *adapter,
+			   struct d3dddi_mapgpuvirtualaddress *args);
+int dxgvmb_send_reserve_gpu_va(struct dxgprocess *pr,
+			       struct dxgadapter *adapter,
+			       struct d3dddi_reservegpuvirtualaddress *args);
+int dxgvmb_send_free_gpu_va(struct dxgprocess *pr, struct dxgadapter *adapter,
+			    struct d3dkmt_freegpuvirtualaddress *args);
+int dxgvmb_send_update_gpu_va(struct dxgprocess *pr, struct dxgadapter *adapter,
+			      struct d3dkmt_updategpuvirtualaddress *args);
 int dxgvmb_send_create_sync_object(struct dxgprocess *pr,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_createsynchronizationobject2
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 4299127af863..7a4b17938f53 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2376,6 +2376,156 @@ int dxgvmb_send_submit_command(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_map_gpu_va(struct dxgprocess *process,
+			   struct d3dkmthandle device,
+			   struct dxgadapter *adapter,
+			   struct d3dddi_mapgpuvirtualaddress *args)
+{
+	struct dxgkvmb_command_mapgpuvirtualaddress *command;
+	struct dxgkvmb_command_mapgpuvirtualaddress_return result;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_MAPGPUVIRTUALADDRESS,
+				   process->host_handle);
+	command->args = *args;
+	command->device = device;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, &result,
+				   sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+	args->virtual_address = result.virtual_address;
+	args->paging_fence_value = result.paging_fence_value;
+	ret = ntstatus2int(result.status);
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_reserve_gpu_va(struct dxgprocess *process,
+			       struct dxgadapter *adapter,
+			       struct d3dddi_reservegpuvirtualaddress *args)
+{
+	struct dxgkvmb_command_reservegpuvirtualaddress *command;
+	struct dxgkvmb_command_reservegpuvirtualaddress_return result;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_RESERVEGPUVIRTUALADDRESS,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, &result,
+				   sizeof(result));
+	args->virtual_address = result.virtual_address;
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_free_gpu_va(struct dxgprocess *process,
+			    struct dxgadapter *adapter,
+			    struct d3dkmt_freegpuvirtualaddress *args)
+{
+	struct dxgkvmb_command_freegpuvirtualaddress *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_FREEGPUVIRTUALADDRESS,
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
+int dxgvmb_send_update_gpu_va(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dkmt_updategpuvirtualaddress *args)
+{
+	struct dxgkvmb_command_updategpuvirtualaddress *command;
+	u32 cmd_size;
+	u32 op_size;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->num_operations == 0 ||
+	    (DXG_MAX_VM_BUS_PACKET_SIZE /
+	     sizeof(struct d3dddi_updategpuvirtualaddress_operation)) <
+	    args->num_operations) {
+		ret = -EINVAL;
+		pr_err("Invalid number of operations: %d",
+			   args->num_operations);
+		goto cleanup;
+	}
+
+	op_size = args->num_operations *
+	    sizeof(struct d3dddi_updategpuvirtualaddress_operation);
+	cmd_size = sizeof(struct dxgkvmb_command_updategpuvirtualaddress) +
+	    op_size - sizeof(args->operations[0]);
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_UPDATEGPUVIRTUALADDRESS,
+				   process->host_handle);
+	command->fence_value = args->fence_value;
+	command->device = args->device;
+	command->context = args->context;
+	command->fence_object = args->fence_object;
+	command->num_operations = args->num_operations;
+	command->flags = args->flags.value;
+	ret = copy_from_user(command->operations, args->operations,
+			     op_size);
+	if (ret) {
+		pr_err("%s failed to copy operations", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
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
 static void set_result(struct d3dkmt_createsynchronizationobject2 *args,
 		       u64 fence_gpu_va, u8 *va)
 {
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 317a4f2938d1..26bdcdfeba86 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -2549,6 +2549,228 @@ dxgk_submit_wait_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_map_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret, ret2;
+	struct d3dddi_mapgpuvirtualaddress args;
+	struct d3dddi_mapgpuvirtualaddress *input = inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	pr_debug("ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+					HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+					args.paging_queue);
+	if (device == NULL) {
+		ret = -EINVAL;
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
+	ret = dxgvmb_send_map_gpu_va(process, zerohandle, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+	/* STATUS_PENING is a success code > 0. It is returned to user mode */
+	if (!(ret == STATUS_PENDING || ret == 0)) {
+		pr_err("%s Unexpected error %x", __func__, ret);
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->paging_fence_value,
+			    &args.paging_fence_value, sizeof(u64));
+	if (ret2) {
+		pr_err("%s failed to copy paging fence to user", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->virtual_address, &args.virtual_address,
+				sizeof(args.virtual_address));
+	if (ret2) {
+		pr_err("%s failed to copy va to user", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_reserve_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dddi_reservegpuvirtualaddress args;
+	struct d3dddi_reservegpuvirtualaddress *input = inargs;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+
+	pr_debug("ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		device = dxgprocess_device_by_object_handle(process,
+						HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+						args.adapter);
+		if (device == NULL) {
+			pr_err("invalid adapter or paging queue: 0x%x",
+				   args.adapter.v);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		adapter = device->adapter;
+		kref_get(&adapter->adapter_kref);
+		kref_put(&device->device_kref, dxgdevice_release);
+	} else {
+		args.adapter = adapter->host_handle;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_reserve_gpu_va(process, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&input->virtual_address, &args.virtual_address,
+			   sizeof(args.virtual_address));
+	if (ret) {
+		pr_err("%s failed to copy VA to user", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (adapter) {
+		dxgadapter_release_lock_shared(adapter);
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	}
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_free_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_freegpuvirtualaddress args;
+	struct dxgadapter *adapter = NULL;
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
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	args.adapter = adapter->host_handle;
+	ret = dxgvmb_send_free_gpu_va(process, adapter, &args);
+
+cleanup:
+
+	if (adapter) {
+		dxgadapter_release_lock_shared(adapter);
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	}
+
+	return ret;
+}
+
+static int
+dxgk_update_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_updategpuvirtualaddress args;
+	struct d3dkmt_updategpuvirtualaddress *input = inargs;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
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
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_update_gpu_va(process, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&input->fence_value, &args.fence_value,
+			   sizeof(args.fence_value));
+	if (ret) {
+		pr_err("%s failed to copy fence value to user", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
 static int
 dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
 {
@@ -5108,12 +5330,16 @@ void init_ioctls(void)
 		  LX_DXCREATEALLOCATION);
 	SET_IOCTL(/*0x7 */ dxgk_create_paging_queue,
 		  LX_DXCREATEPAGINGQUEUE);
+	SET_IOCTL(/*0x8 */ dxgk_reserve_gpu_va,
+		  LX_DXRESERVEGPUVIRTUALADDRESS);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
 	SET_IOCTL(/*0xa */ dxgk_query_vidmem_info,
 		  LX_DXQUERYVIDEOMEMORYINFO);
 	SET_IOCTL(/*0xb */ dxgk_make_resident,
 		  LX_DXMAKERESIDENT);
+	SET_IOCTL(/*0xc */ dxgk_map_gpu_va,
+		  LX_DXMAPGPUVIRTUALADDRESS);
 	SET_IOCTL(/*0xd */ dxgk_escape,
 		  LX_DXESCAPE);
 	SET_IOCTL(/*0xe */ dxgk_get_device_state,
@@ -5152,6 +5378,8 @@ void init_ioctls(void)
 		  LX_DXEVICT);
 	SET_IOCTL(/*0x1f */ dxgk_flush_heap_transitions,
 		  LX_DXFLUSHHEAPTRANSITIONS);
+	SET_IOCTL(/*0x20 */ dxgk_free_gpu_va,
+		  LX_DXFREEGPUVIRTUALADDRESS);
 	SET_IOCTL(/*0x21 */ dxgk_get_context_process_scheduling_priority,
 		  LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY);
 	SET_IOCTL(/*0x22 */ dxgk_get_context_scheduling_priority,
@@ -5200,6 +5428,8 @@ void init_ioctls(void)
 		  LX_DXUNLOCK2);
 	SET_IOCTL(/*0x38 */ dxgk_update_alloc_property,
 		  LX_DXUPDATEALLOCPROPERTY);
+	SET_IOCTL(/*0x39 */ dxgk_update_gpu_va,
+		  LX_DXUPDATEGPUVIRTUALADDRESS);
 	SET_IOCTL(/*0x3a */ dxgk_wait_sync_object_cpu,
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x3b */ dxgk_wait_sync_object_gpu,
-- 
2.35.1

