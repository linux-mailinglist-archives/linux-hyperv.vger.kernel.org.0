Return-Path: <linux-hyperv+bounces-3809-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 233A8A2467F
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 03:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920DC1888FFB
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 02:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5952012C7FD;
	Sat,  1 Feb 2025 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8gbP36v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0AE45C14
	for <linux-hyperv@vger.kernel.org>; Sat,  1 Feb 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376253; cv=none; b=q9e29ftvly1mCRwuzlj7pXU+C+maLbdHb/se8CPfmtxANSxIw0rTdKcyWFHzxoB2/98PB8hPWVGWaZnbnt98w7z7okPrItT0qXNnomSn6n7xBdTq9Z3fBM+jlLPN2sz4/pC1IAU2kL44W34ny9MS1T0qOvxX3EpnocIRhar/CtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376253; c=relaxed/simple;
	bh=TyPGGnI+qvESlCqTdnx/2r6KTTCSxp5Z/qlgDjzTlP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BmXHfnq3kgD5rLhypVYN1Q9J8vxDeQ+OB0APyP34zicFhBqZo3P4jzM+Pp0fVYt7+DpN5L+s8F7/pqbdYBhQx3NVsxvlcTcRKf/vBafecce7zWWQdOpDiUh3awA8/UQnwuNEqFnP8tjI+motNHBipjiag7yyhsL+NZ0aers7ddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8gbP36v; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216728b170cso54748045ad.2
        for <linux-hyperv@vger.kernel.org>; Fri, 31 Jan 2025 18:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376251; x=1738981051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=E0C6rmJeK4TduAmeKIdyYwLof9bH1hCIL8jVX3VQ6HM=;
        b=k8gbP36vFJT0lD4k/FBbCT4q4E2h6FpPE418yfW/LP7RkR/W18L6zr+JEDqAryPMit
         xkpWbUrL+xIe5w11xBdlicJ6OOW1TKZYi+baWGQGGdGZ49y52KFXLA/4rGzn48CjdU9B
         3O5JHOq2+ixlSUeKvauPJ423LNWcksqaAUf4vz0pglxtkbvZIZDADZrPRYlMVgxQIqLE
         xYTUz7856a0NSIFYRBiTF0XRrpT8VXr28iRMREqmYzW6OqElo9bL5N0Ez3wHqqwtrnkE
         23QOTt4jRs95o3YoixUG6NXmMMHHlyi0YU1+htD9GlIoBFkxQDdSuJ+4CNG71hxm6+ti
         kAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376251; x=1738981051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0C6rmJeK4TduAmeKIdyYwLof9bH1hCIL8jVX3VQ6HM=;
        b=u7H9N9vtK40F92tvUs0XAYb4jIigGsAS8Wuf75MvHgdPbubh5SqZRskevRbzHYBqRn
         0RTCJZTAVUy4XYDayKDvuz8szzHikqrNXMhSS5UZHnHlFe8NwMMee1j4liKrtm9a6fVl
         HpgLycMRIuE62qwQmo1v8Qdo9jNr1c2SgXgDOLlnacLmliLBGw3h1Kx9R8m37Cr/zNd1
         jKYbUYeb3uS3cGbhXk/Aoah7c8MoDIz257bYm3l6t4XK2YaQJ3RfOeMDzvonbHW+kXId
         CX2XYzcHgIaEgblXknQHKPyqYEXYpoSPDMLo9fV3XxoC6NKWcWa//tJ15iZVLMhJtOZ3
         IjYA==
X-Forwarded-Encrypted: i=1; AJvYcCU/dogwVls9EX4yMlrOsViv5Wj6bCeUjNp/CG+fQFlxH9fQ844DXyDIs4anWLZBtZq5P5VsHBwq0yQXuZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tu4YsvyfY4dnd/Kfsvhdzur/s86JaQ5VbRU/8wLgH5FLiZsR
	p2TGt87Nz8ossU1jH1OtUMLICEpJMzaOUm9E0bSRclbc/BSvLiDK6huUaD9t5DzyhpJ1UhNoFQX
	DPw==
X-Google-Smtp-Source: AGHT+IFlvWiOED1ZYXsClK6j8veie9a9mJfZCZQPkiq0i15PJ6F5P2kJWMXEZplyquyEAP3l8GbEgk3YB0s=
X-Received: from pghg16.prod.google.com ([2002:a63:e610:0:b0:ad0:f8ff:b90d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6713:b0:1e0:d766:8da1
 with SMTP id adf61e73a8af0-1ed7a6e12f1mr21226332637.39.1738376250763; Fri, 31
 Jan 2025 18:17:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:04 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-3-seanjc@google.com>
Subject: [PATCH 02/16] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
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

Extract the guts of cpu_khz_from_cpuid() to a standalone helper that
doesn't restrict the usage to Intel CPUs.  This will allow sharing the
core logic with kvmclock, as (a) CPUID.0x16 may be enumerated alongside
kvmclock, and (b) KVM generally doesn't restrict CPUID based on vendor.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h | 16 ++++++++++++++++
 arch/x86/kernel/tsc.c      | 21 ++++++---------------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 14a81a66b37c..540e2a31c87d 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -69,6 +69,22 @@ static inline int cpuid_get_tsc_freq(unsigned int *tsc_khz,
 	return 0;
 }
 
+static inline int cpuid_get_cpu_freq(unsigned int *cpu_khz)
+{
+	unsigned int eax_base_mhz, ebx, ecx, edx;
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+		return -ENOENT;
+
+	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
+
+	if (!eax_base_mhz)
+		return -ENOENT;
+
+	*cpu_khz = eax_base_mhz * 1000;
+	return 0;
+}
+
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index e3faa2b36910..4fc633ac5873 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -662,7 +662,7 @@ static unsigned long quick_pit_calibrate(void)
 unsigned long native_calibrate_tsc(void)
 {
 	unsigned int eax_denominator, ebx_numerator;
-	unsigned int crystal_khz;
+	unsigned int crystal_khz, cpu_khz;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
@@ -692,13 +692,8 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
-		unsigned int eax_base_mhz, ebx, ecx, edx;
-
-		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		crystal_khz = eax_base_mhz * 1000 *
-			eax_denominator / ebx_numerator;
-	}
+	if (crystal_khz == 0 && !cpuid_get_cpu_freq(&cpu_khz))
+		crystal_khz = cpu_khz * eax_denominator / ebx_numerator;
 
 	if (crystal_khz == 0)
 		return 0;
@@ -725,19 +720,15 @@ unsigned long native_calibrate_tsc(void)
 
 static unsigned long cpu_khz_from_cpuid(void)
 {
-	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;
+	unsigned int cpu_khz;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+	if (cpuid_get_cpu_freq(&cpu_khz))
 		return 0;
 
-	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
-
-	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
-
-	return eax_base_mhz * 1000;
+	return cpu_khz;
 }
 
 /*
-- 
2.48.1.362.g079036d154-goog


