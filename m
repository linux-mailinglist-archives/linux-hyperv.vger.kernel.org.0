Return-Path: <linux-hyperv+bounces-10862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPn/LPXLBGrMPAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10862-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:07:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF4B539970
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFD0A305EABC
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5DE38E11A;
	Wed, 13 May 2026 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q2ExZPvb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE3E346AD4;
	Wed, 13 May 2026 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698488; cv=none; b=GqAgV8mUl/lNnjkx759r79qmfe5Qxaf5QkjlicfqOVYVEDuD9fv8S1YnecG6Q0UFYab1+gU9Rxoh1bbY89EkLu4fmqIBYUNTh5k6sTSk05sjJfx3Cch6tjtz9Fi26T4awH20xWkIDK2vCM6n50xz4xs5oSspsWrxmHaLBLA9tck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698488; c=relaxed/simple;
	bh=V88ovEr2mhCxY4AboDfR/Hy5hAsylMDO2ygR23u3Mns=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmVKMskabJv7TkoWRmB0sRoPELmqTML31zVpa+8pPoBfUb9dReu8p6hbBb5lz3TdsNxPNSRITSRrDAqCFuiBk5Xb3WgbB+hKEltFNTJhpZVs2S0eQCJX/zNRtltCydMkrsWctA3QvYVA4/k6RGwBshdFSdfD3CilxF2DOV8swtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q2ExZPvb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 997A520B7166;
	Wed, 13 May 2026 11:54:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 997A520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698483;
	bh=kikw/if6p5C5PvazUrNiKdIQ4Ld5vlDfdqrd06RQOfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=q2ExZPvbPzhXgwrjmg/E3m0qkveJDhVsA7Iqad17fs8wdK0c43n8ot5m6cmGAHYRQ
	 QfkSLMnIYheulk23Tg10lEY0QxOav6GT24Fw4mc31mp2w3X9rmWcSIYSVB6y0rGDpU
	 aihcyP22SNcIym1iqU2fCQTV5HeJC0sdklIj684E=
Subject: [PATCH v4 2/6] mshv: Rename mshv_mem_region to mshv_region
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:54:46 +0000
Message-ID: 
 <177869848626.19379.2719711345729409313.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: BDF4B539970
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10862-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
 drivers/hv/mshv_regions.c   |   76 ++++++++++++++++++++++---------------------
 drivers/hv/mshv_root.h      |   22 ++++++------
 drivers/hv/mshv_root_main.c |   22 ++++++------
 3 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 894eb4dcad93f..f81951ae3f808 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -32,7 +32,7 @@ static inline bool mshv_pfn_valid(unsigned long pfn)
 	return pfn != MSHV_INVALID_PFN;
 }
 
