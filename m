Return-Path: <linux-hyperv+bounces-6616-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4056B38F85
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 02:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB0F9819C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 00:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD121A459;
	Thu, 28 Aug 2025 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMA3k0/S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032F1EF38F
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Aug 2025 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339332; cv=none; b=M1okx1vRQTOX2kzXGHS1scmEvBDq5W8wiCmMl/OD5V/bbnNMbZNobpjlAWHPajcQU15rQc/bhn13rMmbtZAgsUKH2X63q7OcMTvaLIGpCILNzAQTgsdCvYQPr/z5FyzPnLPq67QO6/k/MkmD1wwu6Xzgr0tLf6OOrud4Wqhpcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339332; c=relaxed/simple;
	bh=XyMaLcJYGhb12wif0PPs0kTeGE1PmcfW6YNjB0soymQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OjXboXKbJrOcXEk9mSXpfoG4w2Zf1qj7gFwb6YL/sZ6TCMs/rGKXJCU1opV4vzvygHFhA6Bkg+7mOigo98Fwgj8gL1VG7VEmdqDmqkGbYSCqHys7BR3zW36KkNCtRE2w7tpXYzADgJ36b/ljPqEF3hYM7PFlZu7gspgvZ1fkQWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMA3k0/S; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246364842e7so7175985ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 27 Aug 2025 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756339330; x=1756944130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=t0b6nfV8ACtHngFYCFD4a6X0clQjFgCPW+omDXt4bTs=;
        b=JMA3k0/Se6u7wU05MFxs2ldVYKHzxG8T4GaORhXC9wXH/d3mpFi/beculeza7mCehj
         WGZibdzZ/s6oS8Sl36zBHXPue02yRh88g9dmgkLa8ueVruKk5zkSS3bWpPdqa4DwaAOF
         dHNZRZP1suGmVns2PjNfoJAxzv2qGfS9Pej4k46vdTwvR2xXfB9egKODebu0RYq+rhq6
         4NlMelvaI+sWnXOa9bhseKe8d5ml+gwAngSihJHoH6Az2vtcbRAOLeDudsBZAbB79leg
         HeOfX5X96jMQXlkMtv2slRpVrQM/0J8zNJJ7nfnSj/Kkq3vzdkO/V7e1zj13Aq4uO/Lf
         1keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756339330; x=1756944130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0b6nfV8ACtHngFYCFD4a6X0clQjFgCPW+omDXt4bTs=;
        b=LAITW2scNd8z2Y+YoRbuWjivdHodCj0UWwC4x5F9YSRilY9D+5WFA9+e/Qh6jVpSje
         JzgblEqgjMtLGEMUC9qTByZ0pmfcI/B2EW8a70co2uFB0edLLSl9KPYixp+33QQp4kYO
         TcViSyXSRX/UExRwUFVHMqbPD6ZYUm9NADv1T/jculjzWmPFBzRVkkanrUXNqZSXSFGU
         rsmTM9Xuc9LbTGQ8QT7LOuxI5D/1W00N9adrlJbX4q+dG4lmMK2XU1RnWjVgVGkrFjdJ
         RMqPPT0ZG6otGK4+mEasVk36mEL4wOaS/Z4tZnO4CoWhJF1Y+UVLdNt250mhbVstfIpL
         1+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWel/a+HlLxIT3A/2a2MKY8zVQmRGtWmqA51XxvMl4eJoaXVjEEnWtplOUB5rcRJ13qaju1nyngBQwI/Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+vAH5RVr2rmr3F6knCAXnKhxF7lrnnTmzYqLeBmRwfLpeA/O
	WIAPiku5po9wgWdjn6VGvk2QL2Kg3nzPPkl6sDIQ3h8kbv+buj3kUC2qsdf6qX4lnJpoZwX+nk6
	jFCRNHQ==
