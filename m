Return-Path: <linux-hyperv+bounces-9769-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOY1DFEWxGlAwQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9769-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 18:07:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C13299BB
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 18:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C4730A8FF3
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49183FB077;
	Wed, 25 Mar 2026 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORqQBH67"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679BC3FB06A;
	Wed, 25 Mar 2026 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457812; cv=none; b=YxlUyJoKRvKmct8dm/xWBDdCQxwBy3ljtze/Spykrhe42fyAS4piQxwdqLpA7mOrISgkVacpRJyIQXu7dfroGc2IOI1SMaq/jCsPg6aONWwEMQbeHaLIxyz7CxTnj98TLpHVEEfwdjToyzIlZeusUn0tw0iEKSYjva7vv1mSBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457812; c=relaxed/simple;
	bh=iHig3EMWOwk1Y/dQ6/HMGDXIACDY9jMTV1RDez9gbZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX8f5bjrYGsPao1TgTLX96LWtFl7/E7pL5E4h6T+omKEJdSzeqMlUm/t+hlMytoCH8tNGMY+IqHfWUMcmha4bNiUDjLVHimVcE002YKpJ34JEplyoF90wWHcRUdDb6LkllN+R1u7VRG2nJnZ8AA11Sv0qifBQ/ychshSsRexQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORqQBH67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F957C4CEF7;
	Wed, 25 Mar 2026 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774457811;
	bh=iHig3EMWOwk1Y/dQ6/HMGDXIACDY9jMTV1RDez9gbZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORqQBH67mGieO5ZudqS2ut9g3nUsz/EtY1RlZCPzNvLXmrLpD6VrGCF9AuyD5fvfu
	 3Xqr/mpNEcnXa9ek+rAdIAVcDbZF/94cJ2fEQZuIQmEw1eEiFy7yd1F87YLlPlchm8
	 MFRRI6vAQfJvPwuINQvnhJze7sxsxJhDXZA3YLvxsSvfgkyOLnvnxRcmzDOpeV3EOg
	 QD7IOZ06PkmPxMge4+KWepN1U3K1YYW7Le/BEY3hAwetoyBWki8HEOOBmcEELb/WPL
	 DwX8m+mfKsZo991kMIc0EcRdyHW/lSc4+kWzhnJ+u2t5b5ZL+22wLLQMFH13T/6VDZ
	 2sUzt5XAz07Jg==
Date: Wed, 25 Mar 2026 16:56:46 +0000
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
Subject: Re: [PATCH net-next v5 0/6] net: mana: Per-vPort EQ and MSI-X
 interrupt management
Message-ID: <20260325165646.GH111839@horms.kernel.org>
References: <20260323195952.1767304-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323195952.1767304-1-longli@microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9769-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A10C13299BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:59:46PM -0700, Long Li wrote:
> This series adds per-vPort Event Queue (EQ) allocation and MSI-X interrupt
> management for the MANA driver. Previously, all vPorts shared a single set
> of EQs. This change enables dedicated EQs per vPort with support for both
> dedicated and shared MSI-X vector allocation modes.
> 
> Patch 1 moves EQ ownership from mana_context to per-vPort mana_port_context
> and exports create/destroy functions for the RDMA driver.
> 
> Patch 2 adds device capability queries to determine whether MSI-X vectors
> should be dedicated per-vPort or shared. When the number of available MSI-X
> vectors is insufficient for dedicated allocation, the driver enables sharing
> mode with bitmap-based vector assignment.
> 
> Patch 3 introduces the GIC (GDMA IRQ Context) abstraction with reference
> counting, allowing multiple EQs to safely share a single MSI-X vector.
> 
> Patch 4 converts the global EQ allocation in probe/resume to use the new
> GIC functions.
> 
> Patch 5 adds per-vPort GIC lifecycle management, calling get/put on each
> EQ creation and destruction during vPort open/close.
> 
> Patch 6 extends the same GIC lifecycle management to the RDMA driver's EQ
> allocation path.
> 
> Changes in v5:
> - Rebased on net-next/main

Hi Long Li,

Unfortunately v5 also doesn't apply cleanly to net-next.

-- 
pw-bot: changes-requested

