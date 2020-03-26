Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA05194111
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2020 15:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgCZOQa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Mar 2020 10:16:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45682 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727685AbgCZOQa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Mar 2020 10:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585232188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f7w6Vl0XLJbOpxQoLSR8Ve0OMcQclxwBm4RvSOfYO9M=;
        b=bsSwe9auZD486H3LqVN4PWHO/FvRliVUYFNZDS9u5PyK2Ei46nbdIcT5hIDmrALd9UhXTF
        0KJEMoYl3JHS9ypBxBC6WiMBkEY1KOwtKQMuZ8zcJQJTXhwqPi2NRMpb9616PGtvpOgx1R
        YqAanRAxZ3S6cx7NQdtoxDF/xCgkDp0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-zspEkFQIMKepmYPaUdZRdQ-1; Thu, 26 Mar 2020 10:16:26 -0400
X-MC-Unique: zspEkFQIMKepmYPaUdZRdQ-1
Received: by mail-wr1-f69.google.com with SMTP id y1so3102430wrn.10
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Mar 2020 07:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f7w6Vl0XLJbOpxQoLSR8Ve0OMcQclxwBm4RvSOfYO9M=;
        b=olAnP0paEZZvupFlB0Yd1owcFfgvLD6hMcTa7+RTnKHQbsqE0X9fs1rDVvPJtZfVlW
         HlJK5oCQ0Ih8wUtqw9uUGoMab5ZY8gjivCB21DLZewBlQzdSqq0lqmKTDImD+KzRCBS6
         3FFi8fKp1WAZ+uLxZaGqNgJzck6n4CNpVxggEJF1G6QheCjYBua/Ag4BLQAq81P3XFp6
         eQRAmfXkgnXnXH5viw5c4ODG/H2rsGjD+mo/C2RfsghbEmsg2nSBvNGq3jdEDtuaGPFG
         SCaBN147EMqltzc9EP38NHexYaFMtG95pJ+o5v0hTv9q1WJ0UC8vceqCCVKF0rw7vZYN
         H7+g==
X-Gm-Message-State: ANhLgQ1xJR7d68/cPoQuKieAj4L8nmMmAm+3LhR2Er2QgXjnVtXg4ASV
        vkc8MvsgKNVoLtP8vWGH7klkYEzxzuI7nHmzI+zSmZMDiutY/pHCEeiJTKn8ZE0CgshZEuGi9Qb
        +iKBpuu5A9IMaEWiiLfw2UF3D
X-Received: by 2002:adf:f38e:: with SMTP id m14mr9878039wro.54.1585232184432;
        Thu, 26 Mar 2020 07:16:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vugg3n0UD8IZObgwEpfCYiaBcBTNKjAKcrVHB0t/Zjgb+Mx2WmcTJRMpi9ejxcFBZCS/EPK9g==
X-Received: by 2002:adf:f38e:: with SMTP id m14mr9878006wro.54.1585232184109;
        Thu, 26 Mar 2020 07:16:24 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b15sm3702502wru.70.2020.03.26.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:16:23 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Andrea Parri \(Microsoft\)" <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] Drivers: hv: vmbus: Don't bind the offer&rescind works to a specific CPU
In-Reply-To: <20200325225505.23998-3-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com> <20200325225505.23998-3-parri.andrea@gmail.com>
Date:   Thu, 26 Mar 2020 15:16:21 +0100
Message-ID: <871rpf5hhm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Andrea Parri (Microsoft)" <parri.andrea@gmail.com> writes:

