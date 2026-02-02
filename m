Return-Path: <linux-hyperv+bounces-8650-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEsNCPXlgGleCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8650-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 18:59:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B084CCFDB8
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 18:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40B62300B18D
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 17:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE81338947A;
	Mon,  2 Feb 2026 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T3YvFPnT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA2389462;
	Mon,  2 Feb 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055150; cv=none; b=Cn57ezyUXgxmCTpJFcdM/bsWiFxIfCT8MGmDXPQEXguXVqR2I56mwA8CnNrbq/ixoyGkKrqIcfk1p0qMcYRR1poo2EHul5cZk3pk1sblvA/6WDhl5dU5P88n1QfQZ4+JHEn/HNdmZ7Vesh287NWx1S/HtaAN4g2kBZ8B0GF6xpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055150; c=relaxed/simple;
	bh=qBuKZdjFKyaWhYfMvMqbmdy2raiy5fqszU9vkmvlXbY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldNgH9epP48haII1mdloqhWS9xEgoQKcijEBT7ctDKWpmz9gXY/+wLpeTn5t20sM5WOBvm+hx86RxyQu7v21snniXyxDq5Ld7kuzKc+k8UX7iEW8nIYJ83G7aW2e9nG4UOKzQkESMnwifajOiOMbZ9iJyNds6v7Hy8NrJbHvqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T3YvFPnT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6B4F220B7168;
	Mon,  2 Feb 2026 09:59:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B4F220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770055149;
	bh=oGA5hhvy9YmgiaKGzZ88eZeX1WVPqMurEBsxRrK7c7Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T3YvFPnT8c+eKsHPsdBYuhTZMfvZ7UoI7K2uRdBWUVAwaNT5A5o2yDiS7Qm9+FTrD
	 7dAn+FbCTYpKm9ES2IYi/oB/Db4TVv9NoQbDKLknBMEwDRr1Nnwub5YhaxqfFwicp7
	 o/9truN1r5J9Aaa7RrHaJXlsLNLFfKMa75s8HvL8=
Subject: [PATCH v2 3/4] mshv: Handle insufficient contiguous memory hypervisor
 status
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 17:59:09 +0000
Message-ID: 
 <177005514902.120041.13078117373390753930.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8650-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B084CCFDB8
X-Rspamd-Action: no action

The HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY status indicates that the
hypervisor lacks sufficient contiguous memory for its internal allocations.

When this status is encountered, allocate and deposit
HV_MAX_CONTIGUOUS_ALLOCATION_PAGES contiguous pages to the hypervisor.
HV_MAX_CONTIGUOUS_ALLOCATION_PAGES is defined in the hypervisor headers, a
deposit of this size will always satisfy the hypervisor's requirements.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_common.c      |    1 +
 drivers/hv/hv_proc.c        |    4 ++++
 include/hyperv/hvgdk_mini.h |    1 +
 include/hyperv/hvhdk_mini.h |    2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 0a3ab7efed46..c7f63c9de503 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -791,6 +791,7 @@ static const struct hv_status_info hv_status_infos[] = {
 	_STATUS_INFO(HV_STATUS_UNKNOWN_PROPERTY,		-EIO),
 	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
 	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
+	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
 	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index ffa25cd6e4e9..dfa27be66ff7 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -119,6 +119,9 @@ int hv_deposit_memory_node(int node, u64 partition_id,
 	case HV_STATUS_INSUFFICIENT_MEMORY:
 		num_pages = 1;
 		break;
+	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
+		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
+		break;
 	default:
 		hv_status_err(hv_status, "Unexpected!\n");
 		return -ENOMEM;
@@ -131,6 +134,7 @@ bool hv_result_needs_memory(u64 status)
 {
 	switch (hv_result(status)) {
 	case HV_STATUS_INSUFFICIENT_MEMORY:
+	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
 		return true;
 	}
 	return false;
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 04b18d0e37af..70f22ef44948 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -38,6 +38,7 @@ struct hv_u128 {
 #define HV_STATUS_INVALID_LP_INDEX		    0x41
 #define HV_STATUS_INVALID_REGISTER_VALUE	    0x50
 #define HV_STATUS_OPERATION_FAILED		    0x71
+#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY    0x75
 #define HV_STATUS_TIME_OUT			    0x78
 #define HV_STATUS_CALL_PENDING			    0x79
 #define HV_STATUS_VTL_ALREADY_ENABLED		    0x86
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index c0300910808b..091c03e26046 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -7,6 +7,8 @@
 
 #include "hvgdk_mini.h"
 
+#define HV_MAX_CONTIGUOUS_ALLOCATION_PAGES	8
+
 /*
  * Doorbell connection_info flags.
  */



