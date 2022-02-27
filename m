Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E2C4C5C0A
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Feb 2022 15:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiB0OcC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Feb 2022 09:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiB0OcA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Feb 2022 09:32:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C7256203;
        Sun, 27 Feb 2022 06:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gVSpX+7KV6wn42digZLX3vAuIC0pBbxisjv1zSfXCt8=; b=xS25Gh/L8q4nvftBwke0WoEuqB
        WZCQlc4/eO5m3CIrFujWVHy7c1ntMcLiIZovb5nZz1QbJ55VmGrJczPFQsviDKqOjrr8CaJV5tk3t
        Xot0RwKQgQN3vFaawuH7zO02hfp/gC13NXkUr0HbpiONgwU1icVk750lH1Zezl7LJZ4supXTzjGYV
        TMOHmImTl28NSLzRp31rAG4SS3rsHr9ROgPrN9gEFW7EiWrxIEL0YuEyz95TNysrz7npSj2Vs9L1+
        rdZF/5LTPPxZSaq/F/NzTfl4m72hXRFfX1gMSaS9dUN0bCXPJmQyuYcTjJHPklOQ8b6/9HfoxeIwe
        teC9G4FQ==;
Received: from [213.208.157.39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOKZu-009Nwk-Uw; Sun, 27 Feb 2022 14:31:15 +0000
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
Subject: [PATCH 04/11] swiotlb: rename swiotlb_late_init_with_default_size
Date:   Sun, 27 Feb 2022 15:30:48 +0100
Message-Id: <20220227143055.335596-5-hch@lst.de>
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

swiotlb_late_init_with_default_size is an overly verbose name that
doesn't even catch what the function is doing, given that the size is
not just a default but the actual requested size.

Rename it to swiotlb_init_late.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/pci/sta2x11-fixup.c | 2 +-
 include/linux/swiotlb.h      | 2 +-
 kernel/dma/swiotlb.c         | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 101081ad64b6d..e0c039a75b2db 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -57,7 +57,7 @@ static void sta2x11_new_instance(struct pci_dev *pdev)
 		int size = STA2X11_SWIOTLB_SIZE;
 		/* First instance: register your own swiotlb area */
 		dev_info(&pdev->dev, "Using SWIOTLB (size %i)\n", size);
-		if (swiotlb_late_init_with_default_size(size))
+		if (swiotlb_init_late(size))
 			dev_emerg(&pdev->dev, "init swiotlb failed\n");
 	}
 	list_add(&instance->list, &sta2x11_instance_list);
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 9fb3a568f0c51..b48b26bfa0edb 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -40,7 +40,7 @@ extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 unsigned long swiotlb_size_or_default(void);
 extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
-extern int swiotlb_late_init_with_default_size(size_t default_size);
+int swiotlb_init_late(size_t size);
 extern void __init swiotlb_update_mem_attributes(void);
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 519e363097190..5f64b02fbb732 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -290,11 +290,9 @@ swiotlb_init(int verbose)
  * initialize the swiotlb later using the slab allocator if needed.
  * This should be just like above, but with some error catching.
  */
-int
-swiotlb_late_init_with_default_size(size_t default_size)
+int swiotlb_init_late(size_t size)
 {
-	unsigned long nslabs =
-		ALIGN(default_size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
 	unsigned long bytes;
 	unsigned char *vstart = NULL;
 	unsigned int order;
-- 
2.30.2

