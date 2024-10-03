Return-Path: <linux-hyperv+bounces-3106-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF298EC5C
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BBE1C21C0B
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD80146017;
	Thu,  3 Oct 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0YBLObe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4C139D07;
	Thu,  3 Oct 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948427; cv=none; b=drnP3Uyw9TncLDw9VpVY5toQx3MdLvHBqhNsRHm0SKoGxX6HXhA+Kd2hK6QUTk4GvNCIUOBtT9Lig1E1FokiEmCVgxXmvMgrS8Z0hqOFRnV1CPqChXNR7S0E8US8vacczbuS/J/A0/g415SnoKdofjv3PAl2PNULMxoXFrafgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948427; c=relaxed/simple;
	bh=LFd4++ARnwhBwXjU944tIIAQhIdqdupWfHSQTCj9Flo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJDPAKU6fSxOoBmtw/YP19OKh0CK+3YTZlZAOzr89PP1/WQ7ND/uDpDtrdGP1p/7RoYZt3e8oVtVjmSilktg4DZ5ONYU3rzlu7gbE4rBNiL9firvStG5iix0xXos6AQjTQbK36hpDGjWhadJ+v2Z4OWAoB0cS3krXCpQn4dg5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0YBLObe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EBAC4CEC7;
	Thu,  3 Oct 2024 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727948426;
	bh=LFd4++ARnwhBwXjU944tIIAQhIdqdupWfHSQTCj9Flo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q0YBLObeA+rDsTw11e8JZT3eaIfH5wIk0iahFyqHbfRQIBcC6c5Q4dBf9nXzRqJEk
	 FegibTDSeM8T8xkUMWZgFU6XR9XTYv9UAVefiKUZwZ6tP1sewRmNOXxRSeH3VPncCH
	 5hYkDg9sQJ7yF6+INiLQ6xjblZ8CP9f4o/SjdXQG3AxeNpy6B13FUqht2KfhLc7igd
	 uPM6xeWzC48Ssgutak9pXTzufpRvTELlqzm4TxkbmL+hGMKDKLdVRWWZTdWvzOV0Dy
	 0wDFT99H8E1+zCgPVWIIWSLSGmAOyjt5QpIKxBHyB8GxFRC3klCnduRICCnkeYoHi/
	 TSDQTDNIgVSNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEBE380DBCA;
	Thu,  3 Oct 2024 09:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next RESEND] net: mana: Increase the
 DEF_RX_BUFFERS_PER_QUEUE to 1024
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172794842978.1797683.8326945624970411743.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 09:40:29 +0000
References: <1727667875-29908-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1727667875-29908-1-git-send-email-shradhagupta@linux.microsoft.com>
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
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 29 Sep 2024 20:44:35 -0700 you wrote:
> Through some experiments, we found out that increasing the default
> RX buffers count from 512 to 1024, gives slightly better throughput
> and significantly reduces the no_wqe_rx errs on the receiver side.
> Along with these, other parameters like cpu usage, retrans seg etc
> also show some improvement with 1024 value.
> 
> Following are some snippets from the experiments
> 
> [...]

Here is the summary with links:
  - [net-next,RESEND] net: mana: Increase the DEF_RX_BUFFERS_PER_QUEUE to 1024
    https://git.kernel.org/netdev/net-next/c/e26a0c5d828b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



