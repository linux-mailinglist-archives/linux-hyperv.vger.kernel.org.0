Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6521A4CC2FA
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Mar 2022 17:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiCCQkf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Mar 2022 11:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiCCQkf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Mar 2022 11:40:35 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F18FF125537;
        Thu,  3 Mar 2022 08:39:48 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nPoU9-0008UX-00; Thu, 03 Mar 2022 17:39:25 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 23B82C28F1; Thu,  3 Mar 2022 17:39:00 +0100 (CET)
Date:   Thu, 3 Mar 2022 17:39:00 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
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
Subject: Re: [PATCH 06/12] MIPS/octeon: use swiotlb_init instead of open
 coding it
Message-ID: <20220303163900.GA11971@alpha.franken.de>
References: <20220301105311.885699-1-hch@lst.de>
 <20220301105311.885699-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301105311.885699-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 12:53:05PM +0200, Christoph Hellwig wrote:
> Use the generic swiotlb initialization helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/cavium-octeon/dma-octeon.c | 15 ++-------------
>  arch/mips/pci/pci-octeon.c           |  2 +-
>  2 files changed, 3 insertions(+), 14 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
