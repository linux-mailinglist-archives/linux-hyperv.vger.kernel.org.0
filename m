Return-Path: <linux-hyperv+bounces-11574-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sBD5GnyyKGooIQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11574-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 02:40:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA84664FFC
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 02:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XeHvRbo1;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11574-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11574-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D297B3020EC0
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B0A1C84D7;
	Wed, 10 Jun 2026 00:40:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E81A6839;
	Wed, 10 Jun 2026 00:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052024; cv=none; b=PkRC/MlCCz3eH1LgpUYAIFNZHoWE4HDQKoVltCvrCW8C5Uw5NAt3AsnxPu1UAmI08fr/NZscost9/ajnOnSvDtHKTyR3GEn3tqOeqJ/AwJ/0+CtBujnmi5aqnqZ6NIxP9b8UKGTb2C3BldQF7fkNnOTp3YFIHZvADKdSeyJTmEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052024; c=relaxed/simple;
	bh=GNtruyY3bNPBssViOYW5EzehELt7YIr9EPaQxYU1H/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u0990l0NeGCXM2BjcaOimcMHP2NByfn/EZDDUc/cmnrnAvbM8xTZgude2504OeCo6opeYhXiSsirvShEhs66VXKWJwdqOteTZGH55j6jnsPrwpIuaEcYxSERedbth/8oMaYEhHgs373FD/Z0R1IXBTczyNKXFdcxXfBD9WYXOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeHvRbo1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EF51F00893;
	Wed, 10 Jun 2026 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781052023;
	bh=r2C275by+jKlR1Fdq7UgN01NONI8D6WcfVWSM4gOhTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XeHvRbo1+h+ud2RjcKhkrzummeJVjUbbsIo+LJ5ZGj0PedaH6WR/UZ7V/v+po2cWx
	 zhH+aE33hkNkd0sCOwuLmxRsW4qOJTDT2YpeOlOqH4DlmHPZOKDq01o9mBjv31Z8oW
	 SX6UfRazMlx9MXr4MeEet3v+FvT3WrC6SVFZ5/aJH/fhzZf0QmqRaRYf4tS/gUgaYm
	 f4Xpuua85wQJnk4HQGBdi8D4txPnssb1hHgT1277vfWIPuLNvTUmLL2SIcjwE8q5Ny
	 4EZctWv8UvQGvALdIzGILw6aWxt3KbGqylZ9foOhSXiPg3mKSI87LT1BrazpZK3u4Z
	 9lJcNo/cdFtfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A7F3930A0F;
	Wed, 10 Jun 2026 00:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 1/6] net: mana: Create separate EQs for each
 vPort
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105202111.2767403.16646247458376850244.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 00:40:21 +0000
References: <20260605005717.2059954-2-longli@microsoft.com>
In-Reply-To: <20260605005717.2059954-2-longli@microsoft.com>
To: Long Li <longli@microsoft.com>
Cc: kotaranov@microsoft.com, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, jgg@ziepe.ca,
 leon@kernel.org, haiyangz@microsoft.com, kys@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, shradhagupta@linux.microsoft.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-11574-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@microsoft.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: CBA84664FFC

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 17:57:10 -0700 you wrote:
> To prepare for assigning vPorts to dedicated MSI-X vectors, remove EQ
> sharing among the vPorts and create dedicated EQs for each vPort.
> 
> Move the EQ definition from struct mana_context to struct mana_port_context
> and update related support functions. Export mana_create_eq() and
> mana_destroy_eq() for use by the MANA RDMA driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/6] net: mana: Create separate EQs for each vPort
    https://git.kernel.org/netdev/net-next/c/fa1a3b7bcd16
  - [net-next,v12,2/6] net: mana: Query device capabilities and configure MSI-X sharing for EQs
    https://git.kernel.org/netdev/net-next/c/d7c253d61488
  - [net-next,v12,3/6] net: mana: Introduce GIC context with refcounting for interrupt management
    https://git.kernel.org/netdev/net-next/c/d478457fc1b7
  - [net-next,v12,4/6] net: mana: Use GIC functions to allocate global EQs
    https://git.kernel.org/netdev/net-next/c/346c277d1db8
  - [net-next,v12,5/6] net: mana: Allocate interrupt context for each EQ when creating vPort
    https://git.kernel.org/netdev/net-next/c/487af6f5391e
  - [net-next,v12,6/6] RDMA/mana_ib: Allocate interrupt contexts on EQs
    https://git.kernel.org/netdev/net-next/c/062b2b051f14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



