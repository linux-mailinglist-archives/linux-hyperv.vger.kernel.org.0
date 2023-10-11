Return-Path: <linux-hyperv+bounces-516-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CE07C4CF2
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5462F28201B
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C6419BDD;
	Wed, 11 Oct 2023 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1yMgPqW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E5199D6;
	Wed, 11 Oct 2023 08:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58AEBC433C7;
	Wed, 11 Oct 2023 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697012425;
	bh=xhjx77AOww0zaMqOJztfw0YnYbpmxbJJ3eRelw351Rk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g1yMgPqW29fE2pSOFlR91UkuVCsWgkoGyj87OwRCsaQvnqoaNclWRVWK3ykG1qN5v
	 4Y6e9EMIGQHBOk2eyANbGbUrbdtkC1AZSANTpyE9NLPCQ8XhzOQD8yHfmmO0XEWYE6
	 AXnq2HoEqwkRTmOJnmOycztNQ62lsvTIVSfGmRTIRV1bgZO0Dt/6HwcTN0efToSTrM
	 3/5ElagCHsaSuL1XJlz2+54M0r/9NXsExPaiDloPKTTIsJ6zDL3NXdcczi1QR5N68P
	 XY1y85vOzK54ZP/9wAbfCYtupyOeTUXngzyI0nEIoxDar0egeVA2vfDnBeKEiW7qvr
	 TNBkrJN3T+nbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40DC0C595C4;
	Wed, 11 Oct 2023 08:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] hv_netvsc: fix netvsc_send_completion to avoid
 multiple message length checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169701242526.2065.3732761512312039309.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 08:20:25 +0000
References: <1696838416-8925-1-git-send-email-sosha@linux.microsoft.com>
In-Reply-To: <1696838416-8925-1-git-send-email-sosha@linux.microsoft.com>
To: Sonia Sharma <sosha@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
 mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 01:00:16 -0700 you wrote:
> From: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> The switch statement in netvsc_send_completion() is incorrectly validating
> the length of incoming network packets by falling through to the next case.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> The current code has not caused any known failures. But nonetheless, the
> code should be corrected as a different ordering of the switch cases might
> cause a length check to fail when it should not.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] hv_netvsc: fix netvsc_send_completion to avoid multiple message length checks
    https://git.kernel.org/netdev/net-next/c/9bae5b055022

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



