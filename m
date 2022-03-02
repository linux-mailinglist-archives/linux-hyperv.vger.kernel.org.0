Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F144C9EF6
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 09:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbiCBIPx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 03:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCBIPw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 03:15:52 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290A3B7C40;
        Wed,  2 Mar 2022 00:15:10 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 527A368BEB; Wed,  2 Mar 2022 09:15:01 +0100 (CET)
Date:   Wed, 2 Mar 2022 09:15:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        x86@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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
Subject: Re: [PATCH 11/12] swiotlb: merge swiotlb-xen initialization into
 swiotlb
Message-ID: <20220302081500.GB23075@lst.de>
References: <20220301105311.885699-1-hch@lst.de> <20220301105311.885699-12-hch@lst.de> <alpine.DEB.2.22.394.2203011720150.3261@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2203011720150.3261@ubuntu-linux-20-04-desktop>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 06:55:47PM -0800, Stefano Stabellini wrote:
> Unrelated to this specific patch series: now that I think about it, if
> io_tlb_default_mem.nslabs is already allocated by the time xen_mm_init
> is called, wouldn't we potentially have an issue with the GFP flags used
> for the earlier allocation (e.g. GFP_DMA32 not used)? Maybe something
> for another day.

swiotlb_init allocates low memory from meblock, which is roughly
equivalent to GFP_DMA allocations, so we'll be fine.

> > @@ -143,10 +141,15 @@ static int __init xen_mm_init(void)
> >  	if (!xen_swiotlb_detect())
> >  		return 0;
> >  
> > -	rc = xen_swiotlb_init();
> >  	/* we can work with the default swiotlb */
> > -	if (rc < 0 && rc != -EEXIST)
> > -		return rc;
> > +	if (!io_tlb_default_mem.nslabs) {
> > +		if (!xen_initial_domain())
> > +			return -EINVAL;
> 
> I don't think we need this xen_initial_domain() check. It is all
> already sorted out by the xen_swiotlb_detect() check above.

Is it?

static inline int xen_swiotlb_detect(void)
{
	if (!xen_domain())
		return 0;
	if (xen_feature(XENFEAT_direct_mapped))
		return 1;
	/* legacy case */
	if (!xen_feature(XENFEAT_not_direct_mapped) && xen_initial_domain())
		return 1;
	return 0;
}

I think I'd keep it as-is for now, as my planned next step would be to
fold xen-swiotlb into swiotlb entirely.
