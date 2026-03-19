Return-Path: <linux-hyperv+bounces-9536-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPToCh9pu2kbjwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9536-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 04:10:23 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E862C5509
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 04:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CC7730642D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 03:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4C3368BD;
	Thu, 19 Mar 2026 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOei5mc5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF440DFCA;
	Thu, 19 Mar 2026 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889820; cv=none; b=ElhqU8sslg7FS5rTCmlKc7NZHg/JySVKkAv+6ZuAwJt8Mdj06U+okkP7yr2tkZYUedcQ031R1dq3fURzZTMHUxvoEmqBiHOMy03K4m5/qkovmXEx7bt09e9/O1q0bU814FgXl5GvhVFZsluLvKdxBsJQKBcK4KryeECeGCZ55RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889820; c=relaxed/simple;
	bh=zrtGPBlmwv3bHJ0dKnfcrKQ9djenXXqNcDoZSmgUT+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rdyGt0+j0SM8Xbi3jY10yaqCHcrPT4tAhURzJRCpgO5IkSfrRHdNcZrXVd98P46fxtN1S1Wu8Fa0CmuT6ECRhI/WW6mzhtFgVRMLxTV1ECYtGy5liyiMsmk3G2GBYo3vkl9ngI5qeYNUFZscR2BlSBNfrAi9JFxskLdmH3aMmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOei5mc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408BCC19421;
	Thu, 19 Mar 2026 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773889820;
	bh=zrtGPBlmwv3bHJ0dKnfcrKQ9djenXXqNcDoZSmgUT+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GOei5mc5gT2c9BwbaIa8RDhR6gFhY9dA1NaIxaUBJKtjAtvC7k9gryvInaaZdHrnU
	 6L3osodVwZgaP7iziiEK6GotFJeoBTrZSIyjzaTjwCsBAc1fw66GW4DDF9/uWVFkZK
	 B3MeJ2K8Ts3S0s+YdPOeL8iIFA7B+0fDpOQ/bDaMxrPhCvj1eA2e8gQq94qeY7V720
	 0bnwdsU+jmxMN1ShVUCl3qbLWuZOMXWf9CjR8uNBjxokyvHK+1GoqoU+vAHtYqaW+3
	 tAg5y/uh8rEEGNgLZUKn4fC3LcnecEV0iZi7Cb/aR8PvUOEVn3dtCU7ePMN8SJh5Me
	 xcd3MQSVuHRpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1503808200;
	Thu, 19 Mar 2026 03:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] add ethtool COALESCE_RX_CQE_FRAMES/NSECS
 and
 use it in MANA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388981154.1008325.11236653611617046174.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 03:10:11 +0000
References: <20260317191826.1346111-1-haiyangz@linux.microsoft.com>
In-Reply-To: <20260317191826.1346111-1-haiyangz@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, paulros@microsoft.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9536-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73E862C5509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 12:18:04 -0700 you wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add two parameters for drivers supporting Rx CQE Coalescing.
> 
> ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
> Maximum number of frames that can be coalesced into a CQE or
> writeback.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] net: ethtool: add ethtool COALESCE_RX_CQE_FRAMES/NSECS
    https://git.kernel.org/netdev/net-next/c/dc3d720e12f6
  - [net-next,v6,2/3] net: mana: Add support for RX CQE Coalescing
    https://git.kernel.org/netdev/net-next/c/c2fe3ff3d66d
  - [net-next,v6,3/3] net: mana: Add ethtool counters for RX CQEs in coalesced type
    https://git.kernel.org/netdev/net-next/c/d01440e10a82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



