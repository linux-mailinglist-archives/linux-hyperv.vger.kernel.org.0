Return-Path: <linux-hyperv+bounces-9810-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD8+Ohf3xWkjEwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9810-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 04:18:47 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E95133EB9D
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 04:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4F193011C9E
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 03:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C22C11ED;
	Fri, 27 Mar 2026 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnl6ldck"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078515A86D;
	Fri, 27 Mar 2026 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581523; cv=none; b=BflpHOIzaGPOQixodz/DVhydfjYik1yQFeNo4jvRcW4JUK0RszV9QChM1zQamta8ufkhPHPY9uXKPPjBCVR++/50E3dY1uGQwCm6i9zPd2jKnAs0n6dFAw09Vy6BYgp48bRheL8XoWvXvXyQgvAGuHy8v6zgRxL2oWVYoFdDHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581523; c=relaxed/simple;
	bh=4o3vkP9OMGwxwIJArEgPS7h9NEih+KsevhqFz1wSHY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueymIkTFOWnsTVE7gWUHjomW52eNvpBU6azM1dN6SHXeWUN5aVLKC05C/5ZtHz7TWReYGLvmdqUmDeBGDT0OYn3VBKuy7oliH7rIZtY5XxnmJ2WB7d9VN1x9WQvHqGJrr0Co706DfvOh60TJubfUpHI77cElsbCZUDysYhnnS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tnl6ldck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF97C116C6;
	Fri, 27 Mar 2026 03:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774581523;
	bh=4o3vkP9OMGwxwIJArEgPS7h9NEih+KsevhqFz1wSHY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tnl6ldckXuQZq4kxsRIMFYMpVnctQA4xcZsfGzIoQhKKekRk68UqyzLs0B98juB1Y
	 Xzbs1CY5JqCOwqJUgML76wRo3VIxawJk0V9O+3QXwcCap4XRsk9d+FcYYh0v7Jtkgw
	 n3O1yyACqXlV9r2TdCHT+cKkfGZRBuUGkNvK+lob7qaWOP0iaBFNiWzfHvIhfgT5rV
	 m9kCcFTiz+reJpnMoT3MlObYUTOLGlGAVXT84Fc/CXCx7Dj5iWCINtPDzmaDvcvJHB
	 PdwugxRuhD3+ttiuIJ0kEIK1NRwrxpC3DbiQQ+4J+ze8VC/BjZobZDxPWVC46DWGiE
	 ay+FXIdxuiFhA==
Date: Thu, 26 Mar 2026 20:18:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@microsoft.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Set default number of queues to
 16
Message-ID: <20260326201841.3b7e5b78@kernel.org>
In-Reply-To: <20260323194925.1766385-1-longli@microsoft.com>
References: <20260323194925.1766385-1-longli@microsoft.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9810-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E95133EB9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 12:49:25 -0700 Long Li wrote:
> Set the default number of queues per vPort to MANA_DEF_NUM_QUEUES (16),
> as 16 queues can achieve optimal throughput for typical workloads. The
> actual number of queues may be lower if it exceeds the hardware reported
> limit. Users can increase the number of queues up to max_queues via
> ethtool if needed.

Sorry we are a bit backlogged I didn't spot this in time (read: I'm
planning to revert this unless proper explanation is provided)

Could you explain why not use netif_get_num_default_rss_queues() ?
Having local driver innovations is a major PITA for users who deal
with heterogeneous envs.

