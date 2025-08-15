Return-Path: <linux-hyperv+bounces-6542-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F218B284C4
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Aug 2025 19:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8CB600F56
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Aug 2025 17:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CCE30E273;
	Fri, 15 Aug 2025 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dlrwTkyb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9023A3DAC02;
	Fri, 15 Aug 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277878; cv=none; b=QMRW3MqnskOmV3ClY/kyMYi/RVylUBpV/aQvXG/2TJUHtLRTsLF3l5Hk1vbw2D3/Ey8OiZfNs6UX5nPu7+vUVfgzIP1WeeeCncvD08EboBivJLCvUWARDUHlrjcpskk2btqkl60vBvI6zRnD5NWHpwjL5rF9tITM/Mig+iKAvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277878; c=relaxed/simple;
	bh=oL165kMhdL7SBcUYTxkBLep6xaK04HUB/ocynpH08P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5cYTdQvY4eDORWrd2LTpsU9YHkcJGvDOoRgFoMP+Tb3OptdijtpRno9gE20OeItbt0kS9THMVZWSrFhmHpHZpDHxRGNmi5ggzDz5aoliwe+45m2TKeAlD+6WQezuj6HDyiHjt8T3TlZ333AZT19G8laFPgd0tcWlRtdCc5kwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dlrwTkyb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.65.3] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6CC32113342;
	Fri, 15 Aug 2025 10:11:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6CC32113342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755277875;
	bh=SAotWXRdJ4GwPTDfcSrqVIfHspaIFddFM5//f09eJ6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dlrwTkyby66/ulJGMUzfUPi9tbkf3955WraEZ82/BBBvXYxHYKm1MstgxjCKmcMAs
	 UzVAVg1EvzxdpCTAItvmVKBfhUPlQJvDW/sEZkBeZt9dBD51w5rlY89gM0QhJhoDRC
	 kWJ5t3+WustA2QQ4QkVVi6SuLZYej8XBP8cX0FVE=
Message-ID: <4ebde68b-1e39-4650-9f57-500843fa8aea@linux.microsoft.com>
Date: Fri, 15 Aug 2025 10:11:15 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hyperv: Add missing field to
 hv_output_map_device_interrupt
To: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "decui@microsoft.com" <decui@microsoft.com>
References: <1755109257-6893-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157B75073B1E6ACDB6405C1D435A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aJ5SOFR8HNqPxBKN@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aJ5SOFR8HNqPxBKN@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/2025 2:16 PM, Wei Liu wrote:
> On Thu, Aug 14, 2025 at 06:57:22PM +0000, Michael Kelley wrote:
>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, August 13, 2025 11:21 AM
>>>
>>> This field is unused, but the correct structure size is needed
>>> when computing the amount of space for the output argument to
>>> reside, so that it does not cross a page boundary.
>>>
>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>> ---
>>>  include/hyperv/hvhdk_mini.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
>>> index 42e7876455b5..858f6a3925b3 100644
>>> --- a/include/hyperv/hvhdk_mini.h
>>> +++ b/include/hyperv/hvhdk_mini.h
>>> @@ -301,6 +301,7 @@ struct hv_input_map_device_interrupt {
>>>  /* HV_OUTPUT_MAP_DEVICE_INTERRUPT */
>>>  struct hv_output_map_device_interrupt {
>>>  	struct hv_interrupt_entry interrupt_entry;
>>> +	u64 ext_status_deprecated[5];
>>
>> Your email identifying the problem said that without this
>> change, struct hv_output_map_device_interrupt is 0x10
>> bytes in size, which matches what I calculate from the definition.
>> This change adds 0x28 bytes, making the struct size now 0x38
>> bytes. But your other email said Hyper-V expects the size to be
>> 0x58 bytes. Is array size "5" correct, or is there some other
>> cause of the discrepancy?
>>

Ah, it looks like the *input* struct size (0x50) plus the size of
1 cpu bank is 0x58. The output struct size should indeed be 0x38.

I got them mixed up somehow when writing the email.
> 
> FWIW the array size 5 here is correct.
> 
> Wei
> 
>> Michael
>>
>>>  } __packed;
>>>
>>>  /* HV_INPUT_UNMAP_DEVICE_INTERRUPT */
>>> --
>>> 2.34.1
>>
>>


