Return-Path: <linux-hyperv+bounces-9586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4XafJwFcvGmCxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9586-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:26:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E8E2D2141
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D315A303C595
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1AD3F9F4D;
	Thu, 19 Mar 2026 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjJlVyHo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583223F9F29
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951935; cv=none; b=kkT4k8LJw3r+6cxXxPSxelWFGHCpeims6MVJREy2ZuAuDASkAxvAbpzp4Dpuo9Uy+/44Dyr1W1AncftD3aP0ydHv4v3EQPgPDZUSSgEhg8P1aXfEREiljBAInitmsIK/iDQyWsZbCaN/guSrfc4DVB2o6zlGgwjP2YpzDo/BRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951935; c=relaxed/simple;
	bh=TMxyYWgJby8NjV+ACi3/fTP8NXqHjx5+hMYaldGQVB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0FM2OUCCXtPaFZGb2E+xt3aLRMLZ7bpkziZZAhP3YRhIWdGt26O1GyE6NLrMSDcwaHS+oFB54gkH8SWBRcVPLeAMa8jBFFWMlIuRclXi2tkFh2SjitRvFksx+2P11hCZXkKRWad0pCpESL/YSA++zv8yud2wkKZrI0tl2GmfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjJlVyHo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439d8df7620so784459f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951930; x=1774556730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JDaklel034pI9Ckf4R38N/JQ5KooPNwXq3IvAAseYE=;
        b=mjJlVyHo7q6ogQFhGLW+051Y3SH33mEAEmCPUNJ/yO84B6Jo0FJFg9Axh4C48bODis
         Yp0Lk8bTxANfm1K3gC5yv2cKLkSuUkue82LvjgkjMCAI5CwOah4v3vUJU/0QG1JeEPhd
         tLuERuqSZXVefdgoWnUO5GlX12ySGP7tyvgUCcXxO64YjO8o2/C0UekBnDXq31rpPvbm
         h5wy+aIPWIPHz6Xq8ogGYGxlFj3B8dXkd8+cCa4m9Yt+ElIG5tbqJ6ubpZu6FQVsvZTf
         WCagpphjPJ9LWrYJRRCMpUAMW+jNe7C35P4KsHmwRIbgNUajeJ6xAFzXmIaH+4/dsg1U
         RD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951930; x=1774556730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4JDaklel034pI9Ckf4R38N/JQ5KooPNwXq3IvAAseYE=;
        b=O7Gq9ThSB5osYwvsqJZJAG1hC2aFpaJzdnaSLRey0Ssw9r74VKC2yb0WLKH95g0ZrG
         rc4FEfvgeuT1o/n1mLAy/djl/y1679g0UwXK8K7DtTdHlMt1DbYkzwQO6rnb1EO+Dfuv
         NaokA1Fr6XmtNSXERiiroChpJWGo/eYuulCqCQakY+IhfWYS8HJwMdymWDZ3gcwmHfCY
         UnkHchZp8ph88fQcKkvoin7mx8hSqRQeUtci3KRIkZaRuwcyixCR6yuXtDp3gAQUhPFC
         pCE49u5ZESJKsrofk/7E2xk5QSBIJHJ68iSwGh3192eRCh3xpQt63jyB3/IRWpCjTMlj
         kM3g==
X-Gm-Message-State: AOJu0YycM/tIIhU51MYo1iida+7wFF44Np8FwFXiCXAWCj0/JzmAx8YT
	RH7QGP7Tq9e3CPQcG+XG1fSyPw+OjBeXdIYxcpQfXPh+yyGp7ZiLet63aNOmOvI7evY=
X-Gm-Gg: ATEYQzyq4jiPiguXoyejWKxBV05BQd/6OPUOtC4M3e31vb2HukkTx6qf/ZQloRgigTF
	Oqd1UOMcPZ7YFXaGebsxut0w5Sn21pqPDv9ztooGnC+VNZl6b+iOekIHf8SKjMvZlsm/jngwsQX
	XDAX9H5PIOLoCDr6ob5Xnf9yDojPMSCRh0IT7CuhfgC1siH99gMIGytEYahwWsz3wtQRm+w+KOk
	F52CHfJV+sY+AtQZpBmKFl4fpiLmGGva9Jtcxfd/dMEPh01ijnzwHe73TXPjRBb4xlR8L9KjIYU
	wsfmzFQAJA5Zx4Sdo1x1KVS0InOfKn/oYi5iv0Dq60Uc6trbRJngKgHv8P1zBaW2t+EEphRM6qb
	WUHTCBnakKKIeSvV+n6FCJXe0nhQrIdtlKpreU2x3Wjmj/DgsKCqus6XKy7bP4P3UEFwRZdz5dk
	XGaSPo/oRShTBOsihr7ZsqC+dg913vKXjCoBDbgHpg2wCg6S5y
X-Received: by 2002:a05:6000:40c7:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-43b6424f867mr1132863f8f.23.1773951930328;
        Thu, 19 Mar 2026 13:25:30 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:29 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 14/55] drivers: hv: dxgkrnl: Submit execution commands to the compute device
