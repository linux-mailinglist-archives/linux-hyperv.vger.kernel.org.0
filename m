Return-Path: <linux-hyperv+bounces-11690-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TPc3JIDlPWou7wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11690-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 04:35:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B26C9D30
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 04:35:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TSvPnq65;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11690-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11690-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A980430EB4AB
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 02:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34A631A555;
	Fri, 26 Jun 2026 02:32:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B631F31619C;
	Fri, 26 Jun 2026 02:31:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441120; cv=none; b=pAumdknMnPBxMDoo2FLdcD21bdDdb+qYgQ2UETmD1xa27Zs4ND1kem42vAhfRIc3hkvFx1JPsG0apDpJJKjNaxLeXjNx7sKppKuZqjX0/Ku4vM6i1O9Nt/6IvV+hVOdpeqbCaEfOJ2xBtpnv7uIuiO4+FopsB3nlvDtTbi148pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441120; c=relaxed/simple;
	bh=Cu+8ULxgnfPyxokxyZMw5c5021izxVS9EdEkDIfmAzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jjTBLXCAmup1mfwO5KgBInkfRBfyOe7dV3FG242KcFjMgH5dacu/gpFnVi/w0Qwc0ZuqqUWhshYpjtHtbs2UczEld8efrAIXTvOMeJiele/fNgSdr8tICTl4suoSPzvV52RaPpVryjaXudD1jo1AD+fdCyQgxrtwEypVuiRgkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSvPnq65; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEB31F000E9;
	Fri, 26 Jun 2026 02:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782441119;
	bh=8y1WmmNAeCzXid8EtBZSYlMy9wcWQjR0ZVlBu3F3G+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TSvPnq65R5BLi1BlMnwfEIPaaXv008iQkAeDOGvqztjDg2Fd/pbIBjDtovtOZBCp2
	 0cFX37NwxAM+ZxwIJY8XAzyN+Xg28ztB8Fu5tahOWdRyUItN6JECzNHwVjN083T7NV
	 ubF6FpJgABuOOJ9lC8TR/atgESb5MUahDJXfdcJwp7WG3XtZg2Uw6Fn0wROTa24XS7
	 6CAzmIf2YBSYBwoPfCvcJJ5GpmfjP7g+3HINgNfcVSvCQrOo52CrvDDOA9eEkdSaNf
	 +hmj9Ssxug6MlT1ybGm9+oi3s0IeJmJWfB8jj7spcexXryEXxld1z0MsmGM7hAQczJ
	 0ATe0ak0+2nMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A1339389C4;
	Fri, 26 Jun 2026 02:31:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethtool: keep rtnl_lock for ops using
 ethtool_op_get_link()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178244110650.3816447.9959963102868412586.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 02:31:46 +0000
References: <20260624190439.2521219-1-kuba@kernel.org>
In-Reply-To: <20260624190439.2521219-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 leitao@debian.org, joshwash@google.com, hramamurthy@google.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, alexanderduyck@fb.com,
 kernel-team@meta.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 jordanrhee@google.com, jacob.e.keller@intel.com, nktgrg@google.com,
 debarghyak@google.com, mohsin.bashr@gmail.com, ernis@linux.microsoft.com,
 sdf@fomichev.me, gal@nvidia.com, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,debian.org,intel.com,nvidia.com,fb.com,meta.com,microsoft.com,gmail.com,linux.microsoft.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11690-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:leitao@debian.org,m:joshwash@google.com,m:hramamurthy@google.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:alexanderduyck@fb.com,m:kernel-team@meta.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:jordanrhee@google.com,m:jacob.e.keller@intel.com,m:nktgrg@google.com,m:debarghyak@google.com,m:mohsin.bashr@gmail.com,m:ernis@linux.microsoft.com,m:sdf@fomichev.me,m:gal@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 042B26C9D30

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 12:04:39 -0700 you wrote:
> Breno reports following splats on mlx5:
> 
>   RTNL: assertion failed at net/core/dev.c (2241)
>   WARNING: net/core/dev.c:2241 at netif_state_change+0xed/0x130, CPU#5: ethtool/1335
>   RIP: 0010:netif_state_change+0xf9/0x130
>   Call Trace:
>     <TASK>
>      __linkwatch_sync_dev+0xea/0x120
>      ethtool_op_get_link+0xe/0x20
>      __ethtool_get_link+0x26/0x40
>      linkstate_prepare_data+0x51/0x200
>      ethnl_default_doit+0x213/0x470
>      genl_family_rcv_msg_doit+0xdd/0x110
> 
> [...]

Here is the summary with links:
  - [net] net: ethtool: keep rtnl_lock for ops using ethtool_op_get_link()
    https://git.kernel.org/netdev/net/c/1105ef941c1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



