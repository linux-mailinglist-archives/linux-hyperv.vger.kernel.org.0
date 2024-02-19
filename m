Return-Path: <linux-hyperv+bounces-1568-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A406859EC8
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 09:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F9B2322E
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C8421362;
	Mon, 19 Feb 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f+PyqisD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8754D2135A;
	Mon, 19 Feb 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332658; cv=none; b=LEIDA0p51dezfm6UYK1+rQE8ONiN036zlMHyfq7wQtxCBvVCQuuyFdyrT0HIRt82QUk5B3NQbs40YxTGsIGn827RPX1050G1oDRTcUvJxrKbSejgGEjztOZzvkcQyttBdBIIIOPGC35FYopzNRKDVbHkOcqaVS65Tnk1K6Fu+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332658; c=relaxed/simple;
	bh=Gdta+sVIghXZf3QcsNLG8QdvkbpOc6nIYPto/FbjQvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNKZfPhHXUYwkk5tQNh1yJnLGpX1qYQZyFUbikeBN81KaBC2fBFKL92HWkhykA2MDyyXwK72GfQ0XcOvsdRa2YUdXZl7DS3Dsr9xodYnQKiWogxVKqPXMdAGBk8BdQWVDq5osWG2WPtXG50jVTJcQBKAxd984GhLRoDaUEQF2zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f+PyqisD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B934C433C7;
	Mon, 19 Feb 2024 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708332658;
	bh=Gdta+sVIghXZf3QcsNLG8QdvkbpOc6nIYPto/FbjQvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+PyqisDcAC14HikWSUp/Z/VjeWy3jqmgEHCrZb4vs0NIrpjJ8ZF0KoLUU/CT3gMg
	 isOPrvk/flo5SEC1O/LpqHHZWt8Qa4McEC1goD+k6IEdNb+ZevFKpN31mIuGPFtz/R
	 DBVVp7q9BgBvIiqJ6S0oEDumtv1eHK2aKrmABIEk=
Date: Mon, 19 Feb 2024 09:50:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 2/6] uio_hv_generic: Query the ringbuffer size for device
Message-ID: <2024021920-wincing-dyslexic-aae1@gregkh>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-3-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708193020-14740-3-git-send-email-ssengar@linux.microsoft.com>

On Sat, Feb 17, 2024 at 10:03:36AM -0800, Saurabh Sengar wrote:
> Query the ring buffer size from pre defined table per device.
> Keep the size as is if the device doesn't have any preferred
> ring size.

What is the "as is" size?

> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 20d9762331bd..4bda6b52e49e 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -238,6 +238,7 @@ hv_uio_probe(struct hv_device *dev,
>  	struct hv_uio_private_data *pdata;
>  	void *ring_buffer;
>  	int ret;
> +	size_t ring_size = hv_dev_ring_size(channel);
>  
>  	/* Communicating with host has to be via shared memory not hypercall */
>  	if (!channel->offermsg.monitor_allocated) {
> @@ -245,12 +246,14 @@ hv_uio_probe(struct hv_device *dev,
>  		return -ENOTSUPP;
>  	}
>  
> +	if (!ring_size)
> +		ring_size = HV_RING_SIZE * PAGE_SIZE;

Why the magic * PAGE_SIZE here?

Where is it documented that ring_size is in pages?

And what happens when PAGE_SIZE is changed?  Why are you relying on that
arbritrary value to dictate your buffer sizes to a device that has
no relationship with PAGE_SIZE?

Yes, I know you are copying what was there today, but you have the
chance to rethink and most importantly, DOCUMENT this decision properly
now.

thanks,

greg k-h

