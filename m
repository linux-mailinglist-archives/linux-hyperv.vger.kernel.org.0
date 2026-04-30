Return-Path: <linux-hyperv+bounces-10509-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFoqGW2n8mlwtQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10509-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 02:50:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5549BD87
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 02:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEA36301917C
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DDD1DB356;
	Thu, 30 Apr 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSohxNtT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40BB194A6C;
	Thu, 30 Apr 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510250; cv=none; b=XPilwKW8PpSK8LRKY/4NjXczeffAMTsLkHzw7jYB6UhgkPRfxKBncS6ZhkaWUH2QQs7t+aoUn0gvbXsJFguUJggsDLQTUjEg2xaZikNEIO8Ftapu8DJF35knPEdb4VIbn1KK9YjHwwHpte51hg8JqTisCIp1t3fp+lFdSDiR+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510250; c=relaxed/simple;
	bh=8hTjZVo/XxRC+sG5sC75NA15k8DMUXtA+PqswM5vy+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K6zsl9b5iB/6Y2MAv1RW3i2sznr0wsgxp6INwp2KjbAWnzor5LumOPCKcenKTT2tTxeaJwFd6Wu4Iq4uhnDjXX0+pSVL7/i4lrlX2U0jMhwEXSrasy5RIBEt5y6cWAkVVRjwdtKiToHPS+mKdIUNnwAyyydFMovMgRw/zHtxDDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSohxNtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBE7C19425;
	Thu, 30 Apr 2026 00:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777510250;
	bh=8hTjZVo/XxRC+sG5sC75NA15k8DMUXtA+PqswM5vy+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gSohxNtTNK3/ENPdzslFmBoW9zlgVXTTWbzglFpCKe8Pa4Xte+oDZqHKDnX7YgN43
	 jbWqss93l6+3pA7vs5oh4P4z69Ct+CXbNjRTSx8AB+A7LddmO5JLfkAY42e3NshICV
	 Dsvxo9XI7Sp5o3+c0EVSUQqCiISCLtwN/cEnWCXGFbBxGgQ2J/xkEW+xD5NBeHIACn
	 j5gcLLURkNslPHVNhyakvBXz/xP7ovEOUve53DahJgs5lLQsePyeUzNWi5HyNbwDhu
	 UQD/E7IViCEc4dQgSvtUKrcVlnP1KvG718lKeWN0mW/1HXF0wQpVgcWNQQd+DY5GdG
	 W2CBK3XqpZ37A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FDC3809A33;
	Thu, 30 Apr 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hv_sock: fix ARM64 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751020555.2241449.18420756857338539292.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 00:50:05 +0000
References: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: netdev@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mhklinux@outlook.com,
 himadrispandya@gmail.com, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: E4A5549BD87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,redhat.com,davemloft.net,google.com,outlook.com,gmail.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-10509-lists,linux-hyperv=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 08:53:39 -0400 you wrote:
> VMBUS ring buffers must be page aligned. Therefore, the current value of
> 24K presents a challenge on ARM64 kernels (with 64K pages). So, use
> VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
> hold all of the relevant data.
> 
> Cc: stable@vger.kernel.org
> Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
> Tested-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> 
> [...]

Here is the summary with links:
  - hv_sock: fix ARM64 support
    https://git.kernel.org/netdev/net/c/b31681206e3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



