Return-Path: <linux-hyperv+bounces-9590-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFtTDsRcvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9590-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:29:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD92D224E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF10323DB2F
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F63FADEA;
	Thu, 19 Mar 2026 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlx7kWLW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFD3FA5CE
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951940; cv=none; b=n5hXGoeTA3WGqpuy8/CfaBX1CXV+A+N9fP/bi3c9NKIkQHZVzwWhCdYbCXEP1RJ7wx9r9Q+a2HMGkLeGq4sbhIEElt8x4sGiE4VMWYfiZxTVPoTu4Mx3yjNili8aJpiV1W3trNHYfdSZTkNQ7fsq8u2BAyxXzTBABVjLvbeDL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951940; c=relaxed/simple;
	bh=ZZXM/wQLEF3Dlc1WRi+Ywkz6l4XsJGiFvg+NN8EbAPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2p4b9Xwja1wx+6FZPxrYGzkQVLFxF4xqYUFNw7R3vaW7UZ+x4gxOJGenoHEHnPHdYD47poN+xYUyTJQVMJaZ8uU4QcxLBXrskDilo5Gqj1rPRwGTloWYf+ca2LFqAzxujQAN5IMt4exNUYrExs0Wm9wZs+7jVZGRS2YjUS7/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dlx7kWLW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso1085867f8f.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951936; x=1774556736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+dl+0/EV/hQJnho7KuWFmDHSw/Nz/kLByx2i7vctfo=;
        b=Dlx7kWLWagdirKqW1Z1JhgJuK1VZxHadmH9cOca0JO3OfNzUBL5y4w+1QSS2PDUf56
         jMw21qW7q/x/QDC39CDM/6p/6vDcfnVw0kI7VxchXsPNingow5rXdxbdemMH3+8G0uz+
         Bz5gn51xtPiQ83yVVMlNGB3zx77coqPyZR8fKS/e7+AcG7C2ykSMZCN7WDPl1369KCVv
         NPr+xSoUWSP/aLuHdCpvAsZ+1x7Xb7ZMx61JnBuWj8q6G0i0nfo85gSFHZ3FzbuG5akb
         y7P4H/C2eKhczGPBapKzqowxyoyVRynGSFiyOIno0rLXiADRCg4MdH4BCGnZDxQmzfG2
         uPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951936; x=1774556736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+dl+0/EV/hQJnho7KuWFmDHSw/Nz/kLByx2i7vctfo=;
        b=MpJtaPg2Lwi0NkDhFNKoeSOGCxQ+ELFk/f36134CXhBjMdiB9w3t6EiF3zXMAFPpIo
         2sv3Y+BCsnBH3QmewzAUBp1aeYYUOyfZpuSiBHUe+3Ge1w0y68WOB8sqMZ+BcQmBViNo
         zRFGOsVSfwNK98gO9+98aEshT7PTVcSNAmLyep60dSh6754dwNVtKvZSFWFvXqyr9HQm
         ZKzCVxjtb8qUEBm3cqby7e2DeZBjZX7fjpYfp1y8X5THl6bN+OyOYrg+PVs1L2X0/Oc2
         Ng87935OxdM6eV+Qx+/Y6lJsxu00/ecAxDQd4fUeE26sn+sCRIkpgLeQIwKiGoI3A5/m
         +tqA==
X-Gm-Message-State: AOJu0YwP3fgCysWFVHfnRlmjXRgQMcaXFtE2a0bvXtNvVlSKzV/kK5I5
	+QBp2bWKMQSxiZouAF+sig8TNRSYufK3PISxUvlPn84UGDyRg13d/gkmYf+fcv6dQr8=
