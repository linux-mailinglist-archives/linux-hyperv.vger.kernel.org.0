Return-Path: <linux-hyperv+bounces-3950-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C4CA35790
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 08:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AED81890371
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 07:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA62A186E26;
	Fri, 14 Feb 2025 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mkO95cr2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79909127E18;
	Fri, 14 Feb 2025 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516751; cv=none; b=K/TY5dgctNTIMe9ZGVkApeGxON+im/RdUQBH8mcrhQddVq9QQst1WvdRw6VfuFWuCFv+muvUfVjPuW0V6+xpK3KRXfolEyDDIRR6CRMDguj5xf6gDog9iDkg+jVO3HR8prqdkkzfImiHqb6eChTP0xTLhkeWqhHBzfwD32C6kB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516751; c=relaxed/simple;
	bh=sIeyQ748uOHN9Yw7tn8MENTS3cxbr1xHZGRbHO32tFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYAJ8USIQz7tJ8SXKIrKviW1aFc27X+BxURvcY/nzEWLv6T6ttbqrzkO+mn2adZW2z3z6L9jFT7WKL8/fg06lo5gi3w0fI66GS8uUNHIMFMMCfBHV+wXpt05KyODf5WP73T/PlmnzBYpD87iZ8iS7W4CzWoCclwfJfOQ82ETqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mkO95cr2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.129.26] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 162C8203F3F0;
	Thu, 13 Feb 2025 23:05:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 162C8203F3F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739516749;
	bh=vBNwj7q3wx/FZIcFsg5bD7IyTSXSX3CJHg4bb5/9iLs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mkO95cr29qnDXMfYva0Q/KnoPwNJ2OEapz/U3/51PNX8VVV9coXfdE5VEbswqUk+N
	 z4NLIjk0pdYxCiAt8i16ZmBlfKKQgKFOZxxVDrQO9XHe7wEAndcY5RKWxnwkUKUZ3q
	 7eWG4OPPFzov1NF3GRy0KXSxdPv3DFqicyETYrtQ=
Message-ID: <bb1c122e-e1bb-43fb-a71d-dde8f7aa352b@linux.microsoft.com>
Date: Fri, 14 Feb 2025 12:35:44 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] uio_hv_generic: Fix sysfs creation path for ring
 buffer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20250214064351.8994-1-namjain@linux.microsoft.com>
 <2025021455-tricky-rebalance-4acc@gregkh>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <2025021455-tricky-rebalance-4acc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 12:21 PM, Greg Kroah-Hartman wrote:
> On Fri, Feb 14, 2025 at 12:13:51PM +0530, Naman Jain wrote:
>> On regular bootup, devices get registered to vmbus first, so when
>> uio_hv_generic driver for a particular device type is probed,
>> the device is already initialized and added, so sysfs creation in
>> uio_hv_generic probe works fine. However, when device is removed
>> and brought back, the channel rescinds and again gets registered
>> to vmbus. However this time, the uio_hv_generic driver is already
>> registered to probe for that device and in this case sysfs creation
>> is tried before the device gets initialized completely. Fix this by
>> deferring sysfs creation till device gets initialized completely.
>>
>> Problem path:
>> vmbus_device_register
>>      device_register
>>          uio_hv_generic probe
>> 		    sysfs_create_bin_file (fails here)
> 
> Ick, that's the issue, you shouldn't be manually creating sysfs files.
> Have the driver core do it for you at the proper time, which should make
> your logic much simpler, right?
> 
> Set the default attribute groups instead of manually creating this and
> see if that works out better.
> 
> thanks,
> 
> greg k-h

Thanks for reviewing Greg. I tried this approach and here are my
observations:

What I could create with ATTRIBUTE_GROUPS:
/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/ring

The one we have right now:
/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/channels/6/ring

I could not find a way to tweak attributes to create the "ring" under 
above path. I could see the variations of sys_create_* which provides a
way to pass kobj and do that, but that is something we are already
using.

Regards,
Naman

