Return-Path: <linux-hyperv+bounces-7011-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF044BA9EEC
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 18:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46E616366D
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD2730DD1A;
	Mon, 29 Sep 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VKMccNVt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F430CDA4;
	Mon, 29 Sep 2025 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161798; cv=none; b=pTLXAdif+fe4oLrlNeMfWHaH7FCFhjlgW3aQoK6rw8G8f3yrcT5E27k8tjbycdtgSRuvDWAiCy0JQvEa/C2LdqihW/ntcsAjob74KeKqzL4AdYXPbQN45Z4oPqD9q6qQJN/blCY8fTpooDL/bqFQrebfRP9ln5Ksq9a7TOsxX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161798; c=relaxed/simple;
	bh=TENnvITzN7Qs9n08UrPR/rgEytMNmmUGcE7M+4J5xnY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKzFdbcd/DbPnphyFuRb0lNCmvs2wupkEiVFyu7jXzen4KTUx6zThFTCvdANVOaY1WQTvVMwmqqzCjT1NowAWBSId67GYDjpdH5rgEcwZADo2Tw5SKHgM0xClQYiYMGEeWJmnfXx1vrmXTwn5hy7HSvG3NPAf0WCX75UMirr4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VKMccNVt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id CF2B9212730E;
	Mon, 29 Sep 2025 09:03:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF2B9212730E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759161796;
	bh=Cku2nBDMNdOXAgtPqmDf2uazSygPXi26UiOp6APHq4s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VKMccNVtyPIEyI4deY44G3yCou7OnI774ACwEYjZ31NQTH9nW/W6EyhBgBk1Tnm2m
	 UCmLXLAqCASlx2sOLjLFmCkVC8DpRx8IH2asJcCfbCoYYeB9UZx3VRE1EKFzuPP7eU
	 M6k669l/PI7OKvgTi9VAbUKIeJZHJ3Tjm9Zkwgr0=
Subject: [PATCH v2 3/4] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Sep 2025 16:03:16 +0000
Message-ID: 
 <175916179655.55038.10386146373160838848.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <175916156212.55038.16727147489322393965.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <175916156212.55038.16727147489322393965.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
 drivers/hv/mshv_root_main.c    |   15 ++++++++++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index e3931b0f12693..97e64d5341b6e 100644
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
index c9c274f29c3c6..0696024ccfe31 100644
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
index d8143bc8dbcfb..e3f55bddd933e 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1378,6 +1378,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 static void mshv_partition_destroy_region(struct mshv_mem_region *region)
 {
 	struct mshv_partition *partition = region->partition;
+	u64 page_offset;
 	u32 unmap_flags = 0;
 	int ret;
 
@@ -1396,9 +1397,17 @@ static void mshv_partition_destroy_region(struct mshv_mem_region *region)
 	if (region->flags.large_pages)
 		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
 
-	/* ignore unmap failures and continue as process may be exiting */
-	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
-				region->nr_pages, unmap_flags);
+	for (page_offset = 0; page_offset < region->nr_pages; page_offset++) {
+		if (!region->pages[page_offset])
+			continue;
+
+		hv_call_unmap_gpa_pages(partition->pt_id,
+					ALIGN(region->start_gfn + page_offset,
+					      MSHV_MAX_UNMAP_GPA_PAGES),
+					MSHV_MAX_UNMAP_GPA_PAGES, unmap_flags);
+
+		page_offset += MSHV_MAX_UNMAP_GPA_PAGES - 1;
+	}
 
 	mshv_region_invalidate(region);
 



