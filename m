Return-Path: <linux-hyperv+bounces-3001-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC8976026
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 06:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637311C22DAD
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 04:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FFD188936;
	Thu, 12 Sep 2024 04:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KcjYda98"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17798188587;
	Thu, 12 Sep 2024 04:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726116646; cv=none; b=EC3lSXeXEmBNLj0DbNgyBzRCAmVPq5YgW1e0K6XY7OycJS2k/0BSwo54CLIO7cCU17FmyZtp4TcNyhXI/q4E6TNHU++LVclpkt/egKraDx6Li1L9xPaRQGPFWVVnX9mf8Br2/DpI5jpwfu71W3Uf9nYYLows38cJeSyRllClnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726116646; c=relaxed/simple;
	bh=OHG/G1DrGqlKXRYTqgpyK3HZLc/Ma2uqVsJEdwVfOnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQliSHHU7//q0SQYIGapcj90LR/OQvDdlNvQ6sugLglvKLf6b62E8KQuNMiK/5QvCnW+8CSNZr1vs3TIVfwTLSpIOjcE6MhdsXXcDXdzL5zLk0JtmGVTtGoIS6jigo8we31qUJxNmu/Tw1zOR9AMcymKJWPGU64/NKYkWFZTpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KcjYda98; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.75.183] (unknown [167.220.238.215])
	by linux.microsoft.com (Postfix) with ESMTPSA id 851F420B9A9A;
	Wed, 11 Sep 2024 21:50:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 851F420B9A9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726116644;
	bh=bzr7HrsoQW01+LQcVQeciWqqtEn3V1YzZq2oY62lzXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KcjYda98BOpiZMKkfXb8eq772Hv8xvyyGbeHZVmQdwArMu7DXdZr9Lww5pu9kZdkv
	 kbEOhk2efhVLei4NvuoAf8jjbH9mhCq19hNq3sVmrP4vnu1kII4ENtSDYM1+O4l5xz
	 LE1QShITzx5TRHFqXWF3D9gYz+g60THZlabJMGtk=
Message-ID: <c047e855-61be-4b68-8876-40d07e79bb7c@linux.microsoft.com>
Date: Thu, 12 Sep 2024 10:20:37 +0530
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415797B9F0A29B91C6117D5BD4642@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/2024 9:09 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, September 10, 2024 9:57 PM
>>
> 
> This version of the patch looks good to me from the standpoint of
> separating the x86 specific functionality from the arch independent
> functionality. And I think the patch works as intended. But there
> are parts of the description and variable naming that don't align
> with my understanding of the problem and the fix. So I've added
> some additional comments below.
> 
> Nit: Now that most of the code changes are in mshyperv.c, the
> patch Subject: prefix should perhaps be "x86/hyperv:" instead
> of "clocksource: hyperv:".

Thanks a lot for reviewing Michael. As you rightly pointed out, these
comments and variable names made more sense when they were in
hyperv_timer.c. I'll change them accordingly in next patch.

Will change commit msg subject as well.

> 
>> read_hv_sched_clock_tsc() assumes that the Hyper-V clock counter is
>> bigger than the variable hv_sched_clock_offset, which is cached during
>> early boot, but depending on the timing this assumption may be false
>> when a hibernated VM starts again (the clock counter starts from 0
>> again) and is resuming back (Note: hv_init_tsc_clocksource() is not
>> called during hibernation/resume); consequently,
>> read_hv_sched_clock_tsc() may return a negative integer (which is
>> interpreted as a huge positive integer since the return type is u64)
>> and new kernel messages are prefixed with huge timestamps before
>> read_hv_sched_clock_tsc() grows big enough (which typically takes
>> several seconds).
> 
> Just so I'm clear on the sequence, when a new VM is created to
> resume the hibernated VM, I think the following happens:
> 
> 1) The VM being used to resume the hibernation image boots a
> fresh instance of the Linux kernel. The sched clock and sched clock
> offset value are initialized as with any kernel, and kernel messages
> are printed with the correct timestamps starting at zero.
> 
> 2) The new Linux kernel then loads the hibernation image and
> transfers control to it, whereupon the "resume" callbacks are run
> in the context of the hibernation image.  At this point, any kernel
> timestamps are wrong, and might even be negative, because the
> sched clock value is calculated based on the new Hyper-V reference
> time (which started again at zero) minus the old sched clock offset.
> The goal is that the sched clock value should be continuous with
> the sched clock value from the original VM. If the original VM
> had been running for 1000 seconds when the hibernation was
> done, the sched clock value in the resumed hibernation image
> should continue, starting at ~1000 seconds.
> 
> 3) The fix is to adjust the sched clock offset in the resumed
> hibernation image, and make it more negative by that ~1000
> seconds.
> 
> Is that all correct?  If so, then it seems like this patch is doing
> more than just cleaning up the negative values for sched clock.
> It's also making the sched clock values continuous with the
> sched clock values in the original VM rather than restarting
> near zero after hibernation image is resumed.
>

