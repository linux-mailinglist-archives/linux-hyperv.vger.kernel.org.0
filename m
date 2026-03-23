Return-Path: <linux-hyperv+bounces-9691-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J9/JSVEwWnpRwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9691-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 14:46:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 555882F33D9
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 14:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B3373029AAF
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 13:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A2B3ACF1C;
	Mon, 23 Mar 2026 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT932sFZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6C3ACA7E;
	Mon, 23 Mar 2026 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273422; cv=none; b=TU8Qf4R1A364Ff+yrqT4S80IamYxpTh3Gq0jzHYhzpw4QKG0f1Jf+DdY9UuLWfnsKPyb498uxdeGO9i7oHjyn9Z6DM9bgHj+brAAJP8CT1kAuqqwN+3Mq6KYKD1+2GKXLaqfjuf13SXby1YaoCWlfGIffwUZS+cO9gWrgkT2SnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273422; c=relaxed/simple;
	bh=2gAh46bnXzvKN6q6mWP0+u0mLvNWEaJFhp7X4eThwhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWBQO3R2PxcyE7yukIG86z1ECltk68PATvCnTRNO6tbO+K7AuDYow0qTomBDRBLzIv/63WoXOJ3uzfpQzWLj8SC1KMviaMAqM6JhiUTIU3H3FKcK2f68ipbm8Ue6M9m4gyBDZMKIRHG86VspRRiCgiSI2F1Fy9QBCDhXzo4Ij+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT932sFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D686C2BC9E;
	Mon, 23 Mar 2026 13:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273422;
	bh=2gAh46bnXzvKN6q6mWP0+u0mLvNWEaJFhp7X4eThwhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lT932sFZ6P+WjvzQJxtSB3mBmV7Bi0HTTmUnDI2cZAJctN37xBFvuohOAZsmzEDy5
	 dwAOtsDBkoG2L6WlKVj0gq3czZ0LjqA99WGdgEKbNL9Q7Hji3ZzX2Zl1vnY+HIAtgd
	 y5mlBuYotGtfMC5tZT5LRXaSPkRcksoazSQdZHFZfhPE8JtKhbbT8UK6BSH0QiOiKH
	 UNxlL3IqmU2ez0ksrndemuTWrtt9QDgj4VCTGzpV6sGYs5sNxpjFyFPmwTEQsHtwdl
	 tr+lB/MlROz0SoJ/I3DyIyud7FBgi+gfGkPmgmKbEMTfqOAFww0tASflfkg8E1WsQ2
	 E87QO3G4R8EpQ==
Date: Mon, 23 Mar 2026 13:43:37 +0000
From: Simon Horman <horms@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/6] net: mana: Per-vPort EQ and MSI-X
 interrupt management
Message-ID: <20260323134337.GA69756@horms.kernel.org>
References: <cover.1774049761.git.longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774049761.git.longli@microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9691-lists,linux-hyperv=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid]
X-Rspamd-Queue-Id: 555882F33D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:54:13PM -0700, Long Li wrote:
> This series adds per-vPort Event Queue (EQ) allocation and MSI-X interrupt
> management for the MANA driver. Previously, all vPorts shared a single set
> of EQs. This change enables dedicated EQs per vPort with support for both
> dedicated and shared MSI-X vector allocation modes.

...

Hi Long Li,

Unfortunately this series did not apply to net-next cleanly.
Which breaks our CI.

Please rebase and repost.

Thanks!

-- 
pw-bot: changes-requested

