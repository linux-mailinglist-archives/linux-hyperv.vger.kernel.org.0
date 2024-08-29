Return-Path: <linux-hyperv+bounces-2905-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72589963726
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 03:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6EA2839A9
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B1F1798F;
	Thu, 29 Aug 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB4cYiz2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE602BAEB;
	Thu, 29 Aug 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893235; cv=none; b=h1MvalHtNnF/rURTA+pRosMUPH9XUAy2gIgnNBPfKiPuYSi92ZJh5lGJE1tdjLUTpDQ4OcO71C816zbxmi2+c033+UHFcpdDTd3u9RL2wPWIX2Obl53snrs3Z1M7iXSZxcixpVow54QvIDRk/NykB3b5ZaC/YScf5iIilhhx4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893235; c=relaxed/simple;
	bh=5/+Fw1Dfro7if1IVlV6dOLSMIl4q+fSi+7fIjJrxyu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jjhWMk0g3Ie9AKVYnKkRNyphTbAbgVis8CguW+kJU4FeeNNXaL/5CrT9Kmlni5JOgReA1pQMXTqlbFBhUlTtJ73F7FB2SC24OrcfCokOqPQhWoX1iOyoqhNmaMjvg/dRcddIbXLhTm2a4SD5pQymMHSpAwk5/1c2RcQ0wun776U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB4cYiz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7676DC4CEC6;
	Thu, 29 Aug 2024 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893234;
	bh=5/+Fw1Dfro7if1IVlV6dOLSMIl4q+fSi+7fIjJrxyu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TB4cYiz2cda7012vWyxL7j5dOk/iPTtCEGao+p54LHVLZ6dkcJ+QXODDzwHwLndSr
	 vyQDSWQ43BHdqlu1+2c2cEB1EfoZrdhm248a8jwQGQq1tJBWUld61ip9CR33KLFSxf
	 VNpL9T9lxYomTkUhN9v7tK6cjaD/+xzaGmDZ7Cqy02TJdzvMlzUdKeO2P9jmHjc6xX
	 4Z/KwhFf4H8kCnWAiD6sdK2LE2qe1PNBQoocKvp6xnZe/CGHL7dUFj6jREvfiFAEyv
	 OlpMgXyxalTzxJbzTTKNAV88ujlaV78+wgnlChxm2UiiBnkDg7oJCHYJR4eyj+wgoy
	 OmP2z3sV/XWyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB01D3809A80;
	Thu, 29 Aug 2024 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: netvsc: Update default VMBus channels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172489323438.1482642.16270022738691881910.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 01:00:34 +0000
References: <1724735791-22815-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1724735791-22815-1-git-send-email-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ernis@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 22:16:31 -0700 you wrote:
> Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> Linux netvsc from 8 to 16 to align with Azure Windows VM
> and improve networking throughput.
> 
> For VMs having less than 16 vCPUS, the channels depend
> on number of vCPUs. For greater than 16 vCPUs,
> set the channels to maximum of VRSS_CHANNEL_DEFAULT and
> number of physical cores / 2 which is returned by
> netif_get_num_default_rss_queues() as a way to optimize CPU
> resource utilization and scale for high-end processors with
> many cores.
> Maximum number of channels are by default set to 64.
> 
> [...]

Here is the summary with links:
  - [v4] net: netvsc: Update default VMBus channels
    https://git.kernel.org/netdev/net-next/c/646f071d315b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



