Return-Path: <linux-hyperv+bounces-9822-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKjzKEgZx2mXSwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9822-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 00:56:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F210034C952
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 00:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84DD93030B11
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 23:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A5C3451C1;
	Fri, 27 Mar 2026 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qU9Yuwlc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB234216C;
	Fri, 27 Mar 2026 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774655718; cv=none; b=UN99kkfa6stEs4eDHwltOAWvkzzKjr2+eKuSQ8DLdF8MVqoGHp7J7a+dNhDOGbNOZj56I9iFw5bG/WDkvDIQrjFo0LzBUfJ7+CnCHmUlai9wWvQCUP5mTcaGuhu/YX+7pLzhx+ycYvcDOISFcBuUSKAWslV5BiHUwc5H3hFh0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774655718; c=relaxed/simple;
	bh=RnVNM/WM/sXq1Qxj0l9dY0/aSg/+qWWVxkrRCD9kPLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKJjmDNz+jGMR6CQdVW4FOYkEoGUzh6fXLUL0JkmY0/lcUaxt+0+ckOu3iPsB3+hmsPEgufN7kAIl7wSwwJ7gPKt3eZGjs207mHepb139J+u3F0zM+VCCC6PwRY88UJj4OjRdnmc+eqLI17ToVz0KTHSwzE2U6W79hX+ATyXxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qU9Yuwlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC64C19423;
	Fri, 27 Mar 2026 23:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774655718;
	bh=RnVNM/WM/sXq1Qxj0l9dY0/aSg/+qWWVxkrRCD9kPLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qU9YuwlcGd76wQVMeMuEYfELfWK+jFLsKwkSYtic4A8rDO3NKlImWzEFsTGZvPzvJ
	 6MfsmVgLW5lySjPdhsBmHeTY3oIc0jM7m5bHS5V1VrN6fUHgUvvK5mbuidkH3O7HPs
	 HUCDiqN7QldIZ3zyZBNAPF+h87YETggU4s9QmqFTygL+CPUxf+SjIKbqEMAZb8Fd0a
	 grHFPSMJxoQQqu/h1wLaNAsjYdubmCMAE29ULc4wtNGVY89UISlmCHbiGTTmAk/av3
	 IDTnlCpG4T7I8tRAkAe+2GUF6n/hz6/vOQWXIjfqfDHEhS0WtDBAP4nRaESBV1WiIm
	 UuX2wBSZ6Frqg==
Date: Fri, 27 Mar 2026 16:55:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@microsoft.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Simon Horman
 <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Set default
 number of queues to 16
Message-ID: <20260327165512.08f7b6f9@kernel.org>
In-Reply-To: <SA1PR21MB668314B1AF002E40B379F1C0CE57A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260323194925.1766385-1-longli@microsoft.com>
	<20260326201841.3b7e5b78@kernel.org>
	<SA1PR21MB668314B1AF002E40B379F1C0CE57A@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9822-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F210034C952
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 04:00:31 +0000 Long Li wrote:
>   We considered netif_get_num_default_rss_queues() but chose a fixed default based on our performance testing. On Azure VMs, typical
>   workloads plateau at around 16 queues - adding more queues beyond that doesn't improve throughput but increases memory usage and
>   interrupt overhead.
> 
>   netif_get_num_default_rss_queues() would return 32-64 on large VMs (64-128 vCPUs), which wastes resources without benefit.
> 
>   That said, I agree that completely ignoring the core-based heuristic isn't ideal for consistency. One option is to use
>   netif_get_num_default_rss_queues() but clamp it to a maximum of MANA_DEF_NUM_QUEUES (16), so small VMs still get enough queues and
>   large VMs don't over-allocate. Something like:
> 
>    apc->num_queues = min(netif_get_num_default_rss_queues(), MANA_DEF_NUM_QUEUES);
>    apc->num_queues = min(apc->num_queues, gc->max_num_queues);
> 
>   For reference, it seems mlx4 does something similar - it caps at DEF_RX_RINGS (16) regardless of core count.

mlx4 is a bit ancient. And mlx5 does the wrong thing, which is why 
I'm so sensitive to this issue :(

>   Do you want me to send a v2?

Please send a follow up, let's leave this patch be and make an
incremental change. 

Thanks!

