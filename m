Return-Path: <linux-hyperv+bounces-5148-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751F3A9CE48
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 18:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111AA9A07FE
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6600E1AD41F;
	Fri, 25 Apr 2025 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I8x1/U+2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821B91ABEC5;
	Fri, 25 Apr 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598952; cv=none; b=L1ZBNTam15ZRqXhhG+flWCCcfpcc5VKMwQJvKMzjp2qDMEKQhlqf4AqywmBLxOih9/O0k7tgEZNMhSoQzWpuGB5xibbhAnEXiklgyZA5wKZ1/twVS2n8oAkz9hPC8/hlIMv7AsZ/9n1hVtgsQC277p3sIaGkXlSNycuDJSbfNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598952; c=relaxed/simple;
	bh=g8uVLiSVpRDFh+Lb4HPlarg+nGqcnGhve4ugtK+tdhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awzne+mPZbl5hMLtklw8g0QuQGukaeVCHHcIPgBJ0vysKAaVxqTDOxdh9k1PqYvePCu3ncqBxR0bfBxVeMsSaVT06K5fY0ZaghXqxDyjv8taCl5cyu6TjqVKYjUAqF/b30u9LydXSg/oSYS709iih2dlLVB8UPtrXlxZbu0l9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I8x1/U+2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.16.80.157] (unknown [131.107.147.157])
	by linux.microsoft.com (Postfix) with ESMTPSA id D19B12020949;
	Fri, 25 Apr 2025 09:35:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D19B12020949
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745598950;
	bh=pgh4s66JUw4GAxqgsyHl2jOBsiKGUIf/XuKLJR8T5C0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I8x1/U+2A2rn9w8uQioMBsGaid3iFRZUlZXFLTWsipb1K4OpFa6lp6QD3vM6waEwG
	 SRDce8nTbqoX8SEgOdaLSFQsxZzw0X1piDOIuP4Tcl88vxIxvI2Q6YWKJVodosDtcn
	 ALyhjD3XBqZP8XsxSnr7Jawi7InijJdy3HuEwU/Y=
Message-ID: <8a235e4f-f4ce-445e-9714-380573033455@linux.microsoft.com>
Date: Fri, 25 Apr 2025 09:35:49 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP ID confusion
 in hv_snp_boot_ap()
To: Michael Kelley <mhklinux@outlook.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
References: <20250424215746.467281-1-romank@linux.microsoft.com>
 <SN6PR02MB4157E849025C4A6B64933150D4842@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157E849025C4A6B64933150D4842@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/2025 8:12 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, April 24, 2025 2:58 PM
>>
>> To start an application processor in SNP-isolated guest, a hypercall
>> is used that takes a virtual processor index. The hv_snp_boot_ap()
>> function uses that START_VP hypercall but passes as VP ID to it what
>> it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
>>
>> As those two aren't generally interchangeable, that may lead to hung
>> APs if VP IDs and APIC IDs don't match, e.g. APIC IDs might be sparse
>> whereas VP IDs never are.
> 
> I agree that VP IDs (a.k.a. VP indexes) and APIC IDs don't necessary match,
> and that APIC IDs might be sparse. But I'm not aware of any statement
> in the TLFS about the nature of VP indexes, except that
> 
>     "A virtual processor index must be less than the maximum number of
>     virtual processors per partition."
> 
> But that maximum is the Hyper-V implementation maximum, not the
> maximum for a particular VM. So the statement does not imply
> denseness unless the number of CPUs in the VM is equal to the
> Hyper-V implementation max. In other parts of Linux kernel code,
> we assume that VP indexes might be sparse as well.
> 
> All that said, this is just a comment about the precise accuracy of
> your commit message, and doesn't affect the code.
> 

I appreciate your help with the precision. I used loose language,
agreed, would like to fix that. The patch was applied though but not yet
sent to the Linus'es tree as I understand. I'd appreciate guidance on
the process! Should I send a v2 nevertheless and explain the situation
in the cover letter?

IOW, how do I make this easier for the maintainer(s)?

>>
>> Update the parameter names to avoid confusion as to what the parameter
>> is. Use the APIC ID to VP ID conversion to provide correct input to the
>> hypercall.
> 
> Terminology:  The TLFS calls this the "VP Index", not the "VP ID".  In
> other Linux code, we also call it the "VP Index".  See the hv_vp_index
> array, for example.  The exception is the hypercall itself, which the TLFS
> calls HvCallGetVpIndexFromApicId, but which our Linux code calls
> HVCALL_GET_VP_ID_FROM_APIC_ID for some unknown reason.
> 
> Could you fix the terminology to be consistent?  And maybe fix the
> HVCALL_* string name as well.  I know you are just moving the
> existing VTL code, but let's take the opportunity to avoid any
> terminology inconsistency.
> 

I percieved ID as both "index" and "identificator" I guess but maybe
"idx" is more like "index". I'll send out a fix for the terminology,
thanks for your help!

