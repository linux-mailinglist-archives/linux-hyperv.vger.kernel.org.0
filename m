Return-Path: <linux-hyperv+bounces-8994-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCFRHBK8n2ktdgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8994-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 04:20:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D79441A0746
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 04:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A30D530763E7
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 03:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C55387585;
	Thu, 26 Feb 2026 03:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwMZwUbx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78638757B;
	Thu, 26 Feb 2026 03:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076010; cv=none; b=KZFjxIEq6df1Q4GD1VUdqZz1PYuwSEoUZjY9llWyG3uTnWcjieBAQFrDlgWiDwQcPDUvIXrISi4O0tqR62hB269xPa62Uz67pKXGyKH7dTPqDMHDvQvg+GGPpCW7uP054zQSSVV0EXxB+gQPZZacfW7qYSnTTkV0vAqbXKrjCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076010; c=relaxed/simple;
	bh=x+hXaKRyH3CbhBqsiU+WtoQDutqA45cAk54/G6S2Khw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WQNbCNUrLlp3/j7Ge2xa7mFNbO+SWeXBh55xohtFrwtJ+7ixztR684a+LBnM7o3gVCX5OXDxOPorTIG0fcVu+D9XCaI/FWlan/aJxX5hoSsYV8w4GlzuTHRHEpf7Ag31HDudPReQW/L2LCRB5Q70LdxhBbRBHpNQiL9TLAQvnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwMZwUbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89016C2BC86;
	Thu, 26 Feb 2026 03:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772076009;
	bh=x+hXaKRyH3CbhBqsiU+WtoQDutqA45cAk54/G6S2Khw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UwMZwUbxfvNfgNu88FlrWqB2vsISVFGHadfXT8QJMh/XzoHws51Ca2d+DLXcPeUa9
	 ZjKuxH2+31auNn4xzKgb2UjuMzHqaRM85J8FlA6wcv6577dF/ZZ7r0EfxNsqZhUVMq
	 THmj12BC6cx2N6aJr3ovEBvnmTkVLQwqW3g2np7rE6OI9v1rjBEvD4fPxMex++r1rG
	 nN+DXh7IpjFN12TPDA/WNR0LRRiAS9z84gtGB9T549rKPRd30eupn7MD54nZaWen8D
	 YEEX5s8GS6m8442ClKsydlpknQ5m6M9JEdNSNyL+U875gsIzeyW2N/4L7oGySInFZW
	 01D9qyy/ysUYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEB7380A94B;
	Thu, 26 Feb 2026 03:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mana: Fix double destroy_workqueue on service
 rescan PCI path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207601404.1018003.17798164390456983637.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:20:14 +0000
References: 
 <aZ2bzL64NagfyHpg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: 
 <aZ2bzL64NagfyHpg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dipayanroy@microsoft.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8994-lists,linux-hyperv=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D79441A0746
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 04:38:36 -0800 you wrote:
> While testing corner cases in the driver, a use-after-free crash
> was found on the service rescan PCI path.
> 
> When mana_serv_reset() calls mana_gd_suspend(), mana_gd_cleanup()
> destroys gc->service_wq. If the subsequent mana_gd_resume() fails
> with -ETIMEDOUT or -EPROTO, the code falls through to
> mana_serv_rescan() which triggers pci_stop_and_remove_bus_device().
> This invokes the PCI .remove callback (mana_gd_remove), which calls
> mana_gd_cleanup() a second time, attempting to destroy the already-
> freed workqueue. Fix this by NULL-checking gc->service_wq in
> mana_gd_cleanup() and setting it to NULL after destruction.
> 
> [...]

Here is the summary with links:
  - [net] net: mana: Fix double destroy_workqueue on service rescan PCI path
    https://git.kernel.org/netdev/net/c/f975a0955276

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



