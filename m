Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A206F758AA6
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jul 2023 03:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGSBKX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jul 2023 21:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGSBKW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jul 2023 21:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7731BC9;
        Tue, 18 Jul 2023 18:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88D5D6165D;
        Wed, 19 Jul 2023 01:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA564C433C9;
        Wed, 19 Jul 2023 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689729020;
        bh=8uyzKeu0wc6Hx7Imh1qAvDMKXqLGtbXjib7QCg+BnoY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gmKQOLX/yRw1rehxHT36YwhiSpD2wemNY3fpDVKio9obYi6NVZzPuebwgwYq1DXnR
         tA+sC/Fp1IfGiQYaoFhnYGmga7srDWHemBWhuN4t9ZsGgECmvShFwtu/7G/H0cx64h
         xGATYg4BHEpzJZ9rMEo3zoX7hXkb3a5tCMMF9iMJkV7tC33+dHQsoAeSnAA1OnYyfx
         z+k9zmZJKKWKhZ/O2Qo2+deNMiBFF56o60TUB3nEaeDqMm+XVCzUlOsGg3vMcsPTLO
         fQTFR3n5yvXRuj7MKjt9Pjmmn5bV3RVDjDcbsejeid7BUUciZ10+5XYQSOmmQhoTkF
         2S6exVlPRzMpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B84A3E22AE5;
        Wed, 19 Jul 2023 01:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] net: mana: Fix doorbell access for receive
 queues
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168972902074.27339.4961524881836853022.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 01:10:20 +0000
References: <1689622539-5334-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1689622539-5334-1-git-send-email-longli@linuxonhyperv.com>
To:     Long Li <longli@linuxonhyperv.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
        shradhagupta@linux.microsoft.com, sharmaajay@microsoft.com,
        shacharr@microsoft.com, stephen@networkplumber.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        longli@microsoft.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 12:35:37 -0700 you wrote:
> From: Long Li <longli@microsoft.com>
> 
> This patchset fixes the issues discovered during 200G physical link
> tests. It fixes doorbell usage and WQE format for receive queues.
> 
> Long Li (2):
>   net: mana: Batch ringing RX queue doorbell on receiving packets
>   net: mana: Use the correct WQE count for ringing RQ doorbell
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net: mana: Batch ringing RX queue doorbell on receiving packets
    https://git.kernel.org/netdev/net-next/c/da4e8648079e
  - [net-next,v5,2/2] net: mana: Use the correct WQE count for ringing RQ doorbell
    https://git.kernel.org/netdev/net-next/c/f5e39b57124f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


