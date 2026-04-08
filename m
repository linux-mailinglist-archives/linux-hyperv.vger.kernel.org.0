Return-Path: <linux-hyperv+bounces-10089-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G6PCb641mlxHggAu9opvQ
	(envelope-from <linux-hyperv+bounces-10089-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 22:21:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020F3C3B7F
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 22:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BA243014759
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C038F94A;
	Wed,  8 Apr 2026 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VMmQlBqh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065B355F43;
	Wed,  8 Apr 2026 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679676; cv=none; b=k/NWRfJfABXm6Ig+qNiwEi6gLXacNP7U/4dpVAUqd0MKccOanIKX48v3qyksQQLJ+PGnM9gD0EhdEd6AdnKBMtMH3LrqaBqpNyLwU9tE7zOxKNud20CR+vbwFp2Bv8FHtdq4RS0WYO9iulgL5WyICxNmUUtP67oTLBs7DKgzttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679676; c=relaxed/simple;
	bh=vmgJA28U4oEYXCV1uPCwl7E69UiNhgMrVSZD1Icewes=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fZXCmQ6OdYL6LsFXe1rUtmLF3RpjApr8xQRFvDNxhu+cYwyflF6fig6bK84BBPDBleM9+oNADwAiBJTrSGRMJKIS2hrf1QZt2mkRpkjnT5rKvBILNOu76ySrEyw4IJP3oC8ap0RKqzrazKb23hXo5nSgmqS+e/RnUyP2TTVvE2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VMmQlBqh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.145.186] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2CC5B20B710C;
	Wed,  8 Apr 2026 13:21:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CC5B20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775679672;
	bh=eC6YQa1wGfGRjmh3YlDhhWauLUlilIwy3f2460KCSmU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VMmQlBqhlgIdTdlILC4Vgofeh7QQRbGCvBn0mjur9dm7GW8RBLZ/OT7jUbxrFcYIE
	 BEeFlkHDYNNoG/nUmpPZDyyUg3KMFFklByalhC0jKsDuA4qetc3zSzgni9aFQ4L8hG
	 hewNOv+SL7mfpgNv1JkLaT8SkuP/NclL3C3V6D4E=
Message-ID: <2dabc1b8-0cf0-4fc8-9cd4-cce60adfc05e@linux.microsoft.com>
Date: Wed, 8 Apr 2026 13:20:59 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: easwar.hariharan@linux.microsoft.com,
 Yu Zhang <zhangyu1@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
 "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [RFC v1 1/5] PCI: hv: Create and export hv_build_logical_dev_id()
