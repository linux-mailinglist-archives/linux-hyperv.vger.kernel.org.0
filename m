Return-Path: <linux-hyperv+bounces-1359-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C6818654
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Dec 2023 12:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1171F22D09
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Dec 2023 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA59154AF;
	Tue, 19 Dec 2023 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2+PCTGJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372F3182A0;
	Tue, 19 Dec 2023 11:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3223C433C9;
	Tue, 19 Dec 2023 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702985423;
	bh=GOOe1ZoFB2OwAip4rvP1V/xtwAtLfCfoucDuR1D/lrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s2+PCTGJYoaAgEKC8A84NOZ65mS0+wdg6yseWWpYr3TbZ56TEe0aK8wG+JAln7L1F
	 eWufbEhXA8dWtri/4+5OFq7oLRZQP2+AywQm/qKZKZKs/T1LhJT5hiXXO2aj2ARjxt
	 mPkrSu3lw7zEQkF+EpIG5Oh/Oaf1YxWkd1dAZiRj4lWsjflRhnCwT/75qbqL10Hdr7
	 ZPrCWln7qRzYe67YEnywTjbtTNbwOl3qyyoR3auPfI3ZrUnpm4yDb6Sn44WSqm7pW3
	 9uOPl0wzIWLX3ojEDXMebkC5GtQaPDuEP7wVaj0oZZdG+fAeLx+ObOqthAO2Es9hls
	 UnH+J2QGqunAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C738D8C98A;
	Tue, 19 Dec 2023 11:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mana: select PAGE_POOL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170298542363.4181.15570485393993326950.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 11:30:23 +0000
References: <20231215203353.635379-1-yury.norov@gmail.com>
In-Reply-To: <20231215203353.635379-1-yury.norov@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, schakrabarti@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Dec 2023 12:33:53 -0800 you wrote:
> Mana uses PAGE_POOL API. x86_64 defconfig doesn't select it:
> 
> ld: vmlinux.o: in function `mana_create_page_pool.isra.0':
> mana_en.c:(.text+0x9ae36f): undefined reference to `page_pool_create'
> ld: vmlinux.o: in function `mana_get_rxfrag':
> mana_en.c:(.text+0x9afed1): undefined reference to `page_pool_alloc_pages'
> make[3]: *** [/home/yury/work/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
> make[2]: *** [/home/yury/work/linux/Makefile:1154: vmlinux] Error 2
> make[1]: *** [/home/yury/work/linux/Makefile:234: __sub-make] Error 2
> make[1]: Leaving directory '/home/yury/work/build-linux-x86_64'
> make: *** [Makefile:234: __sub-make] Error 2
> 
> [...]

Here is the summary with links:
  - net: mana: select PAGE_POOL
    https://git.kernel.org/netdev/net/c/340943fbff3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



