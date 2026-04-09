Return-Path: <linux-hyperv+bounces-10097-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIoDHNrE12mdSQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10097-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 17:25:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90663CC9AD
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 17:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51EB6301F25E
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Apr 2026 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32053BBA0B;
	Thu,  9 Apr 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ADEQHvNZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689563DF001;
	Thu,  9 Apr 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748258; cv=none; b=fpb1Aq7ilEDqnPZ55NrfnkyEumX0uyLNZA6S+KiZiFHvk/nfyb+/jRzP8Wuf6ZDniFByT7SYVmJnbUZeC69EFnu7mTG65VCXyZeXZmOx/pdUfTJJbnx2qp0pymTmhizrWKJQSep8e2VDwKYe5WtGBk6CiZl27P0HrL1RMi0N3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748258; c=relaxed/simple;
	bh=RmpSCqwT4YQ1EyJHvyjCOzZOsgJOwzySJ8ZR3T9XQ7U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCBBxqr25+nWKZthQlY1K0M9yYtrcM0ZdGTNcE95tB8sHU99oYUU1aqrVJGDEKfS8HpijPkfkaQruRHf3A+38FvNChXutNgssxrLYYk9WnT1Js8E3NrnNT+ZjCggBeJPct/gSCt+yqtL7PJEuFjRZ3QI1e96L3WcARP6tvhY0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ADEQHvNZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB45F20B6F08;
	Thu,  9 Apr 2026 08:24:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB45F20B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775748256;
	bh=W/2AUmh+gShLThqDUVkP8uBrGs1HupE09J2+Uc+67W8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ADEQHvNZnX0I8Wr0XEaK6lfFckY+LwXCUSilpnZ6z8O6jh+StL0J90E0njS99mxdg
	 CBK12HJdd6+NGbYIJvxhjxfBi9Y+WqGmOWQobAAYkAVzi1/m+5HS/mgIpNqd8eKPuN
	 IchwITD4OZnINbgfETm241W4wHtgBMcOjSjiTjCg=
Subject: [PATCH v3 3/7] mshv: Rename mshv_mem_region to mshv_region
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 09 Apr 2026 15:24:16 +0000
Message-ID: 
 <177574825658.19719.7922237851991205296.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10097-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A90663CC9AD
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
 



