Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3775A519
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jul 2023 06:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGTE3w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Jul 2023 00:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGTE3p (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Jul 2023 00:29:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540A52112;
        Wed, 19 Jul 2023 21:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5756615B6;
        Thu, 20 Jul 2023 04:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1284CC433C7;
        Thu, 20 Jul 2023 04:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689827381;
        bh=00793e+DVIX+KzxECbpJoJSmHqRjPxWfvFAIRLmu5OA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lGl4yoxCXG41iA0WBnzxDW4JqpYchqiEsKe/VNW6L/qU6UGFO0ogtp3fuAC4r1um7
         iYQh1T6+hImHQQNvTaKBU+rDhBSD67g4nEKwJi8l2B2r7u2KvoquSSDlSAP2q0q8Ui
         A3EfdWFfkVs8HdRr8NxhJfeDc21tt9TQe0Fsg9/UlXEBOyWrMlkaR562Of//eGyWsn
         Ib5OkPFx65BMxlypb9N0lzKSx+e3ifn8i726AdE/2j7vuVqsdJ1zBOAG8+EHX+PY0T
         kSmfESVk0CyowibqH1c4ilI1Gnk74Lk1NoKUu/v7hjTvpXsUh7/S5Gv5oT8hHDAG9b
         6c3/HW/ju95xA==
Date:   Wed, 19 Jul 2023 21:29:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Paul Rosswurm <paulros@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Long Li <longli@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2,net-next] net: mana: Add page pool for RX buffers
Message-ID: <20230719212939.6da38bc0@kernel.org>
In-Reply-To: <1689716837-22859-1-git-send-email-haiyangz@microsoft.com>
References: <1689716837-22859-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 18 Jul 2023 21:48:01 +0000 Haiyang Zhang wrote:
> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> usage.
> 
> The standard page pool API is used.

> @@ -1437,8 +1437,12 @@ static void mana_rx_skb(void *buf_va, struct mana_rxcomp_oob *cqe,
>  
>  	act = mana_run_xdp(ndev, rxq, &xdp, buf_va, pkt_len);
>  
> -	if (act == XDP_REDIRECT && !rxq->xdp_rc)
> +	if (act == XDP_REDIRECT && !rxq->xdp_rc) {
> +		if (from_pool)
> +			page_pool_release_page(rxq->page_pool,
> +					       virt_to_head_page(buf_va));


IIUC you should pass the page_pool as the last argument to 
xdp_rxq_info_reg_mem_model() and then the page will be recycled
by the core, you shouldn't release it.

Not to mention the potential race in releasing the page _after_
giving its ownership to someone else.

> -		page = dev_alloc_page();
> +		if (is_napi) {
> +			page = page_pool_dev_alloc_pages(rxq->page_pool);
> +			*from_pool = true;
> +		} else {
> +			page = dev_alloc_page();

FWIW if you're only calling this outside NAPI during init, when NAPI
can't yet run, I _think_ it's okay to use page_pool_dev_alloc..

> +	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
> +	pprm.napi = &cq->napi;
> +	pprm.dev = gc->dev;
> +	pprm.dma_dir = DMA_FROM_DEVICE;

If you're not setting PP_FLAG_DMA_MAP you don't have to fill in .dev
and .dma_dir
-- 
pw-bot: cr
