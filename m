Return-Path: <linux-hyperv+bounces-9888-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFHwDGKazWkrfQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9888-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 00:21:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1F0380E65
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 00:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C2330ADB91
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 22:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240FB32C316;
	Wed,  1 Apr 2026 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KOEGQfpK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64937C93A;
	Wed,  1 Apr 2026 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081569; cv=none; b=CGWuVLz2U1lUqvJry8vM3dOGKdrUUg0bDI4aFy7VeOfsKbyu8sULPlpghYOOQfsFAihzV94kcZgXF/6Obh0DGDaGnIf5M1icyLoe+WVCUC9T/itrt9shEgzQ6H0pDEae5+48e+7oteUfknoJNAXm/shrSTp32KgquvErriYCKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081569; c=relaxed/simple;
	bh=XEcYMN9Mb9xMKDA0voAxzaHRz5cW8yikLMZFzBdJgzA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdFgZ27anMS7zblstCUeqUTu0P9E3XUxFeA5dtkv27OZ6nWTLo8nOUYbfizaIM05v+wb2BcVeXvvJs3hvI85PkeaKQWlPf3qILF7qnfpaAbxVZ3v5TnclgrbHAkT+MtqWUiF12LNyTXPRMkUh/0GR1oG91uhPcFieTxM8RLkzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KOEGQfpK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 09E5F20B710C;
	Wed,  1 Apr 2026 15:12:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09E5F20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775081567;
	bh=BxwMXqOmy8NSOcSj7VSvIBNBQ4zYtQzLg2SzFveR4bA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KOEGQfpKGTYVLa/0Wfda1JVSPec6EqMMeOF6jkJ2F2q/gDmZ7P8+kvOPmPuZWMLQ9
	 7qGi6f3705tRF8n0QYXA/fCT2FXeF0mBtloLaMIKuB/Jayl1mYLFlvbiBmbXVbidiE
	 Ex7b0HW/2bR6B1knnGr2T4HPLQrXDaRKod1WlyyE=
Subject: [PATCH 4/7] mshv: Optimize memory region mapping operations
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 01 Apr 2026 22:12:46 +0000
Message-ID: 
 <177508156646.215674.2229578835484145880.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9888-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA1F0380E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two specific operations don't require PFN iteration: region unmapping
and region remapping with no access. For unmapping, all frames in MSHV
memory regions are guaranteed to be mapped with page access, so we can
unmap them all without checking individual PFNs. For remapping with no
access, all frames are already mapped with page access, allowing us to
unmap them all in one pass.

Since neither operation needs PFN validation, iterating over PFNs is
redundant. Batch operations into large page-aligned chunks followed by
remaining pages. This eliminates PFN traversal for these operations,
requires no additional hypercalls compared to the PFN-checking approach,
and provides the simplest possible sequential execution path.

The optimization utilizes HV_MAP_GPA_LARGE_PAGE and
HV_UNMAP_GPA_LARGE_PAGE flags for aligned portions, processing only the
remainder with base page granularity. This removes mshv_region_chunk_unmap()
and mshv_region_process_range() helper functions, reducing code complexity.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   65 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 2c4215381e0b..a92381219758 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -449,27 +449,27 @@ static int mshv_region_pin(struct mshv_region *region)
 	return ret < 0 ? ret : -ENOMEM;
 }
 
-static int mshv_region_chunk_unmap(struct mshv_region *region,
-				   u32 flags,
-				   u64 pfn_offset, u64 pfn_count,
-				   bool huge_page)
+static int mshv_region_unmap(struct mshv_region *region)
 {
-	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
-		return 0;
+	u64 aligned_pages, remaining_pages;
+	int ret = 0;
 
-	if (huge_page)
-		flags |= HV_UNMAP_GPA_LARGE_PAGE;
+	aligned_pages = ALIGN_DOWN(region->nr_pfns, PTRS_PER_PMD);
+	remaining_pages = region->nr_pfns - aligned_pages;
 
-	return hv_call_unmap_pfns(region->partition->pt_id,
-				  region->start_gfn + pfn_offset,
-				  pfn_count, flags);
-}
+	if (aligned_pages)
+		ret = hv_call_unmap_pfns(region->partition->pt_id,
+					 region->start_gfn,
+					 aligned_pages,
+					 HV_UNMAP_GPA_LARGE_PAGE);
 
-static int mshv_region_unmap(struct mshv_region *region)
-{
-	return mshv_region_process_range(region, 0,
-					 0, region->nr_pfns,
-					 mshv_region_chunk_unmap);
+	if (!ret && remaining_pages)
+		ret = hv_call_unmap_pfns(region->partition->pt_id,
+					 region->start_gfn + aligned_pages,
+					 remaining_pages,
+					 0);
+
+	return ret;
 }
 
 static void mshv_region_destroy(struct kref *ref)
@@ -684,6 +684,34 @@ bool mshv_region_handle_gfn_fault(struct mshv_region *region, u64 gfn)
 	return !ret;
 }
 
+static int mshv_region_map_no_access(struct mshv_region *region,
+				     u64 pfn_offset, u64 pfn_count)
+{
+	u64 aligned_pages, remaining_pages;
+	int ret = 0;
+
+	aligned_pages = ALIGN_DOWN(pfn_count, PTRS_PER_PMD);
+	remaining_pages = pfn_count - aligned_pages;
+
+	if (aligned_pages)
+		ret = hv_call_map_ram_pfns(region->partition->pt_id,
+					   region->start_gfn + pfn_offset,
+					   aligned_pages,
+					   HV_MAP_GPA_NO_ACCESS |
+					   HV_MAP_GPA_LARGE_PAGE,
+					   NULL);
+
+	if (!ret && remaining_pages)
+		ret = hv_call_map_ram_pfns(region->partition->pt_id,
+					   region->start_gfn +
+					   aligned_pages + pfn_offset,
+					   remaining_pages,
+					   HV_MAP_GPA_NO_ACCESS,
+					   NULL);
+
+	return ret;
+}
+
 /**
  * mshv_region_interval_invalidate - Invalidate a range of memory region
  * @mni: Pointer to the mmu_interval_notifier structure
@@ -727,8 +755,7 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 
 	mmu_interval_set_seq(mni, cur_seq);
 
-	ret = mshv_region_remap_pfns(region, HV_MAP_GPA_NO_ACCESS,
-				     pfn_offset, pfn_count);
+	ret = mshv_region_map_no_access(region, pfn_offset, pfn_count);
 	if (ret)
 		goto out_unlock;
 



