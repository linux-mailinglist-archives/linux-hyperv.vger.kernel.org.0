Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E217C62CB85
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Nov 2022 21:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiKPUwy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Nov 2022 15:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiKPUwa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Nov 2022 15:52:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD0963B9D;
        Wed, 16 Nov 2022 12:52:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668631947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33J5BD3tpOzz0XsMXF5A2OumpToZnyzGEePA9xQwZn0=;
        b=EpyHVR7gyrCyXJL9CcGKJOYB/RjC+W7AlH8xKC/vcZ5wVNqtlBANLmpDqMo0ZtjIGnmWLY
        pTd9r9HxGoOT/EEwE5Ybgaeg8bJRfal78kY+2GhEJjtPzbdRLZTbiFOYuIz+nBczEUcvzs
        vcvwqwSs7UK0SiG1oo2q4/f79jAa94nTQxXBVJMQR+hgrU9ouX5de4MIpPVMqKRuyrtfnk
        /Jtf/dDxJW3HbGYwg/bw3P8/pcPa15unfLj0S2PbwpiSpn+s1o7HGWMu9bJqcb7HgO1pB0
        ZJXwk9iB2jQbgHfWHcE0WbTz+GuNFSbyE5yW2287jMulsr1Ry1BD14f3A24+sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668631947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33J5BD3tpOzz0XsMXF5A2OumpToZnyzGEePA9xQwZn0=;
        b=bQ/iiX/xd+FgZdfYSqeEeN1dFeG+IhxZkOFIV4csii4NpB/tP5VT53rLO4YKXZO4pPwy0v
        cLDBgbpcfIAJVuAA==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: RE: [PATCH] clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h
 not asm/mshyperv.h
In-Reply-To: <87fsemtut0.ffs@tglx>
References: <87zgcwt2qg.ffs@tglx>
 <BYAPR21MB1688C5BCDF3269BA070DB884D7039@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87wn7ztc89.ffs@tglx> <87sfinta8q.ffs@tglx> <87leoft9w1.ffs@tglx>
 <87fsemtut0.ffs@tglx>
Date:   Wed, 16 Nov 2022 21:52:26 +0100
Message-ID: <8735aipqph.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael!

On Sun, Nov 13 2022 at 22:21, Thomas Gleixner wrote:
> Subject: clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h not asm/mshyperv.h
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Sat, 12 Nov 2022 19:08:15 +0100
>
> clocksource/hyperv_timer.h is included into the VDSO build. It includes
> asm/mshyperv.h which in turn includes the world and some more. This worked
> so far by chance, but any subtle change in the include chain results in a
> build breakage because VDSO builds are building user space libraries.
>
> Include asm/hyperv-tlfs.h instead which contains everything what the VDSO
> build needs and move the hv_get_raw_timer() define into the header file.
>
> Fixup drivers/hv/vmbus_drv.c which relies on the indirect include of
> asm/mshyperv.h.

Any comments on this latest version?

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/hyperv_timer.h |    9 +++++++++
>  arch/x86/include/asm/mshyperv.h     |    2 --
>  drivers/hv/vmbus_drv.c              |    1 +
>  include/clocksource/hyperv_timer.h  |    4 +++-
>  4 files changed, 13 insertions(+), 3 deletions(-)
>
> --- /dev/null
> +++ b/arch/x86/include/asm/hyperv_timer.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_HYPERV_TIMER_H
> +#define _ASM_X86_HYPERV_TIMER_H
> +
> +#include <asm/msr.h>
> +
> +#define hv_get_raw_timer() rdtsc_ordered()
> +
> +#endif
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -19,8 +19,6 @@ typedef int (*hyperv_fill_flush_list_fun
>  		struct hv_guest_mapping_flush_list *flush,
>  		void *data);
>  
> -#define hv_get_raw_timer() rdtsc_ordered()
> -
>  void hyperv_vector_handler(struct pt_regs *regs);
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -37,6 +37,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
>  
>  struct vmbus_dynid {
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -15,13 +15,15 @@
>  
>  #include <linux/clocksource.h>
>  #include <linux/math64.h>
> -#include <asm/mshyperv.h>
> +#include <asm/hyperv-tlfs.h>
>  
>  #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
>  #define HV_MIN_DELTA_TICKS 1
>  
>  #ifdef CONFIG_HYPERV_TIMER
>  
> +#include <asm/hyperv_timer.h>
> +
>  /* Routines called by the VMbus driver */
>  extern int hv_stimer_alloc(bool have_percpu_irqs);
>  extern int hv_stimer_cleanup(unsigned int cpu);
