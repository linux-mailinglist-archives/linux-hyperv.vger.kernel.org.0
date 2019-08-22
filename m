Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F043898EF5
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbfHVJOc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 05:14:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33187 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfHVJOc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 05:14:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so3544152pfq.0;
        Thu, 22 Aug 2019 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bGJNIGeHShUi2KAJrnIfqaAZ76Q6jv5SalNCR03uoY=;
        b=GD8Za+nahfu3tp60ifZ+TzNV/Gc7aWKBoy5u7inJdjfDv3ymB2vWFu6vh+Tl1WP+UG
         BoAX6Ro4izBSvkVZO5dyZ9TjfcRMO050Hv45zvqXhgXrs2UiZFfy4CnrZ0YLB0zfcP51
         lLtA2Pt6KeIjM8pvdC2pn3vHGPHJp4sJ474i39Ij9g778nhvsVoR6LRHf65MpuzkJ9Gb
         hFPr1GadkjKLZYrT32rtx06Zsx3xNsgOShPAzlSRlqutdN+YqzlFsMPnLVnE6d2w0cGE
         /TCRwBnwDOflX4L57uKN7sC/USfVMT21usbtwy8jgHdss237aChRIG529Pf5xHqL6HVK
         wF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bGJNIGeHShUi2KAJrnIfqaAZ76Q6jv5SalNCR03uoY=;
        b=Hrd8V/L4/uXVkAuhpGUAWt7aNTETMKsSCB28Tp2ELbA4VSWQzWvB+8quj/pWy6U+9G
         ePecPC6k6yJtYKN3welhKNMEWTKDSfRDJ4XB+kcAaCFS+rTiJ0JZbJfPXzVbo2y0s7Wb
         an1hSc/IgWbmYoOwf9U/mPQ2T40kl4R1UK57e902M6Ow/tFQSZaj2Zt+ya/3K46LMr7E
         4ZS74WEYqIEfgxS3da3j+V7KdiTkCyH+ONZn49Yc3djw3mvVTFc1G6s0H2xRlRfTXf+0
         4KgFT4x6SVyOTcb+xys9UWm0NnMvPJJhXGGwC3PC/5PQZwdlgXFwVH0IhwclB/vpPET9
         J3yw==
X-Gm-Message-State: APjAAAVKTnq792fZwRXMHV8e5h+wPcasZOMKDAelp1Ww1gKKsItuhxTy
        kvxTJg7Dya6nxMoPrgCpEbj+rS8Q+efPUdNmSE4=
X-Google-Smtp-Source: APXvYqzUXOoO7jdGPjAKWz7nXwmlWYmfzAsnoLiS84XqAjcFRWSGZ/WnSNWu1MT5YbHpr7hkfHM0M3VTjLpmlKd9Ct4=
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr4315418pjb.68.1566465271506;
 Thu, 22 Aug 2019 02:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190822053852.239309-1-Tianyu.Lan@microsoft.com> <87zhk1pp9p.fsf@vitty.brq.redhat.com>
In-Reply-To: <87zhk1pp9p.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Thu, 22 Aug 2019 17:14:20 +0800
Message-ID: <CAOLK0px+=yGoXnGw_e_wC=pVAw+Op5f7dtgjaczLUT_edukfSA@mail.gmail.com>
Subject: Re: [PATCH] x86/Hyper-V: Fix build error with CONFIG_HYPERV_TSCPAGE=N
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        michael.h.kelley@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 22, 2019 at 4:39 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> lantianyu1986@gmail.com writes:
>
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >
> > Both Hyper-V tsc page and Hyper-V tsc MSR code use variable
> > hv_sched_clock_offset for their sched clock callback and so
> > define the variable regardless of CONFIG_HYPERV_TSCPAGE setting.
>
> CONFIG_HYPERV_TSCPAGE is gone after my "x86/hyper-v: enable TSC page
> clocksource on 32bit" patch. Do we still have an issue to fix?
>
Hi Vtialy:
             Your patch also fixs the build issue. If it's not
necessary to have a dedicated patch
to fix the issue, please ignore it. Thanks.

> >
> > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > ---
> > This patch is based on the top of "git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > timers/core".
> >
> >  drivers/clocksource/hyperv_timer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> > index dad8af198e20..c322ab4d3689 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -22,6 +22,7 @@
> >  #include <asm/mshyperv.h>
> >
> >  static struct clock_event_device __percpu *hv_clock_event;
> > +static u64 hv_sched_clock_offset __ro_after_init;
> >
> >  /*
> >   * If false, we're using the old mechanism for stimer0 interrupts
> > @@ -215,7 +216,6 @@ EXPORT_SYMBOL_GPL(hyperv_cs);
> >  #ifdef CONFIG_HYPERV_TSCPAGE
> >
> >  static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
> > -static u64 hv_sched_clock_offset __ro_after_init;
> >
> >  struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> >  {
>
> --
> Vitaly



-- 
Best regards
Tianyu Lan
