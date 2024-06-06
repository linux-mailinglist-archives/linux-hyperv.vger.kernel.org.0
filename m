Return-Path: <linux-hyperv+bounces-2335-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73F98FF28E
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2024 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C5B1C25948
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2024 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D9F21340;
	Thu,  6 Jun 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7IgvyVy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215210E9;
	Thu,  6 Jun 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691621; cv=none; b=RSBhV/5fq+Eclg45OHpMARDhLih2v/PTWu5abktI6zOgmriSVhlIoeFuxG/pc6HsOgS89ykMalH22uUa+u2riqRA83M1hpQ+EVGtKRgizHvfU/uLDL9nMGlumLjnetK9ng8M1fblamh8KsT1gM/GcywVPHYwQ0glPeXNNZ1dTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691621; c=relaxed/simple;
	bh=Dd5xuQCXjQbAM4QC/1i17ToQ5z+UxwV8krZqgKleMYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXnKN5bM335cE7uWYGeMDN5AgGF4fBsGHDCjwfitlaE54wj7J68NKMfBpMvBRjvM7gDVDrqoAXlpKYTx50fiUjhJKD+X3BOQ2iGS7P5huADNsQZCKu/BfFaiVoULg/XBFleBu2u7vdtbJpQvxV9Ts665lZLuYIhXzYYBTYCJD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7IgvyVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CD4C32786;
	Thu,  6 Jun 2024 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717691621;
	bh=Dd5xuQCXjQbAM4QC/1i17ToQ5z+UxwV8krZqgKleMYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7IgvyVyr7ONSY69TsofxX/n2zPzWdGiDcLRgwHNaOQnF4ChSokqEP6+OBPUZ4M2B
	 koC4aXtmLTtI+gRNseSk1bhrMQBo4CfnYkPOEwOATqot2X0YSd0OyAT/mp8sAAP7TH
	 bSV+3rqixQgyaDXW3hvpbA+1bCSRnmhKE7+ZbIJJmp5raQ/6l4XiPaiDh20wOESBHt
	 TYqORfpFQu+hom7AZnFiGKKv4xwR4NY3MM7GQbxCDOXPFtpOhbNadzwYNI85vjaRpp
	 rEf2QOO6Q6CJv80aHUhXQXetttQ+qYZ+oEPg8MoHqwPampnfw2vRyu1JcxfJOoreGw
	 TxA2SMRKurJ5A==
Date: Thu, 6 Jun 2024 17:33:34 +0100
From: Simon Horman <horms@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
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
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Long Li <longli@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v3] net: mana: Allow variable size indirection
 table
Message-ID: <20240606163334.GO791188@kernel.org>
References: <1717169861-15825-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240604093349.GP491852@kernel.org>
 <20240605083906.GA15889@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605083906.GA15889@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Wed, Jun 05, 2024 at 01:39:06AM -0700, Shradha Gupta wrote:
> On Tue, Jun 04, 2024 at 10:33:49AM +0100, Simon Horman wrote:
> > On Fri, May 31, 2024 at 08:37:41AM -0700, Shradha Gupta wrote:
> > > Allow variable size indirection table allocation in MANA instead
> > > of using a constant value MANA_INDIRECT_TABLE_SIZE.
> > > The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> > > indirection table is allocated dynamically.
> > > 
> > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > 
> > ...
> > 
> > > @@ -2344,11 +2352,33 @@ static int mana_create_vport(struct mana_port_context *apc,
> > >  	return mana_create_txq(apc, net);
> > >  }
> > >  
> > > +static int mana_rss_table_alloc(struct mana_port_context *apc)
> > > +{
> > > +	if (!apc->indir_table_sz) {
> > > +		netdev_err(apc->ndev,
> > > +			   "Indirection table size not set for vPort %d\n",
> > > +			   apc->port_idx);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	apc->indir_table = kcalloc(apc->indir_table_sz, sizeof(u32), GFP_KERNEL);
> > > +	if (!apc->indir_table)
> > > +		return -ENOMEM;
> > > +
> > > +	apc->rxobj_table = kcalloc(apc->indir_table_sz, sizeof(mana_handle_t), GFP_KERNEL);
> > > +	if (!apc->rxobj_table) {
> > > +		kfree(apc->indir_table);
> > 
> > Hi, Shradha
> > 
> > Perhaps I am on the wrong track here, but I have some concerns
> > about clean-up paths.
> > 
> > Firstly.  I think that apc->indir_table should be to NULL here for
> > consistency with other clean-up paths. Or alternatively, fields of apc
> > should not set to NULL elsewhere after being freed.
> 
> Hi Simon,
> 
> Thanks for the comments. This makes sense, I am planning of consistently
> removing the NULLify from other places too as per Leon's comments.

Great!

> > In looking into this I noticed that mana_probe() does not call
> > mana_remove() or return an error in the cases where mana_probe_port()
> > or mana_attach() fail unless add_adev also fails. If so, is that
> > intentional?
> 
> Right, so most calls like mana_probe_port(), mana_attach() cleanup after
> themselves in the code if there is any error. So, not having to call
> mana_remove() in these cases in mana_probe() is intentional. But I do
> agree that an error is returned in mana_probe() only if add_adev also
> fails. I'll fix that too in the next version

I'm not entirely sure, but perhaps that is a candidate for a separate patch.

> > 
> > In any case, I would suggest as a follow-up, arranging things so that
> > when an error occurs in a function, anything that was allocated is
> > unwound before returning an error.
> > 
> > I think this would make allocation/deallocation easier to reason with.
> > And I suspect it would avoid both the need for fields of structures to
> > be zeroed after being freed, and the need to call mana_remove() from
> > mana_probe().
> 
> Agreed
> > 
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static void mana_rss_table_init(struct mana_port_context *apc)
> > >  {
> > >  	int i;
> > >  
> > > -	for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
> > > +	for (i = 0; i < apc->indir_table_sz; i++)
> > >  		apc->indir_table[i] =
> > >  			ethtool_rxfh_indir_default(i, apc->num_queues);
> > >  }
> > 
> > ...
> > 
> > > @@ -2739,11 +2772,17 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
> > >  	err = register_netdev(ndev);
> > >  	if (err) {
> > >  		netdev_err(ndev, "Unable to register netdev.\n");
> > > -		goto reset_apc;
> > > +		goto free_indir;
> > >  	}
> > >  
> > >  	return 0;
> > >  
> > > +free_indir:
> > > +	apc->indir_table_sz = 0;
> > > +	kfree(apc->indir_table);
> > > +	apc->indir_table = NULL;
> > > +	kfree(apc->rxobj_table);
> > > +	apc->rxobj_table = NULL;
> > >  reset_apc:
> > >  	kfree(apc->rxqs);
> > >  	apc->rxqs = NULL;
> > 
> > nit: Not strictly related to this patch, but the reset_apc code should
> >      probably be a call to mana_cleanup_port_context() as it is the dual of
> >      mana_init_port_context() which is called earlier in mana_probe_port()
> 
> Sure, let me do that too.

FWIIW, I think it would be appropriate to put that change in a separate patch.

> > 
> > ...
> > 
> > > @@ -2931,6 +2972,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
> > >  		}
> > >  
> > >  		unregister_netdevice(ndev);
> > > +		apc->indir_table_sz = 0;
> > > +		kfree(apc->indir_table);
> > > +		apc->indir_table = NULL;
> > > +		kfree(apc->rxobj_table);
> > > +		apc->rxobj_table = NULL;
> > 
> > The code to free and zero indir_table_sz and indir_table appears twice
> > in this patch. Perhaps a helper to do this, which would be the dual
> > of mana_rss_table_alloc is in order.
> Makes sense, will change this too.

Thanks.