Yes, that's exactly what this patch is trying to do. There was an option
to correct in suspend-resume callbacks of original VM in hyperv_timer.c,
but these are executed very late, and we still end up getting many logs
with these incorrect timestamps. We took reference from the code where
tsc clock correction takes place, and thought that similar should be
done here.

We can tweak the commit msg to add this additional detail.

>>
>> Fix the issue by saving the Hyper-V clock counter just before the
>> suspend, and using it to correct the hv_sched_clock_offset in
>> resume. Override x86_platform.save_sched_clock_state  and
>> x86_platform.restore_sched_clock_state.
>>
>> Note: if Invariant TSC is available, the issue doesn't happen because
>> 1) we don't register read_hv_sched_clock_tsc() for sched clock:
>> See commit e5313f1c5404 ("clocksource/drivers/hyper-v: Rework
>> clocksource and sched clock setup");
>> 2) the common x86 code adjusts TSC similarly: see
>> __restore_processor_state() ->  tsc_verify_tsc_adjust(true) and
>> x86_platform.restore_sched_clock_state().
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 1349401ff1aa ("clocksource/drivers/hyper-v: Suspend/resume Hyper-V
>> clocksource for hibernation")
>> Co-developed-by: Dexuan Cui <decui@microsoft.com>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>> Changes from v1:
>> https://lore.kernel.org/all/20240909053923.8512-1-namjain@linux.microsoft.com/
>> * Reorganized code as per Michael's comment, and moved the logic to x86
>> specific files, to keep hyperv_timer.c arch independent.
>>
>> ---
>>   arch/x86/kernel/cpu/mshyperv.c     | 70 ++++++++++++++++++++++++++++++
>>   drivers/clocksource/hyperv_timer.c |  8 +++-
>>   include/clocksource/hyperv_timer.h |  8 ++++
>>   3 files changed, 85 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index e0fd57a8ba84..d83a694e387c 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -224,6 +224,75 @@ static void hv_machine_crash_shutdown(struct pt_regs
>> *regs)
>>   	hyperv_cleanup();
>>   }
>>   #endif /* CONFIG_CRASH_DUMP */
>> +
>> +static u64 hv_sched_clock_offset_saved;
>> +static void (*old_save_sched_clock_state)(void);
>> +static void (*old_restore_sched_clock_state)(void);
>> +
>> +/*
>> + * Hyper-V clock counter resets during hibernation. Save and restore clock
>> + * offset during suspend/resume, while also considering the time passed
>> + * before suspend. This is to make sure that sched_clock using hv tsc page
>> + * based clocksource, proceeds from where it left off during suspend and
>> + * it shows correct time for the timestamps of kernel messages after resume.
>> + */

I added it here, but the same should be added in commit msg as well.
I'll add it.

>> +static void save_hv_clock_tsc_state(void)
>> +{
>> +	hv_sched_clock_offset_saved = hv_read_reference_counter();
> 
> Naming this variable hv_sched_clock_offset_saved doesn't seem to match
> what it actually contains. The saved value is not a sched_clock_offset. It's
> the value of the Hyper-V reference counter at the time the original VM
> hibernates does "suspend".  The sched_clock_offset in the original VM will
> typically be a pretty small value (a few seconds or even less). But the
> Hyper-V reference counter value might be thousands of seconds if the
> VM has been running a while before it hibernates.

I'll change it to something that conveys the right information. Thanks
for the suggestion.

> 
>> +}
>> +
>> +static void restore_hv_clock_tsc_state(void)
>> +{
>> +	/*
>> +	 * hv_sched_clock_offset = offset that is used by hyperv_timer clocksource driver
>> +	 *                         to get time.
>> +	 * Time passed before suspend = hv_sched_clock_offset_saved
>> +	 *                            - hv_sched_clock_offset (old)
>> +	 *
>> +	 * After Hyper-V clock counter resets, hv_sched_clock_offset needs a correction.
>> +	 *
>> +	 * New time = hv_read_reference_counter() (future) - hv_sched_clock_offset (new)
>> +	 * New time = Time passed before suspend + hv_read_reference_counter() (future)
>> +	 *                                       - hv_read_reference_counter() (now)
>> +	 *
>> +	 * Solving the above two equations gives:
>> +	 *
>> +	 * hv_sched_clock_offset (new) = hv_sched_clock_offset (old)
>> +	 *                             - hv_sched_clock_offset_saved
>> +	 *                             + hv_read_reference_counter() (now))
>> +	 */
>> +	hv_adj_sched_clock_offset(hv_sched_clock_offset_saved - hv_read_reference_counter());
> 
> The argument passed to hv_adj_sched_clock_offset() makes sense to me if I think
> of it as:
> 
> 	hv_ref_time_at_hibernate - hv_read_reference_counter()
> 
> where hv_read_reference_counter() is just "ref time now".
> 
> I think of it like this: The Hyper-V reference counter value changed underneath
> the resumed hibernation image when it starts running in the new VM. The adjustment
> changes the sched clock offset to compensate for that change so that sched clock
> values are continuous across the suspend/resume hibernation sequence.
> 
> I don't completely understand what you've explained with the two equations and
> solving them, though the result matches my expectations.

Yeah :) it made more sense when we look at it from hyperv_timer.c driver
POV because these offsets are nothing but reference counters at
different points of time. Having said that, I think we can go with a
comment explaining the intention, and skip adding these equations which
may be confusing here as there is no concept of offsets here, as you
rightly pointed out in your previous reply as well.

