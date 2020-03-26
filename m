Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 733CD1940F1
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2020 15:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCZOF1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Mar 2020 10:05:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60313 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727822AbgCZOF0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Mar 2020 10:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585231524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iu8pP+Jj7yxXz+kaoKj+StMGIPihDf+lmC4twg0Tx8I=;
        b=DeLoAWFirKmULSN7WIwguu86alZCfibn2T+DnJLn7OHJaABeFTV/lDdelJKGeTn93lE39J
        GHbzoKmtgQBlFuHAjCV6sG0WQ22MsmwK3FsvomZ6waluakl8CHBvPBZ+kADoj11uPxsnKR
        BrtCA8T8qXCddW+MG/UkCKeaaJa+Qp4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-2AAUK2ygN4GGiK8ioWh46w-1; Thu, 26 Mar 2020 10:05:23 -0400
X-MC-Unique: 2AAUK2ygN4GGiK8ioWh46w-1
Received: by mail-wr1-f69.google.com with SMTP id l17so3098639wro.3
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Mar 2020 07:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iu8pP+Jj7yxXz+kaoKj+StMGIPihDf+lmC4twg0Tx8I=;
        b=r9chjLKcVrHW5xxCBKejDdGHREDRCYVdRGiWzjr/EEjHBlE58LjIGcw7IffkeTtc0d
         vb+d19Z5+uvARToCpHV0SowwcemKbTJ1SIn2LBAS/Gb0XizH5J+WCouou+eMmseTBLY+
         2IPodJoWG5kfWL3ve28GoGct1UHdmUvE7VrawdDkwfwfRmGpdJ0of9WDyGXy6DGw699D
         5kmMcArKcYoPtOOXQYzZE/s03R6Xk/s6XaQkYaS+WiuG2x4xRNq1rgAPuFbSnDGpLGIm
         1XTertHLOfTptUAWnVpHbHDwuUQK9J+LQrqwpASQ/v+AgsRDlmkr4jSUInqMeBesI/o2
         OIhw==
X-Gm-Message-State: ANhLgQ0J4GBs3iTE/NnLt4TMBg7fIrfH9y1Vy3MhX7AUPfezY9cXycAX
        5LCnr7fxJ6qqEWR5siwZu3IFMuT+I3ZGtNve1NZOw1RUPZpBu1U6nRS/ZOY+SeTMNOTiVqkfS4n
        NgSz6wYBmEGp/NyPX6ux8skdU
X-Received: by 2002:a5d:4611:: with SMTP id t17mr392177wrq.16.1585231520389;
        Thu, 26 Mar 2020 07:05:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvxFjrunOsSfd505meGyZf11k+WGz1I4Q9myCzJ3l75WCPrsGXFu9lrehOCOCF+g+IF36yJsQ==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr392144wrq.16.1585231520041;
        Thu, 26 Mar 2020 07:05:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r3sm3775853wrm.35.2020.03.26.07.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:05:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Andrea Parri \(Microsoft\)" <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] Drivers: hv: vmbus: Always handle the VMBus messages on CPU0
In-Reply-To: <20200325225505.23998-2-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com> <20200325225505.23998-2-parri.andrea@gmail.com>
Date:   Thu, 26 Mar 2020 15:05:17 +0100
Message-ID: <874kub5i02.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Andrea Parri (Microsoft)" <parri.andrea@gmail.com> writes:

