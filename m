Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D61968B5
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2020 19:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgC1Sul (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 Mar 2020 14:50:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45231 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgC1Sul (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 Mar 2020 14:50:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so15750837wrw.12;
        Sat, 28 Mar 2020 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T9X4TQZ9K4JIEIm2tTNHBEPbE51dAYWSay3gWxgKRNs=;
        b=kCwiVp/Aze/2Pz7pZ5u6zXqyH0ixIlIESCCbTmsnAhtzGVP4BjcD2vSLt3RUTmenUE
         h3oSaKufL43z2+hyQJMp9s0PQ7Bdl5G7NsOErjnuRVDakMxpsFS5Rkhsopb/aYfhiMrS
         O+WIXx6M9ljIbOThh8zSecrerqXk8+H08qlklrjkRmFDJAqMNJoxwMS8xe0O7SPgNRYV
         EAc5MTdaG1sZNkZx9WkIHBYUn5oNSXWWCGm6zcQIUPJFJpRDSxe7UVk65FxJqHPXREvw
         x1GNBceWinUmIRkZZBgvkNJTz6gnwd42ePJVma7ldyMTmqSDLuXcHahqh9MrCyrAk21Y
         vqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T9X4TQZ9K4JIEIm2tTNHBEPbE51dAYWSay3gWxgKRNs=;
        b=Y8jQdVO8biniuJPAtDKYnhUY+B81CXgZ5XUC/bF/eLmizUcKNAYvm/v0B9Ka6K7/Gt
         f6z9viEBon203mUl833IyrOQH4SJ0yYQqXj0QRrwip9rjTF1AgEBrHOMc/ybWPHWsCbE
         MTow9jbyjKVBJXzd2e4jZ3Pistc5m2qD09OHAF6o2pV/ZYQoKq84UqyHSG6h+1fmeZ9r
         ryWowGXKx9xYY0OAarhLn+OZIHcW0INZL0zcFx5R2VNZdWLFVy8FiLHB5xRfVWMUAdxJ
         d5ljUY5C9YpiqKdFBw57wgOa47otSu3hfIzDi/yxahgQ279fyjhSoLAKNdw9Zx+9MKzl
         8JFw==
X-Gm-Message-State: ANhLgQ1pBDjjzNsxCwi6s200ReVbtWY95kexBFoklwpPSO3YHnISUeXy
        TaYKI0BeUP7/gcOrk7/yjF8=
X-Google-Smtp-Source: ADFU+vtui0abJnpIDHZiXzdCeHgOGtzqxSZ1ihNtfRBfNsrqjM4GsNkVn7Srfc6pNQ5QBiD6F6Djgg==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr5912021wrn.283.1585421438782;
        Sat, 28 Mar 2020 11:50:38 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j11sm2607703wmi.33.2020.03.28.11.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 11:50:38 -0700 (PDT)
Date:   Sat, 28 Mar 2020 19:50:35 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] Drivers: hv: vmbus: Always handle the VMBus
 messages on CPU0
Message-ID: <20200328185035.GB12184@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-2-parri.andrea@gmail.com>
 <874kub5i02.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kub5i02.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 26, 2020 at 03:05:17PM +0100, Vitaly Kuznetsov wrote:
> "Andrea Parri (Microsoft)" <parri.andrea@gmail.com> writes:
> 
> > A Linux guest have to pick a "connect CPU" to communicate with the
> > Hyper-V host.  This CPU can not be taken offline because Hyper-V does
> > not provide a way to change that CPU assignment.
> >
> > Current code sets the connect CPU to whatever CPU ends up running the
> > function vmbus_negotiate_version(), and this will generate problems if
> > that CPU is taken offine.
> >
> > Establish CPU0 as the connect CPU, and add logics to prevents the
> > connect CPU from being taken offline.   We could pick some other CPU,
> > and we could pick that "other CPU" dynamically if there was a reason to
> > do so at some point in the future.  But for now, #defining the connect
> > CPU to 0 is the most straightforward and least complex solution.
> >
> > While on this, add inline comments explaining "why" offer and rescind
> > messages should not be handled by a same serialized work queue.
> >
> > Suggested-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > ---
> >  drivers/hv/connection.c   | 20 +-------------------
> >  drivers/hv/hv.c           |  7 +++++++
> >  drivers/hv/hyperv_vmbus.h | 11 ++++++-----
> >  drivers/hv/vmbus_drv.c    | 20 +++++++++++++++++---
> >  4 files changed, 31 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> > index 74e77de89b4f3..f4bd306d2cef9 100644
> > --- a/drivers/hv/connection.c
> > +++ b/drivers/hv/connection.c
> > @@ -69,7 +69,6 @@ MODULE_PARM_DESC(max_version,
> >  int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
> >  {
> >  	int ret = 0;
> > -	unsigned int cur_cpu;
> >  	struct vmbus_channel_initiate_contact *msg;
> >  	unsigned long flags;
> >  
> > @@ -102,24 +101,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
> >  
> >  	msg->monitor_page1 = virt_to_phys(vmbus_connection.monitor_pages[0]);
> >  	msg->monitor_page2 = virt_to_phys(vmbus_connection.monitor_pages[1]);
> > -	/*
> > -	 * We want all channel messages to be delivered on CPU 0.
> > -	 * This has been the behavior pre-win8. This is not
> > -	 * perf issue and having all channel messages delivered on CPU 0
> > -	 * would be ok.
> > -	 * For post win8 hosts, we support receiving channel messagges on
> > -	 * all the CPUs. This is needed for kexec to work correctly where
> > -	 * the CPU attempting to connect may not be CPU 0.
> > -	 */
> > -	if (version >= VERSION_WIN8_1) {
> > -		cur_cpu = get_cpu();
> > -		msg->target_vcpu = hv_cpu_number_to_vp_number(cur_cpu);
> > -		vmbus_connection.connect_cpu = cur_cpu;
> > -		put_cpu();
> > -	} else {
> > -		msg->target_vcpu = 0;
> > -		vmbus_connection.connect_cpu = 0;
> > -	}
> > +	msg->target_vcpu = hv_cpu_number_to_vp_number(VMBUS_CONNECT_CPU);
> >  
> >  	/*
> >  	 * Add to list before we send the request since we may
> > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > index 6098e0cbdb4b0..e2b3310454640 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -249,6 +249,13 @@ int hv_synic_cleanup(unsigned int cpu)
> >  	bool channel_found = false;
> >  	unsigned long flags;
> >  
> > +	/*
> > +	 * Hyper-V does not provide a way to change the connect CPU once
> > +	 * it is set; we must prevent the connect CPU from going offline.
> > +	 */
> > +	if (cpu == VMBUS_CONNECT_CPU)
> > +		return -EBUSY;
> > +
> >  	/*
> >  	 * Search for channels which are bound to the CPU we're about to
> >  	 * cleanup. In case we find one and vmbus is still connected we need to
> > diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> > index 70b30e223a578..67fb1edcbf527 100644
> > --- a/drivers/hv/hyperv_vmbus.h
> > +++ b/drivers/hv/hyperv_vmbus.h
> > @@ -212,12 +212,13 @@ enum vmbus_connect_state {
> >  
> >  #define MAX_SIZE_CHANNEL_MESSAGE	HV_MESSAGE_PAYLOAD_BYTE_COUNT
> >  
> > -struct vmbus_connection {
> > -	/*
> > -	 * CPU on which the initial host contact was made.
> > -	 */
> > -	int connect_cpu;
> > +/*
> > + * The CPU that Hyper-V will interrupt for VMBUS messages, such as
> > + * CHANNELMSG_OFFERCHANNEL and CHANNELMSG_RESCIND_CHANNELOFFER.
> > + */
> > +#define VMBUS_CONNECT_CPU	0
> >  
> > +struct vmbus_connection {
> >  	u32 msg_conn_id;
> >  
> >  	atomic_t offer_in_progress;
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 029378c27421d..7600615e13754 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1056,14 +1056,28 @@ void vmbus_on_msg_dpc(unsigned long data)
> >  			/*
> >  			 * If we are handling the rescind message;
> >  			 * schedule the work on the global work queue.
> > +			 *
> > +			 * The OFFER message and the RESCIND message should
> > +			 * not be handled by the same serialized work queue,
> > +			 * because the OFFER handler may call vmbus_open(),
> > +			 * which tries to open the channel by sending an
> > +			 * OPEN_CHANNEL message to the host and waits for
> > +			 * the host's response; however, if the host has
> > +			 * rescinded the channel before it receives the
> > +			 * OPEN_CHANNEL message, the host just silently
> > +			 * ignores the OPEN_CHANNEL message; as a result,
> > +			 * the guest's OFFER handler hangs for ever, if we
> > +			 * handle the RESCIND message in the same serialized
> > +			 * work queue: the RESCIND handler can not start to
> > +			 * run before the OFFER handler finishes.
> >  			 */
> > -			schedule_work_on(vmbus_connection.connect_cpu,
> > +			schedule_work_on(VMBUS_CONNECT_CPU,
> >  					 &ctx->work);
> >  			break;
> >  
> >  		case CHANNELMSG_OFFERCHANNEL:
> >  			atomic_inc(&vmbus_connection.offer_in_progress);
> > -			queue_work_on(vmbus_connection.connect_cpu,
> > +			queue_work_on(VMBUS_CONNECT_CPU,
> >  				      vmbus_connection.work_queue,
> >  				      &ctx->work);
> >  			break;
> > @@ -1110,7 +1124,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
> >  
> >  	INIT_WORK(&ctx->work, vmbus_onmessage_work);
> >  
> > -	queue_work_on(vmbus_connection.connect_cpu,
> > +	queue_work_on(VMBUS_CONNECT_CPU,
> >  		      vmbus_connection.work_queue,
> >  		      &ctx->work);
> >  }
> 
> I tried to refresh my memory on why 'connect_cpu' was introduced and it
> all comes down to the following commit:
> 
> commit 7268644734f6a300353a4c4ff8bf3e013ba80f89
> Author: Alex Ng <alexng@microsoft.com>
> Date:   Fri Feb 26 15:13:22 2016 -0800
> 
>     Drivers: hv: vmbus: Support kexec on ws2012 r2 and above
> 
> which for some unknown reason kept hardcoding '0' for pre-win2012-r2 (
> hv_context.vp_index[smp_processor_id()] in all cases would do exactly
> the same I guess ). Later, 'connect_cpu' appeared just to remember our
> choice, I can't see why we didn't go with CPU0 for simplicity.
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied!  Thanks again for the review and all the suggestions,

  Andrea
