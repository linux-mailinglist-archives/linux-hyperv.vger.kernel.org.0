Return-Path: <linux-hyperv+bounces-4681-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 212FAA6E299
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Mar 2025 19:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492413B0368
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Mar 2025 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1B7264A9B;
	Mon, 24 Mar 2025 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="46pIIM0o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F53C17;
	Mon, 24 Mar 2025 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841899; cv=none; b=PGNA2oZA87a/0eftsgfDIIcj1pfYO1hE3rNybSTLTnAX1kBUJsEW3l8rgeycWz7qTssvG8wI05DCebU6tv/0vrpYlojK+JaN56iJ3dsEbhWCPF1hEPjG0RD9Cq6JoZ42OXDg+8nsxUJwIP6ukpad5ENhNZcqExcFi6sbCssDiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841899; c=relaxed/simple;
	bh=K3laK/m5RtpxHsNbwje5ZG8P4i6IVDET2aF6Q5FXpEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4BNAWXbK41P0Ax8vaf+XFlYbEOSH5zJp7yq6MlcHGttBfwHwjCqMQe3YbGZ12KFG+NN2/E5ILIXeTRgrZQRwq4cS8FPmh8jEHyNwnk0qkE+Av0cXuH0tR2Nm5qWScCvsiiCBkSgy98bCzgNWKNdfCXfX8Sp/V1mEKMJYicFYIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=46pIIM0o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n7jWwqiuO3K1ioFA/FuzqDBCH2NO8F0ORU/xJjFa8QI=; b=46pIIM0oB91fzxEQ7VIVH19kOq
	wiKFCzriYDxg1lMpvLVGyzW+vQlAvJt/BehpI1Nl8IDUUXZgvHyVjiYbjIV9G+rrI8dXY0rAGH01h
	hC6ZEq4bDaiBnySSvqfceQELYDTQ5wvBsa6GiRW1PImqxVG4Di7g2uy6y1TmwujfY+/I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1twmmt-006y43-RD; Mon, 24 Mar 2025 19:44:39 +0100
Date: Mon, 24 Mar 2025 19:44:39 +0100
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
Message-ID: <909eae34-02ac-4acd-8f0e-1194f0049a21@lunn.ch>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-2-git-send-email-ernis@linux.microsoft.com>
 <f4e84b99-53b5-455d-bad2-ef638cafdeae@lunn.ch>
 <20250324174339.GA29274@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324174339.GA29274@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Mar 24, 2025 at 10:43:39AM -0700, Erni Sri Satya Vennela wrote:
> On Thu, Mar 20, 2025 at 02:37:47PM +0100, Andrew Lunn wrote:
> > > +int mana_query_link_cfg(struct mana_port_context *apc)
> > > +{
> > > +	struct net_device *ndev = apc->ndev;
> > > +	struct mana_query_link_config_req req = {};
> > > +	struct mana_query_link_config_resp resp = {};
> > > +	int err;
> > > +
> > > +	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
> > > +			     sizeof(req), sizeof(resp));
> > > +
> > > +	req.vport = apc->port_handle;
> > > +
> > > +	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
> > > +				sizeof(resp));
> > > +
> > > +	if (err) {
> > > +		netdev_err(ndev, "Failed to query link config: %d\n", err);
> > > +		goto out;
> > > +	}
> > > +
> > > +	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_LINK_CONFIG,
> > > +				   sizeof(resp));
> > > +
> > > +	if (err || resp.hdr.status) {
> > > +		netdev_err(ndev, "Failed to query link config: %d, 0x%x\n", err,
> > > +			   resp.hdr.status);
> > > +		if (!err)
> > > +			err = -EPROTO;
> > > +		goto out;
> > > +	}
> > > +
> > > +	if (resp.qos_unconfigured) {
> > > +		err = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +	apc->speed = resp.link_speed;
> > 
> > Might be worth adding a comment that the firmware is returning speed
> > in Mbps.
> > 
> > Or name the struct member link_speed_mbps.
> > 
> Thank you for your suggestion. I'll make this change for the next
> version of this patchset.

Please answer my other questions before posting the next version of
the patch. I'm really questioning if this is the correct uAPI to be
using. You have a very poor description of what you are trying to
do. Maybe TC is the better fit? Does this speed apply to ingress and
egress? If so, there are two leaky buckets, so why only one
configuration value? Or can you only configure ingress?

Also, if i understand correctly MANA is a virtual device and this is
the VM side of it. If this is used for bandwidth limitation, why is
the VM controlling this, not the hypervisor? What is the security
model?

	Andrew

