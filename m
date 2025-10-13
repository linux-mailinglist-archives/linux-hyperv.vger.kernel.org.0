Return-Path: <linux-hyperv+bounces-7205-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 364DCBD6041
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 21:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6C964E2985
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 19:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942192DAFAE;
	Mon, 13 Oct 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kKbwpmBq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414D1CA84;
	Mon, 13 Oct 2025 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385451; cv=none; b=FFD55rFTL81GcTGLnboyahhKCtVjPsTCIjLNcoauxN4fUUlRNlRoCBx1nXSXv7ipkIlzabsZFDG5JMAfxPcNihQGDmj7WU8U5Cc1G5EmGtsNd2QqAZGJ726ImlfC3OJ0ISEDZPX8zYOvoiyoXUWP67lysS8GMX68+enyIrgUCpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385451; c=relaxed/simple;
	bh=8WDz4ZbNB96LLcu6hjmzQIgU5ZCEzepUzwjbj0t2K7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGlBrgPNBWbQg+p2bpsszU7otdakRf9jTZNXohuX0lWOwWqHVDmB0VqPC/FUY0z4YL3IX1pYSscEyg2w9kG/hmHbo+7ZGZMij28jl2QBPecsbF9TDwgkU9YOxBbqv2IvQ6A/NJ67ChmN+dcCL3mJEJzzQkBn0zEJ1VPKF2Ggo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kKbwpmBq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.76.64.58] (unknown [20.97.9.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 29EB72065942;
	Mon, 13 Oct 2025 12:57:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29EB72065942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760385449;
	bh=ek2yDpktb2CguXy5Z7Ut0IRgqjH213ECc7iX3AVyaoE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kKbwpmBq8ediwHVma1Xlkr/fZOhaPU7S69kpbE8VgJ7TrIUX5/SwuH1zjytR4qBPi
	 EpA9dAG3e00dQzSK2uLs0+UeiYE+zzsMoPhJUu8meRk0FrIomSSg0frM42lnnzadHk
	 1COJ1qcGHCfvZiNhDcWQjgUj9WL/c/dSEqyP48Ng=
Message-ID: <6270ca1e-b77a-4133-bd7a-6e01e65fd921@linux.microsoft.com>
Date: Mon, 13 Oct 2025 14:57:25 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add support for clean shutdown with MSHV
To: Wei Liu <wei.liu@kernel.org>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com
References: <20251009160501.6356-1-prapal@linux.microsoft.com>
 <aOg2hiWM4PZ8D1S5@skinsburskii.localdomain>
 <20251013190546.GC3862989@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Praveen K Paladugu <prapal@linux.microsoft.com>
In-Reply-To: <20251013190546.GC3862989@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/2025 2:05 PM, Wei Liu wrote:
> On Thu, Oct 09, 2025 at 03:26:14PM -0700, Stanislav Kinsburskii wrote:
>> On Thu, Oct 09, 2025 at 10:58:49AM -0500, Praveen K Paladugu wrote:
>>> Add support for clean shutdown of the root partition when running on MSHV
>>> hypervisor.
>>>
>>> Praveen K Paladugu (2):
>>>    hyperv: Add definitions for MSHV sleep state configuration
>>>    hyperv: Enable clean shutdown for root partition with MSHV
>>>
>>
>> There is no need to split this logic to two patches: the first one
>> doesn't make sense without the second one, so it would be better to
>> squash them.
>>
> 
> I would rather keep them separate. It is a bit easier to pick out only
> the header changes that way.
> 
Ack.
> Wei
> 
>> Thanks,
>> Stanislav
>>
>>>   arch/x86/hyperv/hv_init.c      |   7 ++
>>>   drivers/hv/hv_common.c         | 118 +++++++++++++++++++++++++++++++++
>>>   include/asm-generic/mshyperv.h |   1 +
>>>   include/hyperv/hvgdk_mini.h    |   4 +-
>>>   include/hyperv/hvhdk_mini.h    |  33 +++++++++
>>>   5 files changed, 162 insertions(+), 1 deletion(-)
>>>
>>> -- 
>>> 2.51.0
>>>

