Return-Path: <linux-hyperv+bounces-5304-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2238BAA6AAA
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 08:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68159875FA
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 06:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D621D3D4;
	Fri,  2 May 2025 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a2beh/TT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296BE1B5EB5;
	Fri,  2 May 2025 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166674; cv=none; b=tnkJbutGzgVMMBQ69JnULB54Rg/WKxB2uQiDvWvVJzb+LH1OI8MOn/tV9PnN72OKeHKD4qPCm7W9DyHkiKqHX12ucr+eHa3iHFaf7WjFTlxbxI98Ae7ScKCMx1MpWYnHwiqpcEK9gwY8nTgaCwXytpl7PWIxGdjYQkpZg18pn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166674; c=relaxed/simple;
	bh=rsEUTqd8xsK6TWEmgVEJdPQiJEmzwCazjM3sx4RcdKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbJgCzrH6tD+K8/G1dzwe+FsTFfqfj+PtEJZKxryADVU0fryd3cc42/Ajq/V8rUrQ6EUILMKfxUn/cdzPGnJF/PjdqQwrJDBUcpGy390CbVJrxpLAF3ORUoKqdQuQUNACxVtotePem2NNiDr3wMsolPjThNvZs/AGhcjfNglVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a2beh/TT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.193.170] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 14C9B2020950;
	Thu,  1 May 2025 23:17:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14C9B2020950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746166672;
	bh=AIs11BV7qh3/KZL3dBV10hCv5+2WoDIfLVxf4Jls7kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a2beh/TTPCQklRtzXhKXinVAJGx/AE2VN4U+ieMGMgKp/VI+Mhi7KDULrlJrVkLL9
	 leFcLrVQDgi/d05wFAY51mJbqR2OOonqmpeA3meS25hZ4pnSHxglN/HoYcbzk2/XmK
	 QN0aFBN0w3x+B8rtGJDiEsXa8eu/SWh3gSoGq7wE=
Message-ID: <e752e64a-1ac6-4c96-91ec-f5797f97aa24@linux.microsoft.com>
Date: Fri, 2 May 2025 11:47:47 +0530
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
 <2173d71c-301d-4b6c-b839-0e747d0d0a4b@linux.microsoft.com>
 <2025050228-proud-deduce-a73c@gregkh>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <2025050228-proud-deduce-a73c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/2/2025 11:43 AM, Greg Kroah-Hartman wrote:
> On Fri, May 02, 2025 at 11:31:03AM +0530, Naman Jain wrote:
>>
>>
>> On 5/1/2025 9:35 PM, Greg Kroah-Hartman wrote:
>>> On Mon, Apr 28, 2025 at 02:37:22PM +0530, Naman Jain wrote:
>>>>
>>>>
>>>> On 4/25/2025 7:30 PM, Greg Kroah-Hartman wrote:
>>>>> On Thu, Apr 24, 2025 at 11:05:22AM +0530, Naman Jain wrote:
>>>>>> Hi,
>>>>>> This patch series aims to address the sysfs creation issue for the ring
>>>>>> buffer by reorganizing the code. Additionally, it updates the ring sysfs
>>>>>> size to accurately reflect the actual ring buffer size, rather than a
>>>>>> fixed static value.
>>>>>>
>>>>>> PFB change logs:
>>>>>>
>>>>>> Changes since v5:
>>>>>> https://lore.kernel.org/all/20250415164452.170239-1-namjain@linux.microsoft.com/
>>>>>> * Added Reviewed-By tags from Dexuan. Also, addressed minor comments in
>>>>>>      commit msg of both patches.
>>>>>> * Missed to remove check for "primary_channel->device_obj->channels_kset" in
>>>>>>      hv_create_ring_sysfs in earlier patch, as suggested by Michael. Did it
>>>>>>      now.
>>>>>> * Changed type for declaring bin_attrs due to changes introduced by
>>>>>>      commit 9bec944506fa ("sysfs: constify attribute_group::bin_attrs") which
>>>>>>      merged recently. Did not use bin_attrs_new since another change is in
>>>>>>      the queue to change usage of bin_attrs_new to bin_attrs
>>>>>>      (sysfs: finalize the constification of 'struct bin_attribute').
>>>>>
>>>>> Please fix up to apply cleanly without build warnings:
>>>>>
>>>>> drivers/hv/vmbus_drv.c:1893:15: error: initializing 'struct bin_attribute **' with an expression of type 'const struct bin_attribute *const[2]' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>>>>>     1893 |         .bin_attrs = vmbus_chan_bin_attrs,
>>>>>          |                      ^~~~~~~~~~~~~~~~~~~~
>>>>> 1 error generated.
>>>>
>>>> Hi Greg,
>>>> I tried reproducing this error but could not see it. Should I rebase the
>>>> change to some other tree or use some specific config option, gcc version,
>>>> compilation flag etc.?
>>>>
>>>> I tried the following:
>>>> * Rebased to latest linux-next tip with below base commit:
>>>> 393d0c54cae31317deaa9043320c5fd9454deabc
>>>> * Regular compilation with gcc: make -j8
>>>> * extra flags:
>>>>     make -j8  EXTRA_CFLAGS="-Wall -O2"
>>>>     make -j8 EXTRA_CFLAGS="-Wincompatible-pointer-types-discards-qualifiers
>>>> -Werror"
>>>> * Tried gcc 11.4, 13.3
>>>> * Tried clang/LLVM with version 18.1.3 : make LLVM=1
>>>
>>> I tried this against my char-misc-linus branch (which is pretty much
>>> just 6.15.0-rc4 plus some iio patches), and it fails with that error
>>> above.
>>>
>>>> BTW I had to edit the type for bin_attrs as this change got merged recently:
>>>> 9bec944506fa ("sysfs: constify attribute_group::bin_attrs")
>>>>
>>>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>>>> index 576b8b3c60af..f418aae4f113 100644
>>>> --- a/include/linux/sysfs.h
>>>> +++ b/include/linux/sysfs.h
>>>> @@ -107,7 +107,7 @@ struct attribute_group {
>>>>                                               int);
>>>>           struct attribute        **attrs;
>>>>           union {
>>>> -               struct bin_attribute            **bin_attrs;
>>>> +               const struct bin_attribute      *const *bin_attrs;
>>>>                   const struct bin_attribute      *const *bin_attrs_new;
>>>>           };
>>>>    };
>>>
>>> That commit is not in my char-misc branches, that's coming from
>>> somewhere else.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Hi Greg,
>>
>> I can send a patch based on char-misc/6.15.0-rc4 which does not have this
>> patch, but I am worried that it will cause compilation issues when your
>> branch is merged with linux-next since this change is already there in
>> linux-next. Do you want me to proceed with sending a patch on 6.15.0-rc4?
> 
> Yes, because you want this fix in 6.15-final, right?
> 
>> Here are more details of that patch:
>>
>> """
>> sysfs: constify attribute_group::bin_attrs
>> All users of this field have been migrated to bin_attrs_new.
>> It can now be constified.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> Link: https://lore.kernel.org/r/20250313-sysfs-const-bin_attr-final-v2-2-96284e1e88ce@weissschuh.net
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> """
> 
> I know that patch, I will deal with that in linux-next when needed, you
> shouldn't be worrying about it.  I'm more concerned as to why your patch
> was not being tested against Linus's tree if you expected it to be in
> the latest release and backported everywhere as it you asked it to be.
> 
> thanks,
> 
> greg k-h

Sure, thanks. I'll rebase it to 6.15.0-rc4 and send the next version.

Regards,
Naman

