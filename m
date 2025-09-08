Return-Path: <linux-hyperv+bounces-6784-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DBFB497D3
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 20:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E321B26688
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260A31283D;
	Mon,  8 Sep 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o1OW5aRs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B011D312802;
	Mon,  8 Sep 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354789; cv=none; b=XR1cVgRQ+o42e3Onaykp7CfO6N7G9auOL84YJIBZbZ3igr1L9tzkM+JgX9NMS0CiLbUVkMHDDd+Cz58G7K9/YAYl5Tab5L1Dx6XiSWh0CP2a8uIOLs+tXuns6ugntkNqkYLotPWnPboWrv/k4/U8oynkWRYUQOZjqPehFkv5b0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354789; c=relaxed/simple;
	bh=/BLW/H7xcZcvs+lCT7H6oiZytPrTqJktjn1TERFx7v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6X7h6SaMXMg6sNtm96TtIY6XyqfcfiIMdbwK4NfhC9m8ml/7e9Jafvf/A2b9QfCww5BbBC4d7s55TblUuLQj7YQx5XigxGFp2dNlhM7FvFLFJL4tsUYzJZFd+ZCwHKjMATV3BJxpNE8jCWouColfjJoYtjcSDt4Gx8xLc1X2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o1OW5aRs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.199] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6DF1D2119385;
	Mon,  8 Sep 2025 11:06:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DF1D2119385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757354786;
	bh=j5gRSHscPfg6W/CSCSDrpbLSWxVgflWg4TN9tbqXdGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o1OW5aRsvSmQnaxcy++csaR1IexNIlsAWgisLv1Ggsd0YIU8VgAatZmqNXsnMfM21
	 AmHerQ7AnqKNPHv1z+FwUyb9OXQT9G/yg9GN2Ueeu14jdK3dwU60I8yXMKmij0rlk9
	 agePWTg6WHLxeHcGoCF37Juew38InLmvGZt4TXOs=
Message-ID: <23d93b71-86cc-4c01-9264-b049cfec39e0@linux.microsoft.com>
Date: Mon, 8 Sep 2025 11:06:25 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mshv: Ignore second stats page map result failure
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
 <efc78065-3556-410a-866f-961a7f1fc1ac@linux.microsoft.com>
 <874a2370-84f1-4cec-bb06-a13fe11b49ca@linux.microsoft.com>
 <7b4fafc7-cf89-45f6-ac5c-59a4c9f53f79@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <7b4fafc7-cf89-45f6-ac5c-59a4c9f53f79@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/2025 10:22 AM, Easwar Hariharan wrote:
> On 9/8/2025 10:04 AM, Nuno Das Neves wrote:
>> On 9/5/2025 12:21 PM, Easwar Hariharan wrote:
>>> On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
>>>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>>>
>>>> Some versions of the hypervisor do not support HV_STATUS_AREA_PARENT and
>>>> return HV_STATUS_INVALID_PARAMETER for the second stats page mapping
>>>> request.
>>>>
>>>> This results a failure in module init. Instead of failing, gracefully
>>>> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
>>>> already-mapped stats_pages[HV_STATS_AREA_SELF].
>>>
>>> What's the impact of this graceful fallback? It occurs to me that if a stats
>>> accumulator, in userspace perhaps, expected to get stats from the 2 pages,
>>> it'd get incorrect values.
>>>
>> This is going out of scope of this series a bit but I'll explain briefly.
>>
>> When we do add the code to expose these stats to userspace, the SELF and
>> PARENT pages won't be exposed separately, there is no duplication.
>>
>> For each stat counter in the page, we'll expose either the SELF or PARENT
>> value, depending on whether there is anything in that slot (whether it's zero
>> or not).
>>
>> Some stats are available via the SELF page, and some via the PARENT page, but
>> the counters in the page have the same layout. So some counters in the SELF
>> page will all stay zero while on the PARENT page they are updated, and vice
>> versa.
>>
>> I believe the hypervisor takes this strange approach for the purpose of
>> backward compatibility. Introducing L1VH created the need for this SELF/PARENT
>> distinction.
>>
>> Hope that makes some kind of sense...it will be clearer when we post the mshv
>> debugfs code itself.
>>
>> To put it another way, falling back to the SELF page won't cause any impact
>> to userspace because the distinction between the pages is all handled in the
>> driver, and we only read each stat value from either SELF or PARENT.
>>
>> Nuno
> 
> Thank you for that explanation, it sorta makes sense.
> 
> I think it'd be better if this patch is part of the series that exposes the stats
> to userspace, so that it can be reviewed in context with the rest of the code in
> the driver that manages the pick-and-choose of a stat value from the SELF/PARENT
> page.
> 
Good idea, I think I'll do that. Thanks!

> Unless there's an active problem now in the upstream kernel that this patch solves?
> i.e. are the versions of the hypervisor that don't support the PARENT stats
> page available in the wild?
> 
I thought there was, but on reflection, no it doesn't solve a problem that exists in
the code today.

Nuno

> Thanks,
> Easwar (he/him)


