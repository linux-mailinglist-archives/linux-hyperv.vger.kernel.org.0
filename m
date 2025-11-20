Return-Path: <linux-hyperv+bounces-7710-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E02F4C7231F
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 05:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE376344905
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 04:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CAC26ED45;
	Thu, 20 Nov 2025 04:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw38CNHB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331C23BF9C;
	Thu, 20 Nov 2025 04:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763613045; cv=none; b=m33/8Id6SFMRpIjPLxzD20j3CANE8gV6wjlb5AYOmPwN1So6GMoT0NaiJLpKrFMQNpQSyB08WAdrQsvzMIzLHjh2kEqueETQz0onVOXqh+UPAO5d4MmKVWSL0xEP99BIjpMThEFl7j3SYDeIsUEH55d737PkEdgrsR2b8RdMVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763613045; c=relaxed/simple;
	bh=XDBowCbVb6T1WoqzF+S0IyPnF3QQ1o/ZS55y3qujj7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nhAO6b5IXENdoSJaekBIF4YnH/pyeBeiLAOJV7zcQ+MGsC8htGGaHTBNLHXOggL/hv1bJkPtTg+kaVSFOpDhm2WRmmD+RfiQ+0CTOpD2k6z3XTjEnM2Okcqxd7g9mpY5+2RzR0Ra6TCxMj5xfStcyRE1kiAr/7wXzNFCFsU4C9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw38CNHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE24C4CEF1;
	Thu, 20 Nov 2025 04:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763613044;
	bh=XDBowCbVb6T1WoqzF+S0IyPnF3QQ1o/ZS55y3qujj7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kw38CNHBKMBgMjOj/zQI3NGqSusDzDEAbchk5HWvEfJH3IkIGAQvNRNfMqMq56eEq
	 Y8VBQnIcq2/q7DhuQfKM3nXgzMphhxYdalGESMgSH610vJOqmSlcNeSvj1rIXD0IVk
	 jrGUOKHMpUlUoxLCfCQSEmmUJKYyrO6uLBG9WolGlk7YiLXCG+H+jMuCdWDJKHLL71
	 WX0OYM0gNAn0TzMhUoiXBNNeVrzKY0BnP1KNZtYo4rMgmkmbDOLBmG4FI08IoSoIQH
	 Fg8+ON+LoQyyMSmAk2K8Vwap5xUdn7dAPQYJryFkic2TBZHoc364OlVZYgulgwe+xt
	 a+Zbr1ZrymfWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3C39EF974;
	Thu, 20 Nov 2025 04:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net: mana: Enforce TX SGE limit and fix
 error
 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176361301025.1077848.8735410574086807354.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 04:30:10 +0000
References: <1763464269-10431-1-git-send-email-gargaditya@linux.microsoft.com>
In-Reply-To: 
 <1763464269-10431-1-git-send-email-gargaditya@linux.microsoft.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, leon@kernel.org, mlevitsk@redhat.com,
 yury.norov@gmail.com, sbhatta@marvell.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gargaditya@microsoft.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Nov 2025 03:11:07 -0800 you wrote:
> Add pre-transmission checks to block SKBs that exceed the hardware's SGE
> limit. Force software segmentation for GSO traffic and linearize non-GSO
> packets as needed.
> 
> Update TX error handling to drop failed SKBs and unmap resources
> immediately.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net: mana: Handle SKB if TX SGEs exceed hardware limit
    https://git.kernel.org/netdev/net-next/c/934fa943b537
  - [net-next,v6,2/2] net: mana: Drop TX skb on post_work_request failure and unmap resources
    https://git.kernel.org/netdev/net-next/c/45120304e841

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



