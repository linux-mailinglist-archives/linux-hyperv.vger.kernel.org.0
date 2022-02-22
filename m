Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69F34BFD14
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Feb 2022 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiBVPhN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Feb 2022 10:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiBVPgs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Feb 2022 10:36:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D92164D13;
        Tue, 22 Feb 2022 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zCMW1Q+QCPXYuvBuEGOZUQKFwE9OwdLFtYhltvQ29K4=; b=UivVJu0xfBlRElPO98LGgBvic3
        FgFkBA8tXOAwbzm4ASFviz4SOlLZ2Xk5ojd8aBpgvcYaCCrlUt0AmrI5QXz9BLb9cU7dErlkZgnz3
        IzVqfHy80xQHgtYs4YtsJIktFe5xVp6loPXsAhY+LqtEtDSPdoKeEjZiqWlkk7Equu3WmJaFkQpSY
        nCZa1Oyt2hQQICm8D2KgV+1H1RPCuXGZ7ggZgJ+BM2gIRjfpfUXSW4OsSGdg/5dox+XsD7+FHqwZ8
        loSXrmeHFqVxP2h0pkLAiL/0DZ/bH24KlkPtKONU0U65lHnthcy9X8oVbBAOSQMLGRq8tZSF7/H/x
        UnbZJ7Dg==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXCe-00AH73-Qo; Tue, 22 Feb 2022 15:35:49 +0000
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
Subject: [PATCH 11/11] x86: remove cruft from <asm/dma-mapping.h>
Date:   Tue, 22 Feb 2022 16:35:14 +0100
Message-Id: <20220222153514.593231-12-hch@lst.de>
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

<asm/dma-mapping.h> gets pulled in by all drivers using the DMA API.
Remove x86 internal variables and unnecessary includes from it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/dma-mapping.h | 11 -----------
 arch/x86/include/asm/iommu.h       |  2 ++
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 256fd8115223d..1c66708e30623 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -2,17 +2,6 @@
 #ifndef _ASM_X86_DMA_MAPPING_H
 #define _ASM_X86_DMA_MAPPING_H
 
-/*
- * IOMMU interface. See Documentation/core-api/dma-api-howto.rst and
- * Documentation/core-api/dma-api.rst for documentation.
- */
-
-#include <linux/scatterlist.h>
-#include <asm/io.h>
-
-extern int iommu_merge;
-extern int panic_on_overflow;
-
 extern const struct dma_map_ops *dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index dba89ed40d38d..0bef44d30a278 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -8,6 +8,8 @@
 
 extern int force_iommu, no_iommu;
 extern int iommu_detected;
+extern int iommu_merge;
+extern int panic_on_overflow;
 
 #ifdef CONFIG_SWIOTLB
 extern bool x86_swiotlb_enable;
-- 
2.30.2

