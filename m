Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134AD6272AE
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Nov 2022 22:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiKMVVT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Nov 2022 16:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiKMVVS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Nov 2022 16:21:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17C6556;
        Sun, 13 Nov 2022 13:21:17 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668374476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WqA9eQpqg/Hiw5ww9rnS051/wTFYpXZ9ePTy08MS9E0=;
        b=CnQ6NWad4KySG53EzK9w8HVjWcU9MBKDbHBXvpVhHzu03lruTcG4QS7bSTNuXvsxKXwXcz
        549hdVOxTevATh1QHxvUfuqabEXCCXGMmQr0YM+xMFj0xyIGIjhPJbEVaON3rBCzetaRrX
        lyxQuHzBkpK9tCtfxVaF1B/7G4n6Y7gNQP1w3vsdJUu8aLs3T5eF+23DrX9FCVuzVzf6Lc
        Q+xzs2FhOWDJ2mPcLeBrCNU9GZ1JCyuEdtDjlhMw4EDhG5jQgUGo+SXRKbNr/qr5oonD4l
        77fgr0iHm+m/YhdKseH859aZBzBexqRl3rUaPQpyVCjpgqRiLlIpC5pLWGgWiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668374476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WqA9eQpqg/Hiw5ww9rnS051/wTFYpXZ9ePTy08MS9E0=;
        b=Xmk/TudIVbnwagakcUpIVMgdZRuT9ezMSJRfzWC57xPb8aGp0CO342lbi9TEHJcb1Ls/Ms
        V+tUzDxO8IleM5DA==
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
In-Reply-To: <87leoft9w1.ffs@tglx>
References: <87zgcwt2qg.ffs@tglx>
 <BYAPR21MB1688C5BCDF3269BA070DB884D7039@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87wn7ztc89.ffs@tglx> <87sfinta8q.ffs@tglx> <87leoft9w1.ffs@tglx>
Date:   Sun, 13 Nov 2022 22:21:15 +0100
Message-ID: <87fsemtut0.ffs@tglx>
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

On Sun, Nov 13 2022 at 11:40, Thomas Gleixner wrote:
> Bah, that obviously wants to include the new header...
>
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -15,7 +15,8 @@
>  
>  #include <linux/clocksource.h>
>  #include <linux/math64.h>
> -#include <asm/mshyperv.h>
> +#include <asm/hyperv_timer.h>

and that breaks when CONFIG_HYPERV_TIMER=n and compiled for ARM64.

Sigh...

---
Subject: clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h not asm/mshyperv.h
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 12 Nov 2022 19:08:15 +0100

clocksource/hyperv_timer.h is included into the VDSO build. It includes
asm/mshyperv.h which in turn includes the world and some more. This worked
so far by chance, but any subtle change in the include chain results in a
build breakage because VDSO builds are building user space libraries.

Include asm/hyperv-tlfs.h instead which contains everything what the VDSO
build needs and move the hv_get_raw_timer() define into the header file.

Fixup drivers/hv/vmbus_drv.c which relies on the indirect include of
asm/mshyperv.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hyperv_timer.h |    9 +++++++++
 arch/x86/include/asm/mshyperv.h     |    2 --
 drivers/hv/vmbus_drv.c              |    1 +
 include/clocksource/hyperv_timer.h  |    4 +++-
 4 files changed, 13 insertions(+), 3 deletions(-)

--- /dev/null
+++ b/arch/x86/include/asm/hyperv_timer.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_HYPERV_TIMER_H
+#define _ASM_X86_HYPERV_TIMER_H
+
+#include <asm/msr.h>
+
+#define hv_get_raw_timer() rdtsc_ordered()
+
+#endif
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -19,8 +19,6 @@ typedef int (*hyperv_fill_flush_list_fun
 		struct hv_guest_mapping_flush_list *flush,
 		void *data);
 
-#define hv_get_raw_timer() rdtsc_ordered()
-
 void hyperv_vector_handler(struct pt_regs *regs);
 
 #if IS_ENABLED(CONFIG_HYPERV)
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -37,6 +37,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
 #include <clocksource/hyperv_timer.h>
+#include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
 
 struct vmbus_dynid {
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -15,13 +15,15 @@
 
 #include <linux/clocksource.h>
 #include <linux/math64.h>
-#include <asm/mshyperv.h>
+#include <asm/hyperv-tlfs.h>
 
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
 
 #ifdef CONFIG_HYPERV_TIMER
 
+#include <asm/hyperv_timer.h>
+
 /* Routines called by the VMbus driver */
 extern int hv_stimer_alloc(bool have_percpu_irqs);
 extern int hv_stimer_cleanup(unsigned int cpu);
