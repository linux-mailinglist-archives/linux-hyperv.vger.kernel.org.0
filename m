Return-Path: <linux-hyperv+bounces-2673-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A079A945EED
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 15:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA9B1F21B0E
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9B61E213C;
	Fri,  2 Aug 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SOvEXJCa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E549481AA;
	Fri,  2 Aug 2024 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606968; cv=none; b=HGbikKPbfwBM3rEmOelT5MDLLkyotsWWmxyLl/0rbJJy2KgGdmZ+b6LfroWPMoSm9IvyfeG5XX7BK3M52F11ZBseothiYUAuekRRZ2A/RJdQuDlPZq0+GF/3OQjrrGxINW3DmLojcG7enVvtjwItvINM3cBGC5HtLv8/IDbKErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606968; c=relaxed/simple;
	bh=9i62uvU3vquQ4VDYBNi7Pj/dTMaRPf4gQonktvDOnC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCfx6AmTRiWTdG49T8izAX1wDUfJ5fqfNBcC0rzaOBVjHiob3hyQxY7UZ99ZRjhnSc4Wj+lZd2kLfewBwbzhlUpWFC0nBiphppgpKHlfY04FnW5RDVkjWK6xi2gV/gJrJmtfPv8rH8IIdrLgKxkE3z+51HPLvA9oD9pbM2C0bio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SOvEXJCa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vkQpZz2gsBF/v6Di7+RwfMjdxIpkChfuRjXsssMC83Q=; b=SOvEXJCaLqHsMVXb7hwyiRjpo2
	by2Lc43sDAzx3HGXnVI75PwrVKl/6DMoa3mibxvbrA3S6KXEakfbA38/4sSEIwe8mpVOD3aq95hXg
	Rslez+ur2gPnGe2Bsp0VGxckDzVe2ZQE8H4mZY3UwNizqH5WgdyW+xj1x+NB5olMx2r8oS8wlIquY
	fxxa4Bc5gWbyuTr+6iyOW9gSe5Pr9xYBwEeUGXfX8g+WVuizLIzPLRNP8B7+lK80XaRoJwIMTzyO0
	+ubJV8gEtjWSoYkANthBWsW6CXsVZdN4XrmmoQRPkeKjJ5FNK65nemrs3XQjHzaaWbBbkKrv1Jo5o
	hTtu0i6w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZslA-0000000155l-0put;
	Fri, 02 Aug 2024 13:55:56 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZsl9-00000002MyB-3Z2g;
	Fri, 02 Aug 2024 14:55:55 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: tglx@linuxtronix.de,
	x86@kernel.org
Cc: lirongqing@baidu.com,
	seanjc@google.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 2/2] i8253: Fix stop sequence for timer 0
Date: Fri,  2 Aug 2024 14:55:55 +0100
Message-ID: <20240802135555.564941-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240802135555.564941-1-dwmw2@infradead.org>
References: <20240802135555.564941-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

According to the data sheet, writing the MODE register should stop the
counter (and thus the interrupts). This appears to work on real hardware,
at least modern Intel and AMD systems. It should also work on Hyper-V.

However, on some buggy virtual machines the mode change doesn't have any
effect until the counter is subsequently loaded (or perhaps when the IRQ
next fires).

So, set MODE 0 and then load the counter, to ensure that those buggy VMs
do the right thing and the interrupts stop. And then write MODE 0 *again*
to stop the counter on compliant implementations too.

Apparently, Hyper-V keeps firing the IRQ *repeatedly* even in mode zero
when it should only happen once, but the second MODE write stops that too.

Userspace test program (mostly written by tglx):
=====
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdint.h>
 #include <sys/io.h>

static __always_inline void __out##bwl(type value, uint16_t port)	\
{									\
	asm volatile("out" #bwl " %" #bw "0, %w1"			\
		     : : "a"(value), "Nd"(port));			\
}									\
									\
static __always_inline type __in##bwl(uint16_t port)			\
{									\
	type value;							\
	asm volatile("in" #bwl " %w1, %" #bw "0"			\
		     : "=a"(value) : "Nd"(port));			\
	return value;							\
}

BUILDIO(b, b, uint8_t)

 #define inb __inb
 #define outb __outb

 #define PIT_MODE	0x43
 #define PIT_CH0	0x40
 #define PIT_CH2	0x42