> The offer and rescind works are currently scheduled on the so called
> "connect CPU".  However, this is not really needed: we can synchronize
> the works by relying on the usage of the offer_in_progress counter and
> of the channel_mutex mutex.  This synchronization is already in place.
> So, remove this unnecessary "bind to the connect CPU" constraint and
> update the inline comments accordingly.
>
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 21 ++++++++++++++++-----
>  drivers/hv/vmbus_drv.c    | 39 ++++++++++++++++++++++++++++-----------
>  2 files changed, 44 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 0370364169c4e..1191f3d76d111 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1025,11 +1025,22 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
>  	 * offer comes in first and then the rescind.
>  	 * Since we process these events in work elements,
>  	 * and with preemption, we may end up processing
> -	 * the events out of order. Given that we handle these
> -	 * work elements on the same CPU, this is possible only
> -	 * in the case of preemption. In any case wait here
> -	 * until the offer processing has moved beyond the
> -	 * point where the channel is discoverable.
> +	 * the events out of order.  We rely on the synchronization
> +	 * provided by offer_in_progress and by channel_mutex for
> +	 * ordering these events:
> +	 *
> +	 * { Initially: offer_in_progress = 1 }
> +	 *
> +	 * CPU1				CPU2
> +	 *
> +	 * [vmbus_process_offer()]	[vmbus_onoffer_rescind()]
> +	 *
> +	 * LOCK channel_mutex		WAIT_ON offer_in_progress == 0
> +	 * DECREMENT offer_in_progress	LOCK channel_mutex
> +	 * INSERT chn_list		SEARCH chn_list
> +	 * UNLOCK channel_mutex		UNLOCK channel_mutex
> +	 *
> +	 * Forbids: CPU2's SEARCH from *not* seeing CPU1's INSERT

WAIT_ON offer_in_progress == 0
LOCK channel_mutex

seems to be racy: what happens if offer_in_progress increments after we
read it but before we managed to aquire channel_mutex?

I think this shold be changed to

LOCK channel_mutex
CHECK offer_in_progress == 0
EQUAL? GOTO proceed with rescind handling
NOT EQUAL? 
 WHILE offer_in_progress) != 0 {
 UNLOCK channel_mutex 
 MSLEEP(1)
 LOCK channel_mutex
}
proceed with rescind handling:
...
UNLOCK channel_mutex

>  	 */
>  
>  	while (atomic_read(&vmbus_connection.offer_in_progress) != 0) {
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 7600615e13754..903b1ec6a259e 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1048,8 +1048,9 @@ void vmbus_on_msg_dpc(unsigned long data)
>  		/*
>  		 * The host can generate a rescind message while we
>  		 * may still be handling the original offer. We deal with
> -		 * this condition by ensuring the processing is done on the
> -		 * same CPU.
> +		 * this condition by relying on the synchronization provided
> +		 * by offer_in_progress and by channel_mutex.  See also the
> +		 * inline comments in vmbus_onoffer_rescind().
>  		 */
>  		switch (hdr->msgtype) {
>  		case CHANNELMSG_RESCIND_CHANNELOFFER:
> @@ -1071,16 +1072,34 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			 * work queue: the RESCIND handler can not start to
>  			 * run before the OFFER handler finishes.
>  			 */
> -			schedule_work_on(VMBUS_CONNECT_CPU,
> -					 &ctx->work);
> +			schedule_work(&ctx->work);
>  			break;
>  
>  		case CHANNELMSG_OFFERCHANNEL:
> +			/*
> +			 * The host sends the offer message of a given channel
> +			 * before sending the rescind message of the same
> +			 * channel.  These messages are sent to the guest's
> +			 * connect CPU; the guest then starts processing them
> +			 * in the tasklet handler on this CPU:
> +			 *
> +			 * VMBUS_CONNECT_CPU
> +			 *
> +			 * [vmbus_on_msg_dpc()]
> +			 * atomic_inc()  // CHANNELMSG_OFFERCHANNEL
> +			 * queue_work()
> +			 * ...
> +			 * [vmbus_on_msg_dpc()]
> +			 * schedule_work()  // CHANNELMSG_RESCIND_CHANNELOFFER
> +			 *
> +			 * We rely on the memory-ordering properties of the
> +			 * queue_work() and schedule_work() primitives, which
> +			 * guarantee that the atomic increment will be visible
> +			 * to the CPUs which will execute the offer & rescind
> +			 * works by the time these works will start execution.
> +			 */
>  			atomic_inc(&vmbus_connection.offer_in_progress);
> -			queue_work_on(VMBUS_CONNECT_CPU,
> -				      vmbus_connection.work_queue,
> -				      &ctx->work);
> -			break;
> +			fallthrough;
>  
>  		default:
>  			queue_work(vmbus_connection.work_queue, &ctx->work);
> @@ -1124,9 +1143,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
>  
>  	INIT_WORK(&ctx->work, vmbus_onmessage_work);
>  
> -	queue_work_on(VMBUS_CONNECT_CPU,
> -		      vmbus_connection.work_queue,
> -		      &ctx->work);
> +	queue_work(vmbus_connection.work_queue, &ctx->work);
>  }
>  #endif /* CONFIG_PM_SLEEP */

-- 
Vitaly

