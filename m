Return-Path: <linux-hyperv+bounces-8745-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHZqLqXkhGlf6QMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8745-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:42:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B0F6876
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5703E300B74E
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA1B3033F2;
	Thu,  5 Feb 2026 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hPeuCzk5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D529301024;
	Thu,  5 Feb 2026 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316947; cv=none; b=JiWue3PDf2KCdAGHfwx+UR1gVjnqxyrpzli/Vd+IrDSxfMmAz0zpIEbfG00tSi7Wi4zo8TzR6924Zl6sgnAjdUKU8L0WFNH2X0xuvZMw6MRPLOYXeeQBMVNARIPDAfC+f4WY8L2cDqVU+391k1XgX9yARfFpnK8Mm8oc8oPUJW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316947; c=relaxed/simple;
	bh=j3VymSjUwlbjMRDRoCRWfZeZ/tb/5/ff0/Xk84qiWDE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVTV/8AEOgwaMiKMjrNGS8r8Uj8o5T8S2AEk/8LXzPleHfHESKSsWxlD2ghT4Gf6Mv+a6H6n87blVOj5g7i6eJkrOloBAMbd5NtOE1QCzZFw45XF+vi3HQG0UJaYGKArJH4/stHyacYLHMQn6PJEkYeN7o7fd/D6v13ASC7g/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hPeuCzk5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6801C20B7168;
	Thu,  5 Feb 2026 10:42:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6801C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770316947;
	bh=/99B8hS5kHjbYQuWu8knQ5wdyX+dO197LrJwzyNDPog=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hPeuCzk5LLA7XeE9+lwVLVAPDWdx1T91xeRBDGUp3SMc7ZZZWc5kFqmZEB9rXZx0H
	 IQceZtKxT1FhlXVeeWLdJL6vcSB73E6pMIDeNSPRwGioTTYGwBRvOQl3wQsCeNB1SX
	 XcRyJ+DMk5284qXNttTT4iqhN2DQ4sewBTNcRuW0=
Subject: [PATCH v3 4/4] mshv: Handle insufficient root memory hypervisor
 statuses
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Feb 2026 18:42:27 +0000
Message-ID: 
 <177031694699.186911.12873334535011325477.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8745-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 5A0B0F6876
X-Rspamd-Action: no action

When creating guest partition objects, the hypervisor may fail to
allocate root partition pages and return an insufficient memory status.
In this case, deposit memory using the root partition ID instead.

