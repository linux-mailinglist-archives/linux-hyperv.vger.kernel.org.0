Return-Path: <linux-hyperv+bounces-2998-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73E974969
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Sep 2024 06:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EE12886E7
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Sep 2024 04:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D94D8D0;
	Wed, 11 Sep 2024 04:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jXdFqoie"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2E5589B;
	Wed, 11 Sep 2024 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726030606; cv=none; b=Rj43tzFs6nzrzaR0Y4XX8o/5SqahIIfLbJDdPLO2USf+fqftGfKr/9sAPJUV4+87GOHxtvZiT+NduOwBTc+p+3vRaAvLEIyoPr38xh6sWyoy5jauWChiEn5xvgXvoowTjXHgDLweFOQ3Gj3zdsqGEoLYJKOyJYdE5tXIClWRUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726030606; c=relaxed/simple;
	bh=WCT3gLIPKi2rloiBhOc+oD67Lrpf+PtV0i/c70mMkeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=huLTEgWeUVb13Veuwx3Jgok8cneWvxAiunJnMkA3CnCo+6zo5nJHrcj12gBXko8itvL+E0aFpDZWfYWgURiYkEF0naZ54tyEFvr0xFaEeAcWNjl3pBHnA6VWHsMNVfSLzi/V/9Zm2I5WGsZ7PR7I/XNEdd+8ks23Jw6TFgqWvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jXdFqoie; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.141])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC2C620B9A88;
	Tue, 10 Sep 2024 21:56:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC2C620B9A88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726030603;
	bh=9bq4kQISS+sdNw0M52IYsF90Bgvmo3NQ+h9q6SDUnJE=;
	h=From:To:Cc:Subject:Date:From;
	b=jXdFqoiexQLH9gRlzWsQEGaUBok2wTyWLeF5OYUKyLNYKXTHqoQyT+kzNMIST/qjp
	 YEaTmS9TWu/WOjJTeWwKCbd+Dj4+NPSq2XJrNBIJNjQYrej0Rq5oJ+aOiTxSV1IE0V
	 43evBpQCHSNuywQYNt5PNavK52Xrrlimik/V6AVw=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namjain@linux.microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v2] clocksource: hyper-v: Fix hv tsc page based sched_clock for hibernation
Date: Wed, 11 Sep 2024 10:26:32 +0530
Message-Id: <20240911045632.3757-1-namjain@linux.microsoft.com>
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
x86_platform.restore_sched_clock_state.

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
Changes from v1:
https://lore.kernel.org/all/20240909053923.8512-1-namjain@linux.microsoft.com/
* Reorganized code as per Michael's comment, and moved the logic to x86
specific files, to keep hyperv_timer.c arch independent.

---
 arch/x86/kernel/cpu/mshyperv.c     | 70 ++++++++++++++++++++++++++++++
 drivers/clocksource/hyperv_timer.c |  8 +++-
 include/clocksource/hyperv_timer.h |  8 ++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba84..d83a694e387c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -224,6 +224,75 @@ static void hv_machine_crash_shutdown(struct pt_regs *regs)
 	hyperv_cleanup();
 }
 #endif /* CONFIG_CRASH_DUMP */
+
+static u64 hv_sched_clock_offset_saved;
+static void (*old_save_sched_clock_state)(void);
+static void (*old_restore_sched_clock_state)(void);
+
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
+	 * hv_sched_clock_offset = offset that is used by hyperv_timer clocksource driver
+	 *                         to get time.
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
+	hv_adj_sched_clock_offset(hv_sched_clock_offset_saved - hv_read_reference_counter());
+}
+
+/*
+ * Functions to override save_sched_clock_state and restore_sched_clock_state
+ * functions of x86_platform. The Hyper-V clock counter is reset during
+ * suspend-resume and the offset used to measure time needs to be
+ * corrected, post resume.
+ */
+static void hv_save_sched_clock_state(void)
+{
+	old_save_sched_clock_state();
+	save_hv_clock_tsc_state();
+}
+
+static void hv_restore_sched_clock_state(void)
+{
+	restore_hv_clock_tsc_state();
+	old_restore_sched_clock_state();
+}
+
+static void __init x86_setup_ops_for_tsc_pg_clock(void)
+{
+	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
+		return;
+
+	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
+	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
+
+	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
+	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
+}
 #endif /* CONFIG_HYPERV */
 
 static uint32_t  __init ms_hyperv_platform(void)
@@ -575,6 +644,7 @@ static void __init ms_hyperv_init_platform(void)
 
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
+	x86_setup_ops_for_tsc_pg_clock();
 	hv_vtl_init_platform();
 #endif
 	/*
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index b2a080647e41..e424892444ed 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -27,7 +27,8 @@
 #include <asm/mshyperv.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
-static u64 hv_sched_clock_offset __ro_after_init;
+/* Note: offset can hold negative values after hibernation. */
+static u64 hv_sched_clock_offset __read_mostly;
 
 /*
  * If false, we're using the old mechanism for stimer0 interrupts
@@ -456,6 +457,11 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
+void hv_adj_sched_clock_offset(u64 offset)
+{
+	hv_sched_clock_offset -= offset;
+}
+
 #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 static int hv_cs_enable(struct clocksource *cs)
 {
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 6cdc873ac907..62e2bad754c0 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -38,6 +38,14 @@ extern void hv_remap_tsc_clocksource(void);
 extern unsigned long hv_get_tsc_pfn(void);
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
+/*
+ * Called during resume from hibernation, from overridden
+ * x86_platform.restore_sched_clock_state routine. This is to adjust offsets
+ * used to calculate time for hv tsc page based sched_clock, to account for
+ * time spent before hibernation.
+ */
+extern void hv_adj_sched_clock_offset(u64 offset);
+
 static __always_inline bool
 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
 		     u64 *cur_tsc, u64 *time)

base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
-- 
2.25.1


