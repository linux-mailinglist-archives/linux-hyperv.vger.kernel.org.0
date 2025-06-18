Return-Path: <linux-hyperv+bounces-5959-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A687ADF863
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 23:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03A01BC37BE
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 21:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907425F796;
	Wed, 18 Jun 2025 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RBT05SRw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D721CC7F;
	Wed, 18 Jun 2025 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280916; cv=none; b=Q7gAJY/zLJIFB/Sc25BgsGSghzb7z/SA22ZFaoxkVesDxxrcNTXDNLoHW5Po0boehHPR7znFs++gM0gdw4CndnYLjSbXrCXFmkiQR5HZ0y30w72H3DLOX5P+LrvsJijharCNrk0sDlod+jT3s3yrr2G2+kOIFv/FTVi537QHMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280916; c=relaxed/simple;
	bh=Mb5osL0V4L255gct7YLi5fk+2Xuu9f9Z2b7W06Gbph8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMM83tTyxloRqSf047s6cHPs4+XNOkEqG2/uCC3q97NxaDKyLLPGAqAx04tqiKP/O0kUpg+ETvSmgIOl994AQiOF9YJu5ifP/yMYMpY7qZR15ddGlrAKeGjQrXh0IxRsx9k492ODECJsn0mlbSM35K7XgeSCrhR9Wjo/G96A/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RBT05SRw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.233.194] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id C59C0211519D;
	Wed, 18 Jun 2025 14:08:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C59C0211519D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750280908;
	bh=/NOSXrykRZi8GU1E4lk+9SFPwXh54Rb4OsmS1WUS76E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RBT05SRw52kVqID8GredOHRIj4YJJKIeWSWafqth3qlPtgyiClzj7/Pwp4T3qOgzI
	 m4BOrM47IUGUHIdTyqN5uHNjnM9xh0aPEDVzeKNgrMtaTkQxpLW/ENydHVIkH32z6f
	 Z+Nm7mRqA4xIcidW6o+iLhdeqHaXWzT+3LRnFgdc=
Message-ID: <8f96db3f-fc3b-44b6-ab28-26bca6e2615b@linux.microsoft.com>
Date: Wed, 18 Jun 2025 14:08:26 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86: hyperv: Expose hv_map_msi_interrupt function
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "x86@kernel.org" <x86@kernel.org>
References: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1749599526-19963-4-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157639630F8AD2D8FD8F52FD475A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157639630F8AD2D8FD8F52FD475A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/2025 4:07 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, June 10, 2025 4:52 PM
>>
>> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
> The preferred patch Subject prefix is "x86/hyperv:"
> 

Thank you for clarifying - I thought I saw some precedent for x86: hyperv:
but must have been mistaken.

>>
>> This patch moves a part of currently internal logic into the
>> hv_map_msi_interrupt function and makes it globally available helper
>> function, which will be used to map PCI interrupts in case of root
>> partition.
> 
> Avoid "this patch" in commit messages.  Suggest:
> 
> Create a helper function hv_map_msi_interrupt() that contains some
> logic that is currently internal to irqdomain.c. Make the helper function
> globally available so it can be used to map PCI interrupts when running
> in the root partition.
> 

Thanks, I'll rephrase.

