Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E29CEB1
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2019 13:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfHZLzK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Aug 2019 07:55:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfHZLzK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Aug 2019 07:55:10 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2DaU-0001LY-NS; Mon, 26 Aug 2019 13:55:06 +0200
Date:   Mon, 26 Aug 2019 13:55:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     Sasha Levin <sashal@kernel.org>, lantianyu1986@gmail.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        daniel.lezcano@linaro.org, michael.h.kelley@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Fix build error with
 CONFIG_HYPERV_TSCPAGE=N
In-Reply-To: <87d0gso0jf.fsf@vitty.brq.redhat.com>
Message-ID: <alpine.DEB.2.21.1908261354140.1939@nanos.tec.linutronix.de>
References: <20190822053852.239309-1-Tianyu.Lan@microsoft.com> <87zhk1pp9p.fsf@vitty.brq.redhat.com> <20190824151218.GM1581@sasha-vm> <87d0gso0jf.fsf@vitty.brq.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 26 Aug 2019, Vitaly Kuznetsov wrote:
> Sasha Levin <sashal@kernel.org> writes:
> 
> > On Thu, Aug 22, 2019 at 10:39:46AM +0200, Vitaly Kuznetsov wrote:
> >>lantianyu1986@gmail.com writes:
> >>
> >>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >>>
> >>> Both Hyper-V tsc page and Hyper-V tsc MSR code use variable
> >>> hv_sched_clock_offset for their sched clock callback and so
> >>> define the variable regardless of CONFIG_HYPERV_TSCPAGE setting.
> >>
> >>CONFIG_HYPERV_TSCPAGE is gone after my "x86/hyper-v: enable TSC page
> >>clocksource on 32bit" patch. Do we still have an issue to fix?
> >
> > Yes. Let's get it fixed on older kernels (as such we need to tag this
> > one for stable). The 32bit TSC patch won't come in before 5.4 anyway.
> >
> > Vitaly, does can you ack this patch? It might require you to re-spin
> > your patch.
> >
> 
> Sure, no problem,
> 
> Acked-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> I, however, was under the impression the patch fixes the issue with the
> newly introduced sched clock:
> 
> commit b74e1d61dbc614ff35ef3ad9267c61ed06b09051
> Author: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Date:   Wed Aug 14 20:32:16 2019 +0800
> 
>     clocksource/hyperv: Add Hyper-V specific sched clock function
> 
> (and Fixes: tag is missing)
> 
> and this is not in mainline as of v5.3-rc6. In tip/timers/core Thomas
> already picked my "clocksource/drivers/hyperv: Enable TSC page
> clocksource on 32bit" which also resolves the issue.

No. I folded Sashas fix into the original clocksource patch and then added
yours on top.

Thanks,

	tglx
