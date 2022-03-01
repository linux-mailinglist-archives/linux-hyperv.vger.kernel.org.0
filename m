Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403584C94DD
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiCATr3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbiCATrU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:20 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 994DF6D392;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0788620B7178;
        Tue,  1 Mar 2022 11:46:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0788620B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163993;
        bh=rOyjGJgM1o6RjFg5Zfo5pAwME3P8gb3cJ/SdT65l3yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZaoQkHrGgtsfKt4RUH+ofCZ/XjG4ALb6Y8YXiCaPH+1ckJuiZwPe1jhrdIW/l0hAV
         hbl26IYjxxZhKEskm0f5Ab/VD5LUz86U94FjHWMRr44kGFYZJE7GByAqr4KCRt9Bvh
         o/ebKhtMKp1tmXOoN7yG+OBu/GDAtOFLfL2y2Z+E=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 16/30] drivers: hv: dxgkrnl: Submit execution commands to the compute device
Date:   Tue,  1 Mar 2022 11:46:03 -0800
Message-Id: <f37f6c441dcc27a9260388f82b3ea04ade414700.1646163378.git.iourit@linux.microsoft.com>
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

Implements ioctls for submission of compute device buffers for execution:
  - LX_DXSUBMITCOMMAND
    The ioctl is used to submit a command buffer to the device,
    working in the "packet scheduling" mode.

  - LX_DXSUBMITCOMMANDTOHWQUEUE
  The ioctl is used to submit a command buffer to the device,
  working in the "hardware scheduling" mode.

To improve performance both ioctls use asynchronous VM bus messages
to communicate with the host as these are high frequency operations.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   6 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 111 +++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  14 ++++
 drivers/hv/dxgkrnl/ioctl.c    | 129 ++++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  |  58 +++++++++++++++
 5 files changed, 318 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index a9aaefe9c168..2a2a69169e71 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -776,6 +776,9 @@ int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 int dxgvmb_send_destroy_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 				   struct d3dkmt_destroyallocation2 *args,
 				   struct d3dkmthandle *alloc_handles);
+int dxgvmb_send_submit_command(struct dxgprocess *pr,
+			       struct dxgadapter *adapter,
+			       struct d3dkmt_submitcommand *args);
 int dxgvmb_send_create_sync_object(struct dxgprocess *pr,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_createsynchronizationobject2
@@ -818,6 +821,9 @@ int dxgvmb_send_destroy_hwqueue(struct dxgprocess *process,
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
+int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
+				       struct dxgadapter *adapter,
+				       struct d3dkmt_submitcommandtohwqueue *a);
 int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 				    struct dxgvmbuschannel *channel,
 				    struct d3dkmt_opensyncobjectfromnthandle2
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index fcfd5544f651..eeb7cb76e1a5 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1886,6 +1886,60 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 	return ret;
 }
 
