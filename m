Return-Path: <linux-hyperv+bounces-7226-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC1BE11B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 02:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F56B19C8596
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Oct 2025 00:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983A2195811;
	Thu, 16 Oct 2025 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e2+G3Js4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19A1553AA;
	Thu, 16 Oct 2025 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574433; cv=none; b=e9LtOkuMfCZp6d0twuL7UmXB7Qq96s2gt71WdU1bv+k667z0fsmlX3eiYm4rXBgmgDM6i1cS8D5sC6d6m0F0kgtMeF9SnDlhxKiRJ+XNRAlFDIbwNKS3FpBaNUErKbOGqxtgZZkDTxTS6fkOX3+CwIaqnxzIYjajH+dwqeUu2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574433; c=relaxed/simple;
	bh=eo8DCL0djJ7okoLNAd/tQJQbiWGtBQUas9ThDgLNVGk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0ZfHpVP74HNbKD31Vxe8NFPN96YjvOkfOEP/qjVb7uxcbse4Sfh7i5O76Fuxoij3Q+SA9qaOtXiHPwvSIcAwME5uKo69DQMc8Sp+Fq0xs+J/H5IpUjBlNmzITn/EGaV3hEJ3h/GK9mspmNJnfmI6GT5FnuvmFX/cnB+BnNP8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e2+G3Js4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 83DE021244D5;
	Wed, 15 Oct 2025 17:27:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83DE021244D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760574431;
	bh=RlA3TOLVQRm+mE8ftLeYMLdMk4yf6F0Br2NnNjLJ1ys=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=e2+G3Js4PnqhLu4HZpffbsV2Eckllum8MreYPeQQODqvCRoyjVH9hO6wdhcC1xHYs
	 GqBx/GdsVqOaY497ZHoZGXTNMQVscmeh6MVEw5rdRPtT9SH0dw6PNsGr+QtkBbuNFC
	 ORnjRhJalXrJCKSFvZzQVgwXCv2nUqBief/4Hswc=
Subject: [PATCH v5 4/5] Drivers: hv: Ensure large page GPA mapping is
 PMD-aligned
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 16 Oct 2025 00:27:11 +0000
Message-ID: 
 <176057443125.74314.7729532384455957581.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
index a3e5b41f3a7f..c4f114376435 100644
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



