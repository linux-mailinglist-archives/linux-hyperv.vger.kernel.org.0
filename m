Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8693768CBE2
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Feb 2023 02:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBGBYb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Feb 2023 20:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBGBYa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Feb 2023 20:24:30 -0500
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 17:24:28 PST
Received: from njjs-sys-mailin01.njjs.baidu.com (mx316.baidu.com [180.101.52.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 506B61E2B6;
        Mon,  6 Feb 2023 17:24:28 -0800 (PST)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 1C4C37F00053;
        Tue,  7 Feb 2023 09:14:36 +0800 (CST)
From:   lirongqing@baidu.com
To:     seanjc@google.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in shutdown
Date:   Tue,  7 Feb 2023 09:14:36 +0800
Message-Id: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

Zeroing the counter register in pit_shutdown() isn't actually supposed to
stop it from counting,  will causes the PIT to start running again,
From the spec:

  The largest possible initial count is 0; this is equivalent to 216 for
  binary counting and 104 for BCD counting.

  The Counter does not stop when it reaches zero. In Modes 0, 1, 4, and 5 the
  Counter "wraps around" to the highest count, either FFFF hex for binary
  count- ing or 9999 for BCD counting, and continues counting.

  Mode 0 is typically used for event counting. After the Control Word is
  written, OUT is initially low, and will remain low until the Counter
  reaches zero. OUT then goes high and remains high until a new count or a
  new Mode 0 Control Word is written into the Counter.

Hyper-V and KVM follow the spec, the issue that 35b69a42 "(clockevents/drivers/
i8253: Add support for PIT shutdown quirk") fixed is in i8253 drivers, not Hyper-v,
so delete the zero timer counter register in shutdown, and delete PIT shutdown
quirk for Hyper-v

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 11 -----------
 drivers/clocksource/i8253.c    | 12 ------------
 include/linux/i8253.h          |  1 -
 3 files changed, 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 46668e2..f788889 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
-#include <linux/i8253.h>
 #include <linux/random.h>
 #include <linux/swiotlb.h>
 #include <asm/processor.h>
@@ -399,16 +398,6 @@ static void __init ms_hyperv_init_platform(void)
 	if (efi_enabled(EFI_BOOT))
 		x86_platform.get_nmi_reason = hv_get_nmi_reason;
 
-	/*
-	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
-	 * counter register during PIT shutdown restarts the PIT. So it
-	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
-	 * to false tells pit_shutdown() not to zero the counter so that
-	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
-	 * and setting this value has no effect.
-	 */
-	i8253_clear_counter_on_shutdown = false;
-
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
 	 * Setup the hook to get control post apic initialization.
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index d4350bb..169474d 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -20,13 +20,6 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-/*
- * Handle PIT quirk in pit_shutdown() where zeroing the counter register
- * restarts the PIT, negating the shutdown. On platforms with the quirk,
- * platform specific code can set this to false.
- */
-bool i8253_clear_counter_on_shutdown __ro_after_init = true;
-
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -117,11 +110,6 @@ static int pit_shutdown(struct clock_event_device *evt)
 
 	outb_p(0x30, PIT_MODE);
 
-	if (i8253_clear_counter_on_shutdown) {
-		outb_p(0, PIT_CH0);
-		outb_p(0, PIT_CH0);
-	}
-
 	raw_spin_unlock(&i8253_lock);
 	return 0;
 }
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index 8336b2f..e6bb36a 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,7 +21,6 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
-extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 
-- 
2.9.4

