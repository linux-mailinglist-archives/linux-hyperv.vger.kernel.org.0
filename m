Return-Path: <linux-hyperv+bounces-3502-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78F9F83D3
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 20:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DEF168873
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAC11A9B25;
	Thu, 19 Dec 2024 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qJ3l/8rZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8D11A9B4D;
	Thu, 19 Dec 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635513; cv=none; b=q9nYCihL7fUMI5KhFXLiAgLX4E6i/UUlnDkYLt/4dyGaFA0V552XvGW3ZNNKwVK9oSoSw8zWqHV6UslJtINi5uwhpaqQOcBTRQ0rMw7o5uNzTTSBjE1MA6ZmEH1DlFj+t1V1ymy5xtGUKbOv4VlZbDEBYqndy1dTLDi8bTj6SbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635513; c=relaxed/simple;
	bh=n2IcJBB4qbRpfPfqQlj4KXlrsfKXydKsCqtx2UJZX4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/UGiqqAffsS6+jzqMs3l7tqx491rddkLqDBuPH5qh6P9E/bFgJWceSWoidg322dfjovAcx4cO+OJpjfewyiEjqIRkL6/UOkzcQ7UbH8btNDW3SkDJkjA7Tnppw+fhi7wJtRuO6tiR6IBP8mv3Y5i4EE1sHvIPbL1MpzOy/Xo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qJ3l/8rZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4A5B203FC94;
	Thu, 19 Dec 2024 11:11:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4A5B203FC94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734635510;
	bh=RHykrDx6QIdTM9BEmOmabvIJ7h7pHRJEXYtwbD+4UEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qJ3l/8rZJ6h0jFSjRcXIIs1ARxLYT9aUB9zz3p3vGd1N96EAZDpKYrzhmUQnbDGAs
	 i0MxjuygGLd4EezM3fCXwdtlZBnvIDPUIIxwK7nAxvLVta4IVSJQgHQYi3gQoipYwy
	 b7OARqxhidi3O7h7MAkoi2Cw+wL36iLT8y31DPM0=
Message-ID: <00986b68-3784-4087-af83-36e5db1a76c9@linux.microsoft.com>
Date: Thu, 19 Dec 2024 11:11:49 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hyperv: Fix pointer type for the output of the
 hypercall in get_vtl(void)
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, eahariha@linux.microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-2-romank@linux.microsoft.com>
 <17f81f98-a7ca-45e0-87be-9f1cfa5c5a95@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <17f81f98-a7ca-45e0-87be-9f1cfa5c5a95@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/2024 10:40 AM, Nuno Das Neves wrote:
> On 12/18/2024 12:54 PM, Roman Kisel wrote:
>> Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
>> changed the type of the output pointer to `struct hv_register_assoc` from
>> `struct hv_get_vp_registers_output`. That leads to an incorrect computation,
>> and leaves the system broken.
>>
> My bad! But, lets not use `struct hv_get_registers_output`. Instead, use
> `struct hv_register_value`, since that is the more complete definition of a
> register value. The output of the get_vp_registers hypercall is just an array
> of these values.
> 
> Ideally we remove `struct hv_get_vp_registers_output` at some point, since
> it serves the same role as `struct hv_register_value` but in a more limited
> capacity.
Nuno, thank you very much for your help! Agreed, I will use `struct
  hv_register_value` in v2.

> 
> Thanks
> Nuno
Thank you,
Roman

> 
>> Use the correct pointer type for the output of the GetVpRegisters hypercall.
>>
>> Fixes: bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_init.c   | 6 +++---
>>   include/hyperv/hvgdk_mini.h | 3 ---
>>   2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 3cf2a227d666..c7185c6a290b 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -416,13 +416,13 @@ static u8 __init get_vtl(void)
>>   {
>>   	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
>>   	struct hv_input_get_vp_registers *input;
>> -	struct hv_register_assoc *output;
>> +	struct hv_get_vp_registers_output *output;
>>   	unsigned long flags;
>>   	u64 ret;
>>   
>>   	local_irq_save(flags);
>>   	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> -	output = (struct hv_register_assoc *)input;
>> +	output = (struct hv_get_vp_registers_output *)input;
>>   
>>   	memset(input, 0, struct_size(input, names, 1));
>>   	input->partition_id = HV_PARTITION_ID_SELF;
>> @@ -432,7 +432,7 @@ static u8 __init get_vtl(void)
>>   
>>   	ret = hv_do_hypercall(control, input, output);
>>   	if (hv_result_success(ret)) {
>> -		ret = output->value.reg8 & HV_X64_VTL_MASK;
>> +		ret = output->as64.low & HV_X64_VTL_MASK;
>>   	} else {
>>   		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
>>   		BUG();
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index db3d1aaf7330..0b1a10828f33 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>> @@ -1107,7 +1107,6 @@ union hv_register_value {
>>   	union hv_x64_pending_interruption_register pending_interruption;
>>   };
>>   
>> -#if defined(CONFIG_ARM64)
>>   /* HvGetVpRegisters returns an array of these output elements */
>>   struct hv_get_vp_registers_output {
>>   	union {
>> @@ -1124,8 +1123,6 @@ struct hv_get_vp_registers_output {
>>   	};
>>   };
>>   
>> -#endif /* CONFIG_ARM64 */
>> -
>>   struct hv_register_assoc {
>>   	u32 name;			/* enum hv_register_name */
>>   	u32 reserved1;

-- 
Thank you,
Roman


