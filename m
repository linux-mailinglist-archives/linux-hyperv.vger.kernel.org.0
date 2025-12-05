Return-Path: <linux-hyperv+bounces-7974-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDACACA935A
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 21:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CA4F30239F8
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 20:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A1A308F36;
	Fri,  5 Dec 2025 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC1MuWCo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57D305065
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Dec 2025 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764964759; cv=none; b=J74sxlYxP2D2NkLcC4CkmwZ/znEyKyeV9McLfUk/2fhyYzq0HduOMmxb70M4Xb5DbZCc3dsThqzLhpWnetjMEoi+Xc230l//ZUM0jdhQe/VPZRncHqA1McwlZKXKPVUSzbHgwfQNudCQfN9KvZDcijRIHPLSfYu71v//S+RTPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764964759; c=relaxed/simple;
	bh=VlgIm88BVp2ZZIQlwGFmvlENlyLdD5L73djmkgNFPac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxVwaDymYWGYL/A975hODJAt1AOPc9PuyQ258mRUVu/FJGd/ZuMByQPL6MlLnjc31M2ntGVKbuZJQWcDGLG6BOJa4dqix1hRkAs/p1FhcnhwPVSGdP/krG7ZfWvwkaHmT/3hZanKORvtmeL58DgKxxwgP4Sst1w5mE/wxLd+13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BC1MuWCo; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c7533dbd87so2251002a34.2
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Dec 2025 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764964756; x=1765569556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0zncQcY2l2ADga64dFU8sEvAZ+HUtgG/giifZeOb1g=;
        b=BC1MuWCohsLP3UBSJ1f/dztlw8B4G+a1Sfeh430NZlh/EKkDO63NQrG+PTUFePdNRv
         MTC4s380CYCzJvYimNfHTJvDsS+TleEPQ2ACoxhi0JInbSMRx1gGRYsLjjapKbPDtjcK
         h2I8ldGq5Bj2KdGXq+INOKv0d2pyGaDBMjilPlyz0v5pBx5fRoL+bFhR368uvyt+wpPW
         NsJLjoOYehMJ0FoAgzqshi3QKkGYTWqbK17uAi6fsLH7aq7R3JG3Vdg2BWDHM82SgabH
         HJPZcuvY6TvC8DNl/fxFWv2YmJFhbNnIs4VRSRAbwgB+eDjPo5EfizB6o33sVPPk399l
         7g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764964756; x=1765569556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0zncQcY2l2ADga64dFU8sEvAZ+HUtgG/giifZeOb1g=;
        b=Y/6BQCBMrvCR4yx7jehY6stBkp99hy3CL/xpaxqsoHrRK+YoHrUZ7kNVZ3hsu3NimW
         m5YE1EsTf1mg1IB8HZ/mD6DsczpR/sDAPprHGS22Gbc92n+F6KnzjaOWgxInW0cANaDC
         ItxsJmTOzulEySx1z73x4BUytzaAo37oq1LVvLxqiZx4BW/ejq9yI5arl5H5YaHBMSQx
         PxDzsiCBGu3+unz9RPsUi39xdYopDCJyc9U9xJIGh+wGlt8MShhxAIcJW3CxCR5ztYyQ
         9twOsZQYLiMkaYSd+phCh2UzOIh6A+V99Bw8vqoIDbLLi9BT5JC1JUpePilD1Ubf+Xz7
         rRzA==
X-Forwarded-Encrypted: i=1; AJvYcCWkBzLzNrEe1VDwlprqLNtrjGrHXNXz8DWivNxomV/xjHVDn7Z0F4s/NpGdCQdJ0iTKOuAcG9rsjU4aLRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9U1gCRzqbvZIWHoOhQJfgPUhs/6ULeZgSHGBJ6Q0DeW2MolK
	PawO0y19TLl1P5O9Z+Yn4AXv3rTrZdBrY5zfA2hqAdioNllNiT3M0ohG
X-Gm-Gg: ASbGnct9aZhSH/9v7ElpGDkn6GA2EdGol7M9Xgyj83VNjtRz8HFPGuEc4ONAhgvSm1e
	GiS4PsuB70CmwMjXtwecscjCZ3/1DgMOiEIVYXgvSKLphnDmc40LncWTKrZ1hVA53JNfKsHZ+fl
	IzVetb0+2aXDeeS3fjxVY/A4F+7hgaxzvr2miqj/BEuQ5ZGznpN6rAWwRjfTtMQrh99zlmhBKTz
	DQrPZwO4HiQSR2f6XYSplKQxOtikdI/q6m5QApvlaP/+JwfNuuEuYjewP653PqrojdCfAi/I8rb
	uTqal00Wu9dVzzzvf4h/SN8gasmYJsD7L5EpybNTwtqCOgBXv0GbkfEt4oIq4Emi13Ibau1fGy8
	CU5t1hsEaY+/HXyCGMcgtaT5eSSAxz4dhg4W9YhhxItVaPti967CPDpFxsA5LpUmcMXn8LbbazR
	Kx2kfTlE2i/JclyaFdF2JpUiTyMAK0gA==
