Return-Path: <linux-hyperv+bounces-3823-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8B7A246C8
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 03:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CA5188A248
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 02:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C701C5F1F;
	Sat,  1 Feb 2025 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTdJFo6H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC41C5D4F
	for <linux-hyperv@vger.kernel.org>; Sat,  1 Feb 2025 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376277; cv=none; b=VHj+KAbYJKKigd+MmPWepkWwsfJ4U8QhC2WV92nBP/Fo/rBfe3fIzeIBFXH28Nt0hMU212ZSQyJQJE5lYFlgS+N2SxIufREwCx6TUPZY1JbVZV7lo9DNBNH7TVgIJdI7WAn1I6fAVWCTQTX/24R26e7F0aOqoNQTbKmNqyYHI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376277; c=relaxed/simple;
	bh=p/Vg9iE4sgVLr3/9VKFQQjtH8mkL0jM6rjwkOfa6jHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QTwU3nly7PZA2UxNr7P/hZpfLGyuIg1/pxDhIOCSjA4I0lbOcs0ANAxQMO31wB+wHqz4wdeSCVSNV+svvAUi4cXL+4Dh9VBYJlIIO7JRDktlDqPw74ysAYilOI82dNholGnS0t4PfDpnf9wa1UbK3TNmooOpWCKvv7wOvYLBcvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTdJFo6H; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso7100913a91.2
        for <linux-hyperv@vger.kernel.org>; Fri, 31 Jan 2025 18:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376275; x=1738981075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SJJEXGT/CGEg26HmUNCtCBi/lOkkZBhLk4mR9XODbn0=;
        b=TTdJFo6HyULXojAv3H0Yn6VjSgoycBc39w0m4rwblQ1P0OYlAecEzDKp8Qu4VJwfqY
         3PeVvp7Snr0vKO3Zy1BKPUnShOW8GroZ284B0DbnjYCDBeA/GWfIrzbt02HbLK5IjARG
         ofQgfWll6AFlBScGymjB5TKvVgrgOpVYSi6L6pWVlbmNPS0JkhSmTA8AJolYxp/tgUDg
         GSzUJ7YitOEqxAwuSr72r1TrMky1PThqO95dfvPhbV14hcwpUualVKomF9IsY6zv9ezl
         51srobwLT18I6geG2e4VcrDD5Q6/3X58lk3ygUZJ6xHb9uLB1GaH/4yOfGNwk7g66ums
         zIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376275; x=1738981075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJJEXGT/CGEg26HmUNCtCBi/lOkkZBhLk4mR9XODbn0=;
        b=J08J1zfbG+6iiufFKCbFSINPJc6+y30KePE7JUVXeyfl0eXYHNwd18wOWyE6NpgsJQ
         PcCOz3lyOJRLhYbPS0lI4YumT7VsBE/PSG5OkCAqLPrwm8BV9ROffE3wR+47dQhVPSC8
         EtnV9hnBRhCRwufqcX3yduwXpwqe6g8uZulCsW/QVu5WS5OchrbAVkr54ujZFWs6BG9L
         ecbpj+b984cRPkP5UtosBKRtYC6qw1TeKXlcxYTcmWzAKa9hQToHVvPO9X8KB9SaVqE7
         dEBqWt28QV5oE898osD4qqQsm6rgskbpvRObDOU1OLaVu3/mbl5Z+wlOQGTKERF7k7eG
         jN1g==
X-Forwarded-Encrypted: i=1; AJvYcCWZO3yjZAPHvZZQln8goQktPVgTOTlTeHBgRL9apB10rTUpjGhUiKRyPCwNHXImuMc0qaWYVDIP8w4zmwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhz49iAo/3adk4BTXIMiBLRPSMwcsKO1iVTuX7q129dHK80Fq9
	1zu3ALK+87shsnmPyBODWd9Ba2ViBPmQ23l2CJz8UcLu6iUBKbZXBIqnloxgCQLqS3gyw5uf83s
	hjw==
X-Google-Smtp-Source: AGHT+IGR6HwuD9w+8Kze6jNqduo1hcKEvlqzGV2yi3bR0PK9E6ixYJtwZg6BVPpJ2g9E6rQRruKKBVyC7NI=
X-Received: from pjtu8.prod.google.com ([2002:a17:90a:c888:b0:2f7:f660:cfe7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2702:b0:2f4:4003:f3d4
 with SMTP id 98e67ed59e1d1-2f83ac83632mr19746549a91.30.1738376275470; Fri, 31
 Jan 2025 18:17:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:18 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-17-seanjc@google.com>
Subject: [PATCH 16/16] x86/kvmclock: Use TSC for sched_clock if it's constant
 and non-stop
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	jailhouse-dev@googlegroups.com, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Sean Christopherson <seanjc@google.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Prefer the TSC over kvmclock for sched_clock if the TSC is constant,
nonstop, and not marked unstable via command line.  I.e. use the same
criteria as tweaking the clocksource rating so that TSC is preferred over
kvmclock.  Per the below comment from native_sched_clock(), sched_clock
is more tolerant of slop than clocksource; using TSC for clocksource but
not sched_clock makes little to no sense, especially now that KVM CoCo
guests with a trusted TSC use TSC, not kvmclock.

        /*
         * Fall back to jiffies if there's no TSC available:
         * ( But note that we still use it if the TSC is marked
         *   unstable. We do this because unlike Time Of Day,
         *   the scheduler clock tolerates small errors and it's
         *   very important for it to be as fast as the platform
         *   can achieve it. )
         */

The only advantage of using kvmclock is that doing so allows for early
and common detection of PVCLOCK_GUEST_STOPPED, but that code has been
broken for nearly two years with nary a complaint, i.e. it can't be
_that_ valuable.  And as above, certain types of KVM guests are losing
the functionality regardless, i.e. acknowledging PVCLOCK_GUEST_STOPPED
needs to be decoupled from sched_clock() no matter what.

Link: https://lore.kernel.org/all/Z4hDK27OV7wK572A@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 9d05d070fe25..fb8cd8313d18 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -344,23 +344,23 @@ void __init kvmclock_init(void)
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 
 	/*
-	 * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
-	 * with P/T states and does not stop in deep C-states.
-	 *
-	 * Invariant TSC exposed by host means kvmclock is not necessary:
-	 * can use TSC as clocksource.
-	 *
+	 * If the TSC counts at a constant frequency across P/T states, counts
+	 * in deep C-states, and the TSC hasn't been marked unstable, prefer
+	 * the TSC over kvmclock for sched_clock and drop kvmclock's rating so
+	 * that TSC is chosen as the clocksource.  Note, the TSC unstable check
+	 * exists purely to honor the TSC being marked unstable via command
+	 * line, any runtime detection of an unstable will happen after this.
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    !check_tsc_unstable()) {
 		kvm_clock.rating = 299;
 		tsc_properties = TSC_FREQ_KNOWN_AND_RELIABLE;
+	} else {
+		flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
+		kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
 	}
 
-	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
-	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
-
 	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_cpu_khz,
 					  tsc_properties);
 
@@ -369,6 +369,11 @@ void __init kvmclock_init(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
+	/*
+	 * Save/restore "sched" clock state even if kvmclock isn't being used
+	 * for sched_clock, as kvmclock is still used for wallclock and relies
+	 * on these hooks to re-enable kvmclock after suspend+resume.
+	 */
 	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
 	x86_platform.restore_sched_clock_state = kvm_restore_sched_clock_state;
 	kvm_get_preset_lpj();
-- 
2.48.1.362.g079036d154-goog


