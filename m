Return-Path: <linux-hyperv+bounces-10165-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JPQA+593mm/EwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10165-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 19:48:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3473FD426
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 19:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBE43034565
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53793F076B;
	Tue, 14 Apr 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UMgHqkGV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB33F0762;
	Tue, 14 Apr 2026 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188559; cv=none; b=R8lf0vGZfbMg/3q3AyqaeJYsY+irLWNvy2qGIrRdceLU0yQGMIusSklmnn3RHHtpXN/SqnAlbgHqZM6/FbCuwpEVA1/TBi3KlgPsfhf+FcnfvH4/4R+BHFrvtZF/wjJ5lfj6ghQR3SB2+U1/eSfaFdPed5zRnCziRZGAP93IFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188559; c=relaxed/simple;
	bh=gCeYHqurzx2lPh87+TV2NNZN9FOY4ebpnxPp7ufGhw0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pikRSSPAuU+qXakpsEKkNlqe8avPWM1BVoDXpSqfc/MmJGAQ7woWXBs9H9PHTU0CWrdkui1Ej7njfSjxPoGK6fHv2cjysDCC6VqNxt+ucno26XziJAADfDD0q6nk/GnhQr0SunnDLJ56b+nWOdDpomiLkivmZPd4mYp3QCcUCqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UMgHqkGV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id A889920B6F01;
	Tue, 14 Apr 2026 10:42:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A889920B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776188554;
	bh=7zZTMeROYxpM9VMql2IMGqFBVYX4tD7eG6hTBXer6KM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UMgHqkGVW/2TBlRJog6nAB/LFf9dHN1/ZMCFaTlWttNReQRoU0GlAukGf8krep8Jc
	 YX+jtBhMIwwG7q+aKs2LRfuVLrCApBTul+7MoHGwYD5QcKFt9z4I8qEjFc8Hg+xf/B
	 N/hCdhW46/x8xJdWBj6IOrlmhdU/7+k5/lN16yzM=
