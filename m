Return-Path: <linux-hyperv+bounces-2997-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83309729A4
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Sep 2024 08:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDD01F2607B
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Sep 2024 06:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF4175D2F;
	Tue, 10 Sep 2024 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QodAntrm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339E1741FE;
	Tue, 10 Sep 2024 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950286; cv=none; b=IX56RFazWouSzY5baQQ5sDRTrK4JGC6pgrIy7vbfwfC2gnuEkFKUfRZfEoWRgkHl9WoLCokkMyZeFmjsdI0hoAsT0Bd69E0oyp0+MctBH+fBrueCA3C/2dTKh1Sw1lreZUQ4hoCxPYzspGWRkxu6yhvXSUmqX+3ckSCg1zyrefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950286; c=relaxed/simple;
	bh=VjEIbjqPBq3Lp/fNF9Xa+R+uI/8Mp6sw85Dh8NFlIB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tONcdZSXUQrsTP/LClrnTCd8MrD0zkS9zFFg2NAGOrkXvcOanC+APb+bZO8+C+dK8Zlj/dCvRwuV9jAxXuRYpPA0K+hp0UA6SDOBBqb3duGUkTSVptqh9ZSwuY0aBeEGEzJ/OMfiwYw33KuVl2JlXBIFBChwP8pbgxAqUkJWKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QodAntrm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.224.114] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E01320B9A6A;
	Mon,  9 Sep 2024 23:37:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E01320B9A6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725950279;
	bh=jQczYn4IGDpSbJMWUYwJY7GUd+3u9rqMfdxFfIyCuZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QodAntrm/M+rGXnVAIDrpNgDFRklZCJG34eYYhdCqhPwx1sYzQwYjN8pkVZZ69I7x
	 YLIBEw+ZUiYP2aXvrFrqetk9A3V02Cd3Rveiw9l+AzshSXV4RGA7O0NyZPZrTjqGN0
	 UNG+zKE7ukm15BRcjHFFM7kOHRkP8PCTOyOBuYaU=
Message-ID: <f982f176-c171-44db-b86c-f91b7d926949@linux.microsoft.com>
Date: Tue, 10 Sep 2024 12:07:53 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH] clocksource: hyper-v: Fix hv tsc page based
 sched_clock for hibernation
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240909053923.8512-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157141DD58FD6EAE96C7CABD4992@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157141DD58FD6EAE96C7CABD4992@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/2024 9:16 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, September 8, 2024 10:39 PM
>>
>> read_hv_sched_clock_tsc() assumes that the Hyper-V clock counter is
>> bigger than the variable hv_sched_clock_offset, which is cached during
>> early boot, but depending on the timing this assumption may be false

..

>> +	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
>> +	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
>> +	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
>> +	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
> 
> This Hyper-V clocksource/timer driver has intentionally been kept
> instruction set architecture independent.  See the comment at the top
> of the source code file. We've also avoided any "#ifdef x86" or similar, though
> it's OK to have #ifdef's on specific clock-related functionality like
> GENERIC_SCHED_CLOCK.
> 
> The reference to "x86_platform" violates the intended independence. The
> code to save-on-suspend and update-on-resume can probably stay in this
> module in generic form, but hooking the functions into the x86_platform
> function call mechanism should move to x86-specific code.
> 
> Michael
> 

Thanks for the review and guidance Michael. I'll take care of it in v2.


Regards,
Naman


>> +
>>   	/*
>>   	 * TSC page mapping works differently in root compared to guest.
>>   	 * - In guest partition the guest PFN has to be passed to the
>>
>> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
>> --
>> 2.25.1
> 


