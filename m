Return-Path: <linux-hyperv+bounces-7056-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C62BB48EF
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414783B4119
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639B263F22;
	Thu,  2 Oct 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h4QHQanz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FB225C809;
	Thu,  2 Oct 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422964; cv=none; b=KQYvMYn8aWsml+w4jS2AAMzlv2IdkSAk2d3+Wbepv4tgityipJh/3/MGSGsveBZmwpiZD4JCyVqcsmBbtJI5Smx+pssxzcYWWd4lhMLRRc7pZEZLAX2ZfpybtMM47oHtaB4981cAQlCm+DF2Oc3cusyIzvESXMZH4dRtARya0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422964; c=relaxed/simple;
	bh=r/ITA94TiKg53EksXuqbtEuUFEcDwgjmO68BCJcmtDU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1wBsvyyFbbEotp+GfkZFJlUmGW60As0zRD4qRXjxinf9jGOWECxg31CXWKQgtJc1uoR6Ck4ImI3FctNVL7WTJf8/RmX4QwrqpNRN5xpc2blMWCdawgp5X0GUioByL/kQUmhX/UkZolVjujy6Nh14mNAprSjhf/DH5GFWoPHsy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h4QHQanz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B7F04211B7BA;
	Thu,  2 Oct 2025 09:36:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7F04211B7BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759422961;
	bh=Hu6sv/VmvACQ/11PC7TlyIFMXtIGviODz3M35ojDjxo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=h4QHQanzbpsfD8f88X6xFc7FZtjv1qfEj/ZcwIoxy3GI1fYLLxEGqfx2a1TIUtA1f
	 wByepa+NRePHfL9J4xisX55ObEvg9lnM0O4Zcp419tSJOZafiu9ERlDGU7DOgYm54Y
	 B/fwBs6hXctv4ZuSAdZjD/od6kEqSd8SSDG47n8E=
Subject: [PATCH v3 3/5] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Oct 2025 16:36:01 +0000
Message-ID: 
 <175942296162.128138.15731950243504649929.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
index 7ef66c43e1515..8bf0b5af25802 100644
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
 