+int dxgvmb_send_submit_command(struct dxgprocess *process,
+			       struct dxgadapter *adapter,
+			       struct d3dkmt_submitcommand *args)
+{
+	int ret;
+	u32 cmd_size;
+	struct dxgkvmb_command_submitcommand *command;
+	u32 hbufsize = args->num_history_buffers * sizeof(struct d3dkmthandle);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	cmd_size = sizeof(struct dxgkvmb_command_submitcommand) +
+	    hbufsize + args->priv_drv_data_size;
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	ret = copy_from_user(&command[1], args->history_buffer_array,
+			     hbufsize);
+	if (ret) {
+		pr_err("%s failed to copy history buffer", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_from_user((u8 *) &command[1] + hbufsize,
+			     args->priv_drv_data, args->priv_drv_data_size);
+	if (ret) {
+		pr_err("%s failed to copy history priv data", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_SUBMITCOMMAND,
+				   process->host_handle);
+	command->args = *args;
+
+	if (dxgglobal->async_msg_enabled) {
+		command->hdr.async_msg = 1;
+		ret = dxgvmb_send_async_msg(msg.channel, msg.hdr, msg.size);
+	} else {
+		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
+						    msg.size);
+	}
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 static void set_result(struct d3dkmt_createsynchronizationobject2 *args,
 		       u64 fence_gpu_va, u8 *va)
 {
@@ -2404,3 +2458,60 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 		pr_debug("err: %s %d", __func__, ret);
 	return ret;
 }
+
+int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
+				       struct dxgadapter *adapter,
+				       struct d3dkmt_submitcommandtohwqueue
+				       *args)
+{
+	int ret = -EINVAL;
+	u32 cmd_size;
+	struct dxgkvmb_command_submitcommandtohwqueue *command;
+	u32 primaries_size = args->num_primaries * sizeof(struct d3dkmthandle);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	cmd_size = sizeof(*command) + args->priv_drv_data_size + primaries_size;
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	if (primaries_size) {
+		ret = copy_from_user(&command[1], args->written_primaries,
+					 primaries_size);
+		if (ret) {
+			pr_err("%s failed to copy primaries handles", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+	if (args->priv_drv_data_size) {
+		ret = copy_from_user((char *)&command[1] + primaries_size,
+				      args->priv_drv_data,
+				      args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s failed to copy primaries data", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_SUBMITCOMMANDTOHWQUEUE,
+				   process->host_handle);
+	command->args = *args;
+
+	if (dxgglobal->async_msg_enabled) {
+		command->hdr.async_msg = 1;
+		ret = dxgvmb_send_async_msg(msg.channel, msg.hdr, msg.size);
+	} else {
+		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
+						    msg.size);
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 10ec7efa4f27..d65412a57a7c 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -314,6 +314,20 @@ struct dxgkvmb_command_flushdevice {
 	enum dxgdevice_flushschedulerreason	reason;
 };
 
+struct dxgkvmb_command_submitcommand {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_submitcommand	args;
+	/* HistoryBufferHandles */
+	/* PrivateDriverData    */
+};
+
+struct dxgkvmb_command_submitcommandtohwqueue {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_submitcommandtohwqueue args;
+	/* Written primaries */
+	/* PrivateDriverData */
+};
+
 struct dxgkvmb_command_createallocation_allocinfo {
 	u32				flags;
 	u32				priv_drv_data_size;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 8992679de5c4..38d28d1792df 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1935,6 +1935,131 @@ dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_submit_command(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_submitcommand args;
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
+	if (args.broadcast_context_count > D3DDDI_MAX_BROADCAST_CONTEXT ||
+	    args.broadcast_context_count == 0) {
+		pr_err("invalid number of contexts");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("invalid private data size");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.num_history_buffers > 1024) {
+		pr_err("invalid number of history buffers");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.num_primaries > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("invalid number of primaries");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    args.broadcast_context[0]);
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
+	ret = dxgvmb_send_submit_command(process, adapter, &args);
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
+dxgk_submit_command_to_hwqueue(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_submitcommandtohwqueue args;
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
+	if (args.priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("invalid private data size");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.num_primaries > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("invalid number of primaries");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGHWQUEUE,
+						    args.hwqueue);
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
+	ret = dxgvmb_send_submit_command_hwqueue(process, adapter, &args);
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
 dxgk_submit_signal_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 {
@@ -3754,6 +3879,8 @@ void init_ioctls(void)
 		  LX_DXCREATEPAGINGQUEUE);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0xf */ dxgk_submit_command,
+		  LX_DXSUBMITCOMMAND);
 	SET_IOCTL(/*0x10 */ dxgk_create_sync_object,
 		  LX_DXCREATESYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x11 */ dxgk_signal_sync_object,
@@ -3782,6 +3909,8 @@ void init_ioctls(void)
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU);
 	SET_IOCTL(/*0x33 */ dxgk_signal_sync_object_gpu2,
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2);
+	SET_IOCTL(/*0x34 */ dxgk_submit_command_to_hwqueue,
+		  LX_DXSUBMITCOMMANDTOHWQUEUE);
 	SET_IOCTL(/*0x35 */ dxgk_submit_wait_to_hwqueue,
 		  LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE);
 	SET_IOCTL(/*0x36 */ dxgk_submit_signal_to_hwqueue,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index a35e02c4cf17..fe0b391d7f6b 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -54,6 +54,8 @@ struct winluid {
 	__u32 b;
 };
 
+#define D3DDDI_MAX_WRITTEN_PRIMARIES		16
+
 #define D3DKMT_CREATEALLOCATION_MAX		1024
 #define D3DKMT_ADAPTERS_MAX			64
 #define D3DDDI_MAX_BROADCAST_CONTEXT		64
@@ -521,6 +523,58 @@ struct d3dkmt_destroysynchronizationobject {
 	struct d3dkmthandle	sync_object;
 };
 
+struct d3dkmt_submitcommandflags {
+	__u32					null_rendering:1;
+	__u32					present_redirected:1;
+	__u32					reserved:30;
+};
+
+struct d3dkmt_submitcommand {
+	__u64					command_buffer;
+	__u32					command_length;
+	struct d3dkmt_submitcommandflags	flags;
+	__u64					present_history_token;
+	__u32					broadcast_context_count;
+	struct d3dkmthandle	broadcast_context[D3DDDI_MAX_BROADCAST_CONTEXT];
+	__u32					reserved;
+#ifdef __KERNEL__
+	void					*priv_drv_data;
+#else
+	__u64					priv_drv_data;
+#endif
+	__u32					priv_drv_data_size;
+	__u32					num_primaries;
+	struct d3dkmthandle	written_primaries[D3DDDI_MAX_WRITTEN_PRIMARIES];
+	__u32					num_history_buffers;
+	__u32					reserved1;
+#ifdef __KERNEL__
+	struct d3dkmthandle			*history_buffer_array;
+#else
+	__u64					history_buffer_array;
+#endif
+};
+
+struct d3dkmt_submitcommandtohwqueue {
+	struct d3dkmthandle	hwqueue;
+	__u32			reserved;
+	__u64			hwqueue_progress_fence_id;
+	__u64			command_buffer;
+	__u32			command_length;
+	__u32			priv_drv_data_size;
+#ifdef __KERNEL__
+	void			*priv_drv_data;
+#else
+	__u64			priv_drv_data;
+#endif
+	__u32			num_primaries;
+	__u32			reserved1;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*written_primaries;
+#else
+	__u64			written_primaries;
+#endif
+};
+
 enum d3dkmt_standardallocationtype {
 	_D3DKMT_STANDARDALLOCATIONTYPE_EXISTINGHEAP	= 1,
 	_D3DKMT_STANDARDALLOCATIONTYPE_CROSSADAPTER	= 2,
@@ -913,6 +967,8 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
+#define LX_DXSUBMITCOMMAND		\
+	_IOWR(0x47, 0x0f, struct d3dkmt_submitcommand)
 #define LX_DXCREATESYNCHRONIZATIONOBJECT \
 	_IOWR(0x47, 0x10, struct d3dkmt_createsynchronizationobject2)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECT \
@@ -941,6 +997,8 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x32, struct d3dkmt_signalsynchronizationobjectfromgpu)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2 \
 	_IOWR(0x47, 0x33, struct d3dkmt_signalsynchronizationobjectfromgpu2)
+#define LX_DXSUBMITCOMMANDTOHWQUEUE	\
+	_IOWR(0x47, 0x34, struct d3dkmt_submitcommandtohwqueue)
 #define LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE \
 	_IOWR(0x47, 0x35, struct d3dkmt_submitsignalsyncobjectstohwqueue)
 #define LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE \
-- 
2.35.1

