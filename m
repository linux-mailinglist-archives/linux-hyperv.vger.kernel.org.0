Return-Path: <linux-hyperv+bounces-9587-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJg5NYhcvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9587-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:28:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFA32D2203
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A1023211215
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A8E3FA5D2;
	Thu, 19 Mar 2026 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFiZAwEV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2A3F8E04
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951937; cv=none; b=a5BV4XIC9iPT7Bkkn2y79Ck/pfDD9O/7A7Qnr8tcy013fc/k9jYScJZkNDsADeh8UvlXfiq3I1c3u/sS8RyhPaaozgTKlDXcb2rVnj+DGw1CjdnJpjtKFM8aeTixxNE2tAgQSohwBXL+JCQtLU1r4iGQfAVkx0mJTrys50xQ6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951937; c=relaxed/simple;
	bh=XYXh9hWNCjjaYxIFWsgzSpcYNdUPkATphGgllc+kOiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGW3uLnh40qcZx3avdBCgVHWFbrJfBd0VZ2zQOjQ6kH81/xno15zpzYJenBKHLsusxQlMQ6Nu/eMWxOb9i/UlritDdbHwNl2hRTxw/4Iu0rEvZ2E9mFEFBs1yjEEofNDi1LtjG3Rf72QY/a6ajrcntU6toPjNVW4fWMzYZRubM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFiZAwEV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso10082535e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951931; x=1774556731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfwWxdi0huZ+o5QErDeADcsmeHgqSR0aJcBxkGUgmUc=;
        b=lFiZAwEV2mQH2cRU2fS6EmzCi6rISVLe6QcO7cLDyubLtp1uaUNqR3ZuuGssjsI6vJ
         GyR1stFWt12C8tVR2x6V2AOkge+n/ufNtkqOb8o3AxduGD3Fzx/kTw2P+Svemfl4kn5V
         dDhN7tfMCpzJFc3VLcXAvhw+Li1WRFOD+l+M6Yca43DnNjbsQ8jCCXrWtuQ8ISM349/7
         qTHIHBF15VxmfJdjMeAO8zW8kXUt2hhPeDVm/NDEVBvmJn73w1x3rj5ud2MdGMQcx/Nc
         Tse8cZrYhlpy1GAGW3Xolel6/2OjSYk4IiQU5BuW8AGTJVurCf0qOZPCafEsGcyISZGv
         HYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951931; x=1774556731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IfwWxdi0huZ+o5QErDeADcsmeHgqSR0aJcBxkGUgmUc=;
        b=OwIj/qXWLrcuHRhj2GVFnu/rNhAejWkq/+Ct3hOZkmfaD3QI1ooWobOv3QQMBIws3z
         L42HP0LGS7Tve4LDr3xm0iaz5LOEuL+89MJtYQkgEPZ0AmAmopyPVVuvbxZnG4AA6dJe
         bs3iIEN91qZjS1VPw4URvr+EnWQ0RsA9Q0wWowQgdj0RbGI+gv6OL4m97rzvxNd0JUY4
         ziqDsHleAa1ME1mXz9tONt0jhQT3fHMSwjcpdUzU8/z7BuqlUhYGUeysNr326nrvHo7G
         BhJI8h2YpOUe4pVRNzfhWwD06TynvKU8EG04R0rYAC7fpoUVI7cuU0qZCjPjSTdK93S9
         0q7w==
X-Gm-Message-State: AOJu0YxMiPex/40Q7HPj3ECERX/S4Q1HB1Kzk/2E2f7tAAuMUAlw6CB/
	3vtZVLQvc0cVxchq71+2k3pAjddEdHz7y7x50FKU2EKbyrtJlEMfoFpDJxVkM50hwlo=
X-Gm-Gg: ATEYQzzeFXAQQsp9mmrzzlQqXhqP1XmigQo2MyjX9JONwj5v0HSu8ZxSrJwqcpB5HJu
	+1XOys0gn2l8ZTuLi4QEM3U9zdQz/IWvThF+aAHC+EkHkNpZQD4PtQr1n2enn2PUIkHAuR4DvOM
	U4go0SGSmafQvwalL2E/sTVEjGyr/vMzdRKmgRMDtLZwQEQf14scDxnG+xIK0oSp5Wz9tRKmX8a
	5lm9G39VDEIeqSf135o7V/PB9a5pG7X1TdfL5d2y3pUZYzS7ivcZSlDar7ESKaC/cCk5g3i9jF9
	XC9Bqd2NA3c0dQSJ0HNsqpuRzMpmSRyhGf8znJ6BYP9PC8NXEiPirl/py1EPqBOIHHn2Rsv15ft
	9y1i4hjjGwAsaH21S1zIadZ3pHVqUtdlUrrzUNeRHUcGHQb0Y1dsqZyHSZtq4rZ4k++Wr6GoXCd
	rbshYuLhYvpMJxjaUe999UwsoMwtF/PgCj2xXosX6aS/Necp/M
X-Received: by 2002:a05:6000:2012:b0:43b:3c49:c393 with SMTP id ffacd0b85a97d-43b6424432dmr1211203f8f.18.1773951931428;
        Thu, 19 Mar 2026 13:25:31 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:30 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 15/55] drivers: hv: dxgkrnl: Share objects with the host
Date: Thu, 19 Mar 2026 20:24:29 +0000
Message-ID: <20260319202509.63802-16-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9587-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EFA32D2203
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement the LX_DXSHAREOBJECTWITHHOST ioctl.
This ioctl is used to create a Windows NT handle on the host
for the given shared object (resource or sync object). The NT
handle is returned to the caller. The caller could share the NT
handle with a host application, which needs to access the object.
The host application can open the shared resource using the NT
handle. This way the guest and the host have access to the same
object.

