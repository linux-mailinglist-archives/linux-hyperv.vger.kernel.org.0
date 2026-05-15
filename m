Return-Path: <linux-hyperv+bounces-10961-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDZdJsB1B2pL4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10961-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:36:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11319556F1A
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A9E730B4488
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8FE40EBD2;
	Fri, 15 May 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ta25z2bi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C768412134
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872883; cv=none; b=B4hpCzJXJKTW0RKTHqmeYfscx48INPxg29Rd62W3cR7DKqtpbFfS5UylmiUOzcufxVk93n0paZbSv8fgWZ/DCKKQUaqQrW/0Unhk5M/ucsp70LHMJ3Y1URbW2Fvw3r3Xjp/SDA7wVelA++RkUl0j5tX3CR5Ox7LD+CJDXbfDHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872883; c=relaxed/simple;
	bh=+wUr561K82TnIIpq5POLLP9qm+OKlIkzSL6qT55+ohk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pDAfPQpAn+ek4vUWh/qWxFNy3/T05ffBJR8mVDeDzvC03Wdj7q32WF902CmAa4nvisodEd2gk8SAo5yaLUa3tMlP5NDfO3XNNHXrndj3SmaT++CDKnz9QOdCQptfO7V3vrKTXdJUL9w0SjpPXKl6t4t1UtQuGPdRpy2x5xyzQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ta25z2bi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83ef22f8e8bso177180b3a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872881; x=1779477681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rGCW9kF5gS8wHa+YnUvDY3DL62KvWmhRkotZ7eduTfw=;
        b=Ta25z2bi/E1rNTbhmSno1IWUNLCuO+aK1Y6t/kHmk9LK7KaW8q74FErtbeLvxVdCLv
         gjFYghKJmudd1vj3medSzcTDBUFt0WUZtmK8VmGJ58JMurKrko1SCC04IKAVhLhDWEkB
         XYK/dG5Cs+L+ExLY+z//vb+QAAMjjEZ7TtgmZx0AHGlzZVr2JH5AhWKxxsL4KY5DwyM5
         JO6gspvhBPtDM2hp0lOENIN409lzPzHLEqnUZBn2Wb7lUcx3ERW8kvam2giqyCCaT2qw
         5yLcn15RyQccNh+vMUkB8u1lfp4qkN4ukcZYhkUkMmA3dIqOwkYuALVdwUd3/LZ9cR45
         FaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872881; x=1779477681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGCW9kF5gS8wHa+YnUvDY3DL62KvWmhRkotZ7eduTfw=;
        b=ZnLfQmfDcBoWnV8YBluok6LEIf9DJ+YeiJPzOEchXczvFPqFboiXFkYoZsc+xe5HIi
         lOeCb9UOUTcQvLvumShqhw9Ff9OIeqcL0Uk0O/sHslj7lRtG0+rcXcdSZeRbJZMasACy
         1o3LuavoDf7bKGw/itINNWkOnfM4I6NVWDDIA5/JW+qsj3HUFu35+M8vgHDmhkvftscB
         As+iT94TPDKbywcBNX/5/Rj5Px+WxQ4H4xVTmCundwIoCKSG07nlbciCuwrH99txGk1R
         kEPACbzXlA1RmCwwsvdbHujLKWItFJR2LKdAoV+ZqBNWnCLz/mrsxobqhVScDqiT+PCq
         Ac2w==
X-Forwarded-Encrypted: i=1; AFNElJ/D9HqK477ljoaiXpPc3IX0QL1BYcXSbWP4zX3h6B2OLIeKSJb+ZI2S9pg98hiiqeO8Zrp/SfMcKYZ5bF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsaZa1DYUefq/H0OSKR1ZQbTrDqvpgF2gFmr58AduhPDvo6ylS
	DWcj0afmV+HAu0YndfRrE9Hz0qMiYepUNHApUk+olgCivyYRLZ9seBB293B6G2HWnfwV1E5UMYU
	obQNU+A==
X-Received: from pfkq14.prod.google.com ([2002:a05:6a00:84e:b0:839:4a33:c354])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12e4:b0:835:405a:7e68
 with SMTP id d2e1a72fcca58-83f33d9dd83mr5938852b3a.32.1778872880815; Fri, 15
 May 2026 12:21:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:39 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-39-seanjc@google.com>
Subject: [PATCH v3 38/41] x86/paravirt: kvmclock: Setup kvmclock early iff
 it's sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 11319556F1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10961-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de,amazon.co.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Rework the seemingly generic x86_cpuinit_ops.early_percpu_clock_init hook
into a dedicated PV sched_clock hook, as the only reason the hook exists
is to allow kvmclock to enable its PV clock on secondary CPUs before the
kernel tries to reference sched_clock, e.g. when grabbing a timestamp for
printk.

