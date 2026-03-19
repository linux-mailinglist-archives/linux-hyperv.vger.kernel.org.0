Return-Path: <linux-hyperv+bounces-9614-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GGKF5tdvGnLxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9614-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:33:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D42582D234E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92C3330B1568
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667B401A0E;
	Thu, 19 Mar 2026 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgPi6iKA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9F93FF8B6
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951967; cv=none; b=qsFv0E8VEYF31eBzpjLUpSZgzdDzppN4yMmjFo0chyznvsC/DtJT8iEYL8fsMD/kx8fA0yJgcBbMwGABq921f97smfNyvr+kur8dbIMvN5e9AJycwAFRTbRcB8RWo0UkbMcrWNZFJ9vkT7m6tY6tYQo2FFoTEnwRexiEhB/KW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951967; c=relaxed/simple;
	bh=Z4PYI3Irnqgd469D+z9UfdlrSw8gbWCsjEqZiiqnGOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgNy4pVzBkJtcxBoAl5D0kQDe8E6eSu5qYqZPd+uemdPyeLsVIUrNfKoz9pVK0gc3jg9Ohd9bNGkfBgQhFPjQpJwM04xpWqCUtwgavArFh9wE8v6ubpZ3CpoWQ/PatqgvaLgE29XzEkh3nTzPalyEz7yUv+Vqb4sGg2bVL9PKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgPi6iKA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483487335c2so10227545e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951962; x=1774556762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6+n+f//BdkXFe0SxztsrgegLDZqmvdOMqnM0EvvH8Y=;
        b=YgPi6iKAAyEd6ZDihlMD8u7aPvOmJpI/t/EbvwSc0/YaNsSisFnEL8ZoZt8DMRI3Xv
         LDhV5wvYHKfsdv+u/0CNdEL8LylPPxP7Meb/GRtMonr9XS8v7R5B+SyBLAu/P/9v0zhv
         zHja+uDJgWlYpTkq6ItJB/K3ky3nKLtmXzRL5Wzcuu0VaKvb2KhwPx6cqCAZ/yZJQBNE
         5mrYzb0KN9EKyDHtK5Wv596Dg9SSuDHkSB4+owMt1m3kVVYxpesaEUxV7FjXBV58NYHM
         Gi5rTyMWMq/6ygCBNPShwbvdvIkMhLGRZaL2HdRNW+Nkk0Cd9kbUnlbAmdItjteTXTrD
         DW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951962; x=1774556762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6+n+f//BdkXFe0SxztsrgegLDZqmvdOMqnM0EvvH8Y=;
        b=O9t2CKJvGDFEE8KBk6rBIUGPGy0vHvVOMwLrbliFfaa07w0BxLjALOxHp0x0As7ie6
         ODvASYcwHO+Yol8BoMKIQfA8y5x5TpBNorq0dEOQ4JExO/rdU/gJhkZJmmb2QLnMcey0
         cpfrK2kUvGZh0hgc2TluwDQLKjpsAVPEJAMdhxyXT/9LsO6BJr5f7gJVp2hkuFgijjdW
         lDsA71eDEw7UgqattxQc2A11pmo8txKfI44VQltn+oaL1qARRUjo9ODHfpOIF+fz2jxE
         UTm1FUbb1DAwRZHjz1OhggXO4fTeeeaTu1ire0o70t8sgzxyhYIbCTKQ3L+sV7DPTup3
         2JBg==
X-Gm-Message-State: AOJu0YziWyeytbLw/fWpKTy4Ng6UvQ1Wvcwna/44RtRrVw2sXeuQnTz9
	HMowL3pElCDcuIdEitKfMmtQFFRE5PXyZ9uQ2QhfkdWX+oMjY0wv3gWE7xQGhqZiCo8=
X-Gm-Gg: ATEYQzziNeBphxaZgpkCpZnZdl637ecF+DlGWiY8xdrE38TC1UkBll5bSfxkTIg3dT+
	5qzjYgdM0KD2ky3JqguBavyQvyPsQwa/KE/z9hJ9EYyn9c8ShC/jmEpHxFTpHoCDFzmv/x8YZXr
	S26e0MeLF57t7+wPREqCIB5ZvYGroX8u7cBW3i/8pNjlYL/UvvAfFf4J2+CR0bwMWBXHxueu9C4
	oVPHTI9NF+3NX5AMoWBptEfPlja5feFkknxZ8glNmqM1U0X4ALW3fKG17VktrFvB+2xnF8fLUHA
	OI3Unejoci/gzoFSF+uNth9ez2ca7pC4r7v2QhaQDzh0eVrYHI0vsdVeHt5HOop77z9Ay2QEzfB
	WnA4VCnesSkfW42cYEwayk4qa7i4rxB0Z2w9IB2EXLupAM5bJNFMl2Q/Qa/ivpRnbqRgo1RAbKr
	dwy2H0ywJNEbqS7WF/X+92qO2UbdGV2torj2rBOsLIj/KfDSje
