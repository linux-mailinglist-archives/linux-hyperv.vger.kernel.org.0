Return-Path: <linux-hyperv+bounces-9923-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB+ZKa+vzml+pQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9923-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:04:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4626938CDCA
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BD8C3036C77
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010F5373C07;
	Thu,  2 Apr 2026 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gnY3VhHH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0CB248896;
	Thu,  2 Apr 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153067; cv=none; b=BfInpy0OUmRgW2ffeGd/ZWidXDs/KPz4aWRf6BhgsG8b1G0ugBampOUcH8LHl8kJL1iJuAXAsB9CfH2USS7WNs5KgiCwuLmlk/j1c/Ucr7e+JmS29rBpRqRD6B3mGbyAI2K6AyhLhZmtp0cIutRh1FtVvuKYpQdMEJrd7SGfYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153067; c=relaxed/simple;
	bh=RmpSCqwT4YQ1EyJHvyjCOzZOsgJOwzySJ8ZR3T9XQ7U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOvM7hvpT1YROz43UR2Ny2vFIC9nvcysltHpqrNqL4fkxVgkvgAumS4Lcipii6Q/1cAjQ+JMAyPJea1PgCrxaVsRh7TkrmqmglzZrQikLgZRCBmYcesPEOhAaL/yGazUUmZMPBdaTDODjUBmrVyU9H6jXgF2d6sdP4XiE/nUL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gnY3VhHH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8260C20B710C;
	Thu,  2 Apr 2026 11:04:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8260C20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775153065;
	bh=W/2AUmh+gShLThqDUVkP8uBrGs1HupE09J2+Uc+67W8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gnY3VhHHtueX+vJoL4TVr5bjUHfPkNPXZUje5hW5q2uF4sfs1OQaRAk64em7YppO5
	 N8axFL5ZV/3zglNtaI9846HdG+HCPdpMdYkjg3tVFlD4iHT+BNukGisFqidbKOcGzI
	 lY80cQwLmX9xfmmVwhj+wCwwMJFMVrOjMP7sxB7k=
Subject: [PATCH v2 3/7] mshv: Rename mshv_mem_region to mshv_region
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 18:04:24 +0000
Message-ID: 
 <177515306494.119822.1237919865291737461.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9923-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 4626938CDCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mshv_mem_region structure represents guest address space regions,
which can be either RAM-backed memory or memory-mapped IO regions
without physical backing. The "mem_" prefix incorrectly suggests the
structure only handles memory regions, creating confusion about its
actual purpose.

Remove the "mem_" prefix to align with existing function naming
(mshv_region_map, mshv_region_pin, etc.) and accurately reflect that
this structure manages arbitrary guest address space mappings
regardless of their backing type.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c   |   74 ++++++++++++++++++++++---------------------
 drivers/hv/mshv_root.h      |   18 +++++-----
 drivers/hv/mshv_root_main.c |   20 ++++++------
 3 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 70cd0857a28e..2c4215381e0b 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -20,7 +20,7 @@
 #define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
 #define MSHV_INVALID_PFN				ULONG_MAX
 
