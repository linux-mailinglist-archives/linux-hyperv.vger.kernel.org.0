Return-Path: <linux-hyperv+bounces-11753-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ew9WDrNsRWoU/woAu9opvQ
	(envelope-from <linux-hyperv+bounces-11753-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:38:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA96F0F53
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:38:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nnZySWBG;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11753-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11753-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5C223014C67
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA47641C8FC;
	Wed,  1 Jul 2026 19:33:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497804189AD
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934381; cv=none; b=qTm+qjSyfGe17qBZ+LQCeM3BO70Ed1j2IJFr2e6q1u9GXOWBvB9PA93FJp5pBap2NWcySWwXngeJv2Jo1fsmP+lU7ZZHUdeUA1m3i572Y9mz3YXAaH/3Z8xcqaQbTYeJNz8fxORAcjRC6no3GlieT6Il5ZXdNt7Rze+HD1DalsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934381; c=relaxed/simple;
	bh=bxwmN1s+gw9A/9J+eO2ggxcdQxgsvCoLoyxswI/ndP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NE5PnQLrnD1gsBYl1ZfE1S844aJFLkIvNRLQr0wGm8sRNkU9+WLMMaWh4epcsj3AtG0IclCtB+aVJMY+FK8UYajFMs6uvlCK2iokPVUynOTNDPYcfhqKQCG8kPVAQL7inyTrAcKmuWRMXo5Z+5jxPFFfxFkaokfmkg5RLi/CRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnZySWBG; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso935696a12.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934377; x=1783539177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ3m/TrNbE4SFzRsHKX+8uSq+s8U3KdnfXDvnqXCgWk=;
        b=nnZySWBGp+4OwixaUbpVyRGP59jpjcE5YokPICSJZcGynsde3ud2282qvNu6jWjx3j
         FZRaAdNfuQYtRkUsLCVePI1+wT9dTJSRdxdxs4/xvrlMtb4eM7aQJjHGDmB9P/dCYGwY
         xz4t1MTj7VNgf7F7Xqs2vGVFaTqYPfTZ+mEnXADMJeecyJkf8QMP1+7Q9hbDFroEBZZG
         rNcyQ6gC3aE5RbFc1s+5xzx3o9uu4MalqL6FhF7DryEg9wd+OY55t9LRS5SWqwo8/XTX
         m1pQEyobDYDuKyWgmrhIcHj+VomgQ/sRzY7rzzeuyMAySvKEy2ptJC32e9bNy4F3ICwS
         lW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934377; x=1783539177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJ3m/TrNbE4SFzRsHKX+8uSq+s8U3KdnfXDvnqXCgWk=;
        b=YsOzz0QuyR90JyE2jC78x2497MTM0oruU+kZH8+Pg8paz1+d0IqAFUE93pQ8P4EfUH
         M8soE1/HbGUMYr5/d+Bv4ZpT01b4f45u3qlk6Zpn8k+eim7YYcl/Z6FWzAYbBjIcMwVd
         guVq1HKtSH8mz7SRkL3zf0JT4jScW+sz2yxuJ9U/B+b5W202G93KjnTXad7/JhnF/Tn8
         JMiZzFm/nN2WqlvFVgHsR6ADZx3NiNZSTtyU4JXeWrCn/WVlJrYwat2S+3U8krRBUX8O
         SHIwjJys8LhZt9yVpd7YR5dXK79S4tfHEvU+6ArwwwwnDzynJlqH5m2qm02WbuPnhnJG
         WllA==
X-Forwarded-Encrypted: i=1; AFNElJ+YiVH+wKQXGllVIYGMvb7mDeT1bHAU/WbP/EJ9iMtIkq8Z6hy04FJMiZMNDP7Q6a/on+6RI7d2gi84hCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWsHApxTxO1K29AuE8Wafr05MGWUQmOwp55twrKDmxblNK17A
	k4tNagLbeURkJjWU306IKJTfK7sBh0mQcv/LAAyczY4PTGUjVPAJYNzpUT+MbH0KREcO4fJOcNx
	OW0XQkA==
X-Received: from pgwa12.prod.google.com ([2002:a65:654c:0:b0:c8a:eb2c:4d63])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1b84:b0:398:9b42:69f7
 with SMTP id adf61e73a8af0-3bfed3b19b0mr3537498637.39.1782934376998; Wed, 01
 Jul 2026 12:32:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:46 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-26-seanjc@google.com>
Subject: [PATCH v5 25/51] clocksource: hyper-v: Register sched_clock
 save/restore iff it's necessary
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11753-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,zytor.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,amazon.co.uk,infradead.org,outlook.com,linutronix.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FBA96F0F53

Register the Hyper-V reference counter (refcounter) callbacks for saving
and restoring its PV sched_clock, if and only if the refcounter is
actually being used for sched_clock.  Currently, Hyper-V overrides the
save/restore hooks if the reference TSC available, whereas the Hyper-V
refcounter code only overrides sched_clock if the reference TSC is
available *and* it's not invariant.  The flaw is effectively papered over
by invoking the "old" save/restore callbacks as part of save/restore, but
that's unnecessary and fragile.

To avoid introducing more complexity, and to allow for additional cleanups
of the PV sched_clock code, move the save/restore hooks and logic into
hyperv_timer.c and simply wire up the hooks when overriding sched_clock
itself.

Note, while the Hyper-V refcounter code is intended to be architecture
neutral, CONFIG_PARAVIRT is firmly x86-only, i.e. adding a small amount of
x86 specific code (which will be reduced in future cleanups) doesn't
meaningfully pollute generic code.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/mshyperv.c     | 58 ------------------------------
 drivers/clocksource/hyperv_timer.c | 50 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e03c69a4db33..c4da8e35319a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -275,63 +275,6 @@ static void hv_guest_crash_shutdown(struct pt_regs *regs)
 }
 #endif /* CONFIG_CRASH_DUMP */
 
