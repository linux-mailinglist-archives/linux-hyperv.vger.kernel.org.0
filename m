Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A294C94C9
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiCATrh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbiCATr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03F4E6D3B1;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 23DB320B477B;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23DB320B477B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163994;
        bh=1GM7xELJ0O/k69aR3fvRIEK9sQ+2nVen9lVIJGDQaac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nk8Y5x9Mk/Zd6WJxExEd+2p7QThSHgPwbtptAN3bkbeaOYIDxvKAN4s7tHwXxaikz
         QN34J/7kg7mZItbVMVLn+ilfzwxaNGkdcWbQFlIp4FWavQ0/Ha0tX6vOBjvMsIwDwO
         lPn4ajCWd5vbdSw5HyXG0Pn5tzYp4g7FBHOr3yKQ=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 22/30] drivers: hv: dxgkrnl: Query video memory information
Date:   Tue,  1 Mar 2022 11:46:09 -0800
Message-Id: <5dadbe959f96e2764a61157eb05f0804a74afb1c.1646163379.git.iourit@linux.microsoft.com>
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

Implement the ioctl to query video memory information from the host
(LX_DXQUERYVIDEOMEMORYINFO).

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  5 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 64 +++++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h | 14 ++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 50 +++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  | 13 +++++++
 5 files changed, 146 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 7d3f2617414d..6cd6bc6d6b9a 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -874,6 +874,11 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
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
index 67b9e1b45b97..40ed2e981d73 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1908,6 +1908,70 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
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
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 95c8b4a0cff9..8bca304fcb4b 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -664,6 +664,20 @@ struct dxgkvmb_command_queryallocationresidency_return {
 	/* d3dkmt_allocationresidencystatus[NumAllocations] */
 };
 
+struct dxgkvmb_command_queryvideomemoryinfo {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		adapter;
+	enum d3dkmt_memory_segment_group memory_segment_group;
+	u32				physical_adapter_index;
+};
+
+struct dxgkvmb_command_queryvideomemoryinfo_return {
+	u64			budget;
+	u64			current_usage;
+	u64			current_reservation;
+	u64			available_for_reservation;
+};
+
 struct dxgkvmb_command_getdevicestate {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_getdevicestate	args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 4f2d762811ba..d7dbde41b8a2 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3586,6 +3586,54 @@ dxgk_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
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
@@ -4391,6 +4439,8 @@ void init_ioctls(void)
 		  LX_DXCREATEPAGINGQUEUE);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0xa */ dxgk_query_vidmem_info,
+		  LX_DXQUERYVIDEOMEMORYINFO);
 	SET_IOCTL(/*0xe */ dxgk_get_device_state,
 		  LX_DXGETDEVICESTATE);
 	SET_IOCTL(/*0xf */ dxgk_submit_command,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index b0a2c858f122..f7f663f6e674 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -893,6 +893,17 @@ enum d3dkmt_memory_segment_group {
 	_D3DKMT_MEMORY_SEGMENT_GROUP_NON_LOCAL	= 1
 };
 
+struct d3dkmt_queryvideomemoryinfo {
+	__u64					process;
+	struct d3dkmthandle			adapter;
+	enum d3dkmt_memory_segment_group	memory_segment_group;
+	__u64					budget;
+	__u64					current_usage;
+	__u64					current_reservation;
+	__u64					available_for_reservation;
+	__u32					physical_adapter_index;
+};
+
 struct d3dkmt_adaptertype {
 	union {
 		struct {
@@ -1200,6 +1211,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
+#define LX_DXQUERYVIDEOMEMORYINFO	\
+	_IOWR(0x47, 0x0a, struct d3dkmt_queryvideomemoryinfo)
 #define LX_DXGETDEVICESTATE		\
 	_IOWR(0x47, 0x0e, struct d3dkmt_getdevicestate)
 #define LX_DXSUBMITCOMMAND		\
-- 
2.35.1

