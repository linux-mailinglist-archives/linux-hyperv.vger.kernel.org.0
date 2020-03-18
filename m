Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C4018A008
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2020 16:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCRP6c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 11:58:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:28430 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbgCRP6c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 11:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584547110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B6PGvx1icbG3tXj8E6e/64qZk/0Iq47yT74imlxqQuw=;
        b=ggCE4S4x9i30p9mYHScTtkT95jBS3lOSiVyKhgPx9F0BbMhPE2JtD6K1EKgq4RIbJbABfZ
        0F98gg0i4xD9uzKROFe35/VweonMkheb4MthcPmJDpNXw+Jvkddw9x+7vk44ZHzRzmyynM
        b57mOMJbdnk4IS7cPdkqAmbL7jBn7WE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-V_1j_TM-NPe3TRWiHCdIsQ-1; Wed, 18 Mar 2020 11:58:29 -0400
X-MC-Unique: V_1j_TM-NPe3TRWiHCdIsQ-1
Received: by mail-wr1-f72.google.com with SMTP id c6so12456391wrm.18
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2020 08:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=B6PGvx1icbG3tXj8E6e/64qZk/0Iq47yT74imlxqQuw=;
        b=av6tabzijyZLwu08unigPicUZR+yQ2JHF/Rxisfb8SkhmiZppA2qk5Fp861IEJXqEU
         wIUSaDnxFjc/iQpXpfeTjVlzhK/0sf08X1VX2IZQ4bne9vhK4/14T66r51h0ZoWrk2cd
         WfmgFkZsqEQ6yTqZ+28PxEA+MbqaLp83RLiDRR3BaEI0Dwg8RfFFMrtQxONjlGxjU+W4
         inrCepqP3n+oudbGhGr1+UWuKgxRSKQI5CVB14eGPZuVmsezqo72gIDwHK2PHs1mlZHL
         ktqrGH0qoZIEsIBhYTwDD18gefaNXFao92Tj7BDZscSd5x/xGYcLS+L53bZDlqIcepCI
         V/kA==
X-Gm-Message-State: ANhLgQ1ROuWV1t8shkJb7oAXM9vDDE5i4b0jZ+FvpRtbQaZ3bQW4ZzoM
        d0Sp4r/KVyR+kniAOGVcIHUIGv2YMkPN0jJFIv+hKJGiwX3O7Eylb++eR47sJn3OKncSs+ikHQW
        TkHgd+aAi94JweUF4VJHQqwUX
X-Received: by 2002:a05:6000:1203:: with SMTP id e3mr6638632wrx.166.1584547106462;
        Wed, 18 Mar 2020 08:58:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtjCvuXMcOs5w1KWeJDGkuvTz8xovzZ8NGW9WL8cGrTCBgHDgeCsP0zhoZoCfieklc9vr3ULQ==
X-Received: by 2002:a05:6000:1203:: with SMTP id e3mr6638599wrx.166.1584547106195;
        Wed, 18 Mar 2020 08:58:26 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v2sm10426967wrt.58.2020.03.18.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 08:58:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     ltykernel@gmail.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH 0/4] x86/Hyper-V: Unload vmbus channel in hv panic callback
In-Reply-To: <20200317132523.1508-2-Tianyu.Lan@microsoft.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com> <20200317132523.1508-2-Tianyu.Lan@microsoft.com>
Date:   Wed, 18 Mar 2020 16:58:23 +0100
Message-ID: <871rpp3ba8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

ltykernel@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Customer reported Hyper-V VM still responded network traffic
> ack packets after kernel panic with kernel parameter "panic=0”.
> This becauses vmbus driver interrupt handler still works
> on the panic cpu after kernel panic. Panic cpu falls into
> infinite loop of panic() with interrupt enabled at that point.
> Vmbus driver can still handle network traffic.
>
> This confuses remote service that the panic system is still
> alive when it gets ack packets. Unload vmbus channel in hv panic
> callback and fix it.
>
> vmbus_initiate_unload() maybe double called during panic process
> (e.g, hyperv_panic_event() and hv_crash_handler()). So check
> and set connection state in vmbus_initiate_unload() to resolve
> reenter issue.
>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c |  5 +++++
>  drivers/hv/vmbus_drv.c    | 17 +++++++++--------
>  2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 0370364169c4..893493f2b420 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -839,6 +839,9 @@ void vmbus_initiate_unload(bool crash)
>  {
>  	struct vmbus_channel_message_header hdr;
>  
> +	if (vmbus_connection.conn_state == DISCONNECTED)
> +		return;
> +

To make this less racy, can we do something like

	if (xchg(&vmbus_connection.conn_state, DISCONNECTED) == DISCONNECTED)
		return;

?

>  	/* Pre-Win2012R2 hosts don't support reconnect */
>  	if (vmbus_proto_version < VERSION_WIN8_1)
>  		return;
> @@ -857,6 +860,8 @@ void vmbus_initiate_unload(bool crash)
>  		wait_for_completion(&vmbus_connection.unload_event);
>  	else
>  		vmbus_wait_for_unload();
> +
> +	vmbus_connection.conn_state = DISCONNECTED;
>  }
>  
>  static void check_ready_for_resume_event(void)
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 029378c27421..b56b9fb9bd90 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -53,9 +53,12 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
>  {
>  	struct pt_regs *regs;
>  
> -	regs = current_pt_regs();
> +	vmbus_initiate_unload(true);
>  
> -	hyperv_report_panic(regs, val);
> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {

With Michael's effors to make code in drivers/hv arch agnostic, I think
we need a better, arch-neutral way.

> +		regs = current_pt_regs();
> +		hyperv_report_panic(regs, val);
> +	}
>  	return NOTIFY_DONE;
>  }
>  
> @@ -1391,10 +1394,12 @@ static int vmbus_bus_init(void)
>  		}
>  
>  		register_die_notifier(&hyperv_die_block);
> -		atomic_notifier_chain_register(&panic_notifier_list,
> -					       &hyperv_panic_block);
>  	}
>  
> +	/* Vmbus channel is unloaded in panic callback when panic happens.*/
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +			       &hyperv_panic_block);
> +
>  	vmbus_request_offers();
>  
>  	return 0;
> @@ -2204,8 +2209,6 @@ static int vmbus_bus_suspend(struct device *dev)
>  
>  	vmbus_initiate_unload(false);
>  
> -	vmbus_connection.conn_state = DISCONNECTED;
> -
>  	/* Reset the event for the next resume. */
>  	reinit_completion(&vmbus_connection.ready_for_resume_event);
>  
> @@ -2289,7 +2292,6 @@ static void hv_kexec_handler(void)
>  {
>  	hv_stimer_global_cleanup();
>  	vmbus_initiate_unload(false);
> -	vmbus_connection.conn_state = DISCONNECTED;
>  	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
>  	mb();
>  	cpuhp_remove_state(hyperv_cpuhp_online);
> @@ -2306,7 +2308,6 @@ static void hv_crash_handler(struct pt_regs *regs)
>  	 * doing the cleanup for current CPU only. This should be sufficient
>  	 * for kdump.
>  	 */
> -	vmbus_connection.conn_state = DISCONNECTED;
>  	cpu = smp_processor_id();
>  	hv_stimer_cleanup(cpu);
>  	hv_synic_disable_regs(cpu);

-- 
Vitaly

