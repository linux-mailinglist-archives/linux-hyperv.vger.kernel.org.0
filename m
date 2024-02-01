Return-Path: <linux-hyperv+bounces-1497-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0DF845745
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 13:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E452F1F231F5
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AEB15DBC7;
	Thu,  1 Feb 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0Sy5Tki"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1415DBB4;
	Thu,  1 Feb 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790026; cv=none; b=up9bhbN4T+zX2sA0sEIoH3e1AfB55cPLzFGQUpdFYZs+6HS4x2KzhZdHuIOix1tlEvf2D7jRnIvuIGIazRq9we/rhIU10//sP6AiG+ZPEuHXiFZOHmoVsN4sDPD5j/3y1c/dt8UaEHk305Fylxc9NY/CSsW8UO9C1V1KAQFZB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790026; c=relaxed/simple;
	bh=oQNssz3rncvvDdKlqcm3FbBtO0deSJ6YT6kx87aTnfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iX3XEFnFDYmaFZSqtb5+ZRFqpSu1r4zmyd6ba1Hr2OtrVI/xMU/hbMAlkIGJqedV5yfdSYG9in4lE2FkjHtvJumAbbnjTG/ZzjLd4Zp21c5r2S2ntOQa6qSeVDix4QMLRwf0tAV/6197T2SJ5Rp1Mj5sX63UXh2OAHS9jB5OA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0Sy5Tki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E092C433C7;
	Thu,  1 Feb 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706790026;
	bh=oQNssz3rncvvDdKlqcm3FbBtO0deSJ6YT6kx87aTnfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l0Sy5Tki+sEEGnirNnX7uwshOZPJO51URpUSP7uei8rRUEpwzcPtfOSUoOMDA7NbD
	 iXNGD5EM4YJXnQXyMtPfzcSxasVeX9YUtNIQvl0vhHHi6DBz8yZ8m7VDN9g9A1M6Zw
	 Xnv5Xn6u1yO6vlV1n58MUMle+6GsJR1nFn5DvmWL4Szo9vbx2pbEeNM2TZ/+9xFHdT
	 ITZTAoYG7ycoX/uf9o+0j+pr41PgQWGK4d40kADIWg67M94KRH2ieFMfWoLoA1/g5t
	 +sKEGRBiIW0KuNnMp9qXjU4C1Y85WIn5Y1yiypSfqwtQcx+8dOPN6LeB1MmZX9hBsC
	 7kEpvtSkEBREQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3447DC99ED;
	Thu,  1 Feb 2024 12:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4 V3 net-next] net: mana: Assigning IRQ affinity on HT cores
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170679002599.3757.12151723746549913869.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 12:20:25 +0000
References: <1706509267-17754-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1706509267-17754-1-git-send-email-schakrabarti@linux.microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 yury.norov@gmail.com, leon@kernel.org, cai.huoqing@linux.dev,
 ssengar@linux.microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 schakrabarti@microsoft.com, paulros@microsoft.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 Jan 2024 22:21:03 -0800 you wrote:
> This patch set introduces a new helper function irq_setup(),
> to optimize IRQ distribution for MANA network devices.
> The patch set makes the driver working 15% faster than
> with cpumask_local_spread().
> 
> Souradeep Chakrabarti (1):
>   net: mana: Assigning IRQ affinity on HT cores
> 
> [...]

Here is the summary with links:
  - [1/4,V3,net-next] cpumask: add cpumask_weight_andnot()
    https://git.kernel.org/netdev/net-next/c/c1f5204efcbc
  - [2/4,V3,net-next] cpumask: define cleanup function for cpumasks
    https://git.kernel.org/netdev/net-next/c/dcee228078c3
  - [3/4,V3,net-next] net: mana: add a function to spread IRQs per CPUs
    https://git.kernel.org/netdev/net-next/c/91bfe210e196
  - [4/4,V3,net-next] net: mana: Assigning IRQ affinity on HT cores
    https://git.kernel.org/netdev/net-next/c/8afefc361209

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



