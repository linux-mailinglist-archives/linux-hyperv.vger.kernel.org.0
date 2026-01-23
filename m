Return-Path: <linux-hyperv+bounces-8478-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LxoIGDRcmnKpgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8478-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 02:39:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6D06F2EA
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 02:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71BE430131FB
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 01:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E0537C0E0;
	Fri, 23 Jan 2026 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RGK+60Ug"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE39B30EF6B;
	Fri, 23 Jan 2026 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132152; cv=none; b=rKz1KPwVb3jwaVHmfw5oeRsMSIfXaBGxXw6KaNGvhI6yzk07xYBJcz3T20R+dM3BaSrVgNFAW/TPO6q8Y55cGcPV5+JioXlv9HbRumd9eJOF7JHq+aYgUm0MvCTC4yRmjf+htE717GwvXHmF1QwtkWqOdw+ljqL2prSw6a+toJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132152; c=relaxed/simple;
	bh=iZpQFdCwdFnUKJt7bERP+i+5TvY+UkUdadwClJ0rJyM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkvBpkyCldMtI0EHH4DBZANAq6Uns3JY5jEPfQySVo5t7CpGKO0orbpvwWCXE+XKC9oK6mz+KlrwzGGVXHgi32yeKKoVAL/CTW2oIa3HdRrkUVvvCIYNY2ScLhLPb5WG8MVNQQty/86Itpo+n4CiZ3qfwm6wUFY5ms3N8JWDa40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RGK+60Ug; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id D9A0520B7194;
	Thu, 22 Jan 2026 17:35:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9A0520B7194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769132128;
	bh=Y7GIZfZCCJT1rE0abx5LI7myN/MH3aCsR6pG9tyNjoA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RGK+60UgjTZsnVGehaalR6SZhKSRYzwGoAKhH8KtQwQqNHXTtSO23U14vD4GNLCky
	 IGIRW4r2Y5NnSF0BiEYxr2EVHHNYZZ/cOl5CN/1nBdra1blcNrdN50U0hCCgLZmzw+
	 9iOF8+Z9+B/iI0QREMoalMxwdDucrouO8FbtNdNY=
Subject: [PATCH 3/4] mshv: Handle insufficient contiguous memory hypervisor
 status
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Jan 2026 01:35:28 +0000
Message-ID: 
 <176913212875.89165.1525113355960161166.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176913164914.89165.5792608454600292463.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176913164914.89165.5792608454600292463.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8478-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,4.155.116.186:received,13.77.154.182:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD6D06F2EA
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
index c0c2bfc80d77..ac21e16f9348 100644
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
@@ -131,6 +134,7 @@ bool hv_result_oom(u64 status)
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
index 0f7178fa88a8..c5cfe13fae57 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -7,6 +7,8 @@
 
 #include "hvgdk_mini.h"
 
+#define HV_MAX_CONTIGUOUS_ALLOCATION_PAGES	8
+
 /*
  * Doorbell connection_info flags.
  */



