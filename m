Return-Path: <linux-hyperv+bounces-11159-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEIsB4ChEGpuawYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11159-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 20:33:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B151B5B9188
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 20:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BC3C3005D09
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 18:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88E236D9EC;
	Fri, 22 May 2026 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfIvkdJi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6E2F1FDE;
	Fri, 22 May 2026 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474597; cv=none; b=ly1dQlvLoc4y2WGpYv7OgZ/FRTW2tL0Guy2Nb1xhUpySF71RlcteC4UoTVG6yK80A5s4ayPot4SKXokWg7AHN9s51BcLUwM+lpmFIwCyims9xmjqqPEBkEegr2I57xZB7JSfbPEOdHlV5YrMfGn9i+5DPjn17ICG5X14FcpNi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474597; c=relaxed/simple;
	bh=5/AhXF9kGVhULDok/+rh/JjfPACpT4ecZvgjeEKRBIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GOeq2KdjlvbJ8c9pUdCNeyJ3wXFPDEUIuvn2gVR1yHlC7yMBeTzJWb6Lfw/TkaqJpCy2HMhzi3OQqt4Ho4R9diHNxdqSlYNl2Of9FQ15++dfQeQ+FxAljBD9CRfbLjzmOQjEvsL7HuJr718htowmRmhb7EpoPxENLd3a8J/XfZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfIvkdJi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406351F000E9;
	Fri, 22 May 2026 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779474596;
	bh=o8IBLuCs7YOJ3hdmxOMAExhPHKvXLTD+QeFBC0POzSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YfIvkdJi7cgsO3LpTKzl01+X3T1RD/v8HXscwZOe99Cy/0vW0rSevxv46G9+fylPX
	 TVspgAhcerPGGr+LoM8c8tnd0WRnVdr90loef39n7lMg6xuikTObFs7VziqNKwWmfR
	 X+Gc34lAYlT8/gWjgrtQPSr5vrgqu4MlYRNKw/UPJ/yb39642samKAzxPkwF8F519d
	 PEGhu9XTCyyxBKo0ss5yEG0Jbmnz2/Y3TvgMTF2rE6LvnXfBuEZ+bAmhYINwX1Pr5Q
	 2JjvwlLGA2N0CKzudI4ToKoO6WxjOLK+beL2JQjY25PfvfGfOhF5K/F9AdTN1GANiV
	 6JJ3ftimjX3Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B683930FB9;
	Fri, 22 May 2026 18:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vsock: keep poll shutdown state consistent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177947460540.1324219.4145730624585924301.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 18:30:05 +0000
References: <20260519165636.62542-1-ziyuzhang201@gmail.com>
In-Reply-To: <20260519165636.62542-1-ziyuzhang201@gmail.com>
To: Ziyu Zhang <ziyuzhang201@gmail.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, acking@vmware.com,
 georgezhang@vmware.com, dtor@vmware.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, stefanha@redhat.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, baijiaju1990@gmail.com,
 r33s3n6@gmail.com, gality369@gmail.com, zhenghaoran154@gmail.com,
 hanguidong02@gmail.com, zzzccc427@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,vmware.com,microsoft.com,linux.alibaba.com,broadcom.com,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-11159-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B151B5B9188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 00:56:36 +0800 you wrote:
> vsock_poll() reads vsk->peer_shutdown before taking the socket lock
> to set EPOLLHUP and EPOLLRDHUP, then reads it again after taking
> the lock to report EOF readability. A shutdown packet can update
> peer_shutdown while poll is waiting for the lock, so one poll invocation
> can report EOF readability without the corresponding HUP/RDHUP bits.
> 
> For connectible sockets, take one peer_shutdown snapshot after
> lock_sock() and use it for all peer-shutdown-derived poll bits. For
> datagram sockets, which do not take lock_sock() in poll(), take one
> lockless READ_ONCE() snapshot and pair it with WRITE_ONCE() on the
> writer side.
> 
> [...]

Here is the summary with links:
  - [net,v2] vsock: keep poll shutdown state consistent
    https://git.kernel.org/netdev/net/c/aae9d8a5528b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



