Return-Path: <linux-hyperv+bounces-8323-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD575D27921
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6564130FFB0D
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61862868B0;
	Thu, 15 Jan 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RqgRy/Xw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB822E3E7;
	Thu, 15 Jan 2026 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501016; cv=none; b=d+G3O36ACePRY4J/N7TmANZ3VozxC9JKMCsAzyJwGK3pUHpubi9LBWrQJlXcCpKvqo41AUofG2yKl+GrGUEsuFn9lsreLMbnd9lOp5CrFyKLcKLoMWi5aG1goJfrjHCqSb7QedBpMfeWJKcF05th4K2ViFgXz07d4tIXMLoJr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501016; c=relaxed/simple;
	bh=8LbyNAp+QXnoXcURzEC0eQk8mDnpCRdyGVkIj9hyjWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPhS+y+vdeAn31OY77+lSmwbtrogtTJb3CO/8sF/8Y2vL0ZaLA3Vskzs0AYvCVqdMDMN9dYMq0ZZuMDqGLaexzSTGkhXFm62sM/AexWTtMKS2FxcWOC3ylr/d+3Kw0ZACZ1ErATtmM/o7WDtO066e4yGBNA0w0tT4HbhlxaWASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RqgRy/Xw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 62C1720B7165;
	Thu, 15 Jan 2026 10:16:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 62C1720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768501014;
	bh=ajMenFRq0ihdh1w2Yz8klYVCSp7DKA7cZuh3c980Ln0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RqgRy/XwxbbVo4cDeyctRd8ozOPVB7rvPPWeruIlzY5/aQFubpLkY7dXvizQR6mk3
	 rLWfgmXeDyJgJ6FknsVkILgAHgC7KwkLnvdea7967Tm74M+S3F0eKLzLyDSPfomxrs
	 GgYY8NTvoC8jLFw8gGHE2JYjyJlOThFLnfFAtuMM=
Message-ID: <e4a513dc-57e9-288d-6929-c1ab1a084388@linux.microsoft.com>
Date: Thu, 15 Jan 2026 10:16:53 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Content-Language: en-US
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 longli@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
References: <20260102220208.862818-1-mrathor@linux.microsoft.com>
 <20260115072509.GF3557088@liuwe-devbox-debian-v2.local>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260115072509.GF3557088@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 23:25, Wei Liu wrote:
> On Fri, Jan 02, 2026 at 02:02:08PM -0800, Mukesh Rathor wrote:
>> MSVC compiler, used to compile the Microsoft Hyper-V hypervisor currently,
>> has an assert intrinsic that uses interrupt vector 0x29 to create an
>> exception. This will cause hypervisor to then crash and collect core. As
>> such, if this interrupt number is assigned to a device by linux and the
>> device generates it, hypervisor will crash. There are two other such
>> vectors hard coded in the hypervisor, 0x2C and 0x2D for debug purposes.
>> Fortunately, the three vectors are part of the kernel driver space and
>> that makes it feasible to reserve them early so they are not assigned
>> later.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>
>> v1: Add ifndef CONFIG_X86_FRED (thanks hpa)
>>
>>   arch/x86/kernel/cpu/mshyperv.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 579fb2c64cfd..8ef4ca6733ac 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -478,6 +478,27 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>   }
>>   EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>>   
>> +#ifndef CONFIG_X86_FRED
> 
> I briefly looked up FRED and checked the code. I understand that once it
> is enabled, Linux kernel doesn't setup the IDT anymore (code in
> arch/x86/kernel/traps.c).
> 
> My question is, do we need to do anything when FRED is enabled?

Yeah, at first glance my thought was it probably has greater
implications (in terms of double checking exceptions), and so
when time allows do deeper investigation and perhaps run it by
the hypervisor team to see if there is any other work we need to
do.

Thanks,
-Mukesh


> Wei
> 
>> +/*
>> + * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
>> + * will crash or hang or break into debugger.
>> + */
>> +static void hv_reserve_irq_vectors(void)
>> +{
>> +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
>> +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
>> +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
>> +
>> +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
>> +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
>> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
>> +		BUG();
>> +
>> +	pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR,
>> +		HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
>> +}
>> +#endif          /* CONFIG_X86_FRED */
>> +
>>   static void __init ms_hyperv_init_platform(void)
>>   {
>>   	int hv_max_functions_eax, eax;
>> @@ -510,6 +531,11 @@ static void __init ms_hyperv_init_platform(void)
>>   
>>   	hv_identify_partition_type();
>>   
>> +#ifndef CONFIG_X86_FRED
>> +	if (hv_root_partition())
>> +		hv_reserve_irq_vectors();
>> +#endif  /* CONFIG_X86_FRED */
>> +
>>   	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
>>   		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
>>   
>> -- 
>> 2.51.2.vfs.0.1
>>


