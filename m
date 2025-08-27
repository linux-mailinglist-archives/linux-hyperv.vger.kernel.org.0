Return-Path: <linux-hyperv+bounces-6609-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DABB376EF
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Aug 2025 03:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BAB1BA0212
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Aug 2025 01:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9531CAA65;
	Wed, 27 Aug 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2nBnLVc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C37404E;
	Wed, 27 Aug 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258199; cv=none; b=KON1glcIimdJuxrNosqDY8D2tAF3MLlago8LC86FZ961Vf7A0WO6KjqHOpQeweB0DGN2XjoRuEEYFT0NHhyRfjGDQ4nhCzscac7dJiLiprZ2xN8lwn5Z54/F41x2438bV+boLz63Toqye9L3/vpoO3jJmN0EaCVbjgkwViwn/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258199; c=relaxed/simple;
	bh=GQfihvVPtcw9WYhwoIpsSwyiiSvECH6fa2fqDJ0BdEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NihO38FAL0LZZBLX1yiW0ERZ3O+E3IRoyRDd+r7XgsftfZOiG0l1+ED2xcBTZXKEm29OPN2v4GaL/RWDsD37NdFk3K9yJYiTd9wbQB3nX+n6yYYFv7y/XuphUlACXmL0SCAPbx/YHOQ4KKKzvtQpepIDN8fVNmurMf/PH474etc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2nBnLVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC23DC4CEF1;
	Wed, 27 Aug 2025 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756258198;
	bh=GQfihvVPtcw9WYhwoIpsSwyiiSvECH6fa2fqDJ0BdEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D2nBnLVc8kaBWVzIsB/oDyTN+0uH9bSfTd/t1q4HkLScHNmNG5qvM8Glykyj6V6g7
	 srsDrHr+lJUAXgcakU33Ym+zTg6Yq6JqWUh6xQWXj8IyzSTaVhj4VBEQcCrZCwQqbG
	 BVwBbZFPtaks9k7BEWtuT3amIur/Qp60vU7hM0PnzwI+jcvEsW0FdyG0NV7QcVwtmN
	 yVmloizyOhmds5H67JuLOq/CXIUhB39K4BpDR0MahPRWgPszEN0mrytiu/MLgGyrO2
	 J76VFwfxjSL4JYEoDEdHEK3XndKIZBCNMWF/7npyMHkHuuaW1RtfPbnOyDXO7Iig5m
	 zU6levwlK8CpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B5F383BF70;
	Wed, 27 Aug 2025 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hv_netvsc: fix loss of early receive events from
 host during channel open.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625820626.162890.13956078628306112530.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 01:30:06 +0000
References: 
 <20250825115627.GA32189@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: 
 <20250825115627.GA32189@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dipayanroy@micorsoft.com,
 ssengar@linux.microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 04:56:27 -0700 you wrote:
> The hv_netvsc driver currently enables NAPI after opening the primary and
> subchannels. This ordering creates a race: if the Hyper-V host places data
> in the host -> guest ring buffer and signals the channel before
> napi_enable() has been called, the channel callback will run but
> napi_schedule_prep() will return false. As a result, the NAPI poller never
> gets scheduled, the data in the ring buffer is not consumed, and the
> receive queue may remain permanently stuck until another interrupt happens
> to arrive.
> 
> [...]

Here is the summary with links:
  - [net] net: hv_netvsc: fix loss of early receive events from host during channel open.
    https://git.kernel.org/netdev/net/c/9448ccd85336

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



