Return-Path: <linux-hyperv+bounces-9924-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIxSGLevzml+pQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9924-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:04:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0058A38CDD1
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7868303700E
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7040535CB6E;
	Thu,  2 Apr 2026 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sKPmUG9B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278DC36BCF5;
	Thu,  2 Apr 2026 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153072; cv=none; b=bKtCFAwdTKJfgzuCBHSQm+LyogpVDwEiSRkuRhCaKS7F031jwz42MZg9UBj7UCvysxhfEOHqGnO6d42mafcCzQchkgsUXcK+Nu619gI/flUMD0sMFu1wmQ4Vs/UrZIwYja3+7wdj3K8ZW8uz8vTD8+r0iDET+TKcaGq1RB0Vd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153072; c=relaxed/simple;
	bh=6yc0ZLtiICO5wp17sTEKwScUGi5GR/y2eE7SL8uE2k8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgX8XSMZJwcMBYPkMqtKrd82bttJitPLvdSZRL1/5yV6mu/nlxMQlB3JzGEHSiMLiHpxHF4V8WWLxbh7JKSZYZJLGLkEYbJY+rxwtn/m8mcylOREwJsRxGS1rdKhahZOOa/vRQpwUZ+6nmp+TTkrkWHYot7kNiYIFYs55NLyHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sKPmUG9B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3BE9220B710C;
	Thu,  2 Apr 2026 11:04:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BE9220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775153071;
	bh=KES9mGd5EYvqF9lrr6+2t/E+YdvM6XGXe46iYJ8GJgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sKPmUG9BBCteTKvq50rSsQ1jgWbHMGYOLDD9XmxySib09/aW/W/IkWGRxH2rh773v
	 AQpROFVupBbllEQ8xQz/VuWEgkBdXOQE+V2gBvYWNd7tImmvtQUBhviUrOXhvve19b
	 BrLPkXW8gljIjSQPzWFx3ggz/3e6S3O+OXQ/SV+k=
Subject: [PATCH v2 4/7] mshv: Optimize memory region mapping operations
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 18:04:30 +0000
Message-ID: 
 <177515307065.119822.3641080767740409824.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9924-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 0058A38CDD1
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
remainder with base page granularity. This removes
mshv_region_chunk_unmap() and eliminates PFN iteration for unmap and
no-access operations, reducing code complexity.

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
 



