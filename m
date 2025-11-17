Return-Path: <linux-hyperv+bounces-7627-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89393C654A4
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8469366270
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65772FB97B;
	Mon, 17 Nov 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="msP8Rbec"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A282FD68F;
	Mon, 17 Nov 2025 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398376; cv=none; b=p7URg6kPBjX24catMZMX4fJOvyYCV4vUp/YrBz7PBT41hz29Th9SQJn99ffZtmizo+hMxE0/K+Mvj9cuZo+sPA53S8MhkEkdebwG2FGT8RM2j8VYF3uQD5kAoCBKo4thAYkcn9Hj3Yvl0SouB/zZmDivpMHSip0Jg8K3anvrXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398376; c=relaxed/simple;
	bh=+LCcOqGimqvndcrx4DCTlkVTQpdLXmnhxvSoBV+3/pk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJrqdxzS9MHuKbXjuc6425DB2KSq7CrMkvKVbSPeowjydzjm4K6rBMc+71ryZ7VDOZ1w3FB+zAFjoTci5tW9YLafxdEGLiLzmioZCoIibBiFLxbzp6DWdH4DKS4lSDYcpitgZ+rUwgD0cc+qdn2HnNviJnfAv7ntz0WZJyI7nAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=msP8Rbec; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9D9D8211629A;
	Mon, 17 Nov 2025 08:52:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D9D8211629A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763398374;
	bh=jhJdoak6aCkwcSWzx40eJNE/+4q/rdV7KiR2i16vyg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=msP8Rbec9Ll3PUxQkVX1qbY5suUZ1c4W55aqMibFpAtnQHRZZp6E0xFGvYhGtpGwe
	 iD0pFTlu26ascBjHe8T8BS+dC6WzW1M7CxHN5NPGUSTGKB6GudhxQ/IygsAcysViZK
	 H7vWmZ4vPU9R0isWh8XP88RyPRqJOG4D0zf5Wd+A=
Subject: [PATCH v6 4/5] Drivers: hv: Ensure large page GPA mapping is
 PMD-aligned
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Nov 2025 16:52:54 +0000
Message-ID: 
 <176339837452.27330.14241630082712785467.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

With the upcoming introduction of movable pages, a region doesn't guarantee
always having large pages mapped. Both mapping on fault and unmapping
during PTE invalidation may not be 2M-aligned, while the hypervisor
requires both the GFN and page count to be 2M-aligned to use the large page
flag.

Update the logic for large page mapping in mshv_region_remap_pages() to
require both page_offset and page_count to be PMD-aligned.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index ef36d8115d8a..73aaa149c14c 100644
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
+	    VALUE_PMD_ALIGNED(region->start_gfn + page_offset) &&
+	    VALUE_PMD_ALIGNED(page_count))
 		map_flags |= HV_MAP_GPA_LARGE_PAGE;
 
 	/* ask the hypervisor to map guest ram */



