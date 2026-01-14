Return-Path: <linux-hyperv+bounces-8284-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6424CD1C36F
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 04:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A616301E159
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3080324B31;
	Wed, 14 Jan 2026 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+05DgqD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A313242A4;
	Wed, 14 Jan 2026 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360416; cv=none; b=F+OZQLHGijOEqBznk9tyVqF0f3V0CgDuskxNjdsLqe57mOntMXrKKq0jKwKnWKA4WZEhDzyLb7nR1RIemnZurB4feVkCcUJ5NPAzBDUutJNQAwYe2PvqsKVQJY7X7fHySiYhYbwgjMa5cdPrIJnY+1WunffHFrWNcz3x7kD1eBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360416; c=relaxed/simple;
	bh=95aqeUD8V3rNNrJu+KyqNXUsjkZKiS7w5jy57uAN3EY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qfch1CTQCluOWZUMLO0lvlvraQRFY8Iuy+HcQOt0zdk4CxLqpHIwHi67IFdbnSO3q6lIjPJNZYLV4LM2EiVPDUsPDaERFJldUnPhTrtE+aM34PZT/WMq9OhBkMnZ1SmfablCTJZp/PO3lriAOl/fnL8kfYjjp9SuQj+eKyXaw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+05DgqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7ADC116C6;
	Wed, 14 Jan 2026 03:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768360416;
	bh=95aqeUD8V3rNNrJu+KyqNXUsjkZKiS7w5jy57uAN3EY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B+05DgqDbQ0z+c8sQAIPgcL3CTm9VhWmtaYdUR7pKwU0vHNnSFk6DjLlUH8YHtirf
	 mShQ2eTMb56cfbjuioj08dB3o3jmT23oUrf+1h+i9ogi1tXPJDuH1JEIRt4RJTnBfv
	 4ti/CjQ9oGH3caD7D82dHwOWgMzG4mXFFsnH6BubxGlfJZkZj2hVl1bcchqCXaJoOS
	 gMGrJzQ/34vutxJNhNV6yM79GSEP0SKfqlyd68asHGYPuJnlGXNCZkYQsaITiD1Y2H
	 sdLPlMVo1nhEiivFTXEfuVau4GbiBOnWnwSry3rEQp1g1UmHKcR72fWldOD1jkDRd5
	 4KDIw9cZ5sZ/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786EF3808200;
	Wed, 14 Jan 2026 03:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hv_netvsc: reject RSS hash key programming
 without RX indirection table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176836020927.2567523.1846936182754550828.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:10:09 +0000
References: <1768212093-1594-1-git-send-email-gargaditya@linux.microsoft.com>
In-Reply-To: <1768212093-1594-1-git-send-email-gargaditya@linux.microsoft.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dipayanroy@linux.microsoft.com, ssengar@linux.microsoft.com,
 shradhagupta@linux.microsoft.com, ernis@linux.microsoft.com,
 gargaditya@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 02:01:33 -0800 you wrote:
> RSS configuration requires a valid RX indirection table. When the device
> reports a single receive queue, rndis_filter_device_add() does not
> allocate an indirection table, accepting RSS hash key updates in this
> state leads to a hang.
> 
> Fix this by gating netvsc_set_rxfh() on ndc->rx_table_sz and return
> -EOPNOTSUPP when the table is absent. This aligns set_rxfh with the device
> capabilities and prevents incorrect behavior.
> 
> [...]

Here is the summary with links:
  - [net-next] net: hv_netvsc: reject RSS hash key programming without RX indirection table
    https://git.kernel.org/netdev/net/c/d23564955811

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



