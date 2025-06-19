Return-Path: <linux-hyperv+bounces-5970-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2FCAE0FEE
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 01:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074267A6210
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 23:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B328BA81;
	Thu, 19 Jun 2025 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHGCIDVT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB420E711;
	Thu, 19 Jun 2025 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375179; cv=none; b=gPglQ8qO+vyHvRvYZbyHgg9yhQYALKj2mqAiDwyfEemXM1SCb8mySoxu+nndxcytHJ4yIppKsutJubbDXbiAikhvlJfhxKM3eZENeCQKx4rtRI2kFdmxdgVQJ1+0qb+6sWFNQQPEwWz6nGLTan6X2esmAb8D2WxFy6B1cVIxbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375179; c=relaxed/simple;
	bh=1iitjCLE0DZH0hmZdXHmHbGc0acxiTVlORAr7x2Ff2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DUb02xl6sv+jpkpI96r73maMysJonhCLkRFvk7uJHGvlIC/8BRGtr1KFvjgN76jDJ2BHFWCzOvLsfhRA18uliW7o285k9mq2sHWXApS1pXKsuDuVzV5IcQJEskowPPKP4nLlzmjOPTg/HB1oj+Z4j+G5nqtPZDxZDNymKyTKkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHGCIDVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EB4C4CEEA;
	Thu, 19 Jun 2025 23:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750375179;
	bh=1iitjCLE0DZH0hmZdXHmHbGc0acxiTVlORAr7x2Ff2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kHGCIDVTAXuEpNeOWqvBztDwNhtbC83OdZWsNR7VxKi1DmeB59lnsfvgfRSDBi0C1
	 DDaAdjCmRPIZs+3EMompPWmZpK2yzknxZSoWeAdGJ9z9S2lz8MKsDFgjgL/HPX0NLa
	 HZC4N/dn7FxZj9FPVK1bqhTj21lPCWtPrZVQVi0pNSLezl+0acGbqD1uFW+MKITodj
	 5HgaQxtTQdUABL1Pee4+F8KmHyHlFWm8U/2hNicNcM2fuTN1Ce8A8AjC/jE4s9ToKT
	 +/XP1XOSo+Ktn1d1cM0RpT/gOkzzCs4MvoKk/cldSm9q5Rod3xhRCBFgRyh/ny5Ssk
	 /2ZaD1IloRHYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3138111DD;
	Thu, 19 Jun 2025 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net-next v3] net: mana: Record doorbell physical address
 in PF
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037520700.1016629.11511793485782650744.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 23:20:07 +0000
References: <1750210606-12167-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1750210606-12167-1-git-send-email-longli@linuxonhyperv.com>
To: Long Li <longli@linuxonhyperv.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shradhagupta@linux.microsoft.com,
 horms@kernel.org, kotaranov@microsoft.com, schakrabarti@linux.microsoft.com,
 erick.archer@outlook.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, longli@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 18:36:46 -0700 you wrote:
> From: Long Li <longli@microsoft.com>
> 
> MANA supports RDMA in PF mode. The driver should record the doorbell
> physical address when in PF mode.
> 
> The doorbell physical address is used by the RDMA driver to map
> doorbell pages of the device to user-mode applications through RDMA
> verbs interface. In the past, they have been mapped to user-mode while
> the device is in VF mode. With the support for PF mode implemented,
> also expose those pages in PF mode.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: mana: Record doorbell physical address in PF mode
    https://git.kernel.org/netdev/net/c/e0fca6f2cebf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



