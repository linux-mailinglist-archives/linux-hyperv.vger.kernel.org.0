Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5184AA5E7
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379058AbiBECec (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:32 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45084 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379015AbiBECeZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:25 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9A4E720B83F8;
        Fri,  4 Feb 2022 18:34:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A4E720B83F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028465;
        bh=RojMZ2F7nOOds6BfWkZDgCGSeVXZSAnagFLgTkdvJ18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4oasDoZG+0o0mnbgxd92JQbI3mGXUGTCPunHAAV8wkkbVeUkbsmhHuNRfV30CW+N
         Bmt29nkmNUN3dbXA436HfudNmqDeQPKa4f7LYs5y3+UYVMQr3tg0HhtYloD4bvBBMY
         0SlQ2/1LF+0xTgRUUhpjVMHjYwOQu2gZLxR8SGMY=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 13/24] drivers: hv: dxgkrnl: Submit execution commands to the compute device
Date:   Fri,  4 Feb 2022 18:34:11 -0800
Message-Id: <b22954afd322a5f3e710df309ed4f5da5272605a.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

- LX_DXSUBMITCOMMAND(D3DKMTSubmitCommand)
  The IOCTL is used to submit a command buffer to the device,
  working in the software packet scheduling mode.

- LX_DXSUBMITCOMMANDTOHWQUEUE(D3DKMTSubmitCommandToHwQueue)
  The IOCTL is used to submit a command buffer to the device,
  working in the hardware scheduling mode.

  Both IOCTLs are asynchronous to improve performance as these
  are high frequency operations.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   6 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 111 +++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 129 ++++++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 887a23a5bbf8..cb533d5fe797 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -770,6 +770,9 @@ int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 int dxgvmb_send_destroy_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 				   struct d3dkmt_destroyallocation2 *args,
 				   struct d3dkmthandle *alloc_handles);
+int dxgvmb_send_submit_command(struct dxgprocess *pr,
+			       struct dxgadapter *adapter,
+			       struct d3dkmt_submitcommand *args);
 int dxgvmb_send_create_sync_object(struct dxgprocess *pr,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_createsynchronizationobject2
@@ -812,6 +815,9 @@ int dxgvmb_send_destroy_hwqueue(struct dxgprocess *process,
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
index 4acfe11d5b90..b474c63df653 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1848,6 +1848,60 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
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
@@ -2366,3 +2420,60 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
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
-- 
2.35.1

