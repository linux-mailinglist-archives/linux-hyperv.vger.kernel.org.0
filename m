Return-Path: <linux-hyperv+bounces-5199-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B964A9F7A3
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 19:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96046189863A
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881D625D54B;
	Mon, 28 Apr 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GuhnONED"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F36184E;
	Mon, 28 Apr 2025 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745862249; cv=none; b=JaCSBUjXehemFkv2ZVtM/mLubaI/2A9vH4fJY/eGhFDQUiJeOL1dbb9WynopQngJ57LpKkZA8fvBwf6DaUwaooM7w10vvxVXER+K/Vlqx6c6xvL2QBQFGmFOJKcXwqWWkihp6woXy0QSdAAK0B0gT+F3q0jrqmk1KWXvPHr8gXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745862249; c=relaxed/simple;
	bh=BX5ANofv8Tzy8FiYDhkTq16cUhjuxc9r8ycpbZRSeA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7vNC5LKcZ2w4GfKyNgn6oYCH+uWB3P8L7A6mJyXkY6jL3Wp/zTnLoVkIoKU3nt68Kgyxl/b+g2VMIItQa7d7SGqmxD0YuzgjChPd/rUeLo8xtqp/2VCVhyKU3m7Vf3wH1evvOr8elKoIQGGOaWuUkV7j+QzRCEHqUzM//DTGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GuhnONED; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B508211AD0B;
	Mon, 28 Apr 2025 10:44:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B508211AD0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745862247;
	bh=0gnmKWUnbMHCfcNqstlfcnIlrj4YYehGlgG0xE+sm/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GuhnONEDcTekGfT1tFgdiCfAbP7cXrNmpzBCGdechut07pUmUvvgl5e6L7PTKRGob
	 syUskQMIhXYqeGYfzkyWvFcwHPK7rIT51g52So47GFP4C+JIljwoI3dUkQJ78Ce61o
	 0Uf0JhYtOznRR9NNINZDkNIuzya1ceqPpvGObhgI=
Message-ID: <b5710b79-5939-422c-9b91-4e5738ce2c03@linux.microsoft.com>
Date: Mon, 28 Apr 2025 10:44:07 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v2] x86/hyperv: Fix APIC ID and VP index
 confusion in hv_snp_boot_ap()
To: Michael Kelley <mhklinux@outlook.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
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
References: <20250425213512.1837061-1-romank@linux.microsoft.com>
 <SN6PR02MB415714E8EAF22D01DEF6F7C4D4872@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415714E8EAF22D01DEF6F7C4D4872@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/26/2025 6:26 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, April 25, 2025 2:35 PM

[...]

>> +	if (!hv_result_success(status)) {
>> +		pr_err("failed to get vp id from apic id %d, status %#llx\n",
> 
> Nit:  The error message should say "vp index" instead of "vp id"
> 

Missed that, thanks! Will send a fix.

[...]

>> +	/*
>> +	 * Find the Linux CPU number for addressing the per-CPU data, and it
>> +	 * might not be the same as APIC ID.
>> +	 *
>> +	 * "APIC ID != VP index" is rare/pathological and might be observed with
>> +	 * more than 16 non power-of-two number of virtual processors. This is not
>> +	 * something backed up by the TLFS, just a heuristic.
> 
> I don't understand these two sentences. Since the TLFS doesn't tell us anything
> about how Hyper-V assigns the VP index value, any comparison with the APIC
> ID seems invalid. Even as a heuristic, the comparison could give a false positive
> or a false negative, so it's hard to take any definite action based on the comparison.

I coded against the observed behavior and used the phrasing that
wouldn't be too restricting. Upon taking another look, that all comes
off rather silly, should not have done that. The O(n) complexity
here isn't the end of the world but wanted to do better.

> 
> Also, the condition for APIC IDs not being dense is having multiple NUMA nodes,
> and the number of vCPUs in a NUMA node is not a power of 2. The number "16"
> specifically doesn't come into play except that more than 16 vCPUs might (or might
> not) indicate multiple NUMA nodes. And I wouldn't characterize these conditions
> as "rare/pathological" -- there are quite a few VM sizes in Azure that meet these
> conditions, and they are perfectly good and normal VMs.
> 

Agreed, too many words on my side with not so much logic. Right,
the APIC <=> VP ID mapping is calculated htrough NUMA nodes, yet the
TLFS doesn't decree how so shouldn't rely on the observed behavior.
Speaking of using "rare/pathological" you're right of the VMs. I'll
remove that whole paragraph.

>> +          * We'd like to move this
>> +	 * code over to the place the CPU number is known rather than has to be
>> +	 * computed via the linear scan like is done here.
> 
> Again, I don't understand the statement about "moving this code over".  Could
> you clarify?
> 

Adding another callback, or as you're suggesting below extending the
existing one.

[...]

> Unfortunately, I think we're stuck doing the linear search for the matching
> apic_id in order to get the "cpu" value. However, in the bigger picture,
> I would note that the caller of hv_snp_boot_ap() is do_boot_cpu(). And
> do_boot_cpu() has the "cpu" value along with the "apic_id" value.
> Unfortunately, it only passes the apic_id as a parameter. You could
> consider changing the call signature to add the "cpu" as a parameter.
> That change itself is a bit messy because it touches several other places,
> but it would certainly clean up this code and the similar VTL code.
> 

I'll remove my unfortunate and silly if statement for this patch, and
will propose updating the wakeup AP callback parameters list in another
patch. Thinking maybe instead of adding another (third) parameter, could
have a structure where all the parameters would live.

>> +	}
>> +	if (cpu >= nr_cpu_ids)
>> +		return -EINVAL;
>> +
>>   	native_store_gdt(&gdtr);
>>
>>   	vmsa->gdtr.base = gdtr.address;
>> @@ -348,7 +376,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>>   	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
>>   	memset(start_vp_input, 0, sizeof(*start_vp_input));
>>   	start_vp_input->partition_id = -1;
>> -	start_vp_input->vp_index = cpu;
>> +	start_vp_input->vp_index = vp_index;
>>   	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
>>   	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 07aadf0e839f..323132f5e2f0 100644
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
>> @@ -306,6 +306,7 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
>>   {
>>   	return __rdmsr(reg);
>>   }
>> +int hv_apicid_to_vp_index(u32 apic_id);
>>
>>   #else /* CONFIG_HYPERV */
>>   static inline void hyperv_init(void) {}
>> @@ -327,6 +328,7 @@ static inline void hv_set_msr(unsigned int reg, u64 value) { }
>>   static inline u64 hv_get_msr(unsigned int reg) { return 0; }
>>   static inline void hv_set_non_nested_msr(unsigned int reg, u64 value) { }
>>   static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
>> +static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
>>   #endif /* CONFIG_HYPERV */
>>
>>
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index abf0bd76e370..6f5976aca3e8 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>> @@ -475,7 +475,7 @@ union hv_vp_assist_msr_contents {	 /*
>> HV_REGISTER_VP_ASSIST_PAGE */
>>   #define HVCALL_CREATE_PORT				0x0095
>>   #define HVCALL_CONNECT_PORT				0x0096
>>   #define HVCALL_START_VP					0x0099
>> -#define HVCALL_GET_VP_ID_FROM_APIC_ID			0x009a
>> +#define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
>>   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>>   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>>   #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
>>
>> base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
>> --
>> 2.43.0
>>
> 

-- 
Thank you,
Roman


