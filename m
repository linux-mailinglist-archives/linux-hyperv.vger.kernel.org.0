Return-Path: <linux-hyperv+bounces-7387-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A28EAC25050
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 13:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9569D351594
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A863491DD;
	Fri, 31 Oct 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bvcli5Cj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117AE2C21DD;
	Fri, 31 Oct 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913957; cv=none; b=LSvxKelJsdojdFoq9BXNAVNtoMIc1ZTF3wPMCdEhyxlVGh5Rt0pqI3lY1L2YfDmADGcUXivDJkvXfNTde8lZ7slwP3GEI28m/d21MQyP6Bl3KPeJKV8TtesZBcwMKYruI0hcKBzzlscUyqFRBoq+FPCdqa6nF5oYn4vx4FUXZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913957; c=relaxed/simple;
	bh=g+6ULz8iyoSYggdN5bJWXhfFYL+vrPewszkEUW0byeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EI97s1IvRHG02/b5qD1nezEJigIRETknq8NtgVEMVFX8SeRq1/tc2I3ZejsvkB18IEynISS9unEbQmFngsF/ukCoYOB+gEKxPevsL7alt4kHurSXFUG33LYkUC4r8wSclmD8wqUp9z/Uxovz4p0A+jn99dlw97HLxmZFyXSDD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Bvcli5Cj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.97.123] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id E01D4201DAE8;
	Fri, 31 Oct 2025 05:32:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E01D4201DAE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761913953;
	bh=XuvWkiTgt0uWpq/KzS6KtJXZLzNVJb+11t6BDSOOSD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bvcli5CjkfOEG2w50WZHzxM/rxzevPoDTIIeYFUaGCGHpktbYlXhqwManTWgb43r0
	 /WOR66OzlQx+WkTRDiaVPHfeMMqJLq2xDvEOtcuwKvY0QNO6g6cXSLLr5lb+jiKLSR
	 HSBpIVFcxkzyffidZNJ9vfQ30J3o4aVfM23so6zM=
Message-ID: <33545bb5-6307-413c-b692-e7bebce58edb@linux.microsoft.com>
Date: Fri, 31 Oct 2025 18:02:22 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hyperv: Use pointer from memcpy() call for assignment
 in hv_crash_setup_trampdata()
To: Markus Elfring <Markus.Elfring@web.de>, linux-hyperv@vger.kernel.org,
 x86@kernel.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Long Li <longli@microsoft.com>, Mukesh Rathor <mrathor@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <d209991b-5aee-4222-aec3-cb662ccb7433@web.de>
 <cea9d987-0231-4131-82ac-9ba8c852f963@linux.microsoft.com>
 <17da2cdc-7fdd-43d1-91d5-36425615588a@web.de>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <17da2cdc-7fdd-43d1-91d5-36425615588a@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/31/2025 3:14 PM, Markus Elfring wrote:
> …>> +++ b/arch/x86/hyperv/hv_crash.c
>>> @@ -464,9 +464,7 @@ static int hv_crash_setup_trampdata(u64 trampoline_va)
>>>            return -1;
>>>        }
>>>    -    dest = (void *)trampoline_va;
>>> -    memcpy(dest, &hv_crash_asm32, size);
>>> -
>>> +    dest = memcpy((void *)trampoline_va, &hv_crash_asm32, size);
>>>        dest += size;
>>>        dest = (void *)round_up((ulong)dest, 16);
>>>        tramp = (struct hv_crash_tramp_data *)dest;
>>
>>
>> I tried running spatch Coccinelle checks on this file, but could not get it to flag this improvement.
> 
> The proposed source code transformation is not supported by a coccicheck script so far.
> 
> 
>> Do you mind sharing more details on the issue reproduction please.
> 
> Would you like to take another look at corresponding development discussions?
> 
> Example:
> [RFC] Increasing usage of direct pointer assignments from memcpy() calls with SmPL?
> https://lore.kernel.org/cocci/ddc8654a-9505-451f-87ad-075bfa646381@web.de/
> https://sympa.inria.fr/sympa/arc/cocci/2025-10/msg00049.html
> 
> 
>> I am OK with this change,
> 
> Thanks for a bit of positive feedback.
> 
> 
>> though it may cost code readability a little bit.
> 
> Would you complain about other variable assignments in such a direction?
> 
> Regards,
> Markus

The only thing which concerns readability IMO is that it is based on the 
assumption that the person reading the code is aware of the return value 
of memcpy. Now, it is debatable if that is something which can be 
considered trivial. I don't have a strong opinion there, but would 
prefer it in its current form.

Also, we could have optimized it further by writing it as below, but we 
are not doing that for a reason as we want to keep the code simpler to 
read and understand. The same may apply here as well.

dest = memcpy((void *)trampoline_va, &hv_crash_asm32, size) + size;

Regards,
Naman

