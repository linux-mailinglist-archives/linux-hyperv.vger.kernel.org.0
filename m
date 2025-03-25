Return-Path: <linux-hyperv+bounces-4687-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A670CA7064F
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5641174BC6
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAB8257ADE;
	Tue, 25 Mar 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYiPadP7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F5255E32;
	Tue, 25 Mar 2025 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919061; cv=none; b=o+ouddcJyA/hSZit2BIwmCSYAKcBVrh3IgbPZVfAXBAY0149JB2+dC5uC0mftfobpWtr8hubtGl/6NaNCcwOoEixMxGajY3VyjBwq9NXgJO27nqsli9VP+hAeLG8BpZJjTimfYoegj6CVfcW54Dn7Pn9KnXFjaX0gymeI3CVPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919061; c=relaxed/simple;
	bh=smwmled8hr02Pgtfh3CQQ2bUvez65YipbMRkmIvNS14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYpGP6kGqv0B7SEfHaA5foMguJ1GrJ1gjcPWU7asZA88pH2odqtbW1eXtnFMmtx/OE5IjulcDvDDd8N3ZnkN/L2KKEE/C7YmHmvJqd/VDtK/xNA1lmLyilQ6lYOnXhnNmouMJPmgBMBmi4S3Vzo7d17q99YyFJ2OQmbGdIuRCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYiPadP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8460CC4CEEE;
	Tue, 25 Mar 2025 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742919060;
	bh=smwmled8hr02Pgtfh3CQQ2bUvez65YipbMRkmIvNS14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYiPadP7GRFumbzemtXxwgVauqdtAr/sBHrZMT/qlt/lVKHWplsZfr4+MbX9r5px6
	 bQQ3XdeazsSETT8KOdIWvsso7hC+2Ir5VUEk12/U5xCXY98XUMtSUBFhrbFX4UtLD2
	 I1ETLG4EtKDfabsAtAwDaDb7JrR6O35ruPeEmNzVTID7DdjEPOU4mRxgkHzuy/EjcY
	 ttWYFNgAG8FS8Cx8E0wNZusdga0AR+7Z/8yOMY2lVMg1NUcmClTBzS4rWsqR7t8+83
	 uwUjHijJRTf8TtyvTBXznXX12LTSaum6c7XT7Ch6ipWEDqNLpnyA988fzjYos3lwki
	 UP2vnyVw/1svQ==
Date: Tue, 25 Mar 2025 16:10:59 +0000
From: Wei Liu <wei.liu@kernel.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch v3] uio_hv_generic: Set event for all channels on the
 device
Message-ID: <Z-LVk8jWkalG5KdD@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
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

Greg, are you going to take this patch?

I can take it if you want.

Thanks,
Wei.

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

