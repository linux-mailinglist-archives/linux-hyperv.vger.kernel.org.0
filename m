Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A6172B360
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Jun 2023 20:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjFKSTE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 11 Jun 2023 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFKSTD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 11 Jun 2023 14:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE37E5F;
        Sun, 11 Jun 2023 11:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91F14610AA;
        Sun, 11 Jun 2023 18:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA5AC433D2;
        Sun, 11 Jun 2023 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686507541;
        bh=O99afy8z9kTwdac04Hv6li+a46VqmosWOQ4/9F029kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QG7Vgf4TZOTu7m6qZwI4duwiwS7Vm1PiqYwd8jXSdfrwKBFRDgELrBu00WUp7ihN8
         rELji8wSbEGvbJn0H0aJOmzkmsGTu2jho9BZZAZxp5jDph3fXoTKfUzEFd6Fg0TcBY
         DNrSz6sQeg0dTUd1czI7LK3hbczg6xYDMnZ609bbasRXDL61umiBuMfFHXfHnpUECO
         L68fJznihtjzMrCM8I3tps3pobWATIm3i6lGTQ5SBOVRgIoH9K+uogWbBAHHwQm1Cq
         Trjpq83nkVeV1Ij0HeSQXkCo24aYAvmwvTzsVtdAmcGc12fo3lksvubmEIPUR8ZPtv
         UZsXtmawotAog==
Date:   Sun, 11 Jun 2023 21:18:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wei Hu <weh@microsoft.com>
Cc:     netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, longli@microsoft.com,
        sharmaajay@microsoft.com, jgg@ziepe.ca, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vkuznets@redhat.com,
        ssengar@linux.microsoft.com, shradhagupta@linux.microsoft.com
Subject: Re: [PATCH v2 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <20230611181857.GK12152@unreal>
References: <20230606151747.1649305-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606151747.1649305-1-weh@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 06, 2023 at 03:17:47PM +0000, Wei Hu wrote:
> Add EQ interrupt support for mana ib driver. Allocate EQs per ucontext
> to receive interrupt. Attach EQ when CQ is created. Call CQ interrupt
> handler when completion interrupt happens. EQs are destroyed when
> ucontext is deallocated.
> 
> The change calls some public APIs in mana ethernet driver to
> allocate EQs and other resources. Ehe EQ process routine is also shared
> by mana ethernet and mana ib drivers.
> 
> Co-developed-by: Ajay Sharma <sharmaajay@microsoft.com>
> Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
> 
> v2: Use ibdev_dbg to print error messages and return -ENOMEN
>     when kzalloc fails.

<...>

> +	if (atomic_read(&ibcq->usecnt) == 0) {

What exactly are you checking here? And in all places where you access ibcq->usecnt?

> +		mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
> +		ibdev_dbg(ibdev, "freeing gdma cq %p\n", gc->cq_table[cq->id]);
> +		kfree(gc->cq_table[cq->id]);
> +		gc->cq_table[cq->id] = NULL;
> +		ib_umem_release(cq->umem);
> +	}
>  
>  	return 0;
>  }
> +
> +void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq)
> +{
> +	struct mana_ib_cq *cq = ctx;
> +	struct ib_device *ibdev = cq->ibcq.device;
> +
> +	ibdev_dbg(ibdev, "Enter %s %d\n", __func__, __LINE__);

This patch has two many debug prints, most if not all should go.

Thanks
