Return-Path: <linux-hyperv+bounces-4680-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72979A6E1D4
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Mar 2025 18:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DE13BB2DA
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Mar 2025 17:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3390264F86;
	Mon, 24 Mar 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RQwIXqJB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E19F2641E9;
	Mon, 24 Mar 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838221; cv=none; b=BhrFzI2OdffKdpjyrV0uF6E/vmn7Ua/bAlla9P8j/buSpA8UFIVnEAom5pbTnT89RVOlh2/OqxxVmLBXbyPz0nFac55xLnE/UPo5yALjnTEWNN7nbBgeWoRHm2408DSqySiUb7jUXm046oCoGWwDpqL6rmZbdc4d1r2UXjQTaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838221; c=relaxed/simple;
	bh=IEbZX5LHrjNjLHzpwBGHTfQ+kmLMtFidxbWZveAryjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBVyJErLEUqXaI+bKlXlqSat45cJz3QgOHNM68SilBskzQYVetg9ayi8NqpTrWW4GRnpb9BgPmwWDcKGgFDm15NqcqjqOU+0LqUZejJ0gX/N8lF2ZZ5dey4gcWBmNTzQeRhHuNYe8KVXS1dgnfTIiP10VstXcQ4qzySAWWp8aKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RQwIXqJB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id A2BA1211AA01; Mon, 24 Mar 2025 10:43:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2BA1211AA01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742838219;
	bh=R0yptjoilxJTorB2L0W8GLNAJvxs/9K84UNE0zqBuPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQwIXqJBSTQ+Fzolz8VNvpueVTY2MJrPe63NQ3B5cOjnV/K+0x7jZ5i8TJsft8Ewa
	 88X/IiZGs4Qs1d0bosnLp5bpEhlmPCUHGoNS1fRF5UcMsDbfRfhmUHMO/NItBNrIhu
	 gCUPmQ8KgiPX8gtMIjSGiLteYPuRztvQE9bSI9SE=
Date: Mon, 24 Mar 2025 10:43:39 -0700
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
Message-ID: <20250324174339.GA29274@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-2-git-send-email-ernis@linux.microsoft.com>
 <f4e84b99-53b5-455d-bad2-ef638cafdeae@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e84b99-53b5-455d-bad2-ef638cafdeae@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Mar 20, 2025 at 02:37:47PM +0100, Andrew Lunn wrote:
> > +int mana_query_link_cfg(struct mana_port_context *apc)
> > +{
> > +	struct net_device *ndev = apc->ndev;
> > +	struct mana_query_link_config_req req = {};
> > +	struct mana_query_link_config_resp resp = {};
> > +	int err;
> > +
> > +	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
> > +			     sizeof(req), sizeof(resp));
> > +
> > +	req.vport = apc->port_handle;
> > +
> > +	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
> > +				sizeof(resp));
> > +
> > +	if (err) {
> > +		netdev_err(ndev, "Failed to query link config: %d\n", err);
> > +		goto out;
> > +	}
> > +
> > +	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_LINK_CONFIG,
> > +				   sizeof(resp));
> > +
> > +	if (err || resp.hdr.status) {
> > +		netdev_err(ndev, "Failed to query link config: %d, 0x%x\n", err,
> > +			   resp.hdr.status);
> > +		if (!err)
> > +			err = -EPROTO;
> > +		goto out;
> > +	}
> > +
> > +	if (resp.qos_unconfigured) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +	apc->speed = resp.link_speed;
> 
> Might be worth adding a comment that the firmware is returning speed
> in Mbps.
> 
> Or name the struct member link_speed_mbps.
> 
Thank you for your suggestion. I'll make this change for the next
version of this patchset.
> 	Andrew

