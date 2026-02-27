Return-Path: <linux-hyperv+bounces-9032-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBCfDOC1oWmMvgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9032-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 16:18:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7C1B9966
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 16:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EF32303EBAB
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D327A436345;
	Fri, 27 Feb 2026 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p1rYvVum"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656DE2877D8;
	Fri, 27 Feb 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205088; cv=none; b=tRxU4lCjqsuzdxeFctLtiR7L3RVxoeFyxKUJM/wls4P7zOJCn5M5BhEXLsem4EQkloE8qvhyfZ1sFplN9nnIiX5goDkjPJfCYakzBMUfOEAO9HVCypzJgCTOeLlpnbacesVggshLn+qdBleOROh7H4GWiWKkBxr5qJ6Bs82/94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205088; c=relaxed/simple;
	bh=8OSlUHdG3SZe2WcVCkBJhifgWumQUGLJJvWESNYm3wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9Ob41jMSe5KNr8W2mO3sPU5QDADk5im3fLtOXBtQf9+3Dkab83ktrygRMAVFQf12Qr71dybcBZdXKjnl0IvoR2jhkpjB2QT6M1aXSKxwEr4LNGnBJ0x/d6I9h63RfA7Efgv8HgPgp8l7yWSNi9AQojCNRlkz4XrpYYQoUz9ryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p1rYvVum; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WPtFWHfAw7BuBivDMTtLj9OtNle5ucPpSNk1HcIecWA=; b=p1rYvVumg5EUFSZ6K9PA9T5Guw
	NylwVimzovTgRlD02ymtwQvnSJnmkQYqYB4kaeZ3gOIhK9/0UlHeQ3WIxrJq3wl7rfxqMAknO0Pda
	I3SB+UQQd7tB6cQLm01iUHHnXfHNNHCs5aOw0i0JyNLnAC71xjlP6vtTJd8girktrHHc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvzUf-00957n-Oc; Fri, 27 Feb 2026 16:11:05 +0100
Date: Fri, 27 Feb 2026 16:11:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
Subject: Re: [PATCH net-next] net: mana: Expose page_pool stats via ethtool
Message-ID: <74a4113a-1e44-42a4-b366-c0e54fe84497@lunn.ch>
References: <aaFmRqjjOuPIEo5x@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaFmRqjjOuPIEo5x@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9032-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 96B7C1B9966
X-Rspamd-Action: no action

> +static void mana_get_page_pool_stats(struct net_device *ndev, u64 *data)
> +{
> +#ifdef CONFIG_PAGE_POOL_STATS
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +	unsigned int num_queues = apc->num_queues;
> +	struct page_pool_stats pp_stats = {};
> +	int q;
> +
> +	for (q = 0; q < num_queues; q++) {
> +		if (!apc->rxqs[q] || !apc->rxqs[q]->page_pool)
> +			continue;
> +
> +		page_pool_get_stats(apc->rxqs[q]->page_pool, &pp_stats);
> +	}
> +
> +	page_pool_ethtool_stats_get(data, &pp_stats);
> +#endif /* CONFIG_PAGE_POOL_STATS */

You should not need this #ifdef. The stubs should make the code do
sensible things if CONFIG_PAGE_POOL_STATS is not enabled.

	 Andrew