static int is8254;

static void dump_pit(void)
{
	if (is8254) {
		// Latch and output counter and status
		outb(0xC2, PIT_MODE);
		printf("%02x %02x %02x\n", inb(PIT_CH0), inb(PIT_CH0), inb(PIT_CH0));
	} else {
		// Latch and output counter
		outb(0x0, PIT_MODE);
		printf("%02x %02x\n", inb(PIT_CH0), inb(PIT_CH0));
	}
}

int main(int argc, char* argv[])
{
	int nr_counts = 2;

	if (argc > 1)
		nr_counts = atoi(argv[1]);

	if (argc > 2)
		is8254 = 1;

	if (ioperm(0x40, 4, 1) != 0)
		return 1;

	dump_pit();

	printf("Set oneshot\n");
	outb(0x38, PIT_MODE);
	outb(0x00, PIT_CH0);
	outb(0x0F, PIT_CH0);

	dump_pit();
	usleep(1000);
	dump_pit();

	printf("Set periodic\n");
	outb(0x34, PIT_MODE);
	outb(0x00, PIT_CH0);
	outb(0x0F, PIT_CH0);

	dump_pit();
	usleep(1000);
	dump_pit();
	dump_pit();
	usleep(100000);
	dump_pit();
	usleep(100000);
	dump_pit();

	printf("Set stop (%d counter writes)\n", nr_counts);
	outb(0x30, PIT_MODE);
	while (nr_counts--)
		outb(0xFF, PIT_CH0);

	dump_pit();
	usleep(100000);
	dump_pit();
	usleep(100000);
	dump_pit();

	printf("Set MODE 0\n");
	outb(0x30, PIT_MODE);

	dump_pit();
	usleep(100000);
	dump_pit();
	usleep(100000);
	dump_pit();

	return 0;
}
=====
Suggested-by: Sean Christopherson <seanjc@google.com>
Co-authored-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/cpu/mshyperv.c | 11 -----------
 drivers/clocksource/i8253.c    | 36 +++++++++++++++++++++++-----------
 include/linux/i8253.h          |  1 -
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba84..3d4237f27569 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
-#include <linux/i8253.h>
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
@@ -522,16 +521,6 @@ static void __init ms_hyperv_init_platform(void)
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
 	if ((hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS) ||
 	    ms_hyperv.paravisor_present)
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index cb215e6f2e83..39f7c2d736d1 100644
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
@@ -112,12 +105,33 @@ void clockevent_i8253_disable(void)
 {
 	raw_spin_lock(&i8253_lock);
 
+	/*
+	 * Writing the MODE register should stop the counter, according to
+	 * the datasheet. This appears to work on real hardware (well, on
+	 * modern Intel and AMD boxes; I didn't dig the Pegasos out of the
+	 * shed).
+	 *
+	 * However, some virtual implementations differ, and the MODE change
+	 * doesn't have any effect until either the counter is written (KVM
+	 * in-kernel PIT) or the next interrupt (QEMU). And in those cases,
+	 * it may not stop the *count*, only the interrupts. Although in
+	 * the virt case, that probably doesn't matter, as the value of the
+	 * counter will only be calculated on demand if the guest reads it;
+	 * it's the interrupts which cause steal time.
+	 *
+	 * Hyper-V apparently has a bug where even in mode 0, the IRQ keeps
+	 * firing repeatedly if the counter is running. But it *does* do the
+	 * right thing when the MODE register is written.
+	 *
+	 * So: write the MODE and then load the counter, which ensures that
+	 * the IRQ is stopped on those buggy virt implementations. And then
+	 * write the MODE again, which is the right way to stop it.
+	 */
 	outb_p(0x30, PIT_MODE);
+	outb_p(0, PIT_CH0);
+	outb_p(0, PIT_CH0);
 
-	if (i8253_clear_counter_on_shutdown) {
-		outb_p(0, PIT_CH0);
-		outb_p(0, PIT_CH0);
-	}
+	outb_p(0x30, PIT_MODE);
 
 	raw_spin_unlock(&i8253_lock);
 }
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index bf169cfef7f1..56c280eb2d4f 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,7 +21,6 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
-extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 extern void clockevent_i8253_disable(void);
-- 
2.44.0


