Return-Path: <linux-hyperv+bounces-4302-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD3A580DC
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 06:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0351169E5A
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 05:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9038D13C908;
	Sun,  9 Mar 2025 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eyEXKFXh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F53C133;
	Sun,  9 Mar 2025 05:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499249; cv=none; b=SJOTf3sEOVMK7R7dYsIgjAad27bwG1sEjCJ+KGKk2YQUk/i0NZBeWR2aTAcvPWDV6GDztP1t4mRA6yGOWm1kbHY39jwKs1YYTycF33Uu7yXZbLgr8uH/5UC68PzuFrDmcCfJp6txH+Fx1MaKI++Smnb7IszMko9GfOAWrdD1Cw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499249; c=relaxed/simple;
	bh=Qy03Kzd1sCrX+TA3t2MlFCTfEPD3qurJBVVaywkl5VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpbDP4HotH/lqGWl/j4TV4G8gndSUYaWqlqhI5azALmNxgDRxacGp/WsP8lti5zL4wH1VjBVpsae8tjbeZGU8rCMOhSrTLAmWlG5LwsxBVfpSExcvS1D4eo8IcuL3KkPoTWZXXiJZWsENWXX8fIwnVaDv1FdMqiw+vcoSfHgcig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eyEXKFXh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id C08812111406; Sat,  8 Mar 2025 21:47:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C08812111406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741499247;
	bh=gLvp5ZqYmwas6pmP/dNAwRvYqTVCi/4Uh5B5do6+cfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyEXKFXhpeu5ozpLKrIH4i8WXSRM+4Zq+OI5R6NqFPV+Ai7TUbHcboHCMi2vMNOG6
	 eik3tBSFBzua8N1uzqP5y1+owQP6CmICJpduZPeGEv0CQiS347hZkDT2w4uhoDmfmb
	 t/75qve62f+MwtxORfl5PGdId10l+UV8CQRpZfRw=
Date: Sat, 8 Mar 2025 21:47:27 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch v2] uio_hv_generic: Set event for all channels on the
 device
Message-ID: <20250309054727.GA24737@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1740780854-7844-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740780854-7844-1-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Feb 28, 2025 at 02:14:14PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Hyper-V may offer a non latency sensitive device with subchannels without
> monitor bit enabled. The decision is entirely on the Hyper-V host not
> configurable within guest.
> 
> When a device has subchannels, also signal events for the subchannel
> if its monitor bit is disabled.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> Change log
> v2: Use vmbus_set_event() to avoid additional check on monitored bit
>     Lock vmbus_connection.channel_mutex when going through subchannels
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

Why is memory barrier not getting called for 'faster' channels ?

- Saurabh

