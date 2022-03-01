Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516DF4C94DA
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbiCATrd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiCATr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A45596CA71;
        Tue,  1 Mar 2022 11:46:37 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7B23320B4785;
        Tue,  1 Mar 2022 11:46:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B23320B4785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163995;
        bh=3q37QE9uLk5aH5O0jebpeRoouE0cPRg+eKJo7IaGKyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1PXEEfoLOuz/W67MMsn9N5fHB4/TZ45K1R6nim/bvqJzlYJoQQHhYbQ0ZRvwSRA/
         AOGYaK624AcfmOvD5eFdUWf6Yn05mL8/eqxbG97UzHEERFvG3d2+Hzj9QRpH3gBM32
         SL71XDv0e+a4P2vPb73wKAgb95iSyD21sOaqnw0k=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 29/30] drivers: hv: dxgkrnl: Manage compute device virtual addresses
Date:   Tue,  1 Mar 2022 11:46:16 -0800
Message-Id: <3f92b96558243d06a07e8a4a094928c54f5cb5b2.1646163379.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement ioctls to manage compute device virtual addresses (VA):
  - LX_DXRESERVEGPUVIRTUALADDRESS,
  - LX_DXFREEGPUVIRTUALADDRESS,
  - LX_DXMAPGPUVIRTUALADDRESS,
  - LX_DXUPDATEGPUVIRTUALADDRESS.

Compute devices access memory by using virtual addressses.
Each process has a dedicated VA space. The video memory manager
on the host is responsible with updating device page tables
before submitting a DMA buffer for execution.

The LX_DXRESERVEGPUVIRTUALADDRESS ioctl reserves a portion of the
process compute device VA space.

The LX_DXMAPGPUVIRTUALADDRESS ioctl reserves a portion of the process
compute device VA space and maps it to the given compute device
allocation.

The LX_DXFREEGPUVIRTUALADDRESS frees the previously reserved portion
of the compute device VA space.

The LX_DXUPDATEGPUVIRTUALADDRESS ioctl adds operations to modify the
compute device VA space to a compute device execution context. It
allows the operations to be queued and synchronized with execution
of other compute device DMA buffers..

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  10 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 150 ++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  38 ++++++
 drivers/hv/dxgkrnl/ioctl.c    | 230 ++++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  | 126 +++++++++++++++++++
 5 files changed, 554 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index c841203a1683..de6333fdada6 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -797,6 +797,16 @@ int dxgvmb_send_evict(struct dxgprocess *pr, struct dxgadapter *adapter,
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
index 9f5b8edb186e..49c36d86c9bf 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2414,6 +2414,156 @@ int dxgvmb_send_submit_command(struct dxgprocess *process,
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
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 59357bd5c7b9..3eda60da013d 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -418,6 +418,44 @@ struct dxgkvmb_command_flushheaptransitions {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 };
 
+struct dxgkvmb_command_freegpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_freegpuvirtualaddress args;
+};
+
+struct dxgkvmb_command_mapgpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dddi_mapgpuvirtualaddress args;
+	struct d3dkmthandle		device;
+};
+
+struct dxgkvmb_command_mapgpuvirtualaddress_return {
+	u64		virtual_address;
+	u64		paging_fence_value;
+	struct ntstatus	status;
+};
+
+struct dxgkvmb_command_reservegpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dddi_reservegpuvirtualaddress args;
+};
+
+struct dxgkvmb_command_reservegpuvirtualaddress_return {
+	u64	virtual_address;
+	u64	paging_fence_value;
+};
+
+struct dxgkvmb_command_updategpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	u64				fence_value;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		context;
+	struct d3dkmthandle		fence_object;
+	u32				num_operations;
+	u32				flags;
+	struct d3dddi_updategpuvirtualaddress_operation operations[1];
+};
+
 struct dxgkvmb_command_queryclockcalibration {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_queryclockcalibration args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index a90c1a897d55..b2fd3d55d72a 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -2535,6 +2535,228 @@ dxgk_submit_wait_to_hwqueue(struct dxgprocess *process, void *__user inargs)
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
@@ -5042,12 +5264,16 @@ void init_ioctls(void)
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
@@ -5082,6 +5308,8 @@ void init_ioctls(void)
 		  LX_DXEVICT);
 	SET_IOCTL(/*0x1f */ dxgk_flush_heap_transitions,
 		  LX_DXFLUSHHEAPTRANSITIONS);
+	SET_IOCTL(/*0x20 */ dxgk_free_gpu_va,
+		  LX_DXFREEGPUVIRTUALADDRESS);
 	SET_IOCTL(/*0x21 */ dxgk_get_context_process_scheduling_priority,
 		  LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY);
 	SET_IOCTL(/*0x22 */ dxgk_get_context_scheduling_priority,
@@ -5118,6 +5346,8 @@ void init_ioctls(void)
 		  LX_DXUNLOCK2);
 	SET_IOCTL(/*0x38 */ dxgk_update_alloc_property,
 		  LX_DXUPDATEALLOCPROPERTY);