>>
>> Cc: stable@vger.kernel.org
>> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_init.c       | 33 ++++++++++++++++++++++++++++++++
>>   arch/x86/hyperv/hv_vtl.c        | 34 +--------------------------------
>>   arch/x86/hyperv/ivm.c           | 11 +++++++++--
>>   arch/x86/include/asm/mshyperv.h |  5 +++--
>>   4 files changed, 46 insertions(+), 37 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index ddeb40930bc8..23422342a091 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -706,3 +706,36 @@ bool hv_is_hyperv_initialized(void)
>>   	return hypercall_msr.enable;
>>   }
>>   EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
>> +
>> +int hv_apicid_to_vp_id(u32 apic_id)
>> +{
>> +	u64 control;
>> +	u64 status;
>> +	unsigned long irq_flags;
>> +	struct hv_get_vp_from_apic_id_in *input;
>> +	u32 *output, ret;
>> +
>> +	local_irq_save(irq_flags);
>> +
>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	memset(input, 0, sizeof(*input));
>> +	input->partition_id = HV_PARTITION_ID_SELF;
>> +	input->apic_ids[0] = apic_id;
>> +
>> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> +
>> +	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
>> +	status = hv_do_hypercall(control, input, output);
>> +	ret = output[0];
>> +
>> +	local_irq_restore(irq_flags);
>> +
>> +	if (!hv_result_success(status)) {
>> +		pr_err("failed to get vp id from apic id %d, status %#llx\n",
>> +		       apic_id, status);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(hv_apicid_to_vp_id);
>> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
>> index 582fe820e29c..8bc4f0121e5e 100644
>> --- a/arch/x86/hyperv/hv_vtl.c
>> +++ b/arch/x86/hyperv/hv_vtl.c
>> @@ -205,38 +205,6 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
>>   	return ret;
>>   }
>>
>> -static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>> -{
>> -	u64 control;
>> -	u64 status;
>> -	unsigned long irq_flags;
>> -	struct hv_get_vp_from_apic_id_in *input;
>> -	u32 *output, ret;
>> -
>> -	local_irq_save(irq_flags);
>> -
>> -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> -	memset(input, 0, sizeof(*input));
>> -	input->partition_id = HV_PARTITION_ID_SELF;
>> -	input->apic_ids[0] = apic_id;
>> -
>> -	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> -
>> -	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
>> -	status = hv_do_hypercall(control, input, output);
>> -	ret = output[0];
>> -
>> -	local_irq_restore(irq_flags);
>> -
>> -	if (!hv_result_success(status)) {
>> -		pr_err("failed to get vp id from apic id %d, status %#llx\n",
>> -		       apic_id, status);
>> -		return -EINVAL;
>> -	}
>> -
>> -	return ret;
>> -}
>> -
>>   static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
>>   {
>>   	int vp_id, cpu;
>> @@ -250,7 +218,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned
>> long start_eip)
>>   		return -EINVAL;
>>
>>   	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
>> -	vp_id = hv_vtl_apicid_to_vp_id(apicid);
>> +	vp_id = hv_apicid_to_vp_id(apicid);
>>
>>   	if (vp_id < 0) {
>>   		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index c0039a90e9e0..e3c32bb0d0cf 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
>>   		free_page((unsigned long)vmsa);
>>   }
>>
>> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
>>   {
>>   	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
>>   		__get_free_page(GFP_KERNEL | __GFP_ZERO);
>> @@ -297,10 +297,17 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>>   	u64 ret, retry = 5;
>>   	struct hv_enable_vp_vtl *start_vp_input;
>>   	unsigned long flags;
>> +	int vp_id;
>>
>>   	if (!vmsa)
>>   		return -ENOMEM;
>>
>> +	vp_id = hv_apicid_to_vp_id(apic_id);
>> +
>> +	/* The BSP or an error */
>> +	if (vp_id <= 0)
> 
> Returning an error on value 0 may be problematic here. Consider
> the panic case where a CPU other than the BSP takes a panic and
> initiates kdump. If the kdump kernel runs with more than 1 CPU, it
> may try to start the CPU that was originally the BSP. To my
> knowledge, SEV-SNP guests on Hyper-V don't support kdump at
> the moment so this problem is currently theoretical, but let's not
> leave a potential future problem by excluding 0 here.
> 
> Also, since I assert that we really don't know anything about the
> VP index values, we can't exclude 0.  It may or may not be the
> original BSP.
> 

I believed that the BSP is always 0 yet as long as that's not in TLFS,
that's not true, I agree on that. Probably not this function's job to
check that the processor shouldn't be attempted to start, will fix!

> Michael
> 
>> +		return -EINVAL;
>> +
>>   	native_store_gdt(&gdtr);
>>
>>   	vmsa->gdtr.base = gdtr.address;
>> @@ -348,7 +355,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>>   	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
>>   	memset(start_vp_input, 0, sizeof(*start_vp_input));
>>   	start_vp_input->partition_id = -1;
>> -	start_vp_input->vp_index = cpu;
>> +	start_vp_input->vp_index = vp_id;
>>   	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
>>   	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 07aadf0e839f..ae62a34bfd1e 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -268,11 +268,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct
>> hv_interrupt_entry *entry);
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>   bool hv_ghcb_negotiate_protocol(void);
>>   void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
>> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
>> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip);
>>   #else
>>   static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>>   static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
>> -static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
>> +static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip) { return 0; }
>>   #endif
>>
>>   #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
>> @@ -329,6 +329,7 @@ static inline void hv_set_non_nested_msr(unsigned int reg,
>> u64 value) { }
>>   static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
>>   #endif /* CONFIG_HYPERV */
>>
>> +int hv_apicid_to_vp_id(u32 apic_id);
>>
>>   #ifdef CONFIG_HYPERV_VTL_MODE
>>   void __init hv_vtl_init_platform(void);
>>
>> base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
>> --
>> 2.43.0
>>
> 

-- 
Thank you,
Roman


