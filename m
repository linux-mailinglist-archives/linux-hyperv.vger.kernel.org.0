Return-Path: <linux-hyperv+bounces-7934-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0791CA1399
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 20:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D3FE322D6F6
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D583164C7;
	Wed,  3 Dec 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KTnR8By/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A373319258E;
	Wed,  3 Dec 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786270; cv=none; b=PbwRREZn+mdM4+XOWEWrNv7r/AypEsDBDH4/cGk9sPdP2u/0eW/kIggkgQk9YXdGChtfjHiRHw1O8yiPmoWZQ110pTNCwewRROj3mDOf7p+u/MxN98Ibyb9T5p/53sCtLmrlke0rd4ne5ZjXuWnVM4NdSOn1XHSJ4SltBKSTqRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786270; c=relaxed/simple;
	bh=CFaA1LgBCRix0pCbhkqH7B2WA+kSyHitbveSkdO9ReA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+OPv13p6IYgVzEbiheIDZ12Wusn0lIMPbE4mdhEallawwiXV/+p5+H3UbwVk3SvMXSYhyZG31NlCT6z8nXoIgA94PxrWxrp/+qchZgNQ9mvs0zfLk5+zC9JAVxCGnXjbJ+Hhgtd5vQkKnKZNyeSTb2jZbn46gNa1OKRrNwP4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KTnR8By/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC08B2120E85;
	Wed,  3 Dec 2025 10:24:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC08B2120E85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764786267;
	bh=BYWdjMMKnRS69oW/sdXE4qxGErCsXuU03TAv+YMnURI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KTnR8By/elpgxLUJzrQZ95qRJ+mFW0xXjWtp8JpJ2MLVPsun9TEt7vTqGKFxD7wRW
	 O+ANtElZ9fA3w9k9121s9lRWVYE6bczyjeHRqdHPtMaz51jhmHck57HrNTqm1yD7WQ
	 vAei3Xih5cAjQTYAwx5qTSLQ//5rPoHdsoxA2zPQ=
Subject: [PATCH v8 5/6] Drivers: hv: Add refcount and locking to mem regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Dec 2025 18:24:27 +0000
Message-ID: 
 <176478626777.114132.1526389640035436917.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176478581828.114132.13305536829966527782.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176478581828.114132.13305536829966527782.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Introduce kref-based reference counting and spinlock protection for
memory regions in Hyper-V partition management. This change improves
memory region lifecycle management and ensures thread-safe access to the
region list.

Also improves the check for overlapped memory regions during region
creation, preventing duplicate or conflicting mappings.

Previously, the regions list was protected by the partition mutex.
However, this approach is too heavy for frequent fault and invalidation
operations. Finer grained locking is now used to improve efficiency and
concurrency.

This is a precursor to supporting movable memory regions. Fault and
invalidation handling for movable regions will require safe traversal of
the region list and holding a region reference while performing
invalidation or fault operations.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c   |   19 ++++++++++++++++---
 drivers/hv/mshv_root.h      |    6 +++++-
 drivers/hv/mshv_root_main.c |   32 ++++++++++++++++++++++++--------
 3 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 1356f68ccb29..94f33754f545 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -7,6 +7,7 @@
  * Authors: Microsoft Linux virtualization team
  */
 
+#include <linux/kref.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 
@@ -154,6 +155,8 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 	if (!is_mmio)
 		region->flags.range_pinned = true;
 
+	kref_init(&region->refcount);
+
 	return region;
 }
 
@@ -303,13 +306,13 @@ static int mshv_region_unmap(struct mshv_mem_region *region)
 					 mshv_region_chunk_unmap);
 }
 
