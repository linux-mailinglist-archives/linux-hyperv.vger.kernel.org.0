Return-Path: <linux-hyperv+bounces-7110-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F0BBBE700
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 17:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97AAB4EE5B0
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5A02D7DDE;
	Mon,  6 Oct 2025 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ppnC1Q1z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23902D7DCF;
	Mon,  6 Oct 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763195; cv=none; b=Wz/ta+36Wm/Sibxxt1Hs3+Cyc2CW3j5LDZLnxaUKEfZYF8COaH7SlaJvGqdssIBEHQKtuUdW3MRV0HSI5IhcvRGVZmzGsL8IiDEcI4nRFRCOrk1Q+jM4INohb8IyiDUyAFWFbZyT/ns7brtSMHENGgfo7GZ01+uIWusS4WZnj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763195; c=relaxed/simple;
	bh=jsqRlvumdNo0vDKoCzt7e/V9jnVeP/OaYHLM6P1Y3wM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGphkG77gCLVNlM5qImOumKv+cc2cyzWobyhS+Xq46OTn39ICbrY+lrkIvSO/IvAy9/zRA8s2kV4Am1+LsLn9MBSMSl1X5Nyi15XhbOSyGliB9kXnHQx2pXYR/5VR5V5M5Uo90Ps5L4kneJcT8yzQxVWvDnzGoVYiRQzH8JumXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ppnC1Q1z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 222742012C1C;
	Mon,  6 Oct 2025 08:06:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 222742012C1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759763193;
	bh=i/yyEcCwYyJqTLN2jEEoStytFKbIQeKSgew93J63ark=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ppnC1Q1zUVcufzvVQaylUeiboKDYiWTXNY7Ebbim069gpqSpYFyYFLtCfk65DvNf8
	 CtDMCZexVdTLERYn3hnUzV4CJUmjS/cUMMuhpAdV3r7QxAcxDotZvavkvg/buDXaLb
	 5PXW23ePeEqc+4BbaiN6S3diRWIleg33zJSUjNOM=
Subject: [PATCH v4 4/5] Drivers: hv: Ensure large page GPA mapping is
 PMD-aligned
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Oct 2025 15:06:33 +0000
Message-ID: 
 <175976319301.16834.18430498559434584549.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
index b61bef6b9c132..cb462495f34b5 100644
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



