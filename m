Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E240E5240
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Oct 2019 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502738AbfJYR0I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Oct 2019 13:26:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409965AbfJYR0I (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Oct 2019 13:26:08 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A1F4369AC
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Oct 2019 17:26:07 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id k10so1586670wrl.22
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Oct 2019 10:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=40gRyfBb4ps5SH5tASPj5Wk8vxcVXH98oDEoIsITulQ=;
        b=XVDzh5SjMES/Gn6g7hCRff/yrdzS6Vd/FIsmFc7hciwZ/wuMjPK8vGUwYUN9Wi1VGG
         oDRRS04d7y3ExnlL3i4aKSdsMoBaPuvaipIZayVuVG+VtVYGwBPrlnucwyO0+rchb+Gr
         6AGOxVt11uM8MmVzuFjCAkuCFo/V5R7tWGYZGD3IfJ5dBtASLTlGqcWfXjjK9I/PayfR
         Q8R+s9PM0VpzPyFLDwml+C0c1E1CovrY5xVEEpkr9UJ1mZ7we2OlrNNr/2g0FBC/EDa/
         cOhTDfBqIBFowLZICT4/WVbqCGDHbhfQUdVe6E1kPsomhtkv1YvU8ik7U8U/Iu/rA7mj
         2vNQ==
X-Gm-Message-State: APjAAAXWITBRH8IA8ozx0vedIS3dW9mV2p0ihq9w16h+Gr+dFjksfBEz
        UuZMW+jPmj702ZF2Zx4Cc4TGXbvBy1JZnP2I4WVMuT4Ccmj4Ym8zzCpvf/YAY0sj7ZadN81DuJ5
        Z6T/fHQpQgv8EVgvrMGixnw5H
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr4608875wmg.89.1572024366076;
        Fri, 25 Oct 2019 10:26:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxN6NZZxBLFYMg5YHl9+sqn9c0uaU2sjYqWfRCptqslqcRU1mKlyZb4SjVt3gCTKPUbIwuexA==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr4608851wmg.89.1572024365828;
        Fri, 25 Oct 2019 10:26:05 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.134])
        by smtp.gmail.com with ESMTPSA id z189sm3996981wmc.25.2019.10.25.10.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:26:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH v2] x86/hyper-v: micro-optimize send_ipi_one case
In-Reply-To: <DM5PR21MB013707183D9E271E60FBD435D7650@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191025131546.18794-1-vkuznets@redhat.com> <DM5PR21MB013707183D9E271E60FBD435D7650@DM5PR21MB0137.namprd21.prod.outlook.com>
Date:   Fri, 25 Oct 2019 19:26:03 +0200
Message-ID: <877e4sbutw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> 
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
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> Changes since v1:
>>  - Style changes [Roman, Joe]
>> ---
>>  arch/x86/hyperv/hv_apic.c           | 13 ++++++++++---
>>  arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
>>  2 files changed, 25 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
>> index e01078e93dd3..fd17c6341737 100644
>> --- a/arch/x86/hyperv/hv_apic.c
>> +++ b/arch/x86/hyperv/hv_apic.c
>> @@ -194,10 +194,17 @@ static bool __send_ipi_mask(const struct cpumask *mask, int
>> vector)
>> 
>>  static bool __send_ipi_one(int cpu, int vector)
>>  {
>> -	struct cpumask mask = CPU_MASK_NONE;
>> +	trace_hyperv_send_ipi_one(cpu, vector);
>> 
>> -	cpumask_set_cpu(cpu, &mask);
>> -	return __send_ipi_mask(&mask, vector);
>> +	if (!hv_hypercall_pg || (vector < HV_IPI_LOW_VECTOR) ||
>> +	    (vector > HV_IPI_HIGH_VECTOR))
>> +		return false;
>> +
>> +	if (cpu >= 64)
>> +		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
>
> The above test should be checking the VP number, not the CPU
> number,

Oops, of course, thanks for catching this! v3 is coming!

>  since the VP number is used to form the bitmap argument
> to the hypercall.  In all current implementations of Hyper-V, the CPU number
> and VP number are the same as far as I am aware, but that's not guaranteed in 
> the future.
>
> Michael
>
>> +
>> +	return !hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector,
>> +			       BIT_ULL(hv_cpu_number_to_vp_number(cpu)));
>>  }
>> 

-- 
Vitaly
