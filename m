Return-Path: <linux-hyperv+bounces-3500-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8556A9F8319
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 19:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE351886DB4
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4819E985;
	Thu, 19 Dec 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UtpD+IK/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127C8197552;
	Thu, 19 Dec 2024 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632349; cv=none; b=USzdKEj3zr/x7YYeBV+5LmjX8jWtQInk16kGyQYyusJXyCXuP5xYBs0HIdjZzaMEDHRFIVfNzMdyaWHBgEwZnioIZ5d1pzzd2bLwWee45kHOjbkozhrObPX2ZnGh+NnSpajT1SgJwaxizf1VHfjhBD1nLUOfFnqxRnZ2FHHJR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632349; c=relaxed/simple;
	bh=WhtlubQfz8aiPGeamOPgNakjLSmmPgwDgabz1j5aQl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2rGxUXLSjx5Lek3mtZDTvvvOYSvLoGZmlzD6fTGjtgRR9l6m6ATcsBXhOK8L/7X29v94jO5PKu3ibxBuyl/kQpwM1M18LcaGf6SuRv+C07DMiecgZCT4BzzR4uB/qWiRxzyzloZ0dcLrThmbvGQWx2iMEQl0p6cnR3/oYupj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UtpD+IK/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F79720ACD87;
	Thu, 19 Dec 2024 10:19:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F79720ACD87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734632347;
	bh=mNUpevMFEjT2OFSQqB9NFveQhkkO0ENcWXnOmfc5Gpk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UtpD+IK/TkCOAlkJK9LwnavM664LRvNJ76BEfuZj2g0mhtapz9WcEj48zbsNu6aHc
	 5pEBjoUg/pj0biSDwxsptdaO/hFmrnYv6qdcv0YC5Ykxy47YU4k6QMziUAfpwflOCH
	 pNoxey8Az8nYfUh+iuERp0UPUi4Es8iu2jNEl7FA=
Message-ID: <8da58247-87df-4250-820a-758ea8e00bbb@linux.microsoft.com>
Date: Thu, 19 Dec 2024 10:19:07 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hyperv: Do not overlap the input and output hypercall
 areas in get_vtl(void)
To: Wei Liu <wei.liu@kernel.org>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 eahariha@linux.microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, nunodasneves@linux.microsoft.com, tglx@linutronix.de,
 tiala@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-3-romank@linux.microsoft.com>
 <Z2OIHRF-cJ92IBv2@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z2OIHRF-cJ92IBv2@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/18/2024 6:42 PM, Wei Liu wrote:
> On Wed, Dec 18, 2024 at 12:54:21PM -0800, Roman Kisel wrote:
>> The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2], disallows
>> overlapping of the input and output hypercall areas, and get_vtl(void) does
>> overlap them.
>>
>> To fix this, enable allocation of the output hypercall pages when running in
>> the VTL mode and use the output hypercall page of the current vCPU for the
>> hypercall.
>>
>> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
>> [2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
>>
>> Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_init.c | 2 +-
>>   drivers/hv/hv_common.c    | 6 +++---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index c7185c6a290b..90c9ea00273e 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -422,7 +422,7 @@ static u8 __init get_vtl(void)
>>   
>>   	local_irq_save(flags);
>>   	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> -	output = (struct hv_get_vp_registers_output *)input;
>> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> 
> You can do
> 
> 	output = (char *)input + HV_HYP_PAGE_SIZE / 2;
> 
> to avoid the extra allocation.
> 
> The input and output structures surely won't take up half of the page.
Agreed on the both counts! I do think that the attempt to save here
won't help much: the hypercall output per-CPU pages in the VTL mode are
needed just as in the dom0/root partition mode because this hypercall
isn't going to be the only one required.

In other words, we will have to allocate these pages anyway as we evolve
the code; we are trying to save here what is going to be spent anyway. 
Sort of, kicking the can down the road as the saying goes :)

I do understand that within the code that is already merged, there is
just one this place in this function where the hypercall that returns
data is used. And the proposed approach makes the code self-explanatory:
```
output = *this_cpu_ptr(hyperv_pcpu_output_arg);
```

as opposed to

```
output = (char *)input + HV_HYP_PAGE_SIZE / 2;
```

or, as it existed,

```
output = (struct hv_get_vp_registers_output *)input;
```

which both do require a good comment I believe.

There will surely be more hypercall usage in the VTL mode that return
data and require the output pages as we progress with upstreaming the
VTL patches. Enabling the hypercall output pages allows to fix the
function in question in a very natural way, making it possible to
replace with some future `hv_get_vp_register` that would work for both
dom0 and VTL mode just the same.

All told, if you believe that we should make this patch a one-liner, 
I'll do as you suggested.

> 
> Thanks,
> Wei.
Thank you,
Roman

> 
>>   
>>   	memset(input, 0, struct_size(input, names, 1));
>>   	input->partition_id = HV_PARTITION_ID_SELF;
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index c4fd07d9bf1a..5178beed6ca8 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -340,7 +340,7 @@ int __init hv_common_init(void)
>>   	BUG_ON(!hyperv_pcpu_input_arg);
>>   
>>   	/* Allocate the per-CPU state for output arg for root */
>> -	if (hv_root_partition) {
>> +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>>   		hyperv_pcpu_output_arg = alloc_percpu(void *);
>>   		BUG_ON(!hyperv_pcpu_output_arg);
>>   	}
>> @@ -435,7 +435,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>   	void **inputarg, **outputarg;
>>   	u64 msr_vp_index;
>>   	gfp_t flags;
>> -	int pgcount = hv_root_partition ? 2 : 1;
>> +	const int pgcount = (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) ? 2 : 1;
>>   	void *mem;
>>   	int ret;
>>   
>> @@ -453,7 +453,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>   		if (!mem)
>>   			return -ENOMEM;
>>   
>> -		if (hv_root_partition) {
>> +		if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>>   			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>>   			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>>   		}
>> -- 
>> 2.34.1
>>

-- 
Thank you,
Roman


