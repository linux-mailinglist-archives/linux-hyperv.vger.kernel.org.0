Return-Path: <linux-hyperv+bounces-2070-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EDD8BAD94
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 May 2024 15:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D439C1F22BF4
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 May 2024 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791C15533E;
	Fri,  3 May 2024 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HFWITQU/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C221153BFE;
	Fri,  3 May 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742367; cv=none; b=GQ9OHg/xEOhOpwbuzGZAhyfV7QD0JzREqSGAvwHovYdc/O5G/RyrKZuE6jM1GjNi6+/KYU1EgS2xPGQlR3kZXFHNC2+281PaDpzmFsFz81UzwAWwDnuExPM+97VVnEdIdg4IacuIDtd3swWz8qHRHj2djrV0OMTQSEDY6VgpjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742367; c=relaxed/simple;
	bh=UoeYf5nSk52yPkAQOPZ4IYRYsP6lzs+qv6PV8R5PQV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyjS1gT/9CP/7apbXSeDNSp4tkp6j5aGfbWb0nEab0TLphQpvxPlHyvhRqYQ1kHT/1aD4XRtPosm12MYufKbg9eA+wotzTdfgPQDhZWp+12t/hPm2kOAHSgydhfIgofNn9JNwmbcqPmp93UgI/ny7Uw9f3spu4SsjzlG1d6TwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HFWITQU/; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VWBGg1gbwzQgV;
	Fri,  3 May 2024 15:19:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714742363;
	bh=UoeYf5nSk52yPkAQOPZ4IYRYsP6lzs+qv6PV8R5PQV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFWITQU/9X3b9ffsqT8cXmFLNi73I0373rD/PFtktQpoOH+2zmgwV5Yfw+E/F3R8K
	 ZQMa5hgDHaXOz1twAAsinnIZ+pVrQ6lX74KgknaVZVKex/5MbuFdKHrG4JhjfAKeSk
	 26YP9U0qWz7UdHB+iwnqs+toDdVpb4+HaghZoTfY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VWBGf1DjgzGSs;
	Fri,  3 May 2024 15:19:22 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Alexander Graf <graf@amazon.com>,
	Angelina Vu <angelinavu@linux.microsoft.com>,
	Anna Trikalinou <atrikalinou@microsoft.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Forrest Yuan Yu <yuanyu@google.com>,
	James Gowans <jgowans@amazon.com>,
	James Morris <jamorris@linux.microsoft.com>,
	John Andersen <john.s.andersen@intel.com>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marian Rotariu <marian.c.rotariu@gmail.com>,
	=?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
	=?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Wei Liu <wei.liu@kernel.org>,
	Will Deacon <will@kernel.org>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	=?UTF-8?q?=C8=98tefan=20=C8=98icleru?= <ssicleru@bitdefender.com>,
	dev@lists.cloudhypervisor.org,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org,
	x86@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy configuration and violation
Date: Fri,  3 May 2024 15:19:08 +0200
Message-ID: <20240503131910.307630-4-mic@digikod.net>
In-Reply-To: <20240503131910.307630-1-mic@digikod.net>
References: <20240503131910.307630-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add an interface for user space to be notified about guests' Heki policy
and related violations.

Extend the KVM_ENABLE_CAP IOCTL with KVM_CAP_HEKI_CONFIGURE and
KVM_CAP_HEKI_DENIAL. Each one takes a bitmask as first argument that can
contains KVM_HEKI_EXIT_REASON_CR0 and KVM_HEKI_EXIT_REASON_CR4. The
returned value is the bitmask of known Heki exit reasons, for now:
KVM_HEKI_EXIT_REASON_CR0 and KVM_HEKI_EXIT_REASON_CR4.

If KVM_CAP_HEKI_CONFIGURE is set, a VM exit will be triggered for each
KVM_HC_LOCK_CR_UPDATE hypercalls according to the requested control
register. This enables to enlighten the VMM with the guest
auto-restrictions.

