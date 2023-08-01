Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D7476A58D
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Aug 2023 02:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjHAAbY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Jul 2023 20:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHAAbX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Jul 2023 20:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562BA1999;
        Mon, 31 Jul 2023 17:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBDC661373;
        Tue,  1 Aug 2023 00:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFA5C433C7;
        Tue,  1 Aug 2023 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690849881;
        bh=edKPUxJSfxSwSgMp4ELrc17mhd6XvhBB05dcUDTu8PM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o52owDH10zGOWCtUIT8xi646am/uSlnvhQg5alGDBcj6z+WgLHgQr14m1GIENgyko
         YCmsi6UwSKPXC7H5UCme6ceAfT6mg2qCZwNrxhfhvPhV5FhEMAtNa0LMrkOigaeRNi
         XTR6LkX+85ifqjNVdK3q2b4/wE0EPneTiOmHgfqx/R9wt+n1Y+4Apn9dxBkwnhDDv+
         qedsv/MKItKNBFjYfsI/41KDd7LuNjZNg2g+8G3Rq5DEsWapBovfCf1dr33K9NKSmd
         vIYfqGXElKeaxFaZo2wKq4pgFgsue0aFEu1FydnI+z4eYoBGQv+g71nN+3Qv2BVXHE
         0ju5++uayZdLg==
Date:   Mon, 31 Jul 2023 17:31:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        wei.liu@kernel.org, edumazet@google.com, pabeni@redhat.com,
        leon@kernel.org, longli@microsoft.com, ssengar@linux.microsoft.com,
        linux-rdma@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        sharmaajay@microsoft.com, hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4,net-next] net: mana: Add page pool for RX buffers
Message-ID: <20230731173119.3ca14894@kernel.org>
In-Reply-To: <1690580767-18937-1-git-send-email-haiyangz@microsoft.com>
References: <1690580767-18937-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 28 Jul 2023 14:46:07 -0700 Haiyang Zhang wrote:
>  static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
> -			     dma_addr_t *da, bool is_napi)
> +			     dma_addr_t *da, bool *from_pool, bool is_napi)
>  {
>  	struct page *page;
>  	void *va;
>  
> +	*from_pool = false;
> +
>  	/* Reuse XDP dropped page if available */
>  	if (rxq->xdp_save_va) {
>  		va = rxq->xdp_save_va;
> @@ -1533,17 +1543,22 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
>  			return NULL;
>  		}
>  	} else {
> -		page = dev_alloc_page();
> +		page = page_pool_dev_alloc_pages(rxq->page_pool);
>  		if (!page)
>  			return NULL;
>  
> +		*from_pool = true;
>  		va = page_to_virt(page);
>  	}
>  
>  	*da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
>  			     DMA_FROM_DEVICE);
>  	if (dma_mapping_error(dev, *da)) {
> -		put_page(virt_to_head_page(va));
> +		if (*from_pool)
> +			page_pool_put_full_page(rxq->page_pool, page, is_napi);

AFAICT you only pass the is_napi to recycle in case of error?
It's fine to always pass in false, passing true enables some
optimizations but it's not worth trying to optimize error paths.

Otherwise you may be passing in true, even tho budget was 0,
see the recently added warnings in this doc:

https://www.kernel.org/doc/html/next/networking/napi.html

In general the driver seems to be processing Rx regardless
of budget? This looks like a bug which should be fixed with
a separate patch for the net tree..
-- 
pw-bot: cr
