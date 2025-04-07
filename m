Return-Path: <linux-hyperv+bounces-4803-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6165A7D858
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Apr 2025 10:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F633188F516
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Apr 2025 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4422A4D5;
	Mon,  7 Apr 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MmE4rd7S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221F9225764;
	Mon,  7 Apr 2025 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015471; cv=none; b=WFXWm8L7n0+2me4TV3HeZLqcJPkM+C15E8E22soSlSMCm9tQp0tuDeKVJC8vPiWNIJf3ALPsGY4JfYEDGv/jFvvwLKR2n3TZ8deh3GOWoVqVcwuTl2KS+Z2o03LPwzcrRAedNKGECfnLRtClgEsaAicx+KeVcsyArRDYiy+BF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015471; c=relaxed/simple;
	bh=ffFvuFZFzZHDUMQg9xqNBt6xuLxJliri+ipKxQpx4a0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SKHg+MAc9fmnJlHZz0QR/X1WedU+UBgnZdRweTl5hqZhGg+LUP976zbUjdswde1Fu4ritcTVHOMFpm/soryciCUeJCqkajx9SapZSBOGHduRcMJqPX0HA9Q/lE5xKHh3wm6UgQL7yZ91jp/ijiO4aQSVvgeV0eHg2P00kFE1zds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MmE4rd7S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id EF2EE2113E70;
	Mon,  7 Apr 2025 01:37:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF2EE2113E70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744015067;
	bh=IMf6zfyOKzO3PayNMjkkAfLVipscVQ5401VbcJCk+nM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=MmE4rd7SzdqG38JRF7f8bd5bO27ZbsuHr4a0kweCf9TOL3UWwp0cv2XKTSBw2NBCG
	 vfKbICbblvJV8q8ddljDCI8SF8tgRcmsI9DcckJ4DGOx5OkEu8jHMQYtgVar/s5xL/
	 KYewhl6WBFxFU+mbUG7T+1+SOqrucRwFjq07gvq4=
Message-ID: <fdec53a0-efcc-4047-b809-d201f3a48005@linux.microsoft.com>
Date: Mon, 7 Apr 2025 14:07:43 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
From: Naman Jain <namjain@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@kernel.org" <stable@kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20250328052745.1417-1-namjain@linux.microsoft.com>
 <20250328052745.1417-2-namjain@linux.microsoft.com>
 <SN6PR02MB4157C74E0E83E63175278153D4A22@SN6PR02MB4157.namprd02.prod.outlook.com>
 <32de9597-d609-4e12-8219-ea7205bdc7d8@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <32de9597-d609-4e12-8219-ea7205bdc7d8@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/31/2025 11:08 AM, Naman Jain wrote:
