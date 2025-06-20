Return-Path: <linux-hyperv+bounces-5985-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A5AE1FFC
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 18:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5243BC311
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD2A28937B;
	Fri, 20 Jun 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fVSZ0plV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PhmuZmuQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F91DD543;
	Fri, 20 Jun 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436369; cv=none; b=Jf+jslGdONFv5RgwoTAiJG5YV0kwC+YRwjf/GDWftQTT/7XF1V8pnETPg3YW3dKr86MzX+pJvYuAulFLNGIptAfY2KJA0nAvO//qQBKGj1sfu/d4Jp4aYI5YNHY6u9kxjoAXNJFqhZZZep7tOZ1+VhlmZ02q55+5lkli7B+xd3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436369; c=relaxed/simple;
	bh=vv/we4/ivW8qVlc9KYQ3SUnskmMUwhAqc+b3MJmmAI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ccv5vlTB01Pn+Q+pNisSj0bkHqq2V13nnq5kmnD+T37Dis8RWT5MIhlDJFPZoPBZMiny17EAWX1Y5kHmJGOflD4sFkFG6w5LN/RXL4J0/wU76/FBSyi2eql0WFlfZ1CwUsK4pUWDPWBiGmEUWW/LP0ZCJ2vNMN9XTacb/mWf5zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fVSZ0plV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PhmuZmuQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750436365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyI1F9ZHY5E4K/TqpP6N0NgPyquJa39Qr071ynaG014=;
	b=fVSZ0plVYhp6KwBYpmltfkSxuNsNAC/7XfZShU69Cx0/8hFmuPw0eSH+Nv9WnM/23Ocjem
	zIzX6xLJ3SmpgUl8dHsH60vTgmOX/s1XIxN2K00/JWg12h41baUgo9scAOfzGov7X6tw++
	UThw1WbFXpflUv/HaDUSOQUxlDrxlUNYfWbbJhkMqa2e7AzYsRxv9spTmH44ZGYAVLLESf
	hED98byL/mOH+Y7OH5oywasR7kOg2FHnFgpdaKJEPJN05IeErqtTiyTEHvws4+6BtPeizF
	nB+qGcccE9bDamx0L+mVy+WppwgPi52/1R4wcXKnjszqujq37+vlqBNOsns79w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750436365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyI1F9ZHY5E4K/TqpP6N0NgPyquJa39Qr071ynaG014=;
	b=PhmuZmuQfJdPqbEkPXi+gvYMeuWTjpSprGjAU1gvLagNyhdjlNiTFYgUXvA2f35kGWg5v3
	nz1mSbILfIRi+rDA==
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
 <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
 <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 3/4] x86: hyperv: Expose hv_map_msi_interrupt function
In-Reply-To: <8f96db3f-fc3b-44b6-ab28-26bca6e2615b@linux.microsoft.com>
References: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1749599526-19963-4-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157639630F8AD2D8FD8F52FD475A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8f96db3f-fc3b-44b6-ab28-26bca6e2615b@linux.microsoft.com>
Date: Fri, 20 Jun 2025 18:19:24 +0200
Message-ID: <878qlmqtbn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 18 2025 at 14:08, Nuno Das Neves wrote:
> On 6/11/2025 4:07 PM, Michael Kelley wrote:
>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, June 10, 2025 4:52 PM
>>> +/**
>>> + * hv_map_msi_interrupt() - "Map" the MSI IRQ in the hypervisor.
>>> + * @data:      Describes the IRQ
>>> + * @out_entry: Hypervisor (MSI) interrupt entry (can be NULL)
>>> + *
>>> + * Map the IRQ in the hypervisor by issuing a MAP_DEVICE_INTERRUPT hypercall.
>>> + */
>>> +int hv_map_msi_interrupt(struct irq_data *data,
>>> +			 struct hv_interrupt_entry *out_entry)
>>>  {
>>> -	union hv_device_id device_id = hv_build_pci_dev_id(dev);
>>> +	struct msi_desc *msidesc;
>>> +	struct pci_dev *dev;
>>> +	union hv_device_id device_id;
>>> +	struct hv_interrupt_entry dummy;
>>> +	struct irq_cfg *cfg = irqd_cfg(data);
>>> +	const cpumask_t *affinity;
>>> +	int cpu;
>>> +	u64 res;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

>>>
>>> -	return hv_map_interrupt(device_id, false, cpu, vector, entry);
>>> +	msidesc = irq_data_get_msi_desc(data);
>>> +	dev = msi_desc_to_pci_dev(msidesc);
>>> +	device_id = hv_build_pci_dev_id(dev);
>>> +	affinity = irq_data_get_effective_affinity_mask(data);
>>> +	cpu = cpumask_first_and(affinity, cpu_online_mask);
>> 
>> Is the cpus_read_lock held at this point? I'm not sure what the
>> overall calling sequence looks like. If it is not held, the CPU that
>> is selected could go offline before hv_map_interrupt() is called.
>> This computation of the target CPU is the same as in the code
>> before this patch, but that existing code looks like it has the
>> same problem.
>> 
>
> Thanks for pointing it out - It *looks* like the read lock is not held
> everywhere this could be called, so it could indeed be a problem.
>
> I've been thinking about different ways around this but I lack the
> knowledge to have an informed opinion about it:
>
> - We could take the cpu read lock in this function, would that work?

Obviously not.

> - I'm not actually sure why the code is getting the first cpu off the effective
>   affinity mask in the first place. It is possible to get the apic id (and hence
>   the cpu) already associated with the irq, as per e.g. x86_vector_msi_compose_msg()
>   Maybe we could get the cpu that way, assuming that doesn't have a
>   similar issue.

There is no reason to fiddle in the underlying low level data. The
effective affinity mask is there for a reason.

> - We could just let this race happen, maybe the outcome isn't too catastrophic?

Let's terminate guesswork mode and look at the facts.

The point is that hv_map_msi_interrupt() is called from:

    1) hv_irq_compose_msi_msg()

    2) hv_arch_irq_unmask() (in patch 4/4)

Both functions are interrupt chip callbacks and invoked with the
interrupt descriptor lock held.

At the point where they are called, the effective affinity mask is valid
and immutable. Nothing can modify it as any modification requires the
interrupt descriptor lock to be held. This applies to the CPU hotplug
machinery too. So this AND cpu_online_mask is a complete pointless
voodoo exercise.

Just use:

     cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));

and be done with it.

Please fix that first with a seperate patch before moving this code
around.

Thanks,

        tglx

