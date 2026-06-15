Return-Path: <linux-hyperv+bounces-11623-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YtXWG1/1L2ojKAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11623-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2026 14:51:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D702768666E
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2026 14:51:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mr7KAvQC;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11623-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11623-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC1063025C3E
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2026 12:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE83EDE62;
	Mon, 15 Jun 2026 12:51:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823B30C143;
	Mon, 15 Jun 2026 12:51:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527898; cv=none; b=Ga6cXz4nPnIzK2MDnWUkiQ81PKQ+JnTFNMsT5rL35FS+sjaAIj+CslkJ3Qb1NZU3cYxJrwgsAZzf2VKblh6FeMaTWGE/wWd3+cii9kfhOvbZ6x9VDgG/JciA5Hssv75I7Og9Rv/z23ZEklfVq937EP3hbe2I0QKB0Xz/THUUBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527898; c=relaxed/simple;
	bh=pYDSdXWHSIEwt9uHynbFQmsVT4AYiA6lTSQKn5Wpwn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbnD+6ONNmfVNTunrMIoCYDNfQ13dLlYM1iEkE8tCjwqns/6qwerOwul7zlwagdVb9fUr3HNSIlK9a0kI/LBiUWvqkbYT0MTkDSrJB995E77JolcQajGuaQQeMc7+yvkq6zoYQFo9Ii2NmmpTF82zbpBa0Mk/O8450dgXu/x16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr7KAvQC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4D21F000E9;
	Mon, 15 Jun 2026 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781527897;
	bh=i4K+f5gCCnhbLOrjygqtS/KpJ6yUBGuciB7yvW4kNZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mr7KAvQCBKRS5dSYPrzizqQcNlkc6Q3EvjhwTlakNWJ/SpyjnOPKSZia4v3IIRYTT
	 ZpVtsRtk9sh2aGwCEQBaGQC3itvijg1E6I1mTVmSGZrKkISZZBuIOYDEz4Jyvq07BQ
	 w81L2mnGq8+v+Ja8bl/hsoau24odQc2KMvf4Ho9EOIJrtZkQIEet127duOsDiklZoJ
	 UObX9hhpfz1ImSXnyoz0IMBqTxJsNA7t+L8jpfLe01267kL7BfCQX8D4Ap8+R4pgBw
	 GdNSJ6hy7/fViOSlIYFssaPqqqtf5ybe8SEanB9d57QoHg6hDLE8tTh7olCNNDVrVE
	 p22Y4wlqVUtAg==
Date: Mon, 15 Jun 2026 13:51:31 +0100
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, paulros@microsoft.com
Subject: Re: [PATCH net-next v4] net: mana: Add Interrupt Moderation support
Message-ID: <20260615125131.GL712698@horms.kernel.org>
References: <20260613205812.2659945-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613205812.2659945-1-haiyangz@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11623-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:shradhagupta@linux.microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D702768666E

On Sat, Jun 13, 2026 at 01:57:54PM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add Static and Dynamic Interrupt Moderation (DIM) support for
> Rx and Tx.
> Update queue creation procedure with new data struct with the related
> settings.
> Add functions to collect stat for DIM, and workers to update DIM data
> and settings.
> Update ethtool handler to get/set the moderation settings from a user.
> To avoid detach/re-attach ops, ring DIM doorbell to change settings
> at run time.
> By default, adaptive-rx/tx (DIM) are enabled if supported by HW.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v4:
>   Fixed tx stat, concurrency, and mb issues from Simon's review.

...

Thanks for your comprehensive reply to the AI-generated review of v3
that I forwarded. And for fixing the issues present in v3.

Reviewed-by: Simon Horman <horms@kernel.org>


