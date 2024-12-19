Return-Path: <linux-hyperv+bounces-3499-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7DD9F81D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 18:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF2B167442
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438A19C546;
	Thu, 19 Dec 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BfvFMjGr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601B678F5E;
	Thu, 19 Dec 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629205; cv=none; b=IYZDYkStKA658Ce6vDgI5+B+dn6owOKJCNlMz7891BYTkQxrPqEZM+3XRExLblp4/K/b0ok1eNS7UCGpbuRViUTD6Sfs2cTZOvsV1NUzS0MtDfb6PRXTIZbubxEyCv4aD9GKL5vBNWQdlh+KVoMKmDx98JIb9iVOqCBtfnOVB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629205; c=relaxed/simple;
	bh=d/xuCFZAgDOkXYEvoohJQWlGU6Z/HGSCETq1IHHFin8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLsaQ5RixjpXku6vJ8GLlh0duCtq5ElcZY6zvM4U03JJ1JPB7upRVQdYt722fDOrhSQvHF2b55j078rVlQGki7xPs7VHQssLxDEygcjfCgOtx+Nw04rFF9hqdHu77XhheZCEC3YRvQsL3J3lIqJNKB1IedHN9rXChIYiqmkScb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BfvFMjGr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE3C9203FC93;
	Thu, 19 Dec 2024 09:26:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE3C9203FC93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734629203;
	bh=+z8sYJqu+2oIAHhmE0RGUrc2vKdTsZ0gS2whJ8tKcnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BfvFMjGrNjHmCyz90KaDV3aR0SlbSwLgT1u2hHllc4a9jVJManwYrvSXmkqryRWDC
	 oPKIehNcl8OmnG449ES26Zv2VPN8OjrEgJLT2BU4FCfrLvsZLHcRORaCAU8a8tugGo
	 Daf8Lh63eA2BkNB/quLWqvY0oURR268gVH4sOqLE=
Message-ID: <7ee1d094-b894-4263-bb19-99d3f97494a5@linux.microsoft.com>
Date: Thu, 19 Dec 2024 09:26:43 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hyperv: Fix pointer type for the output of the
 hypercall in get_vtl(void)
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
 <20241218205421.319969-2-romank@linux.microsoft.com>
 <Z2OIsFUXcjVXpqtw@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z2OIsFUXcjVXpqtw@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/18/2024 6:45 PM, Wei Liu wrote:
> On Wed, Dec 18, 2024 at 12:54:20PM -0800, Roman Kisel wrote:
>> Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
>> changed the type of the output pointer to `struct hv_register_assoc` from
>> `struct hv_get_vp_registers_output`. That leads to an incorrect computation,
>> and leaves the system broken.
>>
>> Use the correct pointer type for the output of the GetVpRegisters hypercall.
>>
>> Fixes: bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
> 
> This commit is not in the mainline kernel yet, so this tag is not
> needed.
Got it, thanks for the explanation!

> 
> It will most likely to be wrong since I will need to rebase the
> hyperv-next branch.
> 
> I can fold this patch into the original patch and leave your
> Signed-off-by there.
That would be great and appreciated very much, thank you!

> 
> Thanks,
> Wei.
Thank you,
Roman

> 
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
>> -- 
>> 2.34.1
>>

-- 
Thank you,
Roman


