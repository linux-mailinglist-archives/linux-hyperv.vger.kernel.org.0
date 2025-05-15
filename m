Return-Path: <linux-hyperv+bounces-5520-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4019AB7BDA
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 05:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9941BA709A
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C4D28DF32;
	Thu, 15 May 2025 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9DTHpJm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60D4B1E64;
	Thu, 15 May 2025 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747277998; cv=none; b=A5SdNU1bNL5PS3Cwp/KUEV4EmkVOevQGGIPd9t7zS0dtFVCdglruOQOoz1WLSN9WWsBNQPvxmjgzjlc6crswGQcozTV08yMQzeXAK/B2Hn6FGmpaRwLzJP9AOL6HU8moMXn0HgknApsiycrXyqPYpf4LIu7Dyb5dK+YcnETIO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747277998; c=relaxed/simple;
	bh=PDLb/Z5CFapT4NGFtLlJZRiFyM6zo5sw4RC5O3pCj60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PvinJE3pEvDX3g7cjqYWxqfPlr4opROMMdOgJx30KbE38PL9X/FxBQRgixIz0R0btBOOuzA2faBbHnElSGx4kM/Mduv4qwkIYAVewZsZahDboWuiGuI5K9Si56RndU9LjTL2k8N4ym93QS2xrSQxXRk57tM07GmOpRE+XaASifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9DTHpJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC5FC4CEEB;
	Thu, 15 May 2025 02:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747277997;
	bh=PDLb/Z5CFapT4NGFtLlJZRiFyM6zo5sw4RC5O3pCj60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V9DTHpJmS1XdJOo7dTi7f7SBsTBdKs7B7n75z+ENLeHSUtQZgNpTNstGghGQUFP5K
	 sWDX1QeIPCL9RWephFXnPsWqPZ2JXEKoTi6gkya1Agy7KlfNvH6CjWbUI6idmhT8Ao
	 2gD7tm/ix4SJJCBsiQkG0P8Fho4t7vIuDwjf66CYz3rZn00jFZxeh6qx4FnMsNIQ85
	 AsOk6n3MPNmp8Jnp/gGJmhMdGD8xpxhTNnlZMDYINBb/+vSC4yFdatZlLpiDf4IAdB
	 +TWT8lBJIK/8/evfnk/91ncMR9Mab5VL1VrNCpguRFRuXO8Yi3QHw07bfGLhaUe93g
	 ncZtNbubpVCGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D20380AA66;
	Thu, 15 May 2025 03:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] hv_netvsc: Fix error "nvsp_rndis_pkt_complete error
 status: 2"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727803505.2590892.12386533199392905169.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 03:00:35 +0000
References: <20250513000604.1396-1-mhklinux@outlook.com>
In-Reply-To: <20250513000604.1396-1-mhklinux@outlook.com>
To: Michael Kelley <mhkelley58@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 May 2025 17:05:59 -0700 you wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Starting with commit dca5161f9bd0 in the 6.3 kernel, the Linux driver
> for Hyper-V synthetic networking (netvsc) occasionally reports
> "nvsp_rndis_pkt_complete error status: 2".[1] This error indicates
> that Hyper-V has rejected a network packet transmit request from the
> guest, and the outgoing network packet is dropped. Higher level
> network protocols presumably recover and resend the packet so there is
> no functional error, but performance is slightly impacted. Commit
> dca5161f9bd0 is not the cause of the error -- it only added reporting
> of an error that was already happening without any notice. The error
> has presumably been present since the netvsc driver was originally
> introduced into Linux.
> 
> [...]

Here is the summary with links:
  - [net,1/5] Drivers: hv: Allow vmbus_sendpacket_mpb_desc() to create multiple ranges
    https://git.kernel.org/netdev/net/c/380b75d30786
  - [net,2/5] hv_netvsc: Use vmbus_sendpacket_mpb_desc() to send VMBus messages
    https://git.kernel.org/netdev/net/c/4f98616b855c
  - [net,3/5] hv_netvsc: Preserve contiguous PFN grouping in the page buffer array
    https://git.kernel.org/netdev/net/c/41a6328b2c55
  - [net,4/5] hv_netvsc: Remove rmsg_pgcnt
    https://git.kernel.org/netdev/net/c/5bbc644bbf4e
  - [net,5/5] Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()
    https://git.kernel.org/netdev/net/c/45a442fe369e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