X-Gm-Gg: ATEYQzw+KOCWUBQ/KYdrk2qOQ1XbDyOyPAmWz/nP5gdAqX9/zLwVqdqryRQIsHOn3gU
	n3NGjck4t/4fWJanJlvm1ujxNLum88Hr7piPrIjxYAr8MHRvzqzt6ZcmWLDYBBmJVnrIWi1VrMg
	ORSUbC2TaeH6T/XRYv1ZFhboLh1v1yXrX4DhB8QJmlnTFp1KcsBmIxiusyg/gCKUM2eAgg7NJqE
	yOPGy0eU5/T+Sc+E1QnxXMhra5NPnqxvp160nUS4HGeBr4oEF9mCMFLHplIjOF/9PPZX4gTAgba
	2aRqVN8RsGU/rFPJGyF+k7mTxf04mnhKv7EhV5RAYWu2NATszqMowm5q6pLyJ+LQKWVh3yTIKwJ
	jPNYVckF3DlEKTlDBDBFhgDu8rD5Lg/xjl2zN4zmSTIIP9HrBEYxyVDivrTWTtRRf38ABpuSj9/
	IB3npOBGNss4opuBY3bEmRMlpBk1gvBlx4RDT2v34qp9Qje5UX
X-Received: by 2002:a05:6000:420a:b0:43b:498f:dcec with SMTP id ffacd0b85a97d-43b6423287dmr1269710f8f.3.1773951935676;
        Thu, 19 Mar 2026 13:25:35 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:35 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 19/55] drivers: hv: dxgkrnl: Flush heap transitions
Date: Thu, 19 Mar 2026 20:24:33 +0000
Message-ID: <20260319202509.63802-20-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9590-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EAD92D224E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement the ioctl to flush heap transitions
(LX_DXFLUSHHEAPTRANSITIONS).

The ioctl is used to ensure that the video memory manager on the host
flushes all internal operations.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  2 +-
 drivers/hv/dxgkrnl/dxgkrnl.h    |  3 ++
 drivers/hv/dxgkrnl/dxgvmbus.c   | 23 ++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  5 ++++
 drivers/hv/dxgkrnl/ioctl.c      | 49 ++++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h    |  6 ++++
 6 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 23f00db7637e..6f763e326a65 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -942,7 +942,7 @@ else
 	if (alloc->priv_drv_data)
 		vfree(alloc->priv_drv_data);
 	if (alloc->cpu_address_mapped)
-		pr_err("Alloc IO space is mapped: %p", alloc);
+		DXG_ERR("Alloc IO space is mapped: %p", alloc);
 	kfree(alloc);
 }
 
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 7fefe4617488..ced9dd294f5f 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -882,6 +882,9 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
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
index dd2c97fee27b..928fad5f133b 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1829,6 +1829,29 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
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
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				      struct dxgadapter *adapter,
 				      struct d3dkmt_queryallocationresidency
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index dbb01b9ab066..d232eb234e2c 100644
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
index b626e2518ff2..8b7d00e4c881 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3500,6 +3500,53 @@ dxgkio_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs
 	return ret;
 }
 
+static int
+dxgkio_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_flushheaptransitions args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	bool adapter_locked = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
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
+		DXG_ERR("failed to copy output args");
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
 dxgkio_get_device_state(struct dxgprocess *process, void *__user inargs)
 {
@@ -4262,7 +4309,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x1c */	{dxgkio_destroy_paging_queue, LX_DXDESTROYPAGINGQUEUE},
 /* 0x1d */	{dxgkio_destroy_sync_object, LX_DXDESTROYSYNCHRONIZATIONOBJECT},
 /* 0x1e */	{},
-/* 0x1f */	{},
+/* 0x1f */	{dxgkio_flush_heap_transitions, LX_DXFLUSHHEAPTRANSITIONS},
 /* 0x20 */	{},
 /* 0x21 */	{},
 /* 0x22 */	{},
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index af381101fd90..873feb951129 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -936,6 +936,10 @@ struct d3dkmt_queryadapterinfo {
 	__u32				private_data_size;
 };
 
+struct d3dkmt_flushheaptransitions {
+	struct d3dkmthandle	adapter;
+};
+
 struct d3dddi_openallocationinfo2 {
 	struct d3dkmthandle	allocation;
 #ifdef __KERNEL__
@@ -1228,6 +1232,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
 #define LX_DXDESTROYSYNCHRONIZATIONOBJECT \
 	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
+#define LX_DXFLUSHHEAPTRANSITIONS	\
+	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
 #define LX_DXLOCK2			\
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
 #define LX_DXQUERYALLOCATIONRESIDENCY	\

