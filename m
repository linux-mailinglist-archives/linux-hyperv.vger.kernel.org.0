Return-Path: <linux-hyperv+bounces-7490-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A43C4B669
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 05:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172E33B76DE
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 04:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DDD257448;
	Tue, 11 Nov 2025 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hoswz3Y/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A31820ED;
	Tue, 11 Nov 2025 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833823; cv=none; b=iZ2TY29vocj39kxZ0jiX2T30BynuLF9DzKvP5DAKnGsTrDssJRCV9c1OgaVDKIcyzND59hrs/HxA2OHkzRB3Ee+ps6S4g+Ju2wC3lOThOT1Hev3kJ/Y7lb+JZnvED7PHPl34jkHsMkND0yDXIO/4k/cByCbPl+wGDDFrr4iYNyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833823; c=relaxed/simple;
	bh=BqbibIjmIBvoptyL9956H5Lx4AaV2x5z8jLGWNeHdaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERx0Nw0q8omkoFHbb8ISnE9rb26zok5y/71m5BRb1HxNPcji5FT4oqFC1rSr+Ef/elHu6AHXUKy26EEw3QlFtT4bB7THnPrU7xuH/eoFEoJCzkqV3nGn+KJKCEQRdOE1+COE9ydpB9cX4Oh4j+wA00F4E/QZtHv2+n2RaqFZaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hoswz3Y/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id F3B50212AE23; Mon, 10 Nov 2025 20:03:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F3B50212AE23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762833822;
	bh=4inJCO+mmtz4c98ESvhku4VxP3CaeaFoBhLGjd6rC44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hoswz3Y/566Cw1bmvGOMeg70i3HGrhqAruCMrcy7NqOYYcC8ZpcGWBmM6IBc0TLj9
	 a4szfWyXewqs73SOLjFdSZ5/7pAIXrRQKsLjRLHiDUJzxOdJX2dnxfEV3RavmPTuNY
	 JE8b5y8WHidiwxJeVwy8fL6hvn5JsOeWXwPIcR7c=
Date: Mon, 10 Nov 2025 20:03:41 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	rosenp@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: mana: Add standard counter
 rx_missed_errors
Message-ID: <20251111040341.GA3750@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1761734272-32055-1-git-send-email-ernis@linux.microsoft.com>
 <1761734272-32055-3-git-send-email-ernis@linux.microsoft.com>
 <20251031161723.057e4770@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031161723.057e4770@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Oct 31, 2025 at 04:17:23PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 03:37:52 -0700 Erni Sri Satya Vennela wrote:
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 009e869ef296..48df44889f05 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -494,6 +494,11 @@ static void mana_get_stats64(struct net_device *ndev,
> >  
> >  	netdev_stats_to_stats64(st, &ndev->stats);
> >  
> > +	if (apc->ac->hwc_timeout_occurred)
> > +		netdev_warn_once(ndev, "HWC timeout occurred\n");
> 
> I don't think there's much value in this print.

This print is added because, if the user tries to run 
"ip -s link interface" for multiple times, he should be warned about 
the time out. I will add more info into the print to let the user
know that it is from this action.
> 
> > +#define MANA_GF_STATS_PERIOD (2 * HZ)
> > +
> > +static void mana_gf_stats_work_handler(struct work_struct *work)
> > +{
> > +	struct mana_context *ac =
> > +		container_of(to_delayed_work(work), struct mana_context, gf_stats_work);
> > +	int err;
> > +
> > +	err = mana_query_gf_stats(ac);
> > +	if (err == -ETIMEDOUT) {
> > +		/* HWC timeout detected - reset stats and stop rescheduling */
> > +		ac->hwc_timeout_occurred = true;
> > +		memset(&ac->hc_stats, 0, sizeof(ac->hc_stats));
> 
> Not sure I've seen another device using this approach but I can't
> really tell what's the best strategy. The device is unusable if it
> can't provide stats..

In the case where the HWC becomes unresponsive,
there will be a brief interval needed for the driver to recover. 
During this period, if users request ethtool stats, they would 
receive outdated information. To address this, we proactively 
reset the stats to zero, ensuring users do not see stale data.

> 
> > +		return;
> > +	}
> > +	queue_delayed_work(ac->gf_stats_wq, &ac->gf_stats_work, MANA_GF_STATS_PERIOD);
> > +}
> > +
> >  int mana_probe(struct gdma_dev *gd, bool resuming)
> >  {
> >  	struct gdma_context *gc = gd->gdma_context;
> > @@ -3478,6 +3503,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
> >  	}
> >  
> >  	err = add_adev(gd, "eth");
> > +	ac->gf_stats_wq = create_singlethread_workqueue("mana_gf_stats");
> 
> Why are you creating a workqueue? You can use system queues.
Thankyou for the suggestion. I will integrate it in the next version.
> 
> > +	queue_delayed_work(ac->gf_stats_wq, &ac->gf_stats_work, MANA_GF_STATS_PERIOD);
> 
> ls wrap long lines at 80 chars.
I will make this change for the next verison.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > index 3dfd96146424..99e811208683 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > @@ -213,8 +213,6 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
> >  
> >  	if (!apc->port_is_up)
> >  		return;
> > -	/* we call mana function to update stats from GDMA */
> > -	mana_query_gf_stats(apc->ac);
> 
> Why delete this? We can get fresh stats for the user in this context.
We want to prevent some user that run ethtool too frequently, like
thousands of times / sec, to overwhelm the HW channel. 

