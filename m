Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08EDC18ADE0
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 09:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCSIDY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 04:03:24 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38298 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSIDY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 04:03:24 -0400
Received: by mail-pj1-f67.google.com with SMTP id m15so669990pje.3;
        Thu, 19 Mar 2020 01:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=voq9Hzu4iRHZMZbGjcaMK/nNCBty28QmnRnnCYGueCg=;
        b=iylglhY4X4Ncl9Cs5dwjcFoi+jDMP36KSGZAN8yanqClgRzAVRQHFiE/GRAHD6OFM8
         XonniPw7C77bHbxAH0YbFNDv0b30PVgn+H4I5mhGUBz80iQOFjAwQwY3iMbmKPUPfBxO
         VJjs9/5R41H4lROReV3Af4vAY7ADXoLIeWGFwBd0XVsd1Rt7bK/oHiohbOW1OwScsc8X
         +EYi5zNupnqQFbfAp3SjGnM/poxmYamT4nmGKURLJGGLQfbhec7FXrhx7oJ2T1DFy1Ew
         bnQSTu8M6mwh7n/Ogdox+aRPQUJgHBuI0F3zh0FoBAyU5yxkRj7VotPQ+dXry5XnAJQZ
         YbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=voq9Hzu4iRHZMZbGjcaMK/nNCBty28QmnRnnCYGueCg=;
        b=haHbZxJg1jurTcKNoDkquCuwIMsRokTrQaC30TCn+SniIi9tMTOSn52pdFCvfxkPR6
         oEo4o7kq00+rc0MXpREZ0W2ayJdoP7OU76uNzWf+HqePFez1/epC9F4k+GVvOlNoWYqD
         US9dIW8wDLjx/j0Mth5o73r7oAnJZheuRXdrygTaPoQ1WaUAGX/UOn7lWtZ7ZWqhbRPY
         5hJycvzHXnc5aKpQldKQmb6kBmu60qD13NMDYOs6PXf0zSRetAV46ZrgQWUu545gP3gr
         xMcZA15/GJF871f1ZGB9CySfpvO6nc4FPl6WYu8w0eicmTRyoxhSjQRWg3Llzvl7Or0L
         K9NA==
X-Gm-Message-State: ANhLgQ06LEku7RSCYaSgb6VpO1PAS0bNU+Pb5WQYyFOO5wChGtEcip5g
        dwZReXg8yRKxk4+xdSvmHEs+Nd6i
X-Google-Smtp-Source: ADFU+vsg5Yh1V3FYZWuhj3a6244en3AVKctMGa5jTZHs9nZOxdB/VOKTKTWW7j8Vk+KUfGbm2cRrjw==
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr2339393pln.178.1584605002487;
        Thu, 19 Mar 2020 01:03:22 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:18:efed::a31c])
        by smtp.gmail.com with ESMTPSA id t17sm1474050pgn.94.2020.03.19.01.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 01:03:21 -0700 (PDT)
Subject: Re: [PATCH 0/4] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <20200317132523.1508-2-Tianyu.Lan@microsoft.com>
 <871rpp3ba8.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <561895b0-3780-0fa6-0ec6-2255ca1cd637@gmail.com>
Date:   Thu, 19 Mar 2020 16:03:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <871rpp3ba8.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Vitaly:
      Thanks for your review.

