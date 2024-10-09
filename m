Return-Path: <linux-hyperv+bounces-3137-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E15996AD4
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Oct 2024 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1AEAB25A6B
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Oct 2024 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591BB1E0485;
	Wed,  9 Oct 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWwrtTNS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BBE1E009C;
	Wed,  9 Oct 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478229; cv=none; b=PKkSpHWBCeS2BBOc1aIELl+57eNBcwvlnpJrKr8OQwPPK+x3n9HO5ZjS+d7zpCBHzwYuXvgRj8zImoWdsgSSjhLmtc14Yfp3gQ+hTfXViXBXQIVknmYgdBQ1Hf4hRpEN3AzRnmEne0g7tTm1wNzZvHZ2OrJrzyD43MCsSruuRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478229; c=relaxed/simple;
	bh=K5DD2nAAM9lfRuDqw8wPZsWCJoleX524mImPuhi+4Pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p/p0IvxVAn9h5ASXwR8fw3WawuUhK2YoKk6NLSBWCcrEUOIBfoffqlEQsEYax730yhXKwddr2jujPlHv3qZrWYLxxsHD0ovlni26osrT8vcwo4XA+zOXdd/kaW/+7CbgK1xtmiA2LoOox+OcmwKmoWY0hYzQGCwqb37Hx0JgPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWwrtTNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFF5C4CEC5;
	Wed,  9 Oct 2024 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478228;
	bh=K5DD2nAAM9lfRuDqw8wPZsWCJoleX524mImPuhi+4Pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uWwrtTNS7htGOAnLifiVgjm9InAuzyYYyRVisxDRLW6kSfxL8lxchyzcWkOPMOfD2
	 AYX+v1gWMM6ljfiC6Ll6Zq0dLVWj2DVuhdvx565Fe7BtM3A4aGywXyBleSJ7ZLTQW5
	 yPhrz+JPfPN1cZS9iSFp/sV8koU3UUZE/9qGbMOJaQEHFL2soKe7T36Tn8hzFaxYRj
	 MXklM7o9t0x0wfn+UcC3rQ8HmEx+fGDO9QmZLHk2pCRkW2vtlzjNywWRA26PS1DMs/
	 G0lPDQGLsb8LdwjN4ZWENaNt+53ODH4h2D7mTOBuNt/2e/TPYJur6Sw1vPJB6ZO6Dt
	 d8Ykxtfi7MjgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B733806644;
	Wed,  9 Oct 2024 12:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: Enable debugfs files for MANA device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172847823298.1258225.9909858718336376294.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 12:50:32 +0000
References: <1728371175-906-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1728371175-906-1-git-send-email-shradhagupta@linux.microsoft.com>
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
by David S. Miller <davem@davemloft.net>:

On Tue,  8 Oct 2024 00:06:15 -0700 you wrote:
> Implement debugfs in MANA driver to be able to view RX,TX,EQ queue
> specific attributes and dump their gdma queues.
> These dumps can be used by other userspace utilities to improve
> debuggability and troubleshooting
> 
> Following files are added in debugfs:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Enable debugfs files for MANA device
    https://git.kernel.org/netdev/net-next/c/6607c17c6c5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



