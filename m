Return-Path: <linux-hyperv+bounces-7828-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F7C87C6F
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 03:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E723B5C20
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 02:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CC63081A2;
	Wed, 26 Nov 2025 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f8sJ9VzJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ACF30AD11;
	Wed, 26 Nov 2025 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122948; cv=none; b=UKRUG/J+GaY9PSQR7mUiieWyMvRr0xXUOw0Pp6FwpurIYqTcQO9O+Z4nPZ9GII6y5f0VhG54N+322x3fQVTZ+ljE3D72mLFJruYrwDc7yFm5AMuh7wAqm+sHKM8PGK+shULPnDCK3TdycSKraoKHtLBm6TTe2MAz5QvaMvVnoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122948; c=relaxed/simple;
	bh=JdDX+O0ogC1Z41vI7ryGth0XZpZ/27tEr1EnKzYqRpI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDSgAYiDcPFdeJxDvesluB4J3KX3/C5Co3vH8ZRyQPEfUyJC+Sy4UgO0tWPQCMltQtoq8W7Hgp09s74Fn5wvJ5grPp07gIgP0LBfB5H789tetKtfsyecR8TvZPZwUAZAu4RNDUD9b3AA3fbs0kqWM0F1s6wjpgHdPG7iBUTPLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f8sJ9VzJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8A3B02120EAF;
	Tue, 25 Nov 2025 18:09:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A3B02120EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764122945;
	bh=JNfBYYJLwxZrhAHFPzYLFbrg/U8bjRyZU21wZ1ZJFYA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=f8sJ9VzJanWwVh+jGWgJCnFNPXh+HRTEXvhBGLPF8ul1DdovgL3b1fLD+gbFH2EZa
	 PfJSwZlJr1LKH7BkShl2VKQi+Drx7/8w+V/71dgham0CDECAQvzhXdIKO0kRX5GpdN
	 x91AH7bZaDReeuDFd2LRAoCxQmmDDOJctnJGuu0c=
Subject: [PATCH v7 3/7] Drivers: hv: Move region management to mshv_regions.c
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Nov 2025 02:09:05 +0000
Message-ID: 
 <176412294544.447063.14863746685758881018.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Refactor memory region management functions from mshv_root_main.c into
mshv_regions.c for better modularity and code organization.

Adjust function calls and headers to use the new implementation. Improve
maintainability and separation of concerns in the mshv_root module.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/Makefile         |    2 
 drivers/hv/mshv_regions.c   |  175 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h      |   10 ++
 drivers/hv/mshv_root_main.c |  176 +++----------------------------------------
 4 files changed, 198 insertions(+), 165 deletions(-)
 create mode 100644 drivers/hv/mshv_regions.c

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 58b8d07639f3..46d4f4f1b252 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -14,7 +14,7 @@ hv_vmbus-y := vmbus_drv.o \
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
-	       mshv_root_hv_call.o mshv_portid_table.o
+	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
 mshv_vtl-y := mshv_vtl_main.o
 
 # Code that must be built-in
diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
new file mode 100644
index 000000000000..35b866670840
--- /dev/null
+++ b/drivers/hv/mshv_regions.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Microsoft Corporation.
+ *
+ * Memory region management for mshv_root module.
+ *
+ * Authors: Microsoft Linux virtualization team
+ */
+
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+
+#include <asm/mshyperv.h>
+
+#include "mshv_root.h"
+
+struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
+					   u64 uaddr, u32 flags,
+					   bool is_mmio)
+{
+	struct mshv_mem_region *region;
+
+	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
+	if (!region)
+		return ERR_PTR(-ENOMEM);
+
+	region->nr_pages = nr_pages;
+	region->start_gfn = guest_pfn;
+	region->start_uaddr = uaddr;
+	region->hv_map_flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_ADJUSTABLE;
+	if (flags & BIT(MSHV_SET_MEM_BIT_WRITABLE))
+		region->hv_map_flags |= HV_MAP_GPA_WRITABLE;
+	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
+		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
+
+	/* Note: large_pages flag populated when we pin the pages */
+	if (!is_mmio)
+		region->flags.range_pinned = true;
+
+	return region;
+}
+
+int mshv_region_share(struct mshv_mem_region *region)
+{
+	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
+
+	if (region->flags.large_pages)
+		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
+
+	return hv_call_modify_spa_host_access(region->partition->pt_id,
+			region->pages, region->nr_pages,
+			HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE,
+			flags, true);
+}
+
+int mshv_region_unshare(struct mshv_mem_region *region)
+{
+	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
+
+	if (region->flags.large_pages)
+		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
+
+	return hv_call_modify_spa_host_access(region->partition->pt_id,
+			region->pages, region->nr_pages,
+			0,
+			flags, false);
+}
+
+static int mshv_region_remap_pages(struct mshv_mem_region *region,
+				   u32 map_flags,
+				   u64 page_offset, u64 page_count)
+{
+	if (page_offset + page_count > region->nr_pages)
+		return -EINVAL;
+
+	if (region->flags.large_pages)
+		map_flags |= HV_MAP_GPA_LARGE_PAGE;
+
+	return hv_call_map_gpa_pages(region->partition->pt_id,
+				     region->start_gfn + page_offset,
+				     page_count, map_flags,
+				     region->pages + page_offset);
+}
+
+int mshv_region_map(struct mshv_mem_region *region)
+{
+	u32 map_flags = region->hv_map_flags;
+
+	return mshv_region_remap_pages(region, map_flags,
+				       0, region->nr_pages);
+}
+
+static void mshv_region_invalidate_pages(struct mshv_mem_region *region,
+					 u64 page_offset, u64 page_count)
+{
+	if (region->flags.range_pinned)
+		unpin_user_pages(region->pages + page_offset, page_count);
+
+	memset(region->pages + page_offset, 0,
+	       page_count * sizeof(struct page *));
+}
+
+void mshv_region_invalidate(struct mshv_mem_region *region)
+{
+	mshv_region_invalidate_pages(region, 0, region->nr_pages);
+}
+
+int mshv_region_pin(struct mshv_mem_region *region)
+{
+	u64 done_count, nr_pages;
+	struct page **pages;
+	__u64 userspace_addr;
+	int ret;
+
+	for (done_count = 0; done_count < region->nr_pages; done_count += ret) {
+		pages = region->pages + done_count;
+		userspace_addr = region->start_uaddr +
+				 done_count * HV_HYP_PAGE_SIZE;
+		nr_pages = min(region->nr_pages - done_count,
+			       MSHV_PIN_PAGES_BATCH_SIZE);
+
+		/*
+		 * Pinning assuming 4k pages works for large pages too.
+		 * All page structs within the large page are returned.
+		 *
+		 * Pin requests are batched because pin_user_pages_fast
+		 * with the FOLL_LONGTERM flag does a large temporary
+		 * allocation of contiguous memory.
+		 */
+		ret = pin_user_pages_fast(userspace_addr, nr_pages,
+					  FOLL_WRITE | FOLL_LONGTERM,
+					  pages);
+		if (ret < 0)
+			goto release_pages;
+	}
+
+	if (PageHuge(region->pages[0]))
+		region->flags.large_pages = true;
+
+	return 0;
+
+release_pages:
+	mshv_region_invalidate_pages(region, 0, done_count);
+	return ret;
+}
+
+void mshv_region_destroy(struct mshv_mem_region *region)
+{
+	struct mshv_partition *partition = region->partition;
+	u32 unmap_flags = 0;
+	int ret;
+
+	hlist_del(&region->hnode);
+
+	if (mshv_partition_encrypted(partition)) {
+		ret = mshv_region_share(region);
+		if (ret) {
+			pt_err(partition,
+			       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
+			       ret);
+			return;
+		}
+	}
+
+	if (region->flags.large_pages)
+		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
+
+	/* ignore unmap failures and continue as process may be exiting */
+	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
+				region->nr_pages, unmap_flags);
+
+	mshv_region_invalidate(region);
+
+	vfree(region);
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 3eb815011b46..0366f416c2f0 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -312,4 +312,14 @@ extern struct mshv_root mshv_root;
 extern enum hv_scheduler_type hv_scheduler_type;
 extern u8 * __percpu *hv_synic_eventring_tail;
 
+struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
+					   u64 uaddr, u32 flags,
+					   bool is_mmio);
+int mshv_region_share(struct mshv_mem_region *region);
+int mshv_region_unshare(struct mshv_mem_region *region);
+int mshv_region_map(struct mshv_mem_region *region);
+void mshv_region_invalidate(struct mshv_mem_region *region);
+int mshv_region_pin(struct mshv_mem_region *region);
+void mshv_region_destroy(struct mshv_mem_region *region);
+
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index ec18984c3f2d..5dfb933da981 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1059,117 +1059,6 @@ static void mshv_async_hvcall_handler(void *data, u64 *status)
 	*status = partition->async_hypercall_status;
 }
 
-static int
-mshv_partition_region_share(struct mshv_mem_region *region)
-{
-	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
-
-	if (region->flags.large_pages)
-		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
-
-	return hv_call_modify_spa_host_access(region->partition->pt_id,
-			region->pages, region->nr_pages,
-			HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE,
-			flags, true);
-}
-
-static int
-mshv_partition_region_unshare(struct mshv_mem_region *region)
-{
-	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
-
-	if (region->flags.large_pages)
-		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
-
-	return hv_call_modify_spa_host_access(region->partition->pt_id,
-			region->pages, region->nr_pages,
-			0,
-			flags, false);
-}
-
-static int
-mshv_region_remap_pages(struct mshv_mem_region *region, u32 map_flags,
-			u64 page_offset, u64 page_count)
-{
-	if (page_offset + page_count > region->nr_pages)
-		return -EINVAL;
-
-	if (region->flags.large_pages)
-		map_flags |= HV_MAP_GPA_LARGE_PAGE;
-
-	/* ask the hypervisor to map guest ram */
-	return hv_call_map_gpa_pages(region->partition->pt_id,
-				     region->start_gfn + page_offset,
-				     page_count, map_flags,
-				     region->pages + page_offset);
-}
-
-static int
-mshv_region_map(struct mshv_mem_region *region)
-{
-	u32 map_flags = region->hv_map_flags;
-
-	return mshv_region_remap_pages(region, map_flags,
-				       0, region->nr_pages);
-}
-
-static void
-mshv_region_invalidate_pages(struct mshv_mem_region *region,
-			     u64 page_offset, u64 page_count)
-{
-	if (region->flags.range_pinned)
-		unpin_user_pages(region->pages + page_offset, page_count);
-
-	memset(region->pages + page_offset, 0,
-	       page_count * sizeof(struct page *));
-}
-
-static void
-mshv_region_invalidate(struct mshv_mem_region *region)
-{
-	mshv_region_invalidate_pages(region, 0, region->nr_pages);
-}
-
-static int
-mshv_region_pin(struct mshv_mem_region *region)
-{
-	u64 done_count, nr_pages;
-	struct page **pages;
-	__u64 userspace_addr;
-	int ret;
-
-	for (done_count = 0; done_count < region->nr_pages; done_count += ret) {
-		pages = region->pages + done_count;
-		userspace_addr = region->start_uaddr +
-				 done_count * HV_HYP_PAGE_SIZE;
-		nr_pages = min(region->nr_pages - done_count,
-			       MSHV_PIN_PAGES_BATCH_SIZE);
-
-		/*
-		 * Pinning assuming 4k pages works for large pages too.
-		 * All page structs within the large page are returned.
-		 *
-		 * Pin requests are batched because pin_user_pages_fast
-		 * with the FOLL_LONGTERM flag does a large temporary
-		 * allocation of contiguous memory.
-		 */
-		ret = pin_user_pages_fast(userspace_addr, nr_pages,
-					  FOLL_WRITE | FOLL_LONGTERM,
-					  pages);
-		if (ret < 0)
-			goto release_pages;
-	}
-
-	if (PageHuge(region->pages[0]))
-		region->flags.large_pages = true;
-
-	return 0;
-
-release_pages:
-	mshv_region_invalidate_pages(region, 0, done_count);
-	return ret;
-}
-
 static struct mshv_mem_region *
 mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 {
@@ -1193,7 +1082,7 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 					struct mshv_mem_region **regionpp,
 					bool is_mmio)
 {
-	struct mshv_mem_region *region, *rg;
+	struct mshv_mem_region *rg;
 	u64 nr_pages = HVPFN_DOWN(mem->size);
 
 	/* Reject overlapping regions */
@@ -1205,26 +1094,15 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 		return -EEXIST;
 	}
 
