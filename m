Return-Path: <linux-hyperv+bounces-2303-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7858FADAC
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AE9283FEF
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CA4142652;
	Tue,  4 Jun 2024 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djjIM4qP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8F3EA69;
	Tue,  4 Jun 2024 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489931; cv=none; b=IYDYws4hTtQ1gRSBKzVdkD7wN3P8xuxKsrZK9tBuI7Qfm1cLYufDkKEzlwa2x2VbPx4JPQhbXa/bPmbB0TAU8ZYhY2KbaRn5RX9VGmPLETwaYgijK3NDEfRIRBa/NHyd3mbwsVa/OyO3Sy9jU3PEC90pI9vNxavT3y7ABNx/zwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489931; c=relaxed/simple;
	bh=TudwJC2mySdD/07ev8fN3GTUmSReWRPtzu1meagMp/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezgiTb7Luq2jRl3UTmK6AWnLY64VjzmZvZ9dHOMRD0hZIevjIdwcQaW0oq9NasRmVd/QvNLvMG7VUCTKW2M0vxKbVM1fSL8NxagC/V0gKwKhYNbOkYXRCFqmziXqUgTxciWfRcCUhcqEHQ7dMC1D8RAZX8B8B4f1rsC0cTdiOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djjIM4qP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03605C2BBFC;
	Tue,  4 Jun 2024 08:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717489930;
	bh=TudwJC2mySdD/07ev8fN3GTUmSReWRPtzu1meagMp/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djjIM4qPJVvrJG/3oJFJKYFcNfV4LBHhTfXOXQTK9uWabNERAkHOiFGl7aB3GTDKh
	 H7dtfSszw4s3g0rwbaup+mGPZbxOktbd2DCOlNQmX5iOqFyZ6pDT0D0gDd3Uzt7kD4
	 H8EIcZtNOj1saTPyh6yDdBPTVF1PC0aDCoQpICV5YHgm9vKlAiOsgyI/tycdgQ6Wzn
	 e5shvqY+wz7nAmETFN4jX84LdPbmXWXbly5bmhCI1yN+mEoUz1BZeSaTl2sKWHLoQJ
	 so68vwEQAAdK2f88icoWLLl9xICHJwchQwEx1B3F/GNs9PSNTI/Tv728K8QNKY+dlg
	 RY/T3BIzfCXZQ==
Date: Tue, 4 Jun 2024 11:32:05 +0300
From: Leon Romanovsky <leon@kernel.org>
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
	Jason Gunthorpe <jgg@ziepe.ca>, Long Li <longli@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v3] net: mana: Allow variable size indirection
 table
Message-ID: <20240604083205.GM3884@unreal>
References: <1717169861-15825-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240603084122.GK3884@unreal>
 <20240604053648.GA14220@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604053648.GA14220@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Jun 03, 2024 at 10:36:48PM -0700, Shradha Gupta wrote:
> On Mon, Jun 03, 2024 at 11:41:22AM +0300, Leon Romanovsky wrote:
> > On Fri, May 31, 2024 at 08:37:41AM -0700, Shradha Gupta wrote:
> > > Allow variable size indirection table allocation in MANA instead
> > > of using a constant value MANA_INDIRECT_TABLE_SIZE.
> > > The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> > > indirection table is allocated dynamically.
> > > 
> > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > ---
> > >  Changes in v3:
> > >  * Fixed the memory leak(save_table) in mana_set_rxfh()
> > > 
> > >  Changes in v2:
> > >  * Rebased to latest net-next tree
> > >  * Rearranged cleanup code in mana_probe_port to avoid extra operations
> > > ---
> > >  drivers/infiniband/hw/mana/qp.c               | 10 +--
> > >  drivers/net/ethernet/microsoft/mana/mana_en.c | 68 ++++++++++++++++---
> > >  .../ethernet/microsoft/mana/mana_ethtool.c    | 27 +++++---
> > >  include/net/mana/gdma.h                       |  4 +-
> > >  include/net/mana/mana.h                       |  9 +--
> > >  5 files changed, 89 insertions(+), 29 deletions(-)
> > 
> > <...>
> > 
> > > +free_indir:
> > > +	apc->indir_table_sz = 0;
> > > +	kfree(apc->indir_table);
> > > +	apc->indir_table = NULL;
> > > +	kfree(apc->rxobj_table);
> > > +	apc->rxobj_table = NULL;
> > >  reset_apc:
> > >  	kfree(apc->rxqs);
> > >  	apc->rxqs = NULL;
> > > @@ -2897,6 +2936,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
> > >  {
> > 
> > <...>
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
> > Why do you need to NULLify here? Will apc is going to be accessible
> > after call to mana_remove? or port probe failure?
> Right, they won't be accessed. This is just for the sake of completeness
> and to prevent double free in case there are code bug in other place.

This coding patter is called defensive programming, which is discouraged
in the kernel. You are not preventing double free, but hiding bugs which
were possible to be found by various static analysis tools.

Please don't do it.

Thanks

> 
> Regards,
> Shradha.
> > 
> > Thanks

