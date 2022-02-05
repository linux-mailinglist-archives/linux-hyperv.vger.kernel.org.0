Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7614AA5DF
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379041AbiBECep (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:45 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45152 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379027AbiBECe1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:27 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0906120B8767;
        Fri,  4 Feb 2022 18:34:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0906120B8767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028467;
        bh=DuzXMHcZ96cA1pXst1JBDrvagkC2PbXVSU+HSg2RTK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IV6q/ecF1i/mfYCcfqsU1uEcDYVHIGuqZZOi0M0hK/kP/ZKrWC2Ag4UMaworzh+TM
         5NRCdSnqlPhSnm97OewSiYXMWG/AeuRyCL0sd53Fi+cKQsOiDbxtLIJJoQFqrZ2GAk
         2/Mf7sOQX9h9YEkF/ny9xpsDFK9CamnEy8raW78o=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 21/24] drivers: hv: dxgkrnl: Ioctls to set/get scheduling priority
Date:   Fri,  4 Feb 2022 18:34:19 -0800
Message-Id: <f7e0f84eb4466a04c66d840f4377458a4fd9d882.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY
LX_DXGETCONTEXTSCHEDULINGPRIORITY
LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY
LX_DXSETCONTEXTSCHEDULINGPRIORITY

A GPU context could have an assigned scheduling priority.
The host dxgkrnl driver submits work from contexts to GPU,
based on the priority of the contexts.
The IOCTLs simply send requests to the host and return the result
back to the caller.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   9 ++
 drivers/hv/dxgkrnl/dxgvmbus.c |  63 +++++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 173 ++++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 52d7d74a93e4..eebb9cee39c3 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -839,6 +839,15 @@ int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 					struct dxgadapter *adapter,
 					struct d3dkmt_getallocationpriority *a);
+int dxgvmb_send_set_context_sch_priority(struct dxgprocess *process,
+					 struct dxgadapter *adapter,
+					 struct d3dkmthandle context,
+					 int priority, bool in_process);
+int dxgvmb_send_get_context_sch_priority(struct dxgprocess *process,
+					 struct dxgadapter *adapter,
+					 struct d3dkmthandle context,
+					 int *priority,
+					 bool in_process);
 int dxgvmb_send_offer_allocations(struct dxgprocess *process,
 				  struct dxgadapter *adapter,
 				  struct d3dkmt_offerallocations *args);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 84034c4fafe2..2b64d53685a0 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2889,6 +2889,69 @@ int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_set_context_sch_priority(struct dxgprocess *process,
+					 struct dxgadapter *adapter,
+					 struct d3dkmthandle context,
+					 int priority,
+					 bool in_process)
+{
+	struct dxgkvmb_command_setcontextschedulingpriority2 *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_SETCONTEXTSCHEDULINGPRIORITY,
+				   process->host_handle);
+	command->context = context;
+	command->priority = priority;
+	command->in_process = in_process;
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_get_context_sch_priority(struct dxgprocess *process,
+					 struct dxgadapter *adapter,
+					 struct d3dkmthandle context,
+					 int *priority,
+					 bool in_process)
+{
+	struct dxgkvmb_command_getcontextschedulingpriority *command;
+	struct dxgkvmb_command_getcontextschedulingpriority_return result = { };
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_GETCONTEXTSCHEDULINGPRIORITY,
+				   process->host_handle);
+	command->context = context;
+	command->in_process = in_process;
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret >= 0) {
+		ret = ntstatus2int(result.status);
+		*priority = result.priority;
+	}
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_offer_allocations(struct dxgprocess *process,
 				  struct dxgadapter *adapter,
 				  struct d3dkmt_offerallocations *args)
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 3370e5de4314..61bdc9a91903 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3724,6 +3724,171 @@ dxgk_get_allocation_priority(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+set_context_scheduling_priority(struct dxgprocess *process,
+				struct d3dkmthandle hcontext,
+				int priority, bool in_process)
+{
+	int ret = 0;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    hcontext);
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
+	ret = dxgvmb_send_set_context_sch_priority(process, adapter,
+						   hcontext, priority,
+						   in_process);
+	if (ret < 0)
+		pr_err("send_set_context_scheduling_priority failed");
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
+static int
+dxgk_set_context_scheduling_priority(struct dxgprocess *process,
+				     void *__user inargs)
+{
+	struct d3dkmt_setcontextschedulingpriority args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = set_context_scheduling_priority(process, args.context,
+					      args.priority, false);
+cleanup:
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+get_context_scheduling_priority(struct dxgprocess *process,
+				struct d3dkmthandle hcontext,
+				int __user *priority,
+				bool in_process)
+{
+	int ret;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int pri = 0;
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    hcontext);
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
+	ret = dxgvmb_send_get_context_sch_priority(process, adapter,
+						   hcontext, &pri, in_process);
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(priority, &pri, sizeof(pri));
+	if (ret) {
+		pr_err("%s failed to copy priority to user", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
+static int
+dxgk_get_context_scheduling_priority(struct dxgprocess *process,
+				     void *__user inargs)
+{
+	struct d3dkmt_getcontextschedulingpriority args;
+	struct d3dkmt_getcontextschedulingpriority __user *input = inargs;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = get_context_scheduling_priority(process, args.context,
+					      &input->priority, false);
+cleanup:
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_set_context_process_scheduling_priority(struct dxgprocess *process,
+					     void *__user inargs)
+{
+	struct d3dkmt_setcontextinprocessschedulingpriority args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = set_context_scheduling_priority(process, args.context,
+					      args.priority, true);
+cleanup:
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_get_context_process_scheduling_priority(struct dxgprocess *process,
+					     void __user *inargs)
+{
+	struct d3dkmt_getcontextinprocessschedulingpriority args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = get_context_scheduling_priority(process, args.context,
+		&((struct d3dkmt_getcontextinprocessschedulingpriority *)
+		inargs)->priority, true);
+cleanup:
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs)
 {
@@ -4843,6 +5008,10 @@ void init_ioctls(void)
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x1f */ dxgk_flush_heap_transitions,
 		  LX_DXFLUSHHEAPTRANSITIONS);
+	SET_IOCTL(/*0x21 */ dxgk_get_context_process_scheduling_priority,
+		  LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY);
+	SET_IOCTL(/*0x22 */ dxgk_get_context_scheduling_priority,
+		  LX_DXGETCONTEXTSCHEDULINGPRIORITY);
 	SET_IOCTL(/*0x23 */ dxgk_get_shared_resource_adapter_luid,
 		  LX_DXGETSHAREDRESOURCEADAPTERLUID);
 	SET_IOCTL(/*0x24 */ dxgk_invalidate_cache,
@@ -4867,6 +5036,10 @@ void init_ioctls(void)
 		  LX_DXRENDER);
 	SET_IOCTL(/*0x2e */ dxgk_set_allocation_priority,
 		  LX_DXSETALLOCATIONPRIORITY);
+	SET_IOCTL(/*0x2f */ dxgk_set_context_process_scheduling_priority,
+		  LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY);
+	SET_IOCTL(/*0x30 */ dxgk_set_context_scheduling_priority,
+		  LX_DXSETCONTEXTSCHEDULINGPRIORITY);
 	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x32 */ dxgk_signal_sync_object_gpu,
-- 
2.35.1

