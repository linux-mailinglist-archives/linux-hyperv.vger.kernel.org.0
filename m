Return-Path: <linux-hyperv+bounces-2990-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DE5970D01
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 07:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D5BB2108D
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 05:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20DA17C22A;
	Mon,  9 Sep 2024 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jNVhyigs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2233622638;
	Mon,  9 Sep 2024 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725860383; cv=none; b=dJlYkEAnqciohyQwZ1cEPRI45IED9E/KQ4fQ1AtmLYjWv4sDSr/bMcrAEPmmKhw89e+rKWuQLMj+6US74RAqOvWDEMyn+2V199h7bkTWg41rY+H9f5u081ugIjxnYNKuuzc8vE6Lf2YJwr1FbzVaruSJvWhpkIfI5Em63Jqqkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725860383; c=relaxed/simple;
	bh=NSKXGoAg3t9lYYBwq5sMoSLMOJGRbv1VQHzNVtHWTRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bMhYbnrISyeQRVD2Er80lolurjIIjjTqLdB2VKrO9SAAnFZkDrJ7HJ3Il8fCsZDD9MBYeI21R9AwLt8LrYxJM2JtBa7IMNK0EGP26Z9jfDWGJdEEDRRCfBLl3LkKSHDnpmdecqPLbRaenGMvcVTnhAN+KpsF7iZQAMymTnQBXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jNVhyigs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.141])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86D3420B7D6A;
	Sun,  8 Sep 2024 22:39:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86D3420B7D6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725860375;
	bh=BLTNsC3QAfdknZXO9uNR/qLcq9EIASe/aBAWDV++BhM=;
	h=From:To:Cc:Subject:Date:From;
	b=jNVhyigsPLB/bSz4fbfr1wTU+iJGzfFqrl+cjyiZhdV6jC/zakIL1Vg4GVnrS1vcW
	 G3uZITXyvoXyQKdCZPfmo3x5t6qqEXJRFB2PlPnKbjH4ZGIGZq/phcmJHgZ0brnRND
	 sNO2KiNDEPyp9ipncoVOK3wz4o1uaabQ98UqFmm4=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] clocksource: hyper-v: Fix hv tsc page based sched_clock for hibernation
Date: Mon,  9 Sep 2024 11:09:23 +0530
Message-Id: <20240909053923.8512-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_hv_sched_clock_tsc() assumes that the Hyper-V clock counter is
bigger than the variable hv_sched_clock_offset, which is cached during
early boot, but depending on the timing this assumption may be false
when a hibernated VM starts again (the clock counter starts from 0
again) and is resuming back (Note: hv_init_tsc_clocksource() is not
called during hibernation/resume); consequently,
read_hv_sched_clock_tsc() may return a negative integer (which is
interpreted as a huge positive integer since the return type is u64)
and new kernel messages are prefixed with huge timestamps before
read_hv_sched_clock_tsc() grows big enough (which typically takes
several seconds).

Fix the issue by saving the Hyper-V clock counter just before the
suspend, and using it to correct the hv_sched_clock_offset in
resume. Override x86_platform.save_sched_clock_state  and
x86_platform.restore_sched_clock_state so that we don't
have to touch the common x86 code.

Note: if Invariant TSC is available, the issue doesn't happen because
1) we don't register read_hv_sched_clock_tsc() for sched clock:
See commit e5313f1c5404 ("clocksource/drivers/hyper-v: Rework
clocksource and sched clock setup");
2) the common x86 code adjusts TSC similarly: see
__restore_processor_state() ->  tsc_verify_tsc_adjust(true) and
x86_platform.restore_sched_clock_state().

Cc: stable@vger.kernel.org
Fixes: 1349401ff1aa ("clocksource/drivers/hyper-v: Suspend/resume Hyper-V clocksource for hibernation")
Co-developed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 64 +++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index b2a080647e41..7aa44b8aae2e 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -27,7 +27,10 @@
 #include <asm/mshyperv.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
-static u64 hv_sched_clock_offset __ro_after_init;
+
+/* Can have negative values, after resume from hibernation, so keep them s64 */
+static s64 hv_sched_clock_offset __read_mostly;
+static s64 hv_sched_clock_offset_saved;
 
 /*
  * If false, we're using the old mechanism for stimer0 interrupts
@@ -51,6 +54,9 @@ static int stimer0_irq = -1;
 static int stimer0_message_sint;
 static __maybe_unused DEFINE_PER_CPU(long, stimer0_evt);
 
+static void (*old_save_sched_clock_state)(void);
+static void (*old_restore_sched_clock_state)(void);
+
 /*
  * Common code for stimer0 interrupts coming via Direct Mode or
  * as a VMbus message.
@@ -434,6 +440,39 @@ static u64 noinstr read_hv_sched_clock_tsc(void)
 		(NSEC_PER_SEC / HV_CLOCK_HZ);
 }
 
+/*
+ * Hyper-V clock counter resets during hibernation. Save and restore clock
+ * offset during suspend/resume, while also considering the time passed
+ * before suspend. This is to make sure that sched_clock using hv tsc page
+ * based clocksource, proceeds from where it left off during suspend and
+ * it shows correct time for the timestamps of kernel messages after resume.
+ */
+static void save_hv_clock_tsc_state(void)
+{
+	hv_sched_clock_offset_saved = hv_read_reference_counter();
+}
+
+static void restore_hv_clock_tsc_state(void)
+{
+	/*
+	 * Time passed before suspend = hv_sched_clock_offset_saved
+	 *                            - hv_sched_clock_offset (old)
+	 *
+	 * After Hyper-V clock counter resets, hv_sched_clock_offset needs a correction.
+	 *
+	 * New time = hv_read_reference_counter() (future) - hv_sched_clock_offset (new)
+	 * New time = Time passed before suspend + hv_read_reference_counter() (future)
+	 *                                       - hv_read_reference_counter() (now)
+	 *
+	 * Solving the above two equations gives:
+	 *
+	 * hv_sched_clock_offset (new) = hv_sched_clock_offset (old)
+	 *                             - hv_sched_clock_offset_saved
+	 *                             + hv_read_reference_counter() (now))
+	 */
+	hv_sched_clock_offset -= hv_sched_clock_offset_saved - hv_read_reference_counter();
+}
+
 static void suspend_hv_clock_tsc(struct clocksource *arg)
 {
 	union hv_reference_tsc_msr tsc_msr;
@@ -456,6 +495,24 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
+/*
+ * Functions to override save_sched_clock_state and restore_sched_clock_state
+ * functions of x86_platform. The Hyper-V clock counter is reset during
+ * suspend-resume and the offset used to measure time needs to be
+ * corrected, post resume.
+ */
+static void hv_save_sched_clock_state(void)
+{
+	save_hv_clock_tsc_state();
+	old_save_sched_clock_state();
+}
+
+static void hv_restore_sched_clock_state(void)
+{
+	restore_hv_clock_tsc_state();
+	old_restore_sched_clock_state();
+}
+
 #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 static int hv_cs_enable(struct clocksource *cs)
 {
@@ -539,6 +596,11 @@ static void __init hv_init_tsc_clocksource(void)
 
 	hv_read_reference_counter = read_hv_clock_tsc;
 
+	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
+	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
+	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
+	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
+
 	/*
 	 * TSC page mapping works differently in root compared to guest.
 	 * - In guest partition the guest PFN has to be passed to the

base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
-- 
2.25.1


