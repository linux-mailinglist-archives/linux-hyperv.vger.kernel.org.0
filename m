Return-Path: <linux-hyperv+bounces-4639-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D4A6A10A
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 09:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757D23B2C1D
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD12205E3E;
	Thu, 20 Mar 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VlfTlwB6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673B01DF248;
	Thu, 20 Mar 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458647; cv=none; b=r8uXZuuqE9YHhzlLqoyOWaVVn+1Rj8Fko2q66vvzWHuHi7Ct2LfwamyCiGzj/IPjBfXxP+jTT3uZJvdzmGBvZbei9KhGUPsvnjMBirBRkjfJ8a6dWCzRqmL2iI9sBkotXF30vdN3FfP/3P6gL/bKtgnqfvmwIrxoQFpc3Q0YULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458647; c=relaxed/simple;
	bh=R02fk1aNrcUVdzDlCBYTLwXrW2mT+IV1D/Zvo/mc4Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwHsn9N5jF3FyADWmN+WdPUvi4HIxDqiV48+APHBHj+bTKlH6K7zlI/WZduJ+URT6NapUQkxxVot2fa71LfWp4Bwe9ZALcTickxajF3hq9oE8IEK3Xft9AwJKrgNaGuSi1F8kmaNSVEfSwmh94wcMx1Vk9OoCbevNmoJdRAcYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VlfTlwB6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1F1502116B34;
	Thu, 20 Mar 2025 01:17:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F1502116B34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742458645;
	bh=AQRi9uQL203/5gLevlFcG3XGxd/uPrONV3CXSTwmPw8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VlfTlwB6NMlON0rKxDsXQTLkwVAqnp9LRvgpc+zb7OAJRX4e1nXBSuymad3kBj+OV
	 SR9/uBGLLEGIC7tJkkJoDcH5TjjbHPSCMKnB0pVih2xl8mu2ei43tiFGlllCHb1rMr
	 Nms9cc/JYvVCHwhMI3iZGz+Br+jSifaVGwPEspAI=
Message-ID: <8c3e2920-41a2-40df-9cbd-79c381aa7b4c@linux.microsoft.com>
Date: Thu, 20 Mar 2025 13:47:21 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250318061558.3294-1-namjain@linux.microsoft.com>
 <2025031859-overwrite-tidy-f8ef@gregkh>
 <2b09fa80-7b2f-4eb2-b059-d16d69ee8f0c@linux.microsoft.com>
 <2025031932-timid-xerox-7f0d@gregkh>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <2025031932-timid-xerox-7f0d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/2025 7:54 PM, Greg Kroah-Hartman wrote:
> On Wed, Mar 19, 2025 at 07:05:56PM +0530, Naman Jain wrote:
>> On 3/18/2025 6:58 PM, Greg Kroah-Hartman wrote:
>>>> +/*
>>>> + * hv_create_ring_sysfs - create ring sysfs entry corresponding to ring buffers for a channel
>>>> + */
>>>
>>> Kerneldoc?
>>
>> Documentation of the ring sysfs is present here -
>> Documentation/ABI/stable/sysfs-bus-vmbus
>>
>> What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/ring
>> Date:           January. 2018
>> KernelVersion:  4.16
>> Contact:        Stephen Hemminger <sthemmin@microsoft.com>
>> Description:    Binary file created by uio_hv_generic for ring buffer
>> Users:          Userspace drivers
>>
>> I should probably change the description, to reflect that it's visibility is
>> controlled by uio_hv_generic, but it's created by hyperV drivers.
>>
>> Please correct me if I misunderstood your comment.
> 
> I mean you are adding a comment here that is NOT in the correct
> kerneldoc fomat.

Thanks, I get it now. I'll make the changes.

> 
>>>> +int hv_create_ring_sysfs(struct vmbus_channel *channel,
>>>> +			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
>>>> +						    struct vm_area_struct *vma))
>>>> +{
>>>> +	struct kobject *kobj = &channel->kobj;
>>>> +
>>>> +	channel->mmap_ring_buffer = hv_mmap_ring_buffer;
>>>> +	channel->ring_sysfs_visible = true;
>>>> +	return sysfs_update_group(kobj, &vmbus_chan_group);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);
>>>
>>> You just raced userspace and created a file without telling it that it
>>> showed up, right?  Something still feels really wrong here.
>>>
>>> greg k-h
>>
>>  From use-case POV, we needed to have uio_hv_generic control the visibility
>> of this ring sysfs node, because the same device (HV_NIC) is used by either
>> hv_netvsc or uio_hv_generic at any given point of time. We didn't want to
>> expose ring buffer through sysfs when hv_netvsc is using it. That's the
>> reason why uio_hv_generic was creating sysfs in the first place.
>>
>> DPDK, which uses this ring sysfs, checks for its presence for primary
>> channel but for secondary channels, it additionally does mmap() of this
>> ring. That's where it becomes more important, not to expose ring buffer when
>> uio_hv_generic is not bind to the device.
>>
>> DPDK runs after uio_hv_generic probe is complete, so I am not sure if this
>> race can happen, in practice. I'll try to gather more information around it.
> 
> Please do, and document the heck out of why you are doing it this way
> and why there is no such race or issue, and why no one else should ever
> copy this pattern as an example of what to do for other drivers.
> 
> thanks,
> 
> greg k-h

I'll add the necessary comments to highlight these problems.

Thanks for reviewing.

Regards,
Naman

