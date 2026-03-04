Return-Path: <linux-hyperv+bounces-9130-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I2lNPF7p2kshwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9130-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:25:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CD31F8E55
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3B2B30BFF41
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 00:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147F29D27A;
	Wed,  4 Mar 2026 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h3emWyJj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC029C339;
	Wed,  4 Mar 2026 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583827; cv=none; b=VwOZFRFA0TQQIiTZiKG/auEAqIQxC6lqo0nx//iqWPKr7xCmn8WTMugLNSQodN4nktgBQlt/Or8RxBowFyS7YY7bMod8gNTEERSjP9s+1NyDh6DneIyLR9bc5zlsEiVAwVA+AS17M2zCIt/XOy3VpQ/boUVervdOiTuJUJSuwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583827; c=relaxed/simple;
	bh=4AoK1Lybd1RfF6579t5liUN85jBAiT+L9duRLtnX1Ls=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0DZRok31jm4Axe558xFgJGWSDNzYf+8ORAU1BXo691qNjsUqUWXHYnYgddH1XwCx8W6M/Q/X12KrwYo7f3O3SYAOgQ6+NjPosFaM5k5HNHFVngTw5hW1dlgniefctWgNtSRXAPgxyJYx79haDyw4yY8rxisZnjHSAh+B+9lpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h3emWyJj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id BFB6F20B6F02;
	Tue,  3 Mar 2026 16:23:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFB6F20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772583825;
	bh=HIXZPD3P577bOQ5SyK+eoIL/V4AV3PNuzzuN6n1FeKo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=h3emWyJjb3IO0mA/38Ma7x19p37Kz0Le3vTekG1gdEptueB+bDtpTXn8Cgn8uYioL
	 RVZdb2lIDDsADh3mvdr30+cSe2tkNVl02CEAA++PYLBUDYuBM5IPNUo5MlnAxy1r2q
	 P1WaZwGgopCjp/4iYm4/CgiBsKGlCmq0Lo6nvC1A=
Subject: [PATCH 3/4] mshv: Fix pre-depositing of pages for virtual processor
 initialization
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2026 00:23:45 +0000
Message-ID: 
 <177258382549.229866.5072213647599344057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 42CD31F8E55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-9130-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Action: no action

Deposit enough pages up front to avoid virtual processor creation failures
due to low memory. This also speeds up guest creation. A VP uses 25% more
pages in a partition with nested virtualization enabled, but the exact
number doesn't vary much, so deposit a fixed number of pages per VP that
works for nested virtualization.

Move page depositing from the hypercall wrapper to the virtual processor
creation code. The required number of pages is based on empirical data.
This logic fits better in the virtual processor creation code than in the
hypercall wrapper.

Also withdraw the deposited memory if virtual processor creation fails.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_proc.c        |    8 --------
 drivers/hv/mshv_root_main.c |   11 ++++++++++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 0f84a70def30..3d41f52efd9a 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -251,14 +251,6 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 	unsigned long irq_flags;
 	int ret = 0;
 
-	/* Root VPs don't seem to need pages deposited */
-	if (partition_id != hv_current_partition_id) {
-		/* The value 90 is empirically determined. It may change. */
-		ret = hv_call_deposit_pages(node, partition_id, 90);
-		if (ret)
-			return ret;
-	}
-
 	do {
 		local_irq_save(irq_flags);
 
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index fbfc50de332c..48c842b6938d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -38,6 +38,7 @@
 /* The deposit values below are empirical and may need to be adjusted. */
 #define MSHV_PARTITION_DEPOSIT_PAGES		(SZ_512K >> PAGE_SHIFT)
 #define MSHV_PARTITION_DEPOSIT_PAGES_NESTED	(20 * SZ_1M >> PAGE_SHIFT)
+#define MSHV_VP_DEPOSIT_PAGES			(1 * SZ_1M >> PAGE_SHIFT)
 
 MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
@@ -1077,10 +1078,15 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (partition->pt_vp_array[args.vp_index])
 		return -EEXIST;
 
+	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id,
+				    MSHV_VP_DEPOSIT_PAGES);
+	if (ret)
+		return ret;
+
 	ret = hv_call_create_vp(NUMA_NO_NODE, partition->pt_id, args.vp_index,
 				0 /* Only valid for root partition VPs */);
 	if (ret)
-		return ret;
+		goto withdraw_mem;
 
 	ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
 				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
@@ -1177,6 +1183,9 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 			       intercept_msg_page, input_vtl_zero);
 destroy_vp:
 	hv_call_delete_vp(partition->pt_id, args.vp_index);
+withdraw_mem:
+	hv_call_withdraw_memory(MSHV_VP_DEPOSIT_PAGES, NUMA_NO_NODE,
+				partition->pt_id);
 out:
 	trace_mshv_create_vp(partition->pt_id, args.vp_index, ret);
 	return ret;



