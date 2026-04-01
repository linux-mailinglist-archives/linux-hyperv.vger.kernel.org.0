Return-Path: <linux-hyperv+bounces-9885-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mObvBPuZzWkrfQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9885-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 00:19:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEA0380E39
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 00:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32EA5302A6A6
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A9341AB6;
	Wed,  1 Apr 2026 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WOvt1dv4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8B2334C28;
	Wed,  1 Apr 2026 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081551; cv=none; b=h2RH02XtORdCb71h8YOqlVFVpWPWRnWSZ1WejuKhF6bs4YKrvngGyvGPWop8osuiJVyctInecQkedKqq0bIsY1KXqlNKCGL29a2GEkEscH2n+gQ70hVySkZbXWS13BAW1jXFnzdZOLGYFSAM5yP42p0FI/6TcCN+1s/GWILZ9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081551; c=relaxed/simple;
	bh=muwUJ32bml/nF+YiMVKY+CAluETmkRtK7TxLUjLhplU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHdcdYwZFd/7OVClzgMqJjY3HoO46TehvpduvTp9W8SP1a8+XqnKDrwURugPTDbYDSo7BG2HlsdcE4o4enUeb8E8aMDJDLQjMlxynyqHm9e8rnmtz+v06fhy0N77k37oY+3HyNJgcY8oLhhbwxNF2sKIeHPik9+D2ZzO2WJxfW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WOvt1dv4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4523320B712B;
	Wed,  1 Apr 2026 15:12:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4523320B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775081550;
	bh=EFJNss2dGo5iUAhtzQYbH1F/6jqAV2xi3x3dWb1SDAI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WOvt1dv4Pm2wmngQiLNQUSPKxQHayn/0EQDr9Sy3IAEmM72pjoTdka8cJTSroapZ/
	 dNrUTKqiMvBRbZzEwaQM2QpXGzgF7PR04aCryODdDAh5D6LA37VXCq/MxA2kk/sjAH
	 Sjuf8piL6eGxX3XZpSReFBK4ujK9rDz/xkdIbO/U=
Subject: [PATCH 1/7] mshv: Consolidate region creation and mapping
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 01 Apr 2026 22:12:29 +0000
Message-ID: 
 <177508154971.215674.18078378131606994813.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9885-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 6DEA0380E39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Consolidate region type detection and initialization into
mshv_region_create() to simplify the region creation flow. Move type
determination logic (MMIO/pinned/movable) earlier in the process and
initialize type-specific fields during creation rather than after.

This eliminates the need for mshv_region_movable_init/fini() by
handling MMU interval notifier setup directly in the constructor and
teardown in the destructor. Region mapping is also unified through a
single mshv_map_region() dispatcher that routes to the appropriate
type-specific handler.

Changes improve code organization by:
- Reducing API surface (4 fewer exported functions)
- Centralizing type determination and validation
- Making region lifecycle more explicit and easier to follow
- Removing post-construction initialization steps

The refactoring maintains existing functionality while making the
codebase more maintainable and less error-prone.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c   |   81 ++++++++++++++++++++++++++++---------------
 drivers/hv/mshv_root.h      |   14 +++----
 drivers/hv/mshv_root_main.c |   61 +++++++++++++-------------------
 3 files changed, 83 insertions(+), 73 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 6b703b269a4f..a85d18e2c279 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -20,6 +20,8 @@
 #define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
 #define MSHV_INVALID_PFN				ULONG_MAX
 
