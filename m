Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A453AC89
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jun 2022 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356175AbiFASME (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Jun 2022 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiFASME (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Jun 2022 14:12:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733F915FC9;
        Wed,  1 Jun 2022 11:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CD7A6CE1D26;
        Wed,  1 Jun 2022 18:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA63C385A5;
        Wed,  1 Jun 2022 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654107120;
        bh=XyRtnaG4f6v1X+0b1Icwpx1CnomvwrWKo4GYEBNHb+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBs/HAWx4uM3HDoEzXU7+T8V9lyNwNqn4zd6Uh/AJGNo4QD8EzwUXHg8SF5aQu/eR
         anmAddXVYpYTPQXJYiVXSgAM6oeXwkinLakcGmSyuAZtpT4Gg5dXcDILW5BYrqp6yC
         vfOgfDXfoYgyw9l9+lVWSvldxx5jHryrGn/d5UzcJCJjQVQvAnn5PGnRbongr5jgLY
         JziHqqThI4bmA2WwIpuZHilJdJjc4uSPMPWYG0WUdO4ZhUny70sDURv0RtrDDn5Tm8
         XZjMRYHCt4Yp4VSnSP3UbNmDy1oSOc8nqKRVMKzHpT2VEuCPCTYpdk41t0XRp7VTN5
         o4MHC+cQamxCw==
Date:   Wed, 1 Jun 2022 11:11:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
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
Message-ID: <Yper7agk7XfCCQNa@dev-arch.thelio-3990X>
References: <20220404050559.132378-1-hch@lst.de>
 <20220404050559.132378-10-hch@lst.de>
 <YpehC7BwBlnuxplF@dev-arch.thelio-3990X>
 <20220601173441.GB27582@lst.de>
 <YpemDuzdoaO3rijX@Ryzen-9-3900X.>
 <20220601175743.GA28082@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601175743.GA28082@lst.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 01, 2022 at 07:57:43PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 01, 2022 at 10:46:54AM -0700, Nathan Chancellor wrote:
> > On Wed, Jun 01, 2022 at 07:34:41PM +0200, Christoph Hellwig wrote:
> > > Can you send me the full dmesg and the content of
> > > /sys/kernel/debug/swiotlb/io_tlb_nslabs for a good and a bad boot?
> > 
> > Sure thing, they are attached! If there is anything else I can provide
> > or test, I am more than happy to do so.
> 
> Nothing interesting.  But the performance numbers almost look like
> swiotlb=force got ignored before (even if I can't explain why).

I was able to get my performance back with this diff but I don't know if
this is a hack or a proper fix in the context of the series.

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dfa1de89dc94..0bfb2fe3d8c5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -276,7 +276,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		      __func__, alloc_size, PAGE_SIZE);
 
 	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
-	mem->force_bounce = flags & SWIOTLB_FORCE;
+	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
 
 	if (flags & SWIOTLB_VERBOSE)
 		swiotlb_print_info();

> Do you get a similar performance with the new kernel without
> swiotlb=force as the old one with that argument by any chance?

I'll see if I can test that, as I am not sure I have control over those
cmdline arguments.

Cheers,
Nathan
