Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A572F777F47
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Aug 2023 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjHJRkX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Aug 2023 13:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjHJRkW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Aug 2023 13:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36F2700;
        Thu, 10 Aug 2023 10:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF437619C4;
        Thu, 10 Aug 2023 17:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08B72C433C7;
        Thu, 10 Aug 2023 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691689221;
        bh=DgGIQxm9T3j5F5GS/tDZyHr6yrkokRMtYqyjFvotMd4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qQqjUiW47BPOFQCeCERwTvIkf4E83TbWzVQC/CRQofvOEhCOo4/tYWQbCTpKzmDg6
         oSw9fW1LGx2qMZovEja3J8zzS68C4bG1TCs2Ri9H93HNCvlVIPPvWF47AL2GW+/WUB
         MeQW1wjxowULzaKhkpd/NJgRK+lFdrCO4rM6TjViuDGXoBNPS3p414WgwlKXlQZuWA
         jBiOqAT/B+SOYO4Rfb+lhyjS8vVx+fSHG5DkSC9V8WBemgTaFd7XZx2/ZFt5BhSI/d
         kzuMp3GXzJHDz6j/COgR5ewWIrx/5EnQsQLAonkbScbwyEKYrIGYkg0pu53US4dvHF
         /QTk4NgBdwpMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE717C64459;
        Thu, 10 Aug 2023 17:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V8 net] net: mana: Fix MANA VF unload when hardware is
 unresponsive
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169168922090.685.4553491279994848251.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Aug 2023 17:40:20 +0000
References: <1691576525-24271-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1691576525-24271-1-git-send-email-schakrabarti@linux.microsoft.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Aug 2023 03:22:05 -0700 you wrote:
> When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
> hardware to complete any inflight packets and set the pending send count
> to zero. But if the hardware has failed, mana_dealloc_queues()
> could wait forever.
> 
> Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
> which is a somewhat arbitrary value that is more than long enough for
> functional hardware to complete any sends.
> 
> [...]

Here is the summary with links:
  - [V8,net] net: mana: Fix MANA VF unload when hardware is unresponsive
    https://git.kernel.org/netdev/net/c/a7dfeda6fdec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


