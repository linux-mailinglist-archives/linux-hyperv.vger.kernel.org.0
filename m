Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF71B4AA5D8
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379114AbiBECeo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45146 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379022AbiBECe0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:26 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 807BD20B8763;
        Fri,  4 Feb 2022 18:34:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 807BD20B8763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028466;
        bh=kQh2dK88XuPow6y/yDSrqkhjm9kQ0UZOA4nLmOlKjd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AD7WHFhvcJEw494Fzf06puQ+jqNp0Yd8bM+DyOSsXSTFghZQfE6WsC1DPmTMDhBb8
         crUnYom5OdyWYdhEOaxRAtD/9690b9HBCnAx+OvVa9yV0xXx+B5m3vGEFymwONauXk
         R17fJ2pzEvup6JZ9fPhqjZYbGhdNai/HcL+T4HaM=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 18/24] drivers: hv: dxgkrnl: Various simple IOCTLs and unused ones LX_DXQUERYVIDEOMEMORYINFO, LX_DXFLUSHHEAPTRANSITIONS, LX_DXINVALIDATECACHE  LX_DXGETSHAREDRESOURCEADAPTERLUID
Date:   Fri,  4 Feb 2022 18:34:16 -0800
Message-Id: <8ec3cb5deb955dd377b264209f50c7d774365e7d.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Simple IOCTLs have the same implementation pattern:
- read data from input
- send a synchronous VM bus message to the host
- return result to the caller

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   8 ++
 drivers/hv/dxgkrnl/dxgvmbus.c |  87 ++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 181 ++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 128c5cd2be3d..2efad824ae72 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -856,6 +856,9 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 				       struct dxgadapter *adapter,
 				       struct d3dkmt_submitcommandtohwqueue *a);
+int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
+				       struct dxgadapter *adapter,
+				       struct d3dkmt_flushheaptransitions *arg);
 int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 				    struct dxgvmbuschannel *channel,
 				    struct d3dkmt_opensyncobjectfromnthandle2
@@ -865,6 +868,11 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				      struct dxgadapter *adapter,
 				      struct d3dkmt_queryallocationresidency
 				      *args);
+int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_queryvideomemoryinfo *args,
+				  struct d3dkmt_queryvideomemoryinfo
+				  *__user iargs);
 int dxgvmb_send_get_device_state(struct dxgprocess *process,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_getdevicestate *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index a1bb7a10bf60..684d9cecc804 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1774,6 +1774,29 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
+				       struct dxgadapter *adapter,
+				       struct d3dkmt_flushheaptransitions *args)
+{
+	struct dxgkvmb_command_flushheaptransitions *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_FLUSHHEAPTRANSITIONS,
+				   process->host_handle);
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				      struct dxgadapter *adapter,
 				      struct d3dkmt_queryallocationresidency
