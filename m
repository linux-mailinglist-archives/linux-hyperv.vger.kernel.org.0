Return-Path: <linux-hyperv+bounces-1335-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D918147EA
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Dec 2023 13:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7E1B22C8B
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Dec 2023 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51C72D021;
	Fri, 15 Dec 2023 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH9rcP22"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA592CCBB;
	Fri, 15 Dec 2023 12:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E9F9C433CC;
	Fri, 15 Dec 2023 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702642826;
	bh=V9TNiHskbUfZDNQZD8GZjX7YXu5p6erkMiCFLD212bk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gH9rcP22FCLa46eetcuEXz7gnXiy5Z4ZZknSnK6kH/UkeqyF8QXVLbwcycNkwhcwe
	 Jm90YE8oRcQhzUi5oQIfZzqNWVwXOc1ONiPnfT8YHHacAE9qJXfIjBkMJeqtc9y76G
	 B+7STOte8MAkbcgzix1O0TxRC//cOPWS38T/8p0Ayu0s7U7MM49KSab4XICAHgNBa0
	 wkvZcR4EqaIphkqzXirGsZxZdgpfQUZ+yoNlaKpsyM35hdSS0m74NfReLDK4Z6qJOn
	 M95owJfr2LRaLJKYFQQNi7BdfKFSMCsUSNlps8JNtTgrWG2fbaBMON0E1Cbav+6EXS
	 NdtzCJAge+7tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3297CDD4EFE;
	Fri, 15 Dec 2023 12:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hv_netvsc: remove duplicated including of slab.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170264282620.26998.13254268990844297465.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 12:20:26 +0000
References: <202312151806+0800-wangjinchao@xfusion.com>
In-Reply-To: <202312151806+0800-wangjinchao@xfusion.com>
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stone.xulei@xfusion.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Dec 2023 18:06:59 +0800 you wrote:
> rm the second include <linux/slab.h>
> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
>  drivers/net/hyperv/rndis_filter.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - hv_netvsc: remove duplicated including of slab.h
    https://git.kernel.org/netdev/net-next/c/e91db1614aba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



