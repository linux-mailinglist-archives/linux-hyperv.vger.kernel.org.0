Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16184C6A7C
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Feb 2022 12:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiB1Lb2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Feb 2022 06:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiB1Lb2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Feb 2022 06:31:28 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C8D51E42;
        Mon, 28 Feb 2022 03:30:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E95C68AFE; Mon, 28 Feb 2022 12:30:43 +0100 (CET)
Date:   Mon, 28 Feb 2022 12:30:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "tboot-devel@lists.sourceforge.net" 
        <tboot-devel@lists.sourceforge.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 08/11] swiotlb: make the swiotlb_init interface more
 useful
Message-ID: <20220228113042.GA10570@lst.de>
References: <20220227143055.335596-1-hch@lst.de> <20220227143055.335596-9-hch@lst.de> <MN0PR21MB309816A344171B46735CA29CD7019@MN0PR21MB3098.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR21MB309816A344171B46735CA29CD7019@MN0PR21MB3098.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 28, 2022 at 02:53:39AM +0000, Michael Kelley (LINUX) wrote:
> From: Christoph Hellwig <hch@lst.de> Sent: Sunday, February 27, 2022 6:31 AM
> > 
> > Pass a bool to pass if swiotlb needs to be enabled based on the
> > addressing needs and replace the verbose argument with a set of
> > flags, including one to force enable bounce buffering.
> > 
> > Note that this patch removes the possibility to force xen-swiotlb
> > use using swiotlb=force on the command line on x86 (arm and arm64
> > never supported that), but this interface will be restored shortly.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/arm/mm/init.c                     |  6 +----
> >  arch/arm64/mm/init.c                   |  6 +----
> >  arch/ia64/mm/init.c                    |  4 +--
> >  arch/mips/cavium-octeon/dma-octeon.c   |  2 +-
> >  arch/mips/loongson64/dma.c             |  2 +-
> >  arch/mips/sibyte/common/dma.c          |  2 +-
> >  arch/powerpc/include/asm/swiotlb.h     |  1 +
> >  arch/powerpc/mm/mem.c                  |  3 ++-
> >  arch/powerpc/platforms/pseries/setup.c |  3 ---
> >  arch/riscv/mm/init.c                   |  8 +-----
> >  arch/s390/mm/init.c                    |  3 +--
> >  arch/x86/kernel/cpu/mshyperv.c         |  8 ------
> >  arch/x86/kernel/pci-dma.c              | 15 ++++++-----
> >  arch/x86/mm/mem_encrypt_amd.c          |  3 ---
> >  drivers/xen/swiotlb-xen.c              |  4 +--
> >  include/linux/swiotlb.h                | 15 ++++++-----
> >  include/trace/events/swiotlb.h         | 29 ++++++++-------------
> >  kernel/dma/swiotlb.c                   | 35 ++++++++++++++------------
> >  18 files changed, 56 insertions(+), 93 deletions(-)
> 
> [snip]
> 
> > 
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index 5a99f993e6392..568274917f1cd 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -336,14 +336,6 @@ static void __init ms_hyperv_init_platform(void)
> >  			swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
> >  #endif
> >  		}
> > -
> > -#ifdef CONFIG_SWIOTLB
> > -		/*
> > -		 * Enable swiotlb force mode in Isolation VM to
> > -		 * use swiotlb bounce buffer for dma transaction.
> > -		 */
> > -		swiotlb_force = SWIOTLB_FORCE;
> > -#endif
> 
> With this code removed, it's not clear to me what forces the use of the
> swiotlb in a Hyper-V isolated VM.  The code in pci_swiotlb_detect_4g() doesn't
> catch this case because cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)
> returns "false" in a Hyper-V guest.  In the Hyper-V guest, it's only
> cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) that returns "true".  I'm
> looking more closely at the meaning of the CC_ATTR_* values, and it may
> be that Hyper-V should also return "true" for CC_ATTR_MEM_ENCRYPT,
> but I don't think CC_ATTR_HOST_MEM_ENCRYPT should return "true".

Ok, I assumed that CC_ATTR_HOST_MEM_ENCRYPT returned true in this case.
I guess we just need to check for CC_ATTR_GUEST_MEM_ENCRYPT as well
there?