@@ -1847,6 +1870,70 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_queryvideomemoryinfo *args,
+				  struct d3dkmt_queryvideomemoryinfo *__user
+				  output)
+{
+	int ret;
+	struct dxgkvmb_command_queryvideomemoryinfo *command;
+	struct dxgkvmb_command_queryvideomemoryinfo_return result = { };
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	command_vgpu_to_host_init2(&command->hdr,
+				   dxgk_vmbcommand_queryvideomemoryinfo,
+				   process->host_handle);
+	command->adapter = args->adapter;
+	command->memory_segment_group = args->memory_segment_group;
+	command->physical_adapter_index = args->physical_adapter_index;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&output->budget, &result.budget,
+			   sizeof(output->budget));
+	if (ret) {
+		pr_err("%s failed to copy budget", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(&output->current_usage, &result.current_usage,
+			   sizeof(output->current_usage));
+	if (ret) {
+		pr_err("%s failed to copy current usage", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(&output->current_reservation,
+			   &result.current_reservation,
+			   sizeof(output->current_reservation));
+	if (ret) {
+		pr_err("%s failed to copy reservation", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(&output->available_for_reservation,
+			   &result.available_for_reservation,
+			   sizeof(output->available_for_reservation));
+	if (ret) {
+		pr_err("%s failed to copy avail reservation", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_get_device_state(struct dxgprocess *process,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_getdevicestate *args,
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 7ebad4524f94..8dd5b64a7dd5 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -880,6 +880,20 @@ dxgk_destroy_context(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int dxgk_create_hwcontext(struct dxgprocess *process,
+					     void *__user inargs)
+{
+	/* This is obsolete entry point */
+	return -ENOTTY;
+}
+
+static int dxgk_destroy_hwcontext(struct dxgprocess *process,
+					      void *__user inargs)
+{
+	/* This is obsolete entry point */
+	return -ENOTTY;
+}
+
 static int
 dxgk_create_hwqueue(struct dxgprocess *process, void *__user inargs)
 {
@@ -2527,6 +2541,13 @@ dxgk_open_sync_object_nt(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
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
@@ -3539,6 +3560,101 @@ dxgk_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_flushheaptransitions args;
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
+	ret = dxgvmb_send_flush_heap_transitions(process, adapter, &args);
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
+static int
+dxgk_query_vidmem_info(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryvideomemoryinfo args;
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
+	if (args.process != 0) {
+		pr_err("query vidmem info from another process ");
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
+	ret = dxgvmb_send_query_vidmem_info(process, adapter, &args, inargs);
+
+cleanup:
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	if (ret < 0)
+		pr_err("%s failed: %x", __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_get_device_state(struct dxgprocess *process, void *__user inargs)
 {
@@ -3854,6 +3970,20 @@ dxgk_share_objects(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_invalidate_cache(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not implemented", __func__);
+	return -ENOTTY;
+}
+
+static int
+dxgk_query_resource_info(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not supported", __func__);
+	return -ENOTTY;
+}
+
 static int
 dxgk_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
 {
@@ -4218,6 +4348,13 @@ open_resource(struct dxgprocess *process,
 	return ret;
 }
 
+static int
+dxgk_open_resource(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not supported", __func__);
+	return -ENOTTY;
+}
+
 static int
 dxgk_open_resource_nt(struct dxgprocess *process,
 				      void *__user inargs)
@@ -4274,6 +4411,28 @@ dxgk_share_object_with_host(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_render(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not implemented", __func__);
+	return -ENOTTY;
+}
+
+static int
+dxgk_create_context(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not implemented", __func__);
+	return -ENOTTY;
+}
+
+static int
+dxgk_get_shared_resource_adapter_luid(struct dxgprocess *process,
+				      void *__user inargs)
+{
+	pr_err("shared_resource_adapter_luid is not implemented");
+	return -ENOTTY;
+}
+
 /*
  * IOCTL processing
  * The driver IOCTLs return
@@ -4334,6 +4493,8 @@ void init_ioctls(void)
 		  LX_DXOPENADAPTERFROMLUID);
 	SET_IOCTL(/*0x2 */ dxgk_create_device,
 		  LX_DXCREATEDEVICE);
+	SET_IOCTL(/*0x3 */ dxgk_create_context,
+		  LX_DXCREATECONTEXT);
 	SET_IOCTL(/*0x4 */ dxgk_create_context_virtual,
 		  LX_DXCREATECONTEXTVIRTUAL);
 	SET_IOCTL(/*0x5 */ dxgk_destroy_context,
@@ -4344,6 +4505,8 @@ void init_ioctls(void)
 		  LX_DXCREATEPAGINGQUEUE);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0xa */ dxgk_query_vidmem_info,
+		  LX_DXQUERYVIDEOMEMORYINFO);
 	SET_IOCTL(/*0xe */ dxgk_get_device_state,
 		  LX_DXGETDEVICESTATE);
 	SET_IOCTL(/*0xf */ dxgk_submit_command,
@@ -4362,20 +4525,38 @@ void init_ioctls(void)
 		  LX_DXCLOSEADAPTER);
 	SET_IOCTL(/*0x16 */ dxgk_change_vidmem_reservation,
 		  LX_DXCHANGEVIDEOMEMORYRESERVATION);
+	SET_IOCTL(/*0x17 */ dxgk_create_hwcontext,
+		  LX_DXCREATEHWCONTEXT);
 	SET_IOCTL(/*0x18 */ dxgk_create_hwqueue,
 		  LX_DXCREATEHWQUEUE);
 	SET_IOCTL(/*0x19 */ dxgk_destroy_device,
 		  LX_DXDESTROYDEVICE);
+	SET_IOCTL(/*0x1a */ dxgk_destroy_hwcontext,
+		  LX_DXDESTROYHWCONTEXT);
 	SET_IOCTL(/*0x1b */ dxgk_destroy_hwqueue,
 		  LX_DXDESTROYHWQUEUE);
 	SET_IOCTL(/*0x1c */ dxgk_destroy_paging_queue,
 		  LX_DXDESTROYPAGINGQUEUE);
 	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x1f */ dxgk_flush_heap_transitions,
+		  LX_DXFLUSHHEAPTRANSITIONS);
+	SET_IOCTL(/*0x23 */ dxgk_get_shared_resource_adapter_luid,
+		  LX_DXGETSHAREDRESOURCEADAPTERLUID);
+	SET_IOCTL(/*0x24 */ dxgk_invalidate_cache,
+		  LX_DXINVALIDATECACHE);
 	SET_IOCTL(/*0x25 */ dxgk_lock2,
 		  LX_DXLOCK2);
+	SET_IOCTL(/*0x28 */ dxgk_open_resource,
+		  LX_DXOPENRESOURCE);
+	SET_IOCTL(/*0x29 */ dxgk_open_sync_object,
+		  LX_DXOPENSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x2a */ dxgk_query_alloc_residency,
 		  LX_DXQUERYALLOCATIONRESIDENCY);
+	SET_IOCTL(/*0x2b */ dxgk_query_resource_info,
+		  LX_DXQUERYRESOURCEINFO);
+	SET_IOCTL(/*0x2d */ dxgk_render,
+		  LX_DXRENDER);
 	SET_IOCTL(/*0x2e */ dxgk_set_allocation_priority,
 		  LX_DXSETALLOCATIONPRIORITY);
 	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
-- 
2.35.1

