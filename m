Return-Path: <linux-hyperv+bounces-9922-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +InPCBGxzml+pQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9922-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:10:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8797F38CEC4
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 907F1302A6D4
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F336C0DC;
	Thu,  2 Apr 2026 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Rf/MQSlF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5ED371CE1;
	Thu,  2 Apr 2026 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153062; cv=none; b=IPwApmGa1VO313k9GMzslEl03yC9t0rFtZMPtrOtU7K0t6aNRe515xOHSO4YMjMvZRvc4ow1jT/q80XDywusD8724rFcUrEFpvC5ZvZRZMtyvAnHsVu5ctPJGbxCW5kAiLtOog8V29h6NmJeTCJ6+plVpu+di0AnmIVWeK7pF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153062; c=relaxed/simple;
	bh=v9TTC+Nd6E0wmrPTtk0Pas/1axFdxZOQ3EK0KkhaOa0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcLWAl4M1v7MYas8tVM/I9LPliLfb+RfRKEhssZ1XogpjWK2kvJV9G2VtranHYkhMixWZdSt5ngmZvgGUQlhce3FoenQ8PkRZByhgdeDmOCtAcE9zAU3vftVPr+ctey2m+lhxHhbtYs5SQEsnKZ7JXsVD7zqB4Jl1F4MfTxFDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Rf/MQSlF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1CDC320B710C;
	Thu,  2 Apr 2026 11:04:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CDC320B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775153060;
	bh=k+ukvopXBdnCI6zky9EadLqukdeJZVJkaj7kR+yp0gs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Rf/MQSlFQ/iMRXpM6RK3Dh3p/RKZT6jbtPbSPRmjtmBobtjYgYDTprK7lCRN3CLHy
	 3J7Di4ZkOkaDvq/wX4mPhLIiKJfdxFRP9SUCsX0lYC2DFvLEnncpwwQJqWYSWC262R
	 gIMg/IVC4tcUrNucZWPr6mFgZu3kG0J1OtVwukkw=
Subject: [PATCH v2 2/7] mshv: Improve code readability with handler function
 typedef
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 18:04:19 +0000
Message-ID: 
 <177515305952.119822.4844263289863761708.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177515251087.119822.1940529498624181326.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177515251087.119822.1940529498624181326.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9922-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8797F38CEC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The inline function pointer declarations in mshv_region_process_*
functions make the code harder to read and maintain. Each function
signature repeats the same lengthy callback parameter definition,
adding visual noise and making the actual logic less clear.

Introduce pfn_handler_t typedef to replace the repeated inline
function pointer declarations. This simplifies function signatures,
makes the code more maintainable, and follows common kernel
patterns for callback handling.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index a85d18e2c279..70cd0857a28e 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -20,6 +20,10 @@
 #define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
 #define MSHV_INVALID_PFN				ULONG_MAX
 
+typedef int (*pfn_handler_t)(struct mshv_mem_region *region, u32 flags,
+			     u64 pfn_offset, u64 pfn_count,
+			     bool huge_page);
+
 static const struct mmu_interval_notifier_ops mshv_region_mni_ops;
 
 /**
@@ -80,11 +84,7 @@ static int mshv_chunk_stride(struct page *page,
 static long mshv_region_process_pfns(struct mshv_mem_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
-				     int (*handler)(struct mshv_mem_region *region,
-						    u32 flags,
-						    u64 pfn_offset,
-						    u64 pfn_count,
-						    bool huge_page))
+				     pfn_handler_t handler)
 {
 	u64 gfn = region->start_gfn + pfn_offset;
 	u64 count;
@@ -138,11 +138,7 @@ static long mshv_region_process_pfns(struct mshv_mem_region *region,
 static long mshv_region_process_hole(struct mshv_mem_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
-				     int (*handler)(struct mshv_mem_region *region,
-						    u32 flags,
-						    u64 pfn_offset,
-						    u64 pfn_count,
-						    bool huge_page))
+				     pfn_handler_t handler)
 {
 	long ret;
 
@@ -156,11 +152,7 @@ static long mshv_region_process_hole(struct mshv_mem_region *region,
 static long mshv_region_process_chunk(struct mshv_mem_region *region,
 				      u32 flags,
 				      u64 pfn_offset, u64 pfn_count,
-				      int (*handler)(struct mshv_mem_region *region,
-						     u32 flags,
-						     u64 pfn_offset,
-						     u64 pfn_count,
-						     bool huge_page))
+				      pfn_handler_t handler)
 {
 	if (pfn_valid(region->mreg_pfns[pfn_offset]))
 		return mshv_region_process_pfns(region, flags,
@@ -193,11 +185,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
 static int mshv_region_process_range(struct mshv_mem_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
-				     int (*handler)(struct mshv_mem_region *region,
-						    u32 flags,
-						    u64 pfn_offset,
-						    u64 pfn_count,
-						    bool huge_page))
+				     pfn_handler_t handler)
 {
 	u64 start, end;
 	long ret;



