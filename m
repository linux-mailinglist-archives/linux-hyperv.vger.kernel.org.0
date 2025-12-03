Return-Path: <linux-hyperv+bounces-7954-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0C4CA1B43
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 22:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89DA730021DD
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C9F2D9EE4;
	Wed,  3 Dec 2025 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ob3v+xJV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003142D94B4;
	Wed,  3 Dec 2025 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798220; cv=none; b=JHd8GYJF/UUMeqsaSb8Aww2zksPZJZHuArjnTfT08MfOVV9UYQUaylXvaKKLFS2/hx5IGgAXF6+uh0wSSvlX+Rm5I7aSFkmzIRxDU7Xhe64NaGEOPaIqTVV3uVU0UGqmBQqOA30tkDPqVlLnBkN6Uq/tn81bdsIw+9XJ/8L40/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798220; c=relaxed/simple;
	bh=UIXj61nNPWtUbXTRKBZDU8wXr4pNVVq1MhVjlqbDYF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pl8oFgi7e/+CfdkvJrK1jeBJZ0HPFy+OpyTt0DeiQfGSeMaO2lzeQxWp/t0L2J7OB+LqitiZPgUr33xO1Ye3biJ4p6YHkUYMoIc5iRQW6sg9K42M47GMRTUGg4IM3nFBywVMH06iS4V0mxDRgFyFfdklcFPccsS/sPnajfWrFuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ob3v+xJV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.205] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 94AF2200E9F8;
	Wed,  3 Dec 2025 13:43:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94AF2200E9F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764798217;
	bh=RRcmL0v1NAgIIN1kQCG0DMsgID2LrHYmivFD2Or7cKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ob3v+xJV1KfRBilqJOeH6JEuQ9yoPprckdcZ08vujcbYc7vu4WmX4A9eM+bE1aazD
	 jsEe+5zlpi5QP58THUzOYkht0h9vzx7le1v1Vsz35629SQbnk/uvc5ODdlqV338GQH
	 bTG5CJzYGZOw4oXhW6Yi1ln4BFtr6zmjXs3iNuao=
Message-ID: <8ae9b13d-b809-431a-b71f-31014b23ae0d@linux.microsoft.com>
Date: Wed, 3 Dec 2025 13:43:35 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mshv: Ignore second stats page map result failure
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, mhklinux@outlook.com,
 prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
 paekkaladevi@linux.microsoft.com
References: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764784405-4484-2-git-send-email-nunodasneves@linux.microsoft.com>
 <aTCJgA3p9UKcIiU5@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aTCJgA3p9UKcIiU5@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/2025 11:03 AM, Stanislav Kinsburskii wrote:
> On Wed, Dec 03, 2025 at 09:53:23AM -0800, Nuno Das Neves wrote:
>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>
>> Older versions of the hypervisor do not support HV_STATS_AREA_PARENT
>> and return HV_STATUS_INVALID_PARAMETER for the second stats page
>> mapping request.
>>
>> This results a failure in module init. Instead of failing, gracefully
>> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
>> already-mapped stats_pages[HV_STATS_AREA_SELF].
>>
>> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root_hv_call.c | 43 ++++++++++++++++++++++++++++++----
>>  drivers/hv/mshv_root_main.c    |  3 +++
>>  2 files changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index 598eaff4ff29..0427785bb7fe 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -855,6 +855,24 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
>>  	return ret;
>>  }
>>  
>> +static int
>> +hv_stats_get_area_type(enum hv_stats_object_type type,
>> +		       const union hv_stats_object_identity *identity)
>> +{
>> +	switch (type) {
>> +	case HV_STATS_OBJECT_HYPERVISOR:
>> +		return identity->hv.stats_area_type;
>> +	case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
>> +		return identity->lp.stats_area_type;
>> +	case HV_STATS_OBJECT_PARTITION:
>> +		return identity->partition.stats_area_type;
>> +	case HV_STATS_OBJECT_VP:
>> +		return identity->vp.stats_area_type;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>>  static int hv_call_map_stats_page(enum hv_stats_object_type type,
>>  				  const union hv_stats_object_identity *identity,
>>  				  void **addr)
>> @@ -863,7 +881,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
>>  	struct hv_input_map_stats_page *input;
>>  	struct hv_output_map_stats_page *output;
>>  	u64 status, pfn;
>> -	int ret = 0;
>> +	int hv_status, ret = 0;
>>  
>>  	do {
>>  		local_irq_save(flags);
>> @@ -878,11 +896,28 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
>>  		pfn = output->map_location;
>>  
>>  		local_irq_restore(flags);
>> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>> -			ret = hv_result_to_errno(status);
>> +
>> +		hv_status = hv_result(status);
>> +		if (hv_status != HV_STATUS_INSUFFICIENT_MEMORY) {
>>  			if (hv_result_success(status))
>>  				break;
>> -			return ret;
>> +
>> +			/*
>> +			 * Older versions of the hypervisor do not support the
>> +			 * PARENT stats area. In this case return "success" but
>> +			 * set the page to NULL. The caller should check for
>> +			 * this case and instead just use the SELF area.
>> +			 */
>> +			if (hv_stats_get_area_type(type, identity) == HV_STATS_AREA_PARENT &&
>> +			    hv_status == HV_STATUS_INVALID_PARAMETER) {
>> +				pr_debug_once("%s: PARENT area type is unsupported\n",
>> +					      __func__);
> 
> Nit: this gebug once looks a bit odd. Why not having it printed always
> (especially given the unconfidional status print a few lines below)?
> 

This isn't indicative of an error, but a missing feature in an older
hypervisor. The rationale of _once is that this information only needs
to be printed once.

Now that I think about it however, it doesn't really change how the
statistics would be interpreted. In the situation where this condition
is triggered (root partition on old hypervisor), all the stats info
is in the HV_STATS_AREA_SELF page anyway. So, maybe this can just be
removed.

> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
> Thanks,
> Stanislav
> 
>> +				*addr = NULL;
>> +				return 0;
>> +			}
>> +
>> +			hv_status_debug(status, "\n");
>> +			return hv_result_to_errno(status);
>>  		}
>>  
>>  		ret = hv_call_deposit_pages(NUMA_NO_NODE,
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index bc15d6f6922f..f59a4ab47685 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -905,6 +905,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>>  	if (err)
>>  		goto unmap_self;
>>  
>> +	if (!stats_pages[HV_STATS_AREA_PARENT])
>> +		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
>> +
>>  	return 0;
>>  
>>  unmap_self:
>> -- 
>> 2.34.1
>>


