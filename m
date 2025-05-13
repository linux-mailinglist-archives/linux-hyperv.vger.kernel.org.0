Return-Path: <linux-hyperv+bounces-5491-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981BCAB59F3
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CC018905AF
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC231A3A8D;
	Tue, 13 May 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U3+CFIdc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61117126BF7;
	Tue, 13 May 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154055; cv=none; b=IsrTdUK+VtbgJYAW1hBUqTbAX0Whq485Ox6q79u2YmrTXaeZRITgsJBus58qM6Dfnv1agWgSzEIkfn0jqpaU+dHthQQYNMP3b6UlJPCsrBED6vF2H3nfnXx3Uwwxbyh7vS+aNVneiXeQEwTPJFBtH8HxKV4M4o0YqNB2IOxx4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154055; c=relaxed/simple;
	bh=d/OefSnIhjOWw5+/8pfM9cvIRAlY3zQqJW4s7vNJOSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mh9UDIDDF9UJQOTFFjtrMivxKvx9v4V0SLfvdgAynQ3J8+bmvf/G+3dVb83mCcNttDKEhSU65TRUI9zCnYqIGFUtS9g90iv99Xa+G7D28OLzTSYIh/qWTk1RxZOzq8pCKx4LhhKYai/9wsQFrIOQxTvsYRwr2DtnwVbGdAOcsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U3+CFIdc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.32.107] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 995FB201DB28;
	Tue, 13 May 2025 09:34:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 995FB201DB28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747154053;
	bh=DFzCu1kvmOXy+gxmTfId8oZOT+kIZ3F1vNu1ZMuupps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U3+CFIdcan8nB0hIDbWoXSTynn28I2VvJGbGPaUC13CmqAveI89tIqRElScFBwSJB
	 1wbj4fudFm9RiHCay02c/OG/oPQP/DTvOY5hb5r9ljQtO7qlTUPfrlRdie6gnhtp9l
	 UCUrQW2t13Wucb/Hpm6xidN+bIFSZvANMLHoytbE=
Message-ID: <d061ea43-8aec-49ff-b013-8c9df4a7b0b5@linux.microsoft.com>
Date: Tue, 13 May 2025 22:04:06 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Michael Kelley <mhklinux@outlook.com>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
 <aBzx8HDwKakGG1tR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <KUZP153MB14447CC188576D3A7376CEAABE8AA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <30fdc85f-5afc-4591-ab43-1c46c435025c@linux.microsoft.com>
 <SN6PR02MB4157D8770347E8C2EC49EBBBD496A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157D8770347E8C2EC49EBBBD496A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/13/2025 9:00 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, May 9, 2025 11:05 AM
>>
>> On 5/9/2025 11:02 AM, Saurabh Singh Sengar wrote:
>>>
>>>
>>
>> [...]
>>
>>>> Yep. We don't rely on user land software doing sane things to maintain
>>>> correctness in kernel, so this needs to be fixed.
>>>>
>>>> Thanks,
>>>> Wei.
>>>
>>>
>>> How about fixing this for normal x86 for now and put a TODO for CVM to be fixed
>> later, when we bring in CVM support ?
>>
>> That seems to strike the right balance ihmo :)
>> Thanks for coming up with the suggestion!
>>
> 
> FWIW, it seems like it would be pretty easy to fix the CVM case as well.  Do
> the following:
> 
> 1. Allocate memory at runtime using the normal kmalloc()
> 2. Copy from user space to that allocated memory
> 3. Disable interrupts as usual for using the per-cpu hypercall arg pages
> 4. Copy from the allocated memory to the per-cpu hypercall arg pages.
>     In a CVM this will do the conversion from encrypted memory to
>     decrypted memory.
> 5. Make the hypercall
> 6. Copy out any results to the allocated memory. Again, this will do
>     the conversion from decrypted to encrypted.
> 7. Enable interrupts
> 8. Copy results from the allocated memory to user space
> 9. Free the allocated memory
> 
> (And maybe Steps 6 and 8 don't apply if there's no output data to copy
> back to user space.)
> 
> The performance penalty is the memory allocation/free, plus the extra
> copying of the input/output hypercall arguments. But I'm guessing the
> arguments are usually on the small side, so the extra copy isn't a big issue.
> 
> Michael

Thanks for looking into this Michael. The steps you have highlighted
makes sense. There is an implementation for this here:

https://github.com/microsoft/OHCL-Linux-Kernel/blob/product/hcl-main/6.12/drivers/hv/mshv_vtl_main.c#L2275

Since CVM use-case does not exist as of today in my patch, we thought of
adding this in future patches when we add CVM support.

Regards,
Naman