-void mshv_region_destroy(struct mshv_mem_region *region)
+static void mshv_region_destroy(struct kref *ref)
 {
+	struct mshv_mem_region *region =
+		container_of(ref, struct mshv_mem_region, refcount);
 	struct mshv_partition *partition = region->partition;
 	int ret;
 
-	hlist_del(&region->hnode);
-
 	if (mshv_partition_encrypted(partition)) {
 		ret = mshv_region_share(region);
 		if (ret) {
@@ -326,3 +329,13 @@ void mshv_region_destroy(struct mshv_mem_region *region)
 
 	vfree(region);
 }
+
+void mshv_region_put(struct mshv_mem_region *region)
+{
+	kref_put(&region->refcount, mshv_region_destroy);
+}
+
+int mshv_region_get(struct mshv_mem_region *region)
+{
+	return kref_get_unless_zero(&region->refcount);
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index ff3374f13691..4249534ba900 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -72,6 +72,7 @@ do { \
 
 struct mshv_mem_region {
 	struct hlist_node hnode;
+	struct kref refcount;
 	u64 nr_pages;
 	u64 start_gfn;
 	u64 start_uaddr;
@@ -97,6 +98,8 @@ struct mshv_partition {
 	u64 pt_id;
 	refcount_t pt_ref_count;
 	struct mutex pt_mutex;
+
+	spinlock_t pt_mem_regions_lock;
 	struct hlist_head pt_mem_regions; // not ordered
 
 	u32 pt_vp_count;
@@ -319,6 +322,7 @@ int mshv_region_unshare(struct mshv_mem_region *region);
 int mshv_region_map(struct mshv_mem_region *region);
 void mshv_region_invalidate(struct mshv_mem_region *region);
 int mshv_region_pin(struct mshv_mem_region *region);
-void mshv_region_destroy(struct mshv_mem_region *region);
+void mshv_region_put(struct mshv_mem_region *region);
+int mshv_region_get(struct mshv_mem_region *region);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 5dfb933da981..aa1a11f4dc3e 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1086,13 +1086,15 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 	u64 nr_pages = HVPFN_DOWN(mem->size);
 
 	/* Reject overlapping regions */
+	spin_lock(&partition->pt_mem_regions_lock);
 	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
 		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
 		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
 			continue;
-
+		spin_unlock(&partition->pt_mem_regions_lock);
 		return -EEXIST;
 	}
+	spin_unlock(&partition->pt_mem_regions_lock);
 
 	rg = mshv_region_create(mem->guest_pfn, nr_pages,
 				mem->userspace_addr, mem->flags,
@@ -1224,8 +1226,9 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	if (ret)
 		goto errout;
 
-	/* Install the new region */
+	spin_lock(&partition->pt_mem_regions_lock);
 	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
+	spin_unlock(&partition->pt_mem_regions_lock);
 
 	return 0;
 
@@ -1244,17 +1247,27 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
 		return -EINVAL;
 
+	spin_lock(&partition->pt_mem_regions_lock);
+
 	region = mshv_partition_region_by_gfn(partition, mem.guest_pfn);
-	if (!region)
-		return -EINVAL;
+	if (!region) {
+		spin_unlock(&partition->pt_mem_regions_lock);
+		return -ENOENT;
+	}
 
 	/* Paranoia check */
 	if (region->start_uaddr != mem.userspace_addr ||
 	    region->start_gfn != mem.guest_pfn ||
-	    region->nr_pages != HVPFN_DOWN(mem.size))
+	    region->nr_pages != HVPFN_DOWN(mem.size)) {
+		spin_unlock(&partition->pt_mem_regions_lock);
 		return -EINVAL;
+	}
+
+	hlist_del(&region->hnode);
 
-	mshv_region_destroy(region);
+	spin_unlock(&partition->pt_mem_regions_lock);
+
+	mshv_region_put(region);
 
 	return 0;
 }
@@ -1657,8 +1670,10 @@ static void destroy_partition(struct mshv_partition *partition)
 	remove_partition(partition);
 
 	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
-				  hnode)
-		mshv_region_destroy(region);
+				  hnode) {
+		hlist_del(&region->hnode);
+		mshv_region_put(region);
+	}
 
 	/* Withdraw and free all pages we deposited */
 	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
@@ -1856,6 +1871,7 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 
 	INIT_HLIST_HEAD(&partition->pt_devices);
 
+	spin_lock_init(&partition->pt_mem_regions_lock);
 	INIT_HLIST_HEAD(&partition->pt_mem_regions);
 
 	mshv_eventfd_init(partition);



