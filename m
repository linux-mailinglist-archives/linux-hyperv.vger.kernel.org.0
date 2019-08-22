Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E898198CAB
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfHVHwT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 03:52:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730037AbfHVHwS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 03:52:18 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F07202A09CE
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Aug 2019 07:52:17 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id m7so2783778wrw.22
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Aug 2019 00:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7BKcrVO8Nhd+WXGWUEZTUpLjr5rNDrS+NAVt7gSeayI=;
        b=Kf7soFa7v8Dae6ImPOY00aU498RSWfxKjDMBFLYcRVIbA1x7t6G563VBHCb0Fw8kUV
         pYdbbscWzLwdpWlbh98WdQKRuPG5SjP1i9R21QsHatOZP5kEKDlce0Ka1AVxaiiBceG1
         I9vp4FIpNbibKXUvUs69TZjjJ8emhs5BaCSr4AnAkoN0LdOI9H6kyvP41XORasO3/7fo
         MbiNSfOZ/VhHIOT20q/IJ3k7mHroYd6Kzh2zkgo6U8HtK/+lJ6dmivP2cP5oYhS3TMMf
         y/T8qI10vaKlxV3I70Zl/5+esLy8mHIqSYCgRPaP6iHP4hVmkcVcWp1J4/YVu1QDU5rZ
         WSwA==
X-Gm-Message-State: APjAAAXQLQzHBrR3laL51VFqGcK05/Jb1tD6UBH15N8vOu+VDmvZ7YhB
        JBzeEiMAHBKsICMp+Lsk5YA96dOmacK57EVMU0AMzZlyGkkfqc+aybw7lo6WjljcvhpgNiQQhws
        MUkIix4kZOo3HDOQUDEj0zYj0
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr4324442wmh.122.1566460336705;
        Thu, 22 Aug 2019 00:52:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWuWvgDKAuh+xWDFJnsdBvnUFY6ufegdNELeez5PrP8mvCRsuw/nstCz8A23ZrVau0d9htVA==
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr4324415wmh.122.1566460336454;
        Thu, 22 Aug 2019 00:52:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i5sm26461922wrn.48.2019.08.22.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 00:52:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/hyper-v: enable TSC page clocksource on 32bit
In-Reply-To: <alpine.DEB.2.21.1908212321320.1983@nanos.tec.linutronix.de>
References: <20190821095650.1841-1-vkuznets@redhat.com> <alpine.DEB.2.21.1908212316040.1983@nanos.tec.linutronix.de> <alpine.DEB.2.21.1908212321320.1983@nanos.tec.linutronix.de>
Date:   Thu, 22 Aug 2019 09:52:14 +0200
Message-ID: <877e75r61d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, 21 Aug 2019, Thomas Gleixner wrote:
>
>> On Wed, 21 Aug 2019, Vitaly Kuznetsov wrote:
>> 
>> > There is no particular reason to not enable TSC page clocksource
>> > on 32-bit. mul_u64_u64_shr() is available and despite the increased
>> > computational complexity (compared to 64bit) TSC page is still a huge
>> > win compared to MSR-based clocksource.
>> > 
>> > In-kernel reads:
>> >   MSR based clocksource: 3361 cycles
>> >   TSC page clocksource: 49 cycles
>> > 
>> > Reads from userspace (unilizing vDSO in case of TSC page):
>> >   MSR based clocksource: 5664 cycles
>> >   TSC page clocksource: 131 cycles
>> > 
>> > Enabling TSC page on 32bits allows us to get rid of CONFIG_HYPERV_TSCPAGE
>> 
>> s/allows us/allows/
>> 
>> > as it is now not any different from CONFIG_HYPERV_TIMER.
>> > 
>> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> > ---
>> >  arch/x86/include/asm/vdso/gettimeofday.h |  6 +++---
>> >  drivers/clocksource/hyperv_timer.c       | 11 -----------
>> >  drivers/hv/Kconfig                       |  3 ---
>> >  include/clocksource/hyperv_timer.h       |  6 ++----
>> >  4 files changed, 5 insertions(+), 21 deletions(-)
>> 
>> Really nice cleanup as a side effect of adding functionality.
>
> That said, could you please rebase that on
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
>
> as I just applied the TSC page patches there and this conflicts left and
> right.

Sure, v2 is coming!

-- 
Vitaly
