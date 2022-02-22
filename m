Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379E34BFD03
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Feb 2022 16:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiBVPgq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Feb 2022 10:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiBVPgQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Feb 2022 10:36:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D98165C07;
        Tue, 22 Feb 2022 07:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2LuLtS1efSBZ06JRKs3rwu/XDIHFFEkeBlwKrISdqYE=; b=Vf12//P1cJJG7r7sSMYd3RKUpR
        1iyqvtcz1vvg2fulY2+WGMc8nNqZ0MlrzDhxAp14OnNMko2kMFYfcU0rlmFA2OCUpO2mFz7P7lvKg
        ALp0Z8CYzL61sODI1ktyZxnyHDkcqBaBsxGE7/O/0yEeje/VzIYseB2EMSkX0NSBzVGeetdBnWPlq
        h4ARmCowLPrC/KwkX0h+EeItmZFyxYuayW3LABiVBWVYx9p142xpp5CdMhN6o16cO+9maNRgWoIhF
        /De8ZYV8h4SrIxdVqDfFAtgqSO7aIGNMgslI44A+n4/vknBhdvQqpOCR4L4Wpy966WPbClzjKYvUC
        fRljMIDw==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXCP-00AGwT-S1; Tue, 22 Feb 2022 15:35:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org, tboot-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org
Subject: [PATCH 06/11] MIPS/octeon: use swiotlb_init instead of open coding it
Date:   Tue, 22 Feb 2022 16:35:09 +0100
Message-Id: <20220222153514.593231-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222153514.593231-1-hch@lst.de>
References: <20220222153514.593231-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Use the generic swiotlb initialization helper instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/cavium-octeon/dma-octeon.c | 15 ++-------------
 arch/mips/pci/pci-octeon.c           |  2 +-
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index df70308db0e69..fb7547e217263 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -186,15 +186,12 @@ phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return daddr;
 }
 
-char *octeon_swiotlb;
-
 void __init plat_swiotlb_setup(void)
 {
 	phys_addr_t start, end;
 	phys_addr_t max_addr;
 	phys_addr_t addr_size;
 	size_t swiotlbsize;
-	unsigned long swiotlb_nslabs;
 	u64 i;
 
 	max_addr = 0;
@@ -236,15 +233,7 @@ void __init plat_swiotlb_setup(void)
 	if (OCTEON_IS_OCTEON2() && max_addr >= 0x100000000ul)
 		swiotlbsize = 64 * (1<<20);
 #endif
-	swiotlb_nslabs = swiotlbsize >> IO_TLB_SHIFT;
-	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
-	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
-
-	octeon_swiotlb = memblock_alloc_low(swiotlbsize, PAGE_SIZE);
-	if (!octeon_swiotlb)
-		panic("%s: Failed to allocate %zu bytes align=%lx\n",
-		      __func__, swiotlbsize, PAGE_SIZE);
 
-	if (swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1) == -ENOMEM)
-		panic("Cannot allocate SWIOTLB buffer");
+	swiotlb_adjust_size(swiotlbsize);
+	swiotlb_init(1);
 }
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index fc29b85cfa926..e457a18cbdc59 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -664,7 +664,7 @@ static int __init octeon_pci_setup(void)
 
 		/* BAR1 movable regions contiguous to cover the swiotlb */
 		octeon_bar1_pci_phys =
-			virt_to_phys(octeon_swiotlb) & ~((1ull << 22) - 1);
+			io_tlb_default_mem.start & ~((1ull << 22) - 1);
 
 		for (index = 0; index < 32; index++) {
 			union cvmx_pci_bar1_indexx bar1_index;
-- 
2.30.2

