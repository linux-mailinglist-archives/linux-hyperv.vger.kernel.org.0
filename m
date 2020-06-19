Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603A9201372
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2020 18:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392433AbgFSQBm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Jun 2020 12:01:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33714 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392228AbgFSQBl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Jun 2020 12:01:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id l11so10219054wru.0;
        Fri, 19 Jun 2020 09:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igRhbYLV+7PJ6N9DkBcYUmMXd50ZJc1tlq0/bt0/vSM=;
        b=nXEjci27uYDnoG14W1QNAqoNXY4/B4lcikwcOWWT8xah2FV7c6zCaXca63OkQw2tYL
         QHJOKqIcZh0PLCBc/TPsLlAaCN0tkc42l0fWMspGcYHZ9vt6Kn3z3Fnz9NTmQvWRDFLg
         vXGTGsNZK4z6HvJV2eKYEcsLzk1w6AES21hjTMNlm4g1jNKCRZJ11cZr9Vff2SHiW8dX
         urYMeLd9cbKN0aELd52Hu2CpdO9ZLJkh4UZttb33hQJ1xMz/XcNnqBoh5N9cYtwQinGx
         EjFhjHS9fBf8bdakfVeeQWHblC31lZStkgRXuJxi8a6LKAFLzuqVSSbi3hhcSbpd4pEd
         lczg==
X-Gm-Message-State: AOAM5316dh20f99sfSFm7Sv9rRgAsKZmaBp/yA7Ype66BVwYclQFJsce
        +AUN5rBcAvEoYfI01ZEsHR0=
X-Google-Smtp-Source: ABdhPJy0TMbHM+GevwodxJNTOFiPbd2ph++ENu2/j8I0jK2Jsh2xokMWVgPO3ifJPex7Syt3C5rCQQ==
X-Received: by 2002:a5d:5605:: with SMTP id l5mr4704895wrv.318.1592582498803;
        Fri, 19 Jun 2020 09:01:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o82sm7393169wmo.40.2020.06.19.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:01:37 -0700 (PDT)
Date:   Fri, 19 Jun 2020 16:01:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 7/8] scsi: storvsc: Introduce the per-storvsc_device
 spinlock
Message-ID: <20200619160136.2r34bdu26hxixv7l@liuwe-devbox-debian-v2>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-8-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617164642.37393-8-parri.andrea@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Cc SCSI maintainers

This patch should go via the hyperv tree because a later patch is
dependent on it. It requires and ack from SCSI maintainers though.

Thanks,
Wei.

On Wed, Jun 17, 2020 at 06:46:41PM +0200, Andrea Parri (Microsoft) wrote:
> storvsc uses the spinlock of the hv_device's primary channel to
> serialize modifications of stor_chns[] performed by storvsc_do_io()
> and storvsc_change_target_cpu(), when it could/should use a (per-)
> storvsc_device spinlock: this change untangles the synchronization
> mechanism for the (storvsc-specific) stor_chns[] array from the
> "generic" VMBus code and data structures, clarifying the scope of
> this synchronization mechanism.
> 
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/scsi/storvsc_drv.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 072ed87286578..8ff21e69a8be8 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -462,6 +462,11 @@ struct storvsc_device {
>  	 * Mask of CPUs bound to subchannels.
>  	 */
>  	struct cpumask alloced_cpus;
> +	/*
> +	 * Serializes modifications of stor_chns[] from storvsc_do_io()
> +	 * and storvsc_change_target_cpu().
> +	 */
> +	spinlock_t lock;
>  	/* Used for vsc/vsp channel reset process */
>  	struct storvsc_cmd_request init_request;
>  	struct storvsc_cmd_request reset_request;
> @@ -639,7 +644,7 @@ static void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old,
>  		return;
>  
>  	/* See storvsc_do_io() -> get_og_chn(). */
> -	spin_lock_irqsave(&device->channel->lock, flags);
> +	spin_lock_irqsave(&stor_device->lock, flags);
>  
>  	/*
>  	 * Determines if the storvsc device has other channels assigned to
> @@ -676,7 +681,7 @@ static void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old,
>  	WRITE_ONCE(stor_device->stor_chns[new], channel);
>  	cpumask_set_cpu(new, &stor_device->alloced_cpus);
>  
> -	spin_unlock_irqrestore(&device->channel->lock, flags);
> +	spin_unlock_irqrestore(&stor_device->lock, flags);
>  }
>  
>  static void handle_sc_creation(struct vmbus_channel *new_sc)
> @@ -1433,14 +1438,14 @@ static int storvsc_do_io(struct hv_device *device,
>  			}
>  		}
>  	} else {
> -		spin_lock_irqsave(&device->channel->lock, flags);
> +		spin_lock_irqsave(&stor_device->lock, flags);
>  		outgoing_channel = stor_device->stor_chns[q_num];
>  		if (outgoing_channel != NULL) {
> -			spin_unlock_irqrestore(&device->channel->lock, flags);
> +			spin_unlock_irqrestore(&stor_device->lock, flags);
>  			goto found_channel;
>  		}
>  		outgoing_channel = get_og_chn(stor_device, q_num);
> -		spin_unlock_irqrestore(&device->channel->lock, flags);
> +		spin_unlock_irqrestore(&stor_device->lock, flags);
>  	}
>  
>  found_channel:
> @@ -1881,6 +1886,7 @@ static int storvsc_probe(struct hv_device *device,
>  	init_waitqueue_head(&stor_device->waiting_to_drain);
>  	stor_device->device = device;
>  	stor_device->host = host;
> +	spin_lock_init(&stor_device->lock);
>  	hv_set_drvdata(device, stor_device);
>  
>  	stor_device->port_number = host->host_no;
> -- 
> 2.25.1
> 
