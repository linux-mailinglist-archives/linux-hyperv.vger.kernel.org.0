Return-Path: <linux-hyperv+bounces-6798-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B3CB50294
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 18:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBB5B4E3141
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B33352FDB;
	Tue,  9 Sep 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dNqlcjCJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AAA223337;
	Tue,  9 Sep 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435254; cv=none; b=Cw/5NOC+XMJfZKVfKoJHovbevKCW3fs94QZDK0XaSV2SiS+s8z+KpbwYad0iou59B9bUGRmTVledhR/pHduoOZC2EYMOoIrp+zWqtCcYIGpCvms53MfXDnca/jmJGxskdRhzy2kRxJSm95dkF/p2QQt5Gs/ESqHptrNduUoGsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435254; c=relaxed/simple;
	bh=SmJc2zv22f0FWYQKbSkbcJrtvbKce1caU4WLDAhXMxU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T+PXBX3PXsCquIr7Ahc/cj/4DDPoM19ZLTew735Ba3jDQ9FpRxsD6/wTY8OUx314WQn0DBzDi4FpG8sHM8f5JFHe3TajbjGPOjS+eiqB/fnmyI/J0Y0tW551++L52jV1mgrcTqb/ttwU3ovLS0YSyLTC0eWFZ5JRkyFwT+45pKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dNqlcjCJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.161.27] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 986A921199D2;
	Tue,  9 Sep 2025 09:27:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 986A921199D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757435250;
	bh=g4ui/NbLzeQr+QDYyVfKyCnHa7V/QAZY5cC85JgqUGE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dNqlcjCJV+tivW1Dfr7LFs00JIg3LYX252g+CgVjlOlGjP8P+rVZHbDAFbvEZZCxE
	 7P88H2SASxLiqdpz/5wXEQ9tt50SPmFbbPg/weaBJVbKFcE8pnv/ndukUoYNS87OL0
	 K+eNRn7IJ+FoacV8u701Noy0R0M6LAsEw86hqCig=
Message-ID: <bd12701b-9093-481e-b420-a19eb9e7c262@linux.microsoft.com>
Date: Tue, 9 Sep 2025 09:27:29 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 easwar.hariharan@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 2/6] mshv: Ignore second stats page map result failure
To: Praveen K Paladugu <praveenkpaladugu@gmail.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
 <efc78065-3556-410a-866f-961a7f1fc1ac@linux.microsoft.com>
 <874a2370-84f1-4cec-bb06-a13fe11b49ca@linux.microsoft.com>
 <7b4fafc7-cf89-45f6-ac5c-59a4c9f53f79@linux.microsoft.com>
 <23d93b71-86cc-4c01-9264-b049cfec39e0@linux.microsoft.com>
 <6252578f-df25-4510-bc18-8f593739fb83@gmail.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <6252578f-df25-4510-bc18-8f593739fb83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/2025 7:52 AM, Praveen K Paladugu wrote:
> 
> 
> On 9/8/2025 1:06 PM, Nuno Das Neves wrote:
>> On 9/8/2025 10:22 AM, Easwar Hariharan wrote:
>>> On 9/8/2025 10:04 AM, Nuno Das Neves wrote:
>>>> On 9/5/2025 12:21 PM, Easwar Hariharan wrote:
>>>>> On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
>>>>>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>>>>>
>>>>>> Some versions of the hypervisor do not support HV_STATUS_AREA_PARENT and
>>>>>> return HV_STATUS_INVALID_PARAMETER for the second stats page mapping
>>>>>> request.
>>>>>>
>>>>>> This results a failure in module init. Instead of failing, gracefully
>>>>>> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
>>>>>> already-mapped stats_pages[HV_STATS_AREA_SELF].
>>>>>
>>>>> What's the impact of this graceful fallback? It occurs to me that if a stats
>>>>> accumulator, in userspace perhaps, expected to get stats from the 2 pages,
>>>>> it'd get incorrect values.
>>>>>
>>>> This is going out of scope of this series a bit but I'll explain briefly.
>>>>
>>>> When we do add the code to expose these stats to userspace, the SELF and
>>>> PARENT pages won't be exposed separately, there is no duplication.
>>>>
>>>> For each stat counter in the page, we'll expose either the SELF or PARENT
>>>> value, depending on whether there is anything in that slot (whether it's zero
>>>> or not).
>>>>
>>>> Some stats are available via the SELF page, and some via the PARENT page, but
>>>> the counters in the page have the same layout. So some counters in the SELF
>>>> page will all stay zero while on the PARENT page they are updated, and vice
>>>> versa.
>>>>
>>>> I believe the hypervisor takes this strange approach for the purpose of
>>>> backward compatibility. Introducing L1VH created the need for this SELF/PARENT
>>>> distinction.
>>>>
>>>> Hope that makes some kind of sense...it will be clearer when we post the mshv
>>>> debugfs code itself.
>>>>
>>>> To put it another way, falling back to the SELF page won't cause any impact
>>>> to userspace because the distinction between the pages is all handled in the
>>>> driver, and we only read each stat value from either SELF or PARENT.
>>>>
>>>> Nuno
>>>
>>> Thank you for that explanation, it sorta makes sense.
>>>
>>> I think it'd be better if this patch is part of the series that exposes the stats
>>> to userspace, so that it can be reviewed in context with the rest of the code in
>>> the driver that manages the pick-and-choose of a stat value from the SELF/PARENT
>>> page.
>>>
>> Good idea, I think I'll do that. Thanks!
>>
>>> Unless there's an active problem now in the upstream kernel that this patch solves?
>>> i.e. are the versions of the hypervisor that don't support the PARENT stats
>>> page available in the wild?
>>>
>> I thought there was, but on reflection, no it doesn't solve a problem that exists in
>> the code today.
>>
>> Nuno
>>
> 
> The usecases for stats exposed by the hypervisor are:
> 1) used within the kernel by root scheduler
> 2) exposed to userspace via debugfs.
> 
> I thought we are addressing the first use-case here (patch1 in this series). If root scheduler support was upstreamed then this patchset does solve a problem in upstream code.
> 

Sorry about the long context, I couldn't figure out a good spot to snip.

Thanks for calling that out. I think root scheduler support has been upstreamed if I'm reading
root_scheduler_init() right, Nuno can confirm.

With the series applied, I don't see any of the code that picks and chooses the stats from
the PARENT/SELF pages even for the kernel case, rather there's a straight memcpy of the
stats pages in the create_vp ioctl.

Is the kernel usage with the root scheduler somehow immune from the problem userspace would
face with the duplicated pages? If not, I'd say that it's an argument for dropping patch 1
and 2, instead of including patch 2, or to fold them together. We don't want a state in the
upstream kernel where a commit introduces a known problem just to be solved by the following
commit.

Thanks,
Easwar (he/him)

