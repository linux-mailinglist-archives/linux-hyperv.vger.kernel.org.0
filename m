Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B484C5C28
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Feb 2022 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiB0Oce (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Feb 2022 09:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiB0Ocb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Feb 2022 09:32:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1150856203;
        Sun, 27 Feb 2022 06:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=e5WrycmUWO29UJfUDorb7NMshMB8lzYVa/Mc+LVTrQY=; b=M6zu15mMoPH+9m8brqTPBHG/MC
        A1xLxoqDKLMvUNkNY0qpBK3uCp9lzGbLcGsqRUtjocz8fFQc+1Futvsr0HDC5pQub0V5q/IW3X5DM
        XxT5xEwpQjzqXMlvqCLscqKv2vSze/CFvVJlqhNLpKFBHw+q/Ttav1/C/auhHll/1QYCggzmQ6G3g
        T8DM1uznPKhTcSGXsvggUq1ncptnYaXLXKrgoWT4BKmLcAnZxTCKsRFwCtON9/siNdio+Iut29G9K
        TuuFBRx65ncACOSJM/GWPdJq+7cv8bsg3M9Q6EqQhIa2RVRROr1HXP+p2mSW9tbbJ0hY2MOkl60xF
        OWiusQpw==;
Received: from [213.208.157.39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOKaJ-009ODX-I5; Sun, 27 Feb 2022 14:31:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
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
Subject: [PATCH 09/11] swiotlb: add a SWIOTLB_ANY flag to lift the low memory restriction
Date:   Sun, 27 Feb 2022 15:30:53 +0100
Message-Id: <20220227143055.335596-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220227143055.335596-1-hch@lst.de>
References: <20220227143055.335596-1-hch@lst.de>
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

Power SVM wants to allocate a swiotlb buffer that is not restricted to
low memory for the trusted hypervisor scheme.  Consolidate the support
for this into the swiotlb_init interface by adding a new flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/svm.h       |  4 ----
 arch/powerpc/mm/mem.c                |  5 +----
 arch/powerpc/platforms/pseries/svm.c | 26 +-------------------------
 include/linux/swiotlb.h              |  1 +
 kernel/dma/swiotlb.c                 |  9 +++++++--
 5 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
index 7546402d796af..85580b30aba48 100644
--- a/arch/powerpc/include/asm/svm.h
+++ b/arch/powerpc/include/asm/svm.h
@@ -15,8 +15,6 @@ static inline bool is_secure_guest(void)
 	return mfmsr() & MSR_S;
 }
 
-void __init svm_swiotlb_init(void);
-
 void dtl_cache_ctor(void *addr);
 #define get_dtl_cache_ctor()	(is_secure_guest() ? dtl_cache_ctor : NULL)
 
@@ -27,8 +25,6 @@ static inline bool is_secure_guest(void)
 	return false;
 }
 
-static inline void svm_swiotlb_init(void) {}
-
 #define get_dtl_cache_ctor() NULL
 
 #endif /* CONFIG_PPC_SVM */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d99b8b5b40ca6..a4d65418c30a9 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -249,10 +249,7 @@ void __init mem_init(void)
 	 * back to to-down.
 	 */
 	memblock_set_bottom_up(true);
-	if (is_secure_guest())
-		svm_swiotlb_init();
-	else
-		swiotlb_init(ppc_swiotlb_enable, ppc_swiotlb_flags);
+	swiotlb_init(ppc_swiotlb_enable, ppc_swiotlb_flags);
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index c5228f4969eb2..3b4045d508ec8 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -28,7 +28,7 @@ static int __init init_svm(void)
 	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
 	 * otherwise.
 	 */
-	swiotlb_force = SWIOTLB_FORCE;
+	ppc_swiotlb_flags |= SWIOTLB_ANY | SWIOTLB_FORCE;
 
 	/* Share the SWIOTLB buffer with the host. */
 	swiotlb_update_mem_attributes();
@@ -37,30 +37,6 @@ static int __init init_svm(void)
 }
 machine_early_initcall(pseries, init_svm);
 
-/*
- * Initialize SWIOTLB. Essentially the same as swiotlb_init(), except that it
- * can allocate the buffer anywhere in memory. Since the hypervisor doesn't have
- * any addressing limitation, we don't need to allocate it in low addresses.
- */
-void __init svm_swiotlb_init(void)
-{
-	unsigned char *vstart;
-	unsigned long bytes, io_tlb_nslabs;
-
-	io_tlb_nslabs = (swiotlb_size_or_default() >> IO_TLB_SHIFT);
-	io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
-
-	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
-
-	vstart = memblock_alloc(PAGE_ALIGN(bytes), PAGE_SIZE);
-	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, false))
-		return;
-
-
-	memblock_free(vstart, PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
-	panic("SVM: Cannot allocate SWIOTLB buffer");
-}
-
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
 	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index dcecf953f7997..ee655f2e4d28b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -15,6 +15,7 @@ struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
 #define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
+#define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ad604e5a0983d..ec200e40fc397 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -275,8 +275,13 @@ void __init swiotlb_init(bool addressing_limit, unsigned int flags)
 	if (swiotlb_force_disable)
 		return;
 
-	/* Get IO TLB memory from the low pages */
-	tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+	/*
+	 * By default allocate the bonuce buffer memory from low memory.
+	 */
+	if (flags & SWIOTLB_ANY)
+		tlb = memblock_alloc(bytes, PAGE_SIZE);
+	else
+		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb)
 		goto fail;
 	if (swiotlb_init_with_tbl(tlb, default_nslabs, flags))
-- 
2.30.2

