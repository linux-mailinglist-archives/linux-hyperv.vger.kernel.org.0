Return-Path: <linux-hyperv+bounces-539-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C6C7CB696
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 00:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CC69B20EDE
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D197339AE;
	Mon, 16 Oct 2023 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4tL1BQp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E663AC18;
	Mon, 16 Oct 2023 22:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C073C433C9;
	Mon, 16 Oct 2023 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697495424;
	bh=zyaih1aLU0Z/zC+xrxo25u6WFywDrPfg8S4GMbOxMCg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E4tL1BQpltynZXWCi+j244SzczT4/v4E8/PCraoReQlSdeqw35vL0bQ4A/5fughJD
	 GwOHt0odil7cQZskFcAFuWABO1mFYPTSJBrnEtz5HKsMMAzlgud9foJHR7WkzoIYEg
	 ifHWwfAel3qmMljsN3TAxWPSSqxfZu+J8pr10GWXvHWapHeE3FlAXHAs4EgxWQHtiv
	 OCYaQtfod45livXvxvjR+TmmoDaiFUZQoDR5AkMT7JvcM7vzFK934Xfw//+cXmxZ+P
	 Igmy0q/AysAYv8KOSh6xbY+aQlI/FzseWHpwdzf6l50qfg2o7ea669OZ3T8k2taoHq
	 ERcj4cGE4LjMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CFEBC43170;
	Mon, 16 Oct 2023 22:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v3] tcp: Set pingpong threshold via sysctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169749542418.25064.17965944702112966328.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 22:30:24 +0000
References: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 corbet@lwn.net, dsahern@kernel.org, ncardwell@google.com, ycheng@google.com,
 kuniyu@amazon.com, morleyd@google.com, mfreemon@cloudflare.com,
 mubashirq@google.com, linux-doc@vger.kernel.org, weiwan@google.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 13:30:44 -0700 you wrote:
> TCP pingpong threshold is 1 by default. But some applications, like SQL DB
> may prefer a higher pingpong threshold to activate delayed acks in quick
> ack mode for better performance.
> 
> The pingpong threshold and related code were changed to 3 in the year
> 2019 in:
>   commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
> And reverted to 1 in the year 2022 in:
>   commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tcp: Set pingpong threshold via sysctl
    https://git.kernel.org/netdev/net-next/c/562b1fdf061b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



