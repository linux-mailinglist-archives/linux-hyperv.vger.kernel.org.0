Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11979194379
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2020 16:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgCZPrV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Mar 2020 11:47:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36870 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCZPrV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Mar 2020 11:47:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id d1so7567925wmb.2;
        Thu, 26 Mar 2020 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C/W7LVOxuIAj1ER56s2leccpId2Ht2qn0VoQEUKWhDc=;
        b=Bb6BQd/ZNUhEmnv3AtflSKj4OfihPbclmbZ/1FZokh5SqQNvDt7zgzly5Uv02kTi0a
         M/uKGghTfgt/lYJh7JTtp1uvFxu/VEm6WApHq3Ggr+0GR1kD3eRDINzgUeO2ZLKOHNVC
         DHfgDkrJC1ykQpr/ufnOqRhe2BwDg1xB4S9LZbk11EMjUDgduTkSRkT95/GHAGxdHSbS
         hytgzjpiiPw+fUeWApU0UfgKvl0qpeSpPMKKAZ8SDHa/JIjDxlfeiA6dH5ZpOn5KOnU9
         owVABBqBy9mGiZHoZ6q/nNcOEShVTBHiVPZL8B45Bd+1nvcd7S8snRB5Hb5d55uxh8Xu
         Uwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C/W7LVOxuIAj1ER56s2leccpId2Ht2qn0VoQEUKWhDc=;
        b=nOtN6jXuz9EJ2k+kmoEL+dWLoBcFkWX8Utt3M7WicD8rYJu7hmgKRuy+7Z9woxmY/J
         V5qFqBjdknLpfvveEOeDBMG2TIA3g/pgg8tBzq2VKbBpeTFbyvwwAZCBt0mo83xccFuw
         8ZWb0mLJnvsTOrcpDqSdfv/aJoUEWMy8RhcMQ06oqMyEl+lFw9xXbXhku+65Lbkr99hk
         /KIhq+nYos2QB1dqqbjWW/h8nVHQdQUvEqz0oK++D2KvjJF6KEecjSopXeTEUhQtwAls
         mJ5PGyumUKDun+NnN4GWzfR8i7vT+VIqVXrJTMrWgXGUajbeZxca0dSgytxSLal8chds
         iK/g==
X-Gm-Message-State: ANhLgQ0+cvsWuBVr5spXt4oGsC0h+mAMQaxpuG5M0h0ckZa2K10Q047s
        44uiaGz8gc2FMp9uGnxPI90=
X-Google-Smtp-Source: ADFU+vuXneQPDtcsOWN0u7MbgkVB3IIz+HrnWmycZKgpGrK8pcOI4MPn8FsUlhVHoTm+0K+OZRsAqg==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr559648wmk.189.1585237638345;
        Thu, 26 Mar 2020 08:47:18 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id v10sm3679158wml.44.2020.03.26.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:47:17 -0700 (PDT)
Date:   Thu, 26 Mar 2020 16:47:10 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] Drivers: hv: vmbus: Don't bind the
 offer&rescind works to a specific CPU
Message-ID: <20200326154710.GA13711@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-3-parri.andrea@gmail.com>
 <871rpf5hhm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rpf5hhm.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 26, 2020 at 03:16:21PM +0100, Vitaly Kuznetsov wrote:
> "Andrea Parri (Microsoft)" <parri.andrea@gmail.com> writes:
> 
> > The offer and rescind works are currently scheduled on the so called
> > "connect CPU".  However, this is not really needed: we can synchronize
> > the works by relying on the usage of the offer_in_progress counter and
> > of the channel_mutex mutex.  This synchronization is already in place.
> > So, remove this unnecessary "bind to the connect CPU" constraint and
> > update the inline comments accordingly.
> >
> > Suggested-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 21 ++++++++++++++++-----
> >  drivers/hv/vmbus_drv.c    | 39 ++++++++++++++++++++++++++++-----------
> >  2 files changed, 44 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 0370364169c4e..1191f3d76d111 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -1025,11 +1025,22 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
> >  	 * offer comes in first and then the rescind.
> >  	 * Since we process these events in work elements,
> >  	 * and with preemption, we may end up processing
> > -	 * the events out of order. Given that we handle these
> > -	 * work elements on the same CPU, this is possible only
> > -	 * in the case of preemption. In any case wait here
> > -	 * until the offer processing has moved beyond the
> > -	 * point where the channel is discoverable.
> > +	 * the events out of order.  We rely on the synchronization
> > +	 * provided by offer_in_progress and by channel_mutex for
> > +	 * ordering these events:
> > +	 *
> > +	 * { Initially: offer_in_progress = 1 }
> > +	 *
> > +	 * CPU1				CPU2
> > +	 *
> > +	 * [vmbus_process_offer()]	[vmbus_onoffer_rescind()]
> > +	 *
> > +	 * LOCK channel_mutex		WAIT_ON offer_in_progress == 0
> > +	 * DECREMENT offer_in_progress	LOCK channel_mutex
> > +	 * INSERT chn_list		SEARCH chn_list
> > +	 * UNLOCK channel_mutex		UNLOCK channel_mutex
> > +	 *
> > +	 * Forbids: CPU2's SEARCH from *not* seeing CPU1's INSERT
> 
> WAIT_ON offer_in_progress == 0
> LOCK channel_mutex
> 
> seems to be racy: what happens if offer_in_progress increments after we
> read it but before we managed to aquire channel_mutex?

