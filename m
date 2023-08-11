Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF3778959
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjHKJA2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHKJAZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 05:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53F71FE6;
        Fri, 11 Aug 2023 02:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 489BD6631E;
        Fri, 11 Aug 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 981E5C433D9;
        Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691744424;
        bh=6HkZ14rxNckm2IMLL9JlA53nYCTTpxgs/GkWA7jwLbc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gYBIDRqjX/zEdrhRuCq/M1JirKTFx7+iVmxL+B76yj6XGNUMvyg3NDkHs+AmShc9L
         hfGLZKmGkhE2LdYnTo//8IRcaUWxssIXViDeuDm/G+vlResKkpYKyvSJvDeTWOMtXx
         gd/Gl+4vIkblNC3DlOG1eCHLdOl8U3LfV0VK9ESd70gPC4seKpyEZezIrVcvmjT13S
         j4cgFdyO1YlMlQ4hwMyMgA9Ls/KZaGrzFDd4/5TcgmHfZfKyh/j9NsVfMf3+p7mcAQ
         QhH05HmCLP9ToC82mIu05eV8optO4f0Muqwm3w0KYOgUQwmgOqoNmt8rCgkdRgO4nE
         8tT0Ss6Xs8Ihg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B82EE21ECE;
        Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: Add gdma stats to ethtool output for
 mana
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169174442450.10902.7270114450407172453.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 09:00:24 +0000
References: <1691640922-11362-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1691640922-11362-1-git-send-email-shradhagupta@linux.microsoft.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sharmaajay@microsoft.com, leon@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
        mikelley@microsoft.com, shradhagupta@microsoft.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  9 Aug 2023 21:15:22 -0700 you wrote:
> Extended performance counter stats in 'ethtool -S <interface>'
> for MANA VF to include GDMA tx LSO packets and bytes count.
> 
> Tested-on: Ubuntu22
> Testcases:
> 1. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
> 2. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV
> 3. Validated the GDMA stat packets and byte counters
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Add gdma stats to ethtool output for mana
    https://git.kernel.org/netdev/net-next/c/ac3899c62296

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


