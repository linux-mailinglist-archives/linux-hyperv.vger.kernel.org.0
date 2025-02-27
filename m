Return-Path: <linux-hyperv+bounces-4112-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACB5A472BC
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA621887863
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A18233148;
	Thu, 27 Feb 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0EEFHhd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED022D7B4
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622792; cv=none; b=WejXtW5tgrwajPFfJI6pdpSPv+xsQyoR2BHpLjRyI/llDlx4vf3rQgyzHRl/sBUzae3JjG4+DoXM4dRIGgAaUGnVkNlhmRYgApzzCguBMBZ0TtNdQiS/3LHl+54OXlazaMRhc5K2W3bcv8lSo5bISiasTIbyrv9UDVxMlHoDiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622792; c=relaxed/simple;
	bh=qxvHP66lsjRniK4FyS4w/nVcINWk6vqDJhVEUffkgUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R7qWyjKcileF5Tn3Q7WeeqJ+rD/+MQeuNyIC+dYXki/TZ2WtpZ5YzgodWmGL74XPRI99pVfkHh+0pTxdRvvQOMgARen+Mj0THAbK59FNNDO+LskrHPq1VJh3P6RtBfKlQQvU2c9eMWI0luq6SFkuDRci6JYjrkQLOmbPvWV3vHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0EEFHhd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so1109799a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622790; x=1741227590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QzXAit3+eiuwe2E434PEIcPVDj3bfcCBW02+u03qap4=;
        b=R0EEFHhdgeuv4rKnUYnpsWdwTNQIRkpZRtRfBBzT9Jm3kN6t6bcls+tw5pfyQQIpXv
         UFHx57GPzdTJj73JHnirodi210PKvnQraIlUFeXeO5aX8GIz6TNAPp7XefAqt8dfH6xd
         ZcKMh+Ilffll3RQM9LgPv1U/MgcLXZXYvntUSvss6ykD308PL8WXW5GIaGoNu4cCmNuE
         gJBoSBgJkfeEZwzqy0e5vbtwVbTtb8ZJ4CuL9ctlJvm5UL2sauRO0ZxvdfMHvNDnFfUA
         +ZD4mOHcy7JrwIiDO8X2qsnl8rc9Y8+NEr1NspiJhWElT33WWxGf8XBTLqOxXVARbD0N
         aH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622790; x=1741227590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzXAit3+eiuwe2E434PEIcPVDj3bfcCBW02+u03qap4=;
        b=tN25DdAPK72F4fbjBAM7v/XS1M/oSjEhBZ3zJTCm2puLPgOWYrFe9EAtsuuRTl+nEY
         gnczTxtx3eRCpbepKY8ORnhe7qatEqYu3JdI0qsBtYKsPv63BOuwoTkj3+afZK28/ZAQ
         YV+okZ+0soP9wZEvAAdg2bIod1FCySwg1OjY7EkfXZWcov2zZ2dcUJS9uW/TxIcSvdCU
         DIxenCzlJYSBxOofk1oWe1MkvKsBCHSV+FiuPAL1CJ2hoR7bqAIbdBkkAAZ40mTdYQV1
         Udc3HFNt2cpyQpp5JDCOHe5eP2Goq+kjiy3Bj8ksvzYzen5UGvpD0xAvhIqvc3DE7OCL
         Qadw==
X-Forwarded-Encrypted: i=1; AJvYcCVLedowxpOa9FOkSSzz5xSyER8up+AAwFl74P7uJnbILemDKNKgK4AoENqVvUun78pDAf2n5ywPUmr7Jx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsNj1ROE6gC5MAAQCa+Pp7o9HFWCL9pen6zhnHqTNt5Gvot9A
	cixb3BFagIaSQ/FBcrZW/d4Jz/jABbxO0i1pQ7nxFEiOVVBhqYXCTaNe7eGvpxGvbRMXJiHV8zZ
	pvQ==
