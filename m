Return-Path: <linux-hyperv+bounces-6454-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD928B19B29
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Aug 2025 07:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B853B45D1
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Aug 2025 05:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC1913C8FF;
	Mon,  4 Aug 2025 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qmmHUbDG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D6754774;
	Mon,  4 Aug 2025 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754286586; cv=none; b=GELxKhC+EUuJqYZ/UDCHv+IXPwmH+hD1mkKO4oFR0UbA+3gurHMGTCeFi3AqKyA5dMQGrj/XoZTYbFT+r/d2GRJwjgS6y0lrA1QNXjO0oovm3CfdtjoJXGW5FPTZLD6NxQqwZ+o8gffoio4kIVPd1Q/HL6hTeteaUfrei6aDSkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754286586; c=relaxed/simple;
	bh=N0ifEoKADJ266dZ1TZEK7VwvwBuXGKpaWyjwuR91ViU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAZpFFt6R1Gqz8SKI9yUkuyAkkZY5k7XxOWEoCn/ue4qL7yzjuXxpA+u7QsHpZqEtIXP5hN03NvjQmMP9nN2uXgN82PFtnOgEJQ8j8a3C3OGf9GYYWLRhVL3LmJDyv7pWbttV5zFxAXXU3+v7V9BkwTRVwwRHCxZCm77s1NkLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qmmHUbDG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.67.184] (unknown [167.220.238.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id C0455201BC7B;
	Sun,  3 Aug 2025 22:49:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0455201BC7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754286579;
	bh=A76h4RG1POnkmztMobKJragbYBbJ9FiCAa2P6uity8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qmmHUbDGeypqffd0mWMQ93VcsqWlgN9ZjnGTrjathKinmLcjJ+XwXJLnMoWFoKMIY
	 fOM30Tf8x9eUY9vx5bjsqCGDmRpzl+ZCW2RjRIMEYEIfQWxUbpRk4WvJ3tuIxmjWNc
	 lie0YPQI6qorxBif1z3aVscrpstOdljShj5ZMC/4=
Message-ID: <5e7f02ee-6007-417b-b234-a70cec30c385@linux.microsoft.com>
Date: Mon, 4 Aug 2025 11:19:34 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12] Drivers: hv: Make the sysfs node size for the ring
 buffer dynamic
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Michael Kelley <mhklinux@outlook.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Long Li <longli@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250723070200.2775-1-namjain@linux.microsoft.com>
 <SN6PR02MB41579080792040E166B5EB69D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e1d394bd-93a6-4d8f-b7f9-fc01449df98a@t-8ch.de>
 <SN6PR02MB415792B00B021D4DB76A6014D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <4abf15ac-de18-48d4-9420-19d40f26fdd2@linux.microsoft.com>
 <8f642ca2-04dc-4d87-b120-5d128ec3202e@t-8ch.de>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <8f642ca2-04dc-4d87-b120-5d128ec3202e@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/1/2025 4:22 PM, Thomas Weißschuh wrote:
> Hi Naman,
> 
> On 2025-07-31 21:13:27+0530, Naman Jain wrote:
>> On 7/30/2025 1:15 AM, Michael Kelley wrote:
>>> From: Thomas Weißschuh <linux@weissschuh.net> Sent: Tuesday, July 29, 2025 11:47 AM
>>>> On 2025-07-29 18:39:45+0000, Michael Kelley wrote:
>>>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, July 23, 2025 12:02 AM
> <snip>
> 
>>>>> Unfortunately, I don't see a fix, short of backporting support for the
>>>>> .bin_size function, as this is exactly the problem that function solves.
>>>>
>>>> It should work out in practice. (I introduced the .bin_size function)
>>>
>>> The race I describe is unlikely, particularly if attribute groups are created
>>> once and then not disturbed. But note that the Hyper-V fcopy group can
>>> get updated in a running VM via update_sysfs_group(), which also calls
>>> create_files(). Such an update might marginally increase the potential for
>>> the race and for getting the wrong size. Still, I agree it should work out
>>> in practice.
>>>
>>> Michael
>>>
>>>>
>>>> Thomas
>>
>> hi Thomas,
>> Would it be possible to port your changes on 6.12 kernel, to avoid such
>> race conditions?
> 
> Possible, surely. But Greg has to accept it.
> And you will need to do the backports.
> 
>> Or if it has a lot of dependencies, or if you have a
>> follow-up advice, please let us us know.
> 
> Not more than mentioned before.
> 
> 
> Thomas

Acked. Thanks.

Regards,
Naman


