Return-Path: <linux-hyperv+bounces-10168-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHWuCAiZ3mlrGQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10168-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 21:44:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB93FE0FE
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 21:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 988C73063A2C
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 19:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27582F0C74;
	Tue, 14 Apr 2026 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PrLOGibe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B71A01BE;
	Tue, 14 Apr 2026 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776195843; cv=none; b=V8c397LHOE2ZNbWglrJz3zFkaY+BXoP9bOjQW3gRAaxIgZJCNd8jhobNv98acIKN2Xvxf89f/7vJB8++qUBEHopiHsfzJOfiaHXcLxU4BsO62HQdP7S9X6mGiUYu4mz7/umfwgzOiN2/LNTXvZnqh+AFq4W7w7fVLjsEADRfaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776195843; c=relaxed/simple;
	bh=8uUybN5gPpkOejRZ6N/OcR8at46nXE+VEYeby7KptWE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lZY6+KBfi3+9aTUajKYRnIVfuSo+3UK65ARiRdwZXNkYPNA7uIJs2B11gwc/h9WnBwmbGnMGLj210BNVS0aDFRUBHgMhSNCgJ499JgwDhzwSJerpclnpl2gdDJMERTbyT9DnxTEDNb5EqtTbHonlX4lIEL0tyhVLwVjli4+UWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PrLOGibe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA20220B7128;
	Tue, 14 Apr 2026 12:43:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA20220B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776195842;
	bh=2sCL/WvVpitYcQBQMCxOqwbqrjUxJqtzArQ8i2O5xXY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PrLOGibedMeSwMPv2HpQ8y+V/nZM+s6uNg1WXCtIzzOv10gyHiIY6LpDKf+6cH0Cn
	 9/NeH8gRxsneTMEubxcKCndOC3iwAcYDiwbBuvgIJMpXXwOrq/YA1QrybZ3tn8k+Yd
	 +VsbIQ1uOutVAQNpPOISr9NG/Z6DK4GA5Tc3DU5U=
Message-ID: <c1c86f2d-3535-45bb-86dd-90c3b05c16fb@linux.microsoft.com>
Date: Tue, 14 Apr 2026 12:43:48 -0700
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
 <e7b3d040-b504-4665-a3ff-8d20261400ca@linux.microsoft.com>
 <SN6PR02MB415741EA3C27630199BCEAA3D4252@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB415741EA3C27630199BCEAA3D4252@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10168-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[easwar.hariharan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 43DB93FE0FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/2026 11:06 AM, Michael Kelley wrote:
> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com> Sent: Tuesday, April 14, 2026 10:42 AM
>>
> 
> [snip]
>  
>>>> Thanks for that explanation, that makes sense. I didn't see any serialization
>>>> that would ensure that the VMBus path to communicate the child devices on the bus
>>>> would complete before pci_scan_device() finds and finalizes the pci_dev. I think it's
>>>
>>> FWIW, hv_pci_query_relations() should be ensuring that the communication
>>> has completed before it returns. It does a wait_for_reponse(), which ensures
>>> that the Hyper-V host has sent the PCI_BUS_RELATIONS[2] response. However,
>>> that message spins off work to the hbus->wq workqueue, so
>>> hv_pci_query_relations() has a flush_workqueue() so ensure everything that
>>> was queued has completed.
>>
>> Hm, I read the comment for the flush_workqueue() as addressing the "PCI_BUS_RELATIONS[2]
>> message arrived before we sent the QUERY_BUS_RELATIONS message" race case, not as an
>> "all child devices have definitely been received and processed in response to our
>> QUERY_BUS_RELATIONS message". Also, knowing very little about the VMBus contract, I
>> discounted the 100 ms timeout in wait_for_response() as a serialization guarantee.
> 
> Yeah, that timeout is so that the code can wake up every 100 ms to check
> if the device has been rescinded (i.e., removed). If the device isn't
> rescinded, wait_for_response() waits forever until a response comes in.

I don't know how I missed that. :(

>>
>> Chalk it up to previous experience dealing with hardware that's *supposed* to be
>> spec-compliant and complete initialization within specified timings. :)
>>
>> I see now that the flush is sufficient though.
>>
>>>
>>> Thinking more about the "hv_pcibus_installed" case, if that path is ever
>>> triggered, I don't think anything needs to be done with the logical device ID.
>>> The vPCI device has already been fully initialized on the Linux side, and it's
>>> logical device ID would not change.
>>>
>>> So I think you could construct the full logical device ID once
>>> hv_pci_query_relations() returns to hv_pci_probe().
>>
>> Let me think about this more and decide between the logical ID and full bus GUID
>> options.
>>
>>>
>>>> safest to take the approach to communicate the GUID, and find the function number from
>>>> the pci_dev. This does mean that there will be an essentially identical copy of
>>>> hv_build_logical_dev_id() in the IOMMU code, but a comment can explain that.
>>>
>>> With this alternative approach, is there a need to communicate the full
>>> GUID to the pvIOMMU drvier? Couldn't you just communicate bytes 4 thru
>>> 7, which would be logical device ID minus the function number?
>>
>> Yes, we could just communicate bytes 4 through 7 but the pvIOMMU version of the build logical
>> ID function would diverge from the pci-hyperv version. I figured if we say (in a comment)
>> that this is the same ID as generated in pci-hyperv, it's better for future readers to see it
>> to be clearly identical at first glance.
>>
>> It's also possible to change the pci-hyperv function to only take bytes 4 through 7 instead of the
>> full GUID, but I rather think we don't need that impedance mismatch of bytes 4 through 7 of the
>> GUID becoming bytes 0 through 3 of a u32.
>>
>>>