> A Linux guest have to pick a "connect CPU" to communicate with the
> Hyper-V host.  This CPU can not be taken offline because Hyper-V does
> not provide a way to change that CPU assignment.
>
> Current code sets the connect CPU to whatever CPU ends up running the
> function vmbus_negotiate_version(), and this will generate problems if
> that CPU is taken offine.
>
> Establish CPU0 as the connect CPU, and add logics to prevents the
> connect CPU from being taken offline.   We could pick some other CPU,
> and we could pick that "other CPU" dynamically if there was a reason to
> do so at some point in the future.  But for now, #defining the connect
> CPU to 0 is the most straightforward and least complex solution.
>
> While on this, add inline comments explaining "why" offer and rescind
> messages should not be handled by a same serialized work queue.
>
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/connection.c   | 20 +-------------------
>  drivers/hv/hv.c           |  7 +++++++
>  drivers/hv/hyperv_vmbus.h | 11 ++++++-----
>  drivers/hv/vmbus_drv.c    | 20 +++++++++++++++++---
>  4 files changed, 31 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 74e77de89b4f3..f4bd306d2cef9 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -69,7 +69,6 @@ MODULE_PARM_DESC(max_version,
>  int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>  {
>  	int ret = 0;
> -	unsigned int cur_cpu;
>  	struct vmbus_channel_initiate_contact *msg;
>  	unsigned long flags;
>  
> @@ -102,24 +101,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
>  
>  	msg->monitor_page1 = virt_to_phys(vmbus_connection.monitor_pages[0]);
>  	msg->monitor_page2 = virt_to_phys(vmbus_connection.monitor_pages[1]);
> -	/*
> -	 * We want all channel messages to be delivered on CPU 0.
> -	 * This has been the behavior pre-win8. This is not
> -	 * perf issue and having all channel messages delivered on CPU 0
> -	 * would be ok.
> -	 * For post win8 hosts, we support receiving channel messagges on
> -	 * all the CPUs. This is needed for kexec to work correctly where
> -	 * the CPU attempting to connect may not be CPU 0.
> -	 */
> -	if (version >= VERSION_WIN8_1) {
> -		cur_cpu = get_cpu();
> -		msg->target_vcpu = hv_cpu_number_to_vp_number(cur_cpu);
> -		vmbus_connection.connect_cpu = cur_cpu;
> -		put_cpu();
> -	} else {
> -		msg->target_vcpu = 0;
> -		vmbus_connection.connect_cpu = 0;
> -	}
> +	msg->target_vcpu = hv_cpu_number_to_vp_number(VMBUS_CONNECT_CPU);
>  
>  	/*
>  	 * Add to list before we send the request since we may
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 6098e0cbdb4b0..e2b3310454640 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -249,6 +249,13 @@ int hv_synic_cleanup(unsigned int cpu)
>  	bool channel_found = false;
>  	unsigned long flags;
>  
> +	/*
> +	 * Hyper-V does not provide a way to change the connect CPU once
> +	 * it is set; we must prevent the connect CPU from going offline.
> +	 */
> +	if (cpu == VMBUS_CONNECT_CPU)
> +		return -EBUSY;
> +
>  	/*
>  	 * Search for channels which are bound to the CPU we're about to
>  	 * cleanup. In case we find one and vmbus is still connected we need to
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 70b30e223a578..67fb1edcbf527 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -212,12 +212,13 @@ enum vmbus_connect_state {
>  
>  #define MAX_SIZE_CHANNEL_MESSAGE	HV_MESSAGE_PAYLOAD_BYTE_COUNT
>  
> -struct vmbus_connection {
> -	/*
> -	 * CPU on which the initial host contact was made.
> -	 */
> -	int connect_cpu;
> +/*
> + * The CPU that Hyper-V will interrupt for VMBUS messages, such as
> + * CHANNELMSG_OFFERCHANNEL and CHANNELMSG_RESCIND_CHANNELOFFER.
> + */
> +#define VMBUS_CONNECT_CPU	0
>  
> +struct vmbus_connection {
>  	u32 msg_conn_id;
>  
>  	atomic_t offer_in_progress;
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 029378c27421d..7600615e13754 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1056,14 +1056,28 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			/*
>  			 * If we are handling the rescind message;
>  			 * schedule the work on the global work queue.
> +			 *
> +			 * The OFFER message and the RESCIND message should
> +			 * not be handled by the same serialized work queue,
> +			 * because the OFFER handler may call vmbus_open(),
> +			 * which tries to open the channel by sending an
> +			 * OPEN_CHANNEL message to the host and waits for
> +			 * the host's response; however, if the host has
> +			 * rescinded the channel before it receives the
> +			 * OPEN_CHANNEL message, the host just silently
> +			 * ignores the OPEN_CHANNEL message; as a result,
> +			 * the guest's OFFER handler hangs for ever, if we
> +			 * handle the RESCIND message in the same serialized
> +			 * work queue: the RESCIND handler can not start to
> +			 * run before the OFFER handler finishes.
>  			 */
> -			schedule_work_on(vmbus_connection.connect_cpu,
> +			schedule_work_on(VMBUS_CONNECT_CPU,
>  					 &ctx->work);
>  			break;
>  
>  		case CHANNELMSG_OFFERCHANNEL:
>  			atomic_inc(&vmbus_connection.offer_in_progress);
> -			queue_work_on(vmbus_connection.connect_cpu,
> +			queue_work_on(VMBUS_CONNECT_CPU,
>  				      vmbus_connection.work_queue,
>  				      &ctx->work);
>  			break;
> @@ -1110,7 +1124,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
>  
>  	INIT_WORK(&ctx->work, vmbus_onmessage_work);
>  
> -	queue_work_on(vmbus_connection.connect_cpu,
> +	queue_work_on(VMBUS_CONNECT_CPU,
>  		      vmbus_connection.work_queue,
>  		      &ctx->work);
>  }

I tried to refresh my memory on why 'connect_cpu' was introduced and it
all comes down to the following commit:

commit 7268644734f6a300353a4c4ff8bf3e013ba80f89
Author: Alex Ng <alexng@microsoft.com>
Date:   Fri Feb 26 15:13:22 2016 -0800

    Drivers: hv: vmbus: Support kexec on ws2012 r2 and above

which for some unknown reason kept hardcoding '0' for pre-win2012-r2 (
hv_context.vp_index[smp_processor_id()] in all cases would do exactly
the same I guess ). Later, 'connect_cpu' appeared just to remember our
choice, I can't see why we didn't go with CPU0 for simplicity.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

