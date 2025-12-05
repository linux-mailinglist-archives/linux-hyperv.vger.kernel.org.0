Return-Path: <linux-hyperv+bounces-7973-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1260CA934E
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 21:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2ABF303FE71
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 20:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1F32F60BC;
	Fri,  5 Dec 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUerhlc6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6C2F1FD2
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Dec 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764964703; cv=none; b=XM0v2W87jJ8th0xz7wBmRD/jIum3eOOq8z3w8QBC8tEd7fA2FVBxKz1ZPI73f5mvxCcba8vYB9UFcqL9c7n4dOxPGhXj8IjBwciKx65HH+0wHx+Y+wE2X/4ibH6bG/wg6bO3dRI7yCGeLUXW5ZIs8qF+eRsCpvB+v7dXxjx6UvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764964703; c=relaxed/simple;
	bh=zCClyS/zTwt+LIaT7RjNmzpDj9vrZ1FlVSo4HJHbQgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ji3VMvEaYH9IxP1C3Wh9hNfCAMMk8stlHBHApmaThOjBsINI6PVGDwwmc7qv9QqBjH7EbpBTZftCXYhlywjhmptDXhGGpCugUjAhMZlzLU09ItCmMQCSFkG/zJr+rqCC8qH+nx+bcZ6V9mFKSlsaUTSuixFfZO0GxlFuA7SQvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUerhlc6; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45090ef26c6so805789b6e.2
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Dec 2025 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764964700; x=1765569500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pHMOLZdp8xm1TVVQolwhRdpGkLjP12bkIhAp/z+i7c=;
        b=eUerhlc62Pgbj9GtkaMFMTcVQA92e0am7CdmgbdJLLW0bM6fE4CcpNgkPrADL+senK
         aYXzd1yicDpSr0Moq9yVIbrxvkcqLXxQDogdIaC88iGSrFd7TvRVQoc/M6IiGXIi6fZL
         nTZtW8wEKYf23KTfvKjaCIixaXZWXL77nFPOW58vuxk1KewCOnSUn2pxFjVPb0uyj4gz
         PsEOZ0b8WeqqpTSxu6eYxziz7v/dwXDEw8cIeBlu7ge5N/ZVmPAjamLoWZpzfMgVCo1o
         wZSmckE9ShzFJkaI6StElFgE6DtvY/DKVz5fgOVkNShor8u3WiPi/u71jupD3yxzmwmp
         51fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764964700; x=1765569500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pHMOLZdp8xm1TVVQolwhRdpGkLjP12bkIhAp/z+i7c=;
        b=ur5NME0/s3Jwx0eq8UxFq4X+B53YAd83JGdIlcPPCn4DkIyVVROO+44aPm2jQQlDQY
         /sEJGhhaiweay1VnyMaVZqykCOLkYxwY9WgBFhiv5Y3vZHZ6vhiVsTjQzHb6eDqvl5+B
         qa0wUNKxzWsg8lp/EVSde4eOBahMU4AYeuRozoojRZRUSzDwbmSgsgTzQ9woLFuNIfsW
         Wz2KGNBF8NOeyFqfabAQ2GSLOMYbmX7G4EpMgOkfxshvsUJRPW6UF5Veu5K5ls/4DZON
         XQHyQBxb7iFAObL9Kgipzktrw4M9hWBQa3LHImiEBpV/6kLGsUmYMCV20WveHBJqo0zo
         FzCw==
X-Forwarded-Encrypted: i=1; AJvYcCUJOsPqE6BdHZMBcsdAApV3diiYgQDUZS6GpzSH+c7lXtX7yznpxuMnUTXOkM1WjlOtgnwcwDlrsidQ6OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTGm8YbmWpARA1JVkkOf1MeFLKEVzRDQcSmAh5un9P4mXPUkDH
	fvlf9jPZ1id9Y9RtLdsZYZBLla9lvzg0YKDGdEz9TR9LxQNE+UhTPmyE
