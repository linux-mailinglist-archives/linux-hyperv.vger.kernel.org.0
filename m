Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EF9E48C7
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Oct 2019 12:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409586AbfJYKoM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Oct 2019 06:44:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407955AbfJYKoL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Oct 2019 06:44:11 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C1614E832
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Oct 2019 10:44:11 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z23so744568wml.0
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Oct 2019 03:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xLtoZSUJtLXfr2GPGv3stYcfCQVAfI7dC3ODzlq3CwA=;
        b=s5S9trBIbjGG7IlALcsKnUNLS2LfINMA5WFHeHnzH+8Qtt1kryzzv4gMqkxKUS1uCl
         cdnTNb2+xXbap4FgqCEvufwa/APT+XZLczidzDatLSF8l/tmqYZtD/vr8j+Fvrx2/uGe
         4rxYOfLk/bq7KEDn5Oo4VmVpW2UFqmE8bvZKVHdd785PPanS0/DO8zM9lytXx1GKKqG0
         /wytDz/yFfL9ZpJuFsKXWtWnK9pvJtSdRTcOhgdr3k5vXtPZCDUsoQJ3Bjr1X7pV23PT
         lyfwcInCb+kt2qkzYNYRypZ+epQuqo1ZABdrTEgfd+cnQ1IvO2kghq9mTY8jQNzn04+t
         ou3w==
X-Gm-Message-State: APjAAAVV3/EfHodcR3zhSQk/+SZO1NIQqCJdf60dYxn/pa133uBsNu9f
        FJIW7lNcBKA1BQU6fj5+C9kCvey3+j+tLt3JayRefsutIrtx5nv6IkigcRJRleNdO66qrKsrObl
        QT47ihWV53nwqPgAdS1QXTOoe
X-Received: by 2002:a1c:6405:: with SMTP id y5mr3080034wmb.175.1572000249784;
        Fri, 25 Oct 2019 03:44:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxsRUknjwKaf4n/Q/NFMTG8SODIFMIf015chHWuD9N5BsDqxI54rtI51KxXOfmREWqKoD6dAQ==
X-Received: by 2002:a1c:6405:: with SMTP id y5mr3079992wmb.175.1572000249403;
        Fri, 25 Oct 2019 03:44:09 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g5sm1882252wma.43.2019.10.25.03.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 03:44:08 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyper-v: micro-optimize send_ipi_one case
In-Reply-To: <20191024163204.GA4673@rkaganb.sw.ru>
References: <20191024152152.25577-1-vkuznets@redhat.com> <20191024163204.GA4673@rkaganb.sw.ru>
Date:   Fri, 25 Oct 2019 12:44:07 +0200
Message-ID: <87r231xfyg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Thu, Oct 24, 2019 at 05:21:52PM +0200, Vitaly Kuznetsov wrote:
>> When sending an IPI to a single CPU there is no need to deal with cpumasks.
>> With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
>> cycles) improvement with smp_call_function_single() loop benchmark. The
>> optimization, however, is tiny and straitforward. Also, send_ipi_one() is
>> important for PV spinlock kick.
>> 
>> I was also wondering if it would make sense to switch to using regular
>> APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CPU
>> cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
>> vector)).
>
> Is it with APICv or emulated apic?

That's actually a good question. Yesterday I was testing this on WS2019
host with Xeon e5-2420 v2 (Ivy Bridge EN) which I *think* should already
support APICv - but I'm not sure and ark.intel.com is not
helpful. Today, I decided to re-test on something more modern and I got
WS2016 host with E5-2667 v4 (Broadwell) and the results are:

'Ex' hypercall: 18000 cycles
orig_apic.send_IPI(): 46000 cycles

I'm, however, just assuming that Hyper-V uses APICv when it's available
and have no idea how to check from within the guest. I'm also not sure
if WS2019 is so much faster or if there are other differences on these
hosts which matter.

>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/hyperv/hv_apic.c           | 22 +++++++++++++++++++---
>>  arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
>>  2 files changed, 34 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
>> index e01078e93dd3..847f9d0328fe 100644
>> --- a/arch/x86/hyperv/hv_apic.c
>> +++ b/arch/x86/hyperv/hv_apic.c
>> @@ -194,10 +194,26 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
>>  
>>  static bool __send_ipi_one(int cpu, int vector)
>>  {
>> -	struct cpumask mask = CPU_MASK_NONE;
>> +	int ret;
>>  
>> -	cpumask_set_cpu(cpu, &mask);
>> -	return __send_ipi_mask(&mask, vector);
>> +	trace_hyperv_send_ipi_one(cpu, vector);
>> +
>> +	if (unlikely(!hv_hypercall_pg))
>> +		return false;
>> +
>> +	if (unlikely((vector < HV_IPI_LOW_VECTOR) ||
>> +		     (vector > HV_IPI_HIGH_VECTOR)))
>> +		return false;
>
> I guess 'ulikely' is unnecessary in these cases.
>

All I can say is that the resulting asm with my gcc is a bit different
:-)

>> +
>> +	if (cpu >= 64)
>> +		goto do_ex_hypercall;
>> +
>> +	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector,
>> +				     BIT_ULL(hv_cpu_number_to_vp_number(cpu)));
>> +	return ((ret == 0) ? true : false);
>
> D'oh.  Isn't "return ret == 0;" or just "return ret;" good enough?

That's how we do stuff in __send_ipi_mask() :-) I'll send v2
implementing Joe's suggestion to drop 'ret' and just do
return !hv_do_fast_hypercall16().

>
> These tiny nitpicks are no reason to hold the patch though, so
>
> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>

Thanks!

-- 
Vitaly
