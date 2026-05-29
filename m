Return-Path: <linux-hyperv+bounces-11333-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENDJAAyvGWpyyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11333-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:21:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D1C604904
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6F57344899F
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDED344D9D;
	Fri, 29 May 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkV1NK4s"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1123F1AB2
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065907; cv=none; b=iRqscwZq8HJfQCLSjYimAqBRaCYbKSkrbPvIvtQYtAeAXouZzvHiL/47PnG7hLATVCZ+WC4s9YpDyOFtFWX6GjOhkHKfmxGSgpvL2ihxrVKR1BdxssgwiYrYygRuTmDloL8uhhiujC9IqpQDnJEZ06XEcLmboQa28YmNuvyQOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065907; c=relaxed/simple;
	bh=RKwWhqVrOQPM1dUBpPmXNW9Ctazo079sf1ULKHAbSWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gtx/UlfWPj671TL6AaISIVanzOLzRJs+rOY2jOaBpUkQCFsPyWIjkIv8JbkSWxmg/tfuPSiAS7nnX+BE0uD4HsJ1W9R7TN7sJy3NV22PXuh4lkPqZRD8ryXtGyR5dTyzi6IYLHEoYtM0PM1pkIsRpS5evkM3O50STFa7gX6h51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YkV1NK4s; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-369166fe5e3so12702586a91.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065905; x=1780670705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nNJLu7do7nPWUZaqv5wFSjm3is+mcIorKyFYEzca5zQ=;
        b=YkV1NK4swRSLQaJ1MnLwQmoRldU7WJ/scHBGJ+ulCyUtszFUUNrNxjUMhmFMr46NBb
         yewkwmQaBjQwRPvHDQn4rjNIV377UQpEDaG5xaLPasidXNbBWkPdtMOXBiE7Gros24zW
         6M5uPAJfoxWcam8/A1j5OqH75HcoeugjY4Sh4cP8ZHwf9Yj52E5PoozusB73H3otFQqo
         3XUfc/2eZ+DAq42a2tEZIxNkY1vJWxeJ1hnd9Rcq4bOATYdJvchU1BpN00R/QGE6XSmx
         Nc7bLYp2VZ4IaGCu6XDvuTUTOWlcx9pxsE5pWt7VoVo99HUqOmPxhwwvEw+mrhzKhInZ
         1TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065905; x=1780670705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNJLu7do7nPWUZaqv5wFSjm3is+mcIorKyFYEzca5zQ=;
        b=AY/XukiB+oWvQiVUQRqppAJ3a5ZuUUtG6CGHkUvjJoeb26li/02RGDRqDHpuj0+wzs
         4pdXEa0NhCC+6LD2WWO2bEpDWrFdRBM+Y6u/VjF/evBW+vrDvgoSbLJOUqAfS0gUOcWp
         UV3f/zEqBr/XA0bJQETIm1sNw5W2ArNdtO+nOxogzTUqgeB5DN4yt434UxzopG3Qvarv
         wPjLV/poWqDmR71FqshYktZeX0K8is8aQS9Aagj3GWKKC8X0tCD3GG5RP4iwVzJMrGp1
         D9SbPTiFdXtPFr53U4iTW8uPFewT2BYIXiWNJ0jCnLQcF7GyeGYnCGUBUS7z2Tq8tP8u
         pscA==
X-Forwarded-Encrypted: i=1; AFNElJ+HQoB5YUvY7frWxCUCu8EbDe6uxLiO8C0Nzn4SK1QOJi7yRcPuZcf2OYNs5Vzdae+3P2xHt6C0UyM9KuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxlRaSciR1jJRfVHn8DWAIdsXxU0GIMyqZcm/U9obaEM1RYzn2
	PLbrMrZb1b0/vp1I2LWBvZKHKmNHpoXj27yhtZaZRhh0CxJvaKadP65apPsAjxjQ0NBPVFM9m3V
	lJATPtA==
