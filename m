Return-Path: <linux-hyperv+bounces-4110-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B08A472B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147831889905
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8782E22FDEE;
	Thu, 27 Feb 2025 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGdP3V47"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38022D7AC
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622789; cv=none; b=sMf6q+eJ9B5Bcn3a/hnY1ZtkDKR44/g3ymVn7CWh5oR0FVqB06HhLHDnde4nozkBJZBoVsk399d2e8Jvi+/dEEtn5cOhcn9GGqYCf28jb9sn8HXMm+OlGB7IOogiNbT1cI+KFPMJpKj6f0CYvuRJczxzh4VdIRsQBrUWOHIEljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622789; c=relaxed/simple;
	bh=zjjnD8AWfMJS2/xbCkWD8FS8YCODvYXqFbARM/Ts+/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GHCz90g5SC8ZMU61oP1K0LVowhle6N6JZnKQftXXy1pRtPDCK+mWOYhcWLBDjDavmMSiwf2w+Y4FaWS+ctUm2tD79vQpQ6x8/uIRFpgCOvt8hI/1mYVdRgT32acqzqtWCZzUwbtkp4QvHApyD6lD4P2Na8J9/iMtIABaA58B7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LGdP3V47; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2234dddbd6fso8510425ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622786; x=1741227586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3WIlT5dxc8eqreSuMAUxshuXGBEM8C/NLPwcD1zy3Y0=;
        b=LGdP3V47zvBfuYhkNIl11AV1RfpjpLs+4ZoASXY5qRpzH0BbueuSYw41Iptz3ijd3v
         gtic5rc9c0YEZMvGsRCQDIrMPaDUL6uHWG5KOUwXvJmOOM58H//frQlF7FnmwGuft8Or
         xaAz8D6Spnx/Hx5xUKEmQxvRMvI8fliZDw55LCSQoM7Kni64zuQkGKnAziTtiFGFhtn/
         KvjEcTKJbxSuG8OwRnkKPlkFJgyV2pOU5B4vJSVbGRBy2R64Zek5I9LgxpP61GR4lU8C
         gVLzI6H3fBqw/0SYdFT+kjqujcFYkM1DN+IkAhUFv3/B+J2ud4G8Jf48/cEHpguSI2sF
         L1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622786; x=1741227586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WIlT5dxc8eqreSuMAUxshuXGBEM8C/NLPwcD1zy3Y0=;
        b=P1aUQIPHykGBYgoA5ljGzP004FYQtxSjK6Xi7pd1hdBkBCpX7BJOiH9py1s0kdjoa3
         SrvznKrT03m9us3fotADPLqh9NI+7lHiXKZLM5TRBtLLKuecG2UaZ+2KvvjyOShWJueW
         69WvpGTmYqUowNROj/wmBJvRBxZovd6GJvapSK/uIwnMLPD5NUDGYA+w1MU/nznTecTM
         j2TOi9isn61VHKfPuglh79Fm8VMzvWfqyNDdrs6zSgXK+uu5mHx6snVI2u4TebCLXysT
         0Bz976YLW6+TK8eWZLUZb082O4KbpVs9f7mmQ9XcgpgtsRCFWL5kyLpBzApNK29cjzf+
         LofA==
X-Forwarded-Encrypted: i=1; AJvYcCXXTVRSznn6a+6rJatV+HpT81pltoHVRlBfssccC+ChMH5J/BoNLo/63QigpkQ1iTRXr1FjIltZfYzesVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkchgRiLEnRT1zoHeTRKFjw9CMWwCkiXm9mJFh306paHNZSzsF
	9hLC6o7V1SZy+CpMCQd505vueT5hd7To+UGCfiptCNTBBMHbNX0tzm1wtMnGrEm0HE2Nnbg6soF
	pwA==
X-Google-Smtp-Source: AGHT+IEKa+U3XmhHVLGnMc9mY3OxJMjJ1pR3+E2erpOOt4xnyyZwND9G3ZoTVgYNZ7eny0ZZLwJ5fe0HKa8=
X-Received: from pjvf4.prod.google.com ([2002:a17:90a:da84:b0:2ea:3a1b:f493])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80e:b0:21f:3d0d:2408
 with SMTP id d9443c01a7336-2234a28af91mr27386885ad.10.1740622786458; Wed, 26
 Feb 2025 18:19:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:41 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-26-seanjc@google.com>
Subject: [PATCH v2 25/38] x86/kvmclock: Hook clocksource.suspend/resume when
 kvmclock isn't sched_clock
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

Save/restore kvmclock across suspend/resume via clocksource hooks when
kvmclock isn't being used for sched_clock.  This will allow using kvmclock
as a clocksource (or for wallclock!) without also using it for sched_clock.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0580fe1aefa0..319f8b2d0702 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -130,7 +130,17 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
-	kvm_register_clock("primary cpu clock, resume");
+	kvm_register_clock("primary cpu, sched_clock resume");
+}
+
+static void kvmclock_suspend(struct clocksource *cs)
+{
+	kvmclock_disable();
+}
+
+static void kvmclock_resume(struct clocksource *cs)
+{
+	kvm_register_clock("primary cpu, clocksource resume");
 }
 
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
@@ -201,6 +211,8 @@ static struct clocksource kvm_clock = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.id     = CSID_X86_KVM_CLK,
 	.enable	= kvm_cs_enable,
+	.suspend = kvmclock_suspend,
+	.resume = kvmclock_resume,
 };
 
 static void __init kvmclock_init_mem(void)
@@ -295,6 +307,15 @@ static void __init kvm_sched_clock_init(bool stable)
 	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
 				   kvm_save_sched_clock_state, kvm_restore_sched_clock_state);
 
+	/*
+	 * The BSP's clock is managed via dedicated sched_clock save/restore
+	 * hooks when kvmclock is used as sched_clock, as sched_clock needs to
+	 * be kept alive until the very end of suspend entry, and restored as
+	 * quickly as possible after resume.
+	 */
+	kvm_clock.suspend = NULL;
+	kvm_clock.resume = NULL;
+
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
 
-- 
2.48.1.711.g2feabab25a-goog


