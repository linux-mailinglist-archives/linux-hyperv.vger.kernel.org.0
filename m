Return-Path: <linux-hyperv+bounces-3808-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDCAA2467C
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 03:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7797A3251
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 02:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514E50276;
	Sat,  1 Feb 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYT3jl7Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7026296
	for <linux-hyperv@vger.kernel.org>; Sat,  1 Feb 2025 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376251; cv=none; b=C6ODK6ryV10g3TvlboPrxzgZBRakGr1xMuMnjltYOPiJwswTbqJ6gBmq6xQ5qDg5j8Uq9LSDKdOgwgI9FWyLnreeboUVlTKtyjyXoriMlId1f8CpxIVFJAaTnDmD+mBPVX0Ln+7vbQF5XS5oWKgkuonovspoHIUeFnyF5Wo6foA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376251; c=relaxed/simple;
	bh=bqOChW42KkISzQ0ttdKpX0A7QPv+hN2zNVexU8vjJYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZgPD+S+IZXcCqbrq0+n9mw4A9CaeRKIfYFdP4R/DebFqHNFeh2royyxqKRleqw7g48EFzalcIox3NkzaB4iZrdr3MLg4u9hJC6y499f/7DeZTjaJIYaz44HcJYVlHvz273T7aKD1c5HvDHDlyWuKj6MlKzRSlBgNCkteUV0TbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYT3jl7Q; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f5538a2356so4881281a91.2
        for <linux-hyperv@vger.kernel.org>; Fri, 31 Jan 2025 18:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376249; x=1738981049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3q3VtWChJd6qluhOhoVrZUOxKE25zEDROrS3h+FyOz0=;
        b=YYT3jl7Qcm+YyvBH+OyECD5VrHlZTrVZJ3yzrUR8eD648UtiQlm1h/e4Pq3C8HyTow
         E6oNZXNX/OyHE/o0B6g5ak+AFK2677jIiTSmrnmBgw3SlwG998OvMbCa3gM8XZkoonVq
         XN5BtzQeiTHcmAew148U2Y+znB6qvjCYYkc1cZZF6y8Ar3PEzv0uJJBp1JG2XV74xi7t
         9YInCNfIQ4txnuSd/KrBa0C5gphOoic0u0UnUJHAyN74Rforg+qCsrQW5uA2QgWQCh8T
         /zi8xXWadKjHSbFvdY3hxlbvbs2KKWIW43IVidIHmLlIFrUlBJI1Vr8eij+dxqyiwWoR
         haAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376249; x=1738981049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q3VtWChJd6qluhOhoVrZUOxKE25zEDROrS3h+FyOz0=;
        b=WlPlhHsylAMuj8cQ09LCwtjv7Ao9X0moMFjJHgfBx7WNZnBhOT0RsIax9fEKPJEptz
         7M977FptBLrSFhqBhkWxTVcAZ1Kf7inDUC8eZE8Myr4qcwy7D2IDtFmVfdmSPOoVbBwz
         obSxE+CMjpfnbWaMoeyTdI3OFKMASs9J593miwVsVTbljOESE52teJI2ks5CG8Jt2Vgy
         ho252p/Gb+u/YMxf7dFAF6Rdqsz8d6cKxYjezauhl9fuemEC4hcc8WXlJvyafU64KpJD
         QKw5PBzy3xHW7DmbKaSAshsuUQSn9PKhoS8kvhLiMfaB5co5KLvW5FRwrUvBDHWaLPY0
         edmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLY/XjCtqBnGZASlhBoJEH6HYPuQDyMll9je0mVULOC2qxNG3ZyShxwUXTHLk1I36w7JuLrVWiqFmoj8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzugF3Bbh7VHoR7PBL1Y4zYyaQMIKreRtuRz9fl6B4z+jtrqmF6
	CXf0qGJP9lsh5VoeW2XeDyITIbUiU8zM+rIPh8Fwg90vJTKl8kKSpItLWX/ezSa60q9FlJCW68O
	P/Q==
X-Google-Smtp-Source: AGHT+IGlJL+gh3dhTIPqGXIyfYqBO171NEVUqAKwIwg+mryw0iUEaDc1VWsrQ1YFiTTJEYVX1rRFTepD4XE=
X-Received: from pjbpx11.prod.google.com ([2002:a17:90b:270b:b0:2e9:5043:f55b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc46:b0:2ee:af31:a7b3
 with SMTP id 98e67ed59e1d1-2f83ab8c3edmr21370350a91.7.1738376249247; Fri, 31
 Jan 2025 18:17:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:03 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-2-seanjc@google.com>
Subject: [PATCH 01/16] x86/tsc: Add a standalone helpers for getting TSC info
 from CPUID.0x15
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

Extract retrieval of TSC frequency information from CPUID into standalone
helpers so that TDX guest support and kvmlock can reuse the logic.  Provide
a version that includes the multiplier math as TDX in particular does NOT
want to use native_calibrate_tsc()'s fallback logic that derives the TSC
frequency based on CPUID.0x16 when the core crystal frequency isn't known.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h | 41 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/tsc.c      | 14 ++-----------
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 94408a784c8e..14a81a66b37c 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -28,6 +28,47 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
+static inline int cpuid_get_tsc_info(unsigned int *crystal_khz,
+				     unsigned int *denominator,
+				     unsigned int *numerator)
+{
+	unsigned int ecx_hz, edx;
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
+		return -ENOENT;
+
+	*crystal_khz = *denominator = *numerator = ecx_hz = edx = 0;
+
+	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
+	cpuid(CPUID_LEAF_TSC, denominator, numerator, &ecx_hz, &edx);
+
+	if (!*denominator || !*numerator)
+		return -ENOENT;
+
+	/*
+	 * Note, some CPUs provide the multiplier information, but not the core
+	 * crystal frequency.  The multiplier information is still useful for
+	 * such CPUs, as the crystal frequency can be gleaned from CPUID.0x16.
+	 */
+	*crystal_khz = ecx_hz / 1000;
+	return 0;
+}
+
+static inline int cpuid_get_tsc_freq(unsigned int *tsc_khz,
+				     unsigned int *crystal_khz)
+{
+	unsigned int denominator, numerator;
+
+	if (cpuid_get_tsc_info(tsc_khz, &denominator, &numerator))
+		return -ENOENT;
+
+	if (!*crystal_khz)
+		return -ENOENT;
+
+	*tsc_khz = *crystal_khz * numerator / denominator;
+	return 0;
+}
+
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 34dec0b72ea8..e3faa2b36910 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -661,25 +661,15 @@ static unsigned long quick_pit_calibrate(void)
  */
 unsigned long native_calibrate_tsc(void)
 {
-	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
+	unsigned int eax_denominator, ebx_numerator;
 	unsigned int crystal_khz;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
+	if (cpuid_get_tsc_info(&crystal_khz, &eax_denominator, &ebx_numerator))
 		return 0;
 
-	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
-
-	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(CPUID_LEAF_TSC, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
-
-	if (ebx_numerator == 0 || eax_denominator == 0)
-		return 0;
-
-	crystal_khz = ecx_hz / 1000;
-
 	/*
 	 * Denverton SoCs don't report crystal clock, and also don't support
 	 * CPUID_LEAF_FREQ for the calculation below, so hardcode the 25MHz
-- 
2.48.1.362.g079036d154-goog


