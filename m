Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0DD56A917
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbiGGRHQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiGGRHP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 13:07:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3241B4D4C6;
        Thu,  7 Jul 2022 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HovvFFoY7D838hXPBREd1aNwqat8RfYwwK9QiIIVY3U=; b=WqLQNmwKPMLPy2wckZKCKxD3R7
        8CxT62mp7vdl5Gus1MdpnQTGSiKK2U0lJVJmQunwIC+fZp+s7kN7EJm0uPu80sOF5Ysa11jb16Ht9
        sjfuVDGyb8SiE1sntIVqLi4d1VRo7/fy7K62YDyR2n0P1DMp4Pwa1GkDx5FPIW8Tl5USpHnOnwoyI
        ASE+YNxkfaSv63xI4W+POjieNQj3mAUb2/kOXYWEMIPXtStgVujuPj/OvjXRow0adYe4FJ+Vg/Oyc
        JVsPbpc/ze1q8BMiSf3WlCbjuO3EUj4vhdfHeMWZa0pZURzoCznZGa99ogqoljhQX72r2Mr2zitQa
        NDjqWo0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9Uxw-00H9AX-54; Thu, 07 Jul 2022 17:07:00 +0000
Date:   Thu, 7 Jul 2022 10:07:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     corbet@lwn.net, hch@infradead.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, paulmck@kernel.org, bp@suse.de,
        akpm@linux-foundation.org, keescook@chromium.org, pmladek@suse.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        kirill.shutemov@intel.com, andi.kleen@intel.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH V3] swiotlb: Split up single swiotlb lock
Message-ID: <YscStPk/IXW9PPmh@infradead.org>
References: <20220707082436.447984-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707082436.447984-1-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 07, 2022 at 04:24:36AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Traditionally swiotlb was not performance critical because it was only
> used for slow devices. But in some setups, like TDX/SEV confidential
> guests, all IO has to go through swiotlb. Currently swiotlb only has a
> single lock. Under high IO load with multiple CPUs this can lead to
> significat lock contention on the swiotlb lock.
> 
> This patch splits the swiotlb bounce buffer pool into individual areas
> which have their own lock. Each CPU tries to allocate in its own area
> first. Only if that fails does it search other areas. On freeing the
> allocation is freed into the area where the memory was originally
> allocated from.
> 
> Area number can be set via swiotlb kernel parameter and is default
> to be possible cpu number. If possible cpu number is not power of
> 2, area number will be round up to the next power of 2.
> 
> This idea from Andi Kleen patch(https://github.com/intel/tdx/commit/
> 4529b5784c141782c72ec9bd9a92df2b68cb7d45).

Thanks, this looks much better.  I think there is a small problem
with how default_nareas is set - we need to use 0 as the default
so that an explicit command line value of 1 works.  Als have you
checked the interaction with swiotlb_adjust_size in detail?

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 5536d2cd69d30..85b1c29dd0eb8 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -70,7 +70,7 @@ struct io_tlb_mem io_tlb_default_mem;
 phys_addr_t swiotlb_unencrypted_base;
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
-static unsigned long default_nareas = 1;
+static unsigned long default_nareas;
 
 /**
  * struct io_tlb_area - IO TLB memory area descriptor
@@ -90,7 +90,10 @@ struct io_tlb_area {
 
 static void swiotlb_adjust_nareas(unsigned int nareas)
 {
-	if (!is_power_of_2(nareas))
+	if (default_nareas)
+		return;
+
+	if (nareas > 1 && !is_power_of_2(nareas))
 		nareas = roundup_pow_of_two(nareas);
 
 	default_nareas = nareas;
@@ -338,8 +341,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
-	if (default_nareas == 1)
-		swiotlb_adjust_nareas(num_possible_cpus());
+	swiotlb_adjust_nareas(num_possible_cpus());
 
 	mem->areas = memblock_alloc(sizeof(struct io_tlb_area) *
 		default_nareas, SMP_CACHE_BYTES);
@@ -410,8 +412,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 			(PAGE_SIZE << order) >> 20);
 	}
 
-	if (default_nareas == 1)
-		swiotlb_adjust_nareas(num_possible_cpus());
+	swiotlb_adjust_nareas(num_possible_cpus());
 
 	area_order = get_order(array_size(sizeof(*mem->areas),
 		default_nareas));