X-Received: from pjqx13.prod.google.com ([2002:a17:90a:b00d:b0:36b:a7c4:95be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2681:b0:368:6998:b4a9
 with SMTP id 98e67ed59e1d1-36bbcc14546mr3878407a91.11.1780065904236; Fri, 29
 May 2026 07:45:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:58 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-12-seanjc@google.com>
Subject: [PATCH v4 11/47] x86/tsc: Kill off x86_platform_ops.calibrate_{cpu,tsc}()
 hooks
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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
	TAGGED_FROM(0.00)[bounces-11333-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 80D1C604904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that getting the CPU and/or TSC frequencies from the hypervisor uses
dedicated hooks, drop x86_platform_ops.calibrate_{cpu,tsc}() and instead
directly invoke the correct helper at each phase of (re)calibration.  In
addition to eliminating unnecessary code, this makes it a bit more obvious
when the "late" path invokes pit_hpet_ptimer_calibrate_cpu() instead of
x86_platform_ops.calibrate_cpu().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h      |  2 --
 arch/x86/include/asm/x86_init.h |  4 ----
 arch/x86/kernel/tsc.c           | 28 ++++++++++++----------------
 arch/x86/kernel/x86_init.c      |  2 --
 4 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 6cf26e62e9a6..4a224f99c3b9 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -97,8 +97,6 @@ extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
 extern void mark_tsc_async_resets(char *reason);
-extern unsigned long native_calibrate_cpu_early(void);
-extern unsigned long native_calibrate_tsc(void);
 extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
 
 extern int tsc_clocksource_reliable;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index a4f8a4aa601d..ada17827ea51 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -292,8 +292,6 @@ struct x86_hyper_runtime {
 
 /**
  * struct x86_platform_ops - platform specific runtime functions
- * @calibrate_cpu:		calibrate CPU
- * @calibrate_tsc:		calibrate TSC, if different from CPU
  * @get_wallclock:		get time from HW clock like RTC etc.
  * @set_wallclock:		set time back to HW clock
  * @iommu_shutdown:		set by an IOMMU driver for shutdown if necessary
@@ -317,8 +315,6 @@ struct x86_hyper_runtime {
  * @guest:			guest incarnations callbacks
  */
 struct x86_platform_ops {
-	unsigned long (*calibrate_cpu)(void);
-	unsigned long (*calibrate_tsc)(void);
 	void (*get_wallclock)(struct timespec64 *ts);
 	int (*set_wallclock)(const struct timespec64 *ts);
 	void (*iommu_shutdown)(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 8cef918486db..5b4b6e43c94c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -696,7 +696,7 @@ int __init cpuid_get_tsc_freq(struct cpuid_tsc_info *info)
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
  */
-unsigned long native_calibrate_tsc(void)
+static unsigned long native_calibrate_tsc(void)
 {
 	struct cpuid_tsc_info info;
 
@@ -931,7 +931,7 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 /**
  * native_calibrate_cpu_early - can calibrate the cpu early in boot
  */
-unsigned long native_calibrate_cpu_early(void)
+static unsigned long native_calibrate_cpu_early(void)
 {
 	unsigned long flags, fast_calibrate = cpu_khz_from_cpuid();
 
@@ -945,7 +945,7 @@ unsigned long native_calibrate_cpu_early(void)
 	return fast_calibrate;
 }
 
-
+#ifndef CONFIG_SMP
 /**
  * native_calibrate_cpu - calibrate the cpu
  */
@@ -958,6 +958,7 @@ static unsigned long native_calibrate_cpu(void)
 
 	return tsc_freq;
 }
+#endif
 
 void recalibrate_cpu_khz(void)
 {
@@ -967,9 +968,9 @@ void recalibrate_cpu_khz(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
 
-	cpu_khz = x86_platform.calibrate_cpu();
+	cpu_khz = native_calibrate_cpu();
 	if (!boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
-		tsc_khz = x86_platform.calibrate_tsc();
+		tsc_khz = native_calibrate_tsc();
 	if (tsc_khz == 0)
 		tsc_khz = cpu_khz;
 	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
@@ -1483,17 +1484,19 @@ static bool __init determine_cpu_tsc_frequencies(bool early,
 	WARN_ON(cpu_khz || tsc_khz);
 
 	if (early) {
+		/*
+		 * Early CPU calibration can only use methods that are available
+		 * early in boot (obviously).
+		 */
 		if (known_cpu_khz)
 			cpu_khz = known_cpu_khz;
 		else
-			cpu_khz = x86_platform.calibrate_cpu();
+			cpu_khz = native_calibrate_cpu_early();
 		if (known_tsc_khz)
 			tsc_khz = known_tsc_khz;
 		else
-			tsc_khz = x86_platform.calibrate_tsc();
+			tsc_khz = native_calibrate_tsc();
 	} else {
-		/* We should not be here with non-native cpu calibration */
-		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
 		cpu_khz = pit_hpet_ptimer_calibrate_cpu();
 	}
 
@@ -1590,13 +1593,6 @@ void __init tsc_init(void)
 		return;
 	}
 
-	/*
-	 * native_calibrate_cpu_early can only calibrate using methods that are
-	 * available early in boot.
-	 */
-	if (x86_platform.calibrate_cpu == native_calibrate_cpu_early)
-		x86_platform.calibrate_cpu = native_calibrate_cpu;
-
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
 		if (!determine_cpu_tsc_frequencies(false, 0, 0)) {
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ebefb77c37bb..c674cbbd466d 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -144,8 +144,6 @@ static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
-	.calibrate_cpu			= native_calibrate_cpu_early,
-	.calibrate_tsc			= native_calibrate_tsc,
 	.get_wallclock			= mach_get_cmos_time,
 	.set_wallclock			= mach_set_cmos_time,
 	.iommu_shutdown			= iommu_shutdown_noop,
-- 
2.54.0.823.g6e5bcc1fc9-goog


