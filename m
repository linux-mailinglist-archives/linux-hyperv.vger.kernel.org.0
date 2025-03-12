Return-Path: <linux-hyperv+bounces-4424-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2662A5DE2D
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 14:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D04C1616EC
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 13:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549AB2459CC;
	Wed, 12 Mar 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4nsVUF0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2605124338F;
	Wed, 12 Mar 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786689; cv=none; b=WNPbxqGoSBFxsO3LFV7z7JlzH8rIkOwj2+jtU3xkW4pq7xP5y/nUjYjww/W0v+5OPSRYWfh1OhG6e/DToSlD5d5J/SYFKdXsnalmYGiKB35zoAeVAWdfF0oh3HCJuScPu0xE0Ki+VlC2pRI8jqVP7a4dHa6tVZPM6WOqVgZNxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786689; c=relaxed/simple;
	bh=VpUOAyI3PEU1aI29OTID3pdLxcQRJd0sc7FayWsDQkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQD1sX8Use16JI/CP0HNDt9HAcfW03wi4qUKsrJrPBZEb/bVv/gn+geoyI+WnnFLD+A5DvXuYxUEFT1HS3DahMe+4wV4+W2+jg6hsXOCw2kTYpGyzt4jJ8XjKgMC0JCS4/ZkDgLmA56q4DT8dGQ2wnVhI9mMBbWRG9T+PrYoMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4nsVUF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F72C4CEE3;
	Wed, 12 Mar 2025 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741786688;
	bh=VpUOAyI3PEU1aI29OTID3pdLxcQRJd0sc7FayWsDQkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4nsVUF0hFYntBx6IEI0V6ct3WIgfPoqb4+NoCFJ/GgcG2xYhmjW/ordmQv7Fq0Gu
	 3J7luUoIMCBEj0EEfJ7V6OrgoXLS2SZkfeQbu3mHS24TinlrGz14gmWFlIdXMG0wi2
	 GmjmtgYVe7b3HQc8sUZ2X33x01yzRcUagA7H1PtdDY60utuWc5k7fCP25sofvCh22I
	 bo0Ccy7egWV4k17qcbNYV6f7Zw1l2LKACAP1pumn2djmyAkQVWPnVc0+kHDraIP+IT
	 yUJJkLEv1Pq+SLJqeiFTP6/RdCibndgX4OOY8uKUqZhKN7j8kCT3n48ejhszdvvqTf
	 ZctprJ6uUSQ2g==
Date: Wed, 12 Mar 2025 15:38:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	"longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [patch rdma-next v5 2/2] RDMA/mana_ib: Handle net
 event for pointing to the current netdev
Message-ID: <20250312133804.GC1322339@unreal>
References: <1741289079-18744-1-git-send-email-longli@linuxonhyperv.com>
 <1741289079-18744-2-git-send-email-longli@linuxonhyperv.com>
 <20250306195354.GG354403@ziepe.ca>
 <SA6PR21MB4231E9B17697BFE4857A7E55CECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
 <SA6PR21MB42316CA1E7C6CF083A89ECE4CED62@SA6PR21MB4231.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA6PR21MB42316CA1E7C6CF083A89ECE4CED62@SA6PR21MB4231.namprd21.prod.outlook.com>

On Mon, Mar 10, 2025 at 09:46:08PM +0000, Long Li wrote:
> > Subject: RE: [EXTERNAL] Re: [patch rdma-next v5 2/2] RDMA/mana_ib:
> > Handle net event for pointing to the current netdev
> > 
> > > Subject: [EXTERNAL] Re: [patch rdma-next v5 2/2] RDMA/mana_ib: Handle
> > > net event for pointing to the current netdev
> > >
> > > On Thu, Mar 06, 2025 at 11:24:39AM -0800, longli@linuxonhyperv.com
> > wrote:
> > > > +	switch (event) {
> > > > +	case NETDEV_CHANGEUPPER:
> > > > +		ndev = mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
> > > > +		/*
> > > > +		 * RDMA core will setup GID based on updated netdev.
> > > > +		 * It's not possible to race with the core as rtnl lock is being
> > > > +		 * held.
> > > > +		 */
> > > > +		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> > > > +
> > > > +		/* mana_get_primary_netdev() returns ndev with refcount
> > held
> > > */
> > > > +		netdev_put(ndev, &dev->dev_tracker);
> > >
> > > ? What is the point of a tracker in dev if it never lasts outside this scope?
> > >
> > > ib_device_set_netdev() already has a tracker built into it.
> > >
> > > Jason
> > 
> > I was asked to use a tracker for netdev_hold()/netdev_put(). But this code
> > (and the code in mana_ib_probe() of the 1st patch) is simple enough that
> > everything is done in one scope.
> > 
> > Jakub, do you think it's okay to use NULL as the tracker in both patches?
> > 
> > Long
> 
> Hi, 
> 
> If we don't want to use a tracker, can we take the v4 version of the patch set?
> 
> Otherwise, please take v5 (this patch) if a tracker is required.

Let's use v5 version as it is more complete variant, however the series
needs to be rebased as it doesn't apply after Konstantin's changes.

Thanks

> 
> Thanks,
> Long

