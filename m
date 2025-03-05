Return-Path: <linux-hyperv+bounces-4223-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3ADA4F7A5
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 08:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557957A0866
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F11EA7C7;
	Wed,  5 Mar 2025 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="als1ojl5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ED61E5B98;
	Wed,  5 Mar 2025 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158372; cv=none; b=rguvpbCsp9RNT3lBCDj8cFBW4ZavDWaa4ykHHvaAxcnWpUtUHCAiFBQnjdsU9KXJ12r68n6u98eJDxe0U1ApAnCVx0I7oGa1UXv8jEVUkc30RUlZ1wOmGMegdCiAqxN2T+G649z7iDj4RD2AFUIy8S5l306COWdOUK9QsxrIHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158372; c=relaxed/simple;
	bh=FM1e1E0SF3Dgi2OfcdcpnZukmIqVm/iKHC5Vg/fliZc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iHJw+zwIi+W6jv0k9n+izDENqvU8sKYkTxWtimou9EOkKQX6TS3idDoe+p8Gnh/cEc20GC7F6zK7d8lvsPeZA1YUZuAgO3p25lQxsJx3f8m8qijOYv8TIPBpT4CC8lq6kUHz/fe/+9vxagIG0flaPALFwKEVP7rccpjxHkd3fGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=als1ojl5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.69.26] (unknown [167.220.238.90])
	by linux.microsoft.com (Postfix) with ESMTPSA id BCE532112508;
	Tue,  4 Mar 2025 23:06:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCE532112508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741158370;
	bh=QyCm+Y8e7E2HICPYm7By9xtYFPVDId/Msyeq0pbfnl4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=als1ojl5ZC1WP927xsSYtyulZlWgHYdlQVT19wwkoMrtNuAi7bNSMsiJ2F4bvPjP/
	 7fW0naJgvIIzl22WGy91MLOOfMjhuUyi+LNaeRuJYaYPPE+dxjTHC0bOobxMj7SaM5
	 s9riOAUWgGmvlhcSOY6a3lzHHu/sI0nnj5HBTixM=
Message-ID: <5709eac1-a828-4ab3-afc2-8f1790d5f61f@linux.microsoft.com>
Date: Wed, 5 Mar 2025 12:36:06 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio_hv_generic: Fix sysfs creation path for ring buffer
From: Naman Jain <namjain@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>
References: <20250225052001.2225-1-namjain@linux.microsoft.com>
 <2025022504-diagnosis-outsell-684c@gregkh>
 <9ee65987-4353-42c6-b517-d6f52428f718@linux.microsoft.com>
 <2025022515-lasso-carrot-4e1d@gregkh>
 <541c63d6-8ae6-4a32-8a02-d86eea64827e@linux.microsoft.com>
 <2025022627-deflate-pliable-6da0@gregkh>
 <0a694947-809d-48b2-9138-d3f6175fe09d@linux.microsoft.com>
 <2025022643-predict-hedge-8c77@gregkh>
 <960501c2-5ab2-4c81-86ac-a4477c0f708a@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <960501c2-5ab2-4c81-86ac-a4477c0f708a@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/27/2025 11:54 AM, Naman Jain wrote:
> 
> 
> On 2/26/2025 8:03 PM, Greg Kroah-Hartman wrote:
>> On Wed, Feb 26, 2025 at 05:51:46PM +0530, Naman Jain wrote:
>>>
>>>
>>> On 2/26/2025 3:33 PM, Greg Kroah-Hartman wrote:
>>>> On Wed, Feb 26, 2025 at 10:43:41AM +0530, Naman Jain wrote:
>>>>>
>>>>>
>>>>> On 2/25/2025 2:09 PM, Greg Kroah-Hartman wrote:
>>>>>> On Tue, Feb 25, 2025 at 02:04:43PM +0530, Naman Jain wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/25/2025 11:42 AM, Greg Kroah-Hartman wrote:
>>>>>>>> On Tue, Feb 25, 2025 at 10:50:01AM +0530, Naman Jain wrote:
>>>>>>>>> On regular bootup, devices get registered to vmbus first, so when
>>>>>>>>> uio_hv_generic driver for a particular device type is probed,
>>>>>>>>> the device is already initialized and added, so sysfs creation in
>>>>>>>>> uio_hv_generic probe works fine. However, when device is removed
>>>>>>>>> and brought back, the channel rescinds and device again gets
>>>>>>>>> registered to vmbus. However this time, the uio_hv_generic 
>>>>>>>>> driver is
>>>>>>>>> already registered to probe for that device and in this case sysfs
>>>>>>>>> creation is tried before the device gets initialized completely.
>>>>>>>>>
>>>>>>>>> Fix this by moving the core logic of sysfs creation for ring 
>>>>>>>>> buffer,
>>>>>>>>> from uio_hv_generic to HyperV's vmbus driver, where rest of the 
>>>>>>>>> sysfs
>>>>>>>>> attributes for the channels are defined. While doing that, make 
>>>>>>>>> use
>>>>>>>>> of attribute groups and macros, instead of creating sysfs 
>>>>>>>>> directly,
>>>>>>>>> to ensure better error handling and code flow.
>>>
>>> <snip>
>>>
>>>>>>>>> +static int hv_mmap_ring_buffer_wrapper(struct file *filp, 
>>>>>>>>> struct kobject *kobj,
>>>>>>>>> +                       const struct bin_attribute *attr,
>>>>>>>>> +                       struct vm_area_struct *vma)
>>>>>>>>> +{
>>>>>>>>> +    struct vmbus_channel *channel = container_of(kobj, struct 
>>>>>>>>> vmbus_channel, kobj);
>>>>>>>>> +
>>>>>>>>> +    if (!channel->mmap_ring_buffer)
>>>>>>>>> +        return -ENODEV;
>>>>>>>>> +    return channel->mmap_ring_buffer(channel, vma);
>>>>>>>>
>>>>>>>> What is preventing mmap_ring_buffer from being set to NULL right 
>>>>>>>> after
>>>>>>>> checking it and then calling it here?  I see no locks here or 
>>>>>>>> where you
>>>>>>>> are assigning this variable at all, so what is preventing these 
>>>>>>>> types of
>>>>>>>> races?
>>>>>>>>
>>>>>>>> thanks,
>>>>>>>>
>>>>>>>> greg k-h
>>>>>>>
>>>>>>> Thank you so much for reviewing.
>>>>>>> I spent some time to understand if this race condition can happen 
>>>>>>> and it
>>>>>>> seems execution flow is pretty sequential, for a particular 
>>>>>>> channel of a
>>>>>>> device.
>>>>>>>
>>>>>>> Unless hv_uio_remove (which makes channel->mmap_ring_buffer NULL) 
>>>>>>> can be
>>>>>>> called in parallel to hv_uio_probe (which had set
>>>>>>> channel->mmap_ring_buffer to non NULL), I doubt race can happen 
>>>>>>> here.
>>>>>>>
>>>>>>> Code Flow: (R, W-> Read, Write to channel->mmap_ring_buffer)
>>>>>>>
>>>>>>> vmbus_device_register
>>>>>>>      device_register
>>>>>>>        hv_uio_probe
>>>>>>>       hv_create_ring_sysfs (W to non NULL)
>>>>>>>            sysfs_update_group
>>>>>>>              vmbus_chan_attr_is_visible (R)
>>>>>>>      vmbus_add_channel_kobj
>>>>>>>        sysfs_create_group
>>>>>>>          vmbus_chan_attr_is_visible  (R)
>>>>>>>          hv_mmap_ring_buffer_wrapper (critical section)
>>>>>>>
>>>>>>> hv_uio_remove
>>>>>>>      hv_remove_ring_sysfs (W to NULL)
>>>>>>
>>>>>> Yes, and right in here someone mmaps the file.
>>>>>>
>>>>>> I think you can race here, no locks at all feels wrong.
>>>>>>
>>>>>> Messing with sysfs groups and files like this is rough, and almost 
>>>>>> never
>>>>>> a good idea, why can't you just do this all at once with the default
>>>>>> groups, why is this being added/removed out-of-band?
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>
>>>>> The decision to avoid creating a "ring" sysfs attribute by default
>>>>> likely stems from a specific use case where it wasn't needed for every
>>>>> device. By creating it automatically, it keeps the uio_hv_generic
>>>>> driver simpler and helps prevent potential race conditions. 
>>>>> However, it
>>>>> has an added cost of having ring buffer for all the channels, where it
>>>>> is not required. I am trying to find if there are any more 
>>>>> implications
>>>>> of it.
>>>>
>>>> You do know about the "is_visable" attribute callback, right?  Why not
>>>> just use that instead of manually mucking around with the
>>>> adding/removing of sysfs attributes at all?  That is what it was
>>>> designed for.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> Hi Greg,
>>> Yes, I am utilizing that in my patch. For differentiating channels of a
>>> uio_hv_generic device, and for *selectively* creating sysfs, we
>>> introduced this field in channel struct "channel->mmap_ring_buffer",
>>> which we were setting only in uio_hv_generic. But, by the time we set
>>> this in uio_hv_generic driver, the sysfs creation has already gone
>>> through and sysfs doesn't get updated dynamically. That's where there
>>> was a need to call sysfs_update_group. I thought the better place to
>>> keep sysfs_update_group would be in vmbus driver, where we are creating
>>> the original sysfs entries, hence I had to add the wrapper functions.
>>> This led us to the race condition we are trying to address now.
>>>
>>>
>>> @@ -1838,6 +1872,10 @@ static umode_t vmbus_chan_attr_is_visible(struct
>>> kobject *kobj,
>>>            attr == &chan_attr_monitor_id.attr))
>>>           return 0;
>>>
>>> +    /* Hide ring attribute if channel's mmap_ring_buffer function is 
>>> not yet
>>> initialised */
>>> +    if (attr ==  &chan_attr_ring_buffer.attr && !channel- 
>>> >mmap_ring_buffer)
>>> +        return 0;
>>> +
>>>       return attr->mode;
>>
>> Ok, that's good.  BUT you need to change the detection of this to be
>> before the device is set up in the driver.  Why can't you do it in the
>> device creation logic itself instead of after-the-fact when you will
>> ALWAYS race with userspace?
>>
>> thanks,
>>
>> greg k-h
> 
> Sure, will check more on this. Thanks.
> 
> Regards,
> Naman
> 

Hi Greg,
I understand this is deviating from the discussions that we have had
till now, but I wanted to kindly request your opinion on the following
approach, which came up in one of our internal discussions.

By moving the sysfs creation logic from hv_uio_probe to hv_uio_open, I
believe we can address this problem. Here are some of the benefits of
this approach:

* This approach involves minimal changes and provides a localized
solution.

* Since the use-case of ring sysfs is specific to uio_hv_generic and
DPDK, this will give us the flexibility to modify it based on
requirements. For example, ring_buffer_bin_attr.size should depend on
the ring buffer's allocated size, which is easier to manage if the
current code resides in uio_hv_generic.

* The use-case of DPDK is such that at any given time, either the
hv_netvsc kernel driver or the userspace (DPDK) will be controlling this
HV_NIC device. We do not want to expose the ring buffer to userspace
when hv_netvsc is using the device. This is where the "awareness" of the
current user comes into play, and we need a way to control the
visibility of the "ring" sysfs from uio_hv_generic.


Alternatively, I could focus on resolving the race condition you
mentioned and proceed with refining the patch. This approach addresses
most of the general practice concerns you highlighted.

Regards,
Naman

