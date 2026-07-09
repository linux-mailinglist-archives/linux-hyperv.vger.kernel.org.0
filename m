Return-Path: <linux-hyperv+bounces-11881-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b3WpAMlkT2qCfwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11881-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 11:07:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 881F972EAFA
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 11:07:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SviaK7ct;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11881-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11881-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D0FB3041819
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jul 2026 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4163EB818;
	Thu,  9 Jul 2026 09:00:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B521F2877C3;
	Thu,  9 Jul 2026 09:00:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587628; cv=none; b=rjK9x/HhcmfmyCnwck8npqutjWlv4zyTRBOj1NDR0ZTMc0WC8z3xGxoS8r/cxwoqEUQ7WXYTMGwJyQV1MtAIhq0/I8h4l45+sszyQAWcs92f2Vz6HFwGbL64yOPS95FCoE1OsDKWj21bKUVaK48GU2tNthV5fzK5KoPs2pLliIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587628; c=relaxed/simple;
	bh=GiWj5e9lJjV/mvs1zAZ3xygPXqHKRYlLyHE+J0BS5zE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FGDupUtxLiNaUoQD65wXqKvnZrhQc8MKHTr6swgdDE6IuyVd5+ejZjSuIDcjtp3BRaMrgJP89yctNo/mjM8BSIzOH7VapUpMXehg6/J7RXFzlNwm7nBGlgJQ+wqs+HI9qSj35K6pHfmCttAc0+3B6uCh0PbNM+KW1w/e4nTznKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SviaK7ct; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709021F000E9;
	Thu,  9 Jul 2026 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783587627;
	bh=mfc+WNJvm0yYS9GyHxV34XVqXNCC79jA4K6/gF6YGEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SviaK7ct00471jl0yZHBjfbTCcPKpONSOlI4vERjwQSJLgWovMJRMBsLVlaalqwZg
	 0WhHpYSsyrGcEfFYkpW6nrJmNZypBIL601m+3Mt6brCbkICI5muf3DgOz9uGhbjAKe
	 LQh4EkHwUGi3waqJ4ybHihVF9la/dypBailQV97kywphdkjOTErnIHExYkQpGac3N4
	 rI2o2N4jS8JYeCZcN1MQrlhWLuAMkDNzW6Y8/OA7Md4r67LRiv3n+AiGVmdgeIrEru
	 99QN1wFPcQdqEyyZjZ0AA+jtUuSPBnW0zyRrPuYA98+4CeRwKlWpcrV0fV+1SuCwLz
	 qcPTD/n1mfxBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698C393A54E;
	Thu,  9 Jul 2026 09:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: mana: Add Interrupt Moderation support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178358760589.3350016.13533059600878836164.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 09:00:05 +0000
References: <20260702220123.815018-1-haiyangz@linux.microsoft.com>
In-Reply-To: <20260702220123.815018-1-haiyangz@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 gargaditya@linux.microsoft.com, sdf@fomichev.me, leitao@debian.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 paulros@microsoft.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11881-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:shradhagupta@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:sdf@fomichev.me,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 881F972EAFA

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 15:01:04 -0700 you wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add Static and Dynamic Interrupt Moderation (DIM) support for
> Rx and Tx.
> Update queue creation procedure with new data struct with the related
> settings.
> Add functions to collect stat for DIM, and workers to update DIM data
> and settings.
> Update ethtool handler to get/set the moderation settings from a user.
> To avoid detach/re-attach ops, ring DIM doorbell to change settings
> at run time.
> By default, adaptive-rx/tx (DIM) are enabled if supported by HW.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: mana: Add Interrupt Moderation support
    https://git.kernel.org/netdev/net-next/c/433f482add31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



