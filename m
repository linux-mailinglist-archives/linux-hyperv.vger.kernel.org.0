Return-Path: <linux-hyperv+bounces-3899-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B62A3117A
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5991883304
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83153253F03;
	Tue, 11 Feb 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UwyAKUUt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6994487A5;
	Tue, 11 Feb 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291513; cv=none; b=eJOMueWdfte0A6/vrw4cEf0WA/t2KFTL4mHfUrRahkAf+mwwfr+18d8BluuYakVYM85QpBN4/emTbznmlQc9voi/1ZnFhGUpQ3NQqeqaF0RmmKG6V60peZk9txQEvEGQoIrEOctZHWNsGkHYoQtP8OuznjWMurktPO8lICTxZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291513; c=relaxed/simple;
	bh=pehVcrgW3SFfnn6VXusU1IW7wP1uKwpQyMQ/ubP88ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6VgVrlXpCHHEwCPUdk31Xo4gjS31l7sr9UweVIpQL7Bv6+wG6klH6uM+W6qJLiItaSYHhYyQ4QfbLsUmNvgSGh80Kf3MseOsF+z9P4ugEJ4xxVUImLI3Nl9MLz9H7W6Ldzo8ZcEvy3p8AVl/CMjBfd4MJO1k3H5M9pRguXX5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UwyAKUUt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kze9YHynH4qYxAJtq69RRqc96/Z65kKEF5K1+McSQLc=; b=UwyAKUUtTUXKhqfY1X8elku9Vv
	02RwzlqYcuQXHrn7NDqU+oj+cAqkGNZFrO6Id6se5h8JKKXKOwR1rqmP7H3XccoJeOS6Y+BmsNAFQ
	Wc9MiB8gDDB6htFT1+AiaK50aUHCYIJjMx4UhP1K1HH5hGz2xWROimjb2nPcW8diiuWM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thtAQ-00D7IH-B4; Tue, 11 Feb 2025 17:31:22 +0100
Date: Tue, 11 Feb 2025 17:31:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
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
Message-ID: <ab47dc52-3bb3-4b69-b202-b59fe4cb0727@lunn.ch>
References: <1739267515-31187-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1739267515-31187-1-git-send-email-ernis@linux.microsoft.com>

On Tue, Feb 11, 2025 at 01:51:55AM -0800, Erni Sri Satya Vennela wrote:
> Add debug statements to assist in debugging and monitoring
> driver behaviour, making it easier to identify potential
> issues  during development and testing.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 52 +++++++++++++----
>  .../net/ethernet/microsoft/mana/hw_channel.c  |  6 +-
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 58 +++++++++++++++----
>  3 files changed, 94 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index be95336ce089..f9839938f0ab 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -666,8 +666,11 @@ int mana_gd_create_hwc_queue(struct gdma_dev *gd,
>  
>  	gmi = &queue->mem_info;
>  	err = mana_gd_alloc_memory(gc, spec->queue_size, gmi);
> -	if (err)
> +	if (err) {
> +		dev_err(gc->dev, "GDMA queue type: %d, size: %u, gdma memory allocation err: %d\n",
> +			spec->type, spec->queue_size, err);

I would expect a debug statement to use dev_dbg(). Please update your
commit message.

>  		goto free_q;
> +	}
>  
>  	queue->head = 0;
>  	queue->tail = 0;
> @@ -688,6 +691,8 @@ int mana_gd_create_hwc_queue(struct gdma_dev *gd,
>  	*queue_ptr = queue;
>  	return 0;
>  out:
> +	dev_err(gc->dev, "Failed to create queue type %d of size %u, err: %d\n",
> +		spec->type, spec->queue_size, err);
>  	mana_gd_free_memory(gmi);
>  free_q:
>  	kfree(queue);
> @@ -763,14 +768,18 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
>  
>  	if (resp.hdr.status ||
>  	    resp.dma_region_handle == GDMA_INVALID_DMA_REGION) {
> -		dev_err(gc->dev, "Failed to create DMA region: 0x%x\n",
> -			resp.hdr.status);
>  		err = -EPROTO;
>  		goto out;
>  	}
>  
>  	gmi->dma_region_handle = resp.dma_region_handle;
> +	dev_dbg(gc->dev, "Created DMA region handle 0x%llx\n",
> +		gmi->dma_region_handle);

Given all the dev_err() you have added, do this add any value? Is
there a way out of this function which is not a success and does not
print an error?

    Andrew

---
pw-bot: cr

