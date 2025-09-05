Return-Path: <linux-hyperv+bounces-6753-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579DCB46296
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 20:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C22A617F6
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428E822836C;
	Fri,  5 Sep 2025 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HqBTFhzW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964FF305967;
	Fri,  5 Sep 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098118; cv=none; b=O2pYmSghvuGABT5Npt1m9gXYXbA6115LW7XeeTaqzUIYXDgIJF6oIOIsBi+yWE9hjRLDHwFHY/TU2I2e41CSd9kGOPdLC8fZEXucWJatn3myT86jdPEwMRL/ZgEkZ0pH7SlNe6MJCtzH0/MCtyUOxvcoggYU8FZ41iP/Peq7qgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098118; c=relaxed/simple;
	bh=ZYN7kjgpp1SBstT/IbRXfImDXToxoMIu7t63iDp4TqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBafr9HRTduLEsb1CDtUbMIycA601YbTAywJW5kaTSjJXxRcXeBvn8HQchwErd6Nl2jtZ4osBcZ44fFNBPsLbr8zp1iSof8TALKvFDFztLKHSpEFlnco/zoWGbPiCmrNNiqPQcfrnQyE8D9rLJ707xad6LLoDJXjVKikk5jpyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HqBTFhzW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.33.189] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9ED3520171D4;
	Fri,  5 Sep 2025 11:48:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9ED3520171D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757098115;
	bh=UEf1JD/aGiC3VLU1cDq4oELHOZ+jOkavOtqU41LSL24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HqBTFhzWNpOzIk6YsS4ZMbeBlQyeO7WAx+3otw9Y/JlPGOwY/+ACb7aL0pwjLk3pl
	 yRsFfAhUaEFF+jparHEF77hOr3ERORImJUKeAIlJt83EfGWRJgVddq4aqAGftsd8SP
	 17cYi4N/uH2gTc2/tRIItR3tDyixz0Mkpe8IeFbI=
Message-ID: <75bb740c-a539-4e95-b0b0-52cb3f5060d5@linux.microsoft.com>
Date: Fri, 5 Sep 2025 11:48:35 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mshv: Ignore second stats page map result failure
To: Praveen K Paladugu <praveenkpaladugu@gmail.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
 <644647df-64d5-44eb-b7ac-13bd4b81d422@gmail.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <644647df-64d5-44eb-b7ac-13bd4b81d422@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/2025 8:31 AM, Praveen K Paladugu wrote:
> 
> 
> On 8/28/2025 7:43 PM, Nuno Das Neves wrote:
>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>
>> Some versions of the hypervisor do not support HV_STATUS_AREA_PARENT and
>> return HV_STATUS_INVALID_PARAMETER for the second stats page mapping
>> request.
>>
> Is this behavior limited to VP stats? Or does it extend to other
> stats (hypervisor, partition, etc) as well?
> 
In practice we will only need to worry about partition and VP.

In the current code in hyperv-next, it's only VP stats. Upcoming patches
to add debugfs code will also need it for partition stats.

>> This results a failure in module init. Instead of failing, gracefully
> nit: s/This results in a failure during module init/

Thanks, I'll change it for v2

Nuno

>> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
>> already-mapped stats_pages[HV_STATS_AREA_SELF].
>>
>> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>   drivers/hv/mshv_root_hv_call.c | 43 ++++++++++++++++++++++++++++++----
>>   drivers/hv/mshv_root_main.c    |  3 +++
>>   2 files changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index c9c274f29c3c..1c38576a673c 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -724,6 +724,24 @@ hv_call_notify_port_ring_empty(u32 sint_index)
>>       return hv_result_to_errno(status);
>>   }
>>   +static int
>> +hv_stats_get_area_type(enum hv_stats_object_type type,
>> +               const union hv_stats_object_identity *identity)
>> +{
>> +    switch (type) {
>> +    case HV_STATS_OBJECT_HYPERVISOR:
>> +        return identity->hv.stats_area_type;
>> +    case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
>> +        return identity->lp.stats_area_type;
>> +    case HV_STATS_OBJECT_PARTITION:
>> +        return identity->partition.stats_area_type;
>> +    case HV_STATS_OBJECT_VP:
>> +        return identity->vp.stats_area_type;
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>>   int hv_call_map_stat_page(enum hv_stats_object_type type,
>>                 const union hv_stats_object_identity *identity,
>>                 void **addr)
>> @@ -732,7 +750,7 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
>>       struct hv_input_map_stats_page *input;
>>       struct hv_output_map_stats_page *output;
>>       u64 status, pfn;
>> -    int ret = 0;
>> +    int hv_status, ret = 0;
>>         do {
>>           local_irq_save(flags);
>> @@ -747,11 +765,28 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
>>           pfn = output->map_location;
>>             local_irq_restore(flags);
>> -        if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>> -            ret = hv_result_to_errno(status);
>> +
>> +        hv_status = hv_result(status);
>> +        if (hv_status != HV_STATUS_INSUFFICIENT_MEMORY) {
>>               if (hv_result_success(status))
>>                   break;
>> -            return ret;
>> +
>> +            /*
>> +             * Some versions of the hypervisor do not support the
>> +             * PARENT stats area. In this case return "success" but
>> +             * set the page to NULL. The caller checks for this
>> +             * case instead just uses the SELF area.
>> +             */
>> +            if (hv_stats_get_area_type(type, identity) == HV_STATS_AREA_PARENT &&
>> +                hv_status == HV_STATUS_INVALID_PARAMETER) {
>> +                pr_debug_once("%s: PARENT area type is unsupported\n",
>> +                          __func__);
>> +                *addr = NULL;
>> +                return 0;
>> +            }
>> +
>> +            hv_status_debug(status, "\n");
>> +            return hv_result_to_errno(status);
>>           }
>>             ret = hv_call_deposit_pages(NUMA_NO_NODE,
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index bbdefe8a2e9c..56ababab57ce 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -929,6 +929,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>>       if (err)
>>           goto unmap_self;
>>   +    if (!stats_pages[HV_STATS_AREA_PARENT])
>> +        stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
>> +
>>       return 0;
>>     unmap_self:
> 


