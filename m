Return-Path: <linux-hyperv+bounces-6781-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A57B49675
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 19:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09D51C2233A
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4C311595;
	Mon,  8 Sep 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Vav6NozA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD6E3054D4;
	Mon,  8 Sep 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351065; cv=none; b=lsvBCGRhihUPMutvZEd3JKW0Gr3F/n57BF+y6a4lrUNSLSCLCtfoePeTUOW+T/4TfLRb1APj/PCAuBIinYS6vIRaoC9Ajv+l/mdVfipDTS4JMwtdmkJIHRB/82tijfQKMaXh3p8ijSy2saVIUOLcTkhY1906589dhNjmYPCg1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351065; c=relaxed/simple;
	bh=NZE29L+co8Jye7ez/b5xsx9TZfPOKPJrzfz2Gsmg+88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASXMyVIl8RpwSuqtYADDieAxNhUmUTH+WXzovJmhuS8SAvNDQnRhzjVKIDMwYf2znPCcBuNePyHi57rYc3q15OaNPssmD1/YJa+91BYZdNSY5kMTaNofR3EDgLCVQEehJeoOQ5LAF8IWzZJGmwfLOYpizQe6+1WhQUFlWAXBVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Vav6NozA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.199] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9D362117647;
	Mon,  8 Sep 2025 10:04:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9D362117647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757351063;
	bh=/xQtosVmPyQSaVWJu2sGOMwPBrt/1Y+EWOUauAjpv7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vav6NozAj7Cqri2DLRm6kTYOCUf1iNUoLI3sWsC7XoaqsFDH38951eVtP9tHjhMxH
	 +k2WR0CK9c54bvCvqC8W2QLG1qO9+psh9FvFdiIqOTiNFrRLxAuyRHSHHi1+DM0H00
	 OkZMJ+zZ1Zkb3o9zTZ/UC1TzIKHraR8MMwrJftg8=
Message-ID: <874a2370-84f1-4cec-bb06-a13fe11b49ca@linux.microsoft.com>
Date: Mon, 8 Sep 2025 10:04:22 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mshv: Ignore second stats page map result failure
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
 <efc78065-3556-410a-866f-961a7f1fc1ac@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <efc78065-3556-410a-866f-961a7f1fc1ac@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/2025 12:21 PM, Easwar Hariharan wrote:
> On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>
>> Some versions of the hypervisor do not support HV_STATUS_AREA_PARENT and
>> return HV_STATUS_INVALID_PARAMETER for the second stats page mapping
>> request.
>>
>> This results a failure in module init. Instead of failing, gracefully
>> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
>> already-mapped stats_pages[HV_STATS_AREA_SELF].
> 
> What's the impact of this graceful fallback? It occurs to me that if a stats
> accumulator, in userspace perhaps, expected to get stats from the 2 pages,
> it'd get incorrect values.
> 
This is going out of scope of this series a bit but I'll explain briefly.

When we do add the code to expose these stats to userspace, the SELF and
PARENT pages won't be exposed separately, there is no duplication.

For each stat counter in the page, we'll expose either the SELF or PARENT
value, depending on whether there is anything in that slot (whether it's zero
or not).

Some stats are available via the SELF page, and some via the PARENT page, but
the counters in the page have the same layout. So some counters in the SELF
page will all stay zero while on the PARENT page they are updated, and vice
versa.

I believe the hypervisor takes this strange approach for the purpose of
backward compatibility. Introducing L1VH created the need for this SELF/PARENT
distinction.

Hope that makes some kind of sense...it will be clearer when we post the mshv
debugfs code itself.

To put it another way, falling back to the SELF page won't cause any impact
to userspace because the distinction between the pages is all handled in the
driver, and we only read each stat value from either SELF or PARENT.

Nuno

>>
>> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root_hv_call.c | 43 ++++++++++++++++++++++++++++++----
>>  drivers/hv/mshv_root_main.c    |  3 +++
>>  2 files changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index c9c274f29c3c..1c38576a673c 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -724,6 +724,24 @@ hv_call_notify_port_ring_empty(u32 sint_index)
>>  	return hv_result_to_errno(status);
>>  }
>>  
>> +static int
>> +hv_stats_get_area_type(enum hv_stats_object_type type,
> 
> One line please, i.e.
> 
> static int hv_stats_get_area_type(...)
> 
> <snip>
> 
> Thanks,
> Easwar (he/him)


