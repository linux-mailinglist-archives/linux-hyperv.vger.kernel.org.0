Return-Path: <linux-hyperv+bounces-4729-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D4A75E90
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 07:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE041665C5
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 05:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988BE29CEB;
	Mon, 31 Mar 2025 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Icr85zrj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0720917A2E2;
	Mon, 31 Mar 2025 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743399529; cv=none; b=DoVRUx0y+rrg5Xoj5zMaAQ145GBX2f7Y+QqQhPEDrLSf3KLAbzM7iB9UN0jcTT2UbOYdIbtidlAOTOMxk1JEfFUzXVE2jo5L7zCiEFhOp2oTfgyjkQ8ePzY9t3mjP5ZOlz9K9Qk99SoOEp+kS0QJgiCHjNJ1NTILiqUUL5erO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743399529; c=relaxed/simple;
	bh=O+nGkDYvtL7d3Qqm+1UtASwmM5sd23/5AKPzIlKKH14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECm1KpuNKeDENrDdGbLf1mRJvpngYv9n0IPEaF6sG5vdLx7wQQ03LFzEdW0Chm1lKeg25AFDb8MCQUcezQPAyffunh9kLPzijTmth708yWLmqg0jP1+BX5hnJa/+9G4A2t0EGloyu1+rKDnTAi+aT5F/hg0c4a4QwWTNoMSyPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Icr85zrj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B0282111439;
	Sun, 30 Mar 2025 22:38:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B0282111439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743399521;
	bh=Ga+JCIeKoiFxHXkSSUu0P9tSi9JTYZkWrviPT8lbSaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Icr85zrj5xsXnf7Gyrpdb9y6S9lOLkFGBRaQtrlBEHyPnyEv2SKPtbOIuTsGXPeSX
	 mC54kMNRj0rNjatFaqG8FkMBqyWJ6Gvt+AASzNMJ0n3KoK2xQdl7SKnOcXzbWieRZC
	 0KbXu+eUE+7xC5ZYEAC7dtlLbBPlXuw/mDY+rQf4=
Message-ID: <32de9597-d609-4e12-8219-ea7205bdc7d8@linux.microsoft.com>
Date: Mon, 31 Mar 2025 11:08:35 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157C74E0E83E63175278153D4A22@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/30/2025 9:05 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, March 27, 2025 10:28 PM
>>
>> On regular bootup, devices get registered to VMBus first, so when
>> uio_hv_generic driver for a particular device type is probed,
>> the device is already initialized and added, so sysfs creation in
>> uio_hv_generic probe works fine. However, when device is removed
>> and brought back, the channel rescinds and device again gets
>> registered to VMBus. However this time, the uio_hv_generic driver is
>> already registered to probe for that device and in this case sysfs
>> creation is tried before the device's kobject gets initialized
>> completely.
>>
>> Fix this by moving the core logic of sysfs creation for ring buffer,
>> from uio_hv_generic to HyperV's VMBus driver, where rest of the sysfs
>> attributes for the channels are defined. While doing that, make use
>> of attribute groups and macros, instead of creating sysfs directly,
>> to ensure better error handling and code flow.
>>
>> Problem path:
>> vmbus_process_offer (new offer comes for the VMBus device)
>>    vmbus_add_channel_work
>>      vmbus_device_register
>>        |-> device_register
>>        |     |...
>>        |     |-> hv_uio_probe
>>        |           |...
>>        |           |-> sysfs_create_bin_file (leads to a warning as
>>        |                 primary channel's kobject, which is used to
>>        |                 create sysfs is not yet initialized)
>>        |-> kset_create_and_add
>>        |-> vmbus_add_channel_kobj (initialization of primary channel's
>>                                    kobject happens later)
>>
>> Above code flow is sequential and the warning is always reproducible in
>> this path.
>>
>> Fixes: 9ab877a6ccf8 ("uio_hv_generic: make ring buffer attribute for primary channel")
>> Cc: stable@kernel.org
>> Suggested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/hyperv_vmbus.h    |   6 ++
>>   drivers/hv/vmbus_drv.c       | 110 ++++++++++++++++++++++++++++++++++-
>>   drivers/uio/uio_hv_generic.c |  33 +++++------
>>   include/linux/hyperv.h       |   6 ++
>>   4 files changed, 134 insertions(+), 21 deletions(-)
>>
> 
> [snip]
> 
>> +/**
>> + * hv_create_ring_sysfs() - create "ring" sysfs entry corresponding to ring buffers for a channel.
>> + * @channel: Pointer to vmbus_channel structure
>> + * @hv_mmap_ring_buffer: function pointer for initializing the function to be called on mmap of
>> + *                       channel's "ring" sysfs node, which is for the ring buffer of that channel.
>> + *                       Function pointer is of below type:
>> + *                       int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
>> + *                                                  struct vm_area_struct *vma))
>> + *                       This has a pointer to the channel and a pointer to vm_area_struct,
>> + *                       used for mmap, as arguments.
>> + *
>> + * Sysfs node for ring buffer of a channel is created along with other fields, however its
>> + * visibility is disabled by default. Sysfs creation needs to be controlled when the use-case
>> + * is running.
>> + * For example, HV_NIC device is used either by uio_hv_generic or hv_netvsc at any given point of
>> + * time, and "ring" sysfs is needed only when uio_hv_generic is bound to that device. To avoid
>> + * exposing the ring buffer by default, this function is reponsible to enable visibility of
>> + * ring for userspace to use.
>> + * Note: Race conditions can happen with userspace and it is not encouraged to create new
>> + * use-cases for this. This was added to maintain backward compatibility, while solving
>> + * one of the race conditions in uio_hv_generic while creating sysfs.
>> + *
>> + * Returns 0 on success or error code on failure.
>> + */
>> +int hv_create_ring_sysfs(struct vmbus_channel *channel,
>> +			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
>> +						    struct vm_area_struct *vma))
>> +{
>> +	struct kobject *kobj = &channel->kobj;
>> +	struct vmbus_channel *primary_channel = channel->primary_channel ?
>> +		channel->primary_channel : channel;
>> +
>> +	channel->mmap_ring_buffer = hv_mmap_ring_buffer;
>> +	channel->ring_sysfs_visible = true;
>> +
>> +	/*
>> +	 * Skip updating the sysfs group if the primary channel is not yet initialized and sysfs
>> +	 * group is not yet created. In those cases, the 'ring' will be created later in
>> +	 * vmbus_device_register() -> vmbus_add_channel_kobj().
>> +	 */
>> +	if  (!primary_channel->device_obj->channels_kset)
>> +		return 0;
> 
> This test doesn't accomplish what you want. It tests if the "channels" directory
> has been created, but not if the numbered subdirectory for this channel has been
> created. sysfs_update_group() operates on the numbered subdirectory and
> could still fail because it hasn't been created yet.
> 
> My recommendation is to not try to do a test, and just let sysfs_update_group()
> fail in that case (and ignore the error).
> 
> Michael
> 

Thanks Michael. Will remove it.

Regards,
Naman

>> +
>> +	return sysfs_update_group(kobj, &vmbus_chan_group);
>> +}
>> +EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);


