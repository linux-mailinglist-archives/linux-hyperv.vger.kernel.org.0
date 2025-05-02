Return-Path: <linux-hyperv+bounces-5300-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF9AA6A61
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 08:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9691C1BA6710
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 06:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170EB1465A1;
	Fri,  2 May 2025 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ESYZ4B3F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E237083A;
	Fri,  2 May 2025 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746165671; cv=none; b=UNg6y0jsJxoFaqLkfm9wjdatzASlYUi23IDNr4BH/x8xma7vFEBaiCChUkXxS3J8fL11qdCrApQdOJqT0icuiQkfkMsmXzrU1PUz3cyn9pq4BV2zXFpTyB+lRFY38q1QFh2cdRulGTl/W2o8DIqOC7TNFqCn5euYCq1tW6uatcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746165671; c=relaxed/simple;
	bh=AVxBl5tihGLUMFHt3lxk0q44vNka5p+fcSzp6TxyzLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFYbaw5eYTsfDa8VfXmGLFTkEVx4S3vxKeeNeqnMj2eqG4hbbCSjj8N9Isyd2h614zhx2GR033Mc9HzKjhdxxKYO5EfZSJR/0MFD+Sz+SVJZLfLeZJ8JfLGHA4nWQT3L1a9W04Ty8A16/ga25pX96+e2SHCH/Gji822iDNPgcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ESYZ4B3F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.193.170] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 42434211159B;
	Thu,  1 May 2025 23:01:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42434211159B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746165668;
	bh=n6KFWWoXYHxscjPof2OutrHwg+xGPVvT7uzE7cJP4LU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ESYZ4B3Fcg3Ko2lR5YdEo+mqD7tWwDu0FDc4cb8270QuBWO7kKB5QfUmcdX2YPrKb
	 ufdjCvBIHn+keFgdpmDDKJMvDVYMD6rjCCkiargQqN/+r2pfG6LfA1IHnzZtXp2809
	 a7gX0PvtbE2Z7BjkSYkzePiQSW2uiwTrAFZGz3Jg=
Message-ID: <2173d71c-301d-4b6c-b839-0e747d0d0a4b@linux.microsoft.com>
Date: Fri, 2 May 2025 11:31:03 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] uio_hv_generic: Fix ring buffer sysfs creation
 path
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250424053524.1631-1-namjain@linux.microsoft.com>
 <2025042501-accuracy-uncombed-cb99@gregkh>
 <752c5b1c-ef67-4644-95d4-712cdba6ad2b@linux.microsoft.com>
 <2025050154-skyward-snagged-973d@gregkh>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <2025050154-skyward-snagged-973d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/1/2025 9:35 PM, Greg Kroah-Hartman wrote:
> On Mon, Apr 28, 2025 at 02:37:22PM +0530, Naman Jain wrote:
>>
>>
>> On 4/25/2025 7:30 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Apr 24, 2025 at 11:05:22AM +0530, Naman Jain wrote:
>>>> Hi,
>>>> This patch series aims to address the sysfs creation issue for the ring
>>>> buffer by reorganizing the code. Additionally, it updates the ring sysfs
>>>> size to accurately reflect the actual ring buffer size, rather than a
>>>> fixed static value.
>>>>
>>>> PFB change logs:
>>>>
>>>> Changes since v5:
>>>> https://lore.kernel.org/all/20250415164452.170239-1-namjain@linux.microsoft.com/
>>>> * Added Reviewed-By tags from Dexuan. Also, addressed minor comments in
>>>>     commit msg of both patches.
>>>> * Missed to remove check for "primary_channel->device_obj->channels_kset" in
>>>>     hv_create_ring_sysfs in earlier patch, as suggested by Michael. Did it
>>>>     now.
>>>> * Changed type for declaring bin_attrs due to changes introduced by
>>>>     commit 9bec944506fa ("sysfs: constify attribute_group::bin_attrs") which
>>>>     merged recently. Did not use bin_attrs_new since another change is in
>>>>     the queue to change usage of bin_attrs_new to bin_attrs
>>>>     (sysfs: finalize the constification of 'struct bin_attribute').
>>>
>>> Please fix up to apply cleanly without build warnings:
>>>
>>> drivers/hv/vmbus_drv.c:1893:15: error: initializing 'struct bin_attribute **' with an expression of type 'const struct bin_attribute *const[2]' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>>>    1893 |         .bin_attrs = vmbus_chan_bin_attrs,
>>>         |                      ^~~~~~~~~~~~~~~~~~~~
>>> 1 error generated.
>>
>> Hi Greg,
>> I tried reproducing this error but could not see it. Should I rebase the
>> change to some other tree or use some specific config option, gcc version,
>> compilation flag etc.?
>>
>> I tried the following:
>> * Rebased to latest linux-next tip with below base commit:
>> 393d0c54cae31317deaa9043320c5fd9454deabc
>> * Regular compilation with gcc: make -j8
>> * extra flags:
>>    make -j8  EXTRA_CFLAGS="-Wall -O2"
>>    make -j8 EXTRA_CFLAGS="-Wincompatible-pointer-types-discards-qualifiers
>> -Werror"
>> * Tried gcc 11.4, 13.3
>> * Tried clang/LLVM with version 18.1.3 : make LLVM=1
> 
> I tried this against my char-misc-linus branch (which is pretty much
> just 6.15.0-rc4 plus some iio patches), and it fails with that error
> above.
> 
>> BTW I had to edit the type for bin_attrs as this change got merged recently:
>> 9bec944506fa ("sysfs: constify attribute_group::bin_attrs")
>>
>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>> index 576b8b3c60af..f418aae4f113 100644
>> --- a/include/linux/sysfs.h
>> +++ b/include/linux/sysfs.h
>> @@ -107,7 +107,7 @@ struct attribute_group {
>>                                              int);
>>          struct attribute        **attrs;
>>          union {
>> -               struct bin_attribute            **bin_attrs;
>> +               const struct bin_attribute      *const *bin_attrs;
>>                  const struct bin_attribute      *const *bin_attrs_new;
>>          };
>>   };
> 
> That commit is not in my char-misc branches, that's coming from
> somewhere else.
> 
> thanks,
> 
> greg k-h

Hi Greg,

I can send a patch based on char-misc/6.15.0-rc4 which does not have 
this patch, but I am worried that it will cause compilation issues when 
your branch is merged with linux-next since this change is already there 
in linux-next. Do you want me to proceed with sending a patch on 6.15.0-rc4?

Here are more details of that patch:

"""
sysfs: constify attribute_group::bin_attrs
All users of this field have been migrated to bin_attrs_new.
It can now be constified.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: 
https://lore.kernel.org/r/20250313-sysfs-const-bin_attr-final-v2-2-96284e1e88ce@weissschuh.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

"""

Regards,
Naman