X-Google-Smtp-Source: AGHT+IEy19UXAGhpZ6BooyEkiFGbgvHpy57ZvxRHzoGzPaLhW9PSe6CovWEb42HIAZDNRdCcii7axkfnXfc=
X-Received: from pjbsh13.prod.google.com ([2002:a17:90b:524d:b0:2ee:53fe:d0fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5385:b0:2f5:63a:449c
 with SMTP id 98e67ed59e1d1-2fe68cf4000mr14888818a91.28.1740622789852; Wed, 26
 Feb 2025 18:19:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:43 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-28-seanjc@google.com>
Subject: [PATCH v2 27/38] x86/kvmclock: Enable kvmclock on APs during onlining
 if kvmclock isn't sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

In anticipation of making x86_cpuinit.early_percpu_clock_init(), i.e.
kvm_setup_secondary_clock(), a dedicated sched_clock hook that will be
invoked if and only if kvmclock is set as sched_clock, ensure APs enable
their kvmclock during CPU online.  While a redundant write to the MSR is
technically ok, skip the registration when kvmclock is sched_clock so that
it's somewhat obvious that kvmclock *needs* to be enabled during early
bringup when it's being used as sched_clock.

Plumb in the BSP's resume path purely for documentation purposes.  Both
KVM (as-a-guest) and timekeeping/clocksource hook syscore_ops, and it's
not super obvious that using KVM's hooks would be flawed.  E.g. it would
work today, because KVM's hooks happen to run after/before timekeeping's
hooks during suspend/resume, but that's sheer dumb luck as the order in
which syscore_ops are invoked depends entirely on when a subsystem is
initialized and thus registers its hooks.

Opportunsitically make the registration messages more precise to help
debug issues where kvmclock is enabled too late.

Opportunstically WARN in kvmclock_{suspend,resume}() to harden against
future bugs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  2 ++
 arch/x86/kernel/kvm.c           | 24 +++++++++++-------
 arch/x86/kernel/kvmclock.c      | 44 +++++++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 8708598f5b8e..42d90bf8fde9 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -120,6 +120,8 @@ static inline long kvm_sev_hypercall3(unsigned int nr, unsigned long p1,
 #ifdef CONFIG_KVM_GUEST
 enum kvm_guest_cpu_action {
 	KVM_GUEST_BSP_SUSPEND,
+	KVM_GUEST_BSP_RESUME,
+	KVM_GUEST_AP_ONLINE,
 	KVM_GUEST_AP_OFFLINE,
 	KVM_GUEST_SHUTDOWN,
 };
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 866b061ee0d9..5f093190df17 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -461,18 +461,24 @@ static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
 	kvmclock_cpu_action(action);
 }
 
+static int __kvm_cpu_online(unsigned int cpu, enum kvm_guest_cpu_action action)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	kvmclock_cpu_action(action);
+	kvm_guest_cpu_init();
+	local_irq_restore(flags);
+	return 0;
+}
+
+#ifdef CONFIG_SMP
+
 static int kvm_cpu_online(unsigned int cpu)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-	kvm_guest_cpu_init();
-	local_irq_restore(flags);
-	return 0;
+	return __kvm_cpu_online(cpu, KVM_GUEST_AP_ONLINE);
 }
 
-#ifdef CONFIG_SMP
-
 static DEFINE_PER_CPU(cpumask_var_t, __pv_cpu_mask);
 
 static bool pv_tlb_flush_supported(void)
@@ -737,7 +743,7 @@ static int kvm_suspend(void)
 
 static void kvm_resume(void)
 {
-	kvm_cpu_online(raw_smp_processor_id());
+	__kvm_cpu_online(raw_smp_processor_id(), KVM_GUEST_BSP_RESUME);
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL) && has_guest_poll)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0ce23f862cbd..76884dfc77f4 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -52,6 +52,7 @@ static struct pvclock_vsyscall_time_info *hvclock_mem;
 DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
 
+static bool kvmclock_is_sched_clock;
 static bool kvmclock_suspended;
 
 /*
@@ -128,7 +129,7 @@ static void kvm_save_sched_clock_state(void)
 #ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
-	kvm_register_clock("secondary cpu clock");
+	kvm_register_clock("secondary cpu, sched_clock setup");
 }
 #endif
 
@@ -140,25 +141,51 @@ static void kvm_restore_sched_clock_state(void)
 
 static void kvmclock_suspend(struct clocksource *cs)
 {
+	if (WARN_ON_ONCE(kvmclock_is_sched_clock))
+		return;
+
 	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
 static void kvmclock_resume(struct clocksource *cs)
 {
+	if (WARN_ON_ONCE(kvmclock_is_sched_clock))
+		return;
+
 	kvmclock_suspended = false;
 	kvm_register_clock("primary cpu, clocksource resume");
 }
 
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
-	/*
-	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
-	 * being used for sched_clock, then it needs to be kept alive until the
-	 * last minute, and restored as quickly as possible after resume.
-	 */
-	if (action != KVM_GUEST_BSP_SUSPEND)
+	switch (action) {
+		/*
+		 * The BSP's clock is managed via clocksource suspend/resume,
+		 * to ensure it's enabled/disabled when timekeeping needs it
+		 * to be, e.g. before reading wallclock (which uses kvmclock).
+		 */
+	case KVM_GUEST_BSP_SUSPEND:
+	case KVM_GUEST_BSP_RESUME:
+		break;
+	case KVM_GUEST_AP_ONLINE:
+		/*
+		 * Secondary CPUs use dedicated sched_clock hooks to enable
+		 * kvmclock early during bringup, there's nothing to be done
+		 * when during CPU online.
+		 */
+		if (kvmclock_is_sched_clock)
+			break;
+		kvm_register_clock("secondary cpu, online");
+		break;
+	case KVM_GUEST_AP_OFFLINE:
+	case KVM_GUEST_SHUTDOWN:
 		kvmclock_disable();
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
 }
 
 /*
@@ -313,6 +340,7 @@ static void __init kvm_sched_clock_init(bool stable)
 	kvm_sched_clock_offset = kvm_clock_read();
 	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
 				   kvm_save_sched_clock_state, kvm_restore_sched_clock_state);
+	kvmclock_is_sched_clock = true;
 
 	/*
 	 * The BSP's clock is managed via dedicated sched_clock save/restore
@@ -356,7 +384,7 @@ void __init kvmclock_init(void)
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
 	this_cpu_write(hv_clock_per_cpu, &hv_clock_boot[0]);
-	kvm_register_clock("primary cpu clock");
+	kvm_register_clock("primary cpu, online");
 	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT)) {
-- 
2.48.1.711.g2feabab25a-goog


