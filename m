Return-Path: <linux-hyperv+bounces-9414-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCBYGtqftWn42gAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9414-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Mar 2026 18:50:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A6928E333
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Mar 2026 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD8083009F39
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Mar 2026 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017FE257851;
	Sat, 14 Mar 2026 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl+qu4JK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D052B2772D;
	Sat, 14 Mar 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510610; cv=none; b=MXczKdhjSM6G9sOAL2ogHh+nbXsszp5Qye5WaNU+SOJOsK6DPzR1UHkhYrLb9upWMxIpcqlJKDPrmY/kv11SYnfluWiOoVr8Z+wDqzC2bFlTmPzM01tfTxug5mbgsgaBppEamwlw6EAUW/H4bnKP2aO7UBC9i7LbrBTCP+V7yeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510610; c=relaxed/simple;
	bh=/SkLwC45ykhUVch9O/ueyDZThc4uPuUMi8ZkCXQYA6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BJj9dHdcv0JGKAi47h9mQcGtGMMfKh2AwG1B74rwwYIOrsxVWJ4aBaQxwXZga/E6kA+Jeqz9Ul6y9gpyZYcKQdDTXfos0wbSTeesUk7Xj3jzWQO8xU1AMDdSQroBeNSUA9eOc+KiDJ1cFhYCRlqCcszl/XbGcctZ2U9Vty66p1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl+qu4JK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67272C116C6;
	Sat, 14 Mar 2026 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773510610;
	bh=/SkLwC45ykhUVch9O/ueyDZThc4uPuUMi8ZkCXQYA6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nl+qu4JK/PnB8ww9lJSxC5jbU+J+clnZhFuvDE8sxeoceap6Nf/VVtUVn4n87gtNy
	 xjBZUfX3eeyRhaUGSsRgcrMaC3WF+FuMl+NwNmQAkr3GUOPWBzN3rmRGrsussucTFP
	 8Q2002LUtUu15pFIXbH+97eFVsCUnyW1HVO3fr1Ugmk0mgMeOVBrHyPu+LMxViQVK+
	 1oWeWBFyI62RyOmHhR3wr/CXZ7+hje+HJk7aqNGj0n2ttDibB3kVmSLvF/M5JsSAIf
	 kohmJb31NgnI8yKBTgv25A14nee2pCtwacaRH1lU4z37YOHkRc/EeQ04fzcyXYCOWY
	 6BeBA56aT1pbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0B63808200;
	Sat, 14 Mar 2026 17:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v2] net: mana: fix use-after-free in
 mana_hwc_destroy_channel() by reordering teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177351060454.1744213.12265570325203026685.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 17:50:04 +0000
References: 
 <abHA3AjNtqa1nx9k@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: 
 <abHA3AjNtqa1nx9k@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, dipayanroy@microsoft.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9414-lists,linux-hyperv=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61A6928E333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 12:22:04 -0700 you wrote:
> A potential race condition exists in mana_hwc_destroy_channel() where
> hwc->caller_ctx is freed before the HWC's Completion Queue (CQ) and
> Event Queue (EQ) are destroyed. This allows an in-flight CQ interrupt
> handler to dereference freed memory, leading to a use-after-free or
> NULL pointer dereference in mana_hwc_handle_resp().
> 
> mana_smc_teardown_hwc() signals the hardware to stop but does not
> synchronize against IRQ handlers already executing on other CPUs. The
> IRQ synchronization only happens in mana_hwc_destroy_cq() via
> mana_gd_destroy_eq() -> mana_gd_deregister_irq(). Since this runs
> after kfree(hwc->caller_ctx), a concurrent mana_hwc_rx_event_handler()
> can dereference freed caller_ctx (and rxq->msg_buf) in
> mana_hwc_handle_resp().
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mana: fix use-after-free in mana_hwc_destroy_channel() by reordering teardown
    https://git.kernel.org/netdev/net/c/fa103fc8f569

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



