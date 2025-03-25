Return-Path: <linux-hyperv+bounces-4690-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D2A706E2
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 17:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E9217637A
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CD25D21F;
	Tue, 25 Mar 2025 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ELmNXG5V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4635A25B694;
	Tue, 25 Mar 2025 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919935; cv=none; b=JojnzVm6wh6SkkvYEmYPS3MM4V7QK6xry+WQ4cUrFnE5sg3i/FS0tPr36J7qoordNeqwk9XZmCWisUvx5xByt9jCGeSjT83lTEBb8w7+C1geVnCkvi5j+D5TgveH4W8FutZixFCpuXz0BW/sgPUN6Z8AgC2O213K50AuPAns/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919935; c=relaxed/simple;
	bh=BXB/l04YScle6+SQ16r/GNRKm8jIFSwM2i1fBG35qZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4JpU0U2u0lHhx2TykttMqkjgIzKjVeXavNUzl48XiiI9ynfy5GdXb+YpWWhfytKxqo4VmuIbQNy+Nvy2oW6Vi78wyCGBnE9WMyS4oGiLXNJUK9Td+zfyp224clxAXiGPdl3fMviNpUVvNSaIFoYANXViA+sSuURqkDLgismcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ELmNXG5V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 0400F203659D; Tue, 25 Mar 2025 09:25:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0400F203659D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742919928;
	bh=vAsYO4e2FF8ruSEJfqgRDn/Skz0UOeL97KKsWvDclCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELmNXG5V4eDrSe8Aqp1Esb/HO28PJiDSZCehL+kIX3btbTaAU/w0V9iChjtwp764J
	 Ewge6UwEWgVPPAvCCsNIRwCr9fjmFU2tUmYiuLOO04/oLElu7D7W0IbyG+WNghUfjQ
	 71SqlHxLOI/sps5r/aqgpLCCEqXGNyxlCW20WI7w=
Date: Tue, 25 Mar 2025 09:25:27 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20250325162527.GA23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-2-git-send-email-ernis@linux.microsoft.com>
 <f4e84b99-53b5-455d-bad2-ef638cafdeae@lunn.ch>
 <20250324174339.GA29274@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <909eae34-02ac-4acd-8f0e-1194f0049a21@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <909eae34-02ac-4acd-8f0e-1194f0049a21@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 24, 2025 at 07:44:39PM +0100, Andrew Lunn wrote:
> On Mon, Mar 24, 2025 at 10:43:39AM -0700, Erni Sri Satya Vennela wrote:
> > On Thu, Mar 20, 2025 at 02:37:47PM +0100, Andrew Lunn wrote:
> > > > +int mana_query_link_cfg(struct mana_port_context *apc)
> > > > +{
> > > > +	struct net_device *ndev = apc->ndev;
> > > > +	struct mana_query_link_config_req req = {};
> > > > +	struct mana_query_link_config_resp resp = {};
> > > > +	int err;
> > > > +
> > > > +	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
> > > > +			     sizeof(req), sizeof(resp));
> > > > +
> > > > +	req.vport = apc->port_handle;
> > > > +
> > > > +	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
> > > > +				sizeof(resp));
> > > > +
> > > > +	if (err) {
> > > > +		netdev_err(ndev, "Failed to query link config: %d\n", err);
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_LINK_CONFIG,
> > > > +				   sizeof(resp));
> > > > +
> > > > +	if (err || resp.hdr.status) {
> > > > +		netdev_err(ndev, "Failed to query link config: %d, 0x%x\n", err,
> > > > +			   resp.hdr.status);
> > > > +		if (!err)
> > > > +			err = -EPROTO;
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	if (resp.qos_unconfigured) {
> > > > +		err = -EINVAL;
> > > > +		goto out;
> > > > +	}
> > > > +	apc->speed = resp.link_speed;
> > > 
> > > Might be worth adding a comment that the firmware is returning speed
> > > in Mbps.
> > > 
> > > Or name the struct member link_speed_mbps.
> > > 
> > Thank you for your suggestion. I'll make this change for the next
> > version of this patchset.
> 
> Please answer my other questions before posting the next version of
> the patch. I'm really questioning if this is the correct uAPI to be
> using. You have a very poor description of what you are trying to
> do. Maybe TC is the better fit? Does this speed apply to ingress and
> egress? If so, there are two leaky buckets, so why only one
> configuration value? Or can you only configure ingress?
> 
The QoS control is at the hardware/firmware level and applies to the
egress rate.
> Also, if i understand correctly MANA is a virtual device and this is
> the VM side of it. If this is used for bandwidth limitation, why is
> the VM controlling this, not the hypervisor? What is the security
> model?
> 
In certain cluster and hardware versions, Azure allows this API to
restrict the bandwidth limit to a lesser value than what was configured
by the Azure control plane. The device will not allow a higher limit
than what was configured through the Azure control plane to be set by
the VM through this API.
> 	Andrew

