Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1AE638D94
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Nov 2022 16:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKYPka (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Nov 2022 10:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiKYPj6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Nov 2022 10:39:58 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E59B2CCBE
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Nov 2022 07:39:58 -0800 (PST)
Received: from [192.168.1.10] (unknown [122.181.76.145])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3C47420B83C2;
        Fri, 25 Nov 2022 07:39:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C47420B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669390797;
        bh=9kHM4kXm6k8RKf2MJV8gYZXvGuAdjfVTw9vqXUbgrKQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MBg8hIKW6AcK7T0FovXma5azEJKB78U/ZWibbcK5YrfKFfTH400hgYVhBCuqDQaYB
         Sz2MYFbGOP9mff++INClLbSlBfVtgF3MdYx4MbqHiarVp3HoIe+iF+mV8OTYqSFo3l
         6TeEIDbp1h43P2vayfua/xSP4vqRb0HBLE1tGoWE=
Subject: Re: [PATCH] x86/hyperv: Remove unregister syscore call from hyperv
 cleanup
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, decui@microsoft.com, haiyangz@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-hyperv@vger.kernel.org, bp@alien8.de,
        mikelley@microsoft.com
References: <1669267391-9809-1-git-send-email-gauravkohli@linux.microsoft.com>
 <Y4DfOq94C4sPWM5+@liuwe-devbox-debian-v2>
From:   Gaurav Kohli <gauravkohli@linux.microsoft.com>
Message-ID: <a7689a77-ff0d-97c2-3938-9e6422ec069b@linux.microsoft.com>
Date:   Fri, 25 Nov 2022 21:09:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Y4DfOq94C4sPWM5+@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 11/25/2022 8:58 PM, Wei Liu wrote:
> On Wed, Nov 23, 2022 at 09:23:11PM -0800, Gaurav Kohli wrote:
>> Hyperv cleanup codes comes under panic path where preemption and irq
> Please use "Hyper-V" throughout.
Thanks for the comment, sure will do on v2.
>
>> is already disabled. So calling of unregister_syscore_ops which has mutex
>> from hyperv cleanup might schedule out the thread and never comes back.
>>
> While on paper this looks problematic -- have you seen this issue
> triggered in real life?
>
> This looks to be only triggered when there is another thread already
> holding the mutex, which seems rather rare in the life cycle of the
> machine?


Earlier we also suspected the same that someone was holding the lock, 
but actually there

was no owner of lock and it got scheduled out due to might sleep code in 
mutex_lock.

Looks like where voluntary preemption config is on, there it is getting 
scheduled out in might sleep.

But there is no need of unregister_syscore_ops as this is in crash path 
only, So removing the same.

>
>> To prevent the same remove unwanted unregister_syscore_ops function call.
>>
>> Signed-off-by: Gaurav Kohli <gauravkohli@linux.microsoft.com>
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index f49bc3ec76e6..c050de69dfde 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -537,7 +537,12 @@ void hyperv_cleanup(void)
>>   	union hv_x64_msr_hypercall_contents hypercall_msr;
>>   	union hv_reference_tsc_msr tsc_msr;
>>   
>> -	unregister_syscore_ops(&hv_syscore_ops);
>> +	/*
>> +	 * Avoid unregister_syscore_ops(&hv_syscore_ops) from cleanup code,
>> +	 * as this is only called in crash path where irq and preemption disabled.
>> +	 * If we add this, there is a chance that this get scheduled out due to mutex
>> +	 * in unregister_syscore_ops and never comes back.
>> +	 */
> There is no need to document things we don't do, right?

Yes, we have added so to avoid the same in future.

>
>>   
>>   	/* Reset our OS id */
>>   	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>> -- 
>> 2.17.1
>>
