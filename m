Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B454AF172
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Feb 2022 13:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiBIMX1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Feb 2022 07:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBIMXZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Feb 2022 07:23:25 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF65BC050CD2;
        Wed,  9 Feb 2022 04:23:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j4so2038095plj.8;
        Wed, 09 Feb 2022 04:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hh4jMpg8FB1udogjbNB+Sii1QdXJESjYTwcDUY5y0oA=;
        b=cF+q4qc+10FcqXJ8k2pqRoWI7jFembF/aqdarCrJ1AO8/X3Oj/pMSLDWR3uFLaiqbx
         ogg4igUDarQ6aNTxpXknpQQdyqMlx2Ofte7Q3OUbMyCX8Zua829jgVwALeSVW+iY0Sbu
         N4AeJqVaOgXcus8bPtpRdjgBs4QLjAj3fSQ8fuCFMXa6yzpyGhHrDrf1WyQqQL4aSCi2
         njAAlOijFTduqU6h/7zBbE3IRPqrsln+A+GHDRbn37vHXXPAUulgOyZQ9qbtzP0HN2L7
         phuu7tbw6SxC6CvkqubBW9GD/UztSvCy+22LSQfLferlOFm0+21yNOO/FDVA1Y2khjCz
         nAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hh4jMpg8FB1udogjbNB+Sii1QdXJESjYTwcDUY5y0oA=;
        b=O//IJeyI1GqMDb8EFQgSNpzn+yTGO92YBNQ/Cl2herE2QGnESACeYpKc7bT/mT4xqY
         RVnw0NswOzPcXNeIAX/4tc7apWOBW3aK3AJq4zMqyc/QtlJj5LovUTt8t58wqnEhF2r5
         nLaT7YMJelQS32NvqlJX8yE0sIakB0+ZIPNZaNu5/Vp4ESiTvRym411rAauJfhyKxX4g
         YsmfK+XYgyKihkNEFS2VRQMQip3rzIQfFhopUZsp8n0HdTDF/VzHypDUilZxbs6zIAKT
         JaYTuKOj6XYLAW/EGeOHJmS+PU0KHExI9AHMqJNWC1f3u3rk6wCU7r+gKqiV5kAEtGFG
         KzYQ==
X-Gm-Message-State: AOAM531fBJAQ5xwdk+78yZDTXn8sxa+2GcV0W/XfrfGeMyS1+/fnjNrA
        yfOX8VD+sAkdbekE2QeuMrM=
X-Google-Smtp-Source: ABdhPJwnZIrLHzT8/ZP+XssNQ0ZTkXO6ZjeqNb4h3vsPFa2mZJZ7cvEKT6w/iNJdXHcvAllSyeKYjg==
X-Received: by 2002:a17:90b:4acb:: with SMTP id mh11mr2285572pjb.72.1644409406297;
        Wed, 09 Feb 2022 04:23:26 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:9d5c:32bf:5c81:da87])
        by smtp.gmail.com with ESMTPSA id lb3sm6300990pjb.47.2022.02.09.04.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 04:23:26 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, hch@infradead.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com, hch@lst.de,
        parri.andrea@gmail.com, thomas.lendacky@amd.com
Subject: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Date:   Wed,  9 Feb 2022 07:23:01 -0500
Message-Id: <20220209122302.213882-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209122302.213882-1-ltykernel@gmail.com>
References: <20220209122302.213882-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V Isolation VM and AMD SEV VM uses swiotlb bounce buffer to
share memory with hypervisor. Current swiotlb bounce buffer is only
allocated from 0 to ARCH_LOW_ADDRESS_LIMIT which is default to
0xffffffffUL. Isolation VM and AMD SEV VM needs 1G bounce buffer at most.
This will fail when there is not enough memory from 0 to 4G address
space and devices also may use memory above 4G address space as DMA memory.
Expose swiotlb_alloc_from_low_pages and platform mey set it to false when
it's not necessary to limit bounce buffer from 0 to 4G memory.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  1 +
 kernel/dma/swiotlb.c    | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f6c3638255d5..2b4f92668bc7 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -39,6 +39,7 @@ enum swiotlb_force {
 extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 unsigned long swiotlb_size_or_default(void);
+void swiotlb_set_alloc_from_low_pages(bool low);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
 extern int swiotlb_late_init_with_default_size(size_t default_size);
 extern void __init swiotlb_update_mem_attributes(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..62bf8b5cc3e4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -73,6 +73,8 @@ enum swiotlb_force swiotlb_force;
 
 struct io_tlb_mem io_tlb_default_mem;
 
+static bool swiotlb_alloc_from_low_pages = true;
+
 phys_addr_t swiotlb_unencrypted_base;
 
 /*
@@ -116,6 +118,11 @@ void swiotlb_set_max_segment(unsigned int val)
 		max_segment = rounddown(val, PAGE_SIZE);
 }
 
+void swiotlb_set_alloc_from_low_pages(bool low)
+{
+	swiotlb_alloc_from_low_pages = low;
+}
+
 unsigned long swiotlb_size_or_default(void)
 {
 	return default_nslabs << IO_TLB_SHIFT;
@@ -284,8 +291,15 @@ swiotlb_init(int verbose)
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
 		return;
 
-	/* Get IO TLB memory from the low pages */
-	tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+	/*
+	 * Get IO TLB memory from the low pages if swiotlb_alloc_from_low_pages
+	 * is set.
+	 */
+	if (swiotlb_alloc_from_low_pages)
+		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+	else
+		tlb = memblock_alloc(bytes, PAGE_SIZE);
+
 	if (!tlb)
 		goto fail;
 	if (swiotlb_init_with_tbl(tlb, default_nslabs, verbose))
-- 
2.25.1

