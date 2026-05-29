Return-Path: <linux-hyperv+bounces-11365-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB6YJNO3GWpWyggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11365-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:59:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D338605306
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C1D633D6F10
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8FA403E9C;
	Fri, 29 May 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdHixLCX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9B402BA0
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067309; cv=none; b=SPfrL7vSi8CUMD6NNF1InloUhLu5aPG89xfZW0zQ4zDAKyknr0pZPzEIR15YAuOA7f7k/b7oNNkLT6rxmAw6YmBZw9Y9mqp7qXE+cJpmTcg5O76FI5KhpJkmHTZaGD/s7ojpHzEFHlwyEQNF8EVzGRDm0aqoYM1Kad10fOY5U8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067309; c=relaxed/simple;
	bh=fmtwqTBYkb6t5vw+7MpnJ0D/yvZROFNekcfkLoS9uAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s8HS0VFYB+a9+iDlsLBHYIMYHdEADgB1JOdYLG6U9skbaB7hJrkkQEvOX2yyIwHDIXgZRKHOeYoh7voCJvXp6tMYBkbbrKiug8itlooVGQaAqunFuWVtOSiye5eplN8i2chxCVq26CyKnGAHpi0+Su2A/OlJkfwYVXPVyyrf4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdHixLCX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc763c7256so291267625ad.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067307; x=1780672107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2eZ/5/NHYtlqNBUgYS8sS/KxrmMqlqE8QNmqFczaR90=;
        b=rdHixLCX61dil2+0N2A/tYy0wy2Yn191b+ZzoDAovSyX7g0g184O6J8KCPwJNMWEnh
         BoV+hHTMxc1vkcjeAVOHbZnoZhokpyiBvvK16SfbGYJ3QjyhErPpBNxztr+KRPvm8euw
         A3hX+ECenN+bpU+oZxgue0Lu3SYC51/edAT2wkFoFp5bBGW7IDqVfmkWtamHkRrSCcGU
         cB3t687aMts2gVKeSYWgyOPDlP1fwYXDs2borjN64W61oAHhxOEZcsvmnng7FAO00+du
         aiGPJ6NDbZGEqBQGAmoZqNR8CX1oJjMC0PZxRE8bRSs7bZtz6ASc3Gejy3Ja05UOk1Hz
         oTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067307; x=1780672107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eZ/5/NHYtlqNBUgYS8sS/KxrmMqlqE8QNmqFczaR90=;
        b=hWy249MfXGePrpHiJn8+vgaAgJT9ijgXWoc/f7OSMx5jt+oduXH2h1kAtoyQNosaq5
         fbV/WNkvQtjFB+eeYX8AHn8cJmFrNCv5OxdSxEX5BQcUzY7D/ITBjVjSJdbMKxzfdv7V
         LPQ/cz3hxMYTkrRYTgyGHyLqxwbrANaZ/bSWuhrW6o9cyR4Kv4i+WmkwkFtSpJpyHwGf
         d8MnUqZepS0vUK1CtMeV2twEBllZ0zrsNgoJeRwe7KO1Z4MWyXkSm251Pf8wi19usFPg
         1v0ELzteoAyN1WdSNr68GBwFk/o4GNO7P5VAKWbQ4fZrcqBxDFs7pObqV6EzEHwq0gQt
         D7Vg==
X-Forwarded-Encrypted: i=1; AFNElJ/3o2rcSUDoKI3kLf0SANxRNdpOqBQl+tlhWyooQrRvW/C0sLW36k3MlmsbpKvrUo6WXwYJfxbCCoJjAMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fymZ60CUPytznpdAqZPOpBNAG3onJUPeuCjpsxG/HvugdTaw
	abzcduos7u46TOkmNaM61KDVrh8X4Z1xN0Fgv1Lf/1+2W6mXSR9/7th+oNA1MEuzNmmqgrw82ad
	t+um3UQ==
X-Received: from plau10.prod.google.com ([2002:a17:903:304a:b0:2ba:67f8:6257])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94c:b0:2bf:604:d5ad
 with SMTP id d9443c01a7336-2bf368904abmr2085275ad.37.1780067306314; Fri, 29
 May 2026 08:08:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:24 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150824.714934-1-seanjc@google.com>
Subject: [PATCH v4 43/47] x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11365-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazon.co.uk:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[zytor.com,intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,infradead.org,outlook.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 0D338605306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a return code to __paravirt_set_sched_clock() so that the kernel can
reject attempts to use a PV sched_clock without breaking the caller.  E.g.
when running as a CoCo VM with a secure TSC, using a PV clock is generally
undesirable.

Note, kvmclock is the only PV clock that does anything "extra" beyond
simply registering itself as sched_clock, i.e. is the only caller that
needs to check the new return value.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 6 +++---
 arch/x86/kernel/kvmclock.c   | 9 ++++++---
 arch/x86/kernel/tsc.c        | 5 +++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index 96ae7feac47c..ca5c95d48c03 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,14 +14,14 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				       void (*save)(void), void (*restore)(void));
+int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				      void (*save)(void), void (*restore)(void));
 
 static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 						     void (*save)(void),
 						     void (*restore)(void))
 {
-	__paravirt_set_sched_clock(func, true, save, restore);
+	(void)__paravirt_set_sched_clock(func, true, save, restore);
 }
 #endif
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 73fabfac2bc9..1336c24f59cf 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -310,10 +310,13 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 
 static __init void kvm_sched_clock_init(bool stable)
 {
+	/* Ensure the offset is configured before making kvmclock visible! */
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
+
+	if (__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				       kvm_save_sched_clock_state,
+				       kvm_restore_sched_clock_state))
+		return;
 
 	/*
 	 * The BSP's clock is managed via dedicated sched_clock save/restore
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6da0a3ac05c2..7bcf757bf551 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,8 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				       void (*save)(void), void (*restore)(void))
+int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				      void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
@@ -289,6 +289,7 @@ void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 	static_call_update(pv_sched_clock, func);
 	x86_platform.save_sched_clock_state = save;
 	x86_platform.restore_sched_clock_state = restore;
+	return 0;
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
-- 
2.54.0.823.g6e5bcc1fc9-goog