+	SET_IOCTL(/*0x39 */ dxgk_update_gpu_va,
+		  LX_DXUPDATEGPUVIRTUALADDRESS);
 	SET_IOCTL(/*0x3a */ dxgk_wait_sync_object_cpu,
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x3b */ dxgk_wait_sync_object_gpu,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 95d6df5f01b5..4c83b934816f 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -1008,6 +1008,124 @@ struct d3dkmt_evict {
 	__u64				num_bytes_to_trim;
 };
 
+struct d3dddigpuva_protection_type {
+	union {
+		struct {
+			__u64	write:1;
+			__u64	execute:1;
+			__u64	zero:1;
+			__u64	no_access:1;
+			__u64	system_use_only:1;
+			__u64	reserved:59;
+		};
+		__u64		value;
+	};
+};
+
+enum d3dddi_updategpuvirtualaddress_operation_type {
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_MAP		= 0,
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_UNMAP		= 1,
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_COPY		= 2,
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_MAP_PROTECT	= 3,
+};
+
+struct d3dddi_updategpuvirtualaddress_operation {
+	enum d3dddi_updategpuvirtualaddress_operation_type operation;
+	union {
+		struct {
+			__u64		base_address;
+			__u64		size;
+			struct d3dkmthandle allocation;
+			__u64		allocation_offset;
+			__u64		allocation_size;
+		} map;
+		struct {
+			__u64		base_address;
+			__u64		size;
+			struct d3dkmthandle allocation;
+			__u64		allocation_offset;
+			__u64		allocation_size;
+			struct d3dddigpuva_protection_type protection;
+			__u64		driver_protection;
+		} map_protect;
+		struct {
+			__u64	base_address;
+			__u64	size;
+			struct d3dddigpuva_protection_type protection;
+		} unmap;
+		struct {
+			__u64	source_address;
+			__u64	size;
+			__u64	dest_address;
+		} copy;
+	};
+};
+
+enum d3dddigpuva_reservation_type {
+	_D3DDDIGPUVA_RESERVE_NO_ACCESS		= 0,
+	_D3DDDIGPUVA_RESERVE_ZERO		= 1,
+	_D3DDDIGPUVA_RESERVE_NO_COMMIT		= 2
+};
+
+struct d3dkmt_updategpuvirtualaddress {
+	struct d3dkmthandle			device;
+	struct d3dkmthandle			context;
+	struct d3dkmthandle			fence_object;
+	__u32					num_operations;
+#ifdef __KERNEL__
+	struct d3dddi_updategpuvirtualaddress_operation *operations;
+#else
+	__u64					operations;
+#endif
+	__u32					reserved0;
+	__u32					reserved1;
+	__u64					reserved2;
+	__u64					fence_value;
+	union {
+		struct {
+			__u32			do_not_wait:1;
+			__u32			reserved:31;
+		};
+		__u32				value;
+	} flags;
+	__u32					reserved3;
+};
+
+struct d3dddi_mapgpuvirtualaddress {
+	struct d3dkmthandle			paging_queue;
+	__u64					base_address;
+	__u64					minimum_address;
+	__u64					maximum_address;
+	struct d3dkmthandle			allocation;
+	__u64					offset_in_pages;
+	__u64					size_in_pages;
+	struct d3dddigpuva_protection_type	protection;
+	__u64					driver_protection;
+	__u32					reserved0;
+	__u64					reserved1;
+	__u64					virtual_address;
+	__u64					paging_fence_value;
+};
+
+struct d3dddi_reservegpuvirtualaddress {
+	struct d3dkmthandle			adapter;
+	__u64					base_address;
+	__u64					minimum_address;
+	__u64					maximum_address;
+	__u64					size;
+	enum d3dddigpuva_reservation_type	reservation_type;
+	__u64					driver_protection;
+	__u64					virtual_address;
+	__u64					paging_fence_value;
+};
+
+struct d3dkmt_freegpuvirtualaddress {
+	struct d3dkmthandle	adapter;
+	__u32			reserved;
+	__u64			base_address;
+	__u64			size;
+};
+
 enum d3dkmt_memory_segment_group {
 	_D3DKMT_MEMORY_SEGMENT_GROUP_LOCAL	= 0,
 	_D3DKMT_MEMORY_SEGMENT_GROUP_NON_LOCAL	= 1
@@ -1449,12 +1567,16 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x06, struct d3dkmt_createallocation)
 #define LX_DXCREATEPAGINGQUEUE		\
 	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
+#define LX_DXRESERVEGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x08, struct d3dddi_reservegpuvirtualaddress)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXQUERYVIDEOMEMORYINFO	\
 	_IOWR(0x47, 0x0a, struct d3dkmt_queryvideomemoryinfo)
 #define LX_DXMAKERESIDENT		\
 	_IOWR(0x47, 0x0b, struct d3dddi_makeresident)
+#define LX_DXMAPGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x0c, struct d3dddi_mapgpuvirtualaddress)
 #define LX_DXESCAPE			\
 	_IOWR(0x47, 0x0d, struct d3dkmt_escape)
 #define LX_DXGETDEVICESTATE		\
@@ -1489,6 +1611,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x1e, struct d3dkmt_evict)
 #define LX_DXFLUSHHEAPTRANSITIONS	\
 	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
+#define LX_DXFREEGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x20, struct d3dkmt_freegpuvirtualaddress)
 #define LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY \
 	_IOWR(0x47, 0x21, struct d3dkmt_getcontextinprocessschedulingpriority)
 #define LX_DXGETCONTEXTSCHEDULINGPRIORITY \
@@ -1525,6 +1649,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x37, struct d3dkmt_unlock2)
 #define LX_DXUPDATEALLOCPROPERTY	\
 	_IOWR(0x47, 0x38, struct d3dddi_updateallocproperty)
+#define LX_DXUPDATEGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x39, struct d3dkmt_updategpuvirtualaddress)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x3a, struct d3dkmt_waitforsynchronizationobjectfromcpu)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU \
-- 
2.35.1

