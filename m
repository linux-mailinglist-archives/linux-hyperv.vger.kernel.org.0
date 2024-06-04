Return-Path: <linux-hyperv+bounces-2306-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1863D8FAEEB
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A5128A0AF
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0EB143C62;
	Tue,  4 Jun 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn7WkOYs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9223823BC;
	Tue,  4 Jun 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493636; cv=none; b=j0ZGI1AwfRjfRtSN9VZ3p3qVuzVGkrElYMbTH3rlPqQ/R0wPthh/cmwZ1bRmURuRp9y0ggT3Zg00Ba61nGc2KKOYpzcZ5Q6xf2k0WFQcjd8G0YUgwp4tvU78VTHTmopC7V6rr4lQ1yqRWQ2D4D8ELumXGKA3EuIipBVGsM3RC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493636; c=relaxed/simple;
	bh=JaaBIIXHCbGmOzepuoBGmKbypMRkED1xayHQDMMQjEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH5+WqZEgPUPvtRrFeURfNYjy8BBzkfkvXLkJ1YIqyV8VQ3WpSWac8zlwOkPdSSzC4sG3oTa/FmC0J/fM17vlkX1WTarKdJRov3OBOIPJ4NC6zQve46UICJyHJD3w6jxTWQg7927PszVClhHo/ioBCP52YvMn+2KS0CILyXwIy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn7WkOYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88107C2BBFC;
	Tue,  4 Jun 2024 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717493636;
	bh=JaaBIIXHCbGmOzepuoBGmKbypMRkED1xayHQDMMQjEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tn7WkOYsrinLNfR1Du+opWfBFE7yf+/ugsZL2M5cccHBKPwCqejGEim1s4caAxbEn
	 S0liFqOnftGDQmZfQQEggAZRVgKPq+hN9NQ2K20VuNln3Huid/Am6eDHY80NxSYF+Y
	 RKwvO5HffShDqgg53uVB0aClx2p53l/w6k2exB3SLQH1aSjNRBk0xeG4R9+SAD3Rb/
	 p3of3H88+TFLAHUS2JXWM1XLHCwGK1OTa0OtPMogh66HmhOK0fUyal4a+qSHZPq77w
	 cYoQdQv4lTIUxBJTEL6xELT6wXRJ5mcnraBoB+xG+anxvpSQKmhLxuom2hU/Y+Jw6M
	 AwNU8QrQN45Kw==
Date: Tue, 4 Jun 2024 10:33:49 +0100
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
Message-ID: <20240604093349.GP491852@kernel.org>
References: <1717169861-15825-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717169861-15825-1-git-send-email-shradhagupta@linux.microsoft.com>

On Fri, May 31, 2024 at 08:37:41AM -0700, Shradha Gupta wrote:
> Allow variable size indirection table allocation in MANA instead
> of using a constant value MANA_INDIRECT_TABLE_SIZE.
> The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> indirection table is allocated dynamically.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

...

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c

...

> @@ -2344,11 +2352,33 @@ static int mana_create_vport(struct mana_port_context *apc,
>  	return mana_create_txq(apc, net);
>  }
>  
> +static int mana_rss_table_alloc(struct mana_port_context *apc)
> +{
> +	if (!apc->indir_table_sz) {
> +		netdev_err(apc->ndev,
> +			   "Indirection table size not set for vPort %d\n",
> +			   apc->port_idx);
> +		return -EINVAL;
> +	}
> +
> +	apc->indir_table = kcalloc(apc->indir_table_sz, sizeof(u32), GFP_KERNEL);
> +	if (!apc->indir_table)
> +		return -ENOMEM;
> +
> +	apc->rxobj_table = kcalloc(apc->indir_table_sz, sizeof(mana_handle_t), GFP_KERNEL);
> +	if (!apc->rxobj_table) {
> +		kfree(apc->indir_table);

Hi, Shradha

Perhaps I am on the wrong track here, but I have some concerns
about clean-up paths.

Firstly.  I think that apc->indir_table should be to NULL here for
consistency with other clean-up paths. Or alternatively, fields of apc
should not set to NULL elsewhere after being freed.

In looking into this I noticed that mana_probe() does not call
mana_remove() or return an error in the cases where mana_probe_port() or
mana_attach() fail unless add_adev also fails. If so, is that intentional?

In any case, I would suggest as a follow-up, arranging things so that when
an error occurs in a function, anything that was allocated is unwound
before returning an error.

I think this would make allocation/deallocation easier to reason with.
And I suspect it would avoid both the need for fields of structures to be
zeroed after being freed, and the need to call mana_remove() from
mana_probe().

> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>  static void mana_rss_table_init(struct mana_port_context *apc)
>  {
>  	int i;
>  
> -	for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
> +	for (i = 0; i < apc->indir_table_sz; i++)
>  		apc->indir_table[i] =
>  			ethtool_rxfh_indir_default(i, apc->num_queues);
>  }

...

> @@ -2739,11 +2772,17 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  	err = register_netdev(ndev);
>  	if (err) {
>  		netdev_err(ndev, "Unable to register netdev.\n");
> -		goto reset_apc;
> +		goto free_indir;
>  	}
>  
>  	return 0;
>  
> +free_indir:
> +	apc->indir_table_sz = 0;
> +	kfree(apc->indir_table);
> +	apc->indir_table = NULL;
> +	kfree(apc->rxobj_table);
> +	apc->rxobj_table = NULL;
>  reset_apc:
>  	kfree(apc->rxqs);
>  	apc->rxqs = NULL;

nit: Not strictly related to this patch, but the reset_apc code should
     probably be a call to mana_cleanup_port_context() as it is the dual of
     mana_init_port_context() which is called earlier in mana_probe_port()

...

> @@ -2931,6 +2972,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  		}
>  
>  		unregister_netdevice(ndev);
> +		apc->indir_table_sz = 0;
> +		kfree(apc->indir_table);
> +		apc->indir_table = NULL;
> +		kfree(apc->rxobj_table);
> +		apc->rxobj_table = NULL;

The code to free and zero indir_table_sz and indir_table appears twice
in this patch. Perhaps a helper to do this, which would be the dual
of mana_rss_table_alloc is in order.

>  
>  		rtnl_unlock();
>  

...

