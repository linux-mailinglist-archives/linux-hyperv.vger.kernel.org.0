Return-Path: <linux-hyperv+bounces-7813-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA5FC83466
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Nov 2025 04:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB9D3AF013
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Nov 2025 03:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C7D27E040;
	Tue, 25 Nov 2025 03:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHhGiWcr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0713AD26;
	Tue, 25 Nov 2025 03:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042648; cv=none; b=bQArPyE1WB+1V8OOdFDPbHomW6mJ+OzUOiHigfKRQ1FYHl3REQPTM0xl6sE+Ejvdlf3Bfz1IevuAQOtgCAljS6BFIXe4+S+b8PREWKkLpjQB4NrAuLiMudDV1xItVS02RDVmxpdSPCYgAfomRgQvuSPyw0Kabfj+bgKyqvUbcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042648; c=relaxed/simple;
	bh=0vSUSA4Kw/GOWyoRRw9M+TcsjUMOzP+C/ziry3I9ONo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sUakpRR+LPtVpB2+yZqCz5c4xj7TpCJ/rweOIR5WTrzxHV1l97Vx/YlH1vCzzQevnjYS0jzOwC1EEaEdm+WElhYdYqAFnyN5z16485ghpPwfQv2givxXfASwzIvvQLOdZi9S/tR57wwejT1ZOGfbPp2eT+wC+XKjk+axz8JqRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHhGiWcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF896C4CEF1;
	Tue, 25 Nov 2025 03:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764042646;
	bh=0vSUSA4Kw/GOWyoRRw9M+TcsjUMOzP+C/ziry3I9ONo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jHhGiWcr6e3IdBkKdjoHNd8OCTR4BhBF36b/cFzC734NuHkgP0ICsN4x+TolxhyNQ
	 ZGWnTGdaLmoubHLtndgeY3VUvsagJ/QXamrPFSo3FnCMWVdzwDFC29aBXooJ7qwwvf
	 Gl9sdWLuv1rMYa3CvMujjdP/6v655BdR2Z/70iwm3iK2BlXqRr4MfFaWqBy/lm/6Xo
	 bLH0ELfxBqJYJz1AnFUmCUCjIUPmqVv2+oR6ejAo9imdnJ5v1/rkRSUe+AnWGR5XJA
	 ArCSd3U6g2YxVIOOW0hONAg5AU14G4/rfXC1/sPfWETF+kq4tGGOidYdCagFnOHNnk
	 G1bAMSL3LCxuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF933A8A3CC;
	Tue, 25 Nov 2025 03:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hyperv: convert to use .get_rx_ring_count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176404260951.179191.7435909096238406022.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 03:50:09 +0000
References: <20251121-hyperv_gxrings-v1-1-31293104953b@debian.org>
In-Reply-To: <20251121-hyperv_gxrings-v1-1-31293104953b@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 01:59:23 -0800 you wrote:
> Convert the hyperv netvsc driver to use the new .get_rx_ring_count
> ethtool operation instead of implementing .get_rxnfc solely for handling
> ETHTOOL_GRXRINGS command. This simplifies the code by replacing the
> switch statement with a direct return of the queue count.
> 
> The new callback provides the same functionality in a more direct way,
> following the ongoing ethtool API modernization.
> 
> [...]

Here is the summary with links:
  - [net-next] net: hyperv: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/a8ff4842da50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



