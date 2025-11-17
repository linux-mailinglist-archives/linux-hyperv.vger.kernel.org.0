Return-Path: <linux-hyperv+bounces-7626-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB741C65453
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D84DB4F03CA
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8462FB601;
	Mon, 17 Nov 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IJp0LJph"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9AC301706;
	Mon, 17 Nov 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398372; cv=none; b=gKGjrSHYHB1Xe+4q4gBFL6CUuIC9UbLBNadsaaxPY8OCJjwxi3n0+r0oGxXd7Pw0BZr0XGVaeU+giLIYD/BRc8MC1qUwED9K9GIgD0AvswuuHBkdHLAgfj0BoH+j3VFbVfVnZvPxB822iX6STQRdnuOoES4lkBQVSLAPsAHZPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398372; c=relaxed/simple;
	bh=oeoevA6OIUjcl9eIekGM5NRMXnBUhk6Bq0jte2viVJk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZS9dn9cTx0DSls3ZoqszyvfD7C9ygRBhWn2FWHhNPzgEsT1YD4/4dLECLSa6Lwh8DbnbYw/6DbqirOuhhy2XbWN+P+t9TXxMksCATvgviYaRLG7fFGOZJeouZTho2yEBDKlYnPUafhcD/qG4SO6arHQ8UOkk4viFeLjdpkrTf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IJp0LJph; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0D590206C17D;
	Mon, 17 Nov 2025 08:52:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D590206C17D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763398369;
	bh=HuFUegP400Q+MPDo5LZJeyXtJj40Kt1umHP+StAynN0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IJp0LJphAQN00uxsZdtyhl3oTE4AG7VotM33qtY1m2fCMc+2BrE2oM2cT+Q+nnpsH
	 JbDRY1fpVTBc2RpWg7JcloPIw04TNksaaDDWY11GYODRcTndVRjYZGKAUuTLc27swN
	 YDymmzHuyeOAPZipDiBrLJmpAJph+jDavqkTrAHU=
Subject: [PATCH v6 3/5] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Nov 2025 16:52:48 +0000
Message-ID: 
 <176339836892.27330.9465609709535892557.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176339789196.27330.10517676002564595057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176339789196.27330.10517676002564595057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Reduce overhead when unmapping large memory regions by batching GPA unmap
operations in 2MB-aligned chunks.

Use a dedicated constant for batch size to improve code clarity and
maintainability.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         |    2 ++
 drivers/hv/mshv_root_hv_call.c |    2 +-
 drivers/hv/mshv_root_main.c    |   36 ++++++++++++++++++++++++++++++------
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 3eb815011b46..5eece7077f8b 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -32,6 +32,8 @@ static_assert(HV_HYP_PAGE_SIZE == MSHV_HV_PAGE_SIZE);
 
 #define MSHV_PIN_PAGES_BATCH_SIZE	(0x10000000ULL / HV_HYP_PAGE_SIZE)
 
+#define MSHV_MAX_UNMAP_GPA_PAGES	512
+
 struct mshv_vp {
 	u32 vp_index;
 	struct mshv_partition *vp_partition;
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index caf02cfa49c9..8fa983f1109b 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -17,7 +17,7 @@
 /* Determined empirically */
 #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
 #define HV_MAP_GPA_DEPOSIT_PAGES	256
-#define HV_UMAP_GPA_PAGES		512
+#define HV_UMAP_GPA_PAGES		MSHV_MAX_UNMAP_GPA_PAGES
 
 #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
 
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index a85872b72b1a..ef36d8115d8a 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1365,7 +1365,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 static void mshv_partition_destroy_region(struct mshv_mem_region *region)
 {
 	struct mshv_partition *partition = region->partition;
-	u32 unmap_flags = 0;
+	u64 gfn, gfn_count, start_gfn, end_gfn;
 	int ret;
 
 	hlist_del(&region->hnode);
@@ -1380,12 +1380,36 @@ static void mshv_partition_destroy_region(struct mshv_mem_region *region)
 		}
 	}
 
-	if (region->flags.large_pages)
-		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
+	start_gfn = region->start_gfn;
+	end_gfn = region->start_gfn + region->nr_pages;
+
+	for (gfn = start_gfn; gfn < end_gfn; gfn += gfn_count) {
+		u32 unmap_flags = 0;
+
+		if (gfn % MSHV_MAX_UNMAP_GPA_PAGES)
+			gfn_count = ALIGN(gfn, MSHV_MAX_UNMAP_GPA_PAGES) - gfn;
+		else
+			gfn_count = MSHV_MAX_UNMAP_GPA_PAGES;
+
+		if (gfn + gfn_count > end_gfn)
+			gfn_count = end_gfn - gfn;
 
-	/* ignore unmap failures and continue as process may be exiting */
-	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
-				region->nr_pages, unmap_flags);
+		/* Skip all pages in this range if none are mapped */
+		if (!memchr_inv(region->pages + (gfn - start_gfn), 0,
+				gfn_count * sizeof(struct page *)))
+			continue;
+
+		if (region->flags.large_pages &&
+		    VALUE_PMD_ALIGNED(gfn) && VALUE_PMD_ALIGNED(gfn_count))
+			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
+
+		ret = hv_call_unmap_gpa_pages(partition->pt_id, gfn,
+					      gfn_count, unmap_flags);
+		if (ret)
+			pt_err(partition,
+			       "Failed to unmap GPA pages %#llx-%#llx: %d\n",
+			       gfn, gfn + gfn_count - 1, ret);
+	}
 
 	mshv_region_invalidate(region);
 



