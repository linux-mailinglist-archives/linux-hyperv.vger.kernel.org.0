Return-Path: <linux-hyperv+bounces-3577-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C45A00FF1
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 22:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CC9162EBA
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFD61B6CF5;
	Fri,  3 Jan 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hHoRYdnX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7E3145B03;
	Fri,  3 Jan 2025 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735940371; cv=none; b=W2Gw+9EFtuKPJQE6c/OPkInhQvx6ElDvtrVpwKgGkzABQt+2VZrh1Gt/JGjBYxascIrCzniujsCmK6cJ9MrNHc3zAr7wlCac2XU8/BeW1oEhKxINI9b//ooaoxh1/GPlDhL5Iq1X5GKA9bf7gT2Ul87Nq+brvxR1e6DMbaNWzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735940371; c=relaxed/simple;
	bh=7YSsrKb1U96EUGPc2QHwgzhYNm8y3y0SmYWTB9Emj84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u08VnMIaVo8yT1DpHkV/TsFVSunHILDOo+M4g9c6Ctc7sHTVKxmIshnZyILJCCZCQDsAiNFQdC3j0WcgblVyY0uT+RjXbYnGpyyx/5gz+e87cDdqnEvt2gp6JlvZSmtNdS/o+nfYIrbMh2+onXXyrw3KUPDu49123Chth96iUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hHoRYdnX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 624C92041AAB;
	Fri,  3 Jan 2025 13:39:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 624C92041AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735940369;
	bh=tvJi7q4nwGLM0CaKc+VGqKyn0tjdjAA/GUpafuT9p+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hHoRYdnXCt3qhgyVTNbzOlBrmS2ZKr7KMrou+8zRNC17X7eDBjVsjVM8wRmQfZ/ds
	 kd/7KIc5QtNaYjvo0MpUsQDNtEQUTRtuP8oVDayHzkeg+SRHgLSmqpHpt8AnEL6Xpf
	 WFUmFoluQVHmCFYlMJdjTFpTHs40xEW+MpXaJL5Y=
Message-ID: <24594814-6b31-4dc9-83c3-2bafbd14e819@linux.microsoft.com>
Date: Fri, 3 Jan 2025 13:39:29 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 eahariha@linux.microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, nunodasneves@linux.microsoft.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250103192002.GA22059@skinsburskii.>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/3/2025 11:20 AM, Stanislav Kinsburskii wrote:
> On Mon, Dec 30, 2024 at 10:09:39AM -0800, Roman Kisel wrote:
>> Due to the hypercall page not being allocated in the VTL mode,
>> the code resorts to using a part of the input page.
>>
>> Allocate the hypercall output page in the VTL mode thus enabling
>> it to use it for output and share code with dom0.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   drivers/hv/hv_common.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index c6ed3ba4bf61..c983cfd4d6c0 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -340,7 +340,7 @@ int __init hv_common_init(void)
>>   	BUG_ON(!hyperv_pcpu_input_arg);
>>   
>>   	/* Allocate the per-CPU state for output arg for root */
>> -	if (hv_root_partition) {
>> +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
> 
> This check doesn't look nice.
I read that as you don't like it. Neither do I (see below), the change
enables what's needed for the rest, and poses no harm imo.

> First of all, IS_ENABLED(CONFIG_HYPERV_VTL_MODE) doesn't mean that this
> particular kernel is being booted in VTL other that VTL0. > Second, current approach is that a VTL1+ kernel is a different build 
from VTL0
> kernel and thus relying on the config option looks reasonable. However,
> this is not true in general case.
"First" and "Second" appear to be saying that the approach is good in
your opinion. What is that general case you're alluding to which is
going to be broken by adding IS_ENABLED() here, how do I repro the
possible borkage?

> 
> I'd suggest one of the following three options:
> 
> 1. Always allocate per-cpu output pages. This is wasteful for the VTL0
> guest case, but it might worth it for overall simplification.
As outlined above, the justification for the changes you're requesting
isn't clear. Yet, if no objections from others, I'd happily weed out
these if's and #ifdef's, on that we're in agreement.

> 
> 2. Don't touch this code and keep the cnage in the Underhill tree.
So, leave get_vtl() broken iiuc? Please suggest what would be the fix
you prefer more. The patch set regularizes the common case and makes
get_vtl() look as hv_get_vp_register which it is so get_vtl() can be
replaced with it once it appears in the tree.

All in all, strong disagree. I cannot seem to see how "don't touch"
and "keep" is going to work with upstreaming the VTL mode patches.

> 
> 3. Introduce a configuration option (command line or device tree or
> both) and use it instead of the kernel config option.
That looks to me as messy and complicated compared to adding
IS_ENABLED(). Why defer the decision to runtime, what are the benefits
in your opinion?

> 
> Thanks,
> Stas
> 
>>   		hyperv_pcpu_output_arg = alloc_percpu(void *);
>>   		BUG_ON(!hyperv_pcpu_output_arg);
>>   	}
>> @@ -435,7 +435,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>   	void **inputarg, **outputarg;
>>   	u64 msr_vp_index;
>>   	gfp_t flags;
>> -	int pgcount = hv_root_partition ? 2 : 1;
>> +	const int pgcount = (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) ? 2 : 1;
>>   	void *mem;
>>   	int ret;
>>   
>> @@ -453,7 +453,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>   		if (!mem)
>>   			return -ENOMEM;
>>   
>> -		if (hv_root_partition) {
>> +		if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>>   			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>>   			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>>   		}
>> -- 
>> 2.34.1
>>

-- 
Thank you,
Roman


