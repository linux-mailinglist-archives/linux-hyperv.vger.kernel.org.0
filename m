Return-Path: <linux-hyperv+bounces-4087-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE1A47225
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350A81888697
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A5B1B0411;
	Thu, 27 Feb 2025 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zxx7mXR/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FF18FC67
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622749; cv=none; b=VQGPdeEgCEqQPCt+EYhsEX/rw22AlyisgbosvdWqw5oqRvhy7QLaZiHm0qIFe8BcG6Jv8f+U8QJaNAwumeH+j73Kr9T9PRd4ci8IlLudW71dLDivzjpX1uB7lTbTplfP4wq1zK6/kQLdcm1j0lDU5l1kIaYiLLVdA1tQNsaG7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622749; c=relaxed/simple;
	bh=YIm02xTVNm0eSDO98sEQL1tUrXbpItcdQ7Va1EiMjyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m6wk8ltkxvrK7P6fuFlcsOWoGhgrBbN7Kp5imnct1zIksBaQlMygO/IMcL1FVvgZE3dm6QRFISZTwAs+tv4qjYHVTDdcB8ut/YEfQBn4mtVb51TKaqJEGyVAXQbHrmXfTSbHprL0Xbdh1r3KocLAPlgiJNfxeTymm7Y0xlOFQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zxx7mXR/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe98fad333so1065199a91.2
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622746; x=1741227546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Dwfv1w4tsOCmi3NCgULhIMD4IZcsOFfau2ULDYaMRLg=;
        b=Zxx7mXR/tph5hMWT+eMpiZUfB7LGnjo3vm++s+G/pOqzIlPRSB21YJk9W9ItALFEsc
         LDGTNDirm9YWggc4IQQxPUP/RG8Z17EYC9PV+t2EWJDiHFXh50A0CoWUK3ESCZxHm9kc
         /oQV/J94l19TNCfKU7fpofF0vP2Pj58nrs+8c8tHYJx7y5LQw4jG20WBvQveWqTLrWcv
         nOOmiQt48iS/OG4IrYpYzkOgd8OL2zvZaj1Pq0inJDoH86KwywJZ4UmvkDBphA7QYDpk
         taIKCdFuviMzaNpm9JaXKFYWdr8I/6psRCnzM4jBRT1DropZT+srUYkuL54B81g+vn2t
         a4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622746; x=1741227546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dwfv1w4tsOCmi3NCgULhIMD4IZcsOFfau2ULDYaMRLg=;
        b=EYXpn+o7OKjN34jpTw7Fk3nDqh/4ht6IPb+x+6FRO1jLC1XssiBDCz9Utu1r9kOfMH
         vmI4LMnKttvjL0JHqSMR7InTFD8a7snKdqsVXedfeAyp0guL1AonpbqjMYbYRpnRO+pq
         zMNBY0wgD21UZUjPT6Z6/Ow8+2TH8f1d+s72lhNrThN4a0xZpfigTWGsrmIY0/ssrD4V
         rS8+7oziu1KKBA8ptt0568R8eJBHUd1ByyiTABF5WmcIgnTz8+ncaAj9VS4RyuyAD8MJ
         GkwyfVlEcXZBUo6pFvBRBSNFsvqEpB9WSfasuwb48aY+ChiKnT00IugIqoy/ucLms8JS
         iszQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXd24yEXZeyAsU12DZcdPkFKyfOBXu87xZxU1dS8MHfw/G+SHnjdljiJMXjebXtL/yrHkUtIDhSud/S2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHAcp3QFRakfhplWNPeYqUN2PGVEqoR4HhlBBmiPUExvsSaBt
	TyhmNRCIXnBcP6vL5Mi+aB+aW0SSL19NZ1dxzHyLUTGGz6LHJpQUPo6wrSvI0dWiuNuDFlGAuhZ
	XRA==
X-Google-Smtp-Source: AGHT+IH6wZ/mGewjHTQw2W+siQpDLDG/G2QvagXg40e21ebxNRSjKEBR8DQxe4UjV6eqsE0kkd3QFpygjvI=
X-Received: from pjbsn14.prod.google.com ([2002:a17:90b:2e8e:b0:2fc:15bf:92f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d83:b0:2fc:3264:3666
 with SMTP id 98e67ed59e1d1-2fce7b221c3mr36215820a91.30.1740622746375; Wed, 26
 Feb 2025 18:19:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:18 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-3-seanjc@google.com>
Subject: [PATCH v2 02/38] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
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

Extract the guts of cpu_khz_from_cpuid() to a standalone helper that
doesn't restrict the usage to Intel CPUs.  This will allow sharing the
core logic with kvmclock, as (a) CPUID.0x16 may be enumerated alongside
kvmclock, and (b) KVM generally doesn't restrict CPUID based on vendor.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 37 +++++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index a4d84f721775..c3a14df46327 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -36,6 +36,7 @@ struct cpuid_tsc_info {
 };
 extern int cpuid_get_tsc_info(struct cpuid_tsc_info *info);
 extern int cpuid_get_tsc_freq(struct cpuid_tsc_info *info);
+extern int cpuid_get_cpu_freq(unsigned int *cpu_khz);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 93713eb81f52..bb4619148161 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -688,6 +688,24 @@ int cpuid_get_tsc_freq(struct cpuid_tsc_info *info)
 	return 0;
 }
 
+int cpuid_get_cpu_freq(unsigned int *cpu_khz)
+{
+	unsigned int eax_base_mhz, ebx, ecx, edx;
+
+	*cpu_khz = 0;
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
 /**
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
@@ -723,13 +741,8 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
-		unsigned int eax_base_mhz, ebx, ecx, edx;
-
-		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		info.crystal_khz = eax_base_mhz * 1000 *
-			info.denominator / info.numerator;
-	}
+	if (!info.crystal_khz && !cpuid_get_cpu_freq(&cpu_khz))
+		info.crystal_khz = cpu_khz * info.denominator / info.numerator;
 
 	if (!info.crystal_khz)
 		return 0;
@@ -756,19 +769,15 @@ unsigned long native_calibrate_tsc(void)
 
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
2.48.1.711.g2feabab25a-goog


