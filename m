Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E904C94CB
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiCATra (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiCATr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BEA86D4C7;
        Tue,  1 Mar 2022 11:46:36 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4E5ED20B477E;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E5ED20B477E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163994;
        bh=VpjY3FrKP5eYWuPDrUFpWY+hn6+F33dyUxnUAJQU0GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+drvFiNLmqGozrk0Sdes7AxiznXuD/8ll7TeL0Wcd+/Zq2KNfK3rgJUTY1GvK8xn
         3bRkMXN7LVCVroZEojcdk77iB5Bs0IS1l591+CfrLcXz3ogRZfTwZ6rdFCgOH/hqfU
         bcd9BiGiRchWhJRZcN9ygOkkuVIoiCgo76xYI9v4=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 23/30] drivers: hv: dxgkrnl: The escape ioctl
Date:   Tue,  1 Mar 2022 11:46:10 -0800
Message-Id: <70edaf072c234df9c2c5bc8fec95392271e780d6.1646163379.git.iourit@linux.microsoft.com>
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

Implement the escape ioctl (LX_DXESCAPE).

This ioctl is used to send/receive private data between user mode
compute device driver (guest) and kernel mode compute device
driver (host). It allows the user mode driver to extend the virtual
compute device API.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  3 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 65 +++++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h | 12 +++++++
 drivers/hv/dxgkrnl/ioctl.c    | 42 ++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  | 41 ++++++++++++++++++++++
 5 files changed, 163 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 6cd6bc6d6b9a..875e336c11d3 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -874,6 +874,9 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				      struct dxgadapter *adapter,
 				      struct d3dkmt_queryallocationresidency
 				      *args);
+int dxgvmb_send_escape(struct dxgprocess *process,
+		       struct dxgadapter *adapter,
+		       struct d3dkmt_escape *args);
 int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 				  struct dxgadapter *adapter,
 				  struct d3dkmt_queryvideomemoryinfo *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 40ed2e981d73..c76ab993e9ba 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1908,6 +1908,70 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_escape(struct dxgprocess *process,
+		       struct dxgadapter *adapter,
+		       struct d3dkmt_escape *args)
+{
+	int ret;
+	struct dxgkvmb_command_escape *command = NULL;
+	u32 cmd_size = sizeof(*command);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	cmd_size = cmd_size - sizeof(args->priv_drv_data[0]) +
+	    args->priv_drv_data_size;
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_ESCAPE,
+				   process->host_handle);
+	command->adapter = args->adapter;
+	command->device = args->device;
+	command->type = args->type;
+	command->flags = args->flags;
+	command->priv_drv_data_size = args->priv_drv_data_size;
+	command->context = args->context;
+	if (args->priv_drv_data_size) {
+		ret = copy_from_user(command->priv_drv_data,
+				     args->priv_drv_data,
+				     args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s failed to copy priv data", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   command->priv_drv_data,
+				   args->priv_drv_data_size);
+	if (ret < 0)
+		goto cleanup;
+
+	if (args->priv_drv_data_size) {
+		ret = copy_to_user(args->priv_drv_data,
+				   command->priv_drv_data,
+				   args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s failed to copy priv data", __func__);
+			ret = -EINVAL;
+		}
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 				  struct dxgadapter *adapter,
 				  struct d3dkmt_queryvideomemoryinfo *args,
@@ -3125,3 +3189,4 @@ int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 		pr_debug("err: %s %d", __func__, ret);
 	return ret;
 }
+
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 8bca304fcb4b..d2d22775645b 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -664,6 +664,18 @@ struct dxgkvmb_command_queryallocationresidency_return {
 	/* d3dkmt_allocationresidencystatus[NumAllocations] */
 };
 
+/* Returns only private data */
+struct dxgkvmb_command_escape {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		adapter;
+	struct d3dkmthandle		device;
+	enum d3dkmt_escapetype		type;
+	struct d3dddi_escapeflags	flags;
+	u32				priv_drv_data_size;
+	struct d3dkmthandle		context;
+	u8				priv_drv_data[1];
+};
+
 struct dxgkvmb_command_queryvideomemoryinfo {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmthandle		adapter;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index d7dbde41b8a2..763bd76382a0 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3586,6 +3586,46 @@ dxgk_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_escape(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_escape args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	bool adapter_locked = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
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
+	ret = dxgvmb_send_escape(process, adapter, &args);
+
+cleanup:
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_query_vidmem_info(struct dxgprocess *process, void *__user inargs)
 {
@@ -4441,6 +4481,8 @@ void init_ioctls(void)
 		  LX_DXQUERYADAPTERINFO);
 	SET_IOCTL(/*0xa */ dxgk_query_vidmem_info,
 		  LX_DXQUERYVIDEOMEMORYINFO);
+	SET_IOCTL(/*0xd */ dxgk_escape,
+		  LX_DXESCAPE);
 	SET_IOCTL(/*0xe */ dxgk_get_device_state,
 		  LX_DXGETDEVICESTATE);
 	SET_IOCTL(/*0xf */ dxgk_submit_command,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index f7f663f6e674..cf08166f4e5d 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -232,6 +232,45 @@ struct d3dddi_destroypagingqueue {
 	struct d3dkmthandle		paging_queue;
 };
 
+enum d3dkmt_escapetype {
+	_D3DKMT_ESCAPE_DRIVERPRIVATE	= 0,
+	_D3DKMT_ESCAPE_VIDMM		= 1,
+	_D3DKMT_ESCAPE_VIDSCH		= 3,
+	_D3DKMT_ESCAPE_DEVICE		= 4,
+	_D3DKMT_ESCAPE_DRT_TEST		= 8,
+};
+
+struct d3dddi_escapeflags {
+	union {
+		struct {
+			__u32		hardware_access:1;
+			__u32		device_status_query:1;
+			__u32		change_frame_latency:1;
+			__u32		no_adapter_synchronization:1;
+			__u32		reserved:1;
+			__u32		virtual_machine_data:1;
+			__u32		driver_known_escape:1;
+			__u32		driver_common_escape:1;
+			__u32		reserved2:24;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_escape {
+	struct d3dkmthandle		adapter;
+	struct d3dkmthandle		device;
+	enum d3dkmt_escapetype		type;
+	struct d3dddi_escapeflags	flags;
+#ifdef __KERNEL__
+	void				*priv_drv_data;
+#else
+	__u64				priv_drv_data;
+#endif
+	__u32				priv_drv_data_size;
+	struct d3dkmthandle		context;
+};
+
 enum dxgk_render_pipeline_stage {
 	_DXGK_RENDER_PIPELINE_STAGE_UNKNOWN		= 0,
 	_DXGK_RENDER_PIPELINE_STAGE_INPUT_ASSEMBLER	= 1,
@@ -1213,6 +1252,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXQUERYVIDEOMEMORYINFO	\
 	_IOWR(0x47, 0x0a, struct d3dkmt_queryvideomemoryinfo)
+#define LX_DXESCAPE			\
+	_IOWR(0x47, 0x0d, struct d3dkmt_escape)
 #define LX_DXGETDEVICESTATE		\
 	_IOWR(0x47, 0x0e, struct d3dkmt_getdevicestate)
 #define LX_DXSUBMITCOMMAND		\
-- 
2.35.1

