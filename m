Return-Path: <linux-hyperv+bounces-8283-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16BD1BE37
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 02:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3D4D3039289
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 01:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23D21D3DC;
	Wed, 14 Jan 2026 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKStq6y3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693015E5DC;
	Wed, 14 Jan 2026 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768352990; cv=none; b=gerRHmmSWfeaJtLH7R9uCiGXRNoBxumG5vsiUSxzOT3a/g56H91wgM28+uuGcUjqNPIQTD39JZdDEuYTE6go8ouY1RYcioaCeZBlluqx43blieQI/XAjKEAxDTfY7Ke2TJ11qi9WcnvdsTdpgzri/XI1KQIjvNfSkswzaY91NPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768352990; c=relaxed/simple;
	bh=FhTE2O81vVOc5m/6D5KI8Ud3LAbeCf+yg7dqhY6WG68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqdBAaHwjBoDgQJ3dBT5wwEcIMJNykyrkn3jzyUJFXz6Xx/qLQQO0J+d9HuZbKagxHhHlx7eYbwbicgkexiXR1eKLnop/2Kw0bbXlL3QSn0wNuYkL2RX92XA5wfsO4yet250jnS1O4FBzWZworH8hf+UlyENSF0t2p4dJMbcmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKStq6y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB7DC116C6;
	Wed, 14 Jan 2026 01:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768352990;
	bh=FhTE2O81vVOc5m/6D5KI8Ud3LAbeCf+yg7dqhY6WG68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RKStq6y3WT2H4tBiUmrgERKeiP8a4xid8VrfXFdZdPbyCr2o0LhEc6qW/a/5ClxXO
	 zxtMjhf790lOIqQ/iWzwaCXFQUBeeYlcwCPWKKE5m+LQinXlKMYSAiEBpVBKjzzm1F
	 raulX2TO2qo2EWBlnJISWJrD6D3SUAaYsuLTu9TOhHIWDeGvxHHhM+AdndBOm8esck
	 oS6a1E6Q5Fl9T/46lP2PHfua2gsMuJrpINkTs6ePSf7R7i/qccKHaIctZmdY7169ei
	 lIAhRxLR8n43a3/V5vYRPoILHi2se1pmRreq/YDXkEzgMKgRybmaKjDQ7h8ljtO7ES
	 2TMaAItMfuasw==
Date: Tue, 13 Jan 2026 17:09:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Erni
 Sri Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, Aditya Garg
 <gargaditya@linux.microsoft.com>, Dipayaan Roy
 <dipayanroy@linux.microsoft.com>, Shiraz Saleem
 <shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Message-ID: <20260113170948.1d6fbdaf@kernel.org>
In-Reply-To: <SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260112172146.04b4a70f@kernel.org>
	<SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 15:13:24 +0000 Haiyang Zhang wrote:
> > > I get that. What is the logic for combining 4 packets into a single
> > > completion? How does it work? Your commit message mentions "regression
> > > on latency" - what is the bound on that regression?  
> > 
> > When we received CQE type CQE_RX_COALESCED_4, it's a coalesced CQE. And in
> > the CQE OOB, there is an array with 4 PPI elements, with each pkt's length:
> > oob->ppi[i].pkt_len.
> > 
> > So we read the related WQE and the DMA buffers for the RX pkt payloads, up
> > to 4.
> > But, if the coalesced pkts <4, the pkt_len will be 0 after the last pkt,
> > so we know when to stop reading the WQEs.  
> 
> And, the coalescing can add up to 2 microseconds into one-way latency.

I am asking you how the _device_ (hypervisor?) decides when to coalesce
and when to send a partial CQE (<4 packets in 4 pkt CQE). You are using
the coalescing uAPI, so I'm trying to make sure this is the correct API.
CQE configuration can also be done via ringparam.