To: Michael Kelley <mhklinux@outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-2-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41570FC0D7EA1364FB48CD1ED485A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <162c901f-69a7-420a-9148-a469d5a8ca4f@linux.microsoft.com>
 <SN6PR02MB4157098A14BE63FCA8C0A70ED480A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB4157098A14BE63FCA8C0A70ED480A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10089-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[easwar.hariharan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9020F3C3B7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/11/2026 9:36 AM, Michael Kelley wrote:
> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com> Sent: Friday, January 9, 2026 10:41 AM
>>
>> On 1/8/2026 10:46 AM, Michael Kelley wrote:
>>> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 2025 9:11 PM
>>>>
>>>> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>>>>
>>>> Hyper-V uses a logical device ID to identify a PCI endpoint device for
>>>> child partitions. This ID will also be required for future hypercalls
>>>> used by the Hyper-V IOMMU driver.
>>>>
>>>> Refactor the logic for building this logical device ID into a standalone
>>>> helper function and export the interface for wider use.
>>>>
>>>> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>>>> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
>>>> ---
>>>>  drivers/pci/controller/pci-hyperv.c | 28 ++++++++++++++++++++--------
>>>>  include/asm-generic/mshyperv.h      |  2 ++
>>>>  2 files changed, 22 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>>>> index 146b43981b27..4b82e06b5d93 100644
>>>> --- a/drivers/pci/controller/pci-hyperv.c
>>>> +++ b/drivers/pci/controller/pci-hyperv.c
>>>> @@ -598,15 +598,31 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>>>>
>>>>  #define hv_msi_prepare		pci_msi_prepare
>>>>
>>>> +/**
>>>> + * Build a "Device Logical ID" out of this PCI bus's instance GUID and the
>>>> + * function number of the device.
>>>> + */
>>>> +u64 hv_build_logical_dev_id(struct pci_dev *pdev)
>>>> +{
>>>> +	struct pci_bus *pbus = pdev->bus;
>>>> +	struct hv_pcibus_device *hbus = container_of(pbus->sysdata,
>>>> +						struct hv_pcibus_device, sysdata);
>>>> +
>>>> +	return (u64)((hbus->hdev->dev_instance.b[5] << 24) |
>>>> +		     (hbus->hdev->dev_instance.b[4] << 16) |
>>>> +		     (hbus->hdev->dev_instance.b[7] << 8)  |
>>>> +		     (hbus->hdev->dev_instance.b[6] & 0xf8) |
>>>> +		     PCI_FUNC(pdev->devfn));
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(hv_build_logical_dev_id);
>>>
>>> This change is fine for hv_irq_retarget_interrupt(), it doesn't help for the
>>> new IOMMU driver because pci-hyperv.c can (and often is) built as a module.
>>> The new Hyper-V IOMMU driver in this patch series is built-in, and so it can't
>>> use this symbol in that case -- you'll get a link error on vmlinux when building
>>> the kernel. Requiring pci-hyperv.c to *not* be built as a module would also
>>> require that the VMBus driver not be built as a module, so I don't think that's
>>> the right solution.
>>>
>>> This is a messy problem. The new IOMMU driver needs to start with a generic
>>> "struct device" for the PCI device, and somehow find the corresponding VMBus
>>> PCI pass-thru device from which it can get the VMBus instance ID. I'm thinking
>>> about ways to do this that don't depend on code and data structures that are
>>> private to the pci-hyperv.c driver, and will follow-up if I have a good suggestion.
>>
>> Thank you, Michael. FWIW, I did try to pull out the device ID components out of
>> pci-hyperv into include/linux/hyperv.h and/or a new include/linux/pci-hyperv.h
>> but it was just too messy as you say.
> 
> Yes, the current approach for getting the device ID wanders through struct
> hv_pcibus_device (which is private to the pci-hyperv driver), and through
> struct hv_device (which is a VMBus data structure). That makes the linkage
> between the PV IOMMU driver and the pci-hyperv and VMBus drivers rather
> substantial, which is not good.

Hi Michael,

I missed this, or made a mental note to follow up but forgot. Either way, Yu reminded
me about this email chain and I started looking at it this week.

> 
> But here's an idea for an alternate approach. The PV IOMMU driver doesn't
> have to generate the logical device ID on-the-fly by going to the dev_instance
> field of struct hv_device. Instead, the pci-hyperv driver can generate the logical
> device ID in hv_pci_probe(), and put it somewhere that's easy for the IOMMU
> driver to access. The logical device ID doesn't change while Linux is running, so
> stashing another copy somewhere isn't a problem.

In my exploration and consulting with Dexuan, I realized that one of the components of
the logical device ID, the PCI function number is set only in pci_scan_device(), well into
pci_scan_root_bus_bridge() that you call out as the point by which the communication must
have occurred.

But then, Dexuan also pointed me to hv_pci_assign_slots() with its call to wslot_to_devfn() and I'm
honestly confused how these two interact. With the current approach, it looks like whatever
devfn pci_scan_device() set is the correct function number to use for the logical device
ID, in which case, the best I can do with your suggested approach below is to inform the
pvIOMMU driver of the GUID, rather than the logical device ID itself.

Perhaps with your history, you can clarify the interaction, and/or share your thoughts
on the above?

> 
> So have the Hyper-V PV IOMMU driver provide an EXPORTed function to accept
> a PCI domain ID and the related logical device ID. The PV IOMMU driver is
> responsible for storing this data in a form that it can later search. hv_pci_probe()
> calls this new function when it instantiates a new PCI pass-thru device. Then when
> the IOMMU driver needs to attach a new device, it can get the PCI domain ID
> from the struct pci_dev (or struct pci_bus), search for the related logical device
> ID in its own data structure, and use it. The pci-hyperv driver has a dependency
> on the IOMMU driver, but that's a dependency in the desired direction. The
> PCI domain ID and logical device ID are just integers, so no data structures are
> shared.

In a previous reply on this thread, you raised the uniqueness issue of bytes 4 and 5
of the GUID being used to create the domain number. I thought this approach could
help with that too, but as I coded it up, I realized that using the domain number 
(not guaranteed to be unique) to search for the bus instance GUID (guaranteed to be unique)
is the wrong way around. It is unfortunately the only available key in the pci_dev
handed to the pvIOMMU driver in this approach though...

Do you think that's a fatal flaw?

> 
> Note that the pci-hyperv must inform the PV IOMMU driver of the logical
> device ID *before* create_root_hv_pci_bus() calls pci_scan_root_bus_bridge().
> The latter function eventually invokes hv_iommu_attach_dev(), which will
> need the logical device ID. See example stack trace. [1]
> 
> I don't think the pci-hyperv driver even needs to tell the IOMMU driver to
> remove the information if a PCI pass-thru device is unbound or removed, as
> the logical device ID will be the same if the device ever comes back. At worst,
> the IOMMU driver can simply replace an existing logical device ID if a new one
> is provided for the same PCI domain ID.

As above, replacing a unique GUID when a result is found for a non-unique
key value may be prone to failure if it happens that the device that came "back"
is not in fact the same device (or class of device) that went away and just happens
to, either due to bytes 4 and 5 being identical, or due to collision in the
pci_domain_nr_dynamic_ida, have the same domain number. 

Thanks,
Easwar (he/him)

> 
> An include file must provide a stub for the new function if
> CONFIG_HYPERV_PVIOMMU is not defined, so that the pci-hyperv driver still
> builds and works.
> 
> I haven't coded this up, but it seems like it should be pretty clean.
> 
> Michael
> 
> [1] Example stack trace, starting with vmbus_add_channel_work() as a
> result of Hyper-V offering the PCI pass-thru device to the guest.
> hv_pci_probe() runs, and ends up in the generic Linux code for adding
> a PCI device, which in turn sets up the IOMMU.
> 
> [    1.731786]  hv_iommu_attach_dev+0xf0/0x1d0
> [    1.731788]  __iommu_attach_device+0x21/0xb0
> [    1.731790]  __iommu_device_set_domain+0x65/0xd0
> [    1.731792]  __iommu_group_set_domain_internal+0x61/0x120
> [    1.731795]  iommu_setup_default_domain+0x3a4/0x530
> [    1.731796]  __iommu_probe_device.part.0+0x15d/0x1d0
> [    1.731798]  iommu_probe_device+0x81/0xb0
> [    1.731799]  iommu_bus_notifier+0x2c/0x80
> [    1.731800]  notifier_call_chain+0x66/0xe0
> [    1.731802]  blocking_notifier_call_chain+0x47/0x70
> [    1.731804]  bus_notify+0x3b/0x50
> [    1.731805]  device_add+0x631/0x850
> [    1.731807]  pci_device_add+0x2db/0x670
> [    1.731809]  pci_scan_single_device+0xc3/0x100
> [    1.731810]  pci_scan_slot+0x97/0x230
> [    1.731812]  pci_scan_child_bus_extend+0x3b/0x2f0
> [    1.731814]  pci_scan_root_bus_bridge+0xc0/0xf0
> [    1.731816]  hv_pci_probe+0x398/0x5f0
> [    1.731817]  vmbus_probe+0x42/0xa0
> [    1.731819]  really_probe+0xe5/0x3e0
> [    1.731822]  __driver_probe_device+0x7e/0x170
> [    1.731823]  driver_probe_device+0x23/0xa0
> [    1.731824]  __device_attach_driver+0x92/0x130
> [    1.731826]  bus_for_each_drv+0x8c/0xe0
> [    1.731828]  __device_attach+0xc0/0x200
> [    1.731830]  device_initial_probe+0x4c/0x50
> [    1.731831]  bus_probe_device+0x32/0x90
> [    1.731832]  device_add+0x65b/0x850
> [    1.731836]  device_register+0x1f/0x30
> [    1.731837]  vmbus_device_register+0x87/0x130
> [    1.731840]  vmbus_add_channel_work+0x139/0x1a0
> [    1.731841]  process_one_work+0x19f/0x3f0
> [    1.731843]  worker_thread+0x188/0x2f0
> [    1.731845]  kthread+0x119/0x230
> [    1.731852]  ret_from_fork+0x1b4/0x1e0
> [    1.731854]  ret_from_fork_asm+0x1a/0x30
> 
>>

