Return-Path: <linux-hyperv+bounces-4619-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EB9A68DEA
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 14:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9A11734FC
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5D255E44;
	Wed, 19 Mar 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sWlthcVc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800E6A29;
	Wed, 19 Mar 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391364; cv=none; b=f9i1fjJgCwdAYhr0HyNAOWbgGT9JiwISE7hMhVzN8e45dPk95JRQjdt/uhgsXD/Tc2We/N2yoOqoyWwvhaHgQUNCPhUhYWFEZ2dG2B4SkKJm8nYbzbp9woEDtE3qbbPGIluIHXfJn4DGDZYtXhs1ckgEBics2CGmQLG7q69z/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391364; c=relaxed/simple;
	bh=KypB5mDXEO9iF8yhtBOBbPJHJr71kTyc1WA7BS3oD7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4KpeVQ7Sgnywm3LEvG2YXoJSyjcPy8Pw6bfnWOHmgtaDvV7lv28vNcsV5K8efPMESiVRw9fM2tQOJZZgb6nDMTJd4yxpI4Y/lQIHsmxudLqlD6DSsENPhuZivmXTTaEfQSt7XqPm6YhCiB3Yobln/fjhqYiEXvSzy4XsKu8PqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sWlthcVc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.161.209] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6A6532025379;
	Wed, 19 Mar 2025 06:35:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A6532025379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742391362;
	bh=ttIyDUl9pBvsbeNfa4fnyguAdFPyGWzSRD7Ms92MD0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sWlthcVcCUCr3BP+Vs2Xq1K6zYqNUveWDSI6SIvEO4b2w7EdtdHS4iyMiDb9zu+4r
	 dIfIN5fc1SSqrFrmz/XONBuoad9mrMDzHW8ai+TxmQaPz51YNwe8mUa2sVa/WMDiJy
	 WgYjaQ1AiPhu6Q0WgyMadzIYclJIlWHo+eBHpXxA=
Message-ID: <2b09fa80-7b2f-4eb2-b059-d16d69ee8f0c@linux.microsoft.com>
Date: Wed, 19 Mar 2025 19:05:56 +0530
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <2025031859-overwrite-tidy-f8ef@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/18/2025 6:58 PM, Greg Kroah-Hartman wrote:
> On Tue, Mar 18, 2025 at 11:45:58AM +0530, Naman Jain wrote:
>> On regular bootup, devices get registered to vmbus first, so when
>> uio_hv_generic driver for a particular device type is probed,
>> the device is already initialized and added, so sysfs creation in
>> uio_hv_generic probe works fine. However, when device is removed
>> and brought back, the channel rescinds and device again gets
>> registered to vmbus. However this time, the uio_hv_generic driver is
>> already registered to probe for that device and in this case sysfs
>> creation is tried before the device gets initialized completely.
>>
>> Fix this by moving the core logic of sysfs creation for ring buffer,
>> from uio_hv_generic to HyperV's vmbus driver, where rest of the sysfs
>> attributes for the channels are defined. While doing that, make use
>> of attribute groups and macros, instead of creating sysfs directly,
>> to ensure better error handling and code flow. While at it, configure
>> size of ring sysfs based on ring buffer's actual size and not 2MB default.
> 
> When you say stuff like "while at it..." that's a huge hint that the
> patch should be broken up into smaller pieces and made a patch series.
> 

I should have done that. I'll take care of it in next version.

>> Problem path:
>> vmbus_device_register
>>      device_register
>>          uio_hv_generic probe
>>                      sysfs_create_bin_file (fails here)
> 
> Why does it fail?

It fails because device kobj is not yet initialized. Will add more details.

> 
>>          kset_create_and_add (dependency)
>>          vmbus_add_channel_kobj (dependency)
> 
> I don't understand this "graph", sorry.
> 

I will revise the commit msg accordingly. Thanks.

>> +/*
>> + * hv_create_ring_sysfs - create ring sysfs entry corresponding to ring buffers for a channel
>> + */
> 
> Kerneldoc?

Documentation of the ring sysfs is present here -
Documentation/ABI/stable/sysfs-bus-vmbus

What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/ring
Date:           January. 2018
KernelVersion:  4.16
Contact:        Stephen Hemminger <sthemmin@microsoft.com>
Description:    Binary file created by uio_hv_generic for ring buffer
Users:          Userspace drivers

I should probably change the description, to reflect that it's 
visibility is controlled by uio_hv_generic, but it's created by hyperV 
drivers.

Please correct me if I misunderstood your comment.

> 
>> +int hv_create_ring_sysfs(struct vmbus_channel *channel,
>> +			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
>> +						    struct vm_area_struct *vma))
>> +{
>> +	struct kobject *kobj = &channel->kobj;
>> +
>> +	channel->mmap_ring_buffer = hv_mmap_ring_buffer;
>> +	channel->ring_sysfs_visible = true;
>> +	return sysfs_update_group(kobj, &vmbus_chan_group);
>> +}
>> +EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);
> 
> You just raced userspace and created a file without telling it that it
> showed up, right?  Something still feels really wrong here.
> 
> greg k-h

 From use-case POV, we needed to have uio_hv_generic control the 
visibility of this ring sysfs node, because the same device (HV_NIC) is 
used by either hv_netvsc or uio_hv_generic at any given point of time. 
We didn't want to expose ring buffer through sysfs when hv_netvsc is 
using it. That's the reason why uio_hv_generic was creating sysfs in the 
first place.

DPDK, which uses this ring sysfs, checks for its presence for primary 
channel but for secondary channels, it additionally does mmap() of this 
ring. That's where it becomes more important, not to expose ring buffer 
when uio_hv_generic is not bind to the device.

DPDK runs after uio_hv_generic probe is complete, so I am not sure if 
this race can happen, in practice. I'll try to gather more information 
around it.

Regards,
Naman

