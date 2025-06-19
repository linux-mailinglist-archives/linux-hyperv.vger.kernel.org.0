Return-Path: <linux-hyperv+bounces-5966-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA024AE0FD6
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 00:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B72189469E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 23:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED75A28C2B2;
	Thu, 19 Jun 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnGFEyFk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE907229B23;
	Thu, 19 Jun 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373979; cv=none; b=bJI86tn61++PZ9mm6GHjt0l3ld6FxWlkpA4ui1cWoObRJVk9UKm0KUYj3JQZowcT3W8UsCN0Mka3Au/GcDDbOrgkaqA8c1hsfoBWKstvOyROb1AJ9o70Y+0kHJQ8E9kr1jOXYNWwbzPpc6BamrR1r43yH1I16tQBuRIgQJGxL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373979; c=relaxed/simple;
	bh=oFs8W69mkMcE3jsONVpj/UL2MWIy+951BHWY6ac5wh4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FcfPaK+pbWH3OgjDNENr+rIxHfgysqL1WC85WJM5d1bRHEFfTqBznOndcuzjqNEAHGN73GUJwAImIla/WvgdifIVn3+DzUbvmMmhOCd9jd1ViMlWXURglairoIuaAp2xR2MQ8csRyj4zF9TceQdkF/DRrNHrgKgNOm912X/q0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnGFEyFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3797CC4CEEA;
	Thu, 19 Jun 2025 22:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750373978;
	bh=oFs8W69mkMcE3jsONVpj/UL2MWIy+951BHWY6ac5wh4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KnGFEyFk5qE287+Q7JLkttMqxxMV5xHRLgw8Da5HR9fVRUwfWaA5h3tOVlTPmXvhS
	 bTSulvvdfYnOde/FSX3vip85LWVjZxmBdUnmg7s3l3MnVbDm13yf2fU7mJ7CO6lUZT
	 toKW1Tw2Wj/Xbfmt5r4Z5iGKFPwPl1Qs4wufpH4csW8iTx7TzGHXZooNgcGHuU1wmM
	 Wxr7sqnASeIHg+6/Zz+baryFiBLNkzoA4tK1t8fdajRM3FqJwPpKUGpn1XpPJVBvLU
	 UmYAIxnhSXhPDc7kQaYOmGCakl2nq2A4UgBrXhUzA2sIXxSnUAk928JlvLmCcEVx9v
	 w0BMzjbfZukVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2E38111DD;
	Thu, 19 Jun 2025 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mana: Set tx_packets to post gso processing
 packet count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037400625.1013059.17103601464401559949.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 23:00:06 +0000
References: 
 <1750160021-24589-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: 
 <1750160021-24589-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: decui@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
 kys@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kotaranov@microsoft.com, schakrabarti@linux.microsoft.com,
 ernis@linux.microsoft.com, longli@microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulros@microsoft.com,
 shradhagupta@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 17 Jun 2025 04:33:41 -0700 you wrote:
> Allow tx_packets and tx_bytes counter in the driver to represent
> the packets transmitted post GSO processing.
> 
> Currently they are populated as bigger pre-GSO packets and bytes
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: mana: Set tx_packets to post gso processing packet count
    https://git.kernel.org/netdev/net-next/c/7399ef984022

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



