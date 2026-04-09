Return-Path: <linux-hyperv+bounces-10098-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IL9BAjF12mdSQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10098-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 17:26:00 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C163CC9CB
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 17:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AC5C30451DA
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Apr 2026 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D93DF019;
	Thu,  9 Apr 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ppLtrWzt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B583DF014;
	Thu,  9 Apr 2026 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748264; cv=none; b=F7OY0zHSbrLptMdW+NJO4RCDTNjCjuF/EyxIrEGm2iKbvycjLkftncBDvA/9P/nKc1LcDsdiHSgkJb4MDT+gcphfmNr+dTdc1+B9+KFfs93Qtf+uVV67EclJJUHalc5ZkaceBz7Td6NiyIqpD0r6cwwbBo13AMEwf7g6Y8tavJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748264; c=relaxed/simple;
	bh=C3knlqH0KMmVZ3v6412qPeKd2zegXYCmg9CylK2YU6I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hlkxj0RtUVl7oqSUpGMtwlNoTijbHBI2PviLK9Eh2/1pT3U3WY5nvmxCkZyOA6deORaaV/k7yoqAgjbjGps1+FHY+Ug9ag9G8s1kmz2HdPfammTbttLIE8ezl7WoiHbFgJqkLhBY3qUZBvdFDa5TtNS1yn/pj+M76f+Fvz0NSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ppLtrWzt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7DD9920B6F01;
	Thu,  9 Apr 2026 08:24:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DD9920B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775748262;
	bh=FVeWoIsbbRGsupiTpjuAui9V6WusDTeg2YoK2nLZY0Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ppLtrWzt8FG3uBun1aP+7l5NUBBepcWrnBJrWN2niWMW1bsrqIE8BnL1M1jaNPmJv
	 KaRNxkIlSeRjWWLbxwgF4pNlsErVpkpQ1N1YjVXSFc+Jb/ophTipla88f+LULxqLbn
	 bl9W8dGBxxMs3CdnT5jAo9PtfFxhqnoFUD3ltxho=
Subject: [PATCH v3 4/7] mshv: Optimize memory region mapping operations
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 09 Apr 2026 15:24:22 +0000
Message-ID: 
 <177574826228.19719.9486401115198170921.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177574802240.19719.4873018419452139691.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177574802240.19719.4873018419452139691.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10098-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82C163CC9CB
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
 drivers/hv/mshv_regions.c |   87 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 2c4215381e0b..f209a34afb3a 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -449,27 +449,38 @@ static int mshv_region_pin(struct mshv_region *region)
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
+	u64 gfn, nr_pfns, starting_pfns, aligned_pfns, remaining_pfns;
+	int ret = 0;
 
-	if (huge_page)
-		flags |= HV_UNMAP_GPA_LARGE_PAGE;
+	gfn = region->start_gfn;
+	nr_pfns = region->nr_pfns;
 
-	return hv_call_unmap_pfns(region->partition->pt_id,
-				  region->start_gfn + pfn_offset,
-				  pfn_count, flags);
-}
+	starting_pfns = min(ALIGN(gfn, PTRS_PER_PMD) - gfn, nr_pfns);
+	aligned_pfns = ALIGN_DOWN(nr_pfns - starting_pfns, PTRS_PER_PMD);
+	remaining_pfns = nr_pfns - aligned_pfns - starting_pfns;
 
-static int mshv_region_unmap(struct mshv_region *region)
-{
-	return mshv_region_process_range(region, 0,
-					 0, region->nr_pfns,
-					 mshv_region_chunk_unmap);
+	if (starting_pfns)
+		ret = hv_call_unmap_pfns(region->partition->pt_id,
+					 gfn, starting_pfns,
+					 0);
+
+	gfn += starting_pfns;
+
+	if (!ret && aligned_pfns)
+		ret = hv_call_unmap_pfns(region->partition->pt_id,
+					 gfn, aligned_pfns,
+					 HV_UNMAP_GPA_LARGE_PAGE);
+
+	gfn += aligned_pfns;
+
+	if (!ret && remaining_pfns)
+		ret = hv_call_unmap_pfns(region->partition->pt_id,
+					 gfn, remaining_pfns,
+					 0);
+
+	return ret;
 }
 
 static void mshv_region_destroy(struct kref *ref)
@@ -684,6 +695,45 @@ bool mshv_region_handle_gfn_fault(struct mshv_region *region, u64 gfn)
 	return !ret;
 }
 
+static int mshv_region_map_no_access(struct mshv_region *region,
+				     u64 pfn_offset, u64 pfn_count)
+{
+	u64 gfn, nr_pfns, starting_pfns, aligned_pfns, remaining_pfns;
+	int ret = 0;
+
+	gfn = region->start_gfn + pfn_offset;
+	nr_pfns = pfn_count;
+
+	starting_pfns = min(ALIGN(gfn, PTRS_PER_PMD) - gfn, nr_pfns);
+	aligned_pfns = ALIGN_DOWN(nr_pfns - starting_pfns, PTRS_PER_PMD);
+	remaining_pfns = nr_pfns - aligned_pfns - starting_pfns;
+
+	if (starting_pfns)
+		ret = hv_call_map_ram_pfns(region->partition->pt_id,
+					   gfn, starting_pfns,
+					   HV_MAP_GPA_NO_ACCESS,
+					   NULL);
+
+	gfn += starting_pfns;
+
+	if (!ret && aligned_pfns)
+		ret = hv_call_map_ram_pfns(region->partition->pt_id,
+					   gfn, aligned_pfns,
+					   HV_MAP_GPA_NO_ACCESS |
+					   HV_MAP_GPA_LARGE_PAGE,
+					   NULL);
+
+	gfn += aligned_pfns;
+
+	if (!ret && remaining_pfns)
+		ret = hv_call_map_ram_pfns(region->partition->pt_id,
+					   gfn, remaining_pfns,
+					   HV_MAP_GPA_NO_ACCESS,
+					   NULL);
+
+	return ret;
+}
+
 /**
  * mshv_region_interval_invalidate - Invalidate a range of memory region
  * @mni: Pointer to the mmu_interval_notifier structure
@@ -727,8 +777,7 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 
 	mmu_interval_set_seq(mni, cur_seq);
 
-	ret = mshv_region_remap_pfns(region, HV_MAP_GPA_NO_ACCESS,
-				     pfn_offset, pfn_count);
+	ret = mshv_region_map_no_access(region, pfn_offset, pfn_count);
 	if (ret)
 		goto out_unlock;
 



