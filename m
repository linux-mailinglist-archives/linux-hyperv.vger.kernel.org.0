Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35CD4CDB2A
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Mar 2022 18:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbiCDRoF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Mar 2022 12:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbiCDRoE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Mar 2022 12:44:04 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287481C027C;
        Fri,  4 Mar 2022 09:43:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 18C7068BEB; Fri,  4 Mar 2022 18:43:09 +0100 (CET)
Date:   Fri, 4 Mar 2022 18:43:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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
Subject: Re: [PATCH 11/12] swiotlb: merge swiotlb-xen initialization into
 swiotlb
Message-ID: <20220304174308.GA13515@lst.de>
References: <20220301105311.885699-1-hch@lst.de> <20220301105311.885699-12-hch@lst.de> <alpine.DEB.2.22.394.2203011720150.3261@ubuntu-linux-20-04-desktop> <ca748512-12bb-7d75-13f1-8d5ec9703e26@oracle.com> <20220304172859.GA12860@lst.de> <fc3992a8-896b-f0fc-e500-9010ec085c57@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc3992a8-896b-f0fc-e500-9010ec085c57@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 04, 2022 at 12:36:17PM -0500, Boris Ostrovsky wrote:
>>> I bisected it to "x86: remove the IOMMU table infrastructure" but haven't actually looked at the code yet.
>> That looks like the swiotlb buffer did not get initialized at all, but I
>> can't really explain why.
>>
>> Can you stick in a printk and see if xen_swiotlb_init_early gets called
>> at all?
>
>
>
> Actually, that's the only thing I did do so far and yes, it does get called.

So, specifically for "x86: remove the IOMMU table infrastructure" I
think we need the one-liner below so that swiotlb_exit doesn't get called
for the Xen case.  But that should have been fixed up by the next
patch already.

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 2ac0ef9c2fb76..1173aa282ab27 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -70,7 +70,7 @@ static void __init pci_xen_swiotlb_init(void)
 	if (!xen_initial_domain() && !x86_swiotlb_enable &&
 	    swiotlb_force != SWIOTLB_FORCE)
 		return;
-	x86_swiotlb_enable = false;
+	x86_swiotlb_enable = true;
 	xen_swiotlb = true;
 	xen_swiotlb_init_early();
 	dma_ops = &xen_swiotlb_dma_ops;