If KVM_CAP_HEKI_DENIAL is set, a VM exit will be triggered for each
pinned CR violation. This enables the VMM to react to a policy
violation.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240503131910.307630-4-mic@digikod.net
---

Changes since v1:
* New patch. Making user space aware of Heki properties was requested by
  Sean Christopherson.
---
 arch/x86/kvm/vmx/vmx.c   |   5 +-
 arch/x86/kvm/x86.c       | 114 +++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/x86.h       |   7 +--
 include/linux/kvm_host.h |   2 +
 include/uapi/linux/kvm.h |  22 ++++++++
 5 files changed, 136 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7ba970b525f7..5869a1ed7866 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5445,6 +5445,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 	int reg;
 	int err;
 	int ret;
+	bool exit = false;
 
 	exit_qualification = vmx_get_exit_qual(vcpu);
 	cr = exit_qualification & 15;
@@ -5454,8 +5455,8 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		val = kvm_register_read(vcpu, reg);
 		trace_kvm_cr_write(cr, val);
 
-		ret = heki_check_cr(vcpu, cr, val);
-		if (ret)
+		ret = heki_check_cr(vcpu, cr, val, &exit);
+		if (exit)
 			return ret;
 
 		switch (cr) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a5f47be59abc..865e88f2b0fc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -119,6 +119,10 @@ static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
 
+#define KVM_HEKI_EXIT_REASON_VALID_MASK ( \
+	KVM_HEKI_EXIT_REASON_CR0 | \
+	KVM_HEKI_EXIT_REASON_CR4)
+
 #define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS | \
                                     KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK)
 
@@ -4836,6 +4840,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		if (kvm_is_vm_type_supported(KVM_X86_SW_PROTECTED_VM))
 			r |= BIT(KVM_X86_SW_PROTECTED_VM);
 		break;
+	case KVM_CAP_HEKI_CONFIGURE:
+	case KVM_CAP_HEKI_DENIAL:
+		r = KVM_HEKI_EXIT_REASON_VALID_MASK;
+		break;
 	default:
 		break;
 	}
@@ -6729,6 +6737,22 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->lock);
 		break;
+#ifdef CONFIG_HEKI
+	case KVM_CAP_HEKI_CONFIGURE:
+		r = -EINVAL;
+		if (cap->args[0] & ~KVM_HEKI_EXIT_REASON_VALID_MASK)
+			break;
+		kvm->heki_configure_exit_reason = cap->args[0];
+		r = 0;
+		break;
+	case KVM_CAP_HEKI_DENIAL:
+		r = -EINVAL;
+		if (cap->args[0] & ~KVM_HEKI_EXIT_REASON_VALID_MASK)
+			break;
+		kvm->heki_denial_exit_reason = cap->args[0];
+		r = 0;
+		break;
+#endif
 	default:
 		r = -EINVAL;
 		break;
@@ -8283,11 +8307,60 @@ static unsigned long emulator_get_cr(struct x86_emulate_ctxt *ctxt, int cr)
 
 #ifdef CONFIG_HEKI
 
