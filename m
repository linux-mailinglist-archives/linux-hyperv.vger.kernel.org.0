Return-Path: <linux-hyperv+bounces-3332-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C9D9C6AD6
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2024 09:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089CD28210B
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2024 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9718870D;
	Wed, 13 Nov 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OkEZm9Un"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41870175D38;
	Wed, 13 Nov 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487642; cv=none; b=F90w5L6Oo3yJ9+iyXkO30agLFE0r28me9HZNTDMfnaB4YQ6W1Z+S9/8DOYIBJFWBuzeN3lZ97+I/gvUlkSbYV+ZEVeH5my32bNvcbr6XI0clzZ+j4mcAGv26DvWWzJc5UPs3p231SXQoGfGQR3xMmPbHMrlGbVpVR/Od4gY6HJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487642; c=relaxed/simple;
	bh=VZAgZ9kqqoB5/D8VJxtRpit6Ayl9TwWmktGv+iiqCqE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MaP11aMSRErgM3FEFFyQTGotxk+juEtW3APlGUfOuE/N0bpm2ZxpRSBDc8sum8Bua1bbe3SV9cehnw3m8MqLF9Vv1Bp9jISc2jmHSUe2V/N5bEiUIYtbWbCWy7uOvXjDL89411ueW3ORiXC0JRvcy6aw+sWeKToOFGELYPqOeg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OkEZm9Un; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.98.145] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id C0CEE20BEBCC;
	Wed, 13 Nov 2024 00:47:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0CEE20BEBCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731487641;
	bh=SPS+paqcIyB/AfQjvCGpueAi/m4/2CY3K6MBc4wtwOo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=OkEZm9Unt8DFFP3kp5+/iYNckQ/hawsOHy2X3Aqg6uohl0/at8m6VNLFc1Adq8LXr
	 HXP38jZ1FsK9PZpCSl6qe8ky5yhfI82wIbbW6tpu2jjRuib23RO1LdJiaSQ5Qrs2rd
	 gJ4CAeJXuVhY4GpOT3j1eTO8J8y3iBkPinp7czCU=
Message-ID: <dc5b1aaf-62cc-49ea-9fc7-c07b3afbd714@linux.microsoft.com>
Date: Wed, 13 Nov 2024 14:17:15 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] Drivers: hv: vmbus: Log on missing offers
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 John Starks <jostarks@microsoft.com>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>
References: <20241029080147.52749-1-namjain@linux.microsoft.com>
 <20241029080147.52749-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157D7212FE3F0F50FAB0592D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
 <4c9e670b-eb37-4bdb-adcf-a4ebbebcefab@linux.microsoft.com>
 <dc8f4e45-c89e-4e2d-82ac-58dd6e9c9884@linux.microsoft.com>
 <SN6PR02MB4157BB5A5F5EDFAC24D594DED4592@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB4157BB5A5F5EDFAC24D594DED4592@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/2024 8:43 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, November 10, 2024 9:44 PM
