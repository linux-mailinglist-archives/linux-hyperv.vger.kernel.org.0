Return-Path: <linux-hyperv+bounces-4917-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA99A8A36F
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 17:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E493A7DCA
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12620E003;
	Tue, 15 Apr 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jYUT5lLN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F143B1F4622;
	Tue, 15 Apr 2025 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732465; cv=none; b=JT8blZAoTeLeEI+gMHCv52BgQ4Z8OeMx7GVb7bnpNbmZYO+YeVuhUoQKnLJgGW2L5dKQ+id/xdyfTqwZmKPhMGBzKuO1Dn2DgeghDKauJBGN5FfYJIpQksHcwqpXdMVVuuXhs7xg+NhfmJr58suY485WcYI8JPRpxQ8S9vj2vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732465; c=relaxed/simple;
	bh=LSLbk51kH8F5qyOJzFmFGWhuZwgYpItKXvCuFHph0bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DT2hZtPSACgSMymWpQlNlNqw4lt/6wAQmiUqZCRB/pegePVGO+7LxlmnSrABqBV38hwUfkGyMHDu3JWPIvELEjjH5XU4XxPlz68YwxA4FHmK1FLHF1mdkpQ07/KrIYR7V4G+g/hLM5z9xwHV5pHmFsjUUqohFZPAZ42PxIwn2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jYUT5lLN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.96.170] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 70D01210C444;
	Tue, 15 Apr 2025 08:54:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70D01210C444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744732463;
	bh=D86U+RjHrQIgQJficqmYAFKe44MOHCmygYqf7pnRLJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jYUT5lLNNPaGdGMd07wKyGVW8bZr1XbnrhRjErpsqDjlhymwE3rejd7J48GFP+Dut
	 O7Xx4XAU9ZRGOtGBJG1Z1/izSp71wX75mXcn/QrwOS/r92dJOL4+sBAhSwG7Jp+v5I
	 ELje62XnGnx5zw0Cw+vclKPGpLylWau/GbNEapsU=
Message-ID: <ca303616-750d-485d-bf3c-8a4106121aec@linux.microsoft.com>
Date: Tue, 15 Apr 2025 21:24:16 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250410060847.82407-1-namjain@linux.microsoft.com>
 <20250410060847.82407-2-namjain@linux.microsoft.com>
 <2025041527-cesarean-facial-cdca@gregkh>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <2025041527-cesarean-facial-cdca@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/15/2025 8:40 PM, Greg Kroah-Hartman wrote:
> On Thu, Apr 10, 2025 at 11:38:46AM +0530, Naman Jain wrote:
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
>>   drivers/uio/uio_hv_generic.c |  39 ++++++-------
>>   include/linux/hyperv.h       |   6 ++
>>   4 files changed, 138 insertions(+), 23 deletions(-)
> 
> Always run checkpatch on a patch before submitting it for review :(
> 

Hi Greg,
I verified again and I could not see checkpatch warnings with patch 1,2.
There was a warning regarding length of characters for link to previous
versions in the cover letter but I ignored it.

I tried on latest linux-next tip with this series fetched from lore 
using b4. I'm sorry, if I am missing something, but can you please try 
again.

Thanks,
Naman

