Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51E626EFD
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Nov 2022 11:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiKMKdP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Nov 2022 05:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiKMKdO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Nov 2022 05:33:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485F81209B;
        Sun, 13 Nov 2022 02:33:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668335590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4TqLSWP6GWKj5YwSytFV7lzD/9wH9qk82DCLCDjI7Q=;
        b=ZnXT97iJfkNsEAAdWyucQS4HWpNkyk+pZRyodnTMIoiABjz3mwOMocaEanITRKUp6C/Oii
        5OZVRp50cA9f84obyPGGqe/P21+jj+08WSCem1j2ZUVo7Qvq238VvbpA37ThNy+GHbR5zd
        DIm+FAw9T3mPAtngkhOnIsh2gltITOu33qFs9WLo1YPhHvTrYbHURKxyNzAmhQK8pUeIJw
        Hc3j+47noND8f7zqpUwDo0eIuZcpNbzwseT0R99Urap0qPFXFXOqncd6uaBpb9eY5LFID/
        f+7sf1jTR/HOKJ4VtVgzZYCpFc0fmwLDywYUuhC6Xw2zGCkYMv3kx2OGThmLxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668335590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4TqLSWP6GWKj5YwSytFV7lzD/9wH9qk82DCLCDjI7Q=;
        b=Jg9ICAyAxld4U1RxmjJXzsfgkRRnn6sFA/bzzHTHGYNCKu4bmegdakXqbLFkBVRGhnXqVR
        LBGFAakdXwqYtgAg==
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
In-Reply-To: <87wn7ztc89.ffs@tglx>
References: <87zgcwt2qg.ffs@tglx>
 <BYAPR21MB1688C5BCDF3269BA070DB884D7039@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87wn7ztc89.ffs@tglx>
Date:   Sun, 13 Nov 2022 11:33:09 +0100
Message-ID: <87sfinta8q.ffs@tglx>
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

On Sun, Nov 13 2022 at 10:50, Thomas Gleixner wrote:
> On Sat, Nov 12 2022 at 21:55, Michael Kelley wrote:
>> But I can see the problem with too much getting dragged into the VDSO
>> builds.  If hv_get_raw_timer() is added to hyperv_timer.h, it should
>> be under #ifdef CONFIG_X86.  Adding an #ifdef isn't ideal, and a more
>> more proper solution might be to have a separate hyperv_timer.h include
>> file under arch/x86/include/asm.  But the latter seems like overkill for just
>> hv_get_raw_timer(), so I'm OK with the #ifdef.
>
> We surely can have asm/hyperv_timer.h but TBH:
>
>>>  static inline notrace u64
>>>  hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
>>>  {
>
> hv_read_tsc_page_tsc() does not look architecture agnostic either. TSC
> is pretty x86 specific :)

Though the below makes sense on its own because it ensures that msr.h is
included, which is required for making clocksource/hyperv_timer.h self
contained.

Thanks,

        tglx
---
Subject: clocksource/drivers/hyper-v: Include asm/hyperv-tlfs.h not asm/mshyperv.h
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 12 Nov 2022 19:08:15 +0100

clocksource/hyperv_timer.h is included into the VDSO build. It includes
asm/mshyperv.h which in turn includes the world and some more. This worked
so far by chance, but any subtle change in the include chain results in a
build breakage because VDSO builds are building user space libraries.

Include asm/hyperv-tlfs.h instead which contains everything what the
VDSO build needs and move the hv_get_raw_timer() define into a separate
header file which also includes asm/msr.h to resolve rdtsc_ordered().

Fixup drivers/hv/vmbus_drv.c which relies on the indirect include of
asm/mshyperv.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hyperv_timer.h |    9 +++++++++
 arch/x86/include/asm/mshyperv.h     |    2 --
 drivers/hv/vmbus_drv.c              |    1 +
 include/clocksource/hyperv_timer.h  |    2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

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
@@ -15,7 +15,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/math64.h>
-#include <asm/mshyperv.h>
+#include <asm/hyperv-tlfs.h>
 
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
