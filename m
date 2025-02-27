Return-Path: <linux-hyperv+bounces-4111-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222A9A472AB
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916A93A274E
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505F6230270;
	Thu, 27 Feb 2025 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zuWy5JVs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD0922F15B
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622790; cv=none; b=soCGWU/wkXS/BDpn8lIUr0WeyYyQiE8XQ/1uKDZACAyrS/ZAkv5DDrDJjxXYP/KoR0pLQLJVjMTwwLn6G0nEba5o6OgvlbskGCVnFVzJETchPhZIfuR/J81Yu5NSEjSC85ySQpkqEXrNII3Xe1lIU70zomdlnjjkMCC3PbWHlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622790; c=relaxed/simple;
	bh=R5OwNlXhbkGyFpfs6H/9FfbWD/QK2xYWDQUAUET1omM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qxXbA1E2sVz/0ht9C0CU2QK7bYjjaecC6jYBz16ijN+IWLH+Ja3atIqNuG/IKxYnINsrZTuPrw8VHemX2uaCCkUEoxE2LNPkyOtQbFPRuWjejxE/v2trSLxp3uJPynx0lGDIfeTfd7AasSYTj54I4AW0D9fZx6ScUKYiddUkJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zuWy5JVs; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe870bc003so993399a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622788; x=1741227588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8l5U+hO6xQEeVCf+kI9O/UrrnIVeF1W04fkwqmR0RAk=;
        b=zuWy5JVsiYI1ZfzrJuCUUiLvMOgDT8++J5uxoTwFEt3DrW7QBR6I5wtKR4Wpn5IyhV
         v6U0951GdBh626qmBE1x4/B882Ni0Nke9dmrBN3Gwv2bLR3C7V5DRm/dT1R9SIb0ynaC
         IAAWN8DMFEYbfLZWOOZie/g9pC9T4C5IE7CSR/zTE2ycLlHcHedGGlRkeADw/a/UOGDx
         xRmEnOwzkthLbknuF/2X376Qw5fnPXBWviZTZ6e665FrWPHBJm6q3h4KE9yeqCZNJcht
         7tlu2/+002Yf6s0tFnBtuHbUJ1zqGiWuANRsnq0UdceT1gZBO4E/cq0Z+G+2yi4hpvhZ
         VJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622788; x=1741227588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8l5U+hO6xQEeVCf+kI9O/UrrnIVeF1W04fkwqmR0RAk=;
        b=XBRjZXK+JOLewKZJ85VmI6t1WE81BgI46rtoh2AYAqf1FTctanX8upiEnY+K5CAELQ
         QqCqTYlkYzSVtqyQEQT/pafic2B7KzoojrAQ5Fo6wgT7L3MjRGcj+pO+h/F8khTU4ZwR
         lKeRA8IhOpSvOsiBMnx69yUJ5iAOB6X8V93UWO2ewM7Xh3RXs18jI7+05LRz5G+DWTp8
         ybYuIX6tDiNyKv0kajOLUSA8OhcX+3siXJ4+0nKO9vtgzAJ8k/zSEAHsRY7XTdawLVVm
         kBj+NeiH34YQDvfKtYT7+uyq65x3nUmKa65rQW3dymNZRAG0uDQffX9E/qnsEPasxENS
         p6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXXvGqsJTmiibGTq0LkizyUn41KJ8MUBaQAMKo7NDBvC/sNnzoESwI9PEyMHvZxnnluaSTu7tW09ISDNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNQduYYpk9jXn9gA6miUynkD8QbqzO+qDJKlXRlLr3HqPUjYA
	kbAzY4e7exV44ZccOAX58jnjsjM1zRlFR35B2SGAkHRETZto86LUUh0MVqChZ76VavMCMfKWolw
	+kw==
X-Google-Smtp-Source: AGHT+IGsGVabM6lqtL4epZ9oGORwajTYA23ku4RspaNu+4NGjN39FOibtOjpJfF6SNul6q4RPaHxkAISArM=
X-Received: from pjbph15.prod.google.com ([2002:a17:90b:3bcf:b0:2ef:d136:17fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3901:b0:2fa:2268:1af4
 with SMTP id 98e67ed59e1d1-2fea1299b06mr2509653a91.7.1740622788182; Wed, 26
 Feb 2025 18:19:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:42 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-27-seanjc@google.com>
Subject: [PATCH v2 26/38] x86/kvmclock: WARN if wall clock is read while
 kvmclock is suspended
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

WARN if kvmclock is still suspended when its wallclock is read, i.e. when
the kernel reads its persistent clock.  The wallclock subtly depends on
the BSP's kvmclock being enabled, and returns garbage if kvmclock is
disabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 319f8b2d0702..0ce23f862cbd 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -52,6 +52,8 @@ static struct pvclock_vsyscall_time_info *hvclock_mem;
 DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
 
+static bool kvmclock_suspended;
+
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
  * have elapsed since the hypervisor wrote the data. So we try to account for
@@ -59,6 +61,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
  */
 static void kvm_get_wallclock(struct timespec64 *now)
 {
+	WARN_ON_ONCE(kvmclock_suspended);
 	wrmsrl(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));
 	preempt_disable();
 	pvclock_read_wallclock(&wall_clock, this_cpu_pvti(), now);
@@ -118,6 +121,7 @@ static void kvm_save_sched_clock_state(void)
 	 * to the old address prior to reconfiguring kvmclock would clobber
 	 * random memory.
 	 */
+	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
@@ -130,16 +134,19 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
+	kvmclock_suspended = false;
 	kvm_register_clock("primary cpu, sched_clock resume");
 }
 
 static void kvmclock_suspend(struct clocksource *cs)
 {
+	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
 static void kvmclock_resume(struct clocksource *cs)
 {
+	kvmclock_suspended = false;
 	kvm_register_clock("primary cpu, clocksource resume");
 }
 
-- 
2.48.1.711.g2feabab25a-goog


