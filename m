Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEECB4FEFB5
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Apr 2022 08:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiDMGXE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Apr 2022 02:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiDMGXC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Apr 2022 02:23:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B24551D;
        Tue, 12 Apr 2022 23:20:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5281E68B05; Wed, 13 Apr 2022 08:20:37 +0200 (CEST)
Date:   Wed, 13 Apr 2022 08:20:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
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
Subject: Re: cleanup swiotlb initialization v8
Message-ID: <20220413062037.GA450@lst.de>
References: <20220404050559.132378-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404050559.132378-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Apr 04, 2022 at 07:05:44AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series tries to clean up the swiotlb initialization, including
> that of swiotlb-xen.  To get there is also removes the x86 iommu table
> infrastructure that massively obsfucates the initialization path.
> 
> Git tree:
> 
>     git://git.infradead.org/users/hch/misc.git swiotlb-init-cleanup
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-init-cleanup

I've updated the git tree above with the commit message nitpicks and
received reviews.  I plan to pull the patches into the dma-mapping
tree after -rc3 is released, so if any involved maintainer is not happy
with the result, please speak up now.