Note: This error should never occur in a guest of L1VH partition context.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_common.c      |    2 +
 drivers/hv/hv_proc.c        |   14 ++++++++++
 include/hyperv/hvgdk_mini.h |   58 ++++++++++++++++++++++---------------------
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index f20596276662..6b67ac616789 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -794,6 +794,8 @@ static const struct hv_status_info hv_status_infos[] = {
 	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
 	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
 	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
+	_STATUS_INFO(HV_STATUS_INSUFFICIENT_ROOT_MEMORY,	-ENOMEM),
+	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY,	-ENOMEM),
 	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 181f6d02bce3..5f4fd9c3231c 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -121,6 +121,18 @@ int hv_deposit_memory_node(int node, u64 partition_id,
 	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
 		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
 		break;
+
+	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
+		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
+		fallthrough;
+	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
+		if (!hv_root_partition()) {
+			hv_status_err(hv_status, "Unexpected root memory deposit\n");
+			return -ENOMEM;
+		}
+		partition_id = HV_PARTITION_ID_SELF;
+		break;
+
 	default:
 		hv_status_err(hv_status, "Unexpected!\n");
 		return -ENOMEM;
@@ -134,6 +146,8 @@ bool hv_result_needs_memory(u64 status)
 	switch (hv_result(status)) {
 	case HV_STATUS_INSUFFICIENT_MEMORY:
 	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
+	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
+	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
 		return true;
 	}
 	return false;
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 99ea0d03e657..50f5a1419052 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -14,34 +14,36 @@ struct hv_u128 {
 } __packed;
 
 /* NOTE: when adding below, update hv_result_to_string() */
-#define HV_STATUS_SUCCESS			    0x0
-#define HV_STATUS_INVALID_HYPERCALL_CODE	    0x2
-#define HV_STATUS_INVALID_HYPERCALL_INPUT	    0x3
-#define HV_STATUS_INVALID_ALIGNMENT		    0x4
-#define HV_STATUS_INVALID_PARAMETER		    0x5
-#define HV_STATUS_ACCESS_DENIED			    0x6
-#define HV_STATUS_INVALID_PARTITION_STATE	    0x7
-#define HV_STATUS_OPERATION_DENIED		    0x8
-#define HV_STATUS_UNKNOWN_PROPERTY		    0x9
-#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	    0xA
-#define HV_STATUS_INSUFFICIENT_MEMORY		    0xB
-#define HV_STATUS_INVALID_PARTITION_ID		    0xD
-#define HV_STATUS_INVALID_VP_INDEX		    0xE
-#define HV_STATUS_NOT_FOUND			    0x10
-#define HV_STATUS_INVALID_PORT_ID		    0x11
-#define HV_STATUS_INVALID_CONNECTION_ID		    0x12
-#define HV_STATUS_INSUFFICIENT_BUFFERS		    0x13
-#define HV_STATUS_NOT_ACKNOWLEDGED		    0x14
-#define HV_STATUS_INVALID_VP_STATE		    0x15
-#define HV_STATUS_NO_RESOURCES			    0x1D
-#define HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED   0x20
-#define HV_STATUS_INVALID_LP_INDEX		    0x41
-#define HV_STATUS_INVALID_REGISTER_VALUE	    0x50
-#define HV_STATUS_OPERATION_FAILED		    0x71
-#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY    0x75
-#define HV_STATUS_TIME_OUT			    0x78
-#define HV_STATUS_CALL_PENDING			    0x79
-#define HV_STATUS_VTL_ALREADY_ENABLED		    0x86
+#define HV_STATUS_SUCCESS				0x0
+#define HV_STATUS_INVALID_HYPERCALL_CODE		0x2
+#define HV_STATUS_INVALID_HYPERCALL_INPUT		0x3
+#define HV_STATUS_INVALID_ALIGNMENT			0x4
+#define HV_STATUS_INVALID_PARAMETER			0x5
+#define HV_STATUS_ACCESS_DENIED				0x6
+#define HV_STATUS_INVALID_PARTITION_STATE		0x7
+#define HV_STATUS_OPERATION_DENIED			0x8
+#define HV_STATUS_UNKNOWN_PROPERTY			0x9
+#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE		0xA
+#define HV_STATUS_INSUFFICIENT_MEMORY			0xB
+#define HV_STATUS_INVALID_PARTITION_ID			0xD
+#define HV_STATUS_INVALID_VP_INDEX			0xE
+#define HV_STATUS_NOT_FOUND				0x10
+#define HV_STATUS_INVALID_PORT_ID			0x11
+#define HV_STATUS_INVALID_CONNECTION_ID			0x12
+#define HV_STATUS_INSUFFICIENT_BUFFERS			0x13
+#define HV_STATUS_NOT_ACKNOWLEDGED			0x14
+#define HV_STATUS_INVALID_VP_STATE			0x15
+#define HV_STATUS_NO_RESOURCES				0x1D
+#define HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED	0x20
+#define HV_STATUS_INVALID_LP_INDEX			0x41
+#define HV_STATUS_INVALID_REGISTER_VALUE		0x50
+#define HV_STATUS_OPERATION_FAILED			0x71
+#define HV_STATUS_INSUFFICIENT_ROOT_MEMORY		0x73
+#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY	0x75
+#define HV_STATUS_TIME_OUT				0x78
+#define HV_STATUS_CALL_PENDING				0x79
+#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY	0x83
+#define HV_STATUS_VTL_ALREADY_ENABLED			0x86
 
 /*
  * The Hyper-V TimeRefCount register and the TSC