On 3/18/2020 11:58 PM, Vitaly Kuznetsov wrote:
> ltykernel@gmail.com writes:
> 
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Customer reported Hyper-V VM still responded network traffic
>> ack packets after kernel panic with kernel parameter "panic=0”.
>> This becauses vmbus driver interrupt handler still works
>> on the panic cpu after kernel panic. Panic cpu falls into
>> infinite loop of panic() with interrupt enabled at that point.
>> Vmbus driver can still handle network traffic.
>>
>> This confuses remote service that the panic system is still
>> alive when it gets ack packets. Unload vmbus channel in hv panic
>> callback and fix it.
>>
>> vmbus_initiate_unload() maybe double called during panic process
>> (e.g, hyperv_panic_event() and hv_crash_handler()). So check
>> and set connection state in vmbus_initiate_unload() to resolve
>> reenter issue.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>>   drivers/hv/channel_mgmt.c |  5 +++++
>>   drivers/hv/vmbus_drv.c    | 17 +++++++++--------
>>   2 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> index 0370364169c4..893493f2b420 100644
>> --- a/drivers/hv/channel_mgmt.c
>> +++ b/drivers/hv/channel_mgmt.c
>> @@ -839,6 +839,9 @@ void vmbus_initiate_unload(bool crash)
>>   {
>>   	struct vmbus_channel_message_header hdr;
>>   
>> +	if (vmbus_connection.conn_state == DISCONNECTED)
>> +		return;
>> +
> 
> To make this less racy, can we do something like
> 
> 	if (xchg(&vmbus_connection.conn_state, DISCONNECTED) == DISCONNECTED)
> 		return;
> 
> ?

Agree. Will update in the next version.

> 
>>   	/* Pre-Win2012R2 hosts don't support reconnect */
>>   	if (vmbus_proto_version < VERSION_WIN8_1)
>>   		return;
>> @@ -857,6 +860,8 @@ void vmbus_initiate_unload(bool crash)
>>   		wait_for_completion(&vmbus_connection.unload_event);
>>   	else
>>   		vmbus_wait_for_unload();
>> +
>> +	vmbus_connection.conn_state = DISCONNECTED;
>>   }
>>   
>>   static void check_ready_for_resume_event(void)
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 029378c27421..b56b9fb9bd90 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -53,9 +53,12 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
>>   {
>>   	struct pt_regs *regs;
>>   
>> -	regs = current_pt_regs();
>> +	vmbus_initiate_unload(true);
>>   
>> -	hyperv_report_panic(regs, val);
>> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> 
> With Michael's effors to make code in drivers/hv arch agnostic, I think
> we need a better, arch-neutral way.
> 
>> +		regs = current_pt_regs();
>> +		hyperv_report_panic(regs, val);
>> +	}
>>   	return NOTIFY_DONE;
>>   }
>>   
>> @@ -1391,10 +1394,12 @@ static int vmbus_bus_init(void)
>>   		}
>>   
>>   		register_die_notifier(&hyperv_die_block);
>> -		atomic_notifier_chain_register(&panic_notifier_list,
>> -					       &hyperv_panic_block);
>>   	}
>>   
>> +	/* Vmbus channel is unloaded in panic callback when panic happens.*/
>> +	atomic_notifier_chain_register(&panic_notifier_list,
>> +			       &hyperv_panic_block);
>> +
>>   	vmbus_request_offers();
>>   
>>   	return 0;
>> @@ -2204,8 +2209,6 @@ static int vmbus_bus_suspend(struct device *dev)
>>   
>>   	vmbus_initiate_unload(false);
>>   
>> -	vmbus_connection.conn_state = DISCONNECTED;
>> -
>>   	/* Reset the event for the next resume. */
>>   	reinit_completion(&vmbus_connection.ready_for_resume_event);
>>   
>> @@ -2289,7 +2292,6 @@ static void hv_kexec_handler(void)
>>   {
>>   	hv_stimer_global_cleanup();
>>   	vmbus_initiate_unload(false);
>> -	vmbus_connection.conn_state = DISCONNECTED;
>>   	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
>>   	mb();
>>   	cpuhp_remove_state(hyperv_cpuhp_online);
>> @@ -2306,7 +2308,6 @@ static void hv_crash_handler(struct pt_regs *regs)
>>   	 * doing the cleanup for current CPU only. This should be sufficient
>>   	 * for kdump.
>>   	 */
>> -	vmbus_connection.conn_state = DISCONNECTED;
>>   	cpu = smp_processor_id();
>>   	hv_stimer_cleanup(cpu);
>>   	hv_synic_disable_regs(cpu);
> 
