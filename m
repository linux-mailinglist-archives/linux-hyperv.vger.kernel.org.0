Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E54F4F0EC7
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Apr 2022 07:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359211AbiDDFI5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Apr 2022 01:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377334AbiDDFI4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Apr 2022 01:08:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6C435255;
        Sun,  3 Apr 2022 22:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RjiwiTF3Oxb6vRH/IITMaa9hgA1bQqA9QM5+9nVyYm8=; b=mYojJH8rP+rsDTvUcL/Rr9LyRc
        QfbxMF/sAOYZNJbgDYgeYLuVB9ZrStMxJIXkPtMhoiCbVe7UghtQ/x02x7UvodNzmV7f6fI7WhvcO
        0txUaVFA+MNQnVSaVdrdxYWIabZZHsZdu5x+1F4yvFVFH/tD8zNYhuq1x/d6ZlJQxKHLQu4tKKX+5
        BwCpMsiKeNm14dtj97yy48dayCDrPzCHq90BUWXCwlstodf041pgu8aM3dn/gc8b5m9kLyXQknojd
        lCgYWmFqQ6EjPT6Etu9ywpNyaq97PXE83giDAQY9bPEHcxUUqfFyjM93I0Iq3J16FRjRJisge8d9M
        o7aPaUCA==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEvS-00D9Gu-8c; Mon, 04 Apr 2022 05:06:51 +0000
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
Subject: [PATCH 11/15] swiotlb: pass a gfp_mask argument to swiotlb_init_late
Date:   Mon,  4 Apr 2022 07:05:55 +0200
Message-Id: <20220404050559.132378-12-hch@lst.de>
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

Let the caller chose a zone to allocate from.  This will be used
later on by the xen-swiotlb initialization on arm.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/pci/sta2x11-fixup.c | 2 +-
 include/linux/swiotlb.h      | 2 +-
 kernel/dma/swiotlb.c         | 7 ++-----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index e0c039a75b2db..c7e6faf59a861 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -57,7 +57,7 @@ static void sta2x11_new_instance(struct pci_dev *pdev)
 		int size = STA2X11_SWIOTLB_SIZE;
 		/* First instance: register your own swiotlb area */
 		dev_info(&pdev->dev, "Using SWIOTLB (size %i)\n", size);
-		if (swiotlb_init_late(size))
+		if (swiotlb_init_late(size, GFP_DMA))
 			dev_emerg(&pdev->dev, "init swiotlb failed\n");
 	}
 	list_add(&instance->list, &sta2x11_instance_list);
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index eabdd89987027..ee655f2e4d28b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -37,7 +37,7 @@ struct scatterlist;
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, unsigned int flags);
 unsigned long swiotlb_size_or_default(void);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
-int swiotlb_init_late(size_t size);
+int swiotlb_init_late(size_t size, gfp_t gfp_mask);
 extern void __init swiotlb_update_mem_attributes(void);
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f6e091424af3d..119187afc65ec 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -292,7 +292,7 @@ void __init swiotlb_init(bool addressing_limit, unsigned int flags)
  * initialize the swiotlb later using the slab allocator if needed.
  * This should be just like above, but with some error catching.
  */
-int swiotlb_init_late(size_t size)
+int swiotlb_init_late(size_t size, gfp_t gfp_mask)
 {
 	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
 	unsigned long bytes;
@@ -303,15 +303,12 @@ int swiotlb_init_late(size_t size)
 	if (swiotlb_force_disable)
 		return 0;
 
-	/*
-	 * Get IO TLB memory from the low pages
-	 */
 	order = get_order(nslabs << IO_TLB_SHIFT);
 	nslabs = SLABS_PER_PAGE << order;
 	bytes = nslabs << IO_TLB_SHIFT;
 
 	while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
-		vstart = (void *)__get_free_pages(GFP_DMA | __GFP_NOWARN,
+		vstart = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
 						  order);
 		if (vstart)
 			break;
-- 
2.30.2

