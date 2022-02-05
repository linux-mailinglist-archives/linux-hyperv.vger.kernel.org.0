Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF74AA5E5
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379095AbiBECel (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45114 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379002AbiBECe0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:26 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id CB25420B83FA;
        Fri,  4 Feb 2022 18:34:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB25420B83FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028465;
        bh=LlJklw6/Tpsj/joypGQrEMqpv8SvTVlBa+qVzpGChj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rm+kSceuks2ijkQZjjuXoi7LWK0TmBBYFuXYFpdWgTZVylMqgDPnG1QiTckAT+qxJ
         cAILck8MaHV4BaTTz+h8OJewJ3aGIEZWA/Ops7AlMha4GfoQ83aoT+RJi7GCp+SBVm
         EHYHP4MFIGh/1MTxc7fNTRBcWzg9SPtAyu6Iujnk=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 14/24] drivers: hv: dxgkrnl: Implement LX_DXSHAREOBJECTWITHHOST ioctl
Date:   Fri,  4 Feb 2022 18:34:12 -0800
Message-Id: <b057425ee4a1e95a3a652e516b5ac31484d3f6e9.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

- Implement the LX_DXSHAREOBJECTWITHHOST (D3DKMTShareObjectWithHost)
  IOCTL. This IOCTL is used to create an NT handle on the host for the
  given shared object. The NT handle is returned to the caller. The caller
  (usually a compositor) could share the NT handle with the host
  client, which renders the guest window. The host client can open
  the shared resource using the NT handle. This way the guest and the
  host have access to the same object (for example, dxgresource or
  dxgsyncobject).

- Fix incorrect handling of error results from copy_from_user().

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  2 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 60 ++++++++++++++++++++++++++++---
 drivers/hv/dxgkrnl/dxgvmbus.h | 14 ++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 68 ++++++++++++++++++++++++++++-------
 4 files changed, 127 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index cb533d5fe797..e1c718e7b8eb 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -846,6 +846,8 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
 			  void *command,
 			  u32 cmd_size);