X-Google-Smtp-Source: AGHT+IFbJZdYRx50aUnhh/5cvLH+rPLr8RjiaKfYDwhowF8b9cut0IKywR7uHfWSiPMtK0H3A3oo1w==
X-Received: by 2002:a05:6820:22a7:b0:659:9a49:8eb5 with SMTP id 006d021491bc7-6599a957d27mr195035eaf.57.1764964756286;
        Fri, 05 Dec 2025 11:59:16 -0800 (PST)
Received: from ?IPV6:2603:8081:c640:1::1008? ([2603:8081:c640:1::1008])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50aa34d4fsm4089404fac.5.2025.12.05.11.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 11:59:15 -0800 (PST)
Message-ID: <561a7936-eaeb-4e59-8f79-f8bca9d2390b@gmail.com>
Date: Fri, 5 Dec 2025 13:59:12 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] hyperv: Cleanly shutdown root partition with MSHV
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 anbelski@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 nunodasneves@linux.microsoft.com
References: <20251126215013.11549-1-prapal@linux.microsoft.com>
 <20251126215013.11549-4-prapal@linux.microsoft.com>
 <aS3K898vD31Qi8mE@skinsburskii.localdomain>
Content-Language: en-US
From: Praveen K Paladugu <praveenkpaladugu@gmail.com>
In-Reply-To: <aS3K898vD31Qi8mE@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/1/2025 11:05 AM, Stanislav Kinsburskii wrote:
> On Wed, Nov 26, 2025 at 03:49:53PM -0600, Praveen K Paladugu wrote:
>> When a root partition running on MSHV is powered off, the default
>> behavior is to write ACPI registers to power-off. However, this ACPI
>> write is intercepted by MSHV and will result in a Machine Check
>> Exception(MCE).
>>
>> The root partition eventually panics with a trace similar to:
>>
>>    [   81.306348] reboot: Power down
>>    [   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 0: b2000000c0060001
>>    [   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4ea9
>>    [   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405 SOCKET 0 APIC 0 microcode ffffffff
>>    [   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>>    [   81.314716] mce: [Hardware Error]: Machine check: Processor context corrupt
>>    [   81.314717] Kernel panic - not syncing: Fatal machine check
>>
>> To correctly shutdown a root partition running on MSHV hypervisor, sleep
>> state information must be configured within the hypervsior. Later, the
>> HVCALL_ENTER_SLEEP_STATE hypercall should be invoked as the last step in
>> the shutdown sequence.
>>
>> The previous patch configures the sleep state information and this patch
>> invokes HVCALL_ENTER_SLEEP_STATE hypercall to cleanly shutdown the root
>> partition.
>>
>> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
>> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
>> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
>> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>> ---
>>   arch/x86/include/asm/mshyperv.h |  2 ++
>>   arch/x86/kernel/cpu/mshyperv.c  |  2 ++
>>   drivers/hv/mshv_common.c        | 18 ++++++++++++++++++
>>   3 files changed, 22 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 166053df0484..4c22f3257368 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -183,9 +183,11 @@ void hv_apic_init(void);
>>   void __init hv_init_spinlocks(void);
>>   bool hv_vcpu_is_preempted(int vcpu);
>>   void hv_sleep_notifiers_register(void);
>> +void hv_machine_power_off(void);
>>   #else
>>   static inline void hv_apic_init(void) {}
>>   static inline void hv_sleep_notifiers_register(void) {};
>> +static inline void hv_machine_power_off(void) {};
>>   #endif
>>   
>>   struct irq_domain *hv_create_pci_msi_domain(void);
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index fac9953a72ef..579fb2c64cfd 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -621,6 +621,8 @@ static void __init ms_hyperv_init_platform(void)
>>   #endif
>>   
>>   #if IS_ENABLED(CONFIG_HYPERV)
>> +	if (hv_root_partition())
>> +		machine_ops.power_off = hv_machine_power_off;
>>   #if defined(CONFIG_KEXEC_CORE)
>>   	machine_ops.shutdown = hv_machine_shutdown;
>>   #endif
>> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
>> index f1d4e81107ee..28905e3ed9c0 100644
>> --- a/drivers/hv/mshv_common.c
>> +++ b/drivers/hv/mshv_common.c
>> @@ -217,4 +217,22 @@ void hv_sleep_notifiers_register(void)
>>   		pr_err("%s: cannot register reboot notifier %d\n", __func__,
>>   		       ret);
>>   }
>> +
>> +/*
>> + * Power off the machine by entering S5 sleep state via Hyper-V hypercall.
>> + * This call does not return if successful.
>> + */
>> +void hv_machine_power_off(void)
>> +{
>> +	unsigned long flags;
>> +	struct hv_input_enter_sleep_state *in;
>> +
>> +	local_irq_save(flags);
>> +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	in->sleep_state = HV_SLEEP_STATE_S5;
>> +
>> +	(void)hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
> 
> Should this the error be printed?
> 
> Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

I will add a BUG() here, as the hypercall is not supposed to return.
  >> +	local_irq_restore(flags);
>> +
>> +}
>>   #endif
>> -- 
>> 2.51.0
> 

-- 
Regards,
Praveen K Paladugu