+static int complete_heki_configure_exit(struct kvm_vcpu *const vcpu)
+{
+	kvm_rax_write(vcpu, 0);
+	++vcpu->stat.hypercalls;
+	return kvm_skip_emulated_instruction(vcpu);
+}
+
+static int complete_heki_denial_exit(struct kvm_vcpu *const vcpu)
+{
+	kvm_inject_gp(vcpu, 0);
+	return 1;
+}
+
+/* Returns true if the @exit_reason is handled by @vcpu->kvm. */
+static bool heki_exit_cr(struct kvm_vcpu *const vcpu, const __u32 exit_reason,
+			 const u64 heki_reason, unsigned long value)
+{
+	switch (exit_reason) {
+	case KVM_EXIT_HEKI_CONFIGURE:
+		if (!(vcpu->kvm->heki_configure_exit_reason & heki_reason))
+			return false;
+
+		vcpu->run->heki_configure.reason = heki_reason;
+		memset(vcpu->run->heki_configure.reserved, 0,
+		       sizeof(vcpu->run->heki_configure.reserved));
+		vcpu->run->heki_configure.cr_pinned = value;
+		vcpu->arch.complete_userspace_io = complete_heki_configure_exit;
+		break;
+	case KVM_EXIT_HEKI_DENIAL:
+		if (!(vcpu->kvm->heki_denial_exit_reason & heki_reason))
+			return false;
+
+		vcpu->run->heki_denial.reason = heki_reason;
+		memset(vcpu->run->heki_denial.reserved, 0,
+		       sizeof(vcpu->run->heki_denial.reserved));
+		vcpu->run->heki_denial.cr_value = value;
+		vcpu->arch.complete_userspace_io = complete_heki_denial_exit;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	vcpu->run->exit_reason = exit_reason;
+	return true;
+}
+
 #define HEKI_ABI_VERSION 1
 
 static int heki_lock_cr(struct kvm_vcpu *const vcpu, const unsigned long cr,
-			unsigned long pin, unsigned long flags)
+			unsigned long pin, unsigned long flags, bool *exit)
 {
+	*exit = false;
+
 	if (flags) {
 		if ((flags == KVM_LOCK_CR_UPDATE_VERSION) && !cr && !pin)
 			return HEKI_ABI_VERSION;
@@ -8307,6 +8380,8 @@ static int heki_lock_cr(struct kvm_vcpu *const vcpu, const unsigned long cr,
 			return -KVM_EINVAL;
 
 		atomic_long_or(pin, &vcpu->kvm->heki_pinned_cr0);
+		*exit = heki_exit_cr(vcpu, KVM_EXIT_HEKI_CONFIGURE,
+				     KVM_HEKI_EXIT_REASON_CR0, pin);
 		return 0;
 	case 4:
 		/* Checks for irrelevant bits. */
@@ -8316,24 +8391,37 @@ static int heki_lock_cr(struct kvm_vcpu *const vcpu, const unsigned long cr,
 		/* Ignores bits not present in host. */
 		pin &= __read_cr4();
 		atomic_long_or(pin, &vcpu->kvm->heki_pinned_cr4);
+		*exit = heki_exit_cr(vcpu, KVM_EXIT_HEKI_CONFIGURE,
+				     KVM_HEKI_EXIT_REASON_CR4, pin);
 		return 0;
 	}
 	return -KVM_EINVAL;
 }
 
+/*
+ * Sets @exit to true if the caller must exit (i.e. denied access) with the
+ * returned value:
+ * - 0 when kvm_run is configured;
+ * - 1 when there is no user space handler.
+ */
 int heki_check_cr(struct kvm_vcpu *const vcpu, const unsigned long cr,
-		  const unsigned long val)
+		  const unsigned long val, bool *exit)
 {
 	unsigned long pinned;
 
+	*exit = false;
+
 	switch (cr) {
 	case 0:
 		pinned = atomic_long_read(&vcpu->kvm->heki_pinned_cr0);
 		if ((val & pinned) != pinned) {
 			pr_warn_ratelimited(
 				"heki: Blocked CR0 update: 0x%lx\n", val);
-			kvm_inject_gp(vcpu, 0);
-			return 1;
+			*exit = true;
+			if (heki_exit_cr(vcpu, KVM_EXIT_HEKI_DENIAL,
+					 KVM_HEKI_EXIT_REASON_CR0, val))
+				return 0;
+			return complete_heki_denial_exit(vcpu);
 		}
 		return 0;
 	case 4:
@@ -8341,8 +8429,11 @@ int heki_check_cr(struct kvm_vcpu *const vcpu, const unsigned long cr,
 		if ((val & pinned) != pinned) {
 			pr_warn_ratelimited(
 				"heki: Blocked CR4 update: 0x%lx\n", val);
-			kvm_inject_gp(vcpu, 0);
-			return 1;
+			*exit = true;
+			if (heki_exit_cr(vcpu, KVM_EXIT_HEKI_DENIAL,
+					 KVM_HEKI_EXIT_REASON_CR4, val))
+				return 0;
+			return complete_heki_denial_exit(vcpu);
 		}
 		return 0;
 	}
@@ -8356,9 +8447,10 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	int res = 0;
+	bool exit = false;
 
-	res = heki_check_cr(vcpu, cr, val);
-	if (res)
+	res = heki_check_cr(vcpu, cr, val, &exit);
+	if (exit)
 		return res;
 
 	switch (cr) {
@@ -10222,7 +10314,11 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 		if (a0 > U32_MAX) {
 			ret = -KVM_EINVAL;
 		} else {
-			ret = heki_lock_cr(vcpu, a0, a1, a2);
+			bool exit = false;
+
+			ret = heki_lock_cr(vcpu, a0, a1, a2, &exit);
+			if (exit)
+				return ret;
 		}
 		break;
 #endif /* CONFIG_HEKI */
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index ade7d68ddaff..2740b74ab583 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -292,18 +292,19 @@ static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
 
 #ifdef CONFIG_HEKI
 
-int heki_check_cr(struct kvm_vcpu *vcpu, unsigned long cr, unsigned long val);
+int heki_check_cr(struct kvm_vcpu *vcpu, unsigned long cr, unsigned long val,
+		  bool *exit);
 
 #else /* CONFIG_HEKI */
 
 static inline int heki_check_cr(struct kvm_vcpu *vcpu, unsigned long cr,
-				unsigned long val)
+				unsigned long val, bool *exit)
 {
 	return 0;
 }
 
 static inline int heki_lock_cr(struct kvm_vcpu *const vcpu, unsigned long cr,
-			       unsigned long pin)
+			       unsigned long pin, bool *exit)
 {
 	return 0;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6ff13937929a..cf8e271d47aa 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -839,6 +839,8 @@ struct kvm {
 #ifdef CONFIG_HEKI
 	atomic_long_t heki_pinned_cr0;
 	atomic_long_t heki_pinned_cr4;
+	u64 heki_configure_exit_reason;
+	u64 heki_denial_exit_reason;
 #endif /* CONFIG_HEKI */
 
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2190adbe3002..1051c2f817ba 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -178,6 +178,8 @@ struct kvm_xen_exit {
 #define KVM_EXIT_NOTIFY           37
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
+#define KVM_EXIT_HEKI_CONFIGURE   40
+#define KVM_EXIT_HEKI_DENIAL      41
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -433,6 +435,24 @@ struct kvm_run {
 			__u64 gpa;
 			__u64 size;
 		} memory_fault;
+		/* KVM_EXIT_HEKI_CONFIGURE */
+		struct {
+#define KVM_HEKI_EXIT_REASON_CR0	(1ULL << 0)
+#define KVM_HEKI_EXIT_REASON_CR4	(1ULL << 1)
+			__u64 reason;
+			union {
+				__u64 cr_pinned;
+				__u64 reserved[7]; /* ignored */
+			};
+		} heki_configure;
+		/* KVM_EXIT_HEKI_DENIAL */
+		struct {
+			__u64 reason;
+			union {
+				__u64 cr_value;
+				__u64 reserved[7]; /* ignored */
+			};
+		} heki_denial;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -917,6 +937,8 @@ struct kvm_enable_cap {
 #define KVM_CAP_MEMORY_ATTRIBUTES 233
 #define KVM_CAP_GUEST_MEMFD 234
 #define KVM_CAP_VM_TYPES 235
+#define KVM_CAP_HEKI_CONFIGURE 236
+#define KVM_CAP_HEKI_DENIAL 237
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.45.0