>>
>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/irqdomain.c     | 47 ++++++++++++++++++++++++---------
>>  arch/x86/include/asm/mshyperv.h |  2 ++
>>  2 files changed, 36 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
>> index 31f0d29cbc5e..82f3bafb93d6 100644
>> --- a/arch/x86/hyperv/irqdomain.c
>> +++ b/arch/x86/hyperv/irqdomain.c
>> @@ -169,13 +169,40 @@ static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
>>  	return dev_id;
>>  }
>>
>> -static int hv_map_msi_interrupt(struct pci_dev *dev, int cpu, int vector,
>> -				struct hv_interrupt_entry *entry)
>> +/**
>> + * hv_map_msi_interrupt() - "Map" the MSI IRQ in the hypervisor.
>> + * @data:      Describes the IRQ
>> + * @out_entry: Hypervisor (MSI) interrupt entry (can be NULL)
>> + *
>> + * Map the IRQ in the hypervisor by issuing a MAP_DEVICE_INTERRUPT hypercall.
>> + */
>> +int hv_map_msi_interrupt(struct irq_data *data,
>> +			 struct hv_interrupt_entry *out_entry)
>>  {
>> -	union hv_device_id device_id = hv_build_pci_dev_id(dev);
>> +	struct msi_desc *msidesc;
>> +	struct pci_dev *dev;
>> +	union hv_device_id device_id;
>> +	struct hv_interrupt_entry dummy;
>> +	struct irq_cfg *cfg = irqd_cfg(data);
>> +	const cpumask_t *affinity;
>> +	int cpu;
>> +	u64 res;
>>
>> -	return hv_map_interrupt(device_id, false, cpu, vector, entry);
>> +	msidesc = irq_data_get_msi_desc(data);
>> +	dev = msi_desc_to_pci_dev(msidesc);
>> +	device_id = hv_build_pci_dev_id(dev);
>> +	affinity = irq_data_get_effective_affinity_mask(data);
>> +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> 
> Is the cpus_read_lock held at this point? I'm not sure what the
> overall calling sequence looks like. If it is not held, the CPU that
> is selected could go offline before hv_map_interrupt() is called.
> This computation of the target CPU is the same as in the code
> before this patch, but that existing code looks like it has the
> same problem.
> 

Thanks for pointing it out - It *looks* like the read lock is not held
everywhere this could be called, so it could indeed be a problem.

I've been thinking about different ways around this but I lack the
knowledge to have an informed opinion about it:

- We could take the cpu read lock in this function, would that work?

- I'm not actually sure why the code is getting the first cpu off the effective
  affinity mask in the first place. It is possible to get the apic id (and hence
  the cpu) already associated with the irq, as per e.g. x86_vector_msi_compose_msg()
  Maybe we could get the cpu that way, assuming that doesn't have a similar issue.

- We could just let this race happen, maybe the outcome isn't too catastrophic?

What do you think?

>> +
>> +	res = hv_map_interrupt(device_id, false, cpu, cfg->vector,
>> +			       out_entry ? out_entry : &dummy);
>> +	if (!hv_result_success(res))
>> +		pr_err("%s: failed to map interrupt: %s",
>> +		       __func__, hv_result_to_string(res));
> 
> hv_map_interrupt() already outputs a message if the hypercall
> fails. Is another message needed here?
> 

It does print the function name, which gives additional context.
Probably it can just be removed however.

>> +
>> +	return hv_result_to_errno(res);
> 
> The error handling is rather messed up. First hv_map_interrupt()
> sometimes returns a Linux errno (not negated), and sometimes a
> hypercall result. The errno is EINVAL, which has value "22", which is
> the same as hypercall result HV_STATUS_ACKNOWLEDGED. And
> the hypercall result returned from hv_map_interrupt() is just
> the result code, not the full 64-bit status, as hv_map_interrupt()
> has already done hv_result(status). Hence the "res" input arg to
> hv_result_to_errno() isn't really the correct input. For example,
> if the hypercall returns U64_MAX, that won't be caught by
> hv_result_to_errno() since the value has been truncated to
> 32 bits. Fixing all this will require some unscrambling.
> 

Good point, it's pretty messed up! I think in v2 I'll add a patch to
clean this up first.

>>  }
>> +EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
>>
>>  static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi_msg *msg)
>>  {
>> @@ -190,10 +217,8 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>  {
>>  	struct msi_desc *msidesc;
>>  	struct pci_dev *dev;
>> -	struct hv_interrupt_entry out_entry, *stored_entry;
>> +	struct hv_interrupt_entry *stored_entry;
>>  	struct irq_cfg *cfg = irqd_cfg(data);
>> -	const cpumask_t *affinity;
>> -	int cpu;
>>  	u64 status;
>>
>>  	msidesc = irq_data_get_msi_desc(data);
>> @@ -204,9 +229,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>  		return;
>>  	}
>>
>> -	affinity = irq_data_get_effective_affinity_mask(data);
>> -	cpu = cpumask_first_and(affinity, cpu_online_mask);
>> -
>>  	if (data->chip_data) {
>>  		/*
>>  		 * This interrupt is already mapped. Let's unmap first.
>> @@ -235,15 +257,14 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>  		return;
>>  	}
>>
>> -	status = hv_map_msi_interrupt(dev, cpu, cfg->vector, &out_entry);
>> +	status = hv_map_msi_interrupt(data, stored_entry);
>>  	if (status != HV_STATUS_SUCCESS) {
> 
> hv_map_msi_interrupt() returns an errno, so testing for HV_STATUS_SUCCESS
> is bogus.
> 

Thanks, noted.

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
>> index 5ec92e3e2e37..843121465ddd 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -261,6 +261,8 @@ static inline void hv_apic_init(void) {}
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


