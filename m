Return-Path: <linux-hyperv+bounces-9800-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLGiLZxAxWkU8wQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9800-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 15:20:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1D336B20
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 15:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7A8A3082F92
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A735C1A0;
	Thu, 26 Mar 2026 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SylF9PGH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB9371875;
	Thu, 26 Mar 2026 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534223; cv=none; b=EE4+95Cgj6DcYqlg4AJ9aQ28yrYAx4bOKYegBcCAIiG1lyre++hyTciVqLNSENLu1pKBUb1kN5f8JS2hSPF3RLcamVWUAf4wPRtZoWAAFk/f6sWLVf5KvvJ8AcxWf/CYGB/77aJ+BhZDOIKr6wIpHAxmZ1SXjwyM9rl98Je+QhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534223; c=relaxed/simple;
	bh=qDXpn8tSOCXVn4ZPGywJkTMJ+kkBMvnV1b47RKYboZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NlH0hrU8G+IkBd6gSK/CCnuZ9M4LgQf3tSiQJasbf7MNu3MGKVjqd2DNHG9nimUGxiKkVL9ny8t42zsksenB7h/rnwYdU11KyeoakRB9277/Sp6Y1th7++McF4tXJUVz/dWUcSakuBKAn2EdpnT6FBbDwSo9Fgz/qlclNckDOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SylF9PGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A1DC116C6;
	Thu, 26 Mar 2026 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774534222;
	bh=qDXpn8tSOCXVn4ZPGywJkTMJ+kkBMvnV1b47RKYboZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SylF9PGH2EGpNlsTu2aaFYfkCFg3+gDznpF8mWO7WAGofPtiw69UUuUQQe7d1hszG
	 lqHMps1JSVsGxMMP5kK7S96qfLVDN5nCF++7xDNhVYHLsJy+izTuFIVwnBpGoEbMh6
	 pLKk1ODXxMDVNQtbdVxrTBAGw9RnGLQ6/kwNtCmwC0SicQdrvCZL+h8A+e040DijL0
	 ca+XUB4YponCWCJPTCleMzvQlRmlduu1w+tf0YO48UIRQHparfwfxVlkM7ravLdRl+
	 4TPRv9u+7sBT6H9DjDHc5N/KhBvT51MIp5ujvtADFmYPoLsv2tyi+JGJQIuae1jIFJ
	 oXtMuRg47nmgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE5039EFA69;
	Thu, 26 Mar 2026 14:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: Set default number of queues to 16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177453420903.2572343.6705987187482730782.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 14:10:09 +0000
References: <20260323194925.1766385-1-longli@microsoft.com>
In-Reply-To: <20260323194925.1766385-1-longli@microsoft.com>
To: Long Li <longli@microsoft.com>
Cc: kotaranov@microsoft.com, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, jgg@ziepe.ca,
 leon@kernel.org, haiyangz@microsoft.com, kys@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9800-lists,linux-hyperv=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12D1D336B20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Mar 2026 12:49:25 -0700 you wrote:
> Set the default number of queues per vPort to MANA_DEF_NUM_QUEUES (16),
> as 16 queues can achieve optimal throughput for typical workloads. The
> actual number of queues may be lower if it exceeds the hardware reported
> limit. Users can increase the number of queues up to max_queues via
> ethtool if needed.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Set default number of queues to 16
    https://git.kernel.org/netdev/net-next/c/45b2b84ac6fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



