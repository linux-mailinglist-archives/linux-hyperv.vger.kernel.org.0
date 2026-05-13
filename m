Return-Path: <linux-hyperv+bounces-10861-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB2oHi/KBGp2OwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10861-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:59:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F335D539725
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F37D3086A34
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC93ADB8F;
	Wed, 13 May 2026 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jcVho9++"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56973346AD4;
	Wed, 13 May 2026 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698482; cv=none; b=brY/VbpGJaUIqmyRFJdC9Y+VQI90/4wbpGR/5D/1OBfSBK4B8Sl65JMsh9KdJPQwN1iAqhVM7Dp45vwaXe6e8BKmn7HoUBBwmE/oQsCVn6BdOIlwaPCNfxKro/g6UZnA7l6Cahqe+FD2cL6VGygVA7VyqoHisT+D+De7PQxueNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698482; c=relaxed/simple;
	bh=oat2KrIeRaGo2BxRG2Tj/eIJlPsGCyZAW9QpwThp6rM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAXOOyoonsu1pENsEhYU5mF9DYfFsS4qGVzHtacA6BI22Uyg2lsJF0btdGSuaLuWeSriAuFrBJYkL9VI1D2J58VlMJE9ueYq4Vwc/lfZor3pruCxa5roAWktnfkOk36XJ+xa5IXp4cC48kxJklQsCqRc5oQEtINw5gt8hYSI5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jcVho9++; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id EF6C420B7166;
	Wed, 13 May 2026 11:54:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF6C420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698478;
	bh=qpQgjF5gSdXTDGBMQsOH9wSvlYwXQo/HrmZaT0GO/Ig=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jcVho9++QeKb2OTEeg708fNyVqD1KaBDH9jdGfTO1yGpwlsC6TrgdbE/C9m5CiXsR
	 dLRrz3Y9/U/oHZtuT5WnL7Ks3JaP6PmuOqL73fxP9VOsMVi/xI7SVnVqH1xAhsvJ98
	 igjZqFXOYkryVQ0w5aDrdiqd+cyo1A/fsq2tSrGg=
Subject: [PATCH v4 1/6] mshv: Consolidate region creation and mapping
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:54:40 +0000
Message-ID: 
 <177869848061.19379.10429546765960770664.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: F335D539725
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10861-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

Consolidate region type detection and initialization into
mshv_region_create() to simplify the region creation flow. Move type
determination logic (MMIO/pinned/movable) earlier in the process and
initialize type-specific fields during creation rather than after.

Movable region initialization now fails explicitly if
mmu_interval_notifier_insert() returns an error, rather than silently
falling back to pinned memory. This fail-fast approach makes
configuration issues more visible.

This eliminates the need for mshv_region_movable_init/fini() by
handling MMU interval notifier setup directly in the constructor and
teardown in the destructor. Region mapping is also unified through a
single mshv_map_region() dispatcher that routes to the appropriate
type-specific handler, reducing the exported API surface by 5
functions.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c   |   83 ++++++++++++++++++++++++++++---------------
 drivers/hv/mshv_root.h      |   15 ++++----
 drivers/hv/mshv_root_main.c |   61 ++++++++++++--------------------
 3 files changed, 85 insertions(+), 74 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 7bcfba9ebac12..894eb4dcad93f 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -25,6 +25,8 @@
 
 #define MSHV_INVALID_PFN				ULONG_MAX
 
+static const struct mmu_interval_notifier_ops mshv_region_mni_ops;
+
 static inline bool mshv_pfn_valid(unsigned long pfn)
 {
 	return pfn != MSHV_INVALID_PFN;
@@ -200,15 +202,21 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 	return 0;
 }
 
-struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pfns,
-					   u64 uaddr, u32 flags)
+struct mshv_mem_region *mshv_region_create(struct mshv_partition *partition,
+					   enum mshv_region_type type,
+					   u64 guest_pfn, u64 nr_pfns,
+					   u64 uaddr, u32 flags,
+					   unsigned long mmio_pfn)
 {
 	struct mshv_mem_region *region;
+	int ret = 0;
 
 	region = vzalloc(struct_size(region, mreg_pfns, nr_pfns));
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 
+	region->partition = partition;
+	region->mreg_type = type;
 	region->nr_pfns = nr_pfns;
 	region->start_gfn = guest_pfn;
 	region->start_uaddr = uaddr;
@@ -220,9 +228,33 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pfns,
 
 	mshv_region_init_pfns(region);
 
+	mutex_init(&region->mreg_mutex);
 	kref_init(&region->mreg_refcount);
 
+	switch (type) {
+	case MSHV_REGION_TYPE_MEM_MOVABLE:
+		ret = mmu_interval_notifier_insert(&region->mreg_mni,
+						   current->mm, uaddr,
+						   nr_pfns << HV_HYP_PAGE_SHIFT,
+						   &mshv_region_mni_ops);
+		break;
+	case MSHV_REGION_TYPE_MEM_PINNED:
+		break;
+	case MSHV_REGION_TYPE_MMIO:
+		region->mreg_mmio_pfn = mmio_pfn;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		goto free_region;
+
 	return region;
+
+free_region:
+	vfree(region);
+	return ERR_PTR(ret);
 }
 
 static int mshv_region_chunk_share(struct mshv_mem_region *region,
@@ -422,7 +454,7 @@ static void mshv_region_destroy(struct kref *ref)
 	int ret;
 
 	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
-		mshv_region_movable_fini(region);
+		mmu_interval_notifier_remove(&region->mreg_mni);
 
 	if (mshv_partition_encrypted(partition)) {
 		ret = mshv_region_share(region);
@@ -709,27 +741,6 @@ static const struct mmu_interval_notifier_ops mshv_region_mni_ops = {
 	.invalidate = mshv_region_interval_invalidate,
 };
 
-void mshv_region_movable_fini(struct mshv_mem_region *region)
-{
-	mmu_interval_notifier_remove(&region->mreg_mni);
-}
-
-bool mshv_region_movable_init(struct mshv_mem_region *region)
-{
-	int ret;
-
-	ret = mmu_interval_notifier_insert(&region->mreg_mni, current->mm,
-					   region->start_uaddr,
-					   region->nr_pfns << HV_HYP_PAGE_SHIFT,
-					   &mshv_region_mni_ops);
-	if (ret)
-		return false;
-
-	mutex_init(&region->mreg_mutex);
-
-	return true;
-}
-
 /**
  * mshv_map_pinned_region - Pin and map memory regions
  * @region: Pointer to the memory region structure
@@ -743,7 +754,7 @@ bool mshv_region_movable_init(struct mshv_mem_region *region)
  *
  * Return: 0 on success, negative error code on failure.
  */
-int mshv_map_pinned_region(struct mshv_mem_region *region)
+static int mshv_map_pinned_region(struct mshv_mem_region *region)
 {
 	struct mshv_partition *partition = region->partition;
 	int ret;
@@ -813,7 +824,7 @@ int mshv_map_pinned_region(struct mshv_mem_region *region)
  *
  * Returns: 0 on success, negative error code on failure.
  */
-int mshv_map_movable_region(struct mshv_mem_region *region)
+static int mshv_map_movable_region(struct mshv_mem_region *region)
 {
 	u64 pfn, count;
 	int ret;
@@ -831,10 +842,24 @@ int mshv_map_movable_region(struct mshv_mem_region *region)
 	return 0;
 }
 
-int mshv_map_mmio_region(struct mshv_mem_region *region,
-			 unsigned long mmio_pfn)
+static int mshv_map_mmio_region(struct mshv_mem_region *region)
 {
 	return hv_call_map_mmio_pfns(region->partition->pt_id,
 				     region->start_gfn,
-				     mmio_pfn, region->nr_pfns);
+				     region->mreg_mmio_pfn,
+				     region->nr_pfns);
+}
+
+int mshv_map_region(struct mshv_mem_region *region)
+{
+	switch (region->mreg_type) {
+	case MSHV_REGION_TYPE_MEM_PINNED:
+		return mshv_map_pinned_region(region);
+	case MSHV_REGION_TYPE_MEM_MOVABLE:
+		return mshv_map_movable_region(region);
+	case MSHV_REGION_TYPE_MMIO:
+		return mshv_map_mmio_region(region);
+	default:
+		return -EINVAL;
+	}
 }
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index b091db06390b0..40fcf57219ece 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -93,6 +93,7 @@ struct mshv_mem_region {
 	enum mshv_region_type mreg_type;
 	struct mmu_interval_notifier mreg_mni;
 	struct mutex mreg_mutex;	/* protects region PFNs remapping */
+	u64 mreg_mmio_pfn;
 	unsigned long mreg_pfns[];
 };
 
@@ -369,17 +370,15 @@ extern struct mshv_root mshv_root;
 extern enum hv_scheduler_type hv_scheduler_type;
 extern u8 * __percpu *hv_synic_eventring_tail;
 
-struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
-					   u64 uaddr, u32 flags);
+struct mshv_mem_region *mshv_region_create(struct mshv_partition *partition,
+					   enum mshv_region_type type,
+					   u64 guest_pfn, u64 nr_pfns,
+					   u64 uaddr, u32 flags,
+					   unsigned long mmio_pfn);
 void mshv_region_init_pfns(struct mshv_mem_region *region);
 void mshv_region_put(struct mshv_mem_region *region);
 int mshv_region_get(struct mshv_mem_region *region);
 bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
-void mshv_region_movable_fini(struct mshv_mem_region *region);
-bool mshv_region_movable_init(struct mshv_mem_region *region);
-int mshv_map_pinned_region(struct mshv_mem_region *region);
-int mshv_map_movable_region(struct mshv_mem_region *region);
-int mshv_map_mmio_region(struct mshv_mem_region *region,
-			 unsigned long mmio_pfn);
+int mshv_map_region(struct mshv_mem_region *region);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index d5197559d7650..68609f2452b3a 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1309,11 +1309,14 @@ static void mshv_async_hvcall_handler(void *data, u64 *status)
  */
 static int mshv_partition_create_region(struct mshv_partition *partition,
 					struct mshv_user_mem_region *mem,
-					struct mshv_mem_region **regionpp,
-					bool is_mmio)
+					struct mshv_mem_region **regionpp)
 {
 	struct mshv_mem_region *rg;
+	enum mshv_region_type type;
 	u64 nr_pfns = HVPFN_DOWN(mem->size);
+	struct vm_area_struct *vma;
+	ulong mmio_pfn;
+	bool is_mmio;
 
 	/* Reject overlapping regions */
 	spin_lock(&partition->pt_mem_regions_lock);
@@ -1326,20 +1329,27 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 	}
 	spin_unlock(&partition->pt_mem_regions_lock);
 
-	rg = mshv_region_create(mem->guest_pfn, nr_pfns,
-				mem->userspace_addr, mem->flags);
-	if (IS_ERR(rg))
-		return PTR_ERR(rg);
+	mmap_read_lock(current->mm);
+	vma = vma_lookup(current->mm, mem->userspace_addr);
+	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
+	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
+	mmap_read_unlock(current->mm);
+
+	if (!vma)
+		return -EINVAL;
 
 	if (is_mmio)
-		rg->mreg_type = MSHV_REGION_TYPE_MMIO;
-	else if (mshv_partition_encrypted(partition) ||
-		 !mshv_region_movable_init(rg))
-		rg->mreg_type = MSHV_REGION_TYPE_MEM_PINNED;
+		type = MSHV_REGION_TYPE_MMIO;
+	else if (mshv_partition_encrypted(partition))
+		type = MSHV_REGION_TYPE_MEM_PINNED;
 	else
-		rg->mreg_type = MSHV_REGION_TYPE_MEM_MOVABLE;
+		type = MSHV_REGION_TYPE_MEM_MOVABLE;
 
-	rg->partition = partition;
+	rg = mshv_region_create(partition, type, mem->guest_pfn, nr_pfns,
+				mem->userspace_addr, mem->flags,
+				mmio_pfn);
+	if (IS_ERR(rg))
+		return PTR_ERR(rg);
 
 	*regionpp = rg;
 
@@ -1363,40 +1373,17 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		     struct mshv_user_mem_region *mem)
 {
 	struct mshv_mem_region *region;
-	struct vm_area_struct *vma;
-	bool is_mmio;
-	ulong mmio_pfn;
 	long ret;
 
 	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
 	    !access_ok((const void __user *)mem->userspace_addr, mem->size))
 		return -EINVAL;
 
-	mmap_read_lock(current->mm);
-	vma = vma_lookup(current->mm, mem->userspace_addr);
-	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
-	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
-	mmap_read_unlock(current->mm);
-
-	if (!vma)
-		return -EINVAL;
-
-	ret = mshv_partition_create_region(partition, mem, &region,
-					   is_mmio);
+	ret = mshv_partition_create_region(partition, mem, &region);
 	if (ret)
 		return ret;
 
-	switch (region->mreg_type) {
-	case MSHV_REGION_TYPE_MEM_PINNED:
-		ret = mshv_map_pinned_region(region);
-		break;
-	case MSHV_REGION_TYPE_MEM_MOVABLE:
-		ret = mshv_map_movable_region(region);
-		break;
-	case MSHV_REGION_TYPE_MMIO:
-		ret = mshv_map_mmio_region(region, mmio_pfn);
-		break;
-	}
+	ret = mshv_map_region(region);
 
 	trace_mshv_map_user_memory(partition->pt_id, region->start_uaddr,
 				   region->start_gfn, region->nr_pfns,



