Return-Path: <linux-hyperv+bounces-7889-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE936C8E415
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 13:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF963AC5BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18CA33031E;
	Thu, 27 Nov 2025 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cyR5QCPr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B8832AADA;
	Thu, 27 Nov 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246583; cv=none; b=ChYJOehuqrVP/B/Iz1PcDccvcPAecsHfwW4ajH8WbyehDxVo8lGcXA0yrjAdkqiKzRCJWma4ssE0dFkKsYs30JT+JPv4xgwp04uYQFgcF3eXNYGIzJNut0WkxoFOxh3z1JJheLdJTQEee73BzSB5CM+ZaQ4yi1akT6J2p5PXSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246583; c=relaxed/simple;
	bh=hIpYSKfO4HFhoXiKbSUCF4+uYzXtrNa5Zd9QByI/HlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2e9ETUB9IMcikNg0fQNx/VnA6czb2wp6nickeaykTU+Qy5ejWflWxSxVCs/mlMCluGzNFWBj96eixISDKlNi8ZLh/rKyMYi+SGl6P2yTbRUBUBSkY88/myyUvyyLG7WICCK654+/UW0X/d57Rj6jfIB5jZLC9otZIMCY97tYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cyR5QCPr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 61B832126F76; Thu, 27 Nov 2025 04:29:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61B832126F76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764246576;
	bh=vux0D5GHamUSpvMt2OhA+/x0C3GHs6iaT+YVZ4z6yO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyR5QCPrYnWU/vEE4vKVZIXcqOxV6Pc5P3nQ56VXpaSbuu3FyKr8/6/NBDou5zMAt
	 TyEW74s5Mjs8Xfrj5KC+OvK1AhlPJ2aEnOOc9zrJEaJWO+qEwMFxlgvDyiTVdv4NeQ
	 Kz4/aeuROIC7qasPZ3l+2cn8pXSpOAtiNUYe0des=
Date: Thu, 27 Nov 2025 04:29:36 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: Re: [PATCH net-next, v4] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20251127122936.GA10090@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251123180818.GA18398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20251126200541.00e5270f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126200541.00e5270f@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Jakub,

On Wed, Nov 26, 2025 at 08:05:41PM -0800, Jakub Kicinski wrote:
> On Sun, 23 Nov 2025 10:08:18 -0800 Dipayaan Roy wrote:
> > Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detected
> > and a device-controlled port reset for all queues can be scheduled to a
> > ordered workqueue. The reset for all queues on stall detection is
> > recomended by hardware team.
> > 
> > The change introduces a single ordered workqueue
> > "mana_per_port_queue_reset_wq" queuing one work_struct per port,
> > using WQ_UNBOUND | WQ_MEM_RECLAIM so stalled queue reset work can
> > run on any CPU and still make forward progress under memory
> > pressure.
> 
> And we need to be able to reset the NIC queue under memory pressure
> because.. ?  I could be wrong but I still find this unusual / defensive
> programming, if you could point me at some existing drivers that'd help.
>
I found these existing drivers using 'create_singlethread_workqueue',

drivers/net/ethernet/mellanox/mlx4/en_main.c
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
drivers/net/ethernet/mellanox/mlx5/core/en_main.c

'create_singlethread_workqueue' in turn uses  WQ_MEM_RECLAIM

as in below macros 
#define alloc_ordered_workqueue(fmt, flags, args...) \
	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1,
##args)

...
#define create_singlethread_workqueue(name) \
	alloc_ordered_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM,
name)

I will switch to directly using create_singlethread_workqueue instead
of explicitly mentioning the flags in the next version. 

 
> > @@ -3287,6 +3341,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
> >  	ndev->min_mtu = ETH_MIN_MTU;
> >  	ndev->needed_headroom = MANA_HEADROOM;
> >  	ndev->dev_port = port_idx;
> > +	ndev->watchdog_timeo = 15 * HZ;
> 
> 5 sec is typical, off the top of my head
> 
As per our internal discussion, 15 second timeout recommended by HW team based on the FPGA reconfig
scenario.
> > @@ -3647,6 +3717,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
> >  		free_netdev(ndev);
> >  	}
> >  
> > +	if (ac->per_port_queue_reset_wq) {
> > +		destroy_workqueue(ac->per_port_queue_reset_wq);
> > +		ac->per_port_queue_reset_wq = NULL;
> > +	}
> 
> I think you're missing this cleanup in the failure path of mana_probe
Right, if all the ports fail to probe the clean up will get skipped from
mana_remove. I will fix this in the v5.
> -- 
> pw-bot: cr

Thank you for the comments, I will work on it in v5.

Regards

