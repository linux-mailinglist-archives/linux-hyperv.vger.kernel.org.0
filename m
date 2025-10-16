Return-Path: <linux-hyperv+bounces-7225-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D22BE11B3
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 02:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9B93E1C49
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 00:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0665113B58B;
	Thu, 16 Oct 2025 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Us8J8LKH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09774420;
	Thu, 16 Oct 2025 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574427; cv=none; b=BbOZk8U3i6OPcWWKgmaCCns4Fk3rvLsMPTeHbsKBUqOOZlvyqPVFzx72/fr3BZYy7pEYWU5fPew0zw9WDmYigfyVJeZz5RgbA7q0d3usnw4Rp5J3AxHwmD3f4GMsFKICo7EHacQEk6+MgWYQ8D2IhsSpI+cwGfRdVOiKan/xx2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574427; c=relaxed/simple;
	bh=tAgztI3ZC55OuDbeWlbdm8sO42BlH6+b9WsRYK4VSLI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTqglhBJhkrmwRmzjDMQ9m4sFNTSwbRNDGQAAsC495mGjS8AtfzR2knQIpmwKD8Mkf4p+Q3GtuCWaDdHqRDeRKyw3eOXkKljQqx74mSZ3i3Ves4LLBl8vHeTYOpIltrINGxDSnQCsxiT3NC3SSkbiEGCTUXj7+5rqxyD8nZqtvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Us8J8LKH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id C517621244D5;
	Wed, 15 Oct 2025 17:27:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C517621244D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760574425;
	bh=uO1ZmYi377mscmHHm5VsooZC9EYZmciyw+FS3OnLyYM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Us8J8LKHoMYeWugdRFhRuWZk2otG7EJ4Ih6ZQTpgLEJ9sWoOpK6KCYI700fPrt7D/
	 qbBWr3NYYRqaHYEazSBd0ZesG2AdCquYlzfwk67Kv79f6wU9pJCTi11MeDdav3l5WY
	 MK8VLPVJHmyuOCdfSBGteyJAt31B19qttVXFDw7A=
Subject: [PATCH v5 3/5] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 16 Oct 2025 00:27:05 +0000
Message-ID: 
 <176057442569.74314.9145830725647822380.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176057396465.74314.10055784909009416453.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176057396465.74314.10055784909009416453.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
---
 drivers/hv/mshv_root.h         |    2 ++
 drivers/hv/mshv_root_hv_call.c |    2 +-
 drivers/hv/mshv_root_main.c    |   28 +++++++++++++++++++++++++---
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index e3931b0f1269..97e64d5341b6 100644
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
index c9c274f29c3c..0696024ccfe3 100644
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
index 97e322f3c6b5..a3e5b41f3a7f 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1378,6 +1378,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 static void mshv_partition_destroy_region(struct mshv_mem_region *region)
 {
 	struct mshv_partition *partition = region->partition;
+	u64 gfn, gfn_count, start_gfn, end_gfn;
 	u32 unmap_flags = 0;
 	int ret;
 
@@ -1396,9 +1397,30 @@ static void mshv_partition_destroy_region(struct mshv_mem_region *region)
 	if (region->flags.large_pages)
 		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
 
-	/* ignore unmap failures and continue as process may be exiting */
-	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
-				region->nr_pages, unmap_flags);
+	start_gfn = region->start_gfn;
+	end_gfn = region->start_gfn + region->nr_pages;
+
+	for (gfn = start_gfn; gfn < end_gfn; gfn += gfn_count) {
+		if (gfn % MSHV_MAX_UNMAP_GPA_PAGES)
+			gfn_count = ALIGN(gfn, MSHV_MAX_UNMAP_GPA_PAGES) - gfn;
+		else
+			gfn_count = MSHV_MAX_UNMAP_GPA_PAGES;
+
+		if (gfn + gfn_count > end_gfn)
+			gfn_count = end_gfn - gfn;
+
+		/* Skip all pages in this range if none are mapped */
+		if (!memchr_inv(region->pages + (gfn - start_gfn), 0,
+				gfn_count * sizeof(struct page *)))
+			continue;
+
+		ret = hv_call_unmap_gpa_pages(partition->pt_id, gfn,
+					      gfn_count, unmap_flags);
+		if (ret)
+			pt_err(partition,
+			       "Failed to unmap GPA pages %#llx-%#llx: %d\n",
+			       gfn, gfn + gfn_count - 1, ret);
+	}
 
 	mshv_region_invalidate(region);
 



