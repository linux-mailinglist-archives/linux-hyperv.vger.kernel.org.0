Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D717628EF
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 04:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGZC5B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jul 2023 22:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGZC5A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jul 2023 22:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795CA193;
        Tue, 25 Jul 2023 19:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A6E61199;
        Wed, 26 Jul 2023 02:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957A2C433C8;
        Wed, 26 Jul 2023 02:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690340215;
        bh=CbLxxa3u8xJbX+yXwwYh9sNVab+LKsl8mbRxbBao4+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V7CmLC0tpxIzeUR4SXWl4mOegP7XX9J4Xo9XKyg/Bl2dUlXhMKI3vycvAEpeRxRYD
         30rBvDson5HiHyCTJjR3tbyTD3TiKnxhix7K4rrbEgEvXFc4uq39Yh+5nJHoV1yOFd
         wk0EY3tISmhpd3cbHfAATp02x9DFOjJUSRr5hR88P4OBzHbsBfR5eB9E+6YTmL2Kng
         p3t7zUu0MzgcP1Dfas01UDW45dmCkD52xc4zQ/vCfnP5ZGA/wa8njJQtjl3Nn25DgX
         cjLMoxJzWHbW6/UpJvQ9H9Y0Kww2K0Ykrvf9BIFpRyHV349TIMiVS03Qkh+HF7E2Rw
         Czhl2qKVlMnaA==
Date:   Tue, 25 Jul 2023 19:56:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, longli@microsoft.com, sharmaajay@microsoft.com,
        leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, schakrabarti@microsoft.com
Subject: Re: [PATCH V5 net-next] net: mana: Configure hwc timeout from
 hardware
Message-ID: <20230725195653.2ed5cecc@kernel.org>
In-Reply-To: <1690177120-20938-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1690177120-20938-1-git-send-email-schakrabarti@linux.microsoft.com>
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

On Sun, 23 Jul 2023 22:38:40 -0700 Souradeep Chakrabarti wrote:
> @@ -825,7 +847,8 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  		goto out;
>  	}
>  
> -	if (!wait_for_completion_timeout(&ctx->comp_event, 30 * HZ)) {
> +	if (!wait_for_completion_timeout(&ctx->comp_event,
> +					 (hwc->hwc_timeout / 1000) * HZ)) {
>  		dev_err(hwc->dev, "HWC: Request timed out!\n");
>  		err = -ETIMEDOUT;
>  		goto out;

msecs_to_jiffies()
-- 
pw-bot: cr
