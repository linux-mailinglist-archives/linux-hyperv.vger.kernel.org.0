Return-Path: <linux-hyperv+bounces-9803-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEhwLDxrxWl1+AQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9803-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 18:22:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B45339162
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 18:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CE3A3014851
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F83CCFA0;
	Thu, 26 Mar 2026 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd2flJKY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDF9383C7D;
	Thu, 26 Mar 2026 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545604; cv=none; b=FhyOGC05QRFRh+iZmv/hDVHRd7OZJueRi6YpDOYVkqZ2BJmhiBrz3fd99dvVfZPfBPRjBiKQYpHBGXEbqA7+O6Hyy1GoCm3xHiB6UICX+yYA4OYQoJqSj9RstoMIAFO4zdDxBcfFGPcv5yjkQZ+oCSGskJRQ8mVdnwz6o1PocYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545604; c=relaxed/simple;
	bh=BZy5v8NRMmYUEl/F2sHfWpEGo0czvNMsmGpyVhXQ+5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCGxYs9AnBgXgmtbU0977ydF0h2Mf5Y7GCskSifAqAII3LKz7+jnj0oV8gyxJkn9Kmuv1PeKfMOt+pFZChyTcga2ehYVkF39Oykwg2AMQPuQKJVZu4kNdErS38xrepXJYoZi4edTV9ljKI6aaw/RPoeHUSGMfgguhApcFX21LnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd2flJKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F0DC116C6;
	Thu, 26 Mar 2026 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774545603;
	bh=BZy5v8NRMmYUEl/F2sHfWpEGo0czvNMsmGpyVhXQ+5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gd2flJKYm45rbE3fu9OJfeR5/UoDNbG1jTK0Bg/GkdELYLB9isfbUPfti+PfXMFZq
	 RZycIip8beJG+J8qROnWq5P1yrWme2TlT2rDVBjq8q+1+T/p+zUQdhzQUq+nClkCLe
	 v6SOHHp1542L/urbXmKMzMJqUv+ewksEige4gY+69uxA2P8aHAlr0a/gArkP0zorK7
	 elXWUJVyub275ZX2deTSAuzW4x5lxSRzeZ8e8LCh642fZ0O/W6yDmIbFrucp6BLwlf
	 /lwGjaDy1vvfnCXCtR9luRuR2nDwXgGiw3tBUWzKOQhgTeT1zoVRd3DvHmNyM9aU0F
	 KBqdPvv1+01DQ==
Date: Thu, 26 Mar 2026 17:19:58 +0000
From: Simon Horman <horms@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v5 0/6] net: mana: Per-vPort EQ
 and MSI-X interrupt management
Message-ID: <20260326171958.GP111839@horms.kernel.org>
References: <20260323195952.1767304-1-longli@microsoft.com>
 <20260325165646.GH111839@horms.kernel.org>
 <SA1PR21MB66838DF94EC752617C9FED20CE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <SA1PR21MB6683FB2D67A3BBCC74B62D45CE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB6683FB2D67A3BBCC74B62D45CE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9803-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 12B45339162
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 08:47:35PM +0000, Long Li wrote:
> > > On Mon, Mar 23, 2026 at 12:59:46PM -0700, Long Li wrote:

...

> > Hi Simon,
> > 
> > This patch set should apply after this patch: (which is also pending net-next)
> > net: mana: Set default number of queues to 16
> > 
> > Can you apply the patch set after this patch, or should I wait for the next patch
> > merge window?
> > 
> > Thank you,
> > Long
> 
> 
> I'll send it over in the next patch merging window.

Thanks,

The way I understand things net-next, and in particular the CI,
can only handle patches where all the dependencies are already
present in net-next.