Rearranging the hook doesn't exactly reduce complexity; arguably it does
the opposite.  But as-is, it's practically impossible to understand *why*
kvmclock needs to do early configuration.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h    |  8 ++++++--
 arch/x86/include/asm/x86_init.h |  2 --
 arch/x86/kernel/kvmclock.c      | 13 ++++++-------
 arch/x86/kernel/smpboot.c       |  3 ++-
 arch/x86/kernel/tsc.c           | 16 +++++++++++++++-
 arch/x86/kernel/x86_init.c      |  1 -
 6 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index ca5c95d48c03..ab1271bd9c3b 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -15,14 +15,18 @@ extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				      void (*save)(void), void (*restore)(void));
+				      void (*save)(void), void (*restore)(void),
+				      void (*start_secondary));
 
 static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 						     void (*save)(void),
 						     void (*restore)(void))
 {
-	(void)__paravirt_set_sched_clock(func, true, save, restore);
+	(void)__paravirt_set_sched_clock(func, true, save, restore, NULL);
 }
+void paravirt_sched_clock_start_secondary(void);
+#else
+static inline void paravirt_sched_clock_start_secondary(void) { }
 #endif
 
 /*
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 6c8a6ead84f6..d1b3f18ea41f 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -187,13 +187,11 @@ struct x86_init_ops {
 /**
  * struct x86_cpuinit_ops - platform specific cpu hotplug setups
  * @setup_percpu_clockev:	set up the per cpu clock event device
- * @early_percpu_clock_init:	early init of the per cpu clock event device
  * @fixup_cpu_id:		fixup function for cpuinfo_x86::topo.pkg_id
  * @parallel_bringup:		Parallel bringup control
  */
 struct x86_cpuinit_ops {
 	void (*setup_percpu_clockev)(void);
-	void (*early_percpu_clock_init)(void);
 	void (*fixup_cpu_id)(struct cpuinfo_x86 *c, int node);
 	bool parallel_bringup;
 };
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0578bc448b1b..62c8ea2e6769 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -127,12 +127,13 @@ static void kvm_save_sched_clock_state(void)
 	kvmclock_disable();
 }
 
-#ifdef CONFIG_SMP
-static void kvm_setup_secondary_clock(void)
+static void kvm_setup_secondary_sched_clock(void)
 {
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_SMP)))
+		return;
+
 	kvm_register_clock("secondary cpu, sched_clock setup");
 }
-#endif
 
 static void kvm_restore_sched_clock_state(void)
 {
@@ -352,7 +353,8 @@ static __init void kvm_sched_clock_init(bool stable)
 {
 	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
 				       kvm_save_sched_clock_state,
-				       kvm_restore_sched_clock_state))
+				       kvm_restore_sched_clock_state,
+				       kvm_setup_secondary_sched_clock))
 		return;
 
 	kvm_sched_clock_offset = kvm_clock_read();
@@ -437,9 +439,6 @@ void __init kvmclock_init(void)
 
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_SMP
-	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
-#endif
 	kvm_get_preset_lpj();
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 294a8ea60298..318ae70e5e7b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -78,6 +78,7 @@
 #include <asm/io_apic.h>
 #include <asm/fpu/api.h>
 #include <asm/setup.h>
+#include <asm/timer.h>
 #include <asm/uv/uv.h>
 #include <asm/microcode.h>
 #include <asm/i8259.h>
@@ -275,7 +276,7 @@ static void notrace __noendbr start_secondary(void *unused)
 	cpu_init();
 	fpu__init_cpu();
 	rcutree_report_cpu_starting(raw_smp_processor_id());
-	x86_cpuinit.early_percpu_clock_init();
+	paravirt_sched_clock_start_secondary();
 
 	ap_starting();
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7a261214fa3e..f78e86494dec 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,19 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
+#ifdef CONFIG_SMP
+static void (*pv_sched_clock_start_secondary)(void) __ro_after_init;
+
+void paravirt_sched_clock_start_secondary(void)
+{
+	if (pv_sched_clock_start_secondary)
+		pv_sched_clock_start_secondary();
+}
+#endif
+
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				      void (*save)(void), void (*restore)(void))
+				      void (*save)(void), void (*restore)(void),
+				      void (*start_secondary))
 {
 	/*
 	 * Don't replace TSC with a PV clock when running as a CoCo guest and
@@ -298,6 +309,9 @@ int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 	static_call_update(pv_sched_clock, func);
 	x86_platform.save_sched_clock_state = save;
 	x86_platform.restore_sched_clock_state = restore;
+#ifdef CONFIG_SMP
+	pv_sched_clock_start_secondary = start_secondary;
+#endif
 	return 0;
 }
 #else
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ebefb77c37bb..cbb5ee613ed5 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -128,7 +128,6 @@ struct x86_init_ops x86_init __initdata = {
 };
 
 struct x86_cpuinit_ops x86_cpuinit = {
-	.early_percpu_clock_init	= x86_init_noop,
 	.setup_percpu_clockev		= setup_secondary_APIC_clock,
 	.parallel_bringup		= true,
 };
-- 
2.54.0.563.g4f69b47b94-goog


