Return-Path: <linux-hyperv+bounces-6822-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3CB52587
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 03:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DF9464C5B
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 01:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08A5200BA1;
	Thu, 11 Sep 2025 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCeuypGW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832681F4C96;
	Thu, 11 Sep 2025 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757553008; cv=none; b=cM5UTS83BjGaL5vgMZHkQ8JOOwNCshGB+ecQ6hmDq6AE3XyGGQU8YjsfE7e80AstL3zmxP9F1yUKPrC7o+2GPOwHCNuUn49cmZmIErPUIXXAffsmaLYfzKuSEKgrtrKk4r+HPaZZh+u0gqmG0YJ204H5zqcfnM9WPDsiTim7ktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757553008; c=relaxed/simple;
	bh=V4nGwzar9W2uZ4Zi61zmtfPYn7W6HDmHIiOf7NBU/MI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tdxa8rnwnCmmt8+sgNgyNmDfIEVxKf4tMSStksqGOz+AtIYQ5EzF+wi4jwT/ksXQ8PJ6JDeqE24Q4unEeCikuGOUnSdBii3XcjzHasR0a7f7JifwUPfg5KBvNaW03M7rWhxpI9ZQjt9PYa9p+iFDsErfNrgucB61ZIkXQWRzJb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCeuypGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F04C4CEEB;
	Thu, 11 Sep 2025 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757553008;
	bh=V4nGwzar9W2uZ4Zi61zmtfPYn7W6HDmHIiOf7NBU/MI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XCeuypGWY2z0Rcm5Xv4YtQotlGZEa8DpGYTLqAbnVU1gSBUMeZlKUV8o8SW51SJLI
	 bGVE2MTnh0YDB5qDUqTL9FPsEOfwN+IswKge+1Chd+NN3OxNdCbM+oL2pck84GXhQ9
	 RAR2Aa54+uMEhjm55enSMC89Lz+7tAXuq595PUgxbpFkPP1T7+ChCT3FsBWuBkVmoh
	 ckDZwAxbuBklSt1aN3CoiCcBqpLugRDEd2qgHkfjdRkxVPf0Sk5uV0298oAJuuK6KG
	 NjnAxcrlEXEtNTdkueOf4dhw74eyLLDWoV5bXa9oy9BFqzq2whL9q/NDcBfkDOMnTC
	 Zrsh1a9iSlpig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D8C383BF69;
	Thu, 11 Sep 2025 01:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: mana: Remove redundant netdev_lock_ops_to_full()
 calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175755301100.1617124.990028016646889423.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 01:10:11 +0000
References: <1757393830-20837-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1757393830-20837-1-git-send-email-ssengar@linux.microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shradhagupta@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ssengar@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Sep 2025 21:57:10 -0700 you wrote:
> NET_SHAPER is always selected for MANA driver. When NET_SHAPER is enabled,
> netdev_lock_ops_to_full() reduces effectively to only an assert for lock,
> which is always held in the path when NET_SHAPER is enabled.
> 
> Remove the redundant netdev_lock_ops_to_full() call.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> [...]

Here is the summary with links:
  - [v3] net: mana: Remove redundant netdev_lock_ops_to_full() calls
    https://git.kernel.org/netdev/net-next/c/38611e5adae3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



