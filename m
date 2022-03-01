Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642764C94CA
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiCATrk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbiCATrU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:20 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFEB46D3A8;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id E731220B4776;
        Tue,  1 Mar 2022 11:46:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E731220B4776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163994;
        bh=6KM5MsfposKDTHeJl/tCcqehF/SHzSSfyzM7+yZ9/oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDoNSoZtFKfGDQZLpehwn8summT+BfIHn1V/1y+ssocNdhVX3AwnQ6MDdD5oYJiF5
         IW/VIdWpf0Cippy49WwXMKunR4X44OqH1ypzZbZrYtd69vbm7yLNtBjbfp4qrZDYaX
         +hFDQ6WM0zusWbU4upfc8GVzwVax7tDkYYrxmJ3k=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 21/30] drivers: hv: dxgkrnl: Flush heap transitions
Date:   Tue,  1 Mar 2022 11:46:08 -0800
Message-Id: <5d9bdf60e080726af0e9f66207040b3f850da345.1646163378.git.iourit@linux.microsoft.com>
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

Implement the ioctl to flush heap transitions
(LX_DXFLUSHHEAPTRANSITIONS).

The ioctl is used to ensure that the video memory manager on the host
flushes all internal operations.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  3 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 23 ++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  5 ++++
 drivers/hv/dxgkrnl/ioctl.c    | 49 +++++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  |  6 +++++
 5 files changed, 86 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index e50f9dbbd5fb..7d3f2617414d 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -862,6 +862,9 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 				       struct dxgadapter *adapter,
 				       struct d3dkmt_submitcommandtohwqueue *a);
+int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
+				       struct dxgadapter *adapter,
+				       struct d3dkmt_flushheaptransitions *arg);
 int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 				    struct dxgvmbuschannel *channel,
 				    struct d3dkmt_opensyncobjectfromnthandle2
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 7c95f63e7f88..67b9e1b45b97 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1812,6 +1812,29 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
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
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 5b7654ef63f3..95c8b4a0cff9 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -367,6 +367,11 @@ struct dxgkvmb_command_submitcommandtohwqueue {
 	/* PrivateDriverData */
 };
 
+/* Returns  ntstatus */
+struct dxgkvmb_command_flushheaptransitions {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+};
+
 struct dxgkvmb_command_createallocation_allocinfo {
 	u32				flags;
 	u32				priv_drv_data_size;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 7ebad4524f94..4f2d762811ba 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3539,6 +3539,53 @@ dxgk_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs)
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
 static int
 dxgk_get_device_state(struct dxgprocess *process, void *__user inargs)
 {
@@ -4372,6 +4419,8 @@ void init_ioctls(void)
 		  LX_DXDESTROYPAGINGQUEUE);
 	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x1f */ dxgk_flush_heap_transitions,
+		  LX_DXFLUSHHEAPTRANSITIONS);
 	SET_IOCTL(/*0x25 */ dxgk_lock2,
 		  LX_DXLOCK2);
 	SET_IOCTL(/*0x2a */ dxgk_query_alloc_residency,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 2dac2d13196a..b0a2c858f122 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -932,6 +932,10 @@ struct d3dkmt_queryadapterinfo {
 	__u32				private_data_size;
 };
 
+struct d3dkmt_flushheaptransitions {
+	struct d3dkmthandle	adapter;
+};
+
 struct d3dddi_openallocationinfo2 {
 	struct d3dkmthandle	allocation;
 #ifdef __KERNEL__
@@ -1224,6 +1228,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
 #define LX_DXDESTROYSYNCHRONIZATIONOBJECT \
 	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
+#define LX_DXFLUSHHEAPTRANSITIONS	\
+	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
 #define LX_DXLOCK2			\
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
 #define LX_DXQUERYALLOCATIONRESIDENCY	\
-- 
2.35.1

