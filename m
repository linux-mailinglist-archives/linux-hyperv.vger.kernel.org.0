Return-Path: <linux-hyperv+bounces-6023-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8F8AEABB0
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Jun 2025 02:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0221F1C4266E
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Jun 2025 00:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5953597B;
	Fri, 27 Jun 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUgrR31X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06109460;
	Fri, 27 Jun 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750983592; cv=none; b=NZEo0Y6Jt7Vjqg/LfrAYZvHrh+5UNifNn9myIIkrQ0kGvyY+UagxdkVTJaq1ke8DNxl1B2qpp0AT/QEWASEeI6UYHpP5ZlEqAzVxfxHauIY5o/hkJpnvWjOX7JXGNekfv6+ObZCyV8gX2rlhgjFj/uHd4dAVWAryCeUR4gbTEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750983592; c=relaxed/simple;
	bh=RrmsbVmyogoXW9Ko+aax+pPbyYQ0NRNNiGyXTQbNfws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cxJlUQazjLcjFNwWP//soOFmhp/QB3DaKeMb3YwA9DPt/OPYYRlBpNP45jcvAqWcG8xUW3LZLUiRfhBh5llcrDZFOsV6fkONTt4pzUkKIqR7S/JHLSUnBesl2Vwm9XwVThH33l1MVQ8NdYekRpoVR4uuf68iVFO0MXjXKNjvoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUgrR31X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFAEC4CEEB;
	Fri, 27 Jun 2025 00:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750983592;
	bh=RrmsbVmyogoXW9Ko+aax+pPbyYQ0NRNNiGyXTQbNfws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gUgrR31XVX2D9PNxb2xoqJcgtfunntbCmCWaCWUo90b2DiSHb6+7Zz1RoY43IH/Ga
	 6MlqTnRN8a4gYNVJOuDGUkt4tPFgjSe3nB1ReWEu3nyNagbRTAZa9AIKrxFMIaLzuZ
	 IvXYj8Aebh6sX0py5t0sb1pzgRVTy/RK5nGZ2K3ye6DTjqH1WPjYdUO/w2xxwPeH9H
	 SGHI7TCaAJmKl5g84b1mjfzB/PM7A94x6k4a9GoluF8ETPjFwXL+V/EwNKnctyVDEO
	 BX5LNBShG1naOeSlLGUzIiKTg3VlNtr3P7Cv8j6sMvs8YIjWVOuhztfQNOL6dldaqb
	 REuTIxh9XOnXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1AF3A40FCB;
	Fri, 27 Jun 2025 00:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: Fix build errors when
 CONFIG_NET_SHAPER is disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175098361824.1380299.7391305111038301717.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 00:20:18 +0000
References: <1750851355-8067-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1750851355-8067-1-git-send-email-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 04:35:55 -0700 you wrote:
> Fix build errors when CONFIG_NET_SHAPER is disabled, including:
> 
> drivers/net/ethernet/microsoft/mana/mana_en.c:804:10: error:
> 'const struct net_device_ops' has no member named 'net_shaper_ops'
> 
>      804 |         .net_shaper_ops         = &mana_shaper_ops,
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Fix build errors when CONFIG_NET_SHAPER is disabled
    https://git.kernel.org/netdev/net-next/c/11cd02069872

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



