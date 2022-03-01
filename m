Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7234C94ED
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiCATri (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbiCATr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 784446D4CB;
        Tue,  1 Mar 2022 11:46:36 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7814B20B4780;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7814B20B4780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163994;
        bh=kCIyR2mWfMTuS4iVykDOHrmv/pCXtKvJue9w934YfPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eap4ICA+4GSso07ojyYZfK1s3xrezwZ70hdUyvDMdjsjcdahPVGFJiK5nk68Bv8o+
         qjD8KOzfGiZ9ckEvPz8s6tIzdJaNJiR5eLQzagG5rrqdvne0MsiMMesHl9TNt9P0M0
         GfJfDCO5z67LPtlab+wvqvDJxUyzwuwI0NqvGJSA=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 24/30] drivers: hv: dxgkrnl: Ioctl to put device to error state
Date:   Tue,  1 Mar 2022 11:46:11 -0800
Message-Id: <0381fb9117e596b299d162ed54a7bb8e4e6ff559.1646163379.git.iourit@linux.microsoft.com>
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

Implement the ioctl to put the virtual compute device to the error
state (LX_DXMARKDEVICEASERROR).

This ioctl is used by the user mode driver when it detects an
unrecoverable error condition.

When a compute device is put to the error state, all subsequent
ioctl calls to the device will fail.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  3 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 25 ++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  5 +++++
 drivers/hv/dxgkrnl/ioctl.c    | 39 +++++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  | 12 +++++++++++
 5 files changed, 84 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 875e336c11d3..03acf8ce3baa 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -836,6 +836,9 @@ int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
 				      struct d3dddi_updateallocproperty *args,
 				      struct d3dddi_updateallocproperty *__user
 				      inargs);
+int dxgvmb_send_mark_device_as_error(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmt_markdeviceaserror *args);
 int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 					struct dxgadapter *adapter,
 					struct d3dkmt_setallocationpriority *a);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index c76ab993e9ba..bf65599635c6 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2708,6 +2708,31 @@ int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_mark_device_as_error(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmt_markdeviceaserror *args)
+{
+	struct dxgkvmb_command_markdeviceaserror *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_MARKDEVICEASERROR,
+				   process->host_handle);
+	command->args = *args;
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 				struct dxgadapter *adapter,
 				struct d3dkmt_setallocationpriority *args)
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index d2d22775645b..615a163f836e 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -627,6 +627,11 @@ struct dxgkvmb_command_updateallocationproperty_return {
 	struct ntstatus			status;
 };
 
+struct dxgkvmb_command_markdeviceaserror {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_markdeviceaserror args;
+};
+
 /* Returns ntstatus */
 struct dxgkvmb_command_changevideomemoryreservation {
 	struct dxgkvmb_command_vgpu_to_host hdr;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 763bd76382a0..b2cc2c6fc725 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3380,6 +3380,43 @@ dxgk_update_alloc_property(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_mark_device_as_error(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_markdeviceaserror args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	pr_debug("ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
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
+	device->execution_state = _D3DKMT_DEVICEEXECUTION_RESET;
+	ret = dxgvmb_send_mark_device_as_error(process, adapter, &args);
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_query_alloc_residency(struct dxgprocess *process, void *__user inargs)
 {
@@ -4515,6 +4552,8 @@ void init_ioctls(void)
 		  LX_DXFLUSHHEAPTRANSITIONS);
 	SET_IOCTL(/*0x25 */ dxgk_lock2,
 		  LX_DXLOCK2);
+	SET_IOCTL(/*0x26 */ dxgk_mark_device_as_error,
+		  LX_DXMARKDEVICEASERROR);
 	SET_IOCTL(/*0x2a */ dxgk_query_alloc_residency,
 		  LX_DXQUERYALLOCATIONRESIDENCY);
 	SET_IOCTL(/*0x2e */ dxgk_set_allocation_priority,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index cf08166f4e5d..fb4ff4b905c4 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -786,6 +786,16 @@ struct d3dkmt_unlock2 {
 	struct d3dkmthandle			allocation;
 };
 
+enum d3dkmt_device_error_reason {
+	_D3DKMT_DEVICE_ERROR_REASON_GENERIC		= 0x80000000,
+	_D3DKMT_DEVICE_ERROR_REASON_DRIVER_ERROR	= 0x80000006,
+};
+
+struct d3dkmt_markdeviceaserror {
+	struct d3dkmthandle			device;
+	enum d3dkmt_device_error_reason		reason;
+};
+
 enum d3dkmt_standardallocationtype {
 	_D3DKMT_STANDARDALLOCATIONTYPE_EXISTINGHEAP	= 1,
 	_D3DKMT_STANDARDALLOCATIONTYPE_CROSSADAPTER	= 2,
@@ -1286,6 +1296,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
 #define LX_DXLOCK2			\
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
+#define LX_DXMARKDEVICEASERROR		\
+	_IOWR(0x47, 0x26, struct d3dkmt_markdeviceaserror)
 #define LX_DXQUERYALLOCATIONRESIDENCY	\
 	_IOWR(0x47, 0x2a, struct d3dkmt_queryallocationresidency)
 #define LX_DXSETALLOCATIONPRIORITY	\
-- 
2.35.1

