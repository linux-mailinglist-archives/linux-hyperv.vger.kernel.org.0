Return-Path: <linux-hyperv+bounces-10279-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHG4OQKN52m89wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10279-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:43:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460943C378
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52EF3098B15
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37423D903F;
	Tue, 21 Apr 2026 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S/ro3UTD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64B3D8915;
	Tue, 21 Apr 2026 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782144; cv=none; b=i3GEL8tWyV1qSiDT/f/bClQ3SLonkic/adDs6UiADNgSj4EcZF6wuxYr2/XprNyLjVL/yMcIc0EMAP83vQYnlqJUwCJX1JV/PMEXcaMn3wA6wfOWDuemwgwlD70yFW69LhEHWEg6X+PUr/gaAs7Ge/z8G7GFykrI8vYFl1P7bhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782144; c=relaxed/simple;
	bh=FG8+MkLj/7ebQZ9/V2yWB8xMJLJdWZC4P3Zf+Gg6y2o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaSrZFxWCwCQBMeON+Q7G6QcfCVwIsmRuULlCZif79p0uymYA8COYtIF/yQugEFLg+odWg3bjXtil9Fs8dfid6BfoUI+4CNKOY3xLiXNIarocxLvOhA1LY+is+Yd131TFO7k6CBSzmCFYyyt0oYHPYmOKAm4Wn0/oGyI5JspXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S/ro3UTD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0273820B6F01;
	Tue, 21 Apr 2026 07:35:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0273820B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776782143;
	bh=9FYSOIw8qhIsq2XFo+NB52pbN+OCkRiIw51OSP24Wlo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=S/ro3UTD1BM9g2KdqHU4ijsUif3+i0VenpcOoD0CLCXQdXvkSVe0t2iBSLL1hjBY6
	 9QghEvgyfcngif7ncVc6K6nO1BTegqRRCl7fRRY0t6qx5WTiIuICSZarl1ODmlyNKQ
	 oEvXHIA0rDBDOnBEjkffBphygG9r/m3x9p17GBEU=
Subject: [PATCH v2 5/7] mshv: Map populated pages on movable region creation
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Apr 2026 14:35:42 +0000
Message-ID: 
 <177678214245.13344.12413265780395703585.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10279-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: 5460943C378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Map any populated pages into the hypervisor upfront when creating a
movable region, rather than waiting for faults. Previously, movable
regions were created with all pages marked as HV_MAP_GPA_NO_ACCESS
regardless of whether the userspace mapping contained populated pages.

This guarantees that if the caller passes a populated mapping, those
present pages will be mapped into the hypervisor immediately during
region creation instead of being faulted in later.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c   |   65 ++++++++++++++++++++++++++++++++-----------
 drivers/hv/mshv_root.h      |    1 +
 drivers/hv/mshv_root_main.c |   10 +------
 3 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 4fbcf1ff6fa6..c408d61a6ca6 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -519,7 +519,8 @@ int mshv_region_get(struct mshv_mem_region *region)
 static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
 					  unsigned long start,
 					  unsigned long end,
