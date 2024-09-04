Return-Path: <linux-hyperv+bounces-2945-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE6E96CAE4
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 01:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230A31F2679F
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 23:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0993518893C;
	Wed,  4 Sep 2024 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgmRDTcG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EB17ADFF;
	Wed,  4 Sep 2024 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493239; cv=none; b=a+38UIJrctzJDjUhjmfO6UbW2bbJZc4zgFC2d9zQ3GBjMTfIW10s3h90x3fpyRXcgtFBdtYIofxIiCQh93q8r7mTRv6mUeTRGVovDV2GLCY+htmvHChJrpy6aC1t5fiBLzYldelHtfG+KaIvgsRFihIwskM3RiUAbi1CvxNIMVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493239; c=relaxed/simple;
	bh=mKjD8xk0OPeXnIPaePzDkxOuIVCyQqxsKu1AG2UDAkM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UjU36RmQyN/IX4nSEOH6mM/Elfb1cYFZVi3nfUtmXq28bOystxAIwAafr7uVcLYFD9QXUafiXcR4g2KX8ZDGxqmCFy4j66XiXw2skdwt7E4cO7EgPf4Xtv0tSatHWqbxn0JYFW8K1luwO4eGbMtLNSzR8vzle4DlA5UoSDOqq2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgmRDTcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D324C4CEC9;
	Wed,  4 Sep 2024 23:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493238;
	bh=mKjD8xk0OPeXnIPaePzDkxOuIVCyQqxsKu1AG2UDAkM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NgmRDTcGKp3Cz5PjQLlYScpPJBdeXZdsJTp3DDep9k3I/ptIzruj80g17njHG8tm9
	 mEr34zrxcIJuv4ZjpJqFOOSWJ3gh5nk6s5WwMul1xA7r6A9C3SD6gZoFdaTubnMJ+7
	 rt88jkFTMbHJx91NYe2qh+SxlDjqpIgc0xZjAfGvoivqXatHvyj21BzJS3Kydjn48B
	 RKb2rytk+pJ95d6neXfn2IJ5HUvOpeILd8sR6TAfcUCwBRIkGX+ixNftEaXg92A451
	 YnYgjDML4LMYwvzYhuXjVkiAt4/fRBOPf621WG7ie4tTl8xaNtid35rT6hih6tvUE6
	 KKKPW6Kxn+nBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715A93822D30;
	Wed,  4 Sep 2024 23:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: Improve mana_set_channels() in low mem
 conditions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549323899.1198891.6547340343364681759.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 23:40:38 +0000
References: <1725248734-21760-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1725248734-21760-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, horms@kernel.org, kotaranov@microsoft.com,
 schakrabarti@linux.microsoft.com, erick.archer@outlook.com,
 pavan.chebbi@broadcom.com, ahmed.zaki@intel.com, colin.i.king@gmail.com,
 shradhagupta@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Sep 2024 20:45:34 -0700 you wrote:
> The mana_set_channels() function requires detaching the mana
> driver and reattaching it with changed channel values.
> During this operation if the system is low on memory, the reattach
> might fail, causing the network device being down.
> To avoid this we pre-allocate buffers at the beginning of set operation,
> to prevent complete network loss
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Improve mana_set_channels() in low mem conditions
    https://git.kernel.org/netdev/net-next/c/1705341485ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