X-Received: by 2002:a05:600c:348c:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-486fee1af1cmr6282575e9.25.1773951961862;
        Thu, 19 Mar 2026 13:26:01 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:01 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 43/55] drivers: hv: dxgkrnl: Implement D3DDKMTIsFeatureEnabled API
Date: Thu, 19 Mar 2026 20:24:57 +0000
Message-ID: <20260319202509.63802-44-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9614-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: D42582D234E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

D3DKMTIsFeatureEnabled is used to query if a particular feature is
supported by the given adapter.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  2 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 58 ++++++++++++++++++++++++++++++++---
 drivers/hv/dxgkrnl/dxgvmbus.h | 31 +++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 46 +++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  | 31 ++++++++++++++++++-
 5 files changed, 163 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 90bcd5377744..ebf81cffa289 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -994,6 +994,8 @@ int dxgvmb_send_share_object_with_host(struct dxgprocess *process,
 int dxgvmb_send_invalidate_cache(struct dxgprocess *process,
 				struct dxgadapter *adapter,
 				struct d3dkmt_invalidatecache *args);
+int dxgvmb_send_is_feature_enabled(struct dxgadapter *adapter,
+				   struct d3dkmt_isfeatureenabled *args);
 
 void signal_host_cpu_event(struct dxghostevent *eventhdr);
 int ntstatus2int(struct ntstatus status);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 916ed9071656..2436e1a7bc73 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -135,15 +135,16 @@ static int init_message_res(struct dxgvmbusmsgres *msg,
 	if (use_ext_header) {
 		msg->msg = (char *)&msg->hdr[1];
 		msg->hdr->command_offset = sizeof(msg->hdr[0]);
-		msg->hdr->vgpu_luid = adapter->host_vgpu_luid;
+		if (adapter)
+			msg->hdr->vgpu_luid = adapter->host_vgpu_luid;
 	} else {
 		msg->msg = (char *)msg->hdr;
 	}
 	msg->res = (char *)msg->hdr + msg->size;
-	if (dxgglobal->async_msg_enabled)
-		msg->channel = &dxgglobal->channel;
-	else
+	if (adapter && !dxgglobal->async_msg_enabled)
 		msg->channel = &adapter->channel;
+	else
+		msg->channel = &dxgglobal->channel;
 	return 0;
 }
 
@@ -2049,6 +2050,55 @@ int dxgvmb_send_invalidate_cache(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_is_feature_enabled(struct dxgadapter *adapter,
+				   struct d3dkmt_isfeatureenabled *args)
+{
+	int ret;
+	struct dxgkvmb_command_isfeatureenabled_return *result;
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+	int res_size = sizeof(*result);
+
+	if (adapter) {
+		struct dxgkvmb_command_isfeatureenabled *command;
+
+		ret = init_message_res(&msg, adapter, sizeof(*command),
+					res_size);
+		if (ret)
+			goto cleanup;
+		command = (void *)msg.msg;
+		command->feature_id = args->feature_id;
+		result = msg.res;
+		command_vgpu_to_host_init1(&command->hdr,
+					   DXGK_VMBCOMMAND_ISFEATUREENABLED);
+	} else {
+		struct dxgkvmb_command_isfeatureenabled_gbl *command;
+
+		ret = init_message_res(&msg, adapter, sizeof(*command),
+					res_size);
+		if (ret)
+			goto cleanup;
+		command = (void *)msg.msg;
+		command->feature_id = args->feature_id;
+		result = msg.res;
+		command_vm_to_host_init1(&command->hdr,
+				DXGK_VMBCOMMAND_ISFEATUREENABLED_GLOBAL);
+	}
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, res_size);
+	if (ret == 0) {
+		ret = ntstatus2int(result->status);
+		if (ret == 0)
+			args->result = result->result;
+		goto cleanup;
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				      struct dxgadapter *adapter,
 				      struct d3dkmt_queryallocationresidency
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 20c562b485de..a7e625b2f896 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -48,6 +48,7 @@ enum dxgkvmb_commandtype_global {
 	DXGK_VMBCOMMAND_SETIOSPACEREGION	= 1010,
 	DXGK_VMBCOMMAND_COMPLETETRANSACTION	= 1011,
 	DXGK_VMBCOMMAND_SHAREOBJECTWITHHOST	= 1021,
+	DXGK_VMBCOMMAND_ISFEATUREENABLED_GLOBAL	= 1022,
 	DXGK_VMBCOMMAND_INVALID_VM_TO_HOST
 };
 
@@ -126,6 +127,7 @@ enum dxgkvmb_commandtype {
 	DXGK_VMBCOMMAND_LOGEVENT		= 65,
 	DXGK_VMBCOMMAND_SETEXISTINGSYSMEMPAGES	= 66,
 	DXGK_VMBCOMMAND_INVALIDATECACHE		= 67,
+	DXGK_VMBCOMMAND_ISFEATUREENABLED	= 68,
 	DXGK_VMBCOMMAND_INVALID
 };
 
@@ -871,6 +873,35 @@ struct dxgkvmb_command_shareobjectwithhost_return {
 	u64		vail_nt_handle;
 };
 
+struct dxgk_feature_desc {
+	u16 min_supported_version;
+	u16 max_supported_version;
+	struct {
+		u16 supported		: 1;
+		u16 virtualization_mode : 3;
+		u16 global 		: 1;
+		u16 driver_feature	: 1;
+		u16 internal		: 1;
+		u16 reserved		: 9;
+	};
+};
+
+struct  dxgkvmb_command_isfeatureenabled {
+	struct dxgkvmb_command_vgpu_to_host	hdr;
+	enum dxgk_feature_id			feature_id;
+};
+
+struct  dxgkvmb_command_isfeatureenabled_gbl {
+	struct dxgkvmb_command_vm_to_host	hdr;
+	enum dxgk_feature_id			feature_id;
+};
+
+struct dxgkvmb_command_isfeatureenabled_return {
+	struct ntstatus				status;
+	struct dxgk_feature_desc		descriptor;
+	struct dxgk_isfeatureenabled_result	result;
+};
+
 int
 dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
 		     void *command, u32 command_size, void *result,
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 24b84be2fb73..5ff4b27af19d 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -5318,6 +5318,51 @@ dxgkio_enum_processes(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_is_feature_enabled(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_isfeatureenabled args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgglobal *dxgglobal = dxggbl();
+	struct d3dkmt_isfeatureenabled *__user uargs = inargs;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (adapter) {
+		ret = dxgadapter_acquire_lock_shared(adapter);
+		if (ret < 0)
+			goto cleanup;
+	}
+
+	ret = dxgvmb_send_is_feature_enabled(adapter, &args);
+	if (ret)
+		goto cleanup;
+
+	ret = copy_to_user(&uargs->result, &args.result, sizeof(args.result));
+
+cleanup:
+
+	if (adapter) {
+		dxgadapter_release_lock_shared(adapter);
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	}
+
+	DXG_TRACE_IOCTL_END(ret);
+	return ret;
+}
+
 static struct ioctl_desc ioctls[] = {
 /* 0x00 */	{},
 /* 0x01 */	{dxgkio_open_adapter_from_luid, LX_DXOPENADAPTERFROMLUID},
@@ -5406,6 +5451,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x47 */	{dxgkio_open_syncobj_from_syncfile,
 		 LX_DXOPENSYNCOBJECTFROMSYNCFILE},
 /* 0x48 */	{dxgkio_enum_processes, LX_DXENUMPROCESSES},
+/* 0x49 */	{dxgkio_is_feature_enabled, LX_ISFEATUREENABLED},
 };
 
 /*
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index f9f817060fa9..5b345ddaf66e 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -1580,7 +1580,7 @@ struct d3dkmt_opensyncobjectfromsyncfile {
 	__u64			fence_value_gpu_va;	/* out */
 };
 
- struct d3dkmt_enumprocesses {
+struct d3dkmt_enumprocesses {
 	struct winluid 		adapter_luid;
 #ifdef __KERNEL__
 	__u32			*buffer;
@@ -1590,6 +1590,33 @@ struct d3dkmt_opensyncobjectfromsyncfile {
 	__u64			buffer_count;
 };
 
+enum dxgk_feature_id {
+	_DXGK_FEATURE_HWSCH				= 0,
+	_DXGK_FEATURE_PAGE_BASED_MEMORY_MANAGER		= 32,
+	_DXGK_FEATURE_KERNEL_MODE_TESTING		= 33,
+	_DXGK_FEATURE_MAX
+};
+
+struct dxgk_isfeatureenabled_result {
+	__u16	version;
+	union {
+		struct {
+			__u16 enabled			:  1;
+			__u16 known_feature		:  1;
+			__u16 supported_by_driver	:  1;
+			__u16 supported_on_config	:  1;
+			__u16 reserved			: 12;
+		};
+		__u16 value;
+	};
+};
+
+struct d3dkmt_isfeatureenabled {
+	struct d3dkmthandle			adapter;
+	enum dxgk_feature_id			feature_id;
+	struct dxgk_isfeatureenabled_result	result;
+};
+
 struct d3dkmt_invalidatecache {
 	struct d3dkmthandle	device;
 	struct d3dkmthandle	allocation;
@@ -1730,5 +1757,7 @@ struct d3dkmt_invalidatecache {
 	_IOWR(0x47, 0x47, struct d3dkmt_opensyncobjectfromsyncfile)
 #define LX_DXENUMPROCESSES	\
 	_IOWR(0x47, 0x48, struct d3dkmt_enumprocesses)
+#define LX_ISFEATUREENABLED	\
+	_IOWR(0x47, 0x49, struct d3dkmt_isfeatureenabled)
 
 #endif /* _D3DKMTHK_H */

