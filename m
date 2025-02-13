Return-Path: <linux-hyperv+bounces-3941-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23330A338DD
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 08:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A513A2924
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 07:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60AE20A5CA;
	Thu, 13 Feb 2025 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Z3bOEml/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3EA20A5DA;
	Thu, 13 Feb 2025 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431872; cv=none; b=k8sQHCuzxW+Go2e837/CWLOTcdoZFBWA/zs4zDZfYmNZk1nKpxjcqB3GEcj1SL70Fj4PnyUlUbrPg6gXOD1mklNn8uWZTI/0JMeIfrbUA2J4/ni13tMRaluyI7nMLn3VlZmSr18edgcT0Z1lVy0M9liMdO1rz4zui03S9377Yvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431872; c=relaxed/simple;
	bh=cYi0mNH+W4kVo6c2gB8r86hGerDnE4yUB+Zmvu1q7pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK8zFPtq3/z/tA3ta5Gl/AEuWpy4NU1RnpvnaaHd+qfFE3fE30LhlY6FrTkrUgtzNgffBgfpRmFzbT+KhJu8dMKiIS2ea1dekL4jsmX7Xii1oMKV9j3Cc8znPNUiM1KXGyYDaxwjUJkSttjFTVzrB4vmXT+vdddvB7MbLz5Mxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Z3bOEml/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 68C10203F3D3; Wed, 12 Feb 2025 23:31:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68C10203F3D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739431869;
	bh=QI2rMzM1udG9YAykg4Ejlut8nQl9y5XAj/a7Dc7kaCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3bOEml/wI1v5DWt+yhgJkZPUNc/YkuG50YK/ZVBwzShh+Xp/UMum3AYBo1DoPdfo
	 avqZTAieXOuOmAhbXoGJ+3myqx87Q1PxgAAZC8PhvQ73ek0nQ776aEfRJ+MZKYy27k
	 SkwFI/p6rh3GLTWeTnlVW6/sYoz03piaiB+nH8MU=
Date: Wed, 12 Feb 2025 23:31:09 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, mlevitsk@redhat.com,
	yury.norov@gmail.com, shradhagupta@linux.microsoft.com,
	kotaranov@microsoft.com, peterz@infradead.org,
	brett.creeley@amd.com, mhklinux@outlook.com,
	schakrabarti@linux.microsoft.com, kent.overstreet@linux.dev,
	longli@microsoft.com, leon@kernel.org, erick.archer@outlook.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mana: Add debug logs in MANA network driver
Message-ID: <20250213073109.GA10334@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739267515-31187-1-git-send-email-ernis@linux.microsoft.com>
 <ab47dc52-3bb3-4b69-b202-b59fe4cb0727@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab47dc52-3bb3-4b69-b202-b59fe4cb0727@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 11, 2025 at 05:31:22PM +0100, Andrew Lunn wrote:
> On Tue, Feb 11, 2025 at 01:51:55AM -0800, Erni Sri Satya Vennela wrote:
> > Add debug statements to assist in debugging and monitoring
> > driver behaviour, making it easier to identify potential
> > issues  during development and testing.
> > 
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 52 +++++++++++++----
> >  .../net/ethernet/microsoft/mana/hw_channel.c  |  6 +-
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 58 +++++++++++++++----
> >  3 files changed, 94 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index be95336ce089..f9839938f0ab 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -666,8 +666,11 @@ int mana_gd_create_hwc_queue(struct gdma_dev *gd,
> >  
> >  	gmi = &queue->mem_info;
> >  	err = mana_gd_alloc_memory(gc, spec->queue_size, gmi);
> > -	if (err)
> > +	if (err) {
> > +		dev_err(gc->dev, "GDMA queue type: %d, size: %u, gdma memory allocation err: %d\n",
> > +			spec->type, spec->queue_size, err);
> 
> I would expect a debug statement to use dev_dbg(). Please update your
> commit message.
I'll make sure to make this change in the next version of the patch.
> 
> >  		goto free_q;
> > +	}
> >  
> >  	queue->head = 0;
> >  	queue->tail = 0;
> > @@ -688,6 +691,8 @@ int mana_gd_create_hwc_queue(struct gdma_dev *gd,
> >  	*queue_ptr = queue;
> >  	return 0;
> >  out:
> > +	dev_err(gc->dev, "Failed to create queue type %d of size %u, err: %d\n",
> > +		spec->type, spec->queue_size, err);
> >  	mana_gd_free_memory(gmi);
> >  free_q:
> >  	kfree(queue);
> > @@ -763,14 +768,18 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
> >  
> >  	if (resp.hdr.status ||
> >  	    resp.dma_region_handle == GDMA_INVALID_DMA_REGION) {
> > -		dev_err(gc->dev, "Failed to create DMA region: 0x%x\n",
> > -			resp.hdr.status);
> >  		err = -EPROTO;
> >  		goto out;
> >  	}
> >  
> >  	gmi->dma_region_handle = resp.dma_region_handle;
> > +	dev_dbg(gc->dev, "Created DMA region handle 0x%llx\n",
> > +		gmi->dma_region_handle);
> 
> Given all the dev_err() you have added, do this add any value? Is
> there a way out of this function which is not a success and does not
> print an error?
> 

I wanted to provide more detailed information using dev_err and dev_dbg.
In the next version, I will retain the dev_err in the if condition as it
is, and change the dev_err to dev_dbg in the "out:" label to ensure that
most of the information gets logged.
>     Andrew
> 
> ---
> pw-bot: cr

