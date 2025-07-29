Return-Path: <linux-hyperv+bounces-6428-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CDAB14770
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 07:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD03BAF77
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 05:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78107224AF2;
	Tue, 29 Jul 2025 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n0PwQJiN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24472634;
	Tue, 29 Jul 2025 05:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753765743; cv=none; b=oqXbEtCAaORs/ooCwWO1cR58HqjiBLpXjKeragwCeI73jo0i0oOSayOD0TmZMmROWsPX7aDkec8R0KcB9BxxNt5ucsO5XxNI9dcaVYAFj3Ii1at6M7FfDB1+kdP0KeaxIrl+UTxtPrNQGI1H/BtNGeGM8A7uqkG5dDv7lYkjKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753765743; c=relaxed/simple;
	bh=XWxFCn699OEVDNLgs8wLGR4eS0m1rSlLO9FCPacfvkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUw2JP1sqadHoj6SEVXSoOdg2P3zYMlGarqznziV6K0hTovDsh3QCifpaUZa0mcqBxy349IpbSMoM5SKMqwKyDcYIg4XWPzFvUY8TB1CL0gpbLflAxWR5Bia/xvuiFqz2hKlm2R4KpfzN3xQFIQ06+MsiRXMN19O5sD5BLSsEfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n0PwQJiN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.161.187] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id DDE912021866;
	Mon, 28 Jul 2025 22:08:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDE912021866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753765741;
	bh=GkNCKUMZl6WNjOw5VJi2LlNf14Ca9uH/SfWTITXfLYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n0PwQJiNfB9DOEIOy0lUKaMiVMBwkkBM+6BeIgnpZQifzkAx2LxAejwp/bXLX9ISt
	 TIftWdWLROq7bO95zPIsK+HzkfO2g+vU8TpqrU8vchvWMbwJFMGKZqv2zonYpCNzQC
	 Qs3KrywEPD1mAnSF+KhwwcKg1Xl2WDBiRpF3ntXA=
Message-ID: <9965dc77-eab9-4252-8c93-01c27e417bdc@linux.microsoft.com>
Date: Tue, 29 Jul 2025 10:38:51 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>,
 Markus Elfring <Markus.Elfring@web.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
 <20250724082547.195235-3-namjain@linux.microsoft.com>
 <SN6PR02MB41571331AF61BE197F76B970D459A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <03c90b7d-e9b8-4f8f-9267-c273791077c2@linux.microsoft.com>
 <SN6PR02MB41579F474B6FC43D4E5754CDD459A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41579F474B6FC43D4E5754CDD459A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/25/2025 8:05 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, July 24, 2025 10:54 PM
>>
>> On 7/25/2025 8:52 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, July 24, 2025 1:26 AM
>>>>
> 
> [snip]
> 
>>>> +
>>>> +static int mshv_vtl_sint_ioctl_set_eventfd(struct mshv_vtl_set_eventfd __user *arg)
>>>> +{
>>>> +	struct mshv_vtl_set_eventfd set_eventfd;
>>>> +	struct eventfd_ctx *eventfd, *old_eventfd;
>>>> +
>>>> +	if (copy_from_user(&set_eventfd, arg, sizeof(set_eventfd)))
>>>> +		return -EFAULT;
>>>> +	if (set_eventfd.flag >= HV_EVENT_FLAGS_COUNT)
>>>> +		return -EINVAL;
>>>> +
>>>> +	eventfd = NULL;
>>>> +	if (set_eventfd.fd >= 0) {
>>>> +		eventfd = eventfd_ctx_fdget(set_eventfd.fd);
>>>> +		if (IS_ERR(eventfd))
>>>> +			return PTR_ERR(eventfd);
>>>> +	}
>>>> +
>>>> +	guard(mutex)(&flag_lock);
>>>> +	old_eventfd = READ_ONCE(flag_eventfds[set_eventfd.flag]);
>>>> +	WRITE_ONCE(flag_eventfds[set_eventfd.flag], eventfd);
>>>> +
>>>> +	if (old_eventfd) {
>>>> +		synchronize_rcu();
>>>> +		eventfd_ctx_put(old_eventfd);
>>>
>>> Again, I wonder if is OK to do eventfd_ctx_put() while holding
>>> flag_lock, since the use of guard() changes the scope of the lock
>>> compared with the previous version of this patch.
>>>
>>
>> I didn't find eventfd_ctx_put() to be a blocking operation, so I thought
>> of keeping guard() here. Although, synchronize_rcu() is a blocking
>> operation. Please advise, I am Ok with removing the guard, as the lock
>> is just being used here, and automatic cleanup should not be an issue
>> here.
> 
> Yes, I think you are right. I saw the kref_put() and was unsure what
> would be called if the object was freed. But the "free" function is
> right there staring at me. :-) All it does is ida_free() and kfree(),
> both of which would be safe.
> 
> You should be good keeping the guard().
> 
> Michael

Acked.

> 
>>
>>
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +


