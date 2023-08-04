Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B3E76FBB0
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Aug 2023 10:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjHDIKY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Aug 2023 04:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjHDIKX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Aug 2023 04:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FE74687;
        Fri,  4 Aug 2023 01:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4825C61F63;
        Fri,  4 Aug 2023 08:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1DE8C433CB;
        Fri,  4 Aug 2023 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691136621;
        bh=YZNe9yQeBFUem9NuaEnUAGWF5xNRlgYGY0hSbJMMoVU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lWgdqsyRWkHhMBGxNnJlT1TrUkZQ3JoCO8ezc1Rwm12HWnwGfktyiLyiw6845hmwV
         OYP/liHSaJmwr1C4pJa39aFM8NtD9MmzAJ5XmGX8uBaqhB53dJwniP7Wdz0YvtQdaX
         E+gmigPhrRyCemggFQiqBr++EAVupUJatvbtMmQ6+0pN8M7MbXwaevrSWx2JqUK61i
         8nvWvYmnrey5bCh+ionB+VQt3wIJuoIbzBxMvtx7vwJ8PBR8Tyz38eH37gT+3AURwH
         Yu3y4MF3akGZepWa0Zlpl28ETXztchHPrVR1yWMjf25W8jr8UDoI+CAyAVUa4GhMwT
         ro9EoPH8W+UdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8386AC6445B;
        Fri,  4 Aug 2023 08:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V6 net-next] net: mana: Configure hwc timeout from hardware
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169113662153.21944.15547696025000936680.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Aug 2023 08:10:21 +0000
References: <1690974460-15660-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1690974460-15660-1-git-send-email-schakrabarti@linux.microsoft.com>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, schakrabarti@microsoft.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  2 Aug 2023 04:07:40 -0700 you wrote:
> At present hwc timeout value is a fixed value. This patch sets the hwc
> timeout from the hardware. It now uses a new hardware capability
> GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG to query and set the value
> in hwc_timeout.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> 
> [...]

Here is the summary with links:
  - [V6,net-next] net: mana: Configure hwc timeout from hardware
    https://git.kernel.org/netdev/net-next/c/62c1bff593b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


