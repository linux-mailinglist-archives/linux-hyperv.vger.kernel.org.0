Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD3598672
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Aug 2019 23:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfHUVRj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 17:17:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57695 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfHUVRj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 17:17:39 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0Xz6-0005hh-PC; Wed, 21 Aug 2019 23:17:36 +0200
Date:   Wed, 21 Aug 2019 23:17:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
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
In-Reply-To: <20190821095650.1841-1-vkuznets@redhat.com>
Message-ID: <alpine.DEB.2.21.1908212316040.1983@nanos.tec.linutronix.de>
References: <20190821095650.1841-1-vkuznets@redhat.com>
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

On Wed, 21 Aug 2019, Vitaly Kuznetsov wrote:

> There is no particular reason to not enable TSC page clocksource
> on 32-bit. mul_u64_u64_shr() is available and despite the increased
> computational complexity (compared to 64bit) TSC page is still a huge
> win compared to MSR-based clocksource.
> 
> In-kernel reads:
>   MSR based clocksource: 3361 cycles
>   TSC page clocksource: 49 cycles
> 
> Reads from userspace (unilizing vDSO in case of TSC page):
>   MSR based clocksource: 5664 cycles
>   TSC page clocksource: 131 cycles
> 
> Enabling TSC page on 32bits allows us to get rid of CONFIG_HYPERV_TSCPAGE

s/allows us/allows/

> as it is now not any different from CONFIG_HYPERV_TIMER.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/vdso/gettimeofday.h |  6 +++---
>  drivers/clocksource/hyperv_timer.c       | 11 -----------
>  drivers/hv/Kconfig                       |  3 ---
>  include/clocksource/hyperv_timer.h       |  6 ++----
>  4 files changed, 5 insertions(+), 21 deletions(-)

Really nice cleanup as a side effect of adding functionality.

Thanks,

	tglx