-static u64 hv_ref_counter_at_suspend;
-static void (*old_save_sched_clock_state)(void);
-static void (*old_restore_sched_clock_state)(void);
-
-/*
- * Hyper-V clock counter resets during hibernation. Save and restore clock
- * offset during suspend/resume, while also considering the time passed
- * before suspend. This is to make sure that sched_clock using hv tsc page
- * based clocksource, proceeds from where it left off during suspend and
- * it shows correct time for the timestamps of kernel messages after resume.
- */
-static void save_hv_clock_tsc_state(void)
-{
-	hv_ref_counter_at_suspend = hv_read_reference_counter();
-}
-
-static void restore_hv_clock_tsc_state(void)
-{
-	/*
-	 * Adjust the offsets used by hv tsc clocksource to
-	 * account for the time spent before hibernation.
-	 * adjusted value = reference counter (time) at suspend
-	 *                - reference counter (time) now.
-	 */
-	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
-}
-
-/*
- * Functions to override save_sched_clock_state and restore_sched_clock_state
- * functions of x86_platform. The Hyper-V clock counter is reset during
- * suspend-resume and the offset used to measure time needs to be
- * corrected, post resume.
- */
-static void hv_save_sched_clock_state(void)
-{
-	old_save_sched_clock_state();
-	save_hv_clock_tsc_state();
-}
-
-static void hv_restore_sched_clock_state(void)
-{
-	restore_hv_clock_tsc_state();
-	old_restore_sched_clock_state();
-}
-
-static void __init x86_setup_ops_for_tsc_pg_clock(void)
-{
-	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
-		return;
-
-	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
-	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
-
-	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
-	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
-}
-
 #ifdef CONFIG_X86_64
 DEFINE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
 EXPORT_STATIC_CALL_TRAMP_GPL(hv_hypercall);
@@ -736,7 +679,6 @@ static void __init ms_hyperv_init_platform(void)
 
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
-	x86_setup_ops_for_tsc_pg_clock();
 	hv_vtl_init_platform();
 #endif
 	/*
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index df567795d175..4293173c3a27 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -554,10 +554,60 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 #elif defined CONFIG_PARAVIRT
 #include <asm/timer.h>
 
+static u64 hv_ref_counter_at_suspend;
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
+	hv_ref_counter_at_suspend = hv_read_reference_counter();
+}
+
+static void restore_hv_clock_tsc_state(void)
+{
+	/*
+	 * Adjust the offsets used by hv tsc clocksource to
+	 * account for the time spent before hibernation.
+	 * adjusted value = reference counter (time) at suspend
+	 *                - reference counter (time) now.
+	 */
+	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
+}
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
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
 {
 	/* We're on x86/x64 *and* using PV ops */
 	paravirt_set_sched_clock(sched_clock);
+
+	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
+	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
+
+	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
+	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
 }
 #else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
 static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
-- 
2.55.0.rc0.799.gd6f94ed593-goog


