Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465455572A4
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jun 2022 07:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiFWFn4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jun 2022 01:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFWFnz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jun 2022 01:43:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B63631231;
        Wed, 22 Jun 2022 22:43:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6917D68AFE; Thu, 23 Jun 2022 07:43:52 +0200 (CEST)
Date:   Thu, 23 Jun 2022 07:43:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        Andrea.Parri@microsoft.com, Tianyu.Lan@microsoft.com
Subject: Re: [PATCH] dma-direct: use the correct size for
 dma_set_encrypted()
Message-ID: <20220623054352.GA12543@lst.de>
References: <20220622191424.15777-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622191424.15777-1-decui@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 22, 2022 at 12:14:24PM -0700, Dexuan Cui wrote:
> The third parameter of dma_set_encrypted() is a size in bytes rather than
> the number of pages.
> 
> Fixes: 4d0564785bb0 ("dma-direct: factor out dma_set_{de,en}crypted helpers")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

see:

commit 4a37f3dd9a83186cb88d44808ab35b78375082c9 (tag: dma-mapping-5.19-2022-05-25)
Author: Robin Murphy <robin.murphy@arm.com>
Date:   Fri May 20 18:10:13 2022 +0100

    dma-direct: don't over-decrypt memory
