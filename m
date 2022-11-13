Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E7B626F05
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Nov 2022 11:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiKMKku (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Nov 2022 05:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiKMKkt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Nov 2022 05:40:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C23E024;
        Sun, 13 Nov 2022 02:40:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668336047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nJIogjb23g2iwaYQky8Pvr9tey5SCj3CTnvgdKP0mhw=;
        b=ew+t0EJUulBq6cZ3fcTp3EDuvhEf6E0EG+C3DJn0P+oMDLm3l0I/hSGP1Kih/31fH/YjuC
        clabFiKqzhEwFfBucZIoaFSQ5QHIEA68ghAEPY1aiRnafIXsVhZhMrkwX0H26nWwEHNRZL
        H42VRxMS+AaSgg7UTyOlaZJ+RhxGmo05XIH/Hqj9fdU+IZCIR7cBE3/GX6CSLGLxS3+f6o
        4HjxZe6NpOJ2FukBnkUKpRYIBi54XjJIfO5/4q8XtcTyZmktf+4esfmNLs59jYJu8hJs5T
        OYrf1OU2TcKeqYvQQDJk3/JbJcwIFiDLJnVnoJiuverIswt7nHT3xVdkODZOvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668336047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nJIogjb23g2iwaYQky8Pvr9tey5SCj3CTnvgdKP0mhw=;
        b=qkM46/Z8vtksTb+qdA9tHbDCOLARvxYd4KHJqhAM0CcyT5mXEcTfPz1O8/ixlzrFJovHJR
        +gNLI7Vto/Ve+5CA==
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
In-Reply-To: <87sfinta8q.ffs@tglx>
References: <87zgcwt2qg.ffs@tglx>
 <BYAPR21MB1688C5BCDF3269BA070DB884D7039@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87wn7ztc89.ffs@tglx> <87sfinta8q.ffs@tglx>
Date:   Sun, 13 Nov 2022 11:40:46 +0100
Message-ID: <87leoft9w1.ffs@tglx>
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

On Sun, Nov 13 2022 at 11:33, Thomas Gleixner wrote:
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -15,7 +15,7 @@
>  
>  #include <linux/clocksource.h>
>  #include <linux/math64.h>
> -#include <asm/mshyperv.h>
> +#include <asm/hyperv-tlfs.h>

Bah, that obviously wants to include the new header...

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
 include/clocksource/hyperv_timer.h  |    3 ++-
 4 files changed, 12 insertions(+), 3 deletions(-)

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
@@ -15,7 +15,8 @@
 
 #include <linux/clocksource.h>
 #include <linux/math64.h>
-#include <asm/mshyperv.h>
+#include <asm/hyperv_timer.h>
+#include <asm/hyperv-tlfs.h>
 
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
