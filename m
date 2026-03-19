Return-Path: <linux-hyperv+bounces-9593-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCNOJv5cvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9593-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:30:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DAA2D2293
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C599325D5DF
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D873FAE19;
	Thu, 19 Mar 2026 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPsAoz0A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DBB3FA5F7
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951943; cv=none; b=pLORILVAkALgwnEdiSM27Cv3ViSiH0ep1ZE2vMrDiAx0J+pt1OJNJpOKl42XFnSCJq28bRvA7KXbryNdfimyzIJpUoNwa4t8UWeaHWsAWH71u/CgKV+KMBSyOT1bUQXMlZShjSfMFhk8QmgMy/y9JoCu/JwiqaaxB/8ORoA4Io0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951943; c=relaxed/simple;
	bh=S8QKX0NZSQwSO6HdzqOHD5S8SMoE062+vSMVmXGkj2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RacmSZ0rsG08lBbzZ93USSlBG41hHdPddz3EUb1aV+WOTnPAQSYiA826ADGs/HVAi20dNic1GlXm7mjmTnFXe8hawpA1bvcZ2yrfbe+2USXixCGJUUlp/vAmrTMl+KZuu33KMfkT5yVrBiCWQtSxtPdKZrkjf3AhheWPdtDFLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPsAoz0A; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so1323897f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951938; x=1774556738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrH2a5k/EhZDhIUyy4Q/uQ6n7kgRZKjSjI2+9Ckr7IY=;
        b=IPsAoz0AVJrPIESWw78xjrgdsEUq+Ch0E9HQAnupYtWJzSeL5HmXdmSBs6BbKUHR2w
         +Y9Bh9WEpkXlpA1Ot3RcMyYOQt49ulAbs4rufJ4QcQ1WA1YPev2YEzqWoBxw/c5/E7gi
         ZMD39FPb3r4wRIUoQFUti197OU6wEbUZFZ6hRrec1ju/QhdQ12LRlSsHea+iORAdhXxW
         ILkxL2meMWzWHNhwcOn8Au2sGxgEKSNYEoC9x4XIOlAy33ZcoacnQ8iYX8gCtGsZ5gT0
         GReYFGStdcJtuq6PuEesnDB1Zj5WnTLypmcvxxE461B/g76oLK0BdQuk/ZUyH+p5nZoK
         +jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951938; x=1774556738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qrH2a5k/EhZDhIUyy4Q/uQ6n7kgRZKjSjI2+9Ckr7IY=;
        b=jRu7viRQH4jz1Q/Eck5z+HWrM0+uuPbOEOY1/TmwkUgESYYiDMaFY1jK/iCKJvxosT
         lDh4J9qi+TbDL976hlpW3mGiQCFCXJRGSv7zDotZIbHs9PYzCHFfiSPNg+nAQ5G8lk23
         yYHAUI41hIvAKqdjhcSc3/4teubTtUtx3ex0Rzt3AsCPlr/o2yndPlcMe72qrt3zJOrp
         5LwVeH2qDvXs2tW9nP0dFkeg3nssRDHHPl3EFcyC71or1E/dBMbpFlFYNybHMapL8ACL
         p1IJjPjgw+A9lpga7oFHuAS70F4FDfm2Cwc7Ty3fl8dow7XWSp/srcUgFQxOrFuH9TXi
         7I/Q==
X-Gm-Message-State: AOJu0YyOQipDNouo3SUGjoeOq8whuSVu6E8TNsxIwC6n76c1Uc/Kw8QO
	aAhhW2kJIHc9tWQ2G2G9HyM1rwXvmWlH5BheTczT+vRxBwiSRxeXBiC6cpmPYIngS7E=
X-Gm-Gg: ATEYQzwbRGUL4KDsaK5uEHW3CADWSEq88pMSuo2jNiHQdQwGlNFVau7m5piF1Vm2Ery
	o1fTawGKDtYS8XM71ba65NHR13F1by3rM5uNN0rSIoCTl565CUuJ3lcssQiLhaRZBBNcMyaA5JO
	kWfhGwQ+33CKNkqW78h9JSbJzL3zQ3eEROlI9vi9nl7lryvDRdCG3uunbTrtchQxC0/HmgZ9GYJ
	GRX/HidmzreO56AlJysl1U9l6jpis+0qMAQQiTdC2VU8Z+z8G/xu8XtC4NKT71tLQj3mmioDZBo
	eq5VDgEbUCbm3wEhuJPZwQAgDb0dgCiArO25yzv0GZws8WMA7W9pzczTWudHQc6rnHhnWmEset2
	iocZvY5RvUzwhsgj+/20NgD9oWENYO/kYfm5Gv71Y6nZgkyqcCvGIelrWNwhhJXf/3CGLoPp3xq
	eUadUQPlox5kUkhO7EvQim+a8E5WpIs+4DPxLygDASFVTr1iyg
