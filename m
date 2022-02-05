Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BA54AA5E8
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379122AbiBECep (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:45 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45148 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379026AbiBECe1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:27 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id D1E4420B8766;
        Fri,  4 Feb 2022 18:34:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1E4420B8766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028466;
        bh=REg1wzAgsHnIu7eVFzviONLszSqaQDbxJ41Fb0yEQf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ik9xm+LIvlq8njg36bYHYWT750B3+QPEV5WoRaNxowJhOlb8xZdqJqSJzkzucLyiH
         jYjswF0oOG9uqx5W2N8j+AvwoOLLgqIRWBwTWRxorkxvUlnFB38z0jtlGAWcEfv8r8
         QB/28Tqe9Y+YJ0B/cXXC2cByK7jrBPUh3sLCk/94=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 20/24] drivers: hv: dxgkrnl: IOCTLs to offer and reclaim allocations
Date:   Fri,  4 Feb 2022 18:34:18 -0800
Message-Id: <874915869e5d0e1fb3446bfdfab25ab94599dfd8.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

LX_DXOFFERALLOCATIONS {D3DKMTOfferAllocations),
LX_DXRECLAIMALLOCATIONS2 (D3DKMTReclaimAllocations)

When a user mode driver does not need to access an allocation, it can
"offer" it. This means that the allocation is not in use and it local
device memory could be reclaimed and given to another allocation.
When the allocation is again needed, the UMD can attempt to"reclaim" the
allocation. If the allocation is still in the device local memory,
the reclaim operation succeeds. If not the called must restore the content
of the allocation before it can be used by the device.
The IOCTLs are implemented by sending messages to the host and returning
results back to the caller.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   8 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 122 ++++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 119 +++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 8310dd9b7843..52d7d74a93e4 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -839,6 +839,14 @@ int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 					struct dxgadapter *adapter,
 					struct d3dkmt_getallocationpriority *a);
+int dxgvmb_send_offer_allocations(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_offerallocations *args);
+int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
+				    struct dxgadapter *adapter,
+				    struct d3dkmthandle device,
+				    struct d3dkmt_reclaimallocations2 *args,
+				    u64 __user *paging_fence_value);
 int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
 					  struct dxgadapter *adapter,
 					  struct d3dkmthandle other_process,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index f7fcbf62f95b..84034c4fafe2 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2889,6 +2889,128 @@ int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_offer_allocations(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_offerallocations *args)
+{
+	struct dxgkvmb_command_offerallocations *command;
+	int ret = -EINVAL;
+	u32 alloc_size = sizeof(struct d3dkmthandle) * args->allocation_count;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_offerallocations) +
+			alloc_size - sizeof(struct d3dkmthandle);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_OFFERALLOCATIONS,
+				   process->host_handle);
+	command->flags = args->flags;
+	command->priority = args->priority;
+	command->device = args->device;
+	command->allocation_count = args->allocation_count;
+	if (args->resources) {
+		command->resources = true;
+		ret = copy_from_user(command->allocations, args->resources,
+				     alloc_size);
+	} else {
+		ret = copy_from_user(command->allocations,
+				     args->allocations, alloc_size);
+	}
+	if (ret) {
+		pr_err("%s failed to copy input handles", __func__);
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
+int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
+				    struct dxgadapter *adapter,
+				    struct d3dkmthandle device,
+				    struct d3dkmt_reclaimallocations2 *args,
+				    u64  __user *paging_fence_value)
+{
+	struct dxgkvmb_command_reclaimallocations *command;
+	struct dxgkvmb_command_reclaimallocations_return *result;
+	int ret;
+	u32 alloc_size = sizeof(struct d3dkmthandle) * args->allocation_count;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_reclaimallocations) +
+	    alloc_size - sizeof(struct d3dkmthandle);
+	u32 result_size = sizeof(*result);
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	if (args->results)
+		result_size += (args->allocation_count - 1) *
+				sizeof(enum d3dddi_reclaim_result);
+
+	ret = init_message_res(&msg, adapter, process, cmd_size, result_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_RECLAIMALLOCATIONS,
+				   process->host_handle);
+	command->device = device;
+	command->paging_queue = args->paging_queue;
+	command->allocation_count = args->allocation_count;
+	command->write_results = args->results != NULL;
+	if (args->resources) {
+		command->resources = true;
+		ret = copy_from_user(command->allocations, args->resources,
+					 alloc_size);
+	} else {
+		ret = copy_from_user(command->allocations,
+					 args->allocations, alloc_size);
+	}
+	if (ret) {
+		pr_err("%s failed to copy input handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(paging_fence_value,
+			   &result->paging_fence_value, sizeof(u64));
+	if (ret) {
+		pr_err("%s failed to copy paging fence", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = ntstatus2int(result->status);
+	if (NT_SUCCESS(result->status) && args->results) {
+		ret = copy_to_user(args->results, result->discarded,
+				   sizeof(result->discarded[0]) *
+				   args->allocation_count);
+		if (ret) {
+			pr_err("%s failed to copy results", __func__);
+			ret = -EINVAL;
+		}
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
 					  struct dxgadapter *adapter,
 					  struct d3dkmthandle other_process,
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 6c9b6e6ea296..3370e5de4314 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -2010,6 +2010,121 @@ dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_offer_allocations(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_offerallocations args;
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
+	if (args.allocation_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.allocation_count == 0) {
+		pr_err("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if ((args.resources == NULL) == (args.allocations == NULL)) {
+		pr_err("invalid pointer to resources/allocations");
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
+	ret = dxgvmb_send_offer_allocations(process, adapter, &args);
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
+dxgk_reclaim_allocations(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_reclaimallocations2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmt_reclaimallocations2 * __user in_args = inargs;
+
+	pr_debug("ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.allocation_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.allocation_count == 0) {
+		pr_err("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if ((args.resources == NULL) == (args.allocations == NULL)) {
+		pr_err("invalid pointer to resources/allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+						args.paging_queue);
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
+	ret = dxgvmb_send_reclaim_allocations(process, adapter,
+					      device->handle, &args,
+					      &in_args->paging_fence_value);
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
 static int
 dxgk_submit_command(struct dxgprocess *process, void *__user inargs)
 {
@@ -4736,6 +4851,8 @@ void init_ioctls(void)
 		  LX_DXLOCK2);
 	SET_IOCTL(/*0x26 */ dxgk_mark_device_as_error,
 		  LX_DXMARKDEVICEASERROR);
+	SET_IOCTL(/*0x27 */ dxgk_offer_allocations,
+		  LX_DXOFFERALLOCATIONS);
 	SET_IOCTL(/*0x28 */ dxgk_open_resource,
 		  LX_DXOPENRESOURCE);
 	SET_IOCTL(/*0x29 */ dxgk_open_sync_object,
@@ -4744,6 +4861,8 @@ void init_ioctls(void)
 		  LX_DXQUERYALLOCATIONRESIDENCY);
 	SET_IOCTL(/*0x2b */ dxgk_query_resource_info,
 		  LX_DXQUERYRESOURCEINFO);
+	SET_IOCTL(/*0x2c */ dxgk_reclaim_allocations,
+		  LX_DXRECLAIMALLOCATIONS2);
 	SET_IOCTL(/*0x2d */ dxgk_render,
 		  LX_DXRENDER);
 	SET_IOCTL(/*0x2e */ dxgk_set_allocation_priority,
-- 
2.35.1