+static const struct mmu_interval_notifier_ops mshv_region_mni_ops;
+
 /**
  * mshv_chunk_stride - Compute stride for mapping guest memory
  * @page      : The page to check for huge page backing
@@ -241,16 +243,39 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 	return 0;
 }
 
-struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pfns,
-					   u64 uaddr, u32 flags)
+struct mshv_mem_region *mshv_region_create(enum mshv_region_type type,
+					   u64 guest_pfn, u64 nr_pfns,
+					   u64 uaddr, u32 flags,
+					   ulong mmio_pfn)
 {
 	struct mshv_mem_region *region;
+	int ret = 0;
 	u64 i;
 
 	region = vzalloc(sizeof(*region) + sizeof(unsigned long) * nr_pfns);
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 
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
+	region->mreg_type = type;
 	region->nr_pfns = nr_pfns;
 	region->start_gfn = guest_pfn;
 	region->start_uaddr = uaddr;
@@ -263,9 +288,14 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pfns,
 	for (i = 0; i < nr_pfns; i++)
 		region->mreg_pfns[i] = MSHV_INVALID_PFN;
 
+	mutex_init(&region->mreg_mutex);
 	kref_init(&region->mreg_refcount);
 
 	return region;
+
+free_region:
+	vfree(region);
+	return ERR_PTR(ret);
 }
 
 static int mshv_region_chunk_share(struct mshv_mem_region *region,
@@ -462,7 +492,7 @@ static void mshv_region_destroy(struct kref *ref)
 	int ret;
 
 	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
-		mshv_region_movable_fini(region);
+		mmu_interval_notifier_remove(&region->mreg_mni);
 
 	if (mshv_partition_encrypted(partition)) {
 		ret = mshv_region_share(region);
@@ -736,27 +766,6 @@ static const struct mmu_interval_notifier_ops mshv_region_mni_ops = {
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
@@ -770,7 +779,7 @@ bool mshv_region_movable_init(struct mshv_mem_region *region)
  *
  * Return: 0 on success, negative error code on failure.
  */
-int mshv_map_pinned_region(struct mshv_mem_region *region)
+static int mshv_map_pinned_region(struct mshv_mem_region *region)
 {
 	struct mshv_partition *partition = region->partition;
 	int ret;
@@ -826,17 +835,31 @@ int mshv_map_pinned_region(struct mshv_mem_region *region)
 	return ret;
 }
 
-int mshv_map_movable_region(struct mshv_mem_region *region)
+static int mshv_map_movable_region(struct mshv_mem_region *region)
 {
 	return mshv_region_collect_and_map(region, 0, region->nr_pfns,
 					   false);
 }
 
-int mshv_map_mmio_region(struct mshv_mem_region *region,
-			 unsigned long mmio_pfn)
+static int mshv_map_mmio_region(struct mshv_mem_region *region)
 {
 	struct mshv_partition *partition = region->partition;
 
 	return hv_call_map_mmio_pfns(partition->pt_id, region->start_gfn,
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
+	}
+
+	return -EINVAL;
 }
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 1f92b9f85b60..2bcdfa070517 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -92,6 +92,7 @@ struct mshv_mem_region {
 	enum mshv_region_type mreg_type;
 	struct mmu_interval_notifier mreg_mni;
 	struct mutex mreg_mutex;	/* protects region PFNs remapping */
+	u64 mreg_mmio_pfn;
 	unsigned long mreg_pfns[];
 };
 
@@ -366,16 +367,13 @@ extern struct mshv_root mshv_root;
 extern enum hv_scheduler_type hv_scheduler_type;
 extern u8 * __percpu *hv_synic_eventring_tail;
 
-struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
-					   u64 uaddr, u32 flags);
+struct mshv_mem_region *mshv_region_create(enum mshv_region_type type,
+					   u64 guest_pfn, u64 nr_pfns,
+					   u64 uaddr, u32 flags,
+					   ulong mmio_pfn);
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
index adb09350205a..3bfa9e9c575f 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1217,11 +1217,14 @@ static void mshv_async_hvcall_handler(void *data, u64 *status)
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
@@ -1234,18 +1237,27 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
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
+
+	rg = mshv_region_create(type, mem->guest_pfn, nr_pfns,
+				mem->userspace_addr, mem->flags,
+				mmio_pfn);
+	if (IS_ERR(rg))
+		return PTR_ERR(rg);
 
 	rg->partition = partition;
 
@@ -1271,40 +1283,17 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		     struct mshv_user_mem_region mem)
 {
 	struct mshv_mem_region *region;
-	struct vm_area_struct *vma;
-	bool is_mmio;
-	ulong mmio_pfn;
 	long ret;
 
 	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
 	    !access_ok((const void __user *)mem.userspace_addr, mem.size))
 		return -EINVAL;
 
-	mmap_read_lock(current->mm);
-	vma = vma_lookup(current->mm, mem.userspace_addr);
-	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
-	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
-	mmap_read_unlock(current->mm);
-
-	if (!vma)
-		return -EINVAL;
-
-	ret = mshv_partition_create_region(partition, &mem, &region,
-					   is_mmio);
+	ret = mshv_partition_create_region(partition, &mem, &region);
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



