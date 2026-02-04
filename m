Return-Path: <linux-hyperv+bounces-8720-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PpUFsWqg2lvsgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8720-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 21:23:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE76EEC6AD
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 21:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F1B53009B0D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B09B340283;
	Wed,  4 Feb 2026 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nL9+w5Pl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA44823C51D
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Feb 2026 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236610; cv=none; b=fzkfL+q57XkaWS3ysWXuu1a9MwLHjHXr8KyBitoQl8EmU8mM+jE15sQzk09JyMKGeVyXNIiiV6jEiz4ed8nSmrpL9TDPSeX/1s7wJkXOApeapoQQKdpwam6dOavhirU0MRZLJ3Gjcc4kzm/lqmv4+AvflIJA/p+PfMeCv2F7Yf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236610; c=relaxed/simple;
	bh=lcG+XeVoSjKClWx8WO6IYpeKsjsS9FLO8oTcVruLA8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMDZHOBbR3r757qQwHQNuJKoQUaSYhIMm8H1P230l7fKXnkg3zlBvdkEQt5y42uHfU7fBU9gHIsZO1w41mBDoIjlFzmLFBVyKmsjK+YbtnFjytFio3JRh+Lcph7S2FeahtCvgLjInB3UjRvaQwRBFjR0gB32x3bAeTozjkijMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nL9+w5Pl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 32C1020B7165;
	Wed,  4 Feb 2026 12:23:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32C1020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770236610;
	bh=bB2XXVY2CGFUz00tLoIEIs22IS9QlCYElskstBWmZW0=;
	h=From:To:Cc:Subject:Date:From;
	b=nL9+w5PlAOCIznDdBg3QRn8gNybHqEFkXgvpUnqAv7FlKi77bj3dzgyzlvTbUQhkZ
	 pVKw8elBjCzMuJP0U65NVtUfCBr2/381ftbIIk4dZm7u5D15pFIxGOMN9Ts97AmiE5
	 tTXUBqk2K0IYLU6EyW0Bm7pe03mS3grnu8JdVSKc=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: wei.liu@kernel.org
Subject: [PATCH v3] mshv: make field names descriptive in a header struct
Date: Wed,  4 Feb 2026 12:23:28 -0800
Message-ID: <20260204202328.196690-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8720-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE76EEC6AD
X-Rspamd-Action: no action

When struct fields use very common names like "pages" or "type", it makes
it difficult to find uses of these fields with tools like grep, cscope,
etc when the struct is in a header file included in many places. Add
prefix mreg_ to some fields in struct mshv_mem_region to make it easier
to find them.

There is no functional change.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
V3: rebase to afefdb2bc945 (origin/hyperv-next)
---
 drivers/hv/mshv_regions.c   | 60 ++++++++++++++++++-------------------
 drivers/hv/mshv_root.h      | 10 +++----
 drivers/hv/mshv_root_main.c | 10 +++----
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index adba3564d9f1..c28aac0726de 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -88,7 +88,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
 	struct page *page;
 	int stride, ret;
 
-	page = region->pages[page_offset];
+	page = region->mreg_pages[page_offset];
 	if (!page)
 		return -EINVAL;
 