X-Received: by 2002:a05:6000:2089:b0:43b:5356:a7fc with SMTP id ffacd0b85a97d-43b6428b374mr1145476f8f.55.1773951937820;
        Thu, 19 Mar 2026 13:25:37 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:37 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 21/55] drivers: hv: dxgkrnl: The escape ioctl
Date: Thu, 19 Mar 2026 20:24:35 +0000
Message-ID: <20260319202509.63802-22-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9593-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 37DAA2D2293
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement the escape ioctl (LX_DXESCAPE).

This ioctl is used to send/receive private data between user mode
compute device driver (guest) and kernel mode compute device
driver (host). It allows the user mode driver to extend the virtual
compute device API.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  3 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 75 ++++++++++++++++++++++++++++++++---
 drivers/hv/dxgkrnl/dxgvmbus.h | 12 ++++++
 drivers/hv/dxgkrnl/ioctl.c    | 42 +++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h  | 41 +++++++++++++++++++
 5 files changed, 167 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index b6a7288a4177..dafc721ed6cf 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -894,6 +894,9 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
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
index 48ff49456057..8bdd49bc7aa6 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1925,6 +1925,70 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
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
+			DXG_ERR("failed to copy priv data");
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
+			DXG_ERR("failed to copy priv data");
+			ret = -EINVAL;
+		}
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 				  struct dxgadapter *adapter,
 				  struct d3dkmt_queryvideomemoryinfo *args,
@@ -1955,14 +2019,14 @@ int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 	ret = copy_to_user(&output->budget, &result.budget,
 			   sizeof(output->budget));
 	if (ret) {
-		pr_err("%s failed to copy budget", __func__);
+		DXG_ERR("failed to copy budget");
 		ret = -EINVAL;
 		goto cleanup;
 	}
 	ret = copy_to_user(&output->current_usage, &result.current_usage,
 			   sizeof(output->current_usage));
 	if (ret) {
-		pr_err("%s failed to copy current usage", __func__);
+		DXG_ERR("failed to copy current usage");
 		ret = -EINVAL;
 		goto cleanup;
 	}
@@ -1970,7 +2034,7 @@ int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 			   &result.current_reservation,
 			   sizeof(output->current_reservation));
 	if (ret) {
-		pr_err("%s failed to copy reservation", __func__);
+		DXG_ERR("failed to copy reservation");
 		ret = -EINVAL;
 		goto cleanup;
 	}
@@ -1978,14 +2042,14 @@ int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 			   &result.available_for_reservation,
 			   sizeof(output->available_for_reservation));
 	if (ret) {
-		pr_err("%s failed to copy avail reservation", __func__);
+		DXG_ERR("failed to copy avail reservation");
 		ret = -EINVAL;
 	}
 
 cleanup:
 	free_message(&msg, process);
 	if (ret)
-		dev_dbg(DXGDEV, "err: %d", ret);
+		DXG_TRACE("err: %d", ret);
 	return ret;
 }
 
@@ -3152,3 +3216,4 @@ int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 		DXG_TRACE("err: %d", ret);
 	return ret;
 }
+
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index a1549983d50f..e1c2ed7b1580 100644
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
index e692b127e219..78de76abce2d 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3547,6 +3547,46 @@ dxgkio_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_escape(struct dxgprocess *process, void *__user inargs)
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static int
 dxgkio_query_vidmem_info(struct dxgprocess *process, void *__user inargs)
 {
@@ -4338,7 +4378,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x0a */	{dxgkio_query_vidmem_info, LX_DXQUERYVIDEOMEMORYINFO},
 /* 0x0b */	{},
 /* 0x0c */	{},
-/* 0x0d */	{},
+/* 0x0d */	{dxgkio_escape, LX_DXESCAPE},
 /* 0x0e */	{dxgkio_get_device_state, LX_DXGETDEVICESTATE},
 /* 0x0f */	{dxgkio_submit_command, LX_DXSUBMITCOMMAND},
 /* 0x10 */	{dxgkio_create_sync_object, LX_DXCREATESYNCHRONIZATIONOBJECT},
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index b7d8b1d91cfc..749edf28bd43 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -236,6 +236,45 @@ struct d3dddi_destroypagingqueue {
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
@@ -1217,6 +1256,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXQUERYVIDEOMEMORYINFO	\
 	_IOWR(0x47, 0x0a, struct d3dkmt_queryvideomemoryinfo)
+#define LX_DXESCAPE			\
+	_IOWR(0x47, 0x0d, struct d3dkmt_escape)
 #define LX_DXGETDEVICESTATE		\
 	_IOWR(0x47, 0x0e, struct d3dkmt_getdevicestate)
 #define LX_DXSUBMITCOMMAND		\