Remark that the RESCIND work must see the increment which is performed
"before" queueing the work in question (and the associated OFFER work),
cf. the comment in vmbus_on_msg_dpc() below and

  dbb92f88648d6 ("workqueue: Document (some) memory-ordering properties of {queue,schedule}_work()")

AFAICT, this suffices to meet the intended behavior as sketched above.
I might be missing something of course, can you elaborate on the issue
here?

Thanks,
  Andrea


> 
> I think this shold be changed to
> 
> LOCK channel_mutex
> CHECK offer_in_progress == 0
> EQUAL? GOTO proceed with rescind handling
> NOT EQUAL? 
>  WHILE offer_in_progress) != 0 {
>  UNLOCK channel_mutex 
>  MSLEEP(1)
>  LOCK channel_mutex
> }
> proceed with rescind handling:
> ...
> UNLOCK channel_mutex
> 
> >  	 */
> >  
> >  	while (atomic_read(&vmbus_connection.offer_in_progress) != 0) {
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 7600615e13754..903b1ec6a259e 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1048,8 +1048,9 @@ void vmbus_on_msg_dpc(unsigned long data)
> >  		/*
> >  		 * The host can generate a rescind message while we
> >  		 * may still be handling the original offer. We deal with
> > -		 * this condition by ensuring the processing is done on the
> > -		 * same CPU.
> > +		 * this condition by relying on the synchronization provided
> > +		 * by offer_in_progress and by channel_mutex.  See also the
> > +		 * inline comments in vmbus_onoffer_rescind().
> >  		 */
> >  		switch (hdr->msgtype) {
> >  		case CHANNELMSG_RESCIND_CHANNELOFFER:
> > @@ -1071,16 +1072,34 @@ void vmbus_on_msg_dpc(unsigned long data)
> >  			 * work queue: the RESCIND handler can not start to
> >  			 * run before the OFFER handler finishes.
> >  			 */
> > -			schedule_work_on(VMBUS_CONNECT_CPU,
> > -					 &ctx->work);
> > +			schedule_work(&ctx->work);
> >  			break;
> >  
> >  		case CHANNELMSG_OFFERCHANNEL:
> > +			/*
> > +			 * The host sends the offer message of a given channel
> > +			 * before sending the rescind message of the same
> > +			 * channel.  These messages are sent to the guest's
> > +			 * connect CPU; the guest then starts processing them
> > +			 * in the tasklet handler on this CPU:
> > +			 *
> > +			 * VMBUS_CONNECT_CPU
> > +			 *
> > +			 * [vmbus_on_msg_dpc()]
> > +			 * atomic_inc()  // CHANNELMSG_OFFERCHANNEL
> > +			 * queue_work()
> > +			 * ...
> > +			 * [vmbus_on_msg_dpc()]
> > +			 * schedule_work()  // CHANNELMSG_RESCIND_CHANNELOFFER
> > +			 *
> > +			 * We rely on the memory-ordering properties of the
> > +			 * queue_work() and schedule_work() primitives, which
> > +			 * guarantee that the atomic increment will be visible
> > +			 * to the CPUs which will execute the offer & rescind
> > +			 * works by the time these works will start execution.
> > +			 */
> >  			atomic_inc(&vmbus_connection.offer_in_progress);
> > -			queue_work_on(VMBUS_CONNECT_CPU,
> > -				      vmbus_connection.work_queue,
> > -				      &ctx->work);
> > -			break;
> > +			fallthrough;
> >  
> >  		default:
> >  			queue_work(vmbus_connection.work_queue, &ctx->work);
> > @@ -1124,9 +1143,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
> >  
> >  	INIT_WORK(&ctx->work, vmbus_onmessage_work);
> >  
> > -	queue_work_on(VMBUS_CONNECT_CPU,
> > -		      vmbus_connection.work_queue,
> > -		      &ctx->work);
> > +	queue_work(vmbus_connection.work_queue, &ctx->work);
> >  }
> >  #endif /* CONFIG_PM_SLEEP */
> 
> -- 
> Vitaly
> 