-typedef int (*pfn_handler_t)(struct mshv_mem_region *region, u32 flags,
+typedef int (*pfn_handler_t)(struct mshv_region *region, u32 flags,
 			     u64 pfn_offset, u64 pfn_count,
 			     bool huge_page);
 
@@ -81,7 +81,7 @@ static int mshv_chunk_stride(struct page *page,
  *
  * Return: Number of pages handled, or negative error code.
  */
-static long mshv_region_process_pfns(struct mshv_mem_region *region,
+static long mshv_region_process_pfns(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
 				     pfn_handler_t handler)
@@ -135,7 +135,7 @@ static long mshv_region_process_pfns(struct mshv_mem_region *region,
  *
  * Return: Number of PFNs handled, or negative error code.
  */
-static long mshv_region_process_hole(struct mshv_mem_region *region,
+static long mshv_region_process_hole(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
 				     pfn_handler_t handler)
@@ -149,7 +149,7 @@ static long mshv_region_process_hole(struct mshv_mem_region *region,
 	return pfn_count;
 }
 
-static long mshv_region_process_chunk(struct mshv_mem_region *region,
+static long mshv_region_process_chunk(struct mshv_region *region,
 				      u32 flags,
 				      u64 pfn_offset, u64 pfn_count,
 				      pfn_handler_t handler)
@@ -182,7 +182,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
  *
  * Returns 0 on success, or a negative error code on failure.
  */
-static int mshv_region_process_range(struct mshv_mem_region *region,
+static int mshv_region_process_range(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
 				     pfn_handler_t handler)
@@ -231,12 +231,12 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 	return 0;
 }
 
-struct mshv_mem_region *mshv_region_create(enum mshv_region_type type,
-					   u64 guest_pfn, u64 nr_pfns,
-					   u64 uaddr, u32 flags,
-					   ulong mmio_pfn)
+struct mshv_region *mshv_region_create(enum mshv_region_type type,
+				       u64 guest_pfn, u64 nr_pfns,
+				       u64 uaddr, u32 flags,
+				       ulong mmio_pfn)
 {
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 	int ret = 0;
 	u64 i;
 
@@ -286,7 +286,7 @@ struct mshv_mem_region *mshv_region_create(enum mshv_region_type type,
 	return ERR_PTR(ret);
 }
 
-static int mshv_region_chunk_share(struct mshv_mem_region *region,
+static int mshv_region_chunk_share(struct mshv_region *region,
 				   u32 flags,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
@@ -305,7 +305,7 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
 					      flags, true);
 }
 
-static int mshv_region_share(struct mshv_mem_region *region)
+static int mshv_region_share(struct mshv_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
 
@@ -314,7 +314,7 @@ static int mshv_region_share(struct mshv_mem_region *region)
 					 mshv_region_chunk_share);
 }
 
-static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
+static int mshv_region_chunk_unshare(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
 				     bool huge_page)
@@ -331,7 +331,7 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 					      flags, false);
 }
 
-static int mshv_region_unshare(struct mshv_mem_region *region)
+static int mshv_region_unshare(struct mshv_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
 
@@ -340,7 +340,7 @@ static int mshv_region_unshare(struct mshv_mem_region *region)
 					 mshv_region_chunk_unshare);
 }
 
-static int mshv_region_chunk_remap(struct mshv_mem_region *region,
+static int mshv_region_chunk_remap(struct mshv_region *region,
 				   u32 flags,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
@@ -362,7 +362,7 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
 				    region->mreg_pfns + pfn_offset);
 }
 
-static int mshv_region_remap_pfns(struct mshv_mem_region *region,
+static int mshv_region_remap_pfns(struct mshv_region *region,
 				  u32 map_flags,
 				  u64 pfn_offset, u64 pfn_count)
 {
@@ -371,7 +371,7 @@ static int mshv_region_remap_pfns(struct mshv_mem_region *region,
 					 mshv_region_chunk_remap);
 }
 
-static int mshv_region_map(struct mshv_mem_region *region)
+static int mshv_region_map(struct mshv_region *region)
 {
 	u32 map_flags = region->hv_map_flags;
 
@@ -379,7 +379,7 @@ static int mshv_region_map(struct mshv_mem_region *region)
 				      0, region->nr_pfns);
 }
 
-static void mshv_region_invalidate_pfns(struct mshv_mem_region *region,
+static void mshv_region_invalidate_pfns(struct mshv_region *region,
 					u64 pfn_offset, u64 pfn_count)
 {
 	u64 i;
@@ -395,12 +395,12 @@ static void mshv_region_invalidate_pfns(struct mshv_mem_region *region,
 	}
 }
 
-static void mshv_region_invalidate(struct mshv_mem_region *region)
+static void mshv_region_invalidate(struct mshv_region *region)
 {
 	mshv_region_invalidate_pfns(region, 0, region->nr_pfns);
 }
 
-static int mshv_region_pin(struct mshv_mem_region *region)
+static int mshv_region_pin(struct mshv_region *region)
 {
 	u64 done_count, nr_pfns, i;
 	unsigned long *pfns;
@@ -449,7 +449,7 @@ static int mshv_region_pin(struct mshv_mem_region *region)
 	return ret < 0 ? ret : -ENOMEM;
 }
 
-static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
+static int mshv_region_chunk_unmap(struct mshv_region *region,
 				   u32 flags,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
@@ -465,7 +465,7 @@ static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 				  pfn_count, flags);
 }
 
-static int mshv_region_unmap(struct mshv_mem_region *region)
+static int mshv_region_unmap(struct mshv_region *region)
 {
 	return mshv_region_process_range(region, 0,
 					 0, region->nr_pfns,
@@ -474,8 +474,8 @@ static int mshv_region_unmap(struct mshv_mem_region *region)
 
 static void mshv_region_destroy(struct kref *ref)
 {
-	struct mshv_mem_region *region =
-		container_of(ref, struct mshv_mem_region, mreg_refcount);
+	struct mshv_region *region =
+		container_of(ref, struct mshv_region, mreg_refcount);
 	struct mshv_partition *partition = region->partition;
 	int ret;
 
@@ -499,12 +499,12 @@ static void mshv_region_destroy(struct kref *ref)
 	vfree(region);
 }
 
-void mshv_region_put(struct mshv_mem_region *region)
+void mshv_region_put(struct mshv_region *region)
 {
 	kref_put(&region->mreg_refcount, mshv_region_destroy);
 }
 
-int mshv_region_get(struct mshv_mem_region *region)
+int mshv_region_get(struct mshv_region *region)
 {
 	return kref_get_unless_zero(&region->mreg_refcount);
 }
@@ -534,7 +534,7 @@ int mshv_region_get(struct mshv_mem_region *region)
  *
  * Return: 0 on success, a negative error code otherwise.
  */
-static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
+static int mshv_region_hmm_fault_and_lock(struct mshv_region *region,
 					  unsigned long start,
 					  unsigned long end,
 					  unsigned long *pfns,
@@ -613,7 +613,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
  *
  * Return: 0 on success, negative errno on failure.
  */
-static int mshv_region_collect_and_map(struct mshv_mem_region *region,
+static int mshv_region_collect_and_map(struct mshv_region *region,
 				       u64 pfn_offset, u64 pfn_count,
 				       bool do_fault)
 {
@@ -653,14 +653,14 @@ static int mshv_region_collect_and_map(struct mshv_mem_region *region,
 	return ret;
 }
 
-static int mshv_region_range_fault(struct mshv_mem_region *region,
+static int mshv_region_range_fault(struct mshv_region *region,
 				   u64 pfn_offset, u64 pfn_count)
 {
 	return mshv_region_collect_and_map(region, pfn_offset, pfn_count,
 					   true);
 }
 
-bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn)
+bool mshv_region_handle_gfn_fault(struct mshv_region *region, u64 gfn)
 {
 	u64 pfn_offset, pfn_count;
 	int ret;
@@ -706,9 +706,9 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 					    const struct mmu_notifier_range *range,
 					    unsigned long cur_seq)
 {
-	struct mshv_mem_region *region = container_of(mni,
-						      struct mshv_mem_region,
-						      mreg_mni);
+	struct mshv_region *region = container_of(mni,
+						  struct mshv_region,
+						  mreg_mni);
 	u64 pfn_offset, pfn_count;
 	unsigned long mstart, mend;
 	int ret = -EPERM;
@@ -767,7 +767,7 @@ static const struct mmu_interval_notifier_ops mshv_region_mni_ops = {
  *
  * Return: 0 on success, negative error code on failure.
  */
-static int mshv_map_pinned_region(struct mshv_mem_region *region)
+static int mshv_map_pinned_region(struct mshv_region *region)
 {
 	struct mshv_partition *partition = region->partition;
 	int ret;
@@ -823,13 +823,13 @@ static int mshv_map_pinned_region(struct mshv_mem_region *region)
 	return ret;
 }
 
-static int mshv_map_movable_region(struct mshv_mem_region *region)
+static int mshv_map_movable_region(struct mshv_region *region)
 {
 	return mshv_region_collect_and_map(region, 0, region->nr_pfns,
 					   false);
 }
 
-static int mshv_map_mmio_region(struct mshv_mem_region *region)
+static int mshv_map_mmio_region(struct mshv_region *region)
 {
 	struct mshv_partition *partition = region->partition;
 
@@ -838,7 +838,7 @@ static int mshv_map_mmio_region(struct mshv_mem_region *region)
 				     region->nr_pfns);
 }
 
-int mshv_map_region(struct mshv_mem_region *region)
+int mshv_map_region(struct mshv_region *region)
 {
 	switch (region->mreg_type) {
 	case MSHV_REGION_TYPE_MEM_PINNED:
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 2bcdfa070517..97659ba55418 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -81,7 +81,7 @@ enum mshv_region_type {
 	MSHV_REGION_TYPE_MMIO
 };
 
-struct mshv_mem_region {
+struct mshv_region {
 	struct hlist_node hnode;
 	struct kref mreg_refcount;
 	u64 nr_pfns;
@@ -367,13 +367,13 @@ extern struct mshv_root mshv_root;
 extern enum hv_scheduler_type hv_scheduler_type;
 extern u8 * __percpu *hv_synic_eventring_tail;
 
-struct mshv_mem_region *mshv_region_create(enum mshv_region_type type,
-					   u64 guest_pfn, u64 nr_pfns,
-					   u64 uaddr, u32 flags,
-					   ulong mmio_pfn);
-void mshv_region_put(struct mshv_mem_region *region);
-int mshv_region_get(struct mshv_mem_region *region);
-bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
-int mshv_map_region(struct mshv_mem_region *region);
+struct mshv_region *mshv_region_create(enum mshv_region_type type,
+				       u64 guest_pfn, u64 nr_pfns,
+				       u64 uaddr, u32 flags,
+				       ulong mmio_pfn);
+void mshv_region_put(struct mshv_region *region);
+int mshv_region_get(struct mshv_region *region);
+bool mshv_region_handle_gfn_fault(struct mshv_region *region, u64 gfn);
+int mshv_map_region(struct mshv_region *region);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 3bfa9e9c575f..9d83a2348655 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -612,10 +612,10 @@ static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
 static_assert(sizeof(struct hv_message) <= MSHV_RUN_VP_BUF_SZ,
 	      "sizeof(struct hv_message) must not exceed MSHV_RUN_VP_BUF_SZ");
 
-static struct mshv_mem_region *
+static struct mshv_region *
 mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 {
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 
 	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
 		if (gfn >= region->start_gfn &&
@@ -626,10 +626,10 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 	return NULL;
 }
 
-static struct mshv_mem_region *
+static struct mshv_region *
 mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 {
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 
 	spin_lock(&p->pt_mem_regions_lock);
 	region = mshv_partition_region_by_gfn(p, gfn);
@@ -656,7 +656,7 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 {
 	struct mshv_partition *p = vp->vp_partition;
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 	bool ret = false;
 	u64 gfn;
 #if defined(CONFIG_X86_64)
@@ -1217,9 +1217,9 @@ static void mshv_async_hvcall_handler(void *data, u64 *status)
  */
 static int mshv_partition_create_region(struct mshv_partition *partition,
 					struct mshv_user_mem_region *mem,
-					struct mshv_mem_region **regionpp)
+					struct mshv_region **regionpp)
 {
-	struct mshv_mem_region *rg;
+	struct mshv_region *rg;
 	enum mshv_region_type type;
 	u64 nr_pfns = HVPFN_DOWN(mem->size);
 	struct vm_area_struct *vma;
@@ -1282,7 +1282,7 @@ static long
 mshv_map_user_memory(struct mshv_partition *partition,
 		     struct mshv_user_mem_region mem)
 {
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 	long ret;
 
 	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
@@ -1318,7 +1318,7 @@ static long
 mshv_unmap_user_memory(struct mshv_partition *partition,
 		       struct mshv_user_mem_region mem)
 {
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 
 	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
 		return -EINVAL;
@@ -1690,7 +1690,7 @@ remove_partition(struct mshv_partition *partition)
 static void destroy_partition(struct mshv_partition *partition)
 {
 	struct mshv_vp *vp;
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 	struct hlist_node *n;
 	int i;
 



