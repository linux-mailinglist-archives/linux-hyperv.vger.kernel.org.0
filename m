Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF676B899
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Aug 2023 17:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjHAPbi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Aug 2023 11:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHAPbh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Aug 2023 11:31:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841C4EE;
        Tue,  1 Aug 2023 08:31:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18B5B615F1;
        Tue,  1 Aug 2023 15:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747A6C433C7;
        Tue,  1 Aug 2023 15:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690903895;
        bh=r5PsDp4On77OijBSy4XSqE+fneVpZ8oOUEVwG1Kl+9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0RGgnIbA43f0C/Gz6u+PEFaV0HmpD2KHxGJ/ctZfU4xX8Iwh/7s0NbTczNGAecDe
         Ajiw/uAN6p9Ybak/3g4GkTJZEdEtM2sS1o9qq+KSwcPv9EMLSTplcxoTXcihyDpolz
         HPWr7zF5DesQ4AVvRnLQRNHXaEBCNenTWaXx+yDEKA3VKD7S3Acqq+h8sAqECHHsY6
         DMcT4kR9W2J4Hpu71Ut0dnkUaK+RzRtCYnb/SR8zdS1Wfe4p+hMGeOIumz86yC+nrs
         kPyneppF67RAcP661vd1IgCDu3IGBfXSUzJr+GR+PA4YGMQW7mwpsr+37jv3O+aust
         +BlVlIu8JLFCQ==
Date:   Tue, 1 Aug 2023 17:31:29 +0200
From:   Simon Horman <horms@kernel.org>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
        stable@vger.kernel.org
Subject: Re: [PATCH V7 net] net: mana: Fix MANA VF unload when hardware is
Message-ID: <ZMklUch+vfZBqfAr@kernel.org>
References: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 01, 2023 at 05:29:13AM -0700, Souradeep Chakrabarti wrote:

...

Hi Souradeep,


> +	for (i = 0; i < apc->num_queues; i++) {
> +		txq = &apc->tx_qp[i].txq;
> +		while (skb = skb_dequeue(&txq->pending_skbs)) {

W=1 builds with both clang-16 and gcc-12 complain that
they would like an extra set of parentheses around
an assignment used as a truth value.

> +			mana_unmap_skb(skb, apc);
> +			dev_consume_skb_any(skb);
> +		}
> +		atomic_set(&txq->pending_sends, 0);
> +	}
>  	/* We're 100% sure the queues can no longer be woken up, because
>  	 * we're sure now mana_poll_tx_cq() can't be running.
>  	 */
> -- 
> 2.34.1
> 
> 