<snip>

>>
>>>>>>>
>>>>>>> I don't think the pci-hyperv driver even needs to tell the IOMMU driver to
>>>>>>> remove the information if a PCI pass-thru device is unbound or removed, as
>>>>>>> the logical device ID will be the same if the device ever comes back. At worst,
>>>>>>> the IOMMU driver can simply replace an existing logical device ID if a new one
>>>>>>> is provided for the same PCI domain ID.
>>>>>>
>>>>>> As above, replacing a unique GUID when a result is found for a non-unique
>>>>>> key value may be prone to failure if it happens that the device that came "back"
>>>>>> is not in fact the same device (or class of device) that went away and just happens
>>>>>> to, either due to bytes 4 and 5 being identical, or due to collision in the
>>>>>> pci_domain_nr_dynamic_ida, have the same domain number.
>>>>
>>>> Given the vPCI team's statements (above), I think we will need to handle unbind or
>>>> removal and ensure the pvIOMMU drivers data structure is invalidated when either
>>>> happens.
>>>
>>> The generic PCI code should handle detaching from the pvIOMMU. So I'm assuming
>>> your statement is specifically about the mapping from domain ID to logical device ID.
>>
>> Yes, apologies for the vagueness (again).
>>
>>> I still think removing it may be unnecessary since adding a mapping for a new vPCI
>>> device with the same domain ID but different logical device ID could just overwrite
>>> any existing mapping. And leaving a dead mapping in the pvIOMMU data structures
>>> doesn’t actually hurt anything. On the other hand, removing/invalidating it is
>>> certainly more tidy and might prevent some confusion down the road.
>>>
>>
>> Yes, if the data structure maps domain -> logical ID, we can do the overwrite as you say.
>> With my approach of informing the pvIOMMU driver of the entire (bus) GUID, we would want
>> to be careful that we don't assume the 1:1 bus<->device case and overwrite an existing
>> device entry with a new device that's on the same bus.
> 
> Yes, that's a valid point.  I was assuming that the pvIOMMU would use the
> domain ID at the lookup key, since the domain ID is directly available from the
> struct pci_dev that is an input parameter to the IOMMU functions. But in the
> not 1:1 case, that domain ID might refer to a bus with multiple functions. The
> logical device IDs for those devices will be the same except for the low order
> 3 bits that encode with the function number. So maybe the domain ID maps
> to a partial logical device ID, and the pvIOMMU driver must always add in the
> function number so the not 1:1 case works.

Agreed.

> 
> Would the pvIOMMU driver do anything with the full GUID, except extract
> bytes 4 through 7? There's no way I see to use the full GUID as the lookup
> key.
> 

No, the hypercalls only use the logical ID, so the rest of the GUID is unused.

Thanks,
Easwar (he/him)

