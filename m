Return-Path: <linux-hyperv+bounces-11576-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8q/ZJQO7KGouIwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11576-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 03:16:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE065665285
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 03:16:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=V3i9UpCw;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11576-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11576-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7747D30D8235
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 01:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015C2417DE;
	Wed, 10 Jun 2026 01:10:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E21229B18;
	Wed, 10 Jun 2026 01:10:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053811; cv=none; b=J3+lPHDHQmMN3Lfs0oKJzBpj0E9iUVKu+1LEqUfaKR14KXiiWNUH3gAcFdIyvWQkkDzhymQ859M/FcKQrni0XvUpUc1WTVjnQJKhscGn0kmA66Mbf2rUUqpHZ+6eZoSf/ewzP+E650ODcTDaqbnROutnkxi9/HjP6hYlSDwyIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053811; c=relaxed/simple;
	bh=tBjRxMsvIYkhu3TLqVGi/Jwn+5CVWmSg5F9Pqg86ms0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DjGlEPypCW18Pc3ClLIJt2rf8RCoGi4LScylo9znmUugV4mByB3s+UVLeSAxoytg1W4HV0DWbxB/kSUcz9WokuVNSl3BY15kdcirgxekqbSo+FJ95lfj5hRjg4bqrp8NxvDVEZL6Ak0KtucYg0G4MLtXo+FNXOOSHctljA+F48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3i9UpCw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7C41F00893;
	Wed, 10 Jun 2026 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053810;
	bh=TRS0K2x+KhOyLAb3tWycsjifz1cV0PWzUeVzV2T5i7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V3i9UpCwdTAuGrFUGaoDvZ0YlBN+c98pcC0vYOhEaxHTmlZRikA7NAEeiFnZi+Nuj
	 JT9mwlPh//qEisc1QxUatPUijLuBv06rIULDBZK4sp1orZhnPQ9fTZ7FUWXSQCvCjw
	 P+DYiXFn8s3TmPbbEWG9cRhy6a4vpmKLWGtL32dfK1ivBUGyQWFzwq1Z3Oii1OgWL2
	 bTABkk01S8Y6qfUWZzqCwRcAUWos0zVvjhubRmfcCXNtP7fnA2IUmvdUrPZVJkBWy4
	 ecTxxPfjIYiSfUgTlgkACuBC7FB+0D0Qlx4ZOPdJS+ONy3aflxPDMS+1dS1J9ksmIF
	 Tx62cCH8yAT2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198133930A12;
	Wed, 10 Jun 2026 01:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: Cache MANA_QUERY_LINK_CONFIG
 result to
 avoid repeated HWC queries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105380863.2776665.17686730574089327914.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:10:08 +0000
References: <20260606133301.2180073-1-ernis@linux.microsoft.com>
In-Reply-To: <20260606133301.2180073-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org, dipayanroy@linux.microsoft.com,
 kees@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11576-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:ernis@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE065665285

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Jun 2026 06:32:55 -0700 you wrote:
> mana_query_link_cfg() sends an HWC command to firmware on every call,
> but the link speed and QoS values it returns only change when the
> driver explicitly calls mana_set_bw_clamp(). This function is called
> not only by userspace via ethtool get_link_ksettings, but also
> periodically by hv_netvsc through netvsc_get_link_ksettings and by
> the sysfs speed_show attribute via dev_attr_show, resulting in
> unnecessary HWC traffic every few minutes.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Cache MANA_QUERY_LINK_CONFIG result to avoid repeated HWC queries
    https://git.kernel.org/netdev/net-next/c/8e0ffcc926f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



