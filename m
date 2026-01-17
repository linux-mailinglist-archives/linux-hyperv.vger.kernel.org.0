Return-Path: <linux-hyperv+bounces-8359-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E059D39166
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Jan 2026 23:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 153BA3004EF0
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Jan 2026 22:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A561029BDBF;
	Sat, 17 Jan 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdlGoPd3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA821F1932;
	Sat, 17 Jan 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768690129; cv=none; b=rVEK0edTF5/KcSnF5PHvvo57fsKhqtdjMUg37ll3kwvJB6mm2ipWs1zvg60LvuNyWNcc4Yrr2xqqvP1ssL0+ebyMZI2Fef7ifaa/TN67Zzx824MQ+I5pKJ08M6eiYXbDz7sSQW8YRXXTpStQ0VakIKTFiWluL2WITvbIQEw8jc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768690129; c=relaxed/simple;
	bh=eoAiYzEULWXg85JvXinMkueaZK1CXYsvYGXVb4A1ZXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRkjhcPLVtegOP9nGl09vA3C8y4vzQI6rjSA9fpRUdiM35l4Db9Qf98qeW0FozQ/w1KTU2o2k3cPqieYEWgxiXsSfrAppbcYLqS5LaLV9mLB1ZvdItDsOVeUcR52VgJ0SHWwIs7iEA3QZherCkFhy6RQB+fOcIFtrCMOUG3xWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdlGoPd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D65CC4CEF7;
	Sat, 17 Jan 2026 22:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768690129;
	bh=eoAiYzEULWXg85JvXinMkueaZK1CXYsvYGXVb4A1ZXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WdlGoPd3xUSeKCaUCX77/Cu1pCRP7hsPL1PgaOFepU5A7GYkQJ6+fHEaerTwHTkbX
	 YU5/qQK4JiyPPwsnk4D52CvbUq9mRLkz9IeDrhTjaeuO4hqeraP897byXK/9fkzKem
	 94Dt2pmAYzFRTNnaKmepRXlZhallnlRealw2QTuY82TQAc61UWWFTF2iasO0xniWWY
	 /1GaBW1JfcDImvVd8uKjH7YZlB8EQmygEVYhHEPdNFUo/CHxlK1HLuFST1hGibsSyd
	 OR5dRPzGlo9iTrVV5Dg+b2bwN9hU/opF+bkgR6BNy4qz+dzK9hlsiIRKIeHRqgen3J
	 ZD0U6xBJAmZgg==
Date: Sat, 17 Jan 2026 14:48:47 -0800
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
Message-ID: <20260117144847.20676729@kernel.org>
In-Reply-To: <SA3PR21MB3867D18555258EDB7FCF9ACACA8AA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260112172146.04b4a70f@kernel.org>
	<SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260113170948.1d6fbdaf@kernel.org>
	<SA3PR21MB38676C98AA702F212CE391E2CA8FA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260114185450.58db5a6d@kernel.org>
	<SA3PR21MB38673CA4DDE618A5D9C4FA99CA8CA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260115181434.4494fe9f@kernel.org>
	<SA3PR21MB3867B98BBA96FF3BA7F42F3FCA8DA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260117085850.0ece5765@kernel.org>
	<SA3PR21MB3867D18555258EDB7FCF9ACACA8AA@SA3PR21MB3867.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 18:01:18 +0000 Haiyang Zhang wrote:
> > > Since this feature is not common to other NICs, can we use an
> > > ethtool private flag instead?  
> > 
> > It's extremely common. Descriptor writeback at the granularity of one
> > packet would kill PCIe performance. We just don't have uAPI so NICs
> > either don't expose the knob or "reuse" another coalescing param.  
> 
> I see. So how about adding a new param like below to "ethtool -C"?
> ethtool -C|--coalesce devname [rx-cqe-coalesce on|off]

I don't think we need on / off, just the params.
If someone needs on / off setting - the size to 1 is basically off.

> > > When the flag is set, the CQE coalescing will be enabled and put
> > > up to 4 pkts in a CQE. support  
> > > Does the "size" mean the max pks per CQE (1 or 4)?  
>  [...]  
> 
> In "ethtool -c" output, add a new value like this?
> rx-cqe-frames:      (1 or 4 frames/CQE for this NIC)

SG

> > > The timeout value is not even exposed to driver, and subject to change
> > > in the future. Also the HW mechanism is proprietary... So, can we not
> > > "expose" the timeout value in "ethtool -c" outputs, because it's not
> > > available at driver level?  
> > 
> > Add it to the FW API and have FW send the current value to the driver?  
> 
> I don't know where is the timeout value in the HW / FW layers. Adding 
> new info to the HW/FW API needs other team's approval, and their work, 
> which will need a complex process and a long time.
> 
> > You were concerned (in the commit msg) that there's a latency cost,
> > which is fair but I think for 99% of users 2usec is absolutely
> > not detectable (it takes longer for the CPU to wake). So I think it'd
> > be very valuable to the user to understand the order of magnitude of
> > latency we're talking about here.  
> 
> For now, may I document the 2us in the patch description? And add a
> new item to the "ethtool -c" output, like "rx-cqe-usecs", label is as 
> "n/a" for now, while we work out with other teams on the time value 
> API at HW/FW layers? So, this CQE coalescing feature support won't be
> blocked by this "2usec" info API for a long time?

Please do it right. We are in no rush upstream. It can't be that hard
to add a single API to the FW within a single organization..

