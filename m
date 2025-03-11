Return-Path: <linux-hyperv+bounces-4382-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B13A5B7E3
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 05:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6D83A3415
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 04:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420FB1E47CA;
	Tue, 11 Mar 2025 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pBsRYPpF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14581DEFC6;
	Tue, 11 Mar 2025 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741666339; cv=none; b=u4kd5W34QvR+INI0bfN/j+dYTiMH7eJcnIGTOVCg43pF/dUc/W3ngCkZq3L9u9YUrsOHJD5sbb9aqjjwefQyEg0QrMxGlvFHa0AohH5SsG5XoSJyeTYCgU39Yz4bg4dsul8UOLJphBhSaUt9JylEdZQVdhY+HMR6baadKpZpxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741666339; c=relaxed/simple;
	bh=K2+jhtniO3+sHD1likhsY/r8f6NPabjz7wCK5LeoxT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJyycuF49I6EaXL7OqnB91EIHJBuUcYF9E5bTc6W+RaccD8Rjm5EdpTJNoSpxl/BB+IkkrFSt0M7mf9J1waELu82z21AMoxLwEU98Gw3FCQL4u/5NvBu03zzGSQkALwr9ck07fBl+Ov8tbl1SVqTFK8RweHGj549fVySH2Iyq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pBsRYPpF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 47A872111424; Mon, 10 Mar 2025 21:12:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47A872111424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741666337;
	bh=T4+3byS9QQCfauiu8VrCImosgNfjC6A7fWIdxfJ3XmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBsRYPpFjClheI959zyEe9W0iYPXY7ggT50J2AHGv3BoqwISxBkoPcaNfoHLuxhrH
	 9zkkhgeZu3dek9q/qE9bvBzhBPUBU4fXKPQef742EFYeu9JUI4ztlz4Lh6g64aPQO/
	 GPciJqaCAfZfEY6u9dLLk3Mt7g+EQOeewfmvISFo=
Date: Mon, 10 Mar 2025 21:12:17 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch v3] uio_hv_generic: Set event for all channels on the
 device
Message-ID: <20250311041217.GA7165@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741644721-20389-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741644721-20389-1-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 10, 2025 at 03:12:01PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Hyper-V may offer a non latency sensitive device with subchannels without
> monitor bit enabled. The decision is entirely on the Hyper-V host not
> configurable within guest.
> 
> When a device has subchannels, also signal events for the subchannel
> if its monitor bit is disabled.
> 
> This patch also removes the memory barrier when monitor bit is enabled
> as it is not necessary. The memory barrier is only needed between
> setting up interrupt mask and calling vmbus_set_event() when monitor
> bit is disabled.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> Change log
> v2: Use vmbus_set_event() to avoid additional check on monitored bit
>     Lock vmbus_connection.channel_mutex when going through subchannels
> v3: Add details in commit messsage on the memory barrier.
> 
>  drivers/uio/uio_hv_generic.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 3976360d0096..45be2f8baade 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -65,6 +65,16 @@ struct hv_uio_private_data {
>  	char	send_name[32];
>  };
>  
> +static void set_event(struct vmbus_channel *channel, s32 irq_state)
> +{
> +	channel->inbound.ring_buffer->interrupt_mask = !irq_state;
> +	if (!channel->offermsg.monitor_allocated && irq_state) {
> +		/* MB is needed for host to see the interrupt mask first */
> +		virt_mb();
> +		vmbus_set_event(channel);
> +	}
> +}
> +
>  /*
>   * This is the irqcontrol callback to be registered to uio_info.
>   * It can be used to disable/enable interrupt from user space processes.
> @@ -79,12 +89,15 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
>  {
>  	struct hv_uio_private_data *pdata = info->priv;
>  	struct hv_device *dev = pdata->device;
> +	struct vmbus_channel *primary, *sc;
>  
> -	dev->channel->inbound.ring_buffer->interrupt_mask = !irq_state;
> -	virt_mb();
> +	primary = dev->channel;
> +	set_event(primary, irq_state);
>  
> -	if (!dev->channel->offermsg.monitor_allocated && irq_state)
> -		vmbus_setevent(dev->channel);
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	list_for_each_entry(sc, &primary->sc_list, sc_list)
> +		set_event(sc, irq_state);
> +	mutex_unlock(&vmbus_connection.channel_mutex);
>  
>  	return 0;
>  }
> @@ -95,12 +108,19 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
>  static void hv_uio_channel_cb(void *context)
>  {
>  	struct vmbus_channel *chan = context;
> -	struct hv_device *hv_dev = chan->device_obj;
> -	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
> +	struct hv_device *hv_dev;
> +	struct hv_uio_private_data *pdata;
>  
>  	chan->inbound.ring_buffer->interrupt_mask = 1;
>  	virt_mb();
>  
> +	/*
> +	 * The callback may come from a subchannel, in which case look
> +	 * for the hv device in the primary channel
> +	 */
> +	hv_dev = chan->primary_channel ?
> +		 chan->primary_channel->device_obj : chan->device_obj;
> +	pdata = hv_get_drvdata(hv_dev);
>  	uio_event_notify(&pdata->info);
>  }
>  
> -- 
> 2.34.1
> 

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

- Saurabh

