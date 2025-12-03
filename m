Return-Path: <linux-hyperv+bounces-7952-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE43FCA1B3A
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 22:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81BF630253C8
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 21:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95CE2D8377;
	Wed,  3 Dec 2025 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nyRQDXqt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045432D7DDC;
	Wed,  3 Dec 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798067; cv=none; b=jUqZ7MuQk2XKsiecShgz5eH5hKbVOJ8+3gsPbvifwy3MZrWdt108Ol0PzS73U6xgcss80hNwQ+lMjERPaCdI70yuRkKQNLqIKOq90OuQMVwE711dzPKUUtsCjQ/oAV5TQ335kpD15HwkFIwEyHfdkr61+Ia9zkVJ+6N0j1ko2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798067; c=relaxed/simple;
	bh=f/VgY/PViOFhq8RJ+WpLLJk0SYU+SccNZdP8ADJuOwg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1jNUihk6ejIKjJT563Nz4XNncAPn9OU9Qu4I2c84hEP+tHTjstBYzKG/KSsnBM2jc0jr3YZCKNGfqrSvvShwTK5iDFh5zce16CHxcPN0ekCYC316Tbt6G/1BfHV4Fv09Edopj+0lQUjecib7e+DtVpYRCPh/sblgz9k72mBtTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nyRQDXqt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id D7139212326F;
	Wed,  3 Dec 2025 13:41:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7139212326F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764798062;
	bh=gYLya0rqS5cpv2upQ49IgAB0eCpR9aSi74TuJIV9nA8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nyRQDXqtFYRBdxq/7IsI0FMiuy+CVg6hHFkz9T9RvKWZY2AAKYvE8nX+EqTspB0hO
	 3EJn1ZAmbcwsUJbAnDWUWarODG9hs6USJ4m49wS5xs/ET9FD3uDQ1z/9unnHXxrz35
	 pyYBTL+IApcxyrXp5r4XJhjaossQ0BmtlkSbg65s=
Subject: [PATCH v9 5/6] Drivers: hv: Add refcount and locking to mem regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Dec 2025 21:41:02 +0000
Message-ID: 
 <176479806274.304819.6733471661684698320.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176479772384.304819.9168337792948347657.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176479772384.304819.9168337792948347657.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
index 40126c12ab33..4ec78fdaf56d 100644
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
 
@@ -311,13 +314,13 @@ static int mshv_region_unmap(struct mshv_mem_region *region)
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
@@ -334,3 +337,13 @@ void mshv_region_destroy(struct mshv_mem_region *region)
 
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



