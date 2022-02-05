Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FD84AA5D9
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379032AbiBECeq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45154 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379029AbiBECe1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:27 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3138420B8769;
        Fri,  4 Feb 2022 18:34:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3138420B8769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028467;
        bh=99UP3cnEF3/f5M3gd4wk5ndz7/g7hC8jubu6pPc0/Yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8fJrQKGNa/9u4HpN0cNXOfRfLALWyn5vJy8avTEouOejKLZWVfgx/SuOZjfkEF/r
         D+gm6sfD1g/yjpj/uL12etV41fW8Tr9PW9Stl4f5f0thtt0cgUSoJgIEXKF50xtDgE
         YZCwNxdlRzjFphgJfeyAllVRKOHdZhSc5z2Y3Ch4=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 22/24] drivers: hv: dxgkrnl: IOCTLs to manage allocation residency
Date:   Fri,  4 Feb 2022 18:34:20 -0800
Message-Id: <32cf9cd4bd2dbb766d45dd50de983a71c78dca33.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

LX_DXMAKERESIDENT (D3DKMTMakeResident)
LX_DXEVICT (D3DKMTEvict)

An allocation is resident when GPU is setup to access it. The current
WDDM design does not support on demand GPU page faulting. An
allocation must be resident (be in the local device memory or
in non-pageable system memory) before GPU is allowed to access it.
Applications need to call D3DKMTMAkeResident to make an allocation
resident and D3DKMTEvict to evict it from GPU accessible memory.
The IOCTLs send the requests to the host and return the result back.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   4 +
 drivers/hv/dxgkrnl/dxgvmbus.c |  98 +++++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 144 ++++++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index eebb9cee39c3..70cb31654aac 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -784,6 +784,10 @@ int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 int dxgvmb_send_destroy_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 				   struct d3dkmt_destroyallocation2 *args,
 				   struct d3dkmthandle *alloc_handles);
+int dxgvmb_send_make_resident(struct dxgprocess *pr, struct dxgadapter *adapter,
+			      struct d3dddi_makeresident *args);
+int dxgvmb_send_evict(struct dxgprocess *pr, struct dxgadapter *adapter,
+		      struct d3dkmt_evict *args);
 int dxgvmb_send_submit_command(struct dxgprocess *pr,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_submitcommand *args);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 2b64d53685a0..4299127af863 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2224,6 +2224,104 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 	return ret;
 }
 
+int dxgvmb_send_make_resident(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dddi_makeresident *args)
+{
+	int ret;
+	u32 cmd_size;
+	struct dxgkvmb_command_makeresident_return result = { };
+	struct dxgkvmb_command_makeresident *command = NULL;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	cmd_size = (args->alloc_count - 1) * sizeof(struct d3dkmthandle) +
+		   sizeof(struct dxgkvmb_command_makeresident);
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	ret = copy_from_user(command->allocations, args->allocation_list,
+			     args->alloc_count *
+			     sizeof(struct d3dkmthandle));
+	if (ret) {
+		pr_err("%s failed to copy alloc handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_MAKERESIDENT,
+				   process->host_handle);
+	command->alloc_count = args->alloc_count;
+	command->paging_queue = args->paging_queue;
+	command->flags = args->flags;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0) {
+		pr_err("send_make_resident failed %x", ret);
+		goto cleanup;
+	}
+
+	args->paging_fence_value = result.paging_fence_value;
+	args->num_bytes_to_trim = result.num_bytes_to_trim;
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
+int dxgvmb_send_evict(struct dxgprocess *process,
+		      struct dxgadapter *adapter,
+		      struct d3dkmt_evict *args)
+{
+	int ret;
+	u32 cmd_size;
+	struct dxgkvmb_command_evict_return result = { };
+	struct dxgkvmb_command_evict *command = NULL;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	cmd_size = (args->alloc_count - 1) * sizeof(struct d3dkmthandle) +
+	    sizeof(struct dxgkvmb_command_evict);
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	ret = copy_from_user(command->allocations, args->allocations,
+			     args->alloc_count *
+			     sizeof(struct d3dkmthandle));
+	if (ret) {
+		pr_err("%s failed to copy alloc handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_EVICT, process->host_handle);
+	command->alloc_count = args->alloc_count;
+	command->device = args->device;
+	command->flags = args->flags;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0) {
+		pr_err("send_evict failed %x", ret);
+		goto cleanup;
+	}
+	args->num_bytes_to_trim = result.num_bytes_to_trim;
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_submit_command(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_submitcommand *args)
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 61bdc9a91903..317a4f2938d1 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -2010,6 +2010,146 @@ dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_make_resident(struct dxgprocess *process, void *__user inargs)
+{
+	int ret, ret2;
+	struct d3dddi_makeresident args;
+	struct d3dddi_makeresident *input = inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	pr_debug("ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.alloc_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.alloc_count == 0) {
+		pr_err("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (args.paging_queue.v == 0) {
+		pr_err("paging queue is missing");
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
+	ret = dxgvmb_send_make_resident(process, adapter, &args);
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
+		pr_err("%s failed to copy paging fence", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->num_bytes_to_trim,
+			    &args.num_bytes_to_trim, sizeof(u64));
+	if (ret2) {
+		pr_err("%s failed to copy bytes to trim", __func__);
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
+
+	return ret;
+}
+
+static int
+dxgk_evict(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_evict args;
+	struct d3dkmt_evict *input = inargs;
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
+	if (args.alloc_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.alloc_count == 0) {
+		pr_err("invalid number of allocations");
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
+	ret = dxgvmb_send_evict(process, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&input->num_bytes_to_trim,
+			   &args.num_bytes_to_trim, sizeof(u64));
+	if (ret) {
+		pr_err("%s failed to copy bytes to trim to user", __func__);
+		ret = -EINVAL;
+	}
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
 dxgk_offer_allocations(struct dxgprocess *process, void *__user inargs)
 {
@@ -4972,6 +5112,8 @@ void init_ioctls(void)
 		  LX_DXQUERYADAPTERINFO);
 	SET_IOCTL(/*0xa */ dxgk_query_vidmem_info,
 		  LX_DXQUERYVIDEOMEMORYINFO);
+	SET_IOCTL(/*0xb */ dxgk_make_resident,
+		  LX_DXMAKERESIDENT);
 	SET_IOCTL(/*0xd */ dxgk_escape,
 		  LX_DXESCAPE);
 	SET_IOCTL(/*0xe */ dxgk_get_device_state,
@@ -5006,6 +5148,8 @@ void init_ioctls(void)
 		  LX_DXDESTROYPAGINGQUEUE);
 	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x1e */ dxgk_evict,
+		  LX_DXEVICT);
 	SET_IOCTL(/*0x1f */ dxgk_flush_heap_transitions,
 		  LX_DXFLUSHHEAPTRANSITIONS);
 	SET_IOCTL(/*0x21 */ dxgk_get_context_process_scheduling_priority,
-- 
2.35.1

