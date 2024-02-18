Return-Path: <linux-hyperv+bounces-1561-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ED1859534
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 08:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148B0B22495
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 07:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC75E545;
	Sun, 18 Feb 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oM1LDZdN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2166E544;
	Sun, 18 Feb 2024 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708240322; cv=none; b=tdSdXBiZI6iC1c9X73ElIy2SLLT4ElOe9uk5RZTf7Iu189tB+tJB1BHZH6n7SYQCrfwItUNBRGQBF+F2gK9pQT8yfzF4M0DAvWSD110NXpr/ObSiP3ENtbjj3nupgfuyXtEHmLnBBDFimh6voE7QFb3c38gdgPV40ABHJQ23X0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708240322; c=relaxed/simple;
	bh=7kz46bBlzsC6VKg//Ry1WVNK/qIqJJJC1HkHxIrtwQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnEEXH/VFxsW7TgyRYNCBQhtyA3n5eBCXDw9oJexjmff2DMTxxtC2ADyCLJbuaN0gv+m5GM8axNCahQ0LkEBtdz3en8pmhNjrkBCdFMxt4/F9XjZkonPvAAB2B5oVVrKS8H5MqACGH7CPIFtA0MAyKirc1LZJCxAU9TfnuB1zv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oM1LDZdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BECC433F1;
	Sun, 18 Feb 2024 07:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708240321;
	bh=7kz46bBlzsC6VKg//Ry1WVNK/qIqJJJC1HkHxIrtwQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oM1LDZdN2xbLsX7070H1FVHEemh1N6DarM2Gjm7yMTCj909NRJlfO1qrj+e1ZF+GK
	 p9J56q1zV0nw/xx/OLYt98sLaUi0MLr1+yp7NTy5rK2ogf0NvuFSAqn3Bz+0bSRFqM
	 suMOUoutTdh5wENuXL55l8WHGGEHNzLTwvzxvjHE=
Date: Sun, 18 Feb 2024 08:11:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 1/6] Drivers: hv: vmbus: Add utility function for
 querying ring size
Message-ID: <2024021858-cubicle-irregular-d402@gregkh>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-2-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708193020-14740-2-git-send-email-ssengar@linux.microsoft.com>

On Sat, Feb 17, 2024 at 10:03:35AM -0800, Saurabh Sengar wrote:
> Add a function to query for the preferred ring buffer size of VMBus
> device.

That says what you did, but not why you did it.

> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 7 +++++--
>  drivers/hv/hyperv_vmbus.h | 5 +++++
>  include/linux/hyperv.h    | 1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 2f4d09ce027a..7ea444d72f9f 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -120,7 +120,8 @@ const struct vmbus_device vmbus_devs[] = {
>  	},
>  
>  	/* File copy */
> -	{ .dev_type = HV_FCOPY,
> +	{ .pref_ring_size = 0x4000,
> +	  .dev_type = HV_FCOPY,
>  	  HV_FCOPY_GUID,
>  	  .perf_device = false,
>  	  .allowed_in_isolated = false,
> @@ -141,11 +142,13 @@ const struct vmbus_device vmbus_devs[] = {
>  	},
>  
>  	/* Unknown GUID */
> -	{ .dev_type = HV_UNKNOWN,
> +	{ .pref_ring_size = 0x11000,
> +	  .dev_type = HV_UNKNOWN,

Where do these magic numbers for the size come from?

>  	  .perf_device = false,
>  	  .allowed_in_isolated = false,
>  	},
>  };
> +EXPORT_SYMBOL_GPL(vmbus_devs);
>  
>  static const struct {
>  	guid_t guid;
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index f6b1e710f805..76ac5185a01a 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -417,6 +417,11 @@ static inline bool hv_is_perf_channel(struct vmbus_channel *channel)
>  	return vmbus_devs[channel->device_id].perf_device;
>  }
>  
> +static inline size_t hv_dev_ring_size(struct vmbus_channel *channel)
> +{
> +	return vmbus_devs[channel->device_id].pref_ring_size;
> +}
> +
>  static inline bool hv_is_allocated_cpu(unsigned int cpu)
>  {
>  	struct vmbus_channel *channel, *sc;
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 2b00faf98017..5951c7bb5712 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -800,6 +800,7 @@ struct vmbus_requestor {
>  #define VMBUS_RQST_RESET (U64_MAX - 3)
>  
>  struct vmbus_device {
> +	size_t pref_ring_size;

No documentation for this?  What is the size in units of?

thanks,

greg k-h

