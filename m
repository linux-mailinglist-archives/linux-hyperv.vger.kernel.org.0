Return-Path: <linux-hyperv+bounces-9809-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOCdLDHnxWlTDQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9809-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 03:10:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7DB33E188
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 03:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17FB5300FECC
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 02:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403833264F3;
	Fri, 27 Mar 2026 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi06MZQF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6AD318B9C;
	Fri, 27 Mar 2026 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577420; cv=none; b=RuvRmuh7IqYnbACJw+qejwXg19v8WaOJ1hR9R6y3c/KIdYt/shc5SiE0rGHcQmCGbX89/5azPuOHzw53/w4Mv8UFy+1QSaFm8C5bezi2v4MRp7bN4S9BVscjyXNf1iUJjidehiFhtktxxlnIRB2HBu+wbMtCTKcNxUG+ZEo+Glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577420; c=relaxed/simple;
	bh=XL2XaiBFzO/RZQtR+6VxjzdTf0vKl3oagcj/NyvFaCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TOJLi0pNXK3KkKg9fNnjtJl4J9mln/3hJRQRnYroVBTG3ClPrWmk/hIiE/VvgfCAKOmT2EBsSG/mP/PWOiFY9pH6Bi3ZtagiGR+BM6FNu5iO5nItRoi8j2hwPWO6Jg9RzULKq3ANd0ZiulRYkjnPP5d0ztJSdiHzbfsD8ipIfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi06MZQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCAFC116C6;
	Fri, 27 Mar 2026 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774577419;
	bh=XL2XaiBFzO/RZQtR+6VxjzdTf0vKl3oagcj/NyvFaCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fi06MZQFzo1TMjvusqFERQeAbZ1Md7XigHXnhwPmpIgPyR1ypjJh6FirpHB/sHTkC
	 MeqxAlp5pAHTeYhBbSQrhE3Zr3PVdcY7FTvPSJi66CcAF8DNQctCHfMBE+e48WDkTz
	 7IY1bJh9pfV4y4qSuL2Zvu4YoSyvdn4eHtrMmfTy5zQasFlkNT+Zjj1k+Pea7H51ER
	 yJEvJP0HjLVBiVDrSXl9rkR5h7fcP41vajrT/XuACbWMMrtgdzIyFoEvcv206SF2KU
	 NVS4o6hwGoUaq/cuY8dZwmRUE3hSxsKUoDhWrYNe1Ami5rwkmMoM8apfeALp8HQ0f2
	 WPFT0pFNYunWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD263809A07;
	Fri, 27 Mar 2026 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v2] net: mana: Fix RX skb truesize accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457740604.3263687.14878454384764628197.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 02:10:06 +0000
References: 
 <acLUhLpLum6qrD/N@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: 
 <acLUhLpLum6qrD/N@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com,
 dipayanroy@microsoft.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9809-lists,linux-hyperv=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[25];
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
X-Rspamd-Queue-Id: 1F7DB33E188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 11:14:28 -0700 you wrote:
> MANA passes rxq->alloc_size to napi_build_skb() for all RX buffers.
> It is correct for fragment-backed RX buffers, where alloc_size matches
> the actual backing allocation used for each packet buffer. However, in
> the non-fragment RX path mana allocates a full page, or a higher-order
> page, per RX buffer. In that case alloc_size only reflects the usable
> packet area and not the actual backing memory.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mana: Fix RX skb truesize accounting
    https://git.kernel.org/netdev/net/c/f73896b4197e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



