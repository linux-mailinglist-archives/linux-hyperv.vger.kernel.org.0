Return-Path: <linux-hyperv+bounces-2302-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25BB8FAA0B
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 07:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7D7284F70
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 05:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77D913DDD1;
	Tue,  4 Jun 2024 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bK8/7ODJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A39113D2AB;
	Tue,  4 Jun 2024 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717479410; cv=none; b=pRkccZA/97kEIwUi7Sr9IY7E/TYKeye2oPw3M0pqfavlQZykYkVsyZu4aMxTSl5gGAxu+etGOpz5yZ5df/jhB7DfGnO5IqRjJCTzI+0GpHaDi3gg0Hq7wXYmtwzi94DhVUQxfUh6agn76Jd5g3BgtAhAF+GVvMDPEibShlJZxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717479410; c=relaxed/simple;
	bh=jXpqd3FK/H/WNfQ5ni71NMR/LyQjoR0FbNVZYK5g1pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II3WYOVDhkK+vDac/zno5K8erOT9nLyXLGXQebkz6p6u+i9BvhRs5CFmFsq0YUf1pEMRGZBE5YojB3orW38pvqnU6pQrXCeusl8G3I7QuBLJ3v9AXB9mCOqalcnnDBAeegpvcr0DUik0aX8ZKx2181G3u6l3UUjyRs3XQ/Jy+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bK8/7ODJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id CFE3120681E8; Mon,  3 Jun 2024 22:36:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFE3120681E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717479408;
	bh=eG1FDBv4R7lC9lHB6vwHEI8Q/I2FDjn+gY+OQPTwEx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bK8/7ODJAyp/AdqWEbg21wvN62rRE4DCYtKwZozOr0P9Y7uzei0iX0fVAX9g//0NR
	 VNc8ZRp9gSDvEKQ1oAQiiSzO2Vy/SlCwo9znaQU1bmGC7ZL2kP6UJxktgZ684D/qsC
	 Rv5rkF60/Dcq+Sa+B3rnqI5ulPNZ9o8+yBAhSQnk=
Date: Mon, 3 Jun 2024 22:36:48 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Kees Cook <keescook@chromium.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Long Li <longli@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v3] net: mana: Allow variable size indirection
 table
Message-ID: <20240604053648.GA14220@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1717169861-15825-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240603084122.GK3884@unreal>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603084122.GK3884@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jun 03, 2024 at 11:41:22AM +0300, Leon Romanovsky wrote:
> On Fri, May 31, 2024 at 08:37:41AM -0700, Shradha Gupta wrote:
> > Allow variable size indirection table allocation in MANA instead
> > of using a constant value MANA_INDIRECT_TABLE_SIZE.
> > The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> > indirection table is allocated dynamically.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  Changes in v3:
> >  * Fixed the memory leak(save_table) in mana_set_rxfh()
> > 
> >  Changes in v2:
> >  * Rebased to latest net-next tree
> >  * Rearranged cleanup code in mana_probe_port to avoid extra operations
> > ---
> >  drivers/infiniband/hw/mana/qp.c               | 10 +--
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 68 ++++++++++++++++---
> >  .../ethernet/microsoft/mana/mana_ethtool.c    | 27 +++++---
> >  include/net/mana/gdma.h                       |  4 +-
> >  include/net/mana/mana.h                       |  9 +--
> >  5 files changed, 89 insertions(+), 29 deletions(-)
> 
> <...>
> 
> > +free_indir:
> > +	apc->indir_table_sz = 0;
> > +	kfree(apc->indir_table);
> > +	apc->indir_table = NULL;
> > +	kfree(apc->rxobj_table);
> > +	apc->rxobj_table = NULL;
> >  reset_apc:
> >  	kfree(apc->rxqs);
> >  	apc->rxqs = NULL;
> > @@ -2897,6 +2936,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
> >  {
> 
> <...>
> 
> > @@ -2931,6 +2972,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
> >  		}
> >  
> >  		unregister_netdevice(ndev);
> > +		apc->indir_table_sz = 0;
> > +		kfree(apc->indir_table);
> > +		apc->indir_table = NULL;
> > +		kfree(apc->rxobj_table);
> > +		apc->rxobj_table = NULL;
> 
> Why do you need to NULLify here? Will apc is going to be accessible
> after call to mana_remove? or port probe failure?
Right, they won't be accessed. This is just for the sake of completeness
and to prevent double free in case there are code bug in other place.

Regards,
Shradha.
> 
> Thanks

