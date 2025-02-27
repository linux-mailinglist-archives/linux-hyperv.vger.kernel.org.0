Return-Path: <linux-hyperv+bounces-4117-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA97EA472C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3D83A3FA8
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436423AE7D;
	Thu, 27 Feb 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kL48CMa5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DBA23907E
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622801; cv=none; b=lokRvmcr3pKT3Vqej289y46RhBs/9YhptsvJxKnTeGFLAIXji1eGpRdgA6fvLyjuIsDBN37SWtbv4jNj5hOyFP/pZrZKog1nh7A+ZXQHfUIJCE2v3+s9pwmtRwFGU2ROU0eqOKGeWj/b+rR4vLVmMIC4Fr1AJLKJtUBW3zWsSTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622801; c=relaxed/simple;
	bh=XdZRYBlPZyw/8jtawHaf0Gd25EjncrTXZSrOsMRCotM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hX/I/6nDHGW/UpejXcAJI8Osn7ctXILGSClHBMNPr+AwZDUTDtqBft3i/cyFuI7OLQkUTPxf8YW+s5PNi+i2jfXaZEf8IeoGPTpz6WluW6pyJJ+bC3W5mh//EHyUbIronh9g+Em7VfXhiL4J4FcW0OQ/LDKA4lXWs5PNINV+x9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kL48CMa5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe870bc003so993602a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622799; x=1741227599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LZJJLySVHQgVgABAB7C0XZjDtBlLYwz9ES+Z1vP/8LE=;
        b=kL48CMa5HC14aNbI0Clsz2W/FXFsbTLSaq66y5swjaYLwy92G2/KOpyXHgPIdH1wA0
         7pdF7gDgm1KFZsaLOrC3vhi/1/NU1Kds9jeCo857ZMxKJy43ucAAGlVApPm80cP7fyJ4
         Ak3WGFAoZWP9p56PU/FtWgNi8x8LSfI5aSLZeENPtLkZJawX/5O0IB3pAhCL9FIW8JUw
         HQ5rSgm47il+rEQfdN6ul6S3Av+lh9JmyzPlpTfaPzPHACpvbCJxvWjLGa2SYgTuxu5F
         HYMmTbNr5hAw8O7aWmxnWa8YRxFwGyF9JTHnUZwtFjhqZpYsP1zTTe2hSkBq5qh4Ig0g
         4Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622799; x=1741227599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZJJLySVHQgVgABAB7C0XZjDtBlLYwz9ES+Z1vP/8LE=;
        b=o2PU9UEAS/0Fp0GUuF4CvXWHMDl09MNbCYtGhcJ6Vq5C+Ty6rhSSk2KzTlEdFeFBJK
         j5Ct1uff/HLjoQLHzhWQlLDBth958Kxl67Gk/Yh3SNint2pu0HFLenBWPLvYLq+9KdjI
         i+eTBD8o8kQ+AKhGE8mh7Pw0d4aLQCs7IaLSACVHkkOou9vsjujnQL5E1vmN+xqvbdNE
         2MV9IjM4daftVVNjFKH2GJwW+LGvnX5+l3KA2Be8sg11zEjY9PC6J1m6KQxTq3H3qcbt
         iu9+L5IWeDrWe7wRBaB85iI9T2FIQiAmzPLymiQbb8cdRG/z4xy4spivnKhLJ4+XIzxR
         2rVw==
X-Forwarded-Encrypted: i=1; AJvYcCXY4iNQqWEvnLWe6X/p7TFvUy2KNwrKw6Oi9L5G+muSbGPqKmcD2Et63gNfXsNf47LDonJVI3eEElsnxwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfBvNSLmmZp84hnkUJlqS2t2skSq31GYvZlbYGcFz/YVpzeSZs
	Kj1N1B354Qi9iJbGl6lc0F4tMzTZb4Gd/gfNfnznaM+RjRH9MqcFZt3ENed/lYvSLI50pc+4ihr
	tTQ==
X-Google-Smtp-Source: AGHT+IGhmfOgzOy0w88MLax4aQJq7WSM6/RTmeD/HK48z8QB3SAzs8w4kTiAhr4wwBRMQkXZhflq/qsZ2GU=
X-Received: from pjtq6.prod.google.com ([2002:a17:90a:c106:b0:2fc:11a0:c53f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:570c:b0:2fa:2c61:3e5a
 with SMTP id 98e67ed59e1d1-2fea12c36b0mr2515446a91.10.1740622798574; Wed, 26
 Feb 2025 18:19:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:48 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-33-seanjc@google.com>
Subject: [PATCH v2 32/38] x86/tsc: Rejects attempts to override TSC
 calibration with lesser routine
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

When registering a TSC frequency calibration routine, sanity check that
the incoming routine is as robust as the outgoing routine, and reject the
incoming routine if the sanity check fails.

Because native calibration routines only mark the TSC frequency as known
and reliable when they actually run, the effective progression of
capabilities is: None (native) => Known and maybe Reliable (PV) =>
Known and Reliable (CoCo).  Violating that progression for a PV override
is relatively benign, but messing up the progression when CoCo is
involved is more problematic, as it likely means a trusted source of
information (hardware/firmware) is being discarded in favor of a less
trusted source (hypervisor).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index be58df4fef66..ebcfaf7dcd38 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1309,8 +1309,13 @@ void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(void),
 
 	if (properties & TSC_FREQUENCY_KNOWN)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)))
+		return;
+
 	if (properties & TSC_RELIABLE)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_RELIABLE)))
+		return;
 
 	x86_platform.calibrate_tsc = calibrate_tsc;
 	if (calibrate_cpu)
-- 
2.48.1.711.g2feabab25a-goog


