Return-Path: <linux-hyperv+bounces-4118-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA27A472D2
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59B81640E4
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D411B23C375;
	Thu, 27 Feb 2025 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/38eAlX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1023A566
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622802; cv=none; b=Y1odijwZjkGXP7HvFlDpTnm3NEfD53MaDgi//iQt9gj2BnX2gafqRh8C0pLqzk0F+Zg7mYt8P+K1O33NRsvyOFMD3jtNixjE7k6lOicSLKU3fn848mkWqhYia7o7x25sYk1HNmqBg71mkYW1t++7jefU4VW67AWGk+Adkbb4kfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622802; c=relaxed/simple;
	bh=QPB0hO3DgGDIpWXharYozGSl0kpmrn7uptJliWGGUbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q7DP+n07CvEC2Zwn3U/SSy9lTBUMkYn7L4Y8aFZCx2F/ezPo2z1zEOSy4Wn42IQ13Tof9E0EELjFphT51/IH6/xH4vR8LuHndKdcbwGvMPGrbNEq+z65fpUTttCC8qLAwyQx8Zla7Mwlvtrf7jZgLdLFtRsMu4Hsf/+K4zDN6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/38eAlX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe98fad333so1066304a91.2
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622800; x=1741227600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SUWURP6DS00BmWQuQkka/ewYMygd0uN/XlEQWE3xarE=;
        b=p/38eAlXVBlnzxMy4cgsnY0hH2hHTEIwimsxxtF21T0WkCtdNUw3WUnpEiNfrZFn9Z
         wFtDE33Y8Q6RhXb+kvOuUE80VfYmhRdlnLd49oet2ZCZyx55S9HQ+lsJiB6EGohCoCXs
         yLL8vgRDcZ6wUk8rxJ88gzM/Qb2l6l0lMsYQcfZKT5gQp9sEyP4GkQva5+PNY50SUmip
         XmHnWKq3pm6Btq73RCSWaagC3bIfp68w0vXxHzgNxh7z5yAuk4tVWLZCO1DIjZ2rfERI
         hq35r+/20Ic+WIA1yx9X+UhO8hvPB/Z6w5BYag0kiSpcpCLLBJ7aVZGWxDl1q8NxjtSx
         6SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622800; x=1741227600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUWURP6DS00BmWQuQkka/ewYMygd0uN/XlEQWE3xarE=;
        b=Z3hHvUeBFbWVylXWCSQHdaF1NO6wOcAU1sDTaCebydX5s3LTdNSPYhyyAVM/Y4J+ta
         GSfpSes3XnMxGoShukKVrIDUk9xch1O/Cf8tU0EAP8Mt4I5eQUY36gtSaafGAQ2oEKEL
         7eJlkx4LqLyQM565Qv+I7vau7PnOnwOCuphEphgZJr0G0431VDlx6WQu4Qm9EjB6Bk+g
         didQskTRpfkmboILUhzVpuCbZIxYM1zp7e4g0ae0hSJg5HWiqbEQcpB/iXTto26pvX6Z
         icJS8jfXcQVbmdlAXGJwzKQ5dKsKihGxO2QFONHE1MNAYmfMgbHVFeFg4UGYWWMJiEL7
         8x7w==
X-Forwarded-Encrypted: i=1; AJvYcCWLlu2c4yAXpVAnc5TxkEh7sL2VUYosHt/sbRYnvd1uysUhh8ypFMufyo+KNoeZcTmNsOeJxzMRUohwTgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQrDzxabeZzQqhJxb+yftEvR/MQhwKTF+bysX/dQ01YMT6sa/
	v4o4pDxVcBpGPk0/HhXlkyW1sm7Gg8ukklifzj9yzziGJLInX7MrNeJap7N/7n3PFSXtG8vQqhs
	Dlg==
X-Google-Smtp-Source: AGHT+IEaJegSwuz7gp17gUBIq0YV/a5p90hmpWu2RxMMtE/LMlRmTHKg61dycPOdBb/l8JsfSEdKtOPrkAY=
X-Received: from pjboh8.prod.google.com ([2002:a17:90b:3a48:b0:2fc:2b96:2d4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcf:b0:2f8:34df:5652
 with SMTP id 98e67ed59e1d1-2fce78beb41mr33366155a91.21.1740622800327; Wed, 26
 Feb 2025 18:20:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:49 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-34-seanjc@google.com>
Subject: [PATCH v2 33/38] x86/kvmclock: Mark TSC as reliable when it's
 constant and nonstop
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

Mark the TSC as reliable if the hypervisor (KVM) has enumerated the TSC
as constant and nonstop, and the admin hasn't explicitly marked the TSC
as unstable.  Like most (all?) virtualization setups, any secondary
clocksource that's used as a watchdog is guaranteed to be less reliable
than a constant, nonstop TSC, as all clocksources the kernel uses as a
watchdog are all but guaranteed to be emulated when running as a KVM
guest.  I.e. any observed discrepancies between the TSC and watchdog will
be due to jitter in the watchdog.

This is especially true for KVM, as the watchdog clocksource is usually
emulated in host userspace, i.e. reading the clock incurs a roundtrip
cost of thousands of cycles.

Marking the TSC reliable addresses a flaw where the TSC will occasionally
be marked unstable if the host is under moderate/heavy load.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ce676e735ced..b924b19e8f0f 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -362,6 +362,7 @@ static void __init kvm_sched_clock_init(bool stable)
 
 void __init kvmclock_init(void)
 {
+	enum tsc_properties tsc_properties = TSC_FREQUENCY_KNOWN;
 	bool stable = false;
 
 	if (!kvm_para_available() || !kvmclock)
@@ -400,18 +401,6 @@ void __init kvmclock_init(void)
 			 PVCLOCK_TSC_STABLE_BIT;
 	}
 
-	kvm_sched_clock_init(stable);
-
-	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
-					  TSC_FREQUENCY_KNOWN);
-
-	x86_platform.get_wallclock = kvm_get_wallclock;
-	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_SMP
-	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
-#endif
-	kvm_get_preset_lpj();
-
 	/*
 	 * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
 	 * with P/T states and does not stop in deep C-states.
@@ -422,8 +411,22 @@ void __init kvmclock_init(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-	    !check_tsc_unstable())
+	    !check_tsc_unstable()) {
 		kvm_clock.rating = 299;
+		tsc_properties = TSC_FREQ_KNOWN_AND_RELIABLE;
+	}
+
+	kvm_sched_clock_init(stable);
+
+	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
+					  tsc_properties);
+
+	x86_platform.get_wallclock = kvm_get_wallclock;
+	x86_platform.set_wallclock = kvm_set_wallclock;
+#ifdef CONFIG_SMP
+	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
+#endif
+	kvm_get_preset_lpj();
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
 	pv_info.name = "KVM";
-- 
2.48.1.711.g2feabab25a-goog