-					  unsigned long *pfns)
+					  unsigned long *pfns,
+					  bool do_fault)
 {
 	struct hmm_range range = {
 		.notifier = &region->mreg_mni,
@@ -541,9 +542,12 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
 		range.hmm_pfns = pfns;
 		range.start = start;
 		range.end = min(vma->vm_end, end);
-		range.default_flags = HMM_PFN_REQ_FAULT;
-		if (vma->vm_flags & VM_WRITE)
-			range.default_flags |= HMM_PFN_REQ_WRITE;
+		range.default_flags = 0;
+		if (do_fault) {
+			range.default_flags = HMM_PFN_REQ_FAULT;
+			if (vma->vm_flags & VM_WRITE)
+				range.default_flags |= HMM_PFN_REQ_WRITE;
+		}
 
 		ret = hmm_range_fault(&range);
 		if (ret)
@@ -568,26 +572,40 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
 }
 
 /**
- * mshv_region_range_fault - Handle memory range faults for a given region.
- * @region: Pointer to the memory region structure.
- * @pfn_offset: Offset of the page within the region.
- * @pfn_count: Number of pages to handle.
+ * mshv_region_collect_and_map - Collect PFNs for a user range and map them
+ * @region    : memory region being processed
+ * @pfn_offset: PFNs offset within the region
+ * @pfn_count : number of PFNs to process
+ * @do_fault  : if true, fault in missing pages;
+ *              if false, collect only present pages
  *
- * This function resolves memory faults for a specified range of pages
- * within a memory region. It uses HMM (Heterogeneous Memory Management)
- * to fault in the required pages and updates the region's page array.
+ * Collects PFNs for the specified portion of @region from the
+ * corresponding userspace VMAs and maps them into the hypervisor. The
+ * behavior depends on @do_fault:
  *
- * Return: 0 on success, negative error code on failure.
+ * - true: Fault in missing pages from userspace, ensuring all pages in the
+ *   range are present. Used for on-demand page population.
+ * - false: Collect PFNs only for pages already present in userspace,
+ *   leaving missing pages as invalid PFN markers.
+ *   Used for initial region setup.
+ *
+ * Collected PFNs are stored in region->mreg_pfns[] with HMM bookkeeping
+ * flags cleared, then the range is mapped into the hypervisor. Present
+ * PFNs get mapped with region access permissions; missing PFNs (invalid
+ * entries) get mapped with no-access permissions.
+ *
+ * Return: 0 on success, negative errno on failure.
  */
-static int mshv_region_range_fault(struct mshv_mem_region *region,
-				   u64 pfn_offset, u64 pfn_count)
+static int mshv_region_collect_and_map(struct mshv_mem_region *region,
+				       u64 pfn_offset, u64 pfn_count,
+				       bool do_fault)
 {
 	unsigned long start, end;
 	unsigned long *pfns;
 	int ret;
 	u64 i;
 
-	pfns = kmalloc_array(pfn_count, sizeof(*pfns), GFP_KERNEL);
+	pfns = vmalloc_array(pfn_count, sizeof(unsigned long));
 	if (!pfns)
 		return -ENOMEM;
 
@@ -596,7 +614,7 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 
 	do {
 		ret = mshv_region_hmm_fault_and_lock(region, start, end,
-						     pfns);
+						     pfns, do_fault);
 	} while (ret == -EBUSY);
 
 	if (ret)
@@ -614,10 +632,17 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 
 	mutex_unlock(&region->mreg_mutex);
 out:
-	kfree(pfns);
+	vfree(pfns);
 	return ret;
 }
 
+static int mshv_region_range_fault(struct mshv_mem_region *region,
+				   u64 pfn_offset, u64 pfn_count)
+{
+	return mshv_region_collect_and_map(region, pfn_offset, pfn_count,
+					   true);
+}
+
 bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn)
 {
 	u64 pfn_offset, pfn_count;
@@ -801,3 +826,9 @@ int mshv_map_pinned_region(struct mshv_mem_region *region)
 err_out:
 	return ret;
 }
+
+int mshv_map_movable_region(struct mshv_mem_region *region)
+{
+	return mshv_region_collect_and_map(region, 0, region->nr_pfns,
+					   false);
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index a0bc08a23953..ce718056590f 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -373,5 +373,6 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 int mshv_map_pinned_region(struct mshv_mem_region *region);
+int mshv_map_movable_region(struct mshv_mem_region *region);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 2e58cb0608d9..881edc5d6e2b 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1298,15 +1298,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		ret = mshv_map_pinned_region(region);
 		break;
 	case MSHV_REGION_TYPE_MEM_MOVABLE:
-		/*
-		 * For movable memory regions, remap with no access to let
-		 * the hypervisor track dirty pages, enabling pre-copy live
-		 * migration.
-		 */
-		ret = hv_call_map_ram_pfns(partition->pt_id,
-					   region->start_gfn,
-					   region->nr_pfns,
-					   HV_MAP_GPA_NO_ACCESS, NULL);
+		ret = mshv_map_movable_region(region);
 		break;
 	case MSHV_REGION_TYPE_MMIO:
 		ret = hv_call_map_mmio_pfns(partition->pt_id,



