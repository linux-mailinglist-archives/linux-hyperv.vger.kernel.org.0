Return-Path: <linux-hyperv+bounces-8919-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RNWvGyKKl2m60AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8919-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 23:09:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA316307E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 23:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C2613015A69
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 22:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D6E2F5A06;
	Thu, 19 Feb 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="avhT3IgD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84662673AA;
	Thu, 19 Feb 2026 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771538974; cv=none; b=azI0+ZkoVrqyM6hosBFpIiU1fCi8cnquLLBrbw7DqbRgF7JzhhmqITdXiaTBZyHpNaJ2N9XwwqQWfjKRTm9bPxwI7ICFpEbXATNOcL4HqPIH4ofQh7H4RYLJgEAFVmqKraNG//CFr+WA5Q4Sdt2uPWQBf92eITqMqbEmWAifKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771538974; c=relaxed/simple;
	bh=KVgAUjwz8KnqJkBrLKb59hokg/g+2mmeBRO4n4pWxBE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=WeCAWnykA2VpMf5C7agYU+mxYEOfdEDoggcGveMTNhbDdTQoUI1T02Gv3aDoS5R4QkiA2jnxVwo5YZdxfJ5bIPA5jHGZKWDRImdCuN6XHsp8GxAXsmmvEkvsWrzTnn8xpdQSf+Vyl5L/jk7XxlKe3pB9G+06b9VRBGPbKlUkxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=avhT3IgD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0689620B6F00;
	Thu, 19 Feb 2026 14:09:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0689620B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771538973;
	bh=YjFO2+/Mqpr/SXRWbAMo4u5S9VcPxAaolKhssx45XHY=;
	h=Subject:From:To:Cc:Date:From;
	b=avhT3IgDW/vwArNVc2RADOlndhrYT8caZabO6veeZvFYzbAXpTUF51XLoGyfc/Wvw
	 iQ5xnt6JEnzQVFG9f+6QdCGMIUaN9GGg9BnAGAfU1zFfl0EuhQ4Mgyo3Qw1QjQrt6b
	 Wwr3md8wxpQGAVTl0Xxw5IpB3m/otPOdtHEl7xRw=
Subject: [PATCH] mshv: Replace fixed memory deposit with status driven helper
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Feb 2026 22:09:32 +0000
Message-ID: 
 <177153896491.48883.14285093878498416061.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8919-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: C3FA316307E
X-Rspamd-Action: no action

Replace hardcoded HV_MAP_GPA_DEPOSIT_PAGES usage with
hv_deposit_memory() which derives the deposit size from
the hypercall status, and remove the now-unused constant.

The previous code always deposited a fixed 256 pages on
insufficient memory, ignoring the actual demand reported
by the hypervisor. hv_deposit_memory() handles different
deposit statuses, aligning map-GPA retries with the rest
of the codebase.

This approach may require more allocation and deposit
hypercall iterations, but avoids over-depositing large
fixed chunks when fewer pages would suffice. Until any
performance impact is measured, the more frugal and
consistent behavior is preferred.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 7f91096f95a8..317191462b63 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -16,7 +16,6 @@
 
 /* Determined empirically */
 #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
-#define HV_MAP_GPA_DEPOSIT_PAGES	256
 #define HV_UMAP_GPA_PAGES		512
 
 #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
@@ -239,8 +238,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 		completed = hv_repcomp(status);
 
 		if (hv_result_needs_memory(status)) {
-			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
-						    HV_MAP_GPA_DEPOSIT_PAGES);
+			ret = hv_deposit_memory(partition_id, status);
 			if (ret)
 				break;
 



