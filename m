Return-Path: <linux-hyperv+bounces-3004-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A717976DE0
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 17:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D73F282A06
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8131BB68F;
	Thu, 12 Sep 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aKkdz0yj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23731B982F;
	Thu, 12 Sep 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155444; cv=none; b=G/Wp5eUggDt0MLohIboKd6P3RPbJtQSTYbj4rj8KIDW0vh6x1KNbC4b40Osu4OrmDY+WxVkyGC2XZCb/ZxSFy84wcWxNVRLaWKP1xtAfV1xnqrX3DvqaKeuBNaCaSSbk5SeJHJh9/0NunLRbCnDW0C4wSO5ZDeyt94NILjCFz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155444; c=relaxed/simple;
	bh=YMRr9g4ZPzQ8hi3Cr5RqWjHdTaonSvS42jjcXwohXIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGPUfG1MXpx0NiEu6xNuZsmUKJ0IFpn4GUcqAxhreu/WGxLvi3rJN5IIfVHGDKd+/x0Slv7rMiSY4xIN9FJ7+MNIHS8X7k3KOSxW//uSCAij17gUI4xCJChX572atfvUprp5yzudXv4led4GoVZBIyMjVFjM8atKaLJIFxQOlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aKkdz0yj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.33.35] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6125120B9D5D;
	Thu, 12 Sep 2024 08:37:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6125120B9D5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726155442;
	bh=T/0bM8wPEZaP8lXz/LE9SPg9Ph0Rxme1goWijhxaPKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aKkdz0yjLeT7Okal8OtVOOIgV1u6mZ0Cg7KVKNlQZfuFsXw73jzlaUpkan/RXPnYK
	 Z7umv+g6b3M72r5CYmVsUztXFh7R2BfKi2B4jlculkO6uBUvtYTSBLnBIb/xdqY+OO
	 FuZ9571za6PYixm2TMC0Pxmt0IHHvHVjVYlldEko=
Message-ID: <d0b42e38-c956-4140-926f-64fad527fbd1@linux.microsoft.com>
Date: Thu, 12 Sep 2024 21:07:16 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: hyper-v: Fix hv tsc page based
 sched_clock for hibernation
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240911045632.3757-1-namjain@linux.microsoft.com>
 <SN6PR02MB415797B9F0A29B91C6117D5BD4642@SN6PR02MB4157.namprd02.prod.outlook.com>
 <c047e855-61be-4b68-8876-40d07e79bb7c@linux.microsoft.com>
 <SN6PR02MB4157967915492AAF473CB682D4642@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157967915492AAF473CB682D4642@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/2024 8:51 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, September 11, 2024 9:51 PM
>>
>> On 9/12/2024 9:09 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, September 10,
>> 2024 9:57 PM
>>>>
>>>
>>> This version of the patch looks good to me from the standpoint of
>>> separating the x86 specific functionality from the arch independent
>>> functionality. And I think the patch works as intended. But there
>>> are parts of the description and variable naming that don't align
>>> with my understanding of the problem and the fix. So I've added
>>> some additional comments below.
>>>
>>> Nit: Now that most of the code changes are in mshyperv.c, the
>>> patch Subject: prefix should perhaps be "x86/hyperv:" instead
>>> of "clocksource: hyperv:".
>>
>> Thanks a lot for reviewing Michael. As you rightly pointed out, these
>> comments and variable names made more sense when they were in
>> hyperv_timer.c. I'll change them accordingly in next patch.
>>
>> Will change commit msg subject as well.
>>
>>>
>>>> read_hv_sched_clock_tsc() assumes that the Hyper-V clock counter is
>>>> bigger than the variable hv_sched_clock_offset, which is cached during
>>>> early boot, but depending on the timing this assumption may be false
>>>> when a hibernated VM starts again (the clock counter starts from 0
>>>> again) and is resuming back (Note: hv_init_tsc_clocksource() is not
>>>> called during hibernation/resume); consequently,
>>>> read_hv_sched_clock_tsc() may return a negative integer (which is
>>>> interpreted as a huge positive integer since the return type is u64)
>>>> and new kernel messages are prefixed with huge timestamps before
>>>> read_hv_sched_clock_tsc() grows big enough (which typically takes
>>>> several seconds).
>>>
>>> Just so I'm clear on the sequence, when a new VM is created to
>>> resume the hibernated VM, I think the following happens:
>>>
>>> 1) The VM being used to resume the hibernation image boots a
>>> fresh instance of the Linux kernel. The sched clock and sched clock
>>> offset value are initialized as with any kernel, and kernel messages
>>> are printed with the correct timestamps starting at zero.
>>>
>>> 2) The new Linux kernel then loads the hibernation image and
>>> transfers control to it, whereupon the "resume" callbacks are run
>>> in the context of the hibernation image.  At this point, any kernel
>>> timestamps are wrong, and might even be negative, because the
>>> sched clock value is calculated based on the new Hyper-V reference
>>> time (which started again at zero) minus the old sched clock offset.
>>> The goal is that the sched clock value should be continuous with
>>> the sched clock value from the original VM. If the original VM
>>> had been running for 1000 seconds when the hibernation was
>>> done, the sched clock value in the resumed hibernation image
>>> should continue, starting at ~1000 seconds.
>>>
>>> 3) The fix is to adjust the sched clock offset in the resumed
>>> hibernation image, and make it more negative by that ~1000
>>> seconds.
>>>
>>> Is that all correct?  If so, then it seems like this patch is doing
>>> more than just cleaning up the negative values for sched clock.
>>> It's also making the sched clock values continuous with the
>>> sched clock values in the original VM rather than restarting
>>> near zero after hibernation image is resumed.
>>>
>>
>> Yes, that's exactly what this patch is trying to do. There was an option
>> to correct in suspend-resume callbacks of original VM in hyperv_timer.c,
>> but these are executed very late, and we still end up getting many logs
>> with these incorrect timestamps. We took reference from the code where
>> tsc clock correction takes place, and thought that similar should be
>> done here.
> 
> Yes, agreed. I'm glad the mechanism for the TSC clock correction
> is available to use. :-)