>>
>> On 11/7/2024 11:14 AM, Naman Jain wrote:
>>>
>>> On 11/1/2024 12:44 AM, Michael Kelley wrote:
>>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 29, 2024 1:02 AM
>>>>>
> 
> [snip]
> 
>>>>> @@ -2494,6 +2495,22 @@ static int vmbus_bus_resume(struct device *dev)
>>>>>
>>>>>        vmbus_request_offers();
>>>>>
>>>>> +    mutex_lock(&vmbus_connection.channel_mutex);
>>>>> +    list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
>>>>> +        if (channel->offermsg.child_relid != INVALID_RELID)
>>>>> +            continue;
>>>>> +
>>>>> +        /* hvsock channels are not expected to be present. */
>>>>> +        if (is_hvsock_channel(channel))
>>>>> +            continue;
>>>>> +
>>>>> +        pr_err("channel %pUl/%pUl not present after resume.\n",
>>>>> +            &channel->offermsg.offer.if_type,
>>>>> +            &channel->offermsg.offer.if_instance);
>>>>> +        /* ToDo: Cleanup these channels here */
>>>>> +    }
>>>>> +    mutex_unlock(&vmbus_connection.channel_mutex);
>>>>> +
>>>>
>>>> Dexuan and John have explained how in Azure VMs, there should not be
>>>> any VFs assigned to the VM at the time of hibernation. So the above
>>>> check for missing offers does not trigger an error message due to
>>>> VF offers coming after the all-offers-received message.
>>>>
>>>> But what about the case of a VM running on a local Hyper-V? I'm not
>>>> completely clear, but in that case I don't think any VFs are removed
>>>> before the hibernation, especially for VM-initiated hibernation. It's
>>>
>>> I am not sure about this behavior. I have requested Dexuan offline
>>> for a comment.
>>>
>>>> a reasonable scenario to later resume that same VM, with the same
>>>> VF assigned to the VM. Because of the way current code counts
>>>> the offers, vmbus_bus_resume() waits for the VF to be offered again,
>>>> and all the channels get correct post-resume relids. But the changes
>>>> in this patch set break that scenario. Since vmbus_bus_resume() now
>>>> proceeds before the VF offer arrives, hv_pci_resume() calling
>>>> vmbus_open() could use the pre-hibernation relid for the VF and break
>>>> things. Certainly the "not present after resume" error message would
>>>> be spurious.
>>>>
>>>> Maybe the focus here is Azure, and it's tolerable for the local Hyper-V
>>>> case with a VF to not work pending later fixes. But I thought I'd call
>>>> out the potential issue (assuming my thinking is correct).
>>>>
>>>> Michael
>>>
>>> IIUC, below scenarios can happen based on your comment-
>>>
>>> Case 1:
>>> VF channel offer is received in time before hv_pci_resume() and there
>>> are no problems.
>>>
>>> Case 2:
>>> Resume proceeds just after getting ALLOFFERS_DELIVERED msg and a warning
>>> is printed that this VF channel is not present after resume.
>>> Then two scenarios can happen:
>>>     Case 2.1:
>>>     VF channel offer is received before hv_pci_resume() and things work
>>>     fine. Warning printed is spurious.
>>>     Case 2.2:
>>>     VM channel offer is not received before hv_pci_resume() and relid is
>>>     not yet restored by onoffer. This is a problem. Warning is printed in
>>>     this case for missing offer.
>>>
>>> I think it all depends on whether or not VFs are removed in local
>>> HyperV VMs. I'll try to get this information. Thanks for pointing this
>>> out.
>>>
>>> Regards,
>>> Naman
>>>
>>
>> Hi Michael,
>> I discussed with Dexuan and we tried these scenarios. Here are the
>> observations:
>>
>> For the two ways of host initiated hibernation:
>>
>> #1: Invoke-Hibernate $vm -Device (Uses the guest shutdown component)
>> OR
>> #2: Invoke-Hibernate $vm -ComputerSystem (Uses the RequestStateChange
>> ability)
> 
> Question:  What Powershell module provides "Invoke-Hibernate"? It's not
> present on my Windows 11 system that is running Hyper-V, and I can't
> find any documentation about it on the web.  Or maybe Invoke-Hibernate
> is a Powershell *script*?

Powertest is one of the internal packages, which has some commands to
trigger host-initiated hibernation. I should probably have mentioned
that in my original comment.

