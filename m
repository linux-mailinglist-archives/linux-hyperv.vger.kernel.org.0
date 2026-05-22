Return-Path: <linux-hyperv+bounces-11158-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJonKNSfEGpuawYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11158-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 20:26:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A65B9019
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 20:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D1FE302E300
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 18:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38E374E5A;
	Fri, 22 May 2026 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFHjpT21"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A237204A;
	Fri, 22 May 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474009; cv=none; b=Dhw46stAaeD0oV5am1Bm21H0B3AKXe6w2i1SQBvip3kqqvCd/F58A6IWsmXZZvfJh39X3zxB5PivOZLLbZuWmsvW2VgXrEeBwT50DORPUZ7LRqrt8CmMYDHynB657xbgUntZPzPHe1SRw3Nxq0DL2h/BFEHMhftUgLtugNxzPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474009; c=relaxed/simple;
	bh=NUoNLZkXE7mCPVDC6q+rsPMeKJv3VUIh65EIfkPD3sM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NTjC4CCPE1ifIafj84p/bjjlF3mlCTGFAxw0t1SDCBCyRTN33ohqgqaZ0Woen7L4LlfT5PoCPwxN4HKJ5F1tdoS7C88pt43sN/EPd/kVnAksJ+f/CRt4xcEVs5GoZ80pxFpgVq+bB6/A3o1+TDi5qTvXtY56HluuxvETomWqdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFHjpT21; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E40B1F000E9;
	Fri, 22 May 2026 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779474008;
	bh=qM2p6TEmCfXL753GtJ3p2ebVls1ARMYe7b6ogYrro08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RFHjpT21c9Tdmt5V3Y7OffReXiagtN+25l/L1Swf6yVoJNkwQGEPUo4OGC6bnJMqK
	 hP54lmC6xu6cQ11deryvMqDHAfq9qjDs6iOAB5EmgwYpJiW2eqf1RJc8Q32/4vHiuC
	 S5fVQuXYO3e5xXZ3ZGwSbSzt3qAHNUd7EKqQBoDhgYoj4088K2O1niL+HQSVhfDLmy
	 ECQr0aMq9IrPUNYW/P9AOpCVGxJdyNMSr3NJ7UzvxE9Swi5Bzx4ki2QKJ7CjVgs9fb
	 i50b6tq7xyc/55P34erz0VpeZ8tb5v8b5rICjYIQULh8IhKMqKpxEdGjnzra9scptT
	 jnxXB5TLXmmHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BD03930FB9;
	Fri, 22 May 2026 18:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9] net: mana: Expose hardware diagnostic info
 via
 debugfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177947401714.1320830.17170258046275289857.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 18:20:17 +0000
References: <20260519064621.772154-1-ernis@linux.microsoft.com>
In-Reply-To: <20260519064621.772154-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, kees@kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11158-lists,linux-hyperv=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF3A65B9019
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 23:46:10 -0700 you wrote:
> Add debugfs entries to expose hardware configuration and diagnostic
> information that aids in debugging driver initialization and runtime
> operations without adding noise to dmesg.
> 
> The debugfs directory for each PCI device is named using pci_name()
> (the unique BDF address), and its creation and removal is integrated
> into mana_gd_setup() and mana_gd_cleanup_device() respectively, so
> that all callers (probe, remove, suspend, resume, shutdown) share a
> single code path.
> 
> [...]

Here is the summary with links:
  - [net-next,v9] net: mana: Expose hardware diagnostic info via debugfs
    https://git.kernel.org/netdev/net-next/c/c227f8aaf22c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



