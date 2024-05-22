Return-Path: <linux-hyperv+bounces-2206-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD0F8CBDA5
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 May 2024 11:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30682282EF6
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 May 2024 09:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143E0811E9;
	Wed, 22 May 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zcgnz/v3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394D2D047;
	Wed, 22 May 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369630; cv=none; b=bWbTqgePgWjPU2+Q+WfbvK+5pfx0PzicVgbp0Oal7KQY18C5OZYOiU4EtiXWZL8oa8q3snVboWfXYzykdLXLJxqea5NN3HClVNN7PI4XYjcGOUe13Z/PlfWq4mE1La/eh0g9q1xjg6tl34t+ACuwuByfOGYCJfxZjRmO8G9edhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369630; c=relaxed/simple;
	bh=xZs+ye5qwNKov0tLlq5iXfmZRCL5RvXS0tDyXCyIVYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cfCTcE5+9u4PL5D40b/j+rR7f72PVd6hap/ddTMOYecjIFj7PwVMkqSoESlu27Jl9Y1OUfjXipyAqhQnVss7aHzfeNcJ/eaK5trC5Dc6GDysQUlFv4y7eBHMbwZ7T7KFK11qKQFrSWxRjRRM52lcgYTRwGmFEbC4F1DES1Kschg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zcgnz/v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D76BC32781;
	Wed, 22 May 2024 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716369629;
	bh=xZs+ye5qwNKov0tLlq5iXfmZRCL5RvXS0tDyXCyIVYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zcgnz/v3xLpANv3pLHA5JZSj6Eml9zBnDwCrG33JwY/tXdM/srH4fSUHG00m+4X2/
	 nAmBkCaFldyF1DyeMCQbMQLGxvqRrljwPSUYfozmADSwLbmQKEde/JNY2yNjUVVUax
	 T2zddxxoaTWKVQFK2M8Sq1LSMQw80ZOK5zv/O0rgNnaHTQ4i0WPRPmeTV9EpeQhf3S
	 d6xrQMdkc5LCflI4Trt6hiI30OvFcbz9MPlFh8PPxZlLcW8JuLokNWqZbvYQeSbLrs
	 R+MQh4qtkunJaEEAnb+eCkPiS4Y1BA0NvBrelwySPp3kBd7WNHNmDugHiquTbNF52Q
	 IcElKkdn8QWdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C09CC4361B;
	Wed, 22 May 2024 09:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net] net: mana: Fix the extra HZ in mana_hwc_send_request
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171636962924.3713.1861130025429857473.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 09:20:29 +0000
References: <1716185104-31658-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1716185104-31658-1-git-send-email-schakrabarti@linux.microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 yury.norov@gmail.com, leon@kernel.org, cai.huoqing@linux.dev,
 ssengar@linux.microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 schakrabarti@microsoft.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 19 May 2024 23:05:04 -0700 you wrote:
> Commit 62c1bff593b7 added an extra HZ along with msecs_to_jiffies.
> This patch fixes that.
> 
> Cc: stable@vger.kernel.org
> Fixes: 62c1bff593b7 ("net: mana: Configure hwc timeout from hardware")
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [V2,net] net: mana: Fix the extra HZ in mana_hwc_send_request
    https://git.kernel.org/netdev/net/c/9c91c7fadb17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



