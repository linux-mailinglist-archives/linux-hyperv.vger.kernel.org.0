Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3FD4F0E90
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Apr 2022 07:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377298AbiDDFIZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Apr 2022 01:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349663AbiDDFIX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Apr 2022 01:08:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E788535255;
        Sun,  3 Apr 2022 22:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rnJqoDznV2ailLujTKu/Jc1dJCINDF5Gg77pH2Dxx2M=; b=1iFXKtta4r+OI9SiFxTCKN3UND
        OgDrY90v7rPxIhfQCXPwwz+In7kY2H8l9KUOSQU7aCLwCYEt8N2HxW6JzPeCyvnGiJW62+ksVNaU1
        5RdWPH/iOrys+qb+LRWQ+fQbqfv060OvVAHgMyI4kfcfsqtMHT3qTxw/n/mouxLBUOjnmDpvDqbJx
        1GjFzMuSqROw+95bLlcyQgLv8r533FZvrhmZ1M6RmEm0SDC+AaBUfi8RWNV8iMaGEC7CZ5qswv8/a
        liRmKvGZ8xV8j94rKpIqvMJjXJqfdYxJUXcJubWVMWhwLHR2Q34GSX7kffJ33Me9OS8ShJwkhNCia
        MO76TOJg==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEuu-00D8qZ-8m; Mon, 04 Apr 2022 05:06:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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
Subject: [PATCH 03/15] swiotlb: simplify swiotlb_max_segment
Date:   Mon,  4 Apr 2022 07:05:47 +0200
Message-Id: <20220404050559.132378-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404050559.132378-1-hch@lst.de>
References: <20220404050559.132378-1-hch@lst.de>
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

Remove the bogus Xen override that was usually larger than the actual
size and just calculate the value on demand.  Note that
swiotlb_max_segment still doesn't make sense as an interface and should
eventually be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/xen/swiotlb-xen.c |  2 --
 include/linux/swiotlb.h   |  1 -
 kernel/dma/swiotlb.c      | 20 +++-----------------
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 47aebd98f52f5..485cd06ed39e7 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -202,7 +202,6 @@ int xen_swiotlb_init(void)
 	rc = swiotlb_late_init_with_tbl(start, nslabs);
 	if (rc)
 		return rc;
-	swiotlb_set_max_segment(PAGE_SIZE);
 	return 0;
 error:
 	if (nslabs > 1024 && repeat--) {
@@ -254,7 +253,6 @@ void __init xen_swiotlb_init_early(void)
 
 	if (swiotlb_init_with_tbl(start, nslabs, true))
 		panic("Cannot allocate SWIOTLB buffer");
-	swiotlb_set_max_segment(PAGE_SIZE);
 }
 #endif /* CONFIG_X86 */
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f6c3638255d54..9fb3a568f0c51 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -164,7 +164,6 @@ static inline void swiotlb_adjust_size(unsigned long size)
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
-extern void swiotlb_set_max_segment(unsigned int);
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 struct page *swiotlb_alloc(struct device *dev, size_t size);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 98bb0eb44a7bf..e0127e397335e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -68,12 +68,6 @@ struct io_tlb_mem io_tlb_default_mem;
 
 phys_addr_t swiotlb_unencrypted_base;
 
-/*
- * Max segment that we can provide which (if pages are contingous) will
- * not be bounced (unless SWIOTLB_FORCE is set).
- */
-static unsigned int max_segment;
-
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 
 static int __init
@@ -97,18 +91,12 @@ early_param("swiotlb", setup_io_tlb_npages);
 
 unsigned int swiotlb_max_segment(void)
 {
-	return io_tlb_default_mem.nslabs ? max_segment : 0;
+	if (!io_tlb_default_mem.nslabs)
+		return 0;
+	return rounddown(io_tlb_default_mem.nslabs << IO_TLB_SHIFT, PAGE_SIZE);
 }
 EXPORT_SYMBOL_GPL(swiotlb_max_segment);
 
-void swiotlb_set_max_segment(unsigned int val)
-{
-	if (swiotlb_force == SWIOTLB_FORCE)
-		max_segment = 1;
-	else
-		max_segment = rounddown(val, PAGE_SIZE);
-}
-
 unsigned long swiotlb_size_or_default(void)
 {
 	return default_nslabs << IO_TLB_SHIFT;
@@ -258,7 +246,6 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 
 	if (verbose)
 		swiotlb_print_info();
-	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
 	return 0;
 }
 
@@ -359,7 +346,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
 
 	swiotlb_print_info();
-	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
 	return 0;
 }
 
-- 
2.30.2