X-Gm-Gg: ASbGncuYgBlmp8kqiXr7nPNwUoJbQnaToxYFvhMKGiYInPjPQDo3PY2YEiahWJrL2LA
	Qv/PoNaCG7KoJfGmvW9IUVG1L+TDPa1UmE/sWxfaYqld0GEhjyHuw6H0L42OnU6C2YLdgs0zTXG
	1ZgXRX7H6g2zeMsPYQbS4FyNUN7FXHlXudgu1oOA/uNrbjpJiy+wCywFLjJWO4eT6H0aRjBu94y
	WYWcOecXG3Na/CH80nCD6laWCFGGEU1H7BBS32g5d5q+jCdxc4pWOzby54K/CVvuhhnRuvVRoPE
	iekDbl3Ln1vWE+cK22hLAfbvc6eJd526J9/rq5R2YVYoad+yO7H3iFApM/Be2BCKLq1a8AQV8qv
	F5VmI/+gGG68dFZ47GbcidI6P2319Vmw9IbhchOB+0o/nz1kZwBSMhy4w8HuWcUiXcwd3O8cgCt
	fdHWveqda61J1aRqSkX4ml7NJBup42Eu8ZeNgHsCao
X-Google-Smtp-Source: AGHT+IEi8ig4wF1Qft2sJYSe9kHnTJZvGeJBWMRlzvUt2ISEanjqRq6I/sCSsvNgs2Q5k1Kj7+lYig==
X-Received: by 2002:a05:6808:1915:b0:450:3062:30d8 with SMTP id 5614622812f47-4539e08f472mr72345b6e.41.1764964699649;
        Fri, 05 Dec 2025 11:58:19 -0800 (PST)
Received: from ?IPV6:2603:8081:c640:1::1008? ([2603:8081:c640:1::1008])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f8d98e1sm2726461b6e.7.2025.12.05.11.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 11:58:19 -0800 (PST)
Message-ID: <e5ebd6f3-0422-485c-87b7-fd9c6e271c18@gmail.com>
Date: Fri, 5 Dec 2025 13:58:15 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Add support for clean shutdown with MSHV
To: Michael Kelley <mhklinux@outlook.com>,
 Praveen K Paladugu <prapal@linux.microsoft.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "arnd@arndb.de" <arnd@arndb.de>
Cc: "anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>,
 "easwar.hariharan@linux.microsoft.com"
 <easwar.hariharan@linux.microsoft.com>,
 "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
References: <20251126215013.11549-1-prapal@linux.microsoft.com>
 <SN6PR02MB415792702B78B9855485DCE5D4DDA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Praveen K Paladugu <praveenkpaladugu@gmail.com>
In-Reply-To: <SN6PR02MB415792702B78B9855485DCE5D4DDA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/29/2025 12:48 AM, Michael Kelley wrote:
> From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Wednesday, November 26, 2025 1:50 PM
>>
>> Add support for clean shutdown of the root partition when running on
>> MSHV Hypervisor.
>>
>> v6:
>>   - Fixed build errors, by adding CONFIG_X86_64 guard
> 
> Adding the CONFIG_X86_64 guard seems like the right solution, and it does
> make the build errors go away. However note that as coded in drivers/hv/Makefile,
>   the code under the new guard won't be built at all unless CONFIG_MSHV_ROOT
> is set (ignoring the VTL case for now), which can only happen in the X86_64 or
> ARM64 cases. So it was nagging at me as to why the guard is needed for an
> x86 32-bit build failure reported by the kernel test robot.
> 
> It turns out there's an underlying bug in drivers/hv/Makefile causing
> mshv_common.o to be built in cases when it shouldn't be, such as the x86
> 32-bit case. The build failures reported by the kernel test robot were on these
> cases when it shouldn't be built in the first place. The bug is in this Makefile line:
> 
> ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
> 
> which should be
> 
> ifneq ($(CONFIG_MSHV_ROOT)$(CONFIG_MSHV_VTL),)
> 
> The buggy version has a spurious "space" character before the start of
> $(CONFIG_MSHV_VTL) such that the result is always "not equal" and
> mshv_common.o is always built.
> 
> If the Makefile is fixed, then the X86_64 guards you added in
> mshv_common.c are not needed. Furthermore, the stubs for
> hv_sleep_notifiers_register() and hv_machine_power_off() in
> arch/x86/include/asm/mshyperv.h for the !CONFIG_X86_64 case aren't
> needed. And the declarations for hv_sleep_notifiers_register() and
> hv_machine_power_off() can be moved out from under the #ifdef
> CONFIG_X86_64. The bottom line is that nothing in this patch set needs
> to be guarded by CONFIG_X86_64.
> 
Thanks for this investigation Michael. With these changes, I am not able
to reproduce any build failures anymore. I will push these changes in v7.

Praveen

> Here's a quick diff of what I changed on top of your v6 patch set
> (including the fix to drivers/hv/Makefile). I tested the build process
> on both x86/64 and arm64, with and without CONFIG_MSHV_ROOT
> selected.
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 4c22f3257368..01d192e70211 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -178,16 +178,15 @@ int hyperv_fill_flush_guest_mapping_list(
>                  struct hv_guest_mapping_flush_list *flush,
>                  u64 start_gfn, u64 end_gfn);
> 
> +void hv_sleep_notifiers_register(void);
> +void hv_machine_power_off(void);
> +
>   #ifdef CONFIG_X86_64
>   void hv_apic_init(void);
>   void __init hv_init_spinlocks(void);
>   bool hv_vcpu_is_preempted(int vcpu);
> -void hv_sleep_notifiers_register(void);
> -void hv_machine_power_off(void);
>   #else
>   static inline void hv_apic_init(void) {}
> -static inline void hv_sleep_notifiers_register(void) {};
> -static inline void hv_machine_power_off(void) {};
>   #endif
> 
>   struct irq_domain *hv_create_pci_msi_domain(void);
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 58b8d07639f3..6d929fb0e13d 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -20,6 +20,6 @@ mshv_vtl-y := mshv_vtl_main.o
>   # Code that must be built-in
>   obj-$(CONFIG_HYPERV) += hv_common.o
>   obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
> -ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
> +ifneq ($(CONFIG_MSHV_ROOT)$(CONFIG_MSHV_VTL),)
>          obj-y += mshv_common.o
>   endif
> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> index 28905e3ed9c0..73505cbdc324 100644
> --- a/drivers/hv/mshv_common.c
> +++ b/drivers/hv/mshv_common.c
> @@ -142,7 +142,6 @@ int hv_call_get_partition_property(u64 partition_id,
>   }
>   EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
> 
> -#ifdef CONFIG_X86_64
>   /*
>    * Corresponding sleep states have to be initialized in order for a subsequent
>    * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
> @@ -235,4 +234,3 @@ void hv_machine_power_off(void)
>          local_irq_restore(flags);
> 
>   }
> -#endif
> 
> The Makefile fix needs to be a separate patch.
> 
> I think I got all this correct, but please double-check my work! :-)
> 
> Michael
> 
>>   - Moved machine_ops hook definition to ms_hyperv_init_platform
>>   - Addressed review comments in v5
>>
>> v5:
>>   - Fixed build errors
>>   - Padded struct hv_input_set_system_property for alignment
>>   - Dropped CONFIG_ACPI stub
>>
>> v4:
>>   - Adopted machine_ops to order invoking HV_ENTER_SLEEP_STATE as the
>>     last step in shutdown sequence.
>>   - This ensures rest of the cleanups are done before powering off
>>
>> v3:
>>   - Dropped acpi_sleep handlers as they are not used on mshv
>>   - Applied ordering for hv_reboot_notifier
>>   - Fixed build issues on i386, arm64 architectures
>>
>> v2:
>>    - Addressed review comments from v1.
>>    - Moved all sleep state handling methods under CONFIG_ACPI stub
>>    - - This fixes build issues on non-x86 architectures.
>>
>>
>> Praveen K Paladugu (3):
>>    hyperv: Add definitions for MSHV sleep state configuration
>>    hyperv: Use reboot notifier to configure sleep state
>>    hyperv: Cleanly shutdown root partition with MSHV
>>
>>   arch/x86/hyperv/hv_init.c       |  1 +
>>   arch/x86/include/asm/mshyperv.h |  4 ++
>>   arch/x86/kernel/cpu/mshyperv.c  |  2 +
>>   drivers/hv/mshv_common.c        | 98 +++++++++++++++++++++++++++++++++
>>   include/hyperv/hvgdk_mini.h     |  4 +-
>>   include/hyperv/hvhdk_mini.h     | 40 ++++++++++++++
>>   6 files changed, 148 insertions(+), 1 deletion(-)
>>
>> --
>> 2.51.0
>>
> 
> 

-- 
Regards,
Praveen K Paladugu