> 
>>
>> #1 does not remove the VF before sending the hibernate message to the VM
>> via hv_utils, but #2 does.
>>
>> With both #1 and #2, during resume, the host offers the vPCI vmbus
>> device before the vmbus_onoffers_delivered() is called. Whether or not
>> VFs are removed doesn't matter here, because during resume the first
>> fresh kernel always requests the VF device, meaning it has become a
>> boot-time device when the 'old' kernel is resuming back. So the issue we
>> are discussing will not happen in practice and the patch won't break
>> things and won't print spurious warnings. If its OK, please let me know,
>> I'll then proceed with v3.
>>
> 
> Ah, this is interesting. I'm assuming these are the details:
> 
> 1)  VM boots with the intent of resuming from hibernation (though
> Hyper-V doesn't know about that intent)
> 2)  Original fresh kernel is loaded and begins initialization
> 3)  VMBus offers come in for boot-time devices, which excludes SR-IOV VFs.
> 4)  ALLOFFERS_DELIVERED message comes in
> 5)  The storvsc driver initializes for the virtual disks on the VM
> 6)  Kernel initialization code finds and reads the swap space to see if a
> hibernation image is present. If so, it reads in the hibernation image.
> 7)  The suspend sequence is initiated (just like during hibernation)
> to shutdown the VMBus devices and terminate the VMBus connection.
> 8)  Control is transferred to the previously read-in hibernation image
> 9)  The hibernation image runs the resume sequence, which
> initiates a new VMBus connection and requests offers
> 10) VMBus offers come in for whatever VMBus devices were present
> when Step 7 initiated the suspend sequence. If a VF device was present
> at that time, an offer for that VF device will come in and will match up
> with the VF that was present in the VM at the time of hibernation.
> 11) ALLOFFERS_DELIVERED message comes in again for the
> newly initiated VMBus connection.
> 

3), 4) works differently IMO. There is no request_for_offers, or 
ALLOFFERS_DELIVERED for fresh kernel. Otherwise on adding the prints in
kernel, we should have seen these function calls *twice* in one 
hibernation-resume cycle. But that is not the case.

When the older/original kernel boots up, and requests offers, it gets 
those VF offers again as part of boot time offers, and then
ALLOFFERS_DELIVERED msg comes. I'm still trying to figure out how fresh
kernel requests for VF offers or if it gets those offers automatically
from the host. I will update my findings so that it can be put up in
documentation which you mentioned.

> The netvsc driver gets initialized *after* step 4, but we don't know
> exactly *when* relative to the storvsc driver. The netvsc driver must
> tell Hyper-V that it can handle an SR-IOV VF, and the VF offer is sent
> sometime after that. While this netvsc/VF sequence is happening, the
> storvsc driver is reading the hibernation image from swap (Step 6).
> 

Maybe this is how fresh kernel gets the offers for VF devices.

> I think the sequence you describe works when reading the
> hibernation image from swap takes 10's of seconds, or even several
> minutes in an Azure VM with a remote disk. That gives plenty
> of time for the VF to get initialized and be fully present when Step 7
> starts. But there's no *guarantee* that the VF is initialized by then.
> It's also not clear to me what action by the guest causes Hyper-V to
> treat the VF as "added to the VM" so that in Step 10 the VF offer is
> sent before ALLOFFERS_DELIVERED.
> 
> The sequence you describe also happens in an Azure VM, even if
> the VF is removed before hibernation. When the VF offer arrives
> during Step 10, it doesn't match with any VFs that were in the VM
> at the time of hibernation. It's treated as a new device, just like it
> would be if the offer arrived after ALLOFFERS_DELIVERED.
> 
> But it seems like there's still the risk of having a fast swap disk
> and a small hibernation image that can be read in a shorter amount
> of time than it takes to initialize the VF to the point that Hyper-V
> treats it as added to the VM. Without knowing what that point is,
> it's hard to assess the likelihood of that happening. Or maybe there's
> an interlock I'm not aware of that ensures Step 7 can't proceed
> while the netvsc/VF sequence is in progress.
> 
> So maybe it's best to proceed with this patch, and deal with the
> risk later when/if it becomes reality. I'm OK if you want to do
> that. This has been an interesting discussion that I'll try to capture
> in some high-level documentation about how Linux guests on
> Hyper-V do hibernation!
> 
> Michael



I have sent v3 with the changes we discussed.

Regards,
Naman