X-Google-Smtp-Source: AGHT+IH/zSg0NOaA8AO8xJkIMVcmzaCiAN5K9jibnSscidupr23ZKkHWPw6r1BmEsVqQvRiXUejojziqfr0=
X-Received: from pjbpm10.prod.google.com ([2002:a17:90b:3c4a:b0:31e:fac4:4723])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:238e:b0:240:50ef:2f00
 with SMTP id d9443c01a7336-2462eea80fbmr326811935ad.26.1756339329158; Wed, 27
 Aug 2025 17:02:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 17:01:53 -0700
In-Reply-To: <20250828000156.23389-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828000156.23389-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828000156.23389-5-seanjc@google.com>
Subject: [PATCH v2 4/7] entry/kvm: KVM: Move KVM details related to
 signal/-EINTR into KVM proper
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, rcu@vger.kernel.org, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, Mukesh R <mrathor@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Move KVM's morphing of pending signals into userspace exits into KVM
proper, and drop the @vcpu param from xfer_to_guest_mode_handle_work().
How KVM responds to -EINTR is a detail that really belongs in KVM itself,
and invoking kvm_handle_signal_exit() from kernel code creates an inverted
module dependency.  E.g. attempting to move kvm_handle_signal_exit() into
kvm_main.c would generate an linker error when building kvm.ko as a module.

Dropping KVM details will also converting the KVM "entry" code into a more
generic virtualization framework so that it can be used when running as a
Hyper-V root partition.

Lastly, eliminating usage of "struct kvm_vcpu" outside of KVM is also nice
to have for KVM x86 developers, as keeping the details of kvm_vcpu purely
within KVM allows changing the layout of the structure without having to
boot into a new kernel, e.g. allows rebuilding and reloading kvm.ko with a
modified kvm_vcpu structure as part of debug/development.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c      |  3 +--
 arch/loongarch/kvm/vcpu.c |  3 +--
 arch/riscv/kvm/vcpu.c     |  3 +--
 arch/x86/kvm/vmx/vmx.c    |  1 -
 arch/x86/kvm/x86.c        |  3 +--
 include/linux/entry-kvm.h | 11 +++--------
 include/linux/kvm_host.h  | 13 ++++++++++++-
 kernel/entry/kvm.c        | 13 +++++--------
 8 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 888f7c7abf54..418fd3043467 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -6,7 +6,6 @@
 
 #include <linux/bug.h>
 #include <linux/cpu_pm.h>
-#include <linux/entry-kvm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
@@ -1177,7 +1176,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		/*
 		 * Check conditions before entering the guest
 		 */
-		ret = xfer_to_guest_mode_handle_work(vcpu);
+		ret = kvm_xfer_to_guest_mode_handle_work(vcpu);
 		if (!ret)
 			ret = 1;
 
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index d1b8c50941ca..514256b25ba1 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/kvm_host.h>
-#include <linux/entry-kvm.h>
 #include <asm/fpu.h>
 #include <asm/lbt.h>
 #include <asm/loongarch.h>
@@ -251,7 +250,7 @@ static int kvm_enter_guest_check(struct kvm_vcpu *vcpu)
 	/*
 	 * Check conditions before entering the guest
 	 */
