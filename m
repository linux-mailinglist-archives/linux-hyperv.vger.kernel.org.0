Return-Path: <linux-hyperv+bounces-9824-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM3BM6VSx2nfVQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9824-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 05:01:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7C034D37E
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 05:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37EDB30805CF
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 04:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FDF35505F;
	Sat, 28 Mar 2026 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c42uO/92"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF234F255;
	Sat, 28 Mar 2026 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670432; cv=none; b=CX1lAW5C1KzuDeRIidhQKF/nDvF221R2N/jEcL69U0Uram5/zoDJXPRBep1az8B5IJrjRjOeiUtdt3lfvwgdRJhRa1EfIPTny/tqlahzRoZGGY7b6gzvPp7PbcCRPoJg6UPlvns7xblVdJYDQ9eUA7386UJ72dZbIwifI3qUHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670432; c=relaxed/simple;
	bh=5OavXk7JxaIUB9Kyb9Zn7YBOxMND6OSoJ30alypKJTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HSv8hRV6EDZ8JOS8+olZCFRa6qUiBZrP4k/Ct9+crkyBPLvnxBgvTzpYW65i3NPUjs615/qBUWFJ1FEMkEsG+5yBNFUHq707ovLdnx2IuPteCIQa8UBIY/F091+hLnbHkYUAaGE3YjYfCTNvRgvj/8YBFj0/tbxPHya1ihRIvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c42uO/92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6A2C4CEF7;
	Sat, 28 Mar 2026 04:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774670431;
	bh=5OavXk7JxaIUB9Kyb9Zn7YBOxMND6OSoJ30alypKJTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c42uO/92Fv9bp+Nmdly2Ezl6dyUWedZSlHL1Wu3Mbzri9x8fsuLsqpeJyYxMHq35e
	 7WpJTdUdS/oZOOqk64ms1WqJXm4BuOa3mj8v0MoMeUCtSQvkT2paHWipNr0anHomij
	 985Y3OBGfERzbNm6FYliea3vbLOjfGYWiVd6P1TJgJfgyWycETioQcHo5HzzdkY4Ru
	 xHlOVU3AjpsaLvFDbHxrnYgg3DTqWzjLhOIEhOYWKyDIf+Ur/fTlbQ180yw2AGdMmo
	 NSG1AycjsarAXHc2vOAPb6NfKT08M7nj/JKUdKnkm5y5IKS4u6NvKn0jJMB6Wi6J1K
	 nxw0ECbq5qE2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9ECD3930181;
	Sat, 28 Mar 2026 04:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: Use at least SZ_4K in doorbell ID
 range check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177467041728.4173055.1408491076465694587.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 04:00:17 +0000
References: <20260325180423.1923060-1-ernis@linux.microsoft.com>
In-Reply-To: <20260325180423.1923060-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com, kotaranov@microsoft.com,
 dipayanroy@linux.microsoft.com, yury.norov@gmail.com, kees@kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9824-lists,linux-hyperv=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A7C034D37E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Mar 2026 11:04:17 -0700 you wrote:
> mana_gd_ring_doorbell() accesses offsets up to DOORBELL_OFFSET_EQ
> (0xFF8) + 8 bytes = 4KB within each doorbell page. A db_page_size
> smaller than SZ_4K is fundamentally incompatible with the driver:
> doorbell pages would overlap and the device cannot function correctly.
> 
> Validate db_page_size at the source and fail the
> probe early if the value is below SZ_4K. This ensures the doorbell ID
> range check in mana_gd_register_device() can rely on db_page_size
> being valid.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Use at least SZ_4K in doorbell ID range check
    https://git.kernel.org/netdev/net-next/c/fb4b4a05aeeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



