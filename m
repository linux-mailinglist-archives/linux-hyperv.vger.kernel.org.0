Return-Path: <linux-hyperv+bounces-6862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76579B56B6F
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Sep 2025 21:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93406189904F
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Sep 2025 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2212DF125;
	Sun, 14 Sep 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf5Kjbqn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774FB2DECB7;
	Sun, 14 Sep 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876417; cv=none; b=jq1ulH7ivrLp7+IMiu1Us8pDe+DaFyeCMbWhnXDq2U99Pu/g+j7Gyyhm52Mg9t7jkVo8FZFKUG8eiQ/3SK3xu7vIDeW3EjhVXMAIK4RsgKoyD+gBCYsDn0UUt1BtUuTWo7EF+ORl4nfubaOQiJmS066292fabHzAlKlZWyLB+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876417; c=relaxed/simple;
	bh=FyF93LpmLxOF9lXH95/wzI5wWyR0u+UOFAJa12hmQhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FEGj4Wks/1HUlUZJd3oZ/Noj+N52LVX7fdTIwNZ6XViUnuS+u5+k/ibOgGc0UShZ4tNvsvalORlgnVrEsRqeb71LOxRbSlAg1J39OD9T3txuFC+hFzI5iYVhNJRpT4/W+/qui28TCkEbGdxn/H7Td7xhBpx/akB4lijSiOyrLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf5Kjbqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C8EC4CEFC;
	Sun, 14 Sep 2025 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757876417;
	bh=FyF93LpmLxOF9lXH95/wzI5wWyR0u+UOFAJa12hmQhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pf5KjbqnWbLlP28YltZXv3tY2PXYGTN1AFUV0GVv6/CosQ4OTBdUHWvyM7RXw80Bv
	 p07gUwPwC8gN13XTqBLEHllQZ6g66dtxSL5lrMVjZ8lAh5yfVNNHQfVWsh5B5/vwu4
	 SKwMQvDKYelSnnGmPk+6K03E+BWzynKoeMiaQjhJGm99ieckiF655ijgvbvXAEJbN3
	 fpAXJTt9q0K4HqPQV24HwyjdZe192tct6ea0QwQvw4a1fl4rxSM1b7Ou2zXEnJAvhO
	 oGILmzmY4ZzUCEAoMlLnIFvWat1MGb8IySkskT0fMA+Sye8zuPjeou9v8fxzlT1EEJ
	 yMkkWCCazdf5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC039B167D;
	Sun, 14 Sep 2025 19:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mana: Reduce waiting time if HWC not
 responding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175787641849.3528285.16103963300533493791.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 19:00:18 +0000
References: <1757537841-5063-1-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1757537841-5063-1-git-send-email-haiyangz@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, decui@microsoft.com, kys@microsoft.com,
 wei.liu@kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, kotaranov@microsoft.com,
 shirazsaleem@microsoft.com, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 13:57:21 -0700 you wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> If HW Channel (HWC) is not responding, reduce the waiting time, so further
> steps will fail quickly.
> This will prevent getting stuck for a long time (30 minutes or more), for
> example, during unloading while HWC is not responding.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mana: Reduce waiting time if HWC not responding
    https://git.kernel.org/netdev/net-next/c/c4deabbc1abe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



