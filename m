Return-Path: <linux-hyperv+bounces-3047-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377097C366
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2024 06:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A78282E10
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2024 04:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F4A1803E;
	Thu, 19 Sep 2024 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OPlNJ+bp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C90A208AD;
	Thu, 19 Sep 2024 04:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726721027; cv=none; b=G0zcADJ2sjfUak8BA6mgNp6u5ll6XWanab7hhkG6jJpxt3pcLr+YVElPhoSrqgysQ8ehfqP2G0fYaZfoDm43Rb0u8Yi6H40p9GFIIxFumzL3X1IuuIJpu+ZayihzRciAUvPxm4m6V3yxy2DtfVz+9uJh2riXwUm0Icyjz4jyOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726721027; c=relaxed/simple;
	bh=lpNgFZv9seW9we31BCKItN+jbOx7qSRiNfOfsPSNkcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIn9y4FKLv7/nNDmfDtZ6pbAjq3ucItqi+3ddGTaoN784hpiYIcJ6vNj+tR6MupQUBsW9NwqMNCpAnYTL6+ZekFdP32MOoxRMpF2pKUyY/5nankciYBKWbjNQJPcT5JFsOdR4JIV7YX33c0/pujGqnBd+0FCnKH0R96LJW7uf3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OPlNJ+bp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.75.183] (unknown [167.220.238.215])
	by linux.microsoft.com (Postfix) with ESMTPSA id 93E9720C0A19;
	Wed, 18 Sep 2024 21:43:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93E9720C0A19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726721025;
	bh=2cXZn7AsuO1/f29Ymo7/H1OKKdihpH5ofIpGs9C1Gak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OPlNJ+bpgLvH5/u1uymp+5eK5jLvpIg7kpgbHDIWxZNe5ftQWDKevBX59qVDYlld8
	 vNA42RHM6o1hKiGHNIa+DD9Z0i/PX+UEoh+ObOgk2NYvDI24yQvfR7/uBOn//s9Smy
	 YbkyJeztx5QlX8kQEnWlcxkPduMbqkOn9hl5OEko=
Message-ID: <26d243c5-6e31-402c-ab3b-588db806ef12@linux.microsoft.com>
Date: Thu, 19 Sep 2024 10:13:35 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/hyper-v: Fix hv tsc page based sched_clock for
 hibernation
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
References: <20240917053917.76787-1-namjain@linux.microsoft.com>
 <SN6PR02MB415772CE1B1F9FC03ECD0258D4622@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415772CE1B1F9FC03ECD0258D4622@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/2024 12:07 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, September 16, 2024 10:39 PM
>>
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
>>
>> Fix the issue by saving the Hyper-V clock counter just before the
>> suspend, and using it to correct the hv_sched_clock_offset in
>> resume. This makes hv tsc page based sched_clock continuous and ensures
>> that post resume, it starts from where it left off during suspend.
>> Override x86_platform.save_sched_clock_state and
>> x86_platform.restore_sched_clock_state routines to correct this as soon
>> as possible.
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
>> Changes from v2:
>> https://lore.kernel.org/all/20240911045632.3757-1-namjain@linux.microsoft.com/
>> Addressed Michael's comments:
>> * Changed commit msg to include information on making timestamps
>>    continuous
>> * Changed subject to reflect the new file being changed
>> * Changed variable name for saving offset/counters
>> * Moved comment on new function introduced from header file to function
>>    definition.
>> * Removed the equations in comments
>> * Rebased to latest linux-next tip
>>
>> Changes from v1:
>> https://lore.kernel.org/all/20240909053923.8512-1-namjain@linux.microsoft.com/
>> * Reorganized code as per Michael's comment, and moved the logic to x86
>> specific files, to keep hyperv_timer.c arch independent.
>>
>> ---
>>   arch/x86/kernel/cpu/mshyperv.c     | 58 ++++++++++++++++++++++++++++++
>>   drivers/clocksource/hyperv_timer.c | 14 +++++++-
>>   include/clocksource/hyperv_timer.h |  2 ++
>>   3 files changed, 73 insertions(+), 1 deletion(-)
> 
> This all looks good to me now. Thanks for indulging all my comments. :-)
> 
> One minor nit: The "Subject:" prefix should not have a dash in "hyper-v".
> The goal is to be consistent in the prefixes used for a particular file instead
> of wandering all over the place. If you check the commit history for
> arch/x86/kernel/cpu/mshyperv.c, you'll see that it is "x86/hyperv", not
> "x86/hyperv-v".
> 
> This is super picky, so don't respin just for this. The maintainer can
> probably fix it when accepting the patch if there are no other changes.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thank you Michael for reviewing. I'll keep this in mind while posting
any patch in future.

Regards,
Naman



