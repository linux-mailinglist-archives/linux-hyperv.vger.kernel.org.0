Return-Path: <linux-hyperv+bounces-4647-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807DA6A783
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 14:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7CB188CE2E
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DB81C5D7E;
	Thu, 20 Mar 2025 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e15JPQEc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD11388;
	Thu, 20 Mar 2025 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477885; cv=none; b=LApi3kLFOTISWYSXU8MtIOGP6xO0LHKYx9AeQGG9JS3uGETXYhuWCm87bCKDC8AXsL0UnfttFXuIIgnu60MLfoAm2YIrUA+JCQ7kCjK5mNZDx3royMTGCwSHr0NRNrwlUabokJS61kv2XpBeJgrxNKo8ng7vkChOK758xJw8jvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477885; c=relaxed/simple;
	bh=hTdf7j2IT37VLyjvA92700a8bqFm/iO32zguLywCvnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+ZIK5N+XU5sPUEmkOzJjv7EDtzAKaz0EcCpeDlGsDI6mcYzSyF+TsomR2p6zNUHy8A4bFdua04bIhUi8YeTFV6hcTQ1ttC8pIz/um17UAeffiEcd8o3+bjMV8bveSpoa2j03g5vVmpmjY9ywLXJkgC9yie/2S+ZZg3yk2jKzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e15JPQEc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jFfCe2z7hTou/jF75500VPYrgrCja5avoZPQCSrPbZ0=; b=e15JPQEc7GSovbWZHYB0iEKQVa
	xJycUQs5bOQxSV4TriBBA8vdR4xmItLhvR5jVgnFkldWBAdV8T6WecmFOTH7UPqJ/KKvZEO8SerLQ
	cNAz61bt4JSY2XGK8z0BUCsQg0+E0yisdyWD0sZA83EdX2n3MzGO3FrOOR2xon1cD07Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvG5j-006Ts0-56; Thu, 20 Mar 2025 14:37:47 +0100
Date: Thu, 20 Mar 2025 14:37:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	brett.creeley@amd.com, surenb@google.com,
	schakrabarti@linux.microsoft.com, kent.overstreet@linux.dev,
	shradhagupta@linux.microsoft.com, erick.archer@outlook.com,
	rosenp@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/3] net: mana: Add speed support in
 mana_get_link_ksettings
Message-ID: <f4e84b99-53b5-455d-bad2-ef638cafdeae@lunn.ch>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-2-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742473341-15262-2-git-send-email-ernis@linux.microsoft.com>

> +int mana_query_link_cfg(struct mana_port_context *apc)
> +{
> +	struct net_device *ndev = apc->ndev;
> +	struct mana_query_link_config_req req = {};
> +	struct mana_query_link_config_resp resp = {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
> +			     sizeof(req), sizeof(resp));
> +
> +	req.vport = apc->port_handle;
> +
> +	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
> +				sizeof(resp));
> +
> +	if (err) {
> +		netdev_err(ndev, "Failed to query link config: %d\n", err);
> +		goto out;
> +	}
> +
> +	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_LINK_CONFIG,
> +				   sizeof(resp));
> +
> +	if (err || resp.hdr.status) {
> +		netdev_err(ndev, "Failed to query link config: %d, 0x%x\n", err,
> +			   resp.hdr.status);
> +		if (!err)
> +			err = -EPROTO;
> +		goto out;
> +	}
> +
> +	if (resp.qos_unconfigured) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +	apc->speed = resp.link_speed;

Might be worth adding a comment that the firmware is returning speed
in Mbps.

Or name the struct member link_speed_mbps.

	Andrew

