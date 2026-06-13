Return-Path: <linux-hyperv+bounces-11619-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O0ndH6KrLGpKVAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11619-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jun 2026 03:00:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5167D5ED
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jun 2026 03:00:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=is3S2qus;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11619-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11619-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E642230BBA3C
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jun 2026 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8EF235358;
	Sat, 13 Jun 2026 01:00:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E16230BD5;
	Sat, 13 Jun 2026 01:00:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312416; cv=none; b=dFc1BQKwxDlAsyldzndEbapeA5hLGiCVdGfi6tltgAYWjPMQPEFvi/zJC9vQy63H6EfNziW4jXyFFs+61c2qYim3bSoLC53HDBmdcMmzYk9xyDtSwoK3lMLMTMtIJ7dVsU28T5qsI/fEVIHFdNFPNl4IbxlXqq32JcafSndLyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312416; c=relaxed/simple;
	bh=KQBCGovx6pW9BG+SLC6gMdk931SvMd3g/FXOzhlQ77s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GGHpm0m10cvNecN3qvSg9VwZ8+9YShEP/S6WI+86z+RQWPUdHWMFY7Bvb0gok/zlIYdh6KBKHByk5IZf+1Lq1/2loy6MofTsJBLdmze39zg1zgBqPcJFFNEGGG2tv8r/sBedK2BlidCqDSWmnnscg5bJcwzDonXtSFPZxRr029s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is3S2qus; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28711F000E9;
	Sat, 13 Jun 2026 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781312414;
	bh=xqGsbkPdl0hqgDNGcNTdWHgt3v/FRaY13OJIvlpgRo0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=is3S2qusAuhnoIIrh39bFJT5h3HLbZlzYqNEQO32Ms33rNZuTnplrFQ0Lgh1Jpr7s
	 JPe9T8U2kfMh5jDWy8MhPoNPe+RIvXAERS+0D4avMWyVVr+Wm67etVlheJQgB1zu9G
	 lPJdvEm7DudXL2iLcClyaQTF/8+t484RuNJ2dYntfS1YzQQtwaehKm+WTZFQ7qnVbi
	 BNYWPGsqFLJlVw6IRDjn7/Kzr6pKVf6rm+/Kwt2zg7jXx/22t5Ty5LAR8kPLzNlStC
	 /iu24RtHc0Re8CoG5Y7SDYXfqGrHQKBSs/gOymYj1IMwptatz2jqvLwcskz49SDrQE
	 St08KGHS2in3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9392F39E9607;
	Sat, 13 Jun 2026 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: mana: fix error-path issues in queue
 setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131241114.1315131.16718270093516277133.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:00:11 +0000
References: <20260608101345.2267320-1-gargaditya@linux.microsoft.com>
In-Reply-To: <20260608101345.2267320-1-gargaditya@linux.microsoft.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, ernis@linux.microsoft.com, kees@kernel.org,
 shacharr@microsoft.com, stephen@networkplumber.org, gargaditya@microsoft.com,
 ssengar@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11619-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:gargaditya@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:ernis@linux.microsoft.com,m:kees@kernel.org,m:shacharr@microsoft.com,m:stephen@networkplumber.org,m:gargaditya@microsoft.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDF5167D5ED

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 03:13:39 -0700 you wrote:
> Two error-path fixes in MANA queue setup, both surfaced during Sashiko
> AI review of a recently upstreamed patch series.
> 
> Patch 1 initializes queue->id to INVALID_QUEUE_ID in
> mana_gd_create_mana_wq_cq() so that a CQ creation failure before the
> firmware id is assigned does not NULL gc->cq_table[0] and silently
> break whichever real CQ owns that slot. This mirrors the existing
> pattern in mana_gd_create_eq().
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: mana: initialize gdma queue id to INVALID_QUEUE_ID
    https://git.kernel.org/netdev/net/c/5985474e1cb4
  - [net,v2,2/2] net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check
    https://git.kernel.org/netdev/net/c/f8fd56977eee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



