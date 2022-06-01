Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1D653ACA7
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jun 2022 20:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356598AbiFASVv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Jun 2022 14:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356590AbiFASVu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Jun 2022 14:21:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAFC65ED;
        Wed,  1 Jun 2022 11:21:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E98968AA6; Wed,  1 Jun 2022 20:21:42 +0200 (CEST)
Date:   Wed, 1 Jun 2022 20:21:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        x86@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
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
Subject: Re: [PATCH 09/15] swiotlb: make the swiotlb_init interface more
 useful
Message-ID: <20220601182141.GA28309@lst.de>
References: <20220404050559.132378-1-hch@lst.de> <20220404050559.132378-10-hch@lst.de> <YpehC7BwBlnuxplF@dev-arch.thelio-3990X> <20220601173441.GB27582@lst.de> <YpemDuzdoaO3rijX@Ryzen-9-3900X.> <20220601175743.GA28082@lst.de> <Yper7agk7XfCCQNa@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yper7agk7XfCCQNa@dev-arch.thelio-3990X>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 01, 2022 at 11:11:57AM -0700, Nathan Chancellor wrote:
> On Wed, Jun 01, 2022 at 07:57:43PM +0200, Christoph Hellwig wrote:
> > On Wed, Jun 01, 2022 at 10:46:54AM -0700, Nathan Chancellor wrote:
> > > On Wed, Jun 01, 2022 at 07:34:41PM +0200, Christoph Hellwig wrote:
> > > > Can you send me the full dmesg and the content of
> > > > /sys/kernel/debug/swiotlb/io_tlb_nslabs for a good and a bad boot?
> > > 
> > > Sure thing, they are attached! If there is anything else I can provide
> > > or test, I am more than happy to do so.
> > 
> > Nothing interesting.  But the performance numbers almost look like
> > swiotlb=force got ignored before (even if I can't explain why).
> 
> I was able to get my performance back with this diff but I don't know if
> this is a hack or a proper fix in the context of the series.

This looks good, but needs a little tweak.  I'd go for this variant of
it:


diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dfa1de89dc944..cb50f8d383606 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -192,7 +192,7 @@ void __init swiotlb_update_mem_attributes(void)
 }
 
 static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
-				    unsigned long nslabs, bool late_alloc)
+		unsigned long nslabs, unsigned int flags, bool late_alloc)
 {
 	void *vaddr = phys_to_virt(start);
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
@@ -203,8 +203,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->index = 0;
 	mem->late_alloc = late_alloc;
 
-	if (swiotlb_force_bounce)
-		mem->force_bounce = true;
+	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
 
 	spin_lock_init(&mem->lock);
 	for (i = 0; i < mem->nslabs; i++) {
@@ -275,8 +274,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
-	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
-	mem->force_bounce = flags & SWIOTLB_FORCE;
+	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false);
 
 	if (flags & SWIOTLB_VERBOSE)
 		swiotlb_print_info();
@@ -348,7 +346,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 
 	set_memory_decrypted((unsigned long)vstart,
 			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
-	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, true);
+	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true);
 
 	swiotlb_print_info();
 	return 0;
@@ -835,8 +833,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
 				     rmem->size >> PAGE_SHIFT);
-		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false);
-		mem->force_bounce = true;
+		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, SWIOTLB_FORCE,
+				false);
 		mem->for_alloc = true;
 
 		rmem->priv = mem;

