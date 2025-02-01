Return-Path: <linux-hyperv+bounces-3820-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F9A246BC
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 03:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C61D168056
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 02:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349911B392E;
	Sat,  1 Feb 2025 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pxQ6kb0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CAE1BBBE5
	for <linux-hyperv@vger.kernel.org>; Sat,  1 Feb 2025 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376272; cv=none; b=EUQkfTmuAFgeqBVYFKBd96uc3WPtULQDhATjbpCj00C5jpwm6oxSY1xJGn17g46Sf/jmFd/4+pT1Vna6AF8wRIL0xj0R9BA+OA+Cb790Pf1Vgo6eE6MMakMAArDGMn4D29Z8sepIJ4QbXTcQmS8RbG2ckIDPwP4vw4nfyZ2GRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376272; c=relaxed/simple;
	bh=azNw66jnMSVEiPAB+2l0m6Z/DQ0p90Ig+X/Tx6OROQQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lz/9lyRSKH7LA6PWDNoLdmf7thyR1Jx+JWz6b5I+aSJPD0B1qHZSmBdsnoT8XGIkNPnGAGDxGACZSlXJ6nHjptcHjlztoTkmEWC+cNfkDSgBm17mCW7cZ6MoKuDCGNLg9e3v6I0t7IedFRPT2E516e3x0qeEdsHg9uoOUVH74jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pxQ6kb0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so4894867a91.1
        for <linux-hyperv@vger.kernel.org>; Fri, 31 Jan 2025 18:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376270; x=1738981070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZKnHj9nGtIPNyoOdVCsq53ZVe6onbdoIhwKKzEiQlk=;
        b=0pxQ6kb0eBNyesUtr0hnPt4rA1lRx/bFzkRAAlmSZUgmotcW5wDSMPEDk9OI1DyEu1
         KMzsVbatfHzwpsVT4/Ru+q4viu8nVOfwzl+4AwDHSkkfmIshJpeVJ5DWQsSbniIODazk
         rmtaXGa3b9ak3K74udhMCZpBVCC/AUqQBfwcVGEh0jGia41pmuaWX66YFgt6r0grxZZN
         sI/5HC8QBABRHNUryNiff7Cf5V9xraNL0fqzBpzHjHs/mI6bp2SOkHFcQvXIUomQInMz
         KdL2kpBSU/xC0TZkGRydfZtVUafLBS79cKg+4Vo0p55BDXqSYDzC66FBOZDMIm8MALBX
         OOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376270; x=1738981070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZKnHj9nGtIPNyoOdVCsq53ZVe6onbdoIhwKKzEiQlk=;
        b=wqbN65/eynxRl2otKnqosF5AjggPvXh7Dwhxc50C2dzaMizRaO8tlDNvR0Yt0tfZrj
         693SUy7U/4ioQZxUtfbfoMZtZC0fB0Zf94Lki5ab0WypcrUsDCKHgVY3QjLw/6w00/wd
         AZsnx/YK+yxUoz9GZqZFXjM/aZLXPSn+IrKg9TqJYZMNudAMWQcCsGAYzZV1fmDsMplc
         V78pHfnZ+D8jUZ6mmnGlTdmTAUrUIiFo4LBvQnPPx/IK+k6eiR87QAFEV3qq0IfMCmZo
         0VUTfreEz8g9Er4hb1leRAqSskwgCMLmBjZLvTCve+lcqLBZqZv8xjyRQScJT+hUhZ/q
         ykFw==
X-Forwarded-Encrypted: i=1; AJvYcCXx+pgVi+TXDRCLV/GhjpT0Ss7qAufTT3PMszbTH/mKZfv+nVNZUnia8RVvb9cynISJBhU9SL6miHJTqWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Ov0TRjEONLkcXEpiNu7rgQXIqbYbKmzVi98fgiCLNdLJVs9u
	frLj3j8BLlcI4TZdGuYpjQzCA7ddPiQpGGpi0bUNIYZPwvEIivjXpFSqCUci6goyJUBHyNv95TO
	Rjg==
X-Google-Smtp-Source: AGHT+IFgXEe7/w9yeWgyg6qQLihx/5RXWr7kMK6/niF7ETqn4L9GsYCh+B6w5nh2NPJ849LxusX87Gxqnac=
X-Received: from pfiy14.prod.google.com ([2002:a05:6a00:190e:b0:724:eefc:69ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9a6:b0:725:e1de:c0bf
 with SMTP id d2e1a72fcca58-72fd0bf47cdmr18371303b3a.9.1738376270050; Fri, 31
 Jan 2025 18:17:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:15 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-14-seanjc@google.com>
Subject: [PATCH 13/16] x86/kvmclock: Get CPU base frequency from CPUID when
 it's available
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

If CPUID.0x16 is present and valid, use the CPU frequency provided by
CPUID instead of assuming that the virtual CPU runs at the same
frequency as TSC and/or kvmclock.  Back before constant TSCs were a
thing, treating the TSC and CPU frequencies as one and the same was
somewhat reasonable, but now it's nonsensical, especially if the
hypervisor explicitly enumerates the CPU frequency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index a7c4ae7f92e2..66e53b15dd1d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -102,6 +102,20 @@ static inline void kvm_sched_clock_init(bool stable)
 		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
 }
 
+static unsigned long kvm_get_cpu_khz(void)
+{
+	unsigned int cpu_khz;
+
+	/*
+	 * Prefer CPUID over kvmclock when possible, as the base CPU frequency
+	 * isn't necessary the same as the kvmlock "TSC" frequency.
+	 */
+	if (!cpuid_get_cpu_freq(&cpu_khz))
+		return cpu_khz;
+
+	return pvclock_tsc_khz(this_cpu_pvti());
+}
+
 /*
  * If we don't do that, there is the possibility that the guest
  * will calibrate under heavy load - thus, getting a lower lpj -
@@ -332,7 +346,7 @@ void __init kvmclock_init(void)
 	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
 
-	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
+	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_cpu_khz,
 					  tsc_properties);
 
 	x86_platform.get_wallclock = kvm_get_wallclock;
-- 
2.48.1.362.g079036d154-goog


