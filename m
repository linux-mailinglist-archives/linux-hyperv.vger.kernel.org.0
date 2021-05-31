Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140B639595E
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 May 2021 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEaLDM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 May 2021 07:03:12 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52466 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhEaLDH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 May 2021 07:03:07 -0400
Received: from [192.168.1.79] (unknown [106.201.36.115])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4979F20B7178;
        Mon, 31 May 2021 04:01:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4979F20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622458887;
        bh=cHg9rnFx1Hr6LTraeqQPRPTYr4rEZm92MuTQAUKcmZU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pnYqze9cTbkvCCFB/cJed0KeYs9wWOS6E5On1sujrV49HkgbUVYFFPydRxjP0gnLM
         lLasu0B3Z6m8Wr8waCInEkWF3g41bIkl/VoRIa6TaA/iOiTuTmECf9p3YXbDeUN5FV
         F57uJXiDK3xSpWoOD3L7YwWguPXRU8cbD6UoRufw=
Subject: Re: [PATCH] x86/hyperv: LP creation with lp_index on same CPU-id
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, nunodasneves@linux.microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
References: <20210531074046.113452-1-kumarpraveen@linux.microsoft.com>
 <20210531105732.muzbpk4yksttsfwz@liuwe-devbox-debian-v2>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <572da60e-714f-b207-a89e-6dc40209e2da@linux.microsoft.com>
Date:   Mon, 31 May 2021 16:31:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531105732.muzbpk4yksttsfwz@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 5/31/2021 4:27 PM, Wei Liu wrote:
> On Mon, May 31, 2021 at 01:10:46PM +0530, Praveen Kumar wrote:
>> The hypervisor expects the lp_index to be same as cpu-id during LP creation
>> This fix correct the same, as cpu_physical_id can give different cpu-id.
> 
> Code looks fine to me, but the commit message can be made clearer.
> 
> """
> The hypervisor expects the logical processor index to be the same as
> CPU's id during logical processor creation. Using cpu_physical_id
> confuses Microsoft Hypervisor's scheduler. That causes the root
> partition not boot when core scheduler is used.
> 
> This patch removes the call to cpu_physical_id and uses the CPU index
> directly for bringing up logical processor. This scheme works for both
> classic scheduler and core scheduler.
> 
> Fixes: 333abaf5abb3 (x86/hyperv: implement and use hv_smp_prepare_cpus)
> """
> 
> No action is required from you. If you are fine with this commit message
> I can incorporate it and update the subject line when committing this
> patch.
> 

Thanks Wei for your comments. I'm fine with your inputs. Please go ahead. Thanks.

Regards,

~Praveen.

>>
>> Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
>> ---
>>  arch/x86/kernel/cpu/mshyperv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 22f13343b5da..4fa0a4280895 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -236,7 +236,7 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>>  	for_each_present_cpu(i) {
>>  		if (i == 0)
>>  			continue;
>> -		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
>> +		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, i);
>>  		BUG_ON(ret);
>>  	}
>>  
>> -- 
>> 2.25.1
>>
