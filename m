Return-Path: <linux-hyperv+bounces-8947-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K86N1RLnGmODAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8947-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 13:43:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE89176542
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 13:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1156A304466A
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D16936A01A;
	Mon, 23 Feb 2026 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk/5p8Lp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4AB36604B;
	Mon, 23 Feb 2026 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850302; cv=none; b=CMxyB+gtzk2ador7SJ7Y8V/AaBhCunBXLoSvCEzLirgicZFFX3x+ykxZRRC4vQB/ab18pYUSgDdYRq3oJma/ObB45qL+pAxNbBnE7V2YPPyFllTN3g1l4ngLOFFTero7Dt9vrhwbO1kmujTZJgIrsLzVF0oODddRkD5wgT2/Arw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850302; c=relaxed/simple;
	bh=hihk3XLBB3Pr3L1pcvUaP+sd8F9YMPpj1VEc3fSYSFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADUBT4nx96ZFYlWIfG1tOOL2zxOtXchW1+7/sGiEyaMd9FGZTiGB9mxSULQ3dDmXdt2Al+4Z64O0sQ5S8buQQ6ECfQklRWLEvmBvIbm173akwWDbiLB7ER36ulLJgOxdX7B+w2nhEcTVNysb1WUEE237izr4FuFC+90Ll4Hlozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk/5p8Lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F1BC2BC87;
	Mon, 23 Feb 2026 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771850301;
	bh=hihk3XLBB3Pr3L1pcvUaP+sd8F9YMPpj1VEc3fSYSFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dk/5p8LpTnZEGlZhgtlLRzvw69oPqElv1V7CslAHQSM2U/9pcBCt6AhHceBQXzDV7
	 fDPx1lLzYQ1uRkEA1gQoKZJZPZJaaTeyu1Z/LuqiWrYkA86PxJs2yBHXa1Yfnkydtw
	 PM1ADljfcpBxQL6t3dksS1s6JI63LNQTIbH4a6H0Avvnfoxej2g2RHpwM2l1Hct3WH
	 fIV9tGVFnin9CNHFJs9d+CKA027YPkGdI20BgEOBZogXe31hLUBhl9yrn6TUPwuARq
	 9NbBYUihBxQSFNixfh8ewrq0NnRYQsXFV98g9Q2FOyTDt91Fh6SqDbawoGNQt73cE8
	 ta7lvCmE2KjMg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] Drivers: hv: vmbus: Use kthread for vmbus interrupts on PREEMPT_RT
Date: Mon, 23 Feb 2026 07:37:33 -0500
Message-ID: <20260223123738.1532940-28-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[siemens.com,outlook.com,kernel.org,microsoft.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8947-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,siemens.com:email]
X-Rspamd-Queue-Id: 6DE89176542
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com>

[ Upstream commit f8e6343b7a89c7c649db5a9e309ba7aa20401813 ]

Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
with related guest support enabled:

[    1.127941] hv_vmbus: registering driver hyperv_drm

