Return-Path: <linux-hyperv+bounces-7399-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E75D9C272E9
	for <lists+linux-hyperv@lfdr.de>; Sat, 01 Nov 2025 00:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4354218996DC
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E228C035;
	Fri, 31 Oct 2025 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpaXpmWv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14FB18787A;
	Fri, 31 Oct 2025 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761953437; cv=none; b=PaqCptKxKecLw6okSwwkQ+atbDjDNcGoKyr7YHDK0pqL3JQVl75WEbUViT6fZ8znFfxQUASUGaNuetfYvBTVlt5ZiuWrGH29x/qIw1eGiIevCUDDv/62i7QW8XlLQCGwyWFzexDGyQr4NuVmgTaILoi4e6jC+lbTgpWvQ0IhV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761953437; c=relaxed/simple;
	bh=IIidDSjrIKesdtTWH6GAfBa/6yYNEJ0t+/i0FVLa4g8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RXm+uCyTHn72XNFtNjALwYKaRPVH8RiqmvITVx7JRljzw1H9VD6dJXLhIcZyILjXvPrUf6NJ7C6z27LWfTDNQ0mZS/Z5ZSGCGTX6Fuez2rZEREZnP+Y61lEqogUdTHUKE2QhaIFVSR0klrzTcEyrvYh0vHohGLl7NBrHmNMPi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpaXpmWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772FDC4CEE7;
	Fri, 31 Oct 2025 23:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761953437;
	bh=IIidDSjrIKesdtTWH6GAfBa/6yYNEJ0t+/i0FVLa4g8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mpaXpmWvZTXX6sSAYknXFtEYT22OAKyfE2BsfF0lN3Tb27e+xLscStw37NPdcmT4B
	 ATknOee8nQio7T6Kpb0/l2Lf557tYQePWV4qLPTtuE+A4cwY9vEobK/wE8PMX2T4zW
	 xwMQ7zzzi8vFoj4Ktj7v6OR9yVkPx7yXglBZsss++w4VAehc6LNVybUS9/BDySOeWZ
	 8v2sOw/B+zvdQro9oAyjbB5jUGppKJJe3/XICluWmxF67YPBkaLm/dSqXf6ABPoLu/
	 6B8m4a+FLft5AenmDShLGjugjpSiWc9+ABw+3bI/SJJVGy/bjfXKDOeNtO58J40NGO
	 vReg2wdtDLyfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFC53809A00;
	Fri, 31 Oct 2025 23:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,v4] net: mana: Support HW link state events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195341349.666625.13563540939353336247.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 23:30:13 +0000
References: <1761770601-16920-1-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1761770601-16920-1-git-send-email-haiyangz@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, leon@kernel.org,
 shradhagupta@linux.microsoft.com, mlevitsk@redhat.com,
 ernis@linux.microsoft.com, yury.norov@gmail.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 ssengar@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, paulros@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 13:43:10 -0700 you wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Handle the NIC hardware link state events received from the HW
> channel, then set the proper link state accordingly.
> 
> And, add a feature bit, GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE,
> to inform the NIC hardware this handler exists.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: mana: Support HW link state events
    https://git.kernel.org/netdev/net-next/c/54133f9b4b53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