Yes.

"arch/x86/kernel/tsc.c"

void tsc_save_sched_clock_state(void)

/*
  * Even on processors with invariant TSC, TSC gets reset in some the
  * ACPI system sleep states. And in some systems BIOS seem to reinit TSC to
  * arbitrary value (still sync'd across cpu's) during resume from such 
sleep
  * states. To cope up with this, recompute the cyc2ns_offset for each 
cpu so
  * that sched_clock() continues from the point where it was left off during
  * suspend.
  */
void tsc_restore_sched_clock_state(void)


called from "arch/x86/power/cpu.c" in
__restore_processor_state() -> x86_platform.restore_sched_clock_state();

> 
>>
>> We can tweak the commit msg to add this additional detail.
> 
> Thanks. I think the change to make the sched clock time (and
> therefore the dmesg log timestamps) continuous with the
> original VM is important to call out.  It's a change that will be
> visible to users.
> 
> [snip]
> 
>>>> +/*
>>>> + * Hyper-V clock counter resets during hibernation. Save and restore clock
>>>> + * offset during suspend/resume, while also considering the time passed
>>>> + * before suspend. This is to make sure that sched_clock using hv tsc page
>>>> + * based clocksource, proceeds from where it left off during suspend and
>>>> + * it shows correct time for the timestamps of kernel messages after resume.
>>>> + */
>>
>> I added it here, but the same should be added in commit msg as well.
>> I'll add it.
> 
> Ah, indeed, you did add it in the comment.  But yes, it should go in
> the commit message as well.
> 
>>
>>>> +static void save_hv_clock_tsc_state(void)
>>>> +{
>>>> +	hv_sched_clock_offset_saved = hv_read_reference_counter();
>>>
>>> Naming this variable hv_sched_clock_offset_saved doesn't seem to match
>>> what it actually contains. The saved value is not a sched_clock_offset. It's
>>> the value of the Hyper-V reference counter at the time the original VM
>>> hibernates does "suspend".  The sched_clock_offset in the original VM will
>>> typically be a pretty small value (a few seconds or even less). But the
>>> Hyper-V reference counter value might be thousands of seconds if the
>>> VM has been running a while before it hibernates.
>>
>> I'll change it to something that conveys the right information. Thanks
>> for the suggestion.
>>
>>>
>>>> +}
>>>> +
>>>> +static void restore_hv_clock_tsc_state(void)
>>>> +{
>>>> +	/*
>>>> +	 * hv_sched_clock_offset = offset that is used by hyperv_timer clocksource driver
>>>> +	 *                         to get time.
>>>> +	 * Time passed before suspend = hv_sched_clock_offset_saved
>>>> +	 *                            - hv_sched_clock_offset (old)
>>>> +	 *
>>>> +	 * After Hyper-V clock counter resets, hv_sched_clock_offset needs a correction.
>>>> +	 *
>>>> +	 * New time = hv_read_reference_counter() (future) - hv_sched_clock_offset (new)
>>>> +	 * New time = Time passed before suspend + hv_read_reference_counter() (future)
>>>> +	 *                                       - hv_read_reference_counter() (now)
>>>> +	 *
>>>> +	 * Solving the above two equations gives:
>>>> +	 *
>>>> +	 * hv_sched_clock_offset (new) = hv_sched_clock_offset (old)
>>>> +	 *                             - hv_sched_clock_offset_saved
>>>> +	 *                             + hv_read_reference_counter() (now))
>>>> +	 */
>>>> +	hv_adj_sched_clock_offset(hv_sched_clock_offset_saved - hv_read_reference_counter());
>>>
>>> The argument passed to hv_adj_sched_clock_offset() makes sense to me if I think
>>> of it as:
>>>
>>> 	hv_ref_time_at_hibernate - hv_read_reference_counter()
>>>
>>> where hv_read_reference_counter() is just "ref time now".
>>>
>>> I think of it like this: The Hyper-V reference counter value changed underneath
>>> the resumed hibernation image when it starts running in the new VM. The adjustment
>>> changes the sched clock offset to compensate for that change so that sched clock
>>> values are continuous across the suspend/resume hibernation sequence.
>>>
>>> I don't completely understand what you've explained with the two equations and
>>> solving them, though the result matches my expectations.
>>
>> Yeah :) it made more sense when we look at it from hyperv_timer.c driver
>> POV because these offsets are nothing but reference counters at
>> different points of time.
> 
> Well, yes and no. The value of the Hyper-V reference counter is
> an absolute value at the time it is read. But the hv_sched_clock_offset
> is a "delta" value -- the difference between two absolute time values.
> While hv_sched_clock_offset is initially set to the current value of the
> Hyper-V reference counter, it is used as a delta value. And after
> the adjustment is applied when resuming from hibernation,
> hv_sched_clock_offset is definitely no longer a reference counter
> value from some point in time -- it's clearly only a delta value.
> 

Details matter :) Thanks for your feedback. I'll wait for a few days
before posting v3, in case there are some more review comments.


>> Having said that, I think we can go with a
>> comment explaining the intention, and skip adding these equations which
>> may be confusing here as there is no concept of offsets here, as you
>> rightly pointed out in your previous reply as well.
> 
> Works for me.
> 
> Thanks,
> 
> Michael

Regards,
Naman

