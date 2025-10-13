Return-Path: <linux-hyperv+bounces-7199-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF74BD494C
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 17:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2986C401681
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D9B3128CF;
	Mon, 13 Oct 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpR+g3ts"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765D30B508
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Oct 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368683; cv=none; b=fjQC5HsQRf3Y+5ZIJ55X9nDW7CMQ/Cs0R3766w6FzTfPiUxdAcvJbXJunLi0E4AmZYyiT7M4IOIs8G1J1OngPOre5pZf6IQp54P3dbGChmd7z371UvvQZ3wufTS7jSPZE0vi4OESZatAYj1thNpzNc6oEILpg8omRd0bIAabgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368683; c=relaxed/simple;
	bh=GKDt9Cy63SIH0ydSh05e90s42lYzKQxYbaamFtHh6x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKtBM57nkQx77fbWrinNCWPOPJZWPdFi33KtMXjHQiqq/5MgY0uiN5GZSwtg1RX+V9/ObpSBfEVafXC1mGWqHxgaAquyFIMzfizicZIvhK4jT79EB1ZqQ5IIvNpTltWoLLsImG93fApuffMyMaIyLDC7lw/vk6i8MDFfb+x24pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpR+g3ts; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-441bc60f35bso445590b6e.2
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Oct 2025 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760368681; x=1760973481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRyxDCkcYD7AvR0IsDzdq/NHUyHn7rIuXPCX9S/Pl6E=;
        b=EpR+g3tsdENA9yvs9plnwyEliJFztQftLgwzISa3eAlu+amrvJWui/jVXf+1lgfH+T
         gXHuBQCZyYg0lWIfkeGmGYDUfcO2KZ9mq9GgCx3FcLL7deIQMcDc1yMn2moXmi2ceEIH
         jZ87iKlfBiXJFSdpNiLQeORq6yvHv05ADrYLAbSFQpSBZi61PoD0fvvAkxxu+56PSxhY
         YdbaDM2Xztp08rfQFmHTaz27cnE+aXO1Q4Avv5Nxp3ql+8tI0T9QI1SCysV6dnDxWzjd
         CzHXBT/xcs8kZ1FvuzKvM+f5X/08IJ1elexW2ACJweXcEbHv1DS+K00NHrtigGrJ4Kkw
         h8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368681; x=1760973481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRyxDCkcYD7AvR0IsDzdq/NHUyHn7rIuXPCX9S/Pl6E=;
        b=P3iOk46MMS7ePX1VaWy7oX/dAVl5TNftyMdb4QeFFELvIqWEWp8UT0DpJIb5VNk+Ep
         giAE+FhcQ1MulGEI3IEtuxoWRXuZL3Tx5U2Hi2IG57jx1QkhWHPZlZHdzBGUaD67R5B3
         iyqXHPr4JO2q7WTixxmDjYoVcDHG96EAnZe5YlRk170ABmPMzCfhP7/TCIoyUlfHZGKC
         3ay90PBP9OmYvTeXVWHo+kwebJbmvZBTrYsVJ9yiC1K5L044XptsbgD9UXm8Yz9qt61P
         PbkFEhWwPh9BIO2qHcUmO+QNf4JXHJL7mKveGWnivwrdS213uQFUoAXI8FnalW5jOBOl
         ouQg==
X-Forwarded-Encrypted: i=1; AJvYcCXtdiMVxeb6aCArRVGyATVxEzM1+JKRcs9ZybmqVKeAJ2Nps49cN6m1Hf54saEFYdsC/gJ4IgqqMnFSdPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4e61kJf+1xwZHisIcNCZ1I3P/Fc6tbAzeYiiu2DAl+Iw9Fz5j
	lCcW3czLqtkHoUmclCaKEjuPIzwChpsy0m9AYlBL6l1fmiARVNt3vvu6
X-Gm-Gg: ASbGncuYIh2k+X/3MRNZaADxpYHJMV4TBhqp6hPnIK6WavZ3WObWSqKwOEhPY0860Ff
	bNVDkDogRXeVRTSftwQFQvCW582VaadbJ3aQ44VGTsIqLIgn9X0v8BBxSS1VFS1j9crnSZDNCYR
	sSXJzeeOTYJ1nfpUMKfR8Imec9X85numdql7+HGdnh4uomxLn0Uq56ehKrKohlg2P2yYMvZ+pcQ
	p1PYBXMXGmQuU4ZXMQsghF62AY4h5mjRYdH5TudaekpeCNsWLVfWBLwuTa65L97MxW1kHsN87Ue
	jEpFqcqBcHv5bJop4JQZfaHE+PA3mYe76valAO/sXqK1+YxRJuQnD81eKIxpwQsbKngYH9plM1q
	zRvCYyTS7CwGn9L0KV8MQbIRSLyyQkSyzFU+RDJipU4o2E0I6A35UVwRWuNTY
X-Google-Smtp-Source: AGHT+IEkrznDh4+3D54wepyKCf/cc4wUix4O6ndVbxKTC1xPd3qKc/8TLhlu/0Z+mNUdZL8/GbbEig==
X-Received: by 2002:a05:6808:1903:b0:438:8c9:5f4 with SMTP id 5614622812f47-4417b2f4fa7mr9071701b6e.19.1760368681028;
        Mon, 13 Oct 2025 08:18:01 -0700 (PDT)
Received: from ?IPV6:2603:8081:c640:1::1010? ([2603:8081:c640:1::1010])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441987494ccsm2530511b6e.0.2025.10.13.08.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:18:00 -0700 (PDT)
Message-ID: <0f4b8ddc-489b-49c4-b1f6-44fd6492c310@gmail.com>
Date: Mon, 13 Oct 2025 10:17:58 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hyperv: Enable clean shutdown for root partition with
 MSHV
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
 Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 anbelski@linux.microsoft.com
References: <20251009160501.6356-1-prapal@linux.microsoft.com>
 <20251009160501.6356-3-prapal@linux.microsoft.com>
 <f0291b64-693c-49f4-bc71-d260a670e636@linux.microsoft.com>
Content-Language: en-US
From: Praveen K Paladugu <praveenkpaladugu@gmail.com>
In-Reply-To: <f0291b64-693c-49f4-bc71-d260a670e636@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/2025 12:30 PM, Easwar Hariharan wrote:
> On 10/9/2025 8:58 AM, Praveen K Paladugu wrote:
>> This commit enables the root partition to perform a clean shutdown when
>> running with MSHV hypervisor.
> 
> No "This commit..." please
> 
>>
>> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
>> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
>> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_init.c      |   7 ++
>>   drivers/hv/hv_common.c         | 118 +++++++++++++++++++++++++++++++++
>>   include/asm-generic/mshyperv.h |   1 +
>>   3 files changed, 126 insertions(+)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index afdbda2dd7b7..57bd96671ead 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -510,6 +510,13 @@ void __init hyperv_init(void)
>>   		memunmap(src);
>>   
>>   		hv_remap_tsc_clocksource();
>> +		/*
>> +		 * The notifier registration might fail at various hops.
>> +		 * Corresponding error messages will land in dmesg. There is
>> +		 * otherwise nothing that can be specifically done to handle
>> +		 * failures here.
>> +		 */
>> +		(void)hv_sleep_notifiers_register();
>>   	} else {
>>   		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>>   		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index e109a620c83f..c5165deb5278 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -837,3 +837,121 @@ const char *hv_result_to_string(u64 status)
>>   	return "Unknown";
>>   }
>>   EXPORT_SYMBOL_GPL(hv_result_to_string);
>> +
>> +/*
>> + * Corresponding sleep states have to be initialized, in order for a subsequent
>> + * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
>> + * ACPI 6.4 chapter 7.4.2 is relevant, while S1, S2 and S3 can be supported.
>> + *
>> + * ACPI should be initialized and should support S5 sleep state when this method
>> + * is called, so that, it can extract correct PM values and pass them to hv.
> 
> Nit: No need for this   ^ comma, i.e. "...when this method is called, so that it can..."
> 
>> + */
>> +static int hv_initialize_sleep_states(void)
>> +{
>> +	u64 status;
>> +	unsigned long flags;
>> +	struct hv_input_set_system_property *in;
>> +	acpi_status acpi_status;
>> +	u8 sleep_type_a, sleep_type_b;
>> +
>> +	if (!acpi_sleep_state_supported(ACPI_STATE_S5)) {
>> +		pr_err("%s: S5 sleep state not supported.\n", __func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	acpi_status = acpi_get_sleep_type_data(ACPI_STATE_S5,
>> +						&sleep_type_a, &sleep_type_b);
>> +	if (ACPI_FAILURE(acpi_status))
>> +		return -ENODEV;
>> +
>> +	local_irq_save(flags);
>> +	in = (struct hv_input_set_system_property *)(*this_cpu_ptr(
>> +		hyperv_pcpu_input_arg));
> 
> Other users don't have these casts, why is it necessary here?
> I didn't really need these casts. I will drop them in the next version.
>> +
>> +	in->property_id = HV_SYSTEM_PROPERTY_SLEEP_STATE;
>> +	in->set_sleep_state_info.sleep_state = HV_SLEEP_STATE_S5;
>> +	in->set_sleep_state_info.pm1a_slp_typ = sleep_type_a;
>> +	in->set_sleep_state_info.pm1b_slp_typ = sleep_type_b;
>> +
>> +	status = hv_do_hypercall(HVCALL_SET_SYSTEM_PROPERTY, in, NULL);
>> +	local_irq_restore(flags);
>> +
>> +	if (!hv_result_success(status)) {
>> +		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
>> +		return hv_result_to_errno(status);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hv_call_enter_sleep_state(u32 sleep_state)
>> +{
>> +	u64 status;
>> +	int ret;
>> +	unsigned long flags;
>> +	struct hv_input_enter_sleep_state *in;
>> +
>> +	ret = hv_initialize_sleep_states();
>> +	if (ret)
>> +		return ret;
>> +
>> +	local_irq_save(flags);
>> +	in = (struct hv_input_enter_sleep_state *)
>> +			(*this_cpu_ptr(hyperv_pcpu_input_arg));
>> +	in->sleep_state = (enum hv_sleep_state)sleep_state;
>> +
> 
> More casts...
> 
>> +	status = hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
>> +	local_irq_restore(flags);
>> +
>> +	if (!hv_result_success(status)) {
>> +		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
>> +		return hv_result_to_errno(status);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hv_reboot_notifier_handler(struct notifier_block *this,
>> +				      unsigned long code, void *another)
>> +{
>> +	int ret = 0;
>> +
>> +	if (SYS_HALT == code || SYS_POWER_OFF == code)
> 
> Usually the variable is on the left of the comparison with the constant
> 
>> +		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
>> +
>> +	return ret ? NOTIFY_DONE : NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block hv_reboot_notifier = {
>> +	.notifier_call  = hv_reboot_notifier_handler,
>> +};
>> +
>> +static int hv_acpi_sleep_handler(u8 sleep_state, u32 pm1a_cnt, u32 pm1b_cnt)
>> +{
>> +	int ret = 0;
>> +
>> +	if (sleep_state == ACPI_STATE_S5)
>> +		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
>> +
>> +	return ret == 0 ? 1 : -1;
>> +}
>> +
>> +static int hv_acpi_extended_sleep_handler(u8 sleep_state, u32 val_a, u32 val_b)
>> +{
>> +	return hv_acpi_sleep_handler(sleep_state, val_a, val_b);
>> +}
>> +
>> +int hv_sleep_notifiers_register(void)
>> +{
>> +	int ret;
>> +
>> +	acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
>> +	acpi_os_set_prepare_extended_sleep(&hv_acpi_extended_sleep_handler);
>> +
>> +	ret = register_reboot_notifier(&hv_reboot_notifier);
>> +	if (ret)
>> +		pr_err("%s: cannot register reboot notifier %d\n",
>> +			__func__, ret);
>> +
>> +	return ret;
>> +}
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 64ba6bc807d9..903d089aba82 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -339,6 +339,7 @@ u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
>>   void hyperv_cleanup(void);
>>   bool hv_query_ext_cap(u64 cap_query);
>>   void hv_setup_dma_ops(struct device *dev, bool coherent);
>> +int hv_sleep_notifiers_register(void);

> 
> Does this still work when CONFIG_HYPERV = n, i.e. do we need a stub below? Also, this looks
> like it's only implemented for x86, so perhaps this declaration should be in arch/x86/include/asm/mshyperv.h
> instead of asm-generic?
As this sleep state data is configured using hypercalls, this code
does not work with CONFIG_HYPERV=n. I will investigate the correct 
header to use here and report back.

> 
>>   #else /* CONFIG_HYPERV */
>>   static inline void hv_identify_partition_type(void) {}
>>   static inline bool hv_is_hyperv_initialized(void) { return false; }
> 
> 
Thanks for the feedback. I will address all the nits along with above 
comments in next update.
-- 
Regards,
Praveen K Paladugu

