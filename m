Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294E0C01C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Sep 2019 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfI0JF3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 Sep 2019 05:05:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0JF3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 Sep 2019 05:05:29 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F38F63704
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Sep 2019 09:05:28 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id s25so1962507wmh.1
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Sep 2019 02:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bbUXI7HnyvMO5i/vr47nNTN4Si9R/+ix2Rzt2/ZHUhs=;
        b=AyGS9fPez9cAqxlJxOPp5AdK65PFGFVFiyusvmbQR5QUP/WVCNnXuwoPaJtogwarFV
         CGpKaQKWw6pB/zwZHoHXNqFPzDmgHR7G7EltGHiGVl1RtJKFDuMEORR3tJUeXsu6rNKw
         ziApBbtZ1naeBsB7p8nEUXGBDL2W0lwK9fupcTy/m7YxdsQoUhjt6hLnI/9iGtSJXKV0
         oqelW5v8oFun7vg+UWDM7ggPrZjs/k9ScYQxrgHddgj1Whj8goc9FT5COB3Wkk/1V0sP
         8/V+t0pI4/6AOctIAmSTB3WRe5ivf7w/f492W386xrZr8b1yaASjNZi16Su9V4CS4fQg
         IIKQ==
X-Gm-Message-State: APjAAAXxlA6OxKRpm0H4wlwwIorYNaqki2Dxv4GGHb8427MDBt9bJd2l
        96WJ3AbXfMcY5u/tNCK8xUlx3KK1RpHs602F5FqaTZTt8+LqXnAUQlhWbNxr4TDRw1ZfegZTIHl
        JotOVLRp9YmRiMUYCIZUQnJFV
X-Received: by 2002:adf:e692:: with SMTP id r18mr1981248wrm.339.1569575126800;
        Fri, 27 Sep 2019 02:05:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPOcDzEUz+3oqTj5hKkr/Dy8Oktp+i4+1rcA8T68L3TfE+56f5nDqHHhlKeou23g29xgZxEQ==
X-Received: by 2002:adf:e692:: with SMTP id r18mr1981220wrm.339.1569575126530;
        Fri, 27 Sep 2019 02:05:26 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.182])
        by smtp.gmail.com with ESMTPSA id w18sm5380136wmc.9.2019.09.27.02.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 02:05:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd\@arndb.de" <arnd@arndb.de>, "bp\@alien8.de" <bp@alien8.de>,
        "daniel.lezcano\@linaro.org" <daniel.lezcano@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa\@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "x86\@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for hibernation
In-Reply-To: <PU1P153MB01695A159E9843B4E1EC13AEBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com> <1567723581-29088-2-git-send-email-decui@microsoft.com> <87ef0372wv.fsf@vitty.brq.redhat.com> <PU1P153MB01695A159E9843B4E1EC13AEBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Date:   Fri, 27 Sep 2019 11:05:24 +0200
Message-ID: <877e5u6re3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Sent: Thursday, September 26, 2019 3:44 AM
>> > [...]
>> > +static int hv_suspend(void)
>> > +{
>> > +	union hv_x64_msr_hypercall_contents hypercall_msr;
>> > +
>> > +	/* Reset the hypercall page */
>> > +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> > +	hypercall_msr.enable = 0;
>> > +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> > +
>> 
>> (trying to think out loud, not sure there's a real issue):
>> 
>> When PV IPIs (or PV TLB flush) are enabled we do the following checks:
>> 
>> 	if (!hv_hypercall_pg)
>> 		return false;
>> 
>> or
>>         if (!hv_hypercall_pg)
>>                 goto do_native;
>> 
>> which will pass as we're not invalidating the pointer. Can we actually
>> be sure that the kernel will never try to send an IPI/do TLB flush
>> before we resume?
>> 
>> Vitaly
>
> When hv_suspend() and hv_resume() are called by syscore_suspend()
> and syscore_resume(), respectively, all the non-boot CPUs are disabled and
> only CPU0 is active and interrupts are disabled, e.g. see
>
> hibernate() -> 
>   hibernation_snapshot() ->
>     create_image() ->
>       suspend_disable_secondary_cpus()
>       local_irq_disable()
>
>       syscore_suspend()
>       swsusp_arch_suspend
>       syscore_resume
>
>       local_irq_enable
>       enable_nonboot_cpus
>
>
> So, I'm pretty sure no IPI can happen between hv_suspend() and hv_resume().
> self-IPI is not supposed to happen either, since interrupts are disabled.
>
> IMO TLB flush should not be an issue either, unless the kernel changes page
> tables between hv_suspend() and hv_resume(), which is not the case as I
> checked the related code, but it looks in theory that might happen, say, in
> the future, so if you insist we should save the variable "hv_hypercall_pg"
> to a temporary variable and set the "hv_hypercall_pg" to NULL before we
> disable the hypercall page

Let's do it as a future proof so we can keep relying on !hv_hypercall_pg
everywhere we need. No need to change this patch IMO, a follow-up would
do.

-- 
Vitaly
