Return-Path: <linux-hyperv+bounces-7109-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2E6BBE6F7
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 17:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1873B9833
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21B2D6E7C;
	Mon,  6 Oct 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Tr0nt1xd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370B32D6E74;
	Mon,  6 Oct 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763189; cv=none; b=ZphfFYGWNBVuwzb2Xscohx2HVF56nkZM+ehkpF+my5V+1wFVlK6LcRW3egJrTGMnYfZdpwvX6kY0i8dzsQnEfH0X2UI7wLEWuHi7TutQ8dr6K8pTvPNUH7mKhU6V4EjM/2M2ICv08ZhnUJQrdGvEtZ/7FOgyWfga8EKvLxVTCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763189; c=relaxed/simple;
	bh=1XMtkoTRl0Lr4SPB5FSdH71J6FB9yWWNoi4hY7Hr/Jw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ts7hO13FtC6qEEUYcUdZpmPnqb5BZqDYMrUd/oQW27zYiA7KmwzJQcKJrWWMDkHuI74o7EMvlclhi4dctZF4a6HXBxzXQgPfQlreUOBcyD/QLYtDD0f2LdgvMfnJU6rcoWntSX+VY3zV5/8Pey7pUJpuVoClw+tgkIZudgzH26Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Tr0nt1xd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A697211CDF2;
	Mon,  6 Oct 2025 08:06:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A697211CDF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759763187;
	bh=vjgKlRDDEjRw02GddRPB5NhZYwJEu4Ggc4Vsxdfe3wg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Tr0nt1xdUDxyyGZPmwmeyo4BKm5BxNi+ta41uIaX6+j7cwMy03eOC5xT3pox4gDUT
	 f90ME7tPuXzcYrTtHU1uazzviWorTTJpLAHQBj8rb9JBrIOitOrdkfbaw6uS5Dbeqr
	 mI8vv8DOyy7jUdbi5JEjPn9XDLuyrvOXkduTt1oI=
Subject: [PATCH v4 3/5] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Oct 2025 15:06:26 +0000
Message-ID: 
 <175976318688.16834.16198650808431263017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
index 97e322f3c6b5e..b61bef6b9c132 100644
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
+		/* Skip if all pages in this range if none is mapped */
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
 



