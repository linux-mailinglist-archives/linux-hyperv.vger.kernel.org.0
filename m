Return-Path: <linux-hyperv+bounces-3961-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9936AA37A4A
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Feb 2025 05:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B38216A287
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Feb 2025 04:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCB61494D8;
	Mon, 17 Feb 2025 04:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DjvzWgmd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6AC1854;
	Mon, 17 Feb 2025 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765140; cv=none; b=QhMQCbvZI/YQOIpg7Js8l5NWmA/WIPK2q/k/JX1tORB1ox0aJ8fwj2z6Ihsja/F6bLYZmRMJOfee+lzZyeSqDVTfwB1hpEVW4WOuRurqyQ2za2rHaYpAzCJ3dTq+HmfWrz1veSvRrm4TFXNPN8380g+R8isfGH/cc8E2N8JZ8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765140; c=relaxed/simple;
	bh=9K3nguHl+1jJCdiqbFDIzQcHxa0+pfSvN2QnQoQNxLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rh+8Hz9XDqbdMlIXZR7Y9yx8TMWhjWCQCFUT6x+g0Bt0CXrzaFTUu+GeynkBO/TFQEUGo7aCUABrozd6l1y68N6OfqpysQhZRO3OJg0Cqn/I7eZd2GkqpOOnHpBIJVBuY9z+9U7RZsIDszQUmCqBtNulvyjEZWnwXBnWA+CmtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DjvzWgmd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.104] (unknown [49.205.248.75])
	by linux.microsoft.com (Postfix) with ESMTPSA id 06F38204E5B3;
	Sun, 16 Feb 2025 20:05:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06F38204E5B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739765138;
	bh=gA/HN3tyS1xuapEwIbEOfoA3Z+Z8tIxXhpP2X3oxgfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DjvzWgmdjROhvvsMiM/VY7MPLLCEHohMBfa1AAr8++81W7wr8pjSCVNq6Mk6jaLcG
	 CTbO8GAxLmGOSNoN94TTFuI6dwHCKmoOO79Tww6xxZi97AuC1FxW42R3k3eA0KJfpc
	 wnsJ/GB7PfV/P3OHV/ddvL+61bkCY4hERiqrH+/A=
Message-ID: <e35ecae5-1596-41f6-92f2-62a79d4d31d6@linux.microsoft.com>
Date: Mon, 17 Feb 2025 09:35:33 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] uio_hv_generic: Fix sysfs creation path for ring
 buffer
To: Stephen Hemminger <stephen@networkplumber.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20250214064351.8994-1-namjain@linux.microsoft.com>
 <2025021455-tricky-rebalance-4acc@gregkh>
 <bb1c122e-e1bb-43fb-a71d-dde8f7aa352b@linux.microsoft.com>
 <2025021418-cork-rinse-698a@gregkh> <20250214091104.01ae4d0a@hermes.local>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250214091104.01ae4d0a@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 10:41 PM, Stephen Hemminger wrote:
> On Fri, 14 Feb 2025 08:41:57 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
>> On Fri, Feb 14, 2025 at 12:35:44PM +0530, Naman Jain wrote:
>>>
>>>
>>> On 2/14/2025 12:21 PM, Greg Kroah-Hartman wrote:
>>>> On Fri, Feb 14, 2025 at 12:13:51PM +0530, Naman Jain wrote:
>>>>> On regular bootup, devices get registered to vmbus first, so when
>>>>> uio_hv_generic driver for a particular device type is probed,
>>>>> the device is already initialized and added, so sysfs creation in
>>>>> uio_hv_generic probe works fine. However, when device is removed
>>>>> and brought back, the channel rescinds and again gets registered
>>>>> to vmbus. However this time, the uio_hv_generic driver is already
>>>>> registered to probe for that device and in this case sysfs creation
>>>>> is tried before the device gets initialized completely. Fix this by
>>>>> deferring sysfs creation till device gets initialized completely.
>>>>>
>>>>> Problem path:
>>>>> vmbus_device_register
>>>>>       device_register
>>>>>           uio_hv_generic probe
>>>>> 		    sysfs_create_bin_file (fails here)
>>>>
>>>> Ick, that's the issue, you shouldn't be manually creating sysfs files.
>>>> Have the driver core do it for you at the proper time, which should make
>>>> your logic much simpler, right?
>>>>
>>>> Set the default attribute groups instead of manually creating this and
>>>> see if that works out better.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> Thanks for reviewing Greg. I tried this approach and here are my
>>> observations:
>>>
>>> What I could create with ATTRIBUTE_GROUPS:
>>> /sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/ring
>>>
>>> The one we have right now:
>>> /sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/channels/6/ring
>>
>> What is "channels" and "6" here?  Are they real devices or just a
>> directory name or something else?
>>
>>> I could not find a way to tweak attributes to create the "ring" under above
>>> path. I could see the variations of sys_create_* which provides a
>>> way to pass kobj and do that, but that is something we are already
>>> using.
>>
>> No driver should EVER be pointing to a raw kobject, that's a huge hint
>> that something is really wrong.  Also, if a raw kobject is in a device
>> path in the middle like this, it will not be seen properly from
>> userspace library tools :(
>>
>> So again, what is creating the "channels" and "6" subdirectories?  All
>> of that shoudl be under full control by the uio device, right?
> 
> The original design of exposing channels was based on what the
> network core does to expose queues. Worth comparing the two
> to see if there is any shared insight.

Thanks Greg and Stephen. I'll try to find it.

Regards,
Naman