Date: Thu, 19 Mar 2026 20:24:28 +0000
Message-ID: <20260319202509.63802-15-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9586-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.979];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: 32E8E2D2141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

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
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   6 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 113 ++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  14 ++++
 drivers/hv/dxgkrnl/ioctl.c    | 127 +++++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h  |  58 ++++++++++++++++
 5 files changed, 316 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 440d1f9b8882..ab97bc53b124 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -796,6 +796,9 @@ int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 int dxgvmb_send_destroy_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 				   struct d3dkmt_destroyallocation2 *args,
 				   struct d3dkmthandle *alloc_handles);
+int dxgvmb_send_submit_command(struct dxgprocess *pr,
+			       struct dxgadapter *adapter,
+			       struct d3dkmt_submitcommand *args);
 int dxgvmb_send_create_sync_object(struct dxgprocess *pr,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_createsynchronizationobject2
@@ -838,6 +841,9 @@ int dxgvmb_send_destroy_hwqueue(struct dxgprocess *process,
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
index c9c00b288ae0..7cb04fec217e 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1901,6 +1901,61 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
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
+	struct dxgglobal *dxgglobal = dxggbl();
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
+		DXG_ERR(" failed to copy history buffer");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_from_user((u8 *) &command[1] + hbufsize,
+			     args->priv_drv_data, args->priv_drv_data_size);
+	if (ret) {
+		DXG_ERR("failed to copy history priv data");
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
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 static void set_result(struct d3dkmt_createsynchronizationobject2 *args,
 		       u64 fence_gpu_va, u8 *va)
 {
@@ -2427,3 +2482,61 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 		DXG_TRACE("err: %d", ret);
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
+	struct dxgglobal *dxgglobal = dxggbl();
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
+			DXG_ERR("failed to copy primaries handles");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+	if (args->priv_drv_data_size) {
+		ret = copy_from_user((char *)&command[1] + primaries_size,
+				      args->priv_drv_data,
+				      args->priv_drv_data_size);
+		if (ret) {
+			DXG_ERR("failed to copy primaries data");
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
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index aba075d374c9..acfdbde09e82 100644
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
index a2d236f5eff5..9128694c8e78 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1902,6 +1902,129 @@ dxgkio_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_submit_command(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_submitcommand args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.broadcast_context_count > D3DDDI_MAX_BROADCAST_CONTEXT ||
+	    args.broadcast_context_count == 0) {
+		DXG_ERR("invalid number of contexts");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		DXG_ERR("invalid private data size");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.num_history_buffers > 1024) {
+		DXG_ERR("invalid number of history buffers");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.num_primaries > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		DXG_ERR("invalid number of primaries");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_submit_command_to_hwqueue(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_submitcommandtohwqueue args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		DXG_ERR("invalid private data size");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.num_primaries > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		DXG_ERR("invalid number of primaries");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static int
 dxgkio_submit_signal_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 {
@@ -3666,7 +3789,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x0c */	{},
 /* 0x0d */	{},
 /* 0x0e */	{},
-/* 0x0f */	{},
+/* 0x0f */	{dxgkio_submit_command, LX_DXSUBMITCOMMAND},
 /* 0x10 */	{dxgkio_create_sync_object, LX_DXCREATESYNCHRONIZATIONOBJECT},
 /* 0x11 */	{dxgkio_signal_sync_object, LX_DXSIGNALSYNCHRONIZATIONOBJECT},
 /* 0x12 */	{dxgkio_wait_sync_object, LX_DXWAITFORSYNCHRONIZATIONOBJECT},
@@ -3706,7 +3829,7 @@ static struct ioctl_desc ioctls[] = {
 		 LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU},
 /* 0x33 */	{dxgkio_signal_sync_object_gpu2,
 		 LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2},
-/* 0x34 */	{},
+/* 0x34 */	{dxgkio_submit_command_to_hwqueue, LX_DXSUBMITCOMMANDTOHWQUEUE},
 /* 0x35 */	{dxgkio_submit_signal_to_hwqueue,
 		  LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE},
 /* 0x36 */	{dxgkio_submit_wait_to_hwqueue,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 6ec70852de6e..9238115d165d 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -58,6 +58,8 @@ struct winluid {
 	__u32 b;
 };
 
+#define D3DDDI_MAX_WRITTEN_PRIMARIES		16
+
 #define D3DKMT_CREATEALLOCATION_MAX		1024
 #define D3DKMT_ADAPTERS_MAX			64
 #define D3DDDI_MAX_BROADCAST_CONTEXT		64
@@ -525,6 +527,58 @@ struct d3dkmt_destroysynchronizationobject {
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
@@ -917,6 +971,8 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
+#define LX_DXSUBMITCOMMAND		\
+	_IOWR(0x47, 0x0f, struct d3dkmt_submitcommand)
 #define LX_DXCREATESYNCHRONIZATIONOBJECT \
 	_IOWR(0x47, 0x10, struct d3dkmt_createsynchronizationobject2)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECT \
@@ -945,6 +1001,8 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x32, struct d3dkmt_signalsynchronizationobjectfromgpu)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2 \
 	_IOWR(0x47, 0x33, struct d3dkmt_signalsynchronizationobjectfromgpu2)
+#define LX_DXSUBMITCOMMANDTOHWQUEUE	\
+	_IOWR(0x47, 0x34, struct d3dkmt_submitcommandtohwqueue)
 #define LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE \
 	_IOWR(0x47, 0x35, struct d3dkmt_submitsignalsyncobjectstohwqueue)
 #define LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE \

