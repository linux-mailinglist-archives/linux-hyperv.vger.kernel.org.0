Return-Path: <linux-hyperv+bounces-6133-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF1DAFBA9B
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 20:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95BED188CFB6
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37199263F5D;
	Mon,  7 Jul 2025 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sEAGC19W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66C18DF62;
	Mon,  7 Jul 2025 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912641; cv=none; b=esglShtRrR7jLh/++aZ/hK1bg/AJuarT2ulaVziYvSgpcODgkaWWnpzu9AXS5U3hOpv8FkGwsOTiyJgyWHQt6LaWrakJXYy0O8gOhnN6SousWZV/tbJMLVuQJfw/GK+fDNa+dZwoKdqTWMvcpDVaQWDrAYsnlYyrPRuaM9QJic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912641; c=relaxed/simple;
	bh=v6ah5GYcAI86rSpZtX2/juVsVn0jnq63bQbdnF2iw00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2jjxf++xk2eiJxjZ9LCzletW0x+CqsPMYMcDicyG9sejjmaJKeGHrFtebV1yyguXCmVIhdJim8/qegkLZ+3SUmAOQOGRD0Ns7Z3w985j9Rd22FWoGINYQtJVXEj/+lZ4uyg1K4Zz87WPM8+BTj+JGpB9Z8jEzdYLD8Wh9s+doY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sEAGC19W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.225.228] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id C7FA7201B1B2;
	Mon,  7 Jul 2025 11:23:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7FA7201B1B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751912639;
	bh=wbc2HG9QUPWt0l63ZWTBhGPjecpI8K9q96+xIUs6eYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sEAGC19WnF2DpvYSQf38laDfMv37wCz2cTJJiu5Iu6HowLVuT4vf7B87ytji/Z7Fn
	 8H9IMDUygflxKPMIA7iUox4zMAWZByAEu5em9fc9Kcb7Wycn7c/ILSZYCZDykirbgf
	 aPR74Z/Joo7rrXDQJiFrDhsBXgONT0Hr4+riF+JM=
Message-ID: <d1e1bf55-af7b-4cd7-927b-886846f0a8dd@linux.microsoft.com>
Date: Mon, 7 Jul 2025 11:23:58 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] x86: hyperv: Expose hv_map_msi_interrupt function
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "romank@linux.microsoft.com" <romank@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "x86@kernel.org" <x86@kernel.org>
References: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1751582677-30930-6-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157AAF735DD432EED00C945D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157AAF735DD432EED00C945D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/2025 8:14 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, July 3, 2025 3:45 PM
>>
>> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>
>> This patch moves a part of currently internal logic into the
>> hv_map_msi_interrupt function and makes it globally available helper
>> function, which will be used to map PCI interrupts in case of root
>> partition.
> 
> Commit message still has "this patch". See suggested wording
> in my comment on v1 of this patch.
> 
Ah, indeed, I missed the change somehow :(

>>
>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/irqdomain.c     | 38 +++++++++++++++++++++++----------
>>  arch/x86/include/asm/mshyperv.h |  2 ++
>>  2 files changed, 29 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
>> index 75b25724b045..eca015563420 100644
>> --- a/arch/x86/hyperv/irqdomain.c
>> +++ b/arch/x86/hyperv/irqdomain.c
>> @@ -172,13 +172,32 @@ static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
>>  	return dev_id;
>>  }
>>
>> -static int hv_map_msi_interrupt(struct pci_dev *dev, int cpu, int vector,
>> -				struct hv_interrupt_entry *entry)
>> +/**
>> + * hv_map_msi_interrupt() - "Map" the MSI IRQ in the hypervisor.
>> + * @data:      Describes the IRQ
>> + * @out_entry: Hypervisor (MSI) interrupt entry (can be NULL)
> 
> Also document the return value?  At least to say that success returns 0,
> while a failure returns a negative errno.
> 
>> + *
>> + * Map the IRQ in the hypervisor by issuing a MAP_DEVICE_INTERRUPT hypercall.
>> + */
>> +int hv_map_msi_interrupt(struct irq_data *data,
>> +			 struct hv_interrupt_entry *out_entry)
>>  {
>> -	union hv_device_id device_id = hv_build_pci_dev_id(dev);
>> +	struct irq_cfg *cfg = irqd_cfg(data);
>> +	struct hv_interrupt_entry dummy;
>> +	union hv_device_id device_id;
>> +	struct msi_desc *msidesc;
>> +	struct pci_dev *dev;
>> +	int cpu;
>>
>> -	return hv_map_interrupt(device_id, false, cpu, vector, entry);
>> +	msidesc = irq_data_get_msi_desc(data);
>> +	dev = msi_desc_to_pci_dev(msidesc);
>> +	device_id = hv_build_pci_dev_id(dev);
>> +	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
>> +
>> +	return hv_map_interrupt(device_id, false, cpu, cfg->vector,
>> +				out_entry ? out_entry : &dummy);
>>  }
>> +EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
>>
>>  static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi_msg *msg)
>>  {
>> @@ -191,11 +210,11 @@ static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi
>>  static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry *old_entry);
>>  static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>  {
>> -	struct hv_interrupt_entry out_entry, *stored_entry;
>> +	struct hv_interrupt_entry *stored_entry;
>>  	struct irq_cfg *cfg = irqd_cfg(data);
>>  	struct msi_desc *msidesc;
>>  	struct pci_dev *dev;
>> -	int cpu, ret;
>> +	int ret;
>>
>>  	msidesc = irq_data_get_msi_desc(data);
>>  	dev = msi_desc_to_pci_dev(msidesc);
>> @@ -205,8 +224,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>  		return;
>>  	}
>>
>> -	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
>> -
>>  	if (data->chip_data) {
>>  		/*
>>  		 * This interrupt is already mapped. Let's unmap first.
>> @@ -233,15 +250,14 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>  		return;
>>  	}
>>
>> -	ret = hv_map_msi_interrupt(dev, cpu, cfg->vector, &out_entry);
>> +	ret = hv_map_msi_interrupt(data, stored_entry);
>>  	if (ret) {
>>  		kfree(stored_entry);
>>  		return;
>>  	}
>>
>> -	*stored_entry = out_entry;
>>  	data->chip_data = stored_entry;
>> -	entry_to_msi_msg(&out_entry, msg);
>> +	entry_to_msi_msg(data->chip_data, msg);
>>
>>  	return;
>>  }
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index e00a8431ef8e..42ea9c68f8c8 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -241,6 +241,8 @@ static inline void hv_apic_init(void) {}
>>
>>  struct irq_domain *hv_create_pci_msi_domain(void);
>>
>> +int hv_map_msi_interrupt(struct irq_data *data,
>> +			 struct hv_interrupt_entry *out_entry);
>>  int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
>>  		struct hv_interrupt_entry *entry);
>>  int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
>> --
>> 2.34.1

