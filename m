Return-Path: <linux-hyperv+bounces-3335-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9129C835E
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Nov 2024 07:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FA12842B3
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Nov 2024 06:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856251E883C;
	Thu, 14 Nov 2024 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U4Xl6V+B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1968139D1B;
	Thu, 14 Nov 2024 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567220; cv=none; b=PuzbInt1UQsGIU0A0nOQrLnqWy1MVUn+IxKqkoZRTZ03kVc+b5LNEEa8zraJHWw3HPOA2HNUnnPVGBICgFrvV/0aTR/W1Ob9MmeqV4tV4dF8GwQYU6Ev4xFM/hv8jzNUak+sQWeQV5dFAOAlsZ60ULelxHbfweqF3DLqbGivyik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567220; c=relaxed/simple;
	bh=3E3RZts7S0yQ0tPNODlYreN6KeN+3CR5DvLxMRd6Lyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6H9olb1QtLTYH9zItpVo8eBjJNDt+aeBr7Q+RZOsUIcRm6iWZvRIa0ooU868+k/xCULEd5pnlAhymA5vUK2XHhbRmWwoytryBPoNxCYi5uC+lYqfp+5qBkABydk+DtkunGZoxIj12Gd/gMxRF3lqiIizDGi6EBtookUHL23JQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U4Xl6V+B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.72.143] (unknown [167.220.238.15])
	by linux.microsoft.com (Postfix) with ESMTPSA id E786220BEBF0;
	Wed, 13 Nov 2024 22:53:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E786220BEBF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731567218;
	bh=MdUW8Lh7BXRu49gIQ82FDqPpJrZCoQvzQQSSlOudE9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U4Xl6V+BzmpFA4E2EVq96K2wzSYwZF+jFJJa+yW/aW6o0HqG7FDA2q5HGx1mb7DXy
	 OjabUUVtvoVjz0Garsj/HUkMDFWKErVvL2uWjEdz4SUYPd521Z/2USUUiNqXl9ofBj
	 G6MFNH3ghfeAR54kvib3+IU7mpDMrJvgvDDf4C6s=
Message-ID: <e457a146-3154-4420-bac1-95cf0b33dec1@linux.microsoft.com>
Date: Thu, 14 Nov 2024 12:23:34 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <dc5b1aaf-62cc-49ea-9fc7-c07b3afbd714@linux.microsoft.com>
 <SN6PR02MB41574AC689EB671BA59679C7D45A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41574AC689EB671BA59679C7D45A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/13/2024 8:56 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, November 13, 2024 12:47 AM
>>
>> On 11/12/2024 8:43 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, November 10, 2024 9:44 PM
>>>>
>>>> On 11/7/2024 11:14 AM, Naman Jain wrote:
>>>>>
>>>>> On 11/1/2024 12:44 AM, Michael Kelley wrote:
>>>>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 29, 2024 1:02 AM
>>>>>>>
>>>
>>> [snip]

<snip>

>>>
>>> 1)  VM boots with the intent of resuming from hibernation (though
>>> Hyper-V doesn't know about that intent)
>>> 2)  Original fresh kernel is loaded and begins initialization
>>> 3)  VMBus offers come in for boot-time devices, which excludes SR-IOV VFs.
>>> 4)  ALLOFFERS_DELIVERED message comes in
>>> 5)  The storvsc driver initializes for the virtual disks on the VM
>>> 6)  Kernel initialization code finds and reads the swap space to see if a
>>> hibernation image is present. If so, it reads in the hibernation image.
>>> 7)  The suspend sequence is initiated (just like during hibernation)
>>> to shutdown the VMBus devices and terminate the VMBus connection.
>>> 8)  Control is transferred to the previously read-in hibernation image
>>> 9)  The hibernation image runs the resume sequence, which
>>> initiates a new VMBus connection and requests offers
>>> 10) VMBus offers come in for whatever VMBus devices were present
>>> when Step 7 initiated the suspend sequence. If a VF device was present
>>> at that time, an offer for that VF device will come in and will match up
>>> with the VF that was present in the VM at the time of hibernation.
>>> 11) ALLOFFERS_DELIVERED message comes in again for the
>>> newly initiated VMBus connection.
>>>
>>
>> 3), 4) works differently IMO. There is no request_for_offers, or
>> ALLOFFERS_DELIVERED for fresh kernel. Otherwise on adding the prints in
>> kernel, we should have seen these function calls *twice* in one
>> hibernation-resume cycle. But that is not the case.
>>

I was looking at the wrong place for fresh kernel logs. The sequence you
mentioned is indeed correct and aligns to my understanding and
experiments results. Kindly ignore my comment above.

>> When the older/original kernel boots up, and requests offers, it gets
>> those VF offers again as part of boot time offers, and then
>> ALLOFFERS_DELIVERED msg comes. I'm still trying to figure out how fresh
>> kernel requests for VF offers or if it gets those offers automatically
>> from the host. I will update my findings so that it can be put up in
>> documentation which you mentioned.

Fresh kernel does not seem to be getting these VF channel offers 
automatically, but resuming kernel does, when it calls request_for_offers().


Regards,
Naman

> 
> Hmmm. I'm not sure what might be happening. I'll be interested in
> what you find. I do indeed want to call out the details in my
> documentation. And I'll also try to repro myself.
> 
> Michael
> 
>>
>>> The netvsc driver gets initialized *after* step 4, but we don't know
>>> exactly *when* relative to the storvsc driver. The netvsc driver must
>>> tell Hyper-V that it can handle an SR-IOV VF, and the VF offer is sent
>>> sometime after that. While this netvsc/VF sequence is happening, the
>>> storvsc driver is reading the hibernation image from swap (Step 6).
>>>
>>
>> Maybe this is how fresh kernel gets the offers for VF devices.
>>
>>> I think the sequence you describe works when reading the
>>> hibernation image from swap takes 10's of seconds, or even several
>>> minutes in an Azure VM with a remote disk. That gives plenty
>>> of time for the VF to get initialized and be fully present when Step 7
>>> starts. But there's no *guarantee* that the VF is initialized by then.
>>> It's also not clear to me what action by the guest causes Hyper-V to
>>> treat the VF as "added to the VM" so that in Step 10 the VF offer is
>>> sent before ALLOFFERS_DELIVERED.
>>>
>>> The sequence you describe also happens in an Azure VM, even if
>>> the VF is removed before hibernation. When the VF offer arrives
>>> during Step 10, it doesn't match with any VFs that were in the VM
>>> at the time of hibernation. It's treated as a new device, just like it
>>> would be if the offer arrived after ALLOFFERS_DELIVERED.
>>>
>>> But it seems like there's still the risk of having a fast swap disk
>>> and a small hibernation image that can be read in a shorter amount
>>> of time than it takes to initialize the VF to the point that Hyper-V
>>> treats it as added to the VM. Without knowing what that point is,
>>> it's hard to assess the likelihood of that happening. Or maybe there's
>>> an interlock I'm not aware of that ensures Step 7 can't proceed
>>> while the netvsc/VF sequence is in progress.
>>>
>>> So maybe it's best to proceed with this patch, and deal with the
>>> risk later when/if it becomes reality. I'm OK if you want to do
>>> that. This has been an interesting discussion that I'll try to capture
>>> in some high-level documentation about how Linux guests on
>>> Hyper-V do hibernation!
>>>
>>> Michael
>>
>>
>>
>> I have sent v3 with the changes we discussed.
>>
>> Regards,
>> Naman