-	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
-	if (!region)
-		return -ENOMEM;
-
-	region->nr_pages = nr_pages;
-	region->start_gfn = mem->guest_pfn;
-	region->start_uaddr = mem->userspace_addr;
-	region->hv_map_flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_ADJUSTABLE;
-	if (mem->flags & BIT(MSHV_SET_MEM_BIT_WRITABLE))
-		region->hv_map_flags |= HV_MAP_GPA_WRITABLE;
-	if (mem->flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
-		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
-
-	/* Note: large_pages flag populated when we pin the pages */
-	if (!is_mmio)
-		region->flags.range_pinned = true;
+	rg = mshv_region_create(mem->guest_pfn, nr_pages,
+				mem->userspace_addr, mem->flags,
+				is_mmio);
+	if (IS_ERR(rg))
+		return PTR_ERR(rg);
 
-	region->partition = partition;
+	rg->partition = partition;
 
-	*regionpp = region;
+	*regionpp = rg;
 
 	return 0;
 }
@@ -1262,7 +1140,7 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 	 * access to guest memory regions.
 	 */
 	if (mshv_partition_encrypted(partition)) {
-		ret = mshv_partition_region_unshare(region);
+		ret = mshv_region_unshare(region);
 		if (ret) {
 			pt_err(partition,
 			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
@@ -1275,7 +1153,7 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 	if (ret && mshv_partition_encrypted(partition)) {
 		int shrc;
 
-		shrc = mshv_partition_region_share(region);
+		shrc = mshv_region_share(region);
 		if (!shrc)
 			goto invalidate_region;
 
@@ -1356,36 +1234,6 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	return ret;
 }
 
-static void mshv_partition_destroy_region(struct mshv_mem_region *region)
-{
-	struct mshv_partition *partition = region->partition;
-	u32 unmap_flags = 0;
-	int ret;
-
-	hlist_del(&region->hnode);
-
-	if (mshv_partition_encrypted(partition)) {
-		ret = mshv_partition_region_share(region);
-		if (ret) {
-			pt_err(partition,
-			       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
-			       ret);
-			return;
-		}
-	}
-
-	if (region->flags.large_pages)
-		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
-
-	/* ignore unmap failures and continue as process may be exiting */
-	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
-				region->nr_pages, unmap_flags);
-
-	mshv_region_invalidate(region);
-
-	vfree(region);
-}
-
 /* Called for unmapping both the guest ram and the mmio space */
 static long
 mshv_unmap_user_memory(struct mshv_partition *partition,
@@ -1406,7 +1254,7 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	    region->nr_pages != HVPFN_DOWN(mem.size))
 		return -EINVAL;
 
-	mshv_partition_destroy_region(region);
+	mshv_region_destroy(region);
 
 	return 0;
 }
@@ -1810,7 +1658,7 @@ static void destroy_partition(struct mshv_partition *partition)
 
 	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
 				  hnode)
-		mshv_partition_destroy_region(region);
+		mshv_region_destroy(region);
 
 	/* Withdraw and free all pages we deposited */
 	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);