+int dxgvmb_send_share_object_with_host(struct dxgprocess *process,
+				struct d3dkmt_shareobjectwithhost *args);
 
 void signal_host_cpu_event(struct dxghostevent *eventhdr);
 int ntstatus2int(struct ntstatus status);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index b474c63df653..8ad290b2b482 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -863,6 +863,50 @@ int dxgvmb_send_destroy_sync_object(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_share_object_with_host(struct dxgprocess *process,
+				struct d3dkmt_shareobjectwithhost *args)
+{
+	struct dxgkvmb_command_shareobjectwithhost *command;
+	struct dxgkvmb_command_shareobjectwithhost_return result = {};
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	command_vm_to_host_init2(&command->hdr,
+				 DXGK_VMBCOMMAND_SHAREOBJECTWITHHOST,
+				 process->host_handle);
+	command->device_handle = args->device_handle;
+	command->object_handle = args->object_handle;
+
+	ret = dxgvmb_send_sync_msg(dxgglobal_get_dxgvmbuschannel(),
+				   msg.hdr, msg.size, &result, sizeof(result));
+
+	dxgglobal_release_channel_lock();
+
+	if (ret || !NT_SUCCESS(result.status)) {
+		if (ret == 0)
+			ret = ntstatus2int(result.status);
+		pr_err("DXGK_VMBCOMMAND_SHAREOBJECTWITHHOST failed: %d %x",
+			ret, result.status.v);
+		goto cleanup;
+	}
+	args->object_vail_nt_handle = result.vail_nt_handle;
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 /*
  * Virtual GPU messages to the host
  */
@@ -2263,37 +2307,43 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 
 	ret = copy_to_user(&inargs->queue, &command->hwqueue,
 			   sizeof(struct d3dkmthandle));
-	if (ret < 0) {
+	if (ret) {
 		pr_err("%s failed to copy hwqueue handle", __func__);
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence,
 			   &command->hwqueue_progress_fence,
 			   sizeof(struct d3dkmthandle));
-	if (ret < 0) {
+	if (ret) {
 		pr_err("%s failed to progress fence", __func__);
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence_cpu_va,
 			   &hwqueue->progress_fence_mapped_address,
 			   sizeof(inargs->queue_progress_fence_cpu_va));
-	if (ret < 0) {
+	if (ret) {
 		pr_err("%s failed to copy fence cpu va", __func__);
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence_gpu_va,
 			   &command->hwqueue_progress_fence_gpuva,
 			   sizeof(u64));
-	if (ret < 0) {
+	if (ret) {
 		pr_err("%s failed to copy fence gpu va", __func__);
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	if (args->priv_drv_data_size) {
 		ret = copy_to_user(args->priv_drv_data,
 				   command->priv_drv_data,
 				   args->priv_drv_data_size);
-		if (ret < 0)
+		if (ret) {
 			pr_err("%s failed to copy private data", __func__);
+			ret = -EINVAL;
+		}
 	}
 
 cleanup:
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 5b455618a2a2..b1434742fa80 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -63,6 +63,7 @@ enum dxgkvmb_commandtype_global {
 	DXGK_VMBCOMMAND_QUERYETWSESSION		= 1009,
 	DXGK_VMBCOMMAND_SETIOSPACEREGION	= 1010,
 	DXGK_VMBCOMMAND_COMPLETETRANSACTION	= 1011,
+	DXGK_VMBCOMMAND_SHAREOBJECTWITHHOST	= 1021,
 	DXGK_VMBCOMMAND_INVALID_VM_TO_HOST
 };
 
@@ -848,6 +849,19 @@ struct dxgkvmb_command_getdevicestate_return {
 	struct ntstatus			status;
 };
 
+struct dxgkvmb_command_shareobjectwithhost {
+	struct dxgkvmb_command_vm_to_host hdr;
+	struct d3dkmthandle	device_handle;
+	struct d3dkmthandle	object_handle;
+	u64			reserved;
+};
+
+struct dxgkvmb_command_shareobjectwithhost_return {
+	struct ntstatus	status;
+	u32		alignment;
+	u64		vail_nt_handle;
+};
+
 int
 dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
 		     void *command, u32 command_size, void *result,
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 38d28d1792df..71ba7b75c60f 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1088,8 +1088,9 @@ dxgk_create_paging_queue(struct dxgprocess *process, void *__user inargs)
 		host_handle = args.paging_queue;
 
 		ret = copy_to_user(inargs, &args, sizeof(args));
-		if (ret < 0) {
+		if (ret) {
 			pr_err("%s failed to copy input args", __func__);
+			ret = -EINVAL;
 			goto cleanup;
 		}
 
@@ -2494,8 +2495,9 @@ dxgk_open_sync_object_nt(struct dxgprocess *process, void *__user inargs)
 		goto cleanup;
 
 	ret = copy_to_user(inargs, &args, sizeof(args));
-	if (ret >= 0)
+	if (ret == 0)
 		goto success;
+	ret = -EINVAL;
 	pr_err("%s failed to copy output args", __func__);
 
 cleanup:
@@ -3405,8 +3407,10 @@ dxgk_share_objects(struct dxgprocess *process, void *__user inargs)
 	tmp = (u64) object_fd;
 
 	ret = copy_to_user(args.shared_handle, &tmp, sizeof(u64));
-	if (ret < 0)
+	if (ret) {
 		pr_err("%s failed to copy shared handle", __func__);
+		ret = -EINVAL;
+	}
 
 cleanup:
 	if (ret < 0) {
@@ -3436,8 +3440,6 @@ dxgk_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
 	struct dxgsharedresource *shared_resource = NULL;
 	struct file *file = NULL;
 
-	pr_debug("ioctl: %s", __func__);
-
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		pr_err("%s failed to copy input args", __func__);
@@ -3492,8 +3494,10 @@ dxgk_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
 	    shared_resource->alloc_private_data_size;
 
 	ret = copy_to_user(inargs, &args, sizeof(args));
-	if (ret < 0)
+	if (ret) {
 		pr_err("%s failed to copy output args", __func__);
+		ret = -EINVAL;
+	}
 
 cleanup:
 
@@ -3554,8 +3558,9 @@ assign_resource_handles(struct dxgprocess *process,
 		ret = copy_to_user(&args->open_alloc_info[i],
 				   &open_alloc_info,
 				   sizeof(open_alloc_info));
-		if (ret < 0) {
+		if (ret) {
 			pr_err("%s failed to copy alloc info", __func__);
+			ret = -EINVAL;
 			goto cleanup;
 		}
 	}
@@ -3705,8 +3710,9 @@ open_resource(struct dxgprocess *process,
 		ret = copy_to_user(args->private_runtime_data,
 				shared_resource->runtime_private_data,
 				shared_resource->runtime_private_data_size);
-		if (ret < 0) {
+		if (ret) {
 			pr_err("%s failed to copy runtime data", __func__);
+			ret = -EINVAL;
 			goto cleanup;
 		}
 	}
@@ -3715,8 +3721,9 @@ open_resource(struct dxgprocess *process,
 		ret = copy_to_user(args->resource_priv_drv_data,
 				shared_resource->resource_private_data,
 				shared_resource->resource_private_data_size);
-		if (ret < 0) {
+		if (ret) {
 			pr_err("%s failed to copy resource data", __func__);
+			ret = -EINVAL;
 			goto cleanup;
 		}
 	}
@@ -3725,8 +3732,9 @@ open_resource(struct dxgprocess *process,
 		ret = copy_to_user(args->total_priv_drv_data,
 				shared_resource->alloc_private_data,
 				shared_resource->alloc_private_data_size);
-		if (ret < 0) {
+		if (ret) {
 			pr_err("%s failed to copy alloc data", __func__);
+			ret = -EINVAL;
 			goto cleanup;
 		}
 	}
@@ -3739,15 +3747,18 @@ open_resource(struct dxgprocess *process,
 
 	ret = copy_to_user(res_out, &resource_handle,
 			   sizeof(struct d3dkmthandle));
-	if (ret < 0) {
+	if (ret) {
 		pr_err("%s failed to copy resource handle to user", __func__);
+		ret = -EINVAL;
 		goto cleanup;
 	}
 
 	ret = copy_to_user(total_driver_data_size_out,
 			   &args->total_priv_drv_data_size, sizeof(u32));
-	if (ret < 0)
+	if (ret) {
 		pr_err("%s failed to copy total driver data size", __func__);
+		ret = -EINVAL;
+	}
 
 cleanup:
 
@@ -3809,6 +3820,37 @@ dxgk_open_resource_nt(struct dxgprocess *process,
 	return ret;
 }
 
+static int
+dxgk_share_object_with_host(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_shareobjectwithhost args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_share_object_with_host(process, &args);
+	if (ret) {
+		pr_err("dxgvmb_send_share_object_with_host dailed");
+		goto cleanup;
+	}
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy data to user", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 /*
  * IOCTL processing
  * The driver IOCTLs return
@@ -3929,4 +3971,6 @@ void init_ioctls(void)
 		  LX_DXQUERYRESOURCEINFOFROMNTHANDLE);
 	SET_IOCTL(/*0x42 */ dxgk_open_resource_nt,
 		  LX_DXOPENRESOURCEFROMNTHANDLE);
+	SET_IOCTL(/*0x44 */ dxgk_share_object_with_host,
+		  LX_DXSHAREOBJECTWITHHOST);
 }
-- 
2.35.1