Fix incorrect handling of error results from copy_from_user().

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  2 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 60 ++++++++++++++++++++++++++++++++---
 drivers/hv/dxgkrnl/dxgvmbus.h | 18 +++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 38 ++++++++++++++++++++--
 include/uapi/misc/d3dkmthk.h  |  9 ++++++
 5 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index ab97bc53b124..a39d11d76e41 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -872,6 +872,8 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
 			  void *command,
 			  u32 cmd_size);
+int dxgvmb_send_share_object_with_host(struct dxgprocess *process,
+				struct d3dkmt_shareobjectwithhost *args);
 
 void signal_host_cpu_event(struct dxghostevent *eventhdr);
 int ntstatus2int(struct ntstatus status);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 7cb04fec217e..67a16de622e0 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -881,6 +881,50 @@ int dxgvmb_send_destroy_sync_object(struct dxgprocess *process,
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
+		DXG_ERR("Host failed to share object with host: %d %x",
+			ret, result.status.v);
+		goto cleanup;
+	}
+	args->object_vail_nt_handle = result.vail_nt_handle;
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_ERR("err: %d", ret);
+	return ret;
+}
+
 /*
  * Virtual GPU messages to the host
  */
@@ -2323,37 +2367,43 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 
 	ret = copy_to_user(&inargs->queue, &command->hwqueue,
 			   sizeof(struct d3dkmthandle));
-	if (ret < 0) {
+	if (ret) {
 		DXG_ERR("failed to copy hwqueue handle");
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence,
 			   &command->hwqueue_progress_fence,
 			   sizeof(struct d3dkmthandle));
-	if (ret < 0) {
+	if (ret) {
 		DXG_ERR("failed to progress fence");
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence_cpu_va,
 			   &hwqueue->progress_fence_mapped_address,
 			   sizeof(inargs->queue_progress_fence_cpu_va));
-	if (ret < 0) {
+	if (ret) {
 		DXG_ERR("failed to copy fence cpu va");
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence_gpu_va,
 			   &command->hwqueue_progress_fence_gpuva,
 			   sizeof(u64));
-	if (ret < 0) {
+	if (ret) {
 		DXG_ERR("failed to copy fence gpu va");
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	if (args->priv_drv_data_size) {
 		ret = copy_to_user(args->priv_drv_data,
 				   command->priv_drv_data,
 				   args->priv_drv_data_size);
-		if (ret < 0)
+		if (ret) {
 			DXG_ERR("failed to copy private data");
+			ret = -EINVAL;
+		}
 	}
 
 cleanup:
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index acfdbde09e82..c1f693917d99 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -574,4 +574,22 @@ struct dxgkvmb_command_destroyhwqueue {
 	struct d3dkmthandle		hwqueue;
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
+int
+dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
+		     void *command, u32 command_size, void *result,
+		     u32 result_size);
+
 #endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 9128694c8e78..ac052836ce27 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -2460,6 +2460,7 @@ dxgkio_open_sync_object_nt(struct dxgprocess *process, void *__user inargs)
 	if (ret == 0)
 		goto success;
 	DXG_ERR("failed to copy output args");
+	ret = -EINVAL;
 
 cleanup:
 
@@ -3364,8 +3365,10 @@ dxgkio_share_objects(struct dxgprocess *process, void *__user inargs)
 	tmp = (u64) object_fd;
 
 	ret = copy_to_user(args.shared_handle, &tmp, sizeof(u64));
-	if (ret < 0)
+	if (ret) {
 		DXG_ERR("failed to copy shared handle");
+		ret = -EINVAL;
+	}
 
 cleanup:
 	if (ret < 0) {
@@ -3773,6 +3776,37 @@ dxgkio_open_resource_nt(struct dxgprocess *process,
 	return ret;
 }
 
+static int
+dxgkio_share_object_with_host(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_shareobjectwithhost args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_share_object_with_host(process, &args);
+	if (ret) {
+		DXG_ERR("dxgvmb_send_share_object_with_host dailed");
+		goto cleanup;
+	}
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy data to user");
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static struct ioctl_desc ioctls[] = {
 /* 0x00 */	{},
 /* 0x01 */	{dxgkio_open_adapter_from_luid, LX_DXOPENADAPTERFROMLUID},
@@ -3850,7 +3884,7 @@ static struct ioctl_desc ioctls[] = {
 		 LX_DXQUERYRESOURCEINFOFROMNTHANDLE},
 /* 0x42 */	{dxgkio_open_resource_nt, LX_DXOPENRESOURCEFROMNTHANDLE},
 /* 0x43 */	{},
-/* 0x44 */	{},
+/* 0x44 */	{dxgkio_share_object_with_host, LX_DXSHAREOBJECTWITHHOST},
 /* 0x45 */	{},
 };
 
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 9238115d165d..895861505e6e 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -952,6 +952,13 @@ struct d3dkmt_enumadapters3 {
 #endif
 };
 
+struct d3dkmt_shareobjectwithhost {
+	struct d3dkmthandle	device_handle;
+	struct d3dkmthandle	object_handle;
+	__u64			reserved;
+	__u64			object_vail_nt_handle;
+};
+
 /*
  * Dxgkrnl Graphics Port Driver ioctl definitions
  *
@@ -1021,5 +1028,7 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x41, struct d3dkmt_queryresourceinfofromnthandle)
 #define LX_DXOPENRESOURCEFROMNTHANDLE	\
 	_IOWR(0x47, 0x42, struct d3dkmt_openresourcefromnthandle)
+#define LX_DXSHAREOBJECTWITHHOST	\
+	_IOWR(0x47, 0x44, struct d3dkmt_shareobjectwithhost)
 
 #endif /* _D3DKMTHK_H */