Message-ID: <e7b3d040-b504-4665-a3ff-8d20261400ca@linux.microsoft.com>
Date: Tue, 14 Apr 2026 10:42:20 -0700
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
 <2dabc1b8-0cf0-4fc8-9cd4-cce60adfc05e@linux.microsoft.com>
 <SN6PR02MB4157DC555A9EC7A73E2CB8CBD4582@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a05fa5b8-3b82-4c5f-8fff-fe10b3f71e87@linux.microsoft.com>
 <SN6PR02MB4157BA7B07D328969EEBF2ADD4252@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB4157BA7B07D328969EEBF2ADD4252@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10165-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[easwar.hariharan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B3473FD426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/2026 9:24 AM, Michael Kelley wrote:
> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com> Sent: Monday, April 13, 2026 2:30 PM
>>
>> On 4/9/2026 12:01 PM, Michael Kelley wrote:
>>> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com> Sent: Wednesday, April 8, 2026 1:21 PM
>>>>
>>>> On 1/11/2026 9:36 AM, Michael Kelley wrote:
>>>>> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com> Sent: Friday, January 9, 2026 10:41 AM
>>>>>>
>>>>>> On 1/8/2026 10:46 AM, Michael Kelley wrote:
>>>>>>> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 2025 9:11 PM
>>>>>>>>
>>>>>>>> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>>>>>>>>
>>>>>>>> Hyper-V uses a logical device ID to identify a PCI endpoint device for
>>>>>>>> child partitions. This ID will also be required for future hypercalls
>>>>>>>> used by the Hyper-V IOMMU driver.
>>>>>>>>
>>>>>>>> Refactor the logic for building this logical device ID into a standalone
>>>>>>>> helper function and export the interface for wider use.
>>>>>>>>
>>>>>>>> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>>>>>>>> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
>>>>>>>> ---
>>>>>>>>  drivers/pci/controller/pci-hyperv.c | 28 ++++++++++++++++++++--------
>>>>>>>>  include/asm-generic/mshyperv.h      |  2 ++
>>>>>>>>  2 files changed, 22 insertions(+), 8 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>>>>>>>> index 146b43981b27..4b82e06b5d93 100644
>>>>>>>> --- a/drivers/pci/controller/pci-hyperv.c
>>>>>>>> +++ b/drivers/pci/controller/pci-hyperv.c
>>>>>>>> @@ -598,15 +598,31 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>>>>>>>>
>>>>>>>>  #define hv_msi_prepare		pci_msi_prepare
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * Build a "Device Logical ID" out of this PCI bus's instance GUID and the
>>>>>>>> + * function number of the device.
>>>>>>>> + */
>>>>>>>> +u64 hv_build_logical_dev_id(struct pci_dev *pdev)
>>>>>>>> +{
>>>>>>>> +	struct pci_bus *pbus = pdev->bus;
>>>>>>>> +	struct hv_pcibus_device *hbus = container_of(pbus->sysdata,
>>>>>>>> +						struct hv_pcibus_device, sysdata);
>>>>>>>> +
>>>>>>>> +	return (u64)((hbus->hdev->dev_instance.b[5] << 24) |
>>>>>>>> +		     (hbus->hdev->dev_instance.b[4] << 16) |
>>>>>>>> +		     (hbus->hdev->dev_instance.b[7] << 8)  |
>>>>>>>> +		     (hbus->hdev->dev_instance.b[6] & 0xf8) |
>>>>>>>> +		     PCI_FUNC(pdev->devfn));
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL_GPL(hv_build_logical_dev_id);
>>>>>>>
>>>>>>> This change is fine for hv_irq_retarget_interrupt(), it doesn't help for the
>>>>>>> new IOMMU driver because pci-hyperv.c can (and often is) built as a module.
>>>>>>> The new Hyper-V IOMMU driver in this patch series is built-in, and so it can't
>>>>>>> use this symbol in that case -- you'll get a link error on vmlinux when building
>>>>>>> the kernel. Requiring pci-hyperv.c to *not* be built as a module would also
>>>>>>> require that the VMBus driver not be built as a module, so I don't think that's
>>>>>>> the right solution.
>>>>>>>
>>>>>>> This is a messy problem. The new IOMMU driver needs to start with a generic
>>>>>>> "struct device" for the PCI device, and somehow find the corresponding VMBus
>>>>>>> PCI pass-thru device from which it can get the VMBus instance ID. I'm thinking
>>>>>>> about ways to do this that don't depend on code and data structures that are
>>>>>>> private to the pci-hyperv.c driver, and will follow-up if I have a good suggestion.
>>>>>>
>>>>>> Thank you, Michael. FWIW, I did try to pull out the device ID components out of
>>>>>> pci-hyperv into include/linux/hyperv.h and/or a new include/linux/pci-hyperv.h
>>>>>> but it was just too messy as you say.
>>>>>
>>>>> Yes, the current approach for getting the device ID wanders through struct
>>>>> hv_pcibus_device (which is private to the pci-hyperv driver), and through
>>>>> struct hv_device (which is a VMBus data structure). That makes the linkage
>>>>> between the PV IOMMU driver and the pci-hyperv and VMBus drivers rather
>>>>> substantial, which is not good.
>>>>
>>>> Hi Michael,
>>>>
>>>> I missed this, or made a mental note to follow up but forgot. Either way, Yu reminded
>>>> me about this email chain and I started looking at it this week.
>>>>
>>>>>
>>>>> But here's an idea for an alternate approach. The PV IOMMU driver doesn't
>>>>> have to generate the logical device ID on-the-fly by going to the dev_instance
>>>>> field of struct hv_device. Instead, the pci-hyperv driver can generate the logical
>>>>> device ID in hv_pci_probe(), and put it somewhere that's easy for the IOMMU
>>>>> driver to access. The logical device ID doesn't change while Linux is running, so
>>>>> stashing another copy somewhere isn't a problem.
>>>>
>>>> In my exploration and consulting with Dexuan, I realized that one of the components of
>>>> the logical device ID, the PCI function number is set only in pci_scan_device(), well into
>>>> pci_scan_root_bus_bridge() that you call out as the point by which the communication
>>>> must have occurred.
>>>>
>>>> But then, Dexuan also pointed me to hv_pci_assign_slots() with its call to wslot_to_devfn() and I'm
>>>> honestly confused how these two interact. With the current approach, it looks like whatever
>>>> devfn pci_scan_device() set is the correct function number to use for the logical device
>>>> ID, in which case, the best I can do with your suggested approach below is to inform the
>>>> pvIOMMU driver of the GUID, rather than the logical device ID itself.
>>>>
>>>> Perhaps with your history, you can clarify the interaction, and/or share your thoughts
>>>> on the above?
>>>
>>> During hv_pci_probe(), hv_pci_query_relations() is called to ask the Hyper-V
>>> host about what PCI devices are present. hv_pci_query_relations() sends a
>>> PCI_QUERY_BUS_RELATIONS message to the host, and the host send back a
>>> PCI_BUS_RELATIONS or PCI_BUS_RELATIONS2 message. The response message
>>> is handled in hv_pci_onchannelcallback(), which calls hv_pci_devices_present()
>>> or hv_pci_devices_present2().  The latter two functions both call
>>> hv_pci_start_relations_work() to add a request to a workqueue that runs
>>> pci_devices_present_work().  Finally, pci_devices_present_work() calls
>>> pc_scan_child_bus(), followed by hv_pci_assign_slots().
>>>
>>> In hv_pci_assign_slots, you can see that the PCI_BUS_RELATIONS[2]
>>> info from the Hyper-V host contains a function number encoded in the
>>> win_slot field. So the Hyper-V host *does* tell the guest the function number.
>>> However, the generic Linux PCI subsystem doesn't use this function number.
>>> It still scans the PCI device, trying successive function numbers to see which
>>> ones work. The scan should find the same function number that the Hyper-V
>>> host originally reported.
>>>
>>> As you noted, there's a sequencing problem in waiting for
>>> pci_scan_single_device() to find the function number. In the hv_pci_probe()
>>> path, after hv_pci_query_relations() runs and before create_root_hv_pci_bus()
>>> is called, it seems feasible to use the function number provided by the
>>> Hyper-V host to construct the logical device ID. That should work. But there's
>>> another path, in that the Hyper-V host can generate a PCI_BUS_RELATIONS[2]
>>> message without a request from Linux when something on the host side changes
>>> the PCI device setup. There's a code path where pci_devices_present_work()
>>> finds the state is "hv_pcibus_installed", and directly calls pci_scan_child_bus().
>>> This path would presumably also need to construct (or re-construct) the
>>> logical device ID using the information from the Hyper-V host before calling
>>> pci_scan_child_bus(). I'm vague on the scenario for this latter case, but the
>>> code is obviously there to handle it.
>>>
>>> The other approach is as you suggest. The Hyper-V PCI driver can tell
>>> the IOMMU driver the almost complete logical device ID, using just the
>>> GUID bits. Then the IOMMU driver can then construct the full logical
>>> device ID by adding the function number from the struct pci_dev. I don't
>>> see a problem with this approach -- other IOMMU drivers are referencing
>>> the struct pci_dev, and pulling out the function number doesn't seem like
>>> a violation of layering.
>>>
>>
>> Thanks for that explanation, that makes sense. I didn't see any serialization
>> that would ensure that the VMBus path to communicate the child devices on the bus
>> would complete before pci_scan_device() finds and finalizes the pci_dev. I think it's
> 
> FWIW, hv_pci_query_relations() should be ensuring that the communication
> has completed before it returns. It does a wait_for_reponse(), which ensures
> that the Hyper-V host has sent the PCI_BUS_RELATIONS[2] response. However,
> that message spins off work to the hbus->wq workqueue, so
> hv_pci_query_relations() has a flush_workqueue() so ensure everything that
> was queued has completed.

Hm, I read the comment for the flush_workqueue() as addressing the "PCI_BUS_RELATIONS[2]
message arrived before we sent the QUERY_BUS_RELATIONS message" race case, not as an
"all child devices have definitely been received and processed in response to our
QUERY_BUS_RELATIONS message". Also, knowing very little about the VMBus contract, I
discounted the 100 ms timeout in wait_for_response() as a serialization guarantee.

Chalk it up to previous experience dealing with hardware that's *supposed* to be
spec-compliant and complete initialization within specified timings. :)

I see now that the flush is sufficient though.

> 
> Thinking more about the "hv_pcibus_installed" case, if that path is ever
> triggered, I don't think anything needs to be done with the logical device ID.
> The vPCI device has already been fully initialized on the Linux side, and it's
> logical device ID would not change.
> 
> So I think you could construct the full logical device ID once
> hv_pci_query_relations() returns to hv_pci_probe().

Let me think about this more and decide between the logical ID and full bus GUID options.

> 
>> safest to take the approach to communicate the GUID, and find the function number from
>> the pci_dev. This does mean that there will be an essentially identical copy of
>> hv_build_logical_dev_id() in the IOMMU code, but a comment can explain that.
> 
> With this alternative approach, is there a need to communicate the full
> GUID to the pvIOMMU drvier? Couldn't you just communicate bytes 4 thru
> 7, which would be logical device ID minus the function number?

Yes, we could just communicate bytes 4 through 7 but the pvIOMMU version of the build logical
ID function would diverge from the pci-hyperv version. I figured if we say (in a comment)
that this is the same ID as generated in pci-hyperv, it's better for future readers to see it
to be clearly identical at first glance.

It's also possible to change the pci-hyperv function to only take bytes 4 through 7 instead of the
full GUID, but I rather think we don't need that impedance mismatch of bytes 4 through 7 of the
GUID becoming bytes 0 through 3 of a u32.

> 
>>
>>>>
>>>>>
>>>>> So have the Hyper-V PV IOMMU driver provide an EXPORTed function to accept
>>>>> a PCI domain ID and the related logical device ID. The PV IOMMU driver is
>>>>> responsible for storing this data in a form that it can later search. hv_pci_probe()
>>>>> calls this new function when it instantiates a new PCI pass-thru device. Then when
>>>>> the IOMMU driver needs to attach a new device, it can get the PCI domain ID
>>>>> from the struct pci_dev (or struct pci_bus), search for the related logical device
>>>>> ID in its own data structure, and use it. The pci-hyperv driver has a dependency
>>>>> on the IOMMU driver, but that's a dependency in the desired direction. The
>>>>> PCI domain ID and logical device ID are just integers, so no data structures are
>>>>> shared.
>>>>
>>>> In a previous reply on this thread, you raised the uniqueness issue of bytes 4 and 5
>>>> of the GUID being used to create the domain number. I thought this approach could
>>>> help with that too, but as I coded it up, I realized that using the domain number
>>>> (not guaranteed to be unique) to search for the bus instance GUID (guaranteed to be unique)
>>>> is the wrong way around. It is unfortunately the only available key in the pci_dev
>>>> handed to the pvIOMMU driver in this approach though...
>>>>
>>>> Do you think that's a fatal flaw?
>>>
>>> There are two uniqueness problems, which I didn't fully separate conceptually
>>> until writing this. One problem is constructing a PCI domain ID that Linux can use
>>> to identify the virtual PCI bus that the Hyper-V PCI driver creates for each vPCI
>>> device. The Hyper-V virtual PCI driver uses GUID bytes 4 and 5, and recognizes
>>> that they might not be unique. So there's code in hv_pci_probe() to pick another
>>> number if there's a duplicate. Hyper-V doesn't really care how Linux picks the
>>> domain ID for the virtual PCI bus as it's purely a Linux construct.
>>
>> This part matters for the IOMMU driver as it is the key we will use to search the data
>> structure to find the right GUID to construct the logical dev ID that Hyper-V recognizes.
> 
> Right. But the Hyper-V vPCI driver in Linux ensures that the domain ID is unique
> in the sense that two active vPCI devices will not have the same domain ID. So
> the pvIOMMU driver should not encounter any ambiguity when looking up the
> logical device ID.

Agreed, that was a fragment of a thought that I neglected to delete before sending. Apologies.

> As you noted below, it's possible that a vPCI device could go
> away, and another vPCI device could be added that ends up with a domain ID
> that was previously used. When that added vPCI device is setup by the Hyper-V
> vPCI driver, it will inform the pvIOMMU driver about the domain ID -> logical
> device ID mapping, and it might overwrite an existing mapping if the newly
> added vPCI device ended up with a domain ID that had previously been used.
> And that's fine.

Yes.

>>
>>>
>>> The second problem is the logical device ID that Hyper-V interprets to
>>> identify a vPCI device in hypercalls such a HVCALL_RETARGET_INTERRUPT
>>> and the new pvIOMMU related hypercalls. This logical device ID uses
>>> GUID bytes 4 thru 7 (minus 1 bit).  I don’t think Linux uses the
>>> logical device ID for anything. Since only Hyper-V interprets it, Hyper-V
>>> must somehow be ensuring uniqueness of bytes 4 thru 7 (minus 1 bit).
>>> That's something to confirm with the Hyper-V team. If they are just hoping
>>> for the best, I don't know how Linux can solve the problem.
>>
>> I checked with the Hyper-V vPCI team on this aspect and the only guarantee that
>> they provide is that, at any given time, there will only be 1 device with a given
>> logical ID attached to a VM.
> 
> OK, so Hyper-V is guaranteeing the uniqueness of vPCI device GUID bytes 4
> thru 7 across all vPCI devices that are attached to a VM at a given point in time.
> That's good!

Technically, they're guaranteeing only that the *combination* of GUID bytes 4 through 7 AND
the slot number will be unique across all vPCI devices that are attached to a VM at a given
point in time. As you say below, while we have in practice not seen multiple devices on a
vPCI bus, the vPCI team asserts that there is no restriction in the stack on doing so.

> 
>> Once a device has been removed, everything about it is
>> forgotten from the Hyper-V stack's perspective, and nothing in the Hyper-V stack would
>> prevent a scenario where, for example, a data movement accelerator is attached with
>> logical ID X, then revoked, and let's say a NIC is attached with the same logical ID X.
> 
> And the "forgetting" behavior is the same in Linux. Once the device is removed,
> Linux forgets everything about it. If a new vPCI device shows up and happens
> to have the same GUID as a previous device, that should not cause any problems
> in Linux.
> 
>>
>> Also, FWIW, they also stated that the GUID is not unique and cannot be
>> guaranteed to be unique because it's the GUID for the bus, not the individual
>> devices.
> 
> I'm not sure I understand this statement. Is this referring to the possibility
> that a vPCI "device" that Hyper-V offers to the guest might have multiple
> functions?

Yes, apologies for the vagueness.

> The vPCI device driver in Linux has code to recognize this case,
> but I'm not aware of any current cases where it happens. In such a case,
> Linux should create a single PCI bus abstraction with multiple devices
> attached to it, with each device being a different function. If Hyper-V
> did ever offer a multiple-function configuration, there might be some
> debugging to do in the Hyper-V vPCI driver in Linux!
> 
> We shortcut the terminology by referring to a vPCI "device", and assuming
> that devices and busses are 1-to-1. But design allows for multiple devices
> as different functions on the same bus.
> 
>>

<snip>

>>>>>
>>>>> I don't think the pci-hyperv driver even needs to tell the IOMMU driver to
>>>>> remove the information if a PCI pass-thru device is unbound or removed, as
>>>>> the logical device ID will be the same if the device ever comes back. At worst,
>>>>> the IOMMU driver can simply replace an existing logical device ID if a new one
>>>>> is provided for the same PCI domain ID.
>>>>
>>>> As above, replacing a unique GUID when a result is found for a non-unique
>>>> key value may be prone to failure if it happens that the device that came "back"
>>>> is not in fact the same device (or class of device) that went away and just happens
>>>> to, either due to bytes 4 and 5 being identical, or due to collision in the
>>>> pci_domain_nr_dynamic_ida, have the same domain number.
>>
>> Given the vPCI team's statements (above), I think we will need to handle unbind or
>> removal and ensure the pvIOMMU drivers data structure is invalidated when either
>> happens.
> 
> The generic PCI code should handle detaching from the pvIOMMU. So I'm assuming
> your statement is specifically about the mapping from domain ID to logical device ID.

Yes, apologies for the vagueness (again).

> I still think removing it may be unnecessary since adding a mapping for a new vPCI
> device with the same domain ID but different logical device ID could just overwrite
> any existing mapping. And leaving a dead mapping in the pvIOMMU data structures
> doesn’t actually hurt anything. On the other hand, removing/invalidating it is
> certainly more tidy and might prevent some confusion down the road.
> 

Yes, if the data structure maps domain -> logical ID, we can do the overwrite as you say.
With my approach of informing the pvIOMMU driver of the entire (bus) GUID, we would want
to be careful that we don't assume the 1:1 bus<->device case and overwrite an existing
device entry with a new device that's on the same bus.

> I'm not the person writing the code, so it's easy for me to make hand-wavy
> statements. ;-)  You've got to actually make it work, so you get to make
> the final decisions.
> 
> Michael

Thank you for the history and engagement as I worked through the options!

- Easwar (he/him)