> 
>> +}
>> +
>> +/*
>> + * Functions to override save_sched_clock_state and restore_sched_clock_state
>> + * functions of x86_platform. The Hyper-V clock counter is reset during
>> + * suspend-resume and the offset used to measure time needs to be
>> + * corrected, post resume.
>> + */
>> +static void hv_save_sched_clock_state(void)
>> +{
>> +	old_save_sched_clock_state();
>> +	save_hv_clock_tsc_state();
>> +}
>> +
>> +static void hv_restore_sched_clock_state(void)
>> +{
>> +	restore_hv_clock_tsc_state();
>> +	old_restore_sched_clock_state();
>> +}
>> +
>> +static void __init x86_setup_ops_for_tsc_pg_clock(void)
>> +{
>> +	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>> +		return;
>> +
>> +	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
>> +	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
>> +
>> +	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
>> +	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
>> +}
>>   #endif /* CONFIG_HYPERV */
>>
>>   static uint32_t  __init ms_hyperv_platform(void)
>> @@ -575,6 +644,7 @@ static void __init ms_hyperv_init_platform(void)
>>
>>   	/* Register Hyper-V specific clocksource */
>>   	hv_init_clocksource();
>> +	x86_setup_ops_for_tsc_pg_clock();
>>   	hv_vtl_init_platform();
>>   #endif
>>   	/*
>> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
>> index b2a080647e41..e424892444ed 100644
>> --- a/drivers/clocksource/hyperv_timer.c
>> +++ b/drivers/clocksource/hyperv_timer.c
>> @@ -27,7 +27,8 @@
>>   #include <asm/mshyperv.h>
>>
>>   static struct clock_event_device __percpu *hv_clock_event;
>> -static u64 hv_sched_clock_offset __ro_after_init;
>> +/* Note: offset can hold negative values after hibernation. */
>> +static u64 hv_sched_clock_offset __read_mostly;
>>
>>   /*
>>    * If false, we're using the old mechanism for stimer0 interrupts
>> @@ -456,6 +457,11 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
>>   	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
>>   }
>>
>> +void hv_adj_sched_clock_offset(u64 offset)
>> +{
>> +	hv_sched_clock_offset -= offset;
>> +}
>> +
>>   #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
>>   static int hv_cs_enable(struct clocksource *cs)
>>   {
>> diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
>> index 6cdc873ac907..62e2bad754c0 100644
>> --- a/include/clocksource/hyperv_timer.h
>> +++ b/include/clocksource/hyperv_timer.h
>> @@ -38,6 +38,14 @@ extern void hv_remap_tsc_clocksource(void);
>>   extern unsigned long hv_get_tsc_pfn(void);
>>   extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
>>
>> +/*
>> + * Called during resume from hibernation, from overridden
>> + * x86_platform.restore_sched_clock_state routine. This is to adjust offsets
>> + * used to calculate time for hv tsc page based sched_clock, to account for
>> + * time spent before hibernation.
>> + */
> 
> I would have expected this comment to be placed with the actual
> function in hyperv_timer.c, not with the declaration here in the .h
> file.
> 

Acked. Will move it in next patch.

> Michael
> 
>> +extern void hv_adj_sched_clock_offset(u64 offset);
>> +
>>   static __always_inline bool
>>   hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
>>   		     u64 *cur_tsc, u64 *time)
>>
>> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
>> --
>> 2.25.1

Regards,
Naman

