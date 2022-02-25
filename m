Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C784C4071
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 09:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiBYIsf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Feb 2022 03:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiBYIse (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Feb 2022 03:48:34 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BBA169233;
        Fri, 25 Feb 2022 00:48:01 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 364BF68AA6; Fri, 25 Feb 2022 09:47:56 +0100 (CET)
Date:   Fri, 25 Feb 2022 09:47:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        x86@kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
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
Subject: Re: cleanup swiotlb initialization
Message-ID: <20220225084755.GA29630@lst.de>
References: <20220222153514.593231-1-hch@lst.de> <09cb4ad3-88e7-3744-b4b8-a6d745ecea9e@oracle.com> <20220224155854.GA30938@lst.de> <206ba6a3-770a-70ad-96bc-76c6380da988@oracle.com> <20220224163943.GA32088@lst.de> <8ffd8587-7eb3-d5b6-eab0-b86df5c0ebbd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ffd8587-7eb3-d5b6-eab0-b86df5c0ebbd@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 24, 2022 at 12:07:26PM -0500, Boris Ostrovsky wrote:
>>> Just to be clear: this crashes only as dom0. Boots fine as baremetal.
>> Ah.  I can gues what this might be.  On Xen the hypervisor controls the
>> IOMMU and we should never end up initializing it in Linux, right?
>
>
> Right, we shouldn't be in that code path.

Can you try the patch below on top of the series?


diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index b849f11a756d0..f88c9a4a5ed12 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -47,22 +47,6 @@ static unsigned int x86_swiotlb_flags;
  */
 static void __init pci_swiotlb_detect_4gb(void)
 {
-#ifdef CONFIG_SWIOTLB_XEN
-	if (xen_pv_domain()) {
-		if (xen_initial_domain())
-			x86_swiotlb_enable = true;
-
-		if (x86_swiotlb_enable) {
-			dma_ops = &xen_swiotlb_dma_ops;
-#ifdef CONFIG_PCI
-			/* Make sure ACS will be enabled */
-			pci_request_acs();
-#endif
-		}
-		return;
-	}
-#endif /* CONFIG_SWIOTLB_XEN */
-
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
 	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
 		x86_swiotlb_enable = true;
@@ -82,16 +66,36 @@ static inline void __init pci_swiotlb_detect_4gb(void)
 }
 #endif /* CONFIG_SWIOTLB */
 
+#ifdef CONFIG_SWIOTLB_XEN
+static void __init xen_swiotlb_init(void)
+{
+	if (!xen_initial_domain() && !x86_swiotlb_enable)
+		return;
+	x86_swiotlb_enable = true;
+	dma_ops = &xen_swiotlb_dma_ops;
+#ifdef CONFIG_PCI
+	/* Make sure ACS will be enabled */
+	pci_request_acs();
+#endif
+	swiotlb_init_remap(true, x86_swiotlb_flags, xen_swiotlb_fixup);
+}
+#else
+static inline void __init xen_swiotlb_init(void)
+{
+}
+#endif /* CONFIG_SWIOTLB_XEN */
+
 void __init pci_iommu_alloc(void)
 {
+	if (xen_pv_domain()) {
+		xen_swiotlb_init();
+		return;
+	}
 	pci_swiotlb_detect_4gb();
 	gart_iommu_hole_init();
 	amd_iommu_detect();
 	detect_intel_iommu();
-#ifdef CONFIG_SWIOTLB
-	swiotlb_init_remap(x86_swiotlb_enable, x86_swiotlb_flags,
-			   xen_pv_domain() ? xen_swiotlb_fixup : NULL);
-#endif
+	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
 }
 
 /*