[    1.132518] =============================
[    1.132519] [ BUG: Invalid wait context ]
[    1.132521] 6.19.0-rc8+ #9 Not tainted
[    1.132524] -----------------------------
[    1.132525] swapper/0/0 is trying to lock:
[    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xc4/0x2b0
[    1.132543] other info that might help us debug this:
[    1.132544] context-{2:2}
[    1.132545] 1 lock held by swapper/0/0:
[    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x31/0x2b0
[    1.132557] stack backtrace:
[    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc8+ #9 PREEMPT_{RT,(lazy)}
[    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
[    1.132567] Call Trace:
[    1.132570]  <IRQ>
[    1.132573]  dump_stack_lvl+0x6e/0xa0
[    1.132581]  __lock_acquire+0xee0/0x21b0
[    1.132592]  lock_acquire+0xd5/0x2d0
[    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
[    1.132606]  ? lock_acquire+0xd5/0x2d0
[    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
[    1.132619]  rt_spin_lock+0x3f/0x1f0
[    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
[    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
[    1.132634]  vmbus_chan_sched+0xc4/0x2b0
[    1.132641]  vmbus_isr+0x2c/0x150
[    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
[    1.132654]  sysvec_hyperv_callback+0x88/0xb0
[    1.132658]  </IRQ>
[    1.132659]  <TASK>
[    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20

As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT,
the vmbus_isr execution needs to be moved into thread context. Open-
coding this allows to skip the IPI that irq_work would additionally
bring and which we do not need, being an IRQ, never an NMI.

This affects both x86 and arm64, therefore hook into the common driver
logic.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Tested-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The bug exists in all stable trees that have PREEMPT_RT support.
However, the patch would need significant adaptation to apply to them
due to the 6.19-specific refactoring of `vmbus_isr` and
`vmbus_chan_sched`.

## Analysis

### What the commit fixes

This commit fixes a **sleeping-in-atomic-context bug** on PREEMPT_RT
kernels running on Hyper-V. The issue is that `vmbus_isr()` runs in hard
IRQ context (called from `sysvec_hyperv_callback` on x86) and acquires
`spin_lock(&channel->sched_lock)` via `vmbus_chan_sched()`. Under
PREEMPT_RT, spinlocks are converted to `rt_spin_lock` (sleeping locks),
which cannot be acquired from hard IRQ context. This triggers a lockdep
"BUG: Invalid wait context" and represents a real correctness issue (not
just a warning).

### Does it fix a real bug?

**Yes.** This is a legitimate bug that makes Hyper-V VMs with PREEMPT_RT
unusable or unstable. The lockdep trace is from real testing (6.19-rc8).
The issue affects all PREEMPT_RT Hyper-V guests.

### Stable kernel rule assessment

1. **Obviously correct and tested**: Yes - reviewed by Michael Kelley
   (Hyper-V maintainer) and Florian Bezdeka, tested by both.
2. **Fixes a real bug**: Yes - sleeping in hardirq context is a real bug
   on PREEMPT_RT.
3. **Important issue**: Moderate - affects PREEMPT_RT on Hyper-V, which
   is a meaningful but somewhat niche combination.
4. **Small and contained**: Borderline - ~80 lines in one file, but adds
   new per-CPU thread infrastructure.
5. **No new features**: The kthread is a mechanism to fix the bug, not a
   feature.

### Risk vs benefit

- **Benefit**: Fixes a real bug that makes PREEMPT_RT on Hyper-V broken.
- **Risk**: Low for non-RT kernels (everything is behind
  `IS_ENABLED(CONFIG_PREEMPT_RT)`, which is compile-time). Moderate for
  RT kernels (new kthread infrastructure, though using well-established
  `smpboot` API).

### Backport concerns

**Critical issue: Dependencies.** This patch was written against the
6.19 codebase which has undergone significant refactoring:
- `vmbus_isr()` changed from `static` to exported
  (`EXPORT_SYMBOL_FOR_MODULES`) in 6.19 via commit `cffe9f58de1eb`
- `vmbus_chan_sched()` signature changed from `vmbus_chan_sched(hv_cpu)`
  to `vmbus_chan_sched(event_page_addr)` in 6.19 via commit
  `163224c189e8b`
- The `vmbus_message_sched()` helper was factored out in 6.19

The patch **will not apply cleanly** to any existing stable tree
(6.12.y, 6.6.y, 6.1.y). A manual backport would be needed, adapting the
fix to the older `vmbus_isr` structure. While the core concept (use
kthread for RT) would work, the adaptation is non-trivial.

### Verification

- **git show v6.12, v6.6, v6.1 kernel/Kconfig.preempt**: Confirmed
  PREEMPT_RT config option exists in all these stable trees
- **git show v6.1 include/linux/smpboot.h**: Confirmed
  `smpboot_register_percpu_thread` API available since at least 6.1
- **git show v6.18 drivers/hv/vmbus_drv.c**: Confirmed `vmbus_isr` is
  `static` in v6.18, only exported in 6.19
- **git show v6.12, v6.6 drivers/hv/vmbus_drv.c**: Confirmed
  `vmbus_chan_sched()` takes `hv_cpu` (not `event_page_addr`) in older
  kernels
- **git log v6.18..v6.19 drivers/hv/vmbus_drv.c**: Identified
  prerequisite commits (163224c189e8b, cffe9f58de1eb) that refactored
  the code
- **Read arch/x86/kernel/cpu/mshyperv.c lines 153-168**: Confirmed
  `vmbus_handler()` is called from `sysvec_hyperv_callback` IDTENTRY
  (hard IRQ context)
- **Read drivers/hv/vmbus_drv.c lines 1305**: Confirmed
  `spin_lock(&channel->sched_lock)` is the sleeping lock in the IRQ path
- **git show v6.12, v6.6**: Confirmed the `sched_lock` spin_lock exists
  in stable trees' vmbus_chan_sched, confirming the bug exists there too

### Decision

This is a legitimate bug fix for PREEMPT_RT on Hyper-V. The bug is real
and affects all stable trees with PREEMPT_RT. However, the patch:

1. Is moderate in size, adding new per-CPU thread infrastructure (~80
   lines)
2. Has significant dependencies on 6.19-specific refactoring and won't
   apply cleanly to any stable tree
3. Targets a somewhat niche combination (PREEMPT_RT + Hyper-V)
4. Would require careful manual adaptation for each stable tree

The fix is well-reviewed and technically sound, and it fixes a real bug.
Despite the backport complexity, the bug is severe enough (sleeping-in-
atomic-context breaks PREEMPT_RT on Hyper-V) that it warrants
backporting with appropriate adaptation. The
`IS_ENABLED(CONFIG_PREEMPT_RT)` guard ensures zero risk to non-RT users.

**YES**

 drivers/hv/vmbus_drv.c | 66 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a53af6fe81a65..1d5cba142828e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/task_stack.h>
+#include <linux/smpboot.h>
 
 #include <linux/delay.h>
 #include <linux/panic_notifier.h>
@@ -1350,7 +1351,7 @@ static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void *message
 	}
 }
 
-void vmbus_isr(void)
+static void __vmbus_isr(void)
 {
 	struct hv_per_cpu_context *hv_cpu
 		= this_cpu_ptr(hv_context.cpu_context);
@@ -1363,6 +1364,53 @@ void vmbus_isr(void)
 
 	add_interrupt_randomness(vmbus_interrupt);
 }
+
+static DEFINE_PER_CPU(bool, vmbus_irq_pending);
+static DEFINE_PER_CPU(struct task_struct *, vmbus_irqd);
+
+static void vmbus_irqd_wake(void)
+{
+	struct task_struct *tsk = __this_cpu_read(vmbus_irqd);
+
+	__this_cpu_write(vmbus_irq_pending, true);
+	wake_up_process(tsk);
+}
+
+static void vmbus_irqd_setup(unsigned int cpu)
+{
+	sched_set_fifo(current);
+}
+
+static int vmbus_irqd_should_run(unsigned int cpu)
+{
+	return __this_cpu_read(vmbus_irq_pending);
+}
+
+static void run_vmbus_irqd(unsigned int cpu)
+{
+	__this_cpu_write(vmbus_irq_pending, false);
+	__vmbus_isr();
+}
+
+static bool vmbus_irq_initialized;
+
+static struct smp_hotplug_thread vmbus_irq_threads = {
+	.store                  = &vmbus_irqd,
+	.setup			= vmbus_irqd_setup,
+	.thread_should_run      = vmbus_irqd_should_run,
+	.thread_fn              = run_vmbus_irqd,
+	.thread_comm            = "vmbus_irq/%u",
+};
+
+void vmbus_isr(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		vmbus_irqd_wake();
+	} else {
+		lockdep_hardirq_threaded();
+		__vmbus_isr();
+	}
+}
 EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
 
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
@@ -1462,6 +1510,13 @@ static int vmbus_bus_init(void)
 	 * the VMbus interrupt handler.
 	 */
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !vmbus_irq_initialized) {
+		ret = smpboot_register_percpu_thread(&vmbus_irq_threads);
+		if (ret)
+			goto err_kthread;
+		vmbus_irq_initialized = true;
+	}
+
 	if (vmbus_irq == -1) {
 		hv_setup_vmbus_handler(vmbus_isr);
 	} else {
@@ -1507,6 +1562,11 @@ static int vmbus_bus_init(void)
 		free_percpu(vmbus_evt);
 	}
 err_setup:
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
+		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
+		vmbus_irq_initialized = false;
+	}
+err_kthread:
 	bus_unregister(&hv_bus);
 	return ret;
 }
@@ -2976,6 +3036,10 @@ static void __exit vmbus_exit(void)
 		free_percpu_irq(vmbus_irq, vmbus_evt);
 		free_percpu(vmbus_evt);
 	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
+		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
+		vmbus_irq_initialized = false;
+	}
 	for_each_online_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
-- 
2.51.0


