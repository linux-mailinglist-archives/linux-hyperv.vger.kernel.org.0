Return-Path: <linux-hyperv+bounces-3164-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496469A5948
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2024 05:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F117C282F57
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2024 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BAF193435;
	Mon, 21 Oct 2024 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j8/XsvqU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C36E193418;
	Mon, 21 Oct 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729482105; cv=none; b=b7de/6iOJR2FDI7x/CDVe/RrmYvx3Jyctp6AZHqrhPqjVazI7SfJfSP1iiQDv5h8P9wij6SpbPd/fFnSTAIwOQ5lwACaaPPfhRJuFxQJzu/fIedQ0+bc5/ROzJpegy5Qr51dzUUMLdcEPCFVKkTASPoPBKl73dvbWimLUtPT6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729482105; c=relaxed/simple;
	bh=gfWm/4z4crplHnbiNFIJoycUa8MJ5HnTjbTzsu6yYaA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oK2vkbH9b5b4hDOH4esl35CsaMzNR1UCEEx1aW/aQplCtxpcgLc4zgUz7sehFqbjbIe8vC+m1NBYgF6nNoCLyat9aGAZhoubCIjzu4o9ko1m0QkoN2YCHK/5Q2T2IZ+mBjfRW0NIZI3H4RjXvUQzB5/IvsJCQ0t2aUG2z3BbCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j8/XsvqU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE88E210B2C1;
	Sun, 20 Oct 2024 20:41:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE88E210B2C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729482103;
	bh=FpzeBHnxnwvm83aCWDE4wDZb+brbprUE31r+txIYr9Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=j8/XsvqUSa3KtQ7u04BoG9ATeEVWesk5EMN/BA7gG8Poejcxw6fe0b0dkJyi/02rG
	 JthCOlW66I5UzIpQue1v+Z6qfyCCamTbZhaKb+5OcoIuf4YfJJde+JiAzwvS1jOIeZ
	 rr1dtPlM7KVuqEJM8n0ARyV+Cl2bb2ZjuWX7ydnE=
Message-ID: <61f0eb38-2f0d-4f0f-a90c-18a02ebf4c55@linux.microsoft.com>
Date: Sun, 20 Oct 2024 20:41:42 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Naman Jain <namjain@linux.microsoft.com>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>
Subject: Re: [RFC PATCH] drivers: hv: Convert open-coded timeouts to
 msecs_to_jiffies()
To: Michael Kelley <mhklinux@outlook.com>,
 Praveen Kumar <kumarpraveen@linux.microsoft.com>,
 "lkp@intel.com" <lkp@intel.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241016223730.531861-1-eahariha@linux.microsoft.com>
 <9f4baf14-8182-451d-9849-4326a783d5c1@linux.microsoft.com>
 <2dff61bd-55d8-430f-9d92-6cbfe1bf6326@linux.microsoft.com>
 <SN6PR02MB41573004E0B25DA75F38F0AED4412@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41573004E0B25DA75F38F0AED4412@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/2024 9:59 PM, Michael Kelley wrote:
> From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Friday, October 18, 2024 3:50 PM
>>
>> On 10/18/2024 12:54 AM, Praveen Kumar wrote:
>>> On 17-10-2024 04:07, Easwar Hariharan wrote:
>>>> We have several places where timeouts are open-coded as N (seconds) * HZ,
>>>> but best practice is to use msecs_to_jiffies(). Convert the timeouts to
>>>> make them HZ invariant.
>>>>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>>>> ---
>>>>  drivers/hv/hv_balloon.c  | 9 +++++----
>>>>  drivers/hv/hv_kvp.c      | 4 ++--
>>>>  drivers/hv/hv_snapshot.c | 6 ++++--
>>>>  drivers/hv/vmbus_drv.c   | 2 +-
>>>>  4 files changed, 12 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>>>> index c38dcdfcb914d..3017d41f12681 100644
>>>> --- a/drivers/hv/hv_balloon.c
>>>> +++ b/drivers/hv/hv_balloon.c
>>>> @@ -756,7 +756,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>>>>  		 * adding succeeded, it is ok to proceed even if the memory was
>>>>  		 * not onlined in time.
>>>>  		 */
>>>> -		wait_for_completion_timeout(&dm_device.ol_waitevent, 5 * HZ);
>>>> +		wait_for_completion_timeout(&dm_device.ol_waitevent, msecs_to_jiffies(5 * 1000));
>>>
>>> Is it correct to convert HZ to 1000 ?
>>> Also, how are you testing these changes ?
>>>
>>
>> It's a conversion of milliseconds to seconds, rather than HZ to 1000. :)
>> msecs_to_jiffies() handles the conversion to jiffies with HZ. As Naman
>> mentioned, this could be equivalently written as 5 * MSECS_PER_SEC, and
>> would probably be more readable. On testing, this is only
>> compile-tested, and that's part of the reason why it's an RFC, since I'm
>> not 100% sure every one of these timeouts is measured in seconds. Hoping
>> for folks more familiar with the code to take a look.
>>
> 
> I believe the current code is correct.  Two things:
> 
> 1) The values multiplied by HZ are indeed in seconds. The number of
> seconds are somewhat arbitrary in some of the cases, so you might
> argue for a different number of seconds. But as coded, the values
> are in seconds.

Thanks for reviewing, Michael, and for the confirmation.

> 
> 2) Unless I'm missing something, the current code uses the correct
> timeout regardless of the value of HZ because the number of jiffies
> per second *is* HZ.
> 
> As such, it might help to be explicit in the commit message that this
> patch isn't fixing any bugs.

Will do.

> As the commit message says, the patch is
> to bring the code into conformance with best practices. I presume
> the best practice you reference is described in
> Documentation/scheduler/completion.rst.
> 
> I don't understand the statement about making the code "HZ invariant",
> which I think came from the aforementioned documentation.  Per
> my #2 above, I think the existing code is already "HZ invariant", at
> least for how I would interpret "HZ invariant".
> 

That's right, both the best practice and the statement of HZ-invariance
came from the scheduler documentation you pointed out. While I can't
find the source with a quick search right now, I understand that HZ
varies with CPU frequency and I figure that's what the statement is
referring to. Unfortunately, there wasn't any discussion on
HZ-invariance I can find on the lore thread where the statement was
added. [1] It seems to be one of those "it's so self explanatory it
doesn't warrant a mention" unless you're one of today's 10,000. [2]

[1]
https://lore.kernel.org/all/1539183392-239389-1-git-send-email-john.garry@huawei.com/T/#u
[2] https://xkcd.com/1053/

> Regardless of the meaning of "HZ invariant", I agree with the idea of
> eliminating the use of HZ in cases like this, and letting msecs_to_jiffies()
> handle it. Unfortunately, converting from "5 * HZ" to 
> "msecs_to_jiffies(5 * 1000)" makes the code really clunky. I would
> advocate for adding something like this to include/linux/jiffies.h:
> 
> #define secs_to_jiffies(secs)    msecs_to_jiffies((secs) * 1000)
> 
> and then using secs_to_jiffies() for all the cases in this patch. That
> reduces the clunkiness. But maybe somebody in the past tried to
> add secs_to_jiffies() and got shot down -- I don't know. It seems like
> an obvious thing to add ....
> 
> Michael

From a quick search on lore with dfb:secs_to_jiffies, it doesn't look
like anyone has tried to add secs_to_jiffies() to jiffies.h. There is
one instance of secs_to_jiffies() being defined in
net/bluetooth/hci_event.c, added in 2021.

Thanks,
Easwar

