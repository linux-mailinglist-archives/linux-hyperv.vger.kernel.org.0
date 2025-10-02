Return-Path: <linux-hyperv+bounces-7057-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EBBB48EC
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 18:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBCD2A7C3C
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A379925C809;
	Thu,  2 Oct 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UbWO4J4w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEBF268C73;
	Thu,  2 Oct 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422969; cv=none; b=K6YzPkrx+FgN+BEAlGJ09UGJBSxZQmSvRJh4ZPHOlAln/WYltrcekPW5BBnfAucCrhb7TYo8WErLJJsmTMkGHbEdhdFDhsTZ4ZzGo9j2DDWd4Y0lLNQi5QN2YryOTvcbhGIGLEn1wB2+/o86yer5W0+rWH4s8t/PFVrImnORu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422969; c=relaxed/simple;
	bh=gmNQFH1KHHfvLso6TyAHJJs9HHKw8S+PhflH82R5xLs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqLoKmiTUSgS7SrhUuChQpxloOR56sAbVN6ShK/yUELgOaoRFJq2UBM3BDK0yybGbrQdhtp2f37y6Gm2BOwLCAbJ5SGNrREpGE+LkbzYEpcHQ6oMvhPzsw7zVVILB6+zn6jJnM+u6U4+HLeep+a7Mbrwlm9+1a//L4QSCzfuHB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UbWO4J4w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82D0D2114267;
	Thu,  2 Oct 2025 09:36:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82D0D2114267
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759422967;
	bh=793iTvHJW1tgZTv5wqYmU8SQ+82qk1SPHAz0k5b2kzw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UbWO4J4wzyCGh6KvQzOJuGS2x5MvMzyfQ3wHJCKDd9rC5aDzE6Ls5ZJEG3sn6EPVP
	 IFlIIOfJoDTvHQgiLhrCKcqSJ4HCo8dUcG0fO2nX2wiCqVH5XgAdX7E9PU4qmZsz1i
	 F6wHIBOvdYQC92rt2KZlLLlbkIUhB9PAvX+s+gj0=
Subject: [PATCH v3 4/5] Drivers: hv: Ensure large page GPA mapping is
 PMD-aligned
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Oct 2025 16:36:07 +0000
Message-ID: 
 <175942296740.128138.11164607006125062344.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

With the upcoming introduction of movable pages, a region doesn't guarantee
always having large pages mapped. Both mapping on fault and unmapping
during PTE invalidation may not be 2M-aligned, while the hypervisor
requires both the GFN and page count to be 2M-aligned to use the large page
flag.

Update the logic for large page mapping in mshv_region_remap_pages() to
require both page_offset and page_count to be PMD-aligned.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 8bf0b5af25802..9547833a04681 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -34,6 +34,8 @@
 #include "mshv.h"
 #include "mshv_root.h"
 
+#define VALUE_PMD_ALIGNED(c)			(!((c) & (PTRS_PER_PMD - 1)))
+
 MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
@@ -1100,7 +1102,9 @@ mshv_region_remap_pages(struct mshv_mem_region *region, u32 map_flags,
 	if (page_offset + page_count > region->nr_pages)
 		return -EINVAL;
 
-	if (region->flags.large_pages)
+	if (region->flags.large_pages &&
+	    VALUE_PMD_ALIGNED(page_offset) &&
+	    VALUE_PMD_ALIGNED(page_count))
 		map_flags |= HV_MAP_GPA_LARGE_PAGE;
 
 	/* ask the hypervisor to map guest ram */



