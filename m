Return-Path: <linux-hyperv+bounces-9828-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEjCLLt1ymmB9AUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9828-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 15:08:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B22E35BA13
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 15:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B25AB3043D27
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A3B3D3310;
	Mon, 30 Mar 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di3bwdXn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF6B3CD8BB;
	Mon, 30 Mar 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875614; cv=none; b=LN6V++wiXEGQyM2TSL3eO9dsBaFuGJzhx+go8Byh+HiZOd+QalrVsFnUUQfTh75NMa9295SFykzD/1svoRikM8dJ7jWOKJJsnYxzcSwxXTtn1AX2qa6VPbyj8+QLolimX+zavxrBTeB/jNGBLF38Qu1HZMyFsWH9YuymVZ7i10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875614; c=relaxed/simple;
	bh=TtCvUVWKXPVAaTKLJLcMPLOfFxnwBsE36MNglsemq0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u9o7645as/jt1IlVKl148bMN17JtNonA+CgdH7K3EsthvNnnujdDPunks8Oh66uWNFip0l85D8ZmTMgMOQdf+y9KIjGGR3VOc++n6NCTfy05HBK5aL2iiKkV6bT7ZZC9LtvvOFu7Q1TdOpG9rEG3fVCXf+MKuryU3h9dIMjkKKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di3bwdXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B51C2BCB0;
	Mon, 30 Mar 2026 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774875613;
	bh=TtCvUVWKXPVAaTKLJLcMPLOfFxnwBsE36MNglsemq0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Di3bwdXn6V7ktE0AT0tyMDlwtOImbxe7ORVPDO45dSA1lQrHFE3peV4PtqdvhhtgL
	 DteL2GE+1pt+sBeWxAHM+YLi0Fh0BI23tOaNWLPKHi/Q+I08XEP75A7k7+Mt+ypLLK
	 WpDZnR/bU4/BUSHBA+AUKlzUwNRTz1b1OICYMD+In7wV8UOpkHS0Qy1+f1KDiOSVmG
	 qSpazTBF9qmeh2c6shCq/w/cpEeabJRY6g5v1afUIjIFxlnevEzg6YVOPy/kM/4qRx
	 Ofv8mkUhMwsYVoG9e0Yzz6gPjnl+uP4Z/RLzrpesXhgE5Fhp7XYwX+agn1VtWEiz+w
	 Z95qAqQONKlfw==
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Haiyang Zhang <haiyangz@microsoft.com>, 
 "K . Y . Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260325194100.1929056-1-longli@microsoft.com>
References: <20260325194100.1929056-1-longli@microsoft.com>
Subject: Re: [PATCH rdma v3] RDMA/mana_ib: Disable RX steering on RSS QP
 destroy
Message-Id: <177487561085.3814940.18401263006419819555.b4-ty@kernel.org>
Date: Mon, 30 Mar 2026 09:00:10 -0400
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9828-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.921];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B22E35BA13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 25 Mar 2026 12:40:57 -0700, Long Li wrote:
> When an RSS QP is destroyed (e.g. DPDK exit), mana_ib_destroy_qp_rss()
> destroys the RX WQ objects but does not disable vPort RX steering in
> firmware. This leaves stale steering configuration that still points to
> the destroyed RX objects.
> 
> If traffic continues to arrive (e.g. peer VM is still transmitting) and
> the VF interface is subsequently brought up (mana_open), the firmware
> may deliver completions using stale CQ IDs from the old RX objects.
> These CQ IDs can be reused by the ethernet driver for new TX CQs,
> causing RX completions to land on TX CQs:
> 
> [...]

Applied, thanks!

[1/1] RDMA/mana_ib: Disable RX steering on RSS QP destroy
      https://git.kernel.org/rdma/rdma/c/187c8bd5e571f5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