@@ -98,7 +98,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
 
 	/* Start at stride since the first stride is validated */
 	for (count = stride; count < page_count; count += stride) {
-		page = region->pages[page_offset + count];
+		page = region->mreg_pages[page_offset + count];
 
 		/* Break if current page is not present */
 		if (!page)
@@ -152,7 +152,7 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 
 	while (page_count) {
 		/* Skip non-present pages */
-		if (!region->pages[page_offset]) {
+		if (!region->mreg_pages[page_offset]) {
 			page_offset++;
 			page_count--;
 			continue;
@@ -190,7 +190,7 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
 		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
 
-	kref_init(&region->refcount);
+	kref_init(&region->mreg_refcount);
 
 	return region;
 }
@@ -204,7 +204,7 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->pages + page_offset,
+					      region->mreg_pages + page_offset,
 					      page_count,
 					      HV_MAP_GPA_READABLE |
 					      HV_MAP_GPA_WRITABLE,
@@ -229,7 +229,7 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->pages + page_offset,
+					      region->mreg_pages + page_offset,
 					      page_count, 0,
 					      flags, false);
 }
@@ -254,7 +254,7 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
 	return hv_call_map_gpa_pages(region->partition->pt_id,
 				     region->start_gfn + page_offset,
 				     page_count, flags,
-				     region->pages + page_offset);
+				     region->mreg_pages + page_offset);
 }
 
 static int mshv_region_remap_pages(struct mshv_mem_region *region,
@@ -277,10 +277,10 @@ int mshv_region_map(struct mshv_mem_region *region)
 static void mshv_region_invalidate_pages(struct mshv_mem_region *region,
 					 u64 page_offset, u64 page_count)
 {
-	if (region->type == MSHV_REGION_TYPE_MEM_PINNED)
-		unpin_user_pages(region->pages + page_offset, page_count);
+	if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
+		unpin_user_pages(region->mreg_pages + page_offset, page_count);
 
-	memset(region->pages + page_offset, 0,
+	memset(region->mreg_pages + page_offset, 0,
 	       page_count * sizeof(struct page *));
 }
 
@@ -297,7 +297,7 @@ int mshv_region_pin(struct mshv_mem_region *region)
 	int ret;
 
 	for (done_count = 0; done_count < region->nr_pages; done_count += ret) {
-		pages = region->pages + done_count;
+		pages = region->mreg_pages + done_count;
 		userspace_addr = region->start_uaddr +
 				 done_count * HV_HYP_PAGE_SIZE;
 		nr_pages = min(region->nr_pages - done_count,
@@ -348,11 +348,11 @@ static int mshv_region_unmap(struct mshv_mem_region *region)
 static void mshv_region_destroy(struct kref *ref)
 {
 	struct mshv_mem_region *region =
-		container_of(ref, struct mshv_mem_region, refcount);
+		container_of(ref, struct mshv_mem_region, mreg_refcount);
 	struct mshv_partition *partition = region->partition;
 	int ret;
 
-	if (region->type == MSHV_REGION_TYPE_MEM_MOVABLE)
+	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
 		mshv_region_movable_fini(region);
 
 	if (mshv_partition_encrypted(partition)) {
@@ -374,12 +374,12 @@ static void mshv_region_destroy(struct kref *ref)
 
 void mshv_region_put(struct mshv_mem_region *region)
 {
-	kref_put(&region->refcount, mshv_region_destroy);
+	kref_put(&region->mreg_refcount, mshv_region_destroy);
 }
 
 int mshv_region_get(struct mshv_mem_region *region)
 {
-	return kref_get_unless_zero(&region->refcount);
+	return kref_get_unless_zero(&region->mreg_refcount);
 }
 
 /**
@@ -405,16 +405,16 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
 	int ret;
 
 	range->notifier_seq = mmu_interval_read_begin(range->notifier);
-	mmap_read_lock(region->mni.mm);
+	mmap_read_lock(region->mreg_mni.mm);
 	ret = hmm_range_fault(range);
-	mmap_read_unlock(region->mni.mm);
+	mmap_read_unlock(region->mreg_mni.mm);
 	if (ret)
 		return ret;
 
-	mutex_lock(&region->mutex);
+	mutex_lock(&region->mreg_mutex);
 
 	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
-		mutex_unlock(&region->mutex);
+		mutex_unlock(&region->mreg_mutex);
 		cond_resched();
 		return -EBUSY;
 	}
@@ -438,7 +438,7 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 				   u64 page_offset, u64 page_count)
 {
 	struct hmm_range range = {
-		.notifier = &region->mni,
+		.notifier = &region->mreg_mni,
 		.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
 	};
 	unsigned long *pfns;
@@ -461,12 +461,12 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 		goto out;
 
 	for (i = 0; i < page_count; i++)
-		region->pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
+		region->mreg_pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
 
 	ret = mshv_region_remap_pages(region, region->hv_map_flags,
 				      page_offset, page_count);
 
-	mutex_unlock(&region->mutex);
+	mutex_unlock(&region->mreg_mutex);
 out:
 	kfree(pfns);
 	return ret;
@@ -520,7 +520,7 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 {
 	struct mshv_mem_region *region = container_of(mni,
 						      struct mshv_mem_region,
-						      mni);
+						      mreg_mni);
 	u64 page_offset, page_count;
 	unsigned long mstart, mend;
 	int ret = -EPERM;
@@ -533,8 +533,8 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	page_count = HVPFN_DOWN(mend - mstart);
 
 	if (mmu_notifier_range_blockable(range))
-		mutex_lock(&region->mutex);
-	else if (!mutex_trylock(&region->mutex))
+		mutex_lock(&region->mreg_mutex);
+	else if (!mutex_trylock(&region->mreg_mutex))
 		goto out_fail;
 
 	mmu_interval_set_seq(mni, cur_seq);
@@ -546,12 +546,12 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 
 	mshv_region_invalidate_pages(region, page_offset, page_count);
 
-	mutex_unlock(&region->mutex);
+	mutex_unlock(&region->mreg_mutex);
 
 	return true;
 
 out_unlock:
-	mutex_unlock(&region->mutex);
+	mutex_unlock(&region->mreg_mutex);
 out_fail:
 	WARN_ONCE(ret,
 		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u, pages %#llx-%#llx, mm: %#llx): %d\n",
@@ -568,21 +568,21 @@ static const struct mmu_interval_notifier_ops mshv_region_mni_ops = {
 
 void mshv_region_movable_fini(struct mshv_mem_region *region)
 {
-	mmu_interval_notifier_remove(&region->mni);
+	mmu_interval_notifier_remove(&region->mreg_mni);
 }
 
 bool mshv_region_movable_init(struct mshv_mem_region *region)
 {
 	int ret;
 
-	ret = mmu_interval_notifier_insert(&region->mni, current->mm,
+	ret = mmu_interval_notifier_insert(&region->mreg_mni, current->mm,
 					   region->start_uaddr,
 					   region->nr_pages << HV_HYP_PAGE_SHIFT,
 					   &mshv_region_mni_ops);
 	if (ret)
 		return false;
 
-	mutex_init(&region->mutex);
+	mutex_init(&region->mreg_mutex);
 
 	return true;
 }
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 7332d9af8373..04c2a1910a8a 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -82,16 +82,16 @@ enum mshv_region_type {
 
 struct mshv_mem_region {
 	struct hlist_node hnode;
-	struct kref refcount;
+	struct kref mreg_refcount;
 	u64 nr_pages;
 	u64 start_gfn;
 	u64 start_uaddr;
 	u32 hv_map_flags;
 	struct mshv_partition *partition;
-	enum mshv_region_type type;
-	struct mmu_interval_notifier mni;
-	struct mutex mutex;	/* protects region pages remapping */
-	struct page *pages[];
+	enum mshv_region_type mreg_type;
+	struct mmu_interval_notifier mreg_mni;
+	struct mutex mreg_mutex;	/* protects region pages remapping */
+	struct page *mreg_pages[];
 };
 
 struct mshv_irq_ack_notifier {
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index c633014ceb96..431aebf95bc7 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -650,7 +650,7 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 		return false;
 
 	/* Only movable memory ranges are supported for GPA intercepts */
-	if (region->type == MSHV_REGION_TYPE_MEM_MOVABLE)
+	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
 		ret = mshv_region_handle_gfn_fault(region, gfn);
 	else
 		ret = false;
@@ -1193,12 +1193,12 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 		return PTR_ERR(rg);
 
 	if (is_mmio)
-		rg->type = MSHV_REGION_TYPE_MMIO;
+		rg->mreg_type = MSHV_REGION_TYPE_MMIO;
 	else if (mshv_partition_encrypted(partition) ||
 		 !mshv_region_movable_init(rg))
-		rg->type = MSHV_REGION_TYPE_MEM_PINNED;
+		rg->mreg_type = MSHV_REGION_TYPE_MEM_PINNED;
 	else
-		rg->type = MSHV_REGION_TYPE_MEM_MOVABLE;
+		rg->mreg_type = MSHV_REGION_TYPE_MEM_MOVABLE;
 
 	rg->partition = partition;
 
@@ -1315,7 +1315,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	if (ret)
 		return ret;
 
-	switch (region->type) {
+	switch (region->mreg_type) {
 	case MSHV_REGION_TYPE_MEM_PINNED:
 		ret = mshv_prepare_pinned_region(region);
 		break;
-- 
2.51.2.vfs.0.1