-	ret = xfer_to_guest_mode_handle_work(vcpu);
+	ret = kvm_xfer_to_guest_mode_handle_work(vcpu);
 	if (ret < 0)
 		return ret;
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index f001e56403f9..251e787f2ebc 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/bitops.h>
-#include <linux/entry-kvm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kdebug.h>
@@ -910,7 +909,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 	while (ret > 0) {
 		/* Check conditions before entering the guest */
-		ret = xfer_to_guest_mode_handle_work(vcpu);
+		ret = kvm_xfer_to_guest_mode_handle_work(vcpu);
 		if (ret)
 			continue;
 		ret = 1;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aa157fe5b7b3..d7c86613e50a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <linux/tboot.h>
 #include <linux/trace_events.h>
-#include <linux/entry-kvm.h>
 
 #include <asm/apic.h>
 #include <asm/asm.h>
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1c49bc681c4..0b13b8bf69e5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -59,7 +59,6 @@
 #include <linux/sched/stat.h>
 #include <linux/sched/isolation.h>
 #include <linux/mem_encrypt.h>
-#include <linux/entry-kvm.h>
 #include <linux/suspend.h>
 #include <linux/smp.h>
 
@@ -11241,7 +11240,7 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 
 		if (__xfer_to_guest_mode_work_pending()) {
 			kvm_vcpu_srcu_read_unlock(vcpu);
-			r = xfer_to_guest_mode_handle_work(vcpu);
+			r = kvm_xfer_to_guest_mode_handle_work(vcpu);
 			kvm_vcpu_srcu_read_lock(vcpu);
 			if (r)
 				return r;
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 16149f6625e4..3644de7e6019 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -21,8 +21,6 @@
 	 _TIF_NOTIFY_SIGNAL | _TIF_NOTIFY_RESUME |			\
 	 ARCH_XFER_TO_GUEST_MODE_WORK)
 
-struct kvm_vcpu;
-
 /**
  * arch_xfer_to_guest_mode_handle_work - Architecture specific xfer to guest
  *					 mode work handling function.
@@ -32,12 +30,10 @@ struct kvm_vcpu;
  * Invoked from xfer_to_guest_mode_handle_work(). Defaults to NOOP. Can be
  * replaced by architecture specific code.
  */
-static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
-						      unsigned long ti_work);
+static inline int arch_xfer_to_guest_mode_handle_work(unsigned long ti_work);
 
 #ifndef arch_xfer_to_guest_mode_work
-static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
-						      unsigned long ti_work)
+static inline int arch_xfer_to_guest_mode_handle_work(unsigned long ti_work)
 {
 	return 0;
 }
@@ -46,11 +42,10 @@ static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
 /**
  * xfer_to_guest_mode_handle_work - Check and handle pending work which needs
  *				    to be handled before going to guest mode
- * @vcpu:	Pointer to current's VCPU data
  *
  * Returns: 0 or an error code
  */
-int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu);
+int xfer_to_guest_mode_handle_work(void);
 
 /**
  * xfer_to_guest_mode_prepare - Perform last minute preparation work that
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 15656b7fba6c..598b9473e46d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2,7 +2,7 @@
 #ifndef __KVM_HOST_H
 #define __KVM_HOST_H
 
-
+#include <linux/entry-kvm.h>
 #include <linux/types.h>
 #include <linux/hardirq.h>
 #include <linux/list.h>
@@ -2450,6 +2450,17 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 	vcpu->run->exit_reason = KVM_EXIT_INTR;
 	vcpu->stat.signal_exits++;
 }
+
+static inline int kvm_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
+{
+	int r = xfer_to_guest_mode_handle_work();
+
+	if (r) {
+		WARN_ON_ONCE(r != -EINTR);
+		kvm_handle_signal_exit(vcpu);
+	}
+	return r;
+}
 #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
 
 /*
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 8485f63863af..6fc762eaacca 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -1,17 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/entry-kvm.h>
-#include <linux/kvm_host.h>
 
-static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
+static int xfer_to_guest_mode_work(unsigned long ti_work)
 {
 	do {
 		int ret;
 
-		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
-			kvm_handle_signal_exit(vcpu);
+		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 			return -EINTR;
-		}
 
 		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
@@ -19,7 +16,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 		if (ti_work & _TIF_NOTIFY_RESUME)
 			resume_user_mode_work(NULL);
 
-		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
+		ret = arch_xfer_to_guest_mode_handle_work(ti_work);
 		if (ret)
 			return ret;
 
@@ -28,7 +25,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 	return 0;
 }
 
-int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
+int xfer_to_guest_mode_handle_work(void)
 {
 	unsigned long ti_work;
 
@@ -44,6 +41,6 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
 		return 0;
 
-	return xfer_to_guest_mode_work(vcpu, ti_work);
+	return xfer_to_guest_mode_work(ti_work);
 }
 EXPORT_SYMBOL_GPL(xfer_to_guest_mode_handle_work);
-- 
2.51.0.268.g9569e192d0-goog


