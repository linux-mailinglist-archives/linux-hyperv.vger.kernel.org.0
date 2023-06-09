Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A480729736
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jun 2023 12:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbjFIKnL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jun 2023 06:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbjFIKmR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jun 2023 06:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CAA2134;
        Fri,  9 Jun 2023 03:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD2A8656BC;
        Fri,  9 Jun 2023 10:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E90DC4339C;
        Fri,  9 Jun 2023 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686307221;
        bh=HqRF6r8J75am0/TGz1JIrl9KjnRcfUrduSSaH/UbhKk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ioKa0004fqkfvxKyNFMCujzB8yWuxMq3APBai4E4xy9Le/wO9/LY/YoDVpUrYSLia
         6uyfnzwqFFaopo/Hu1EKLwxbTEJdUqhZOPnoVwodzSepslh0IokHl3C8YjGx2ZAICM
         6XESD3HNp1dKS+rN2RuVWdRRgRFmR3z/PgPsVouhMpOWhhwFzvU+HDc/kdogCYoKDp
         QEspCMDcpi4MuuBHleAedA0VVjO3m0K1iUBsQis1gMcldlBoqMx89oBoM2u4k3ynOl
         sgl13hwaiJn7SPHJ/DZhphk5MQJNE4O8LVeXw24ALLiVRvc1KbOoJTiIcf524bvrXq
         jnZOCijYP8Dtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 016E2C43157;
        Fri,  9 Jun 2023 10:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 3/3] tools: ynl: Remove duplicated include in
 devlink-user.c
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168630722099.15877.14513212480913480643.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Jun 2023 10:40:20 +0000
References: <20230609085249.131071-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230609085249.131071-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     simon.horman@corigine.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, abaci@linux.alibaba.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  9 Jun 2023 16:52:47 +0800 you wrote:
> ./tools/net/ynl/generated/devlink-user.c: stdlib.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5464
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  tools/net/ynl/generated/devlink-user.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next,3/3] tools: ynl: Remove duplicated include in devlink-user.c
    (no matching commit)
  - [net-next,2/3] tools: ynl: Remove duplicated include in handshake-user.c
    https://git.kernel.org/netdev/net-next/c/e7c5433c5aaa
  - [net-next,1/3] net: hv_netvsc: Remove duplicated include in rndis_filter.c
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