> 
> 
> On 3/30/2025 9:05 PM, Michael Kelley wrote:
>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, March 
>> 27, 2025 10:28 PM
>>>
>>> On regular bootup, devices get registered to VMBus first, so when
>>> uio_hv_generic driver for a particular device type is probed,
>>> the device is already initialized and added, so sysfs creation in
>>> uio_hv_generic probe works fine. However, when device is removed
>>> and brought back, the channel rescinds and device again gets
>>> registered to VMBus. However this time, the uio_hv_generic driver is
>>> already registered to probe for that device and in this case sysfs
>>> creation is tried before the device's kobject gets initialized
>>> completely.
>>>
>>> Fix this by moving the core logic of sysfs creation for ring buffer,
>>> from uio_hv_generic to HyperV's VMBus driver, where rest of the sysfs
>>> attributes for the channels are defined. While doing that, make use
>>> of attribute groups and macros, instead of creating sysfs directly,
>>> to ensure better error handling and code flow.
>>>
>>> Problem path:
>>> vmbus_process_offer (new offer comes for the VMBus device)
>>>    vmbus_add_channel_work
>>>      vmbus_device_register
>>>        |-> device_register
>>>        |     |...
>>>        |     |-> hv_uio_probe
>>>        |           |...
>>>        |           |-> sysfs_create_bin_file (leads to a warning as
>>>        |                 primary channel's kobject, which is used to
>>>        |                 create sysfs is not yet initialized)
>>>        |-> kset_create_and_add
>>>        |-> vmbus_add_channel_kobj (initialization of primary channel's
>>>                                    kobject happens later)
>>>
>>> Above code flow is sequential and the warning is always reproducible in
>>> this path.
>>>
>>> Fixes: 9ab877a6ccf8 ("uio_hv_generic: make ring buffer attribute for 
>>> primary channel")
>>> Cc: stable@kernel.org
>>> Suggested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>>> ---
>>>   drivers/hv/hyperv_vmbus.h    |   6 ++
>>>   drivers/hv/vmbus_drv.c       | 110 ++++++++++++++++++++++++++++++++++-
>>>   drivers/uio/uio_hv_generic.c |  33 +++++------
>>>   include/linux/hyperv.h       |   6 ++
>>>   4 files changed, 134 insertions(+), 21 deletions(-)
>>>
>>
>> [snip]
>>
>>> +/**
>>> + * hv_create_ring_sysfs() - create "ring" sysfs entry corresponding 
>>> to ring buffers for a channel.
>>> + * @channel: Pointer to vmbus_channel structure
>>> + * @hv_mmap_ring_buffer: function pointer for initializing the 
>>> function to be called on mmap of
>>> + *                       channel's "ring" sysfs node, which is for 
>>> the ring buffer of that channel.
>>> + *                       Function pointer is of below type:
>>> + *                       int (*hv_mmap_ring_buffer)(struct 
>>> vmbus_channel *channel,
>>> + *                                                  struct 
>>> vm_area_struct *vma))
>>> + *                       This has a pointer to the channel and a 
>>> pointer to vm_area_struct,
>>> + *                       used for mmap, as arguments.
>>> + *
>>> + * Sysfs node for ring buffer of a channel is created along with 
>>> other fields, however its
>>> + * visibility is disabled by default. Sysfs creation needs to be 
>>> controlled when the use-case
>>> + * is running.
>>> + * For example, HV_NIC device is used either by uio_hv_generic or 
>>> hv_netvsc at any given point of
>>> + * time, and "ring" sysfs is needed only when uio_hv_generic is 
>>> bound to that device. To avoid
>>> + * exposing the ring buffer by default, this function is reponsible 
>>> to enable visibility of
>>> + * ring for userspace to use.
>>> + * Note: Race conditions can happen with userspace and it is not 
>>> encouraged to create new
>>> + * use-cases for this. This was added to maintain backward 
>>> compatibility, while solving
>>> + * one of the race conditions in uio_hv_generic while creating sysfs.
>>> + *
>>> + * Returns 0 on success or error code on failure.
>>> + */
>>> +int hv_create_ring_sysfs(struct vmbus_channel *channel,
>>> +             int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
>>> +                            struct vm_area_struct *vma))
>>> +{
>>> +    struct kobject *kobj = &channel->kobj;
>>> +    struct vmbus_channel *primary_channel = channel->primary_channel ?
>>> +        channel->primary_channel : channel;
>>> +
>>> +    channel->mmap_ring_buffer = hv_mmap_ring_buffer;
>>> +    channel->ring_sysfs_visible = true;
>>> +
>>> +    /*
>>> +     * Skip updating the sysfs group if the primary channel is not 
>>> yet initialized and sysfs
>>> +     * group is not yet created. In those cases, the 'ring' will be 
>>> created later in
>>> +     * vmbus_device_register() -> vmbus_add_channel_kobj().
>>> +     */
>>> +    if  (!primary_channel->device_obj->channels_kset)
>>> +        return 0;
>>
>> This test doesn't accomplish what you want. It tests if the "channels" 
>> directory
>> has been created, but not if the numbered subdirectory for this 
>> channel has been
>> created. sysfs_update_group() operates on the numbered subdirectory and
>> could still fail because it hasn't been created yet.
>>
>> My recommendation is to not try to do a test, and just let 
>> sysfs_update_group()
>> fail in that case (and ignore the error).
>>
>> Michael
>>
> 
> Thanks Michael. Will remove it.
> 
> Regards,
> Naman

Just to let you know, I'll wait till the end of merge window and a few 
more days before sending the next version. Meanwhile if there are any 
further comments, I'll take them up together.

Regards,
Naman

> 
>>> +
>>> +    return sysfs_update_group(kobj, &vmbus_chan_group);
>>> +}
>>> +EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);
> 


