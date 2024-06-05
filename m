Return-Path: <linux-hyperv+bounces-2321-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8D48FC6D5
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2024 10:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2768B261BE
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2024 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8061946BF;
	Wed,  5 Jun 2024 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HanVOSjg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C324963E;
	Wed,  5 Jun 2024 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576748; cv=none; b=bBqgBXiHTKtnlmPGPGLsThf5q+nlPblj+RoNSQnDcxFvGogo1gSSdTBVAyfURlt9SXu5Juq+wODpwbT3vDhJfnXg7Ef6x3wpAdSbNXIwSSDO/+z/QuHIBnG7We/UhcbUka0TqXDNitp3+Tv0CCvLUVSbOrNH2sDNZdOGRuBnSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576748; c=relaxed/simple;
	bh=CNAuilfiRwwKm0fGNUOB0FH43WBrxg4Srl1Cepe++Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ashag912Xmsgkj1v3d1VQakwdi438KNAGYLQtacsom2XSKIaWvXcsJ9j5jxCUbKxTUb6pLBomch2ei33E8hN+qtkz8xV+BybGqx78jagWqsUUBGNzw0LJqI9AVFj8QJl1uTLv4LW7Q3LCrm0+upQLMWVY8Lbcfagm7tTCYhfyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HanVOSjg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 678D120B9260; Wed,  5 Jun 2024 01:39:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 678D120B9260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717576746;
	bh=TrGB2Ttu+2GQP4P667beS3OkIPRmk8NFPGqeTHHLFWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HanVOSjgakHW3wIPeXeqrGKQ1S3YE4V/rsqZcbU8ENuI6HzP2JbQ/gZM2NzgEAvV9
	 yutTk2fmzDfEd/kXALFdNom5jAXN17IeP5kKUuv8Xwe4sB7CPBfj4TsdS90ZzkH58c
	 fDqpCeXRUSUtle0vYZxpyFrajGZLw4X+sjyHRrpQ=
Date: Wed, 5 Jun 2024 01:39:06 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
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
Message-ID: <20240605083906.GA15889@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1717169861-15825-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240604093349.GP491852@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604093349.GP491852@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jun 04, 2024 at 10:33:49AM +0100, Simon Horman wrote:
> On Fri, May 31, 2024 at 08:37:41AM -0700, Shradha Gupta wrote:
> > Allow variable size indirection table allocation in MANA instead
> > of using a constant value MANA_INDIRECT_TABLE_SIZE.
> > The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> > indirection table is allocated dynamically.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> 
> ...
> 
> > @@ -2344,11 +2352,33 @@ static int mana_create_vport(struct mana_port_context *apc,
> >  	return mana_create_txq(apc, net);
> >  }
> >  
> > +static int mana_rss_table_alloc(struct mana_port_context *apc)
> > +{
> > +	if (!apc->indir_table_sz) {
> > +		netdev_err(apc->ndev,
> > +			   "Indirection table size not set for vPort %d\n",
> > +			   apc->port_idx);
> > +		return -EINVAL;
> > +	}
> > +
> > +	apc->indir_table = kcalloc(apc->indir_table_sz, sizeof(u32), GFP_KERNEL);
> > +	if (!apc->indir_table)
> > +		return -ENOMEM;
> > +
> > +	apc->rxobj_table = kcalloc(apc->indir_table_sz, sizeof(mana_handle_t), GFP_KERNEL);
> > +	if (!apc->rxobj_table) {
> > +		kfree(apc->indir_table);
> 
> Hi, Shradha
> 
> Perhaps I am on the wrong track here, but I have some concerns
> about clean-up paths.
> 
> Firstly.  I think that apc->indir_table should be to NULL here for
> consistency with other clean-up paths. Or alternatively, fields of apc
> should not set to NULL elsewhere after being freed.

Hi Simon,

Thanks for the comments. This makes sense, I am planning of consistently removing
the NULLify from other places too as per Leon's comments.
> 
> In looking into this I noticed that mana_probe() does not call
> mana_remove() or return an error in the cases where mana_probe_port() or
> mana_attach() fail unless add_adev also fails. If so, is that intentional?

Right, so most calls like mana_probe_port(), mana_attach() cleanup after themselves
in the code if there is any error. So, not having to call mana_remove() in these
cases in mana_probe() is intentional. But I do agree that an error is returned in
mana_probe() only if add_adev also fails. I'll fix that too in the next version
> 
> In any case, I would suggest as a follow-up, arranging things so that when
> an error occurs in a function, anything that was allocated is unwound
> before returning an error.
> 
> I think this would make allocation/deallocation easier to reason with.
> And I suspect it would avoid both the need for fields of structures to be
> zeroed after being freed, and the need to call mana_remove() from
> mana_probe().

Agreed
> 
> > +		return -ENOMEM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static void mana_rss_table_init(struct mana_port_context *apc)
> >  {
> >  	int i;
> >  
> > -	for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
> > +	for (i = 0; i < apc->indir_table_sz; i++)
> >  		apc->indir_table[i] =
> >  			ethtool_rxfh_indir_default(i, apc->num_queues);
> >  }
> 
> ...
> 
> > @@ -2739,11 +2772,17 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
> >  	err = register_netdev(ndev);
> >  	if (err) {
> >  		netdev_err(ndev, "Unable to register netdev.\n");
> > -		goto reset_apc;
> > +		goto free_indir;
> >  	}
> >  
> >  	return 0;
> >  
> > +free_indir:
> > +	apc->indir_table_sz = 0;
> > +	kfree(apc->indir_table);
> > +	apc->indir_table = NULL;
> > +	kfree(apc->rxobj_table);
> > +	apc->rxobj_table = NULL;
> >  reset_apc:
> >  	kfree(apc->rxqs);
> >  	apc->rxqs = NULL;
> 
> nit: Not strictly related to this patch, but the reset_apc code should
>      probably be a call to mana_cleanup_port_context() as it is the dual of
>      mana_init_port_context() which is called earlier in mana_probe_port()

Sure, let me do that too.
> 
> ...
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
> The code to free and zero indir_table_sz and indir_table appears twice
> in this patch. Perhaps a helper to do this, which would be the dual
> of mana_rss_table_alloc is in order.
Makes sense, will change this too.

Thanks,
Shradha.
> 
> >  
> >  		rtnl_unlock();
> >  
> 
> ...

