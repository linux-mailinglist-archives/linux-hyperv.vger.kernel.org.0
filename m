Return-Path: <linux-hyperv+bounces-2939-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB596B986
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 13:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74D01C21E57
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6AC1CC171;
	Wed,  4 Sep 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkpuDtZf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE62148314;
	Wed,  4 Sep 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447628; cv=none; b=ja1B1knO8d6QMU2CxFAMZoZ5sNbPrJ1T+ddKTRQws7j7FgBlSNiFoHvE8yrPk7/6jHdGVZ0C7LrnCO1/wnJhxiW4RZQO6GugjBlNMr8ylpq7tUReuzwfgq+nmAkAwmc7HTE6quWUomrJkav37WzBhWUMgUR1r//So0LgifNbZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447628; c=relaxed/simple;
	bh=dWIWAa4AHuQnBM6xR0K9/gqAZobICygIJEwT+Qz/vYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lgTLl+WjdRwKkwsGUNi2nnpAp4mgKyDYNxPjBVARkwkjhppOSIiMnsdniwUFHc/hGKWIIyYPUtCvv3oXesQ4NWy/yrY6c9CtjchJgLmkeB4fbtQ5OepN3sHVaoVJ9QYd1IPTzbo7SzsjfOi/YZr2VZp5PbwMjxFwz+zgRPOPaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkpuDtZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF2DC4CEC2;
	Wed,  4 Sep 2024 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447628;
	bh=dWIWAa4AHuQnBM6xR0K9/gqAZobICygIJEwT+Qz/vYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UkpuDtZfkWSuqYsDI1LcQEhppzekBXIQwdWoaSQ3NDYepE+G/lNHjTPlV/CzVE8AD
	 Gq1auhT+9ZH4pZ0FSLhwG2izdpPMvKhpHLvOsH2KPNrG9mxvwq7phyIgQaXo+8aqeQ
	 IpDTnr22oEiaDQZ5zjBTo4df93JwevBnsT8xSh3zTYkaPwM/MuU27ngvsZfa/8EEGc
	 APzQ7gh0NjA9mLweSY9tMMYbU5ZHKqweJ7biZwdnunsIY5XzTORue5ghUx/zPAuZ1E
	 gdcR29Kxabthj8kv4x0Pz40Gf0soXpKKUQXFZOey0u69O/gms6Hxb+XtTLud2ziPuD
	 ARjm1ZXBS6njA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB13C3806651;
	Wed,  4 Sep 2024 11:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V4 net] net: mana: Fix error handling in mana_create_txq/rxq's
 NAPI cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172544762877.964331.4773742631498321794.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 11:00:28 +0000
References: <1725281027-29331-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1725281027-29331-1-git-send-email-schakrabarti@linux.microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  2 Sep 2024 05:43:47 -0700 you wrote:
> Currently napi_disable() gets called during rxq and txq cleanup,
> even before napi is enabled and hrtimer is initialized. It causes
> kernel panic.
> 
> ? page_fault_oops+0x136/0x2b0
>   ? page_counter_cancel+0x2e/0x80
>   ? do_user_addr_fault+0x2f2/0x640
>   ? refill_obj_stock+0xc4/0x110
>   ? exc_page_fault+0x71/0x160
>   ? asm_exc_page_fault+0x27/0x30
>   ? __mmdrop+0x10/0x180
>   ? __mmdrop+0xec/0x180
>   ? hrtimer_active+0xd/0x50
>   hrtimer_try_to_cancel+0x2c/0xf0
>   hrtimer_cancel+0x15/0x30
>   napi_disable+0x65/0x90
>   mana_destroy_rxq+0x4c/0x2f0
>   mana_create_rxq.isra.0+0x56c/0x6d0
>   ? mana_uncfg_vport+0x50/0x50
>   mana_alloc_queues+0x21b/0x320
>   ? skb_dequeue+0x5f/0x80
> 
> [...]

Here is the summary with links:
  - [V4,net] net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup
    https://git.kernel.org/netdev/net/c/b6ecc6620376

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



