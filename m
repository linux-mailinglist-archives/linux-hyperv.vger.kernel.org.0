Return-Path: <linux-hyperv+bounces-6184-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764EDB010B2
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 03:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9CF7BB620
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 01:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0497472615;
	Fri, 11 Jul 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbGF+BdM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD46F073;
	Fri, 11 Jul 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196808; cv=none; b=r/XQA2joJVk2mLf80AQ4Fxo25Af6C/IfSkD89cd8AlW+QtRr+OH+s1esWrYO5x/QqeS0NgpiookPGJv5KdY9lCH6pJvCQuAE/2+7dfWF9+7GvGbsjvwYZ6iYfV0H8zPdqutHccZZBV74JdfWJNSLgmQXamuEtDVpyn5o3B96D1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196808; c=relaxed/simple;
	bh=94bn2cqdTiiH6ij++VmZPGlsCxQv1kcJRXQGirS11RU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WTnSdozcd1/9jNzZm+v+ZYuIpvXFg7AkxBP4kMk1eCDGMUMGs46WeV0dxzziIHsqO+q6TDgfA6EFQpBxKGCOAQCo18ReveEoW9GFheyxPMzHTmbjdd1BGKVNXpj1d7tZ7+r+AavEuZu54Or8nKWYo4s2X2p+U2AF0+KUz+U7NSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbGF+BdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C63C4CEE3;
	Fri, 11 Jul 2025 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752196808;
	bh=94bn2cqdTiiH6ij++VmZPGlsCxQv1kcJRXQGirS11RU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lbGF+BdMmeotRQs1dho6JGKSKUKrv+mosu1VKdazb5Z9Dj/L99Vpk4ztp29W7/BEE
	 Y/qw637ulphoKVWbj0C02QIRq/uj/xahp5eJkRzO3VlBX26qi5VC7aEJy6InNTTWsv
	 ffnkUpReo57hJgSmmDzNtYWitSUmi1Np9zsdJoUzgSBQfP4y4FfK8mLby3DEgLvxEG
	 g+f/2/KNcm47Diq+JdwpQ5+NFfq8OqNseaJB5jcN6Y96ucYoNKkdPZrCRyj0q+1RaY
	 j9GktFP3p8cLgnDAZGTES/SRfvHDvSCxcqM1wi9u63QY5ULUq+b9y5Ew9g/9EmlG+J
	 K+mPi2Qbl3Exg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD39383B266;
	Fri, 11 Jul 2025 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mana: fix spelling for mana_gd_deregiser_irq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219683049.1724831.3012463176153196869.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:20:30 +0000
References: 
 <1752068580-27215-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: 
 <1752068580-27215-1-git-send-email-shradhagupta@linux.microsoft.com>
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Jul 2025 06:43:00 -0700 you wrote:
> Fix the typo in function name mana_gd_deregiser_irq()
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - net: mana: fix spelling for mana_gd_deregiser_irq()
    https://git.kernel.org/netdev/net-next/c/380a8891fdcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



