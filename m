Return-Path: <linux-hyperv+bounces-9747-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA6gKL1hw2m1qQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9747-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 05:17:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050F431F943
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 05:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B25E5311D870
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 04:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3122F690F;
	Wed, 25 Mar 2026 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0YbeHNv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731D2F12D4;
	Wed, 25 Mar 2026 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411821; cv=none; b=SXqeUKmbHSAvr8bMvZabssqLjpujpMLCoZmmagfZaQLkQwLGKFKjH6U73HQXAxOyfQzV/K777xmosH4jaW4aHlrvjGnQCcXfA3FLdv0+HIeMu9UiuKvkhp1kdOACV+gTccLaoP8xpPFpV9uFiSYEZKoupuGlw/BLFOLafzutXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411821; c=relaxed/simple;
	bh=csrBj4PEHhkzLj9KLOtGYFT5RYKttSLGF60SAsZJgc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dp0evh9uoywOir0/dz1t339rzerg131M7j868FjkGyQysmHsjPzWw4LnpW1M1wtqwY0ysNmNgKEKvC8TynEa8frJCOgMmF+HwAE/OrnUVuNPraQZWS2ULgq1jdQHSIiNxsCU7XjhnV2Lv/pWHfWssAkulPDlAyV9wmfwgzGysYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0YbeHNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A64C4CEF7;
	Wed, 25 Mar 2026 04:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774411821;
	bh=csrBj4PEHhkzLj9KLOtGYFT5RYKttSLGF60SAsZJgc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N0YbeHNvorPvE5GPJWNwSp3lDkDVHDhsMrhfAe99kHZAwO7OSKeTVRIObRqE11YRZ
	 UOaKcScCnBHgnn5FFaDkStpAlXq8djRoX9B0hdz2n/wtktpdxCCt2GY7m64pZaNw1o
	 ZArzlK0LMYmSwgfWp1umlJ/S+olET5zMO470gUCeXQeUvLjNoBgm6oYsv2tBqihqJ3
	 opGMR+SlK8guShg38AERweut+u0An/t2i++umCe3d4iu2lxZqAytVby2eIaxxXh0ku
	 LYkqQF0NVxYUHRxLgHimZ4lccNKnDBujKHLc1Le9ZWItSf3aAfb+9+2dwoW7poBF3g
	 g3qgh9wd8FQkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FE93808203;
	Wed, 25 Mar 2026 04:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PPATCH net v3] net: mana: fix use-after-free in add_adev() error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177441180853.1422230.5922345720060434501.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 04:10:08 +0000
References: <20260323165730.945365-1-lgs201920130244@gmail.com>
In-Reply-To: <20260323165730.945365-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 gargaditya@linux.microsoft.com, shirazsaleem@microsoft.com, kees@kernel.org,
 leon@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9747-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 050F431F943
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 00:57:30 +0800 you wrote:
> If auxiliary_device_add() fails, add_adev() jumps to add_fail and calls
> auxiliary_device_uninit(adev).
> 
> The auxiliary device has its release callback set to adev_release(),
> which frees the containing struct mana_adev. Since adev is embedded in
> struct mana_adev, the subsequent fall-through to init_fail and access
> to adev->id may result in a use-after-free.
> 
> [...]

Here is the summary with links:
  - [PPATCH,net,v3] net: mana: fix use-after-free in add_adev() error path
    https://git.kernel.org/netdev/net/c/c4ea7d8907cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