-static void mshv_region_init_pfns_range(struct mshv_mem_region *region,
+static void mshv_region_init_pfns_range(struct mshv_region *region,
 					u64 pfn_offset, u64 pfn_count)
 {
 	u64 i;
@@ -41,7 +41,7 @@ static void mshv_region_init_pfns_range(struct mshv_mem_region *region,
 		region->mreg_pfns[i] = MSHV_INVALID_PFN;
 }
 
-void mshv_region_init_pfns(struct mshv_mem_region *region)
+void mshv_region_init_pfns(struct mshv_region *region)
 {
 	mshv_region_init_pfns_range(region, 0, region->nr_pfns);
 }
@@ -106,7 +106,7 @@ static int mshv_chunk_stride(unsigned long pfn, u64 gfn, u64 pfn_count)
  * Return: Length of the run in PFNs, or a negative errno from
  *         mshv_chunk_stride() if the backing folio order is unsupported.
  */
-static long mshv_region_chunk_size(struct mshv_mem_region *region,
+static long mshv_region_chunk_size(struct mshv_region *region,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool *huge_page)
 {
@@ -164,10 +164,10 @@ static long mshv_region_chunk_size(struct mshv_mem_region *region,
  *
  * Returns 0 on success, or a negative error code on failure.
  */
-static int mshv_region_process_range(struct mshv_mem_region *region,
+static int mshv_region_process_range(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
-				     int (*handler)(struct mshv_mem_region *region,
+				     int (*handler)(struct mshv_region *region,
 						    u32 flags,
 						    u64 pfn_offset,
 						    u64 pfn_count,
@@ -202,13 +202,13 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 	return 0;
 }
 
-struct mshv_mem_region *mshv_region_create(struct mshv_partition *partition,
-					   enum mshv_region_type type,
-					   u64 guest_pfn, u64 nr_pfns,
-					   u64 uaddr, u32 flags,
-					   unsigned long mmio_pfn)
+struct mshv_region *mshv_region_create(struct mshv_partition *partition,
+				       enum mshv_region_type type,
+				       u64 guest_pfn, u64 nr_pfns,
+				       u64 uaddr, u32 flags,
+				       unsigned long mmio_pfn)
 {
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 	int ret = 0;
 
 	region = vzalloc(struct_size(region, mreg_pfns, nr_pfns));
@@ -257,7 +257,7 @@ struct mshv_mem_region *mshv_region_create(struct mshv_partition *partition,
 	return ERR_PTR(ret);
 }
 
-static int mshv_region_chunk_share(struct mshv_mem_region *region,
+static int mshv_region_chunk_share(struct mshv_region *region,
 				   u32 flags,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
@@ -276,7 +276,7 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
 					      flags, true);
 }
 
-static int mshv_region_share(struct mshv_mem_region *region)
+static int mshv_region_share(struct mshv_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
 
@@ -285,7 +285,7 @@ static int mshv_region_share(struct mshv_mem_region *region)
 					 mshv_region_chunk_share);
 }
 
-static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
+static int mshv_region_chunk_unshare(struct mshv_region *region,
 				     u32 flags,
 				     u64 pfn_offset, u64 pfn_count,
 				     bool huge_page)
@@ -302,7 +302,7 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 					      flags, false);
 }
 
-static int mshv_region_unshare(struct mshv_mem_region *region)
+static int mshv_region_unshare(struct mshv_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
 
@@ -311,7 +311,7 @@ static int mshv_region_unshare(struct mshv_mem_region *region)
 					 mshv_region_chunk_unshare);
 }
 
-static int mshv_region_chunk_remap(struct mshv_mem_region *region,
+static int mshv_region_chunk_remap(struct mshv_region *region,
 				   u32 flags,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
@@ -333,7 +333,7 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
 				    region->mreg_pfns + pfn_offset);
 }
 
-static int mshv_region_remap_pfns(struct mshv_mem_region *region,
+static int mshv_region_remap_pfns(struct mshv_region *region,
 				  u32 map_flags,
 				  u64 pfn_offset, u64 pfn_count)
 {
@@ -342,7 +342,7 @@ static int mshv_region_remap_pfns(struct mshv_mem_region *region,
 					 mshv_region_chunk_remap);
 }
 
-static int mshv_region_map(struct mshv_mem_region *region)
+static int mshv_region_map(struct mshv_region *region)
 {
 	u32 map_flags = region->hv_map_flags;
 
@@ -350,7 +350,7 @@ static int mshv_region_map(struct mshv_mem_region *region)
 				      0, region->nr_pfns);
 }
 
-static void mshv_region_invalidate_pfns(struct mshv_mem_region *region,
+static void mshv_region_invalidate_pfns(struct mshv_region *region,
 					u64 pfn_offset, u64 pfn_count)
 {
 	u64 i;
@@ -366,12 +366,12 @@ static void mshv_region_invalidate_pfns(struct mshv_mem_region *region,
 	mshv_region_init_pfns_range(region, pfn_offset, pfn_count);
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
@@ -426,7 +426,7 @@ static int mshv_region_pin(struct mshv_mem_region *region)
 	return ret < 0 ? ret : -ENOMEM;
 }
 
-static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
+static int mshv_region_chunk_unmap(struct mshv_region *region,
 				   u32 flags,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
@@ -439,7 +439,7 @@ static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 				  pfn_count, flags);
 }
 
-static int mshv_region_unmap(struct mshv_mem_region *region)
+static int mshv_region_unmap(struct mshv_region *region)
 {
 	return mshv_region_process_range(region, 0,
 					 0, region->nr_pfns,
@@ -448,8 +448,8 @@ static int mshv_region_unmap(struct mshv_mem_region *region)
 
 static void mshv_region_destroy(struct kref *ref)
 {
-	struct mshv_mem_region *region =
-		container_of(ref, struct mshv_mem_region, mreg_refcount);
+	struct mshv_region *region =
+		container_of(ref, struct mshv_region, mreg_refcount);
 	struct mshv_partition *partition = region->partition;
 	int ret;
 
@@ -473,12 +473,12 @@ static void mshv_region_destroy(struct kref *ref)
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
@@ -505,7 +505,7 @@ int mshv_region_get(struct mshv_mem_region *region)
  *
  * Return: 0 on success, negative error code on failure.
  */
-static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
+static int mshv_region_hmm_fault_and_lock(struct mshv_region *region,
 					  unsigned long start,
 					  unsigned long end,
 					  unsigned long *pfns,
@@ -595,7 +595,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
  *
  * Return: 0 on success, negative errno on failure.
  */
-static int mshv_region_collect_and_map(struct mshv_mem_region *region,
+static int mshv_region_collect_and_map(struct mshv_region *region,
 				       u64 pfn_offset, u64 pfn_count,
 				       bool do_fault)
 {
@@ -640,14 +640,14 @@ static int mshv_region_collect_and_map(struct mshv_mem_region *region,
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
@@ -693,9 +693,9 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
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
@@ -754,7 +754,7 @@ static const struct mmu_interval_notifier_ops mshv_region_mni_ops = {
  *
  * Return: 0 on success, negative error code on failure.
  */
-static int mshv_map_pinned_region(struct mshv_mem_region *region)
+static int mshv_map_pinned_region(struct mshv_region *region)
 {
 	struct mshv_partition *partition = region->partition;
 	int ret;
@@ -824,7 +824,7 @@ static int mshv_map_pinned_region(struct mshv_mem_region *region)
  *
  * Returns: 0 on success, negative error code on failure.
  */
-static int mshv_map_movable_region(struct mshv_mem_region *region)
+static int mshv_map_movable_region(struct mshv_region *region)
 {
 	u64 pfn, count;
 	int ret;
@@ -842,7 +842,7 @@ static int mshv_map_movable_region(struct mshv_mem_region *region)
 	return 0;
 }
 
-static int mshv_map_mmio_region(struct mshv_mem_region *region)
+static int mshv_map_mmio_region(struct mshv_region *region)
 {
 	return hv_call_map_mmio_pfns(region->partition->pt_id,
 				     region->start_gfn,
@@ -850,7 +850,7 @@ static int mshv_map_mmio_region(struct mshv_mem_region *region)
 				     region->nr_pfns);
 }
 
-int mshv_map_region(struct mshv_mem_region *region)
+int mshv_map_region(struct mshv_region *region)
 {
 	switch (region->mreg_type) {
 	case MSHV_REGION_TYPE_MEM_PINNED:
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 40fcf57219ece..e9bd18013b486 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -82,7 +82,7 @@ enum mshv_region_type {
 	MSHV_REGION_TYPE_MMIO
 };
 
-struct mshv_mem_region {
+struct mshv_region {
 	struct hlist_node hnode;
 	struct kref mreg_refcount;
 	u64 nr_pfns;
@@ -370,15 +370,15 @@ extern struct mshv_root mshv_root;
 extern enum hv_scheduler_type hv_scheduler_type;
 extern u8 * __percpu *hv_synic_eventring_tail;
 
-struct mshv_mem_region *mshv_region_create(struct mshv_partition *partition,
-					   enum mshv_region_type type,
-					   u64 guest_pfn, u64 nr_pfns,
-					   u64 uaddr, u32 flags,
-					   unsigned long mmio_pfn);
-void mshv_region_init_pfns(struct mshv_mem_region *region);
-void mshv_region_put(struct mshv_mem_region *region);
-int mshv_region_get(struct mshv_mem_region *region);
-bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
-int mshv_map_region(struct mshv_mem_region *region);
+struct mshv_region *mshv_region_create(struct mshv_partition *partition,
+				       enum mshv_region_type type,
+				       u64 guest_pfn, u64 nr_pfns,
+				       u64 uaddr, u32 flags,
+				       unsigned long mmio_pfn);
+void mshv_region_init_pfns(struct mshv_region *region);
+void mshv_region_put(struct mshv_region *region);
+int mshv_region_get(struct mshv_region *region);
+bool mshv_region_handle_gfn_fault(struct mshv_region *region, u64 gfn);
+int mshv_map_region(struct mshv_region *region);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 68609f2452b3a..0e9d14d1d6167 100644
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
@@ -933,7 +933,7 @@ mshv_vp_ioctl_translate_gva(struct mshv_vp *vp, void __user *user_args)
 			return ret;
 
 		if (mshv_gpa_fault_retryable(result.result_code)) {
-			struct mshv_mem_region *region;
+			struct mshv_region *region;
 			bool faulted;
 
 			region = mshv_partition_region_by_gfn_get(partition,
@@ -1309,9 +1309,9 @@ static void mshv_async_hvcall_handler(void *data, u64 *status)
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
@@ -1372,7 +1372,7 @@ static long
 mshv_map_user_memory(struct mshv_partition *partition,
 		     struct mshv_user_mem_region *mem)
 {
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 	long ret;
 
 	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
@@ -1408,7 +1408,7 @@ static long
 mshv_unmap_user_memory(struct mshv_partition *partition,
 		       struct mshv_user_mem_region *mem)
 {
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 
 	if (!(mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
 		return -EINVAL;
@@ -1780,7 +1780,7 @@ remove_partition(struct mshv_partition *partition)
 static void destroy_partition(struct mshv_partition *partition)
 {
 	struct mshv_vp *vp;
-	struct mshv_mem_region *region;
+	struct mshv_region *region;
 	struct hlist_node *n;
 	int i;
 



