Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE23137F37A
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 May 2021 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhEMHTw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 May 2021 03:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230271AbhEMHTw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 May 2021 03:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620890322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gLt6isweW7Of4V0VRlG6qMcSWB/PO2aDoJW/Li5V43Y=;
        b=dj/LR/IExB2tonRIjbFeYARtrrfTebazTgh61wKlVNGKQhvt39ejMSfl+RaGuVUTGg7EPw
        nZ5xO+mPa1ALnnwgDqFwc/hA3dZlcAB2XAuA41rOHch24JJbaUhoocM4ACLMNI2UnkcgfG
        UK//GXq7k10bbBaoPBU9IECq+mXoR0Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-981XugslO5y564F57eDMQg-1; Thu, 13 May 2021 03:18:40 -0400
X-MC-Unique: 981XugslO5y564F57eDMQg-1
Received: by mail-wm1-f71.google.com with SMTP id s66-20020a1ca9450000b0290149fce15f03so563747wme.9
        for <linux-hyperv@vger.kernel.org>; Thu, 13 May 2021 00:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gLt6isweW7Of4V0VRlG6qMcSWB/PO2aDoJW/Li5V43Y=;
        b=Ivmv0HpssI55TLmUMkfZH+owCHTg8rm8BFQhlVliJdqMHeeZtRsulyrT7JqKhfaHje
         +KcABX7o85fZocLqvq9i+q6eOYxMxILKU0mP1IJ+XJ7tD6xak+5VUB2ynt0dpOVKERFh
         n/sk1YpumBleNeILMF5QgV8MOqLXjg6+afmHEbvQUnaPg3jbDoP+Ld/vMpZRXMfZPLlf
         K4aB7flOK4Iz3uIZjMb1ix0IUOrDT+GPRErSX6lygvYhePyoj3807Df1aZsHQpHlWjV4
         pWZFJqWD2kRGxJ8ZpAegQaPwFG5nOJNDxZYMBINgfzlh+VHBRWnAY7IB1E8rxkQtbHrk
         a5BA==
X-Gm-Message-State: AOAM530YoupcrRSVGKbmj20OBdJGyjG/j98HZ5ATiDvck3J4xS+PdKZj
        ktGZ25kR0/TNduV7C4jRdb8yyVqwWykX4QFJ+0o/89ydSmwzdRfMbGq56dHvPNjFT8WRcEG7YrF
        /XjIZSYsmR4GttPrONHplSf/g
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr2348406wml.124.1620890319507;
        Thu, 13 May 2021 00:18:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw58sP/KR07sIuGOMVJD/MVh/vb1GdsVaVmjtJVN7q1nGkqTTfrcasqqGWKpaqu3VfdHiL4aA==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr2348383wml.124.1620890319307;
        Thu, 13 May 2021 00:18:39 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p14sm1966485wrm.70.2021.05.13.00.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 00:18:38 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-hyperv@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mohammed Gamal <mgamal@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/hyper-v: Re-enable
 VDSO_CLOCKMODE_HVCLOCK on X86
In-Reply-To: <87tun766kv.ffs@nanos.tec.linutronix.de>
References: <20210512084630.1662011-1-vkuznets@redhat.com>
 <87tun766kv.ffs@nanos.tec.linutronix.de>
Date:   Thu, 13 May 2021 09:18:37 +0200
Message-ID: <8735urw182.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, May 12 2021 at 10:46, Vitaly Kuznetsov wrote:
>> Mohammed reports (https://bugzilla.kernel.org/show_bug.cgi?id=213029)
>> the commit e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO
>> differences inline") broke vDSO on x86. The problem appears to be that
>> VDSO_CLOCKMODE_HVCLOCK is an enum value in 'enum vdso_clock_mode' and
>> '#ifdef VDSO_CLOCKMODE_HVCLOCK' branch evaluates to false (it is not
>> a define). Replace it with CONFIG_X86 as it is the only arch which
>> has this mode currently.
>>
>> Reported-by: Mohammed Gamal <mgamal@redhat.com>
>> Fixes: e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO differences inline")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/clocksource/hyperv_timer.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
>> index 977fd05ac35f..e17421f5e47d 100644
>> --- a/drivers/clocksource/hyperv_timer.c
>> +++ b/drivers/clocksource/hyperv_timer.c
>> @@ -419,7 +419,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
>>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>>  }
>>  
>> -#ifdef VDSO_CLOCKMODE_HVCLOCK
>> +#ifdef CONFIG_X86
>>  static int hv_cs_enable(struct clocksource *cs)
>>  {
>>  	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
>> @@ -435,7 +435,7 @@ static struct clocksource hyperv_cs_tsc = {
>>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>>  	.suspend= suspend_hv_clock_tsc,
>>  	.resume	= resume_hv_clock_tsc,
>> -#ifdef VDSO_CLOCKMODE_HVCLOCK
>> +#ifdef CONFIG_X86
>>  	.enable = hv_cs_enable,
>>  	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
>>  #else
>
> That's lame as it needs to be patched differently once ARM64 gains
> support. What about the below?
>

The solution I liked the most was Michael's: no need to do anything
except for adding VDSO_CLOCKMODE_HVCLOCK to the enum. Too bad it didn't
work)

You proposal seems to be slightly better than mine: when adding
VDSO_CLOCKMODE_HVCLOCK to ARM the change will be limited to
drivers/clocksource/hyperv_timer.c will stay intact.

I'll send v2 shortly, thanks!


> Thanks,
>
>         tglx
> ---
> --- a/arch/x86/include/asm/vdso/clocksource.h
> +++ b/arch/x86/include/asm/vdso/clocksource.h
> @@ -7,4 +7,6 @@
>  	VDSO_CLOCKMODE_PVCLOCK,	\
>  	VDSO_CLOCKMODE_HVCLOCK
>  
> +#define HAVE_VDSO_CLOCKMODE_HVCLOCK
> +
>  #endif /* __ASM_VDSO_CLOCKSOURCE_H */
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -419,7 +419,7 @@ static void resume_hv_clock_tsc(struct c
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>  }
>  
> -#ifdef VDSO_CLOCKMODE_HVCLOCK
> +#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
>  static int hv_cs_enable(struct clocksource *cs)
>  {
>  	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> @@ -435,7 +435,7 @@ static struct clocksource hyperv_cs_tsc
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>  	.suspend= suspend_hv_clock_tsc,
>  	.resume	= resume_hv_clock_tsc,
> -#ifdef VDSO_CLOCKMODE_HVCLOCK
> +#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
>  	.enable = hv_cs_enable,
>  	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
>  #else
>

-- 
Vitaly

