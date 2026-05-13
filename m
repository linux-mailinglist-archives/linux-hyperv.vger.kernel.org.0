Return-Path: <linux-hyperv+bounces-10863-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKK8LQnMBGrMPAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10863-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:07:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5431539980
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A9423064139
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E413AFB08;
	Wed, 13 May 2026 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qXsWzeDE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5663AEF3E;
	Wed, 13 May 2026 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698494; cv=none; b=O4rvOCndZR/EQjPUbsVmPlXV0Q0nSgYotP6B/IxC1+itt2sVIefNs7RtwpcVCvsxpyKKLRz3HQhYkt4FSSqAYGRcTfS6uCvtT05KmAfePjh7ZgOPr/fIa48mmu/5AGFU6XYAODGC9AQReB1t/ZY6Qv6rJTb5qeGtd1Mu3VMZMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698494; c=relaxed/simple;
	bh=9GoljRSClIZD5c/M85W5aU2rV2F5rxll5ZRth1cKyhI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XELfVZG8BQYORwt4JlFibxDv4YtPXLv5AHraM2OxyOVgXrv5cUvMrKTgcM02mbalQurg0VJ+ih2lejMa1GL0OgDrAFiDnPqkT54iCf0NscS7J5AsCbH3DZ8gSptuaDp0XbjCKOkSebe6cLvPjRczf1jpvDC1u0n1kEOnmOJmc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qXsWzeDE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6C2F220B7167;
	Wed, 13 May 2026 11:54:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C2F220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698489;
	bh=mQFzl1BF8Q8WKsUKwnhZGuvs+5PcOooBE/pDIKVHxpE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qXsWzeDE7CRm7vz+WW3JK5NaJfx4n5i+ntTf4zBKrm6FdTI3z+zUbWNIj/BXro1RC
	 eE5S5DeqKGzwVjj1uKtFcaj6f1FR4vbSdhFmXlDmF764+u1koPfvveOa3H4WapwtBn
	 NhS7ja2SuyXAp6IeYmxxlqu+dSGp7adHRinFd8b4=
Subject: [PATCH v4 3/6] mshv: Optimize region unmap and invalidation with
 large pages
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:54:52 +0000
Message-ID: 
 <177869849207.19379.10516301649455055796.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177869833161.19379.1357399549586915698.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177869833161.19379.1357399549586915698.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B5431539980
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10863-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Region unmapping and no-access remapping do not require per-PFN
iteration: all GFNs in a region are guaranteed mapped (valid PFNs
with access permissions, holes with no-access), so they can be
processed in bulk.

Split GFN ranges into large-page-aligned chunks and use
HV_MAP_GPA_LARGE_PAGE / HV_UNMAP_GPA_LARGE_PAGE flags for the
aligned portions. This eliminates PFN traversal and reduces
hypercalls for large regions.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   77 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index f81951ae3f808..cb42ee49c2e2f 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -20,11 +20,17 @@
 /* Process memory regions in chunks to avoid soft lockups and livelock */
 #define MSHV_MAX_PFN_BATCH				(SZ_2M / PAGE_SIZE)
 
+/* Hypervisor base pages per large page (2 MiB / 4 KiB) */
+#define HV_PFNS_PER_LARGE_PAGE				(SZ_2M / HV_HYP_PAGE_SIZE)
+
 #define MSHV_MAP_FAULT_IN_PAGES				\
 	(PTRS_PER_PMD * max_t(unsigned long, 1, PAGE_SIZE / HV_HYP_PAGE_SIZE))
 
 #define MSHV_INVALID_PFN				ULONG_MAX
 
+typedef int (*gfn_handler_t)(struct mshv_region *region,
+			      u64 gfn, u64 count, u32 flags);
+
 static const struct mmu_interval_notifier_ops mshv_region_mni_ops;
 
 static inline bool mshv_pfn_valid(unsigned long pfn)
@@ -426,24 +432,54 @@ static int mshv_region_pin(struct mshv_region *region)
 	return ret < 0 ? ret : -ENOMEM;
 }
 
-static int mshv_region_chunk_unmap(struct mshv_region *region,
-				   u32 flags,
-				   u64 pfn_offset, u64 pfn_count,
-				   bool huge_page)
+/*
+ * Split a GFN range into head (unaligned), large-page-aligned middle,
+ * and tail, invoking @fn for each non-empty piece.
+ */
+static int mshv_region_for_each_gfn_chunk(struct mshv_region *region,
+					  u64 gfn, u64 nr_pfns,
+					  u32 base_flags, u32 large_flag,
+					  gfn_handler_t fn)
 {
-	if (huge_page)
-		flags |= HV_UNMAP_GPA_LARGE_PAGE;
+	u64 head, aligned, tail;
+	int ret;
+
+	head = min(ALIGN(gfn, HV_PFNS_PER_LARGE_PAGE) - gfn, nr_pfns);
+	aligned = ALIGN_DOWN(nr_pfns - head, HV_PFNS_PER_LARGE_PAGE);
+	tail = nr_pfns - head - aligned;
+
+	if (head) {
+		ret = fn(region, gfn, head, base_flags);
+		if (ret)
+			return ret;
+	}
+	if (aligned) {
+		ret = fn(region, gfn + head, aligned,
+			 base_flags | large_flag);
+		if (ret)
+			return ret;
+	}
+	if (tail) {
+		ret = fn(region, gfn + head + aligned, tail, base_flags);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
 
+static int mshv_unmap_gfns(struct mshv_region *region,
+			   u64 gfn, u64 count, u32 flags)
+{
 	return hv_call_unmap_pfns(region->partition->pt_id,
-				  region->start_gfn + pfn_offset,
-				  pfn_count, flags);
+				  gfn, count, flags);
 }
 
 static int mshv_region_unmap(struct mshv_region *region)
 {
-	return mshv_region_process_range(region, 0,
-					 0, region->nr_pfns,
-					 mshv_region_chunk_unmap);
+	return mshv_region_for_each_gfn_chunk(region, region->start_gfn,
+					      region->nr_pfns,
+					      0, HV_UNMAP_GPA_LARGE_PAGE,
+					      mshv_unmap_gfns);
 }
 
 static void mshv_region_destroy(struct kref *ref)
@@ -671,6 +707,22 @@ bool mshv_region_handle_gfn_fault(struct mshv_region *region, u64 gfn)
 	return !ret;
 }
 
+static int mshv_map_no_access_gfns(struct mshv_region *region,
+				   u64 gfn, u64 count, u32 flags)
+{
+	return hv_call_map_ram_pfns(region->partition->pt_id,
+				    gfn, count, flags, NULL);
+}
+
+static int mshv_region_map_no_access(struct mshv_region *region,
+				     u64 pfn_offset, u64 pfn_count)
+{
+	return mshv_region_for_each_gfn_chunk(region,
+			region->start_gfn + pfn_offset, pfn_count,
+			HV_MAP_GPA_NO_ACCESS, HV_MAP_GPA_LARGE_PAGE,
+			mshv_map_no_access_gfns);
+}
+
 /**
  * mshv_region_interval_invalidate - Invalidate a range of memory region
  * @mni: Pointer to the mmu_interval_notifier structure
@@ -714,8 +766,7 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 
 	mmu_interval_set_seq(mni, cur_seq);
 
-	ret = mshv_region_remap_pfns(region, HV_MAP_GPA_NO_ACCESS,
-				     pfn_offset, pfn_count);
+	ret = mshv_region_map_no_access(region, pfn_offset, pfn_count);
 	if (ret)
 		goto out_unlock;
 



