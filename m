Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD954C94D4
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbiCATre (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbiCATr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EAC06D849;
        Tue,  1 Mar 2022 11:46:37 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 13FE720B4783;
        Tue,  1 Mar 2022 11:46:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13FE720B4783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163995;
        bh=k0Nw6viu2p8DE8OnDudjEQ7OhqwR/vXr+trWuzwhzhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjRL5dXnw3ZaTVr9SCO28rxs/50vfu4UWsWlo6U8TisgkKzFptwWcb2ayNoLBzOoA
         0ZyhspdBo96Y2sd+W5NkNL705LT9SNk3t1o4xksIl2i31BS+SJL9jAz+5Pf5AgJVFm
         IyQqqRO2+u7BrVpXAIjUarPNMpN+85xDG3bCV5aQ=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 27/30] drivers: hv: dxgkrnl: Ioctls to manage scheduling priority
Date:   Tue,  1 Mar 2022 11:46:14 -0800
Message-Id: <6545b87388ea35ff2d59c326cac480af562be0cc.1646163379.git.iourit@linux.microsoft.com>
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

Implement iocts to manage compute device scheduling priority:
  - LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY
  - LX_DXGETCONTEXTSCHEDULINGPRIORITY
  - LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY
  - LX_DXSETCONTEXTSCHEDULINGPRIORITY

Each compute device execution context has an assigned scheduling
priority. It is used by the compute device scheduler on the host to
pick contexts for execution. There is a global priority and a
priority within a process.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   9 ++
 drivers/hv/dxgkrnl/dxgvmbus.c |  63 +++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  19 ++++
 drivers/hv/dxgkrnl/ioctl.c    | 173 ++++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  |  28 ++++++
 5 files changed, 292 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 59e10e7202cd..00c3bb5f3ab8 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -845,6 +845,15 @@ int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
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
index 0ab7acf3787b..2f0914b71c3c 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2927,6 +2927,69 @@ int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
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
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 7fa89ed16c2d..2e522d6652da 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -331,6 +331,25 @@ struct dxgkvmb_command_getallocationpriority_return {
 	/* u32 priorities[allocation_count or 1]; */
 };
 
+/* Returns ntstatus */
+struct dxgkvmb_command_setcontextschedulingpriority2 {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	int				priority;
+	bool				in_process;
+};
+
+struct dxgkvmb_command_getcontextschedulingpriority {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	bool				in_process;
+};
+
+struct dxgkvmb_command_getcontextschedulingpriority_return {
+	struct ntstatus			status;
+	int				priority;
+};
+
 struct dxgkvmb_command_createdevice {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_createdeviceflags	flags;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 47ffdd1dda93..0a4fca6ee2aa 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3703,6 +3703,171 @@ dxgk_get_allocation_priority(struct dxgprocess *process, void *__user inargs)
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
@@ -4773,6 +4938,10 @@ void init_ioctls(void)
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x1f */ dxgk_flush_heap_transitions,
 		  LX_DXFLUSHHEAPTRANSITIONS);
+	SET_IOCTL(/*0x21 */ dxgk_get_context_process_scheduling_priority,
+		  LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY);
+	SET_IOCTL(/*0x22 */ dxgk_get_context_scheduling_priority,
+		  LX_DXGETCONTEXTSCHEDULINGPRIORITY);
 	SET_IOCTL(/*0x25 */ dxgk_lock2,
 		  LX_DXLOCK2);
 	SET_IOCTL(/*0x26 */ dxgk_mark_device_as_error,
@@ -4785,6 +4954,10 @@ void init_ioctls(void)
 		  LX_DXRECLAIMALLOCATIONS2);
 	SET_IOCTL(/*0x2e */ dxgk_set_allocation_priority,
 		  LX_DXSETALLOCATIONPRIORITY);
+	SET_IOCTL(/*0x2f */ dxgk_set_context_process_scheduling_priority,
+		  LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY);
+	SET_IOCTL(/*0x30 */ dxgk_set_context_scheduling_priority,
+		  LX_DXSETCONTEXTSCHEDULINGPRIORITY);
 	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x32 */ dxgk_signal_sync_object_gpu,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 3849f714ae9c..11e2f3c9c88c 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -704,6 +704,26 @@ struct d3dkmt_submitcommandtohwqueue {
 #endif
 };
 
+struct d3dkmt_setcontextschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
+struct d3dkmt_setcontextinprocessschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
+struct d3dkmt_getcontextschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
+struct d3dkmt_getcontextinprocessschedulingpriority {
+	struct d3dkmthandle			context;
+	int					priority;
+};
+
 struct d3dkmt_setallocationpriority {
 	struct d3dkmthandle		device;
 	struct d3dkmthandle		resource;
@@ -1415,6 +1435,10 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
 #define LX_DXFLUSHHEAPTRANSITIONS	\
 	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
+#define LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x21, struct d3dkmt_getcontextinprocessschedulingpriority)
+#define LX_DXGETCONTEXTSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x22, struct d3dkmt_getcontextschedulingpriority)
 #define LX_DXLOCK2			\
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
 #define LX_DXMARKDEVICEASERROR		\
@@ -1427,6 +1451,10 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x2c, struct d3dkmt_reclaimallocations2)
 #define LX_DXSETALLOCATIONPRIORITY	\
 	_IOWR(0x47, 0x2e, struct d3dkmt_setallocationpriority)
+#define LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x2f, struct d3dkmt_setcontextinprocessschedulingpriority)
+#define LX_DXSETCONTEXTSCHEDULINGPRIORITY \
+	_IOWR(0x47, 0x30, struct d3dkmt_setcontextschedulingpriority)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x31, struct d3dkmt_signalsynchronizationobjectfromcpu)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU \
-- 
2.35.1

