Return-Path: <linux-hyperv+bounces-3967-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F572A3BAD2
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Feb 2025 10:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1570F188CA39
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Feb 2025 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7081D5CEA;
	Wed, 19 Feb 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSYCHDPA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9B1CD215;
	Wed, 19 Feb 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958600; cv=none; b=KlYet1a0+GKorH9IMSBtOMp2x8RKn9h06dQzTHEg5MkuGc/VS5L1T7GhfkVG3fchiLVJF0qEQLa/H7r8DmQWOO+XJht5fGb35NvA4poDGUCyjCcHxr6FrW5DTbTirTTj1gJNRdzx3i8+Zk+OzErZKqg/9DnGrCDTJK0ZRMNV8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958600; c=relaxed/simple;
	bh=gGKRQVXQErbi8eRaHJ2DfyuebdYQXMVvxp5XwekQrqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PGfZYIsR25e64j0lQgCmdC1ScuuRjxmoKA/PDbX/n19cp3J9Fw55rUFbWOvbjCQoIqzHLCCUZC1JWyIQPVaku1sGUF6bUQZCFGl7z3Oo3HJI9Xv/ZlIrRi9UYlg4LYPaj8BYvTRRw+CEN6xZPKLDm+86vjeusQHJzDhnMCfeTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSYCHDPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847F8C4CEE7;
	Wed, 19 Feb 2025 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739958600;
	bh=gGKRQVXQErbi8eRaHJ2DfyuebdYQXMVvxp5XwekQrqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hSYCHDPAETBpj9sPX1Y09vTfClkSm0DPiqvwLdeMZ5gSatNhMQvFxHnQmhodCE240
	 nhYzlB66Qhby3oFM0nmJFKDwu27Dt4otZms536TrIWcsEmtApCvLsS7+DqaddFcO5Q
	 SisMBy4H08XB7/f+Pp/9C+h2Q91b2ilvsx+T4FzZ3nhxz2ie6yNFY/LC93vNPRyBPv
	 Aae5jh2TgO9/0hUa6QBB+mOUi8+kYn2RTy+dr349Ct6aa8k8TraP7R5BxzAYqahNU0
	 tOFueu/c6QxK9eoWbbBLfx8u7W196oF2eWW7PIwsSnsZTccgAsuup1kr2SPo6sh99l
	 q4sGTWxTkUrOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6F380AAE9;
	Wed, 19 Feb 2025 09:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/2] Enable Big TCP for MANA devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173995863100.531989.91959446814814394.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 09:50:31 +0000
References: <1739763715-28412-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1739763715-28412-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com,
 schakrabarti@linux.microsoft.com, erick.archer@outlook.com,
 shradhagupta@microsoft.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 16 Feb 2025 19:41:55 -0800 you wrote:
> Allow the max gso/gro aggregated pkt size to go up to GSO_MAX_SIZE for
> MANA NIC. On Azure, this not possible without allowing the same for
> netvsc NIC (as the NICs are bonded together).
> Therefore, we use netif_set_tso_max_size() to set max aggregated pkt
> size
> to VF's tso_max_size for netvsc too, when the data path is switched over
> to the VF
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/2] net: mana: Allow tso_max_size to go up-to GSO_MAX_SIZE
    https://git.kernel.org/netdev/net-next/c/27315836f4bc
  - [v3,net-next,2/2] hv_netvsc: Use VF's tso_max_size value when data path is VF
    https://git.kernel.org/netdev/net-next/c/685920920e3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



