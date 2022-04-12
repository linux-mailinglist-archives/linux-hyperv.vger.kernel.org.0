Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326F94FCF5C
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Apr 2022 08:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiDLGXp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Apr 2022 02:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDLGXo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Apr 2022 02:23:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8C35269;
        Mon, 11 Apr 2022 23:21:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CD9FC68AA6; Tue, 12 Apr 2022 08:21:20 +0200 (CEST)
Date:   Tue, 12 Apr 2022 08:21:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        x86@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
Subject: Re: [PATCH 10/15] swiotlb: add a SWIOTLB_ANY flag to lift the low
 memory restriction
Message-ID: <20220412062120.GA7796@lst.de>
References: <20220404050559.132378-1-hch@lst.de> <20220404050559.132378-11-hch@lst.de> <Yk4vfAd0J5u+wUsq@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk4vfAd0J5u+wUsq@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 06, 2022 at 08:25:32PM -0400, Konrad Rzeszutek Wilk wrote:
> > diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> > index c5228f4969eb2..3b4045d508ec8 100644
> > --- a/arch/powerpc/platforms/pseries/svm.c
> > +++ b/arch/powerpc/platforms/pseries/svm.c
> > @@ -28,7 +28,7 @@ static int __init init_svm(void)
> >  	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
> >  	 * otherwise.
> >  	 */
> > -	swiotlb_force = SWIOTLB_FORCE;
> > +	ppc_swiotlb_flags |= SWIOTLB_ANY | SWIOTLB_FORCE;
> 
> This is the only place you set the ppc_swiotlb_flags.. so I wonder why
> the '|=' instead of just '=' ?

Preparing for setting others and not clobbering the value.
