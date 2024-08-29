Return-Path: <linux-hyperv+bounces-2913-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF609646F0
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 15:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48312281015
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549B1A38E7;
	Thu, 29 Aug 2024 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hp4yWOJI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656861A7062;
	Thu, 29 Aug 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938818; cv=none; b=GqZtmxnmGo3lvxYJ8VP01k5VNOdCYObA3JQ1AWXdvXW5MUIPx3G6cVC2hejx+KXJqY16WQDeEdYrmcFucytRW3uumPQXdNnpNC1tq2q/WxF9Gk9OVt0HLcs2uyqr1Lze8FX/FvjMmS+jGCCKv+kwRqdKJAATbbkiyCFkcmo+6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938818; c=relaxed/simple;
	bh=qNPPeHf/vYuq0NGXxA3J7Hqh0THBlpKiI5+YoxZwegg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOry+hzSQtlr06KELnl3dInaiEKSuSRToSo6WC0DyIpaTG4GBQsqOJ8aInwiC+qbHn26usJS7dl5lSi91XU/6OXQ25yJdp7W/F1cH1TYYkupafZb6nn0GSLEk+T1datRwaA2GfwISb2NbY9IjuyMivhHx5UC+f/jap2V2wvHoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hp4yWOJI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id DC86620B7123; Thu, 29 Aug 2024 06:40:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC86620B7123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724938816;
	bh=hbaGrTEPuSV2RDgGFeoOvPU36FCdWtiuI0WSBEYaL4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hp4yWOJIYNRDz2N8JTwyECMJcbmS/xdhZrsPeC0cSKFzZDAzQM36kiH8qCkWtXQDu
	 jF6z4/VVmApRePXk+lfWLmlrwTC1qosvbPHJJj6EBJ4/Uowf8rBeUMi/+1kNyJOuqF
	 ye/9puQAjxQFQQeONjHGb80WIOaa/KyFO2QUN/NQ=
Date: Thu, 29 Aug 2024 06:40:16 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
Message-ID: <20240829134016.GA29554@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240829071312.1595-1-namjain@linux.microsoft.com>
 <20240829071312.1595-3-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829071312.1595-3-namjain@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 29, 2024 at 12:43:12PM +0530, Naman Jain wrote:
> Rescind offer handling relies on rescind callbacks for some of the
> resources cleanup, if they are registered. It does not unregister
> vmbus device for the primary channel closure, when callback is
> registered. Without it, next onoffer does not come, rescind flag
> remains set and device goes to unusable state.
> 
> Add logic to unregister vmbus for the primary channel in rescind callback
> to ensure channel removal and relid release, and to ensure that next
> onoffer can be received and handled properly.
> 
> Cc: stable@vger.kernel.org
> Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c       | 1 +
>  drivers/uio/uio_hv_generic.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 7242c4920427..c405295b930a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1980,6 +1980,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
>  	 */
>  	device_unregister(&device_obj->device);
>  }
> +EXPORT_SYMBOL_GPL(vmbus_device_unregister);
>  
>  #ifdef CONFIG_ACPI
>  /*
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index e3e66a3e85a8..870409599411 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -121,6 +121,14 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
>  
>  	/* Wake up reader */
>  	uio_event_notify(&pdata->info);
> +
> +	/*
> +	 * With rescind callback registered, rescind path will not unregister the device
> +	 * from vmbus when the primary channel is rescinded.
> +	 * Without it, rescind handling is incomplete and next onoffer msg does not come.
> +	 * Unregister the device from vmbus here.
> +	 */
> +	vmbus_device_unregister(channel->device_obj);
>  }
>  
>  /* Sysfs API to allow mmap of the ring buffers
> -- 
> 2.34.1
>

For the series,
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com> 

