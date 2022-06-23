Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698D8557CF0
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jun 2022 15:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiFWN2R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jun 2022 09:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiFWN2Q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jun 2022 09:28:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CC8BF60;
        Thu, 23 Jun 2022 06:28:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 87A4D67373; Thu, 23 Jun 2022 15:28:00 +0200 (CEST)
Date:   Thu, 23 Jun 2022 15:28:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Andrea Parri <Andrea.Parri@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH] dma-direct: use the correct size for
 dma_set_encrypted()
Message-ID: <20220623132800.GA9262@lst.de>
References: <20220622191424.15777-1-decui@microsoft.com> <20220623054352.GA12543@lst.de> <SN6PR2101MB132705E084BCC12BCDDF4E7FBFB59@SN6PR2101MB1327.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR2101MB132705E084BCC12BCDDF4E7FBFB59@SN6PR2101MB1327.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 23, 2022 at 07:00:58AM +0000, Dexuan Cui wrote:
> It looks like commit 4a37f3dd9a831 fixed a different issue?
> 
> Here my patch is for the latest mainline:
> 
> In dma_direct_alloc()'s error handling path, we pass 'size' to dma_set_encrypted():
>   out_encrypt_pages:
> 	  if (dma_set_encrypted(dev, page_address(page), size))
> 
> However, in dma_direct_free(), we pass ' 1 << page_order ' to dma_set_encrypted().
> I think the ' 1 << page_order' is incorrect and it should be 'size' as well?

Indeed.  I've applied the patch now.
