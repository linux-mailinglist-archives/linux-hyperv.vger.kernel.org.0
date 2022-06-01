Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E9353AC48
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jun 2022 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354621AbiFAR55 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Jun 2022 13:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbiFAR54 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Jun 2022 13:57:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF0996BB;
        Wed,  1 Jun 2022 10:57:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D34A568C4E; Wed,  1 Jun 2022 19:57:44 +0200 (CEST)
Date:   Wed, 1 Jun 2022 19:57:43 +0200
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
Message-ID: <20220601175743.GA28082@lst.de>
References: <20220404050559.132378-1-hch@lst.de> <20220404050559.132378-10-hch@lst.de> <YpehC7BwBlnuxplF@dev-arch.thelio-3990X> <20220601173441.GB27582@lst.de> <YpemDuzdoaO3rijX@Ryzen-9-3900X.>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpemDuzdoaO3rijX@Ryzen-9-3900X.>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 01, 2022 at 10:46:54AM -0700, Nathan Chancellor wrote:
> On Wed, Jun 01, 2022 at 07:34:41PM +0200, Christoph Hellwig wrote:
> > Can you send me the full dmesg and the content of
> > /sys/kernel/debug/swiotlb/io_tlb_nslabs for a good and a bad boot?
> 
> Sure thing, they are attached! If there is anything else I can provide
> or test, I am more than happy to do so.

Nothing interesting.  But the performance numbers almost look like
swiotlb=force got ignored before (even if I can't explain why).
Do you get a similar performance with the new kernel without
swiotlb=force as the old one with that argument by any chance?

