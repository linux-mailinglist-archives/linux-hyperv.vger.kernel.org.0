Return-Path: <linux-hyperv+bounces-9095-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHOlM3tOpmlCNwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9095-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 03:59:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EAF1E8442
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 03:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 418AB3030EE7
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 02:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90906379EF7;
	Tue,  3 Mar 2026 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/84zTxz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4392F851;
	Tue,  3 Mar 2026 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506744; cv=none; b=aA4Pkqa+ZBrBSE/ZQ/U1YkKVS8Lij91X0Skn0WmcMXYll3seL0DAYPP9m1Aeo1ktHmG9hEncOl1zTIwN3SEuJZvrzh+6DaBD4wsos80oQImyA6AA7R80B+HBj+tu9B/pKMARquwSR+NvkPvXgrUsTJ1iDCxUBC5NfQxZn27rh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506744; c=relaxed/simple;
	bh=fgR3EcmKuj1SzLVfh3XjFCkJQtQeTsanWkUytmCjjE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnWvnybAgtV+fbNgMnCxhCuOvoD4F2LEko6TVy8s4rNSxbieXEXS+usHhKxsTlrRRHAdWueAIRftIwsL69m2EiPzu7jJRKMRaz3kW8vLc9C4hX0zjbRp+M0TDgTM8WoVEyNHoYKEyv43Ro2eAaXd33N8CPmFDa/EeYDRP/IaBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/84zTxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C82EC19423;
	Tue,  3 Mar 2026 02:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772506744;
	bh=fgR3EcmKuj1SzLVfh3XjFCkJQtQeTsanWkUytmCjjE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/84zTxzhinzf72eQwnDGMk3zSnySat6C1/pGI/Cux6BplPu4oe+TlTspV/u06utp
	 38WDqMJkqph8tT6iwSh+QjmzqzgdqlQfb+hNV0QMNkuDkpn0GBwOFANoWySPTNimgL
	 nD24aPtJsYg6i9NzjK4X20wRSmMMWs8y7Ev9XDul7e0ggbbqpULOhXjA3iPB5s6f87
	 HOjxRYVHdBt7/NPpC1C6cvyjO9A+3640mqRkzelUZinPuchN5KwY1ghKjQ/Dq94nh0
	 Rq5l01L7wHow7JfVFq/PWFCCUgjMO3u/KmSR92Q449Uc5MSSkQB6InIuQP96B75lRw
	 nFzm7EhJ9G8uQ==
Date: Mon, 2 Mar 2026 18:59:02 -0800
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
Subject: Re: [PATCH net-next 0/6] net: mana: Per-vPort EQ and MSI-X
 interrupt management
Message-ID: <20260302185902.5a778bb4@kernel.org>
In-Reply-To: <20260228021144.85054-1-longli@microsoft.com>
References: <20260228021144.85054-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 42EAF1E8442
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-9095-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 18:11:38 -0800 Long Li wrote:
> This series adds per-vPort Event Queue (EQ) allocation and MSI-X interrupt
> management for the MANA driver. Previously, all vPorts shared a single set
> of EQs. This change enables dedicated EQs per vPort with support for both
> dedicated and shared MSI-X vector allocation modes.

Does not apply to net-next, please rebase.

