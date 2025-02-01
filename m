Return-Path: <linux-hyperv+bounces-3814-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DCFA2469F
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 03:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F1165D2C
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 02:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924515A863;
	Sat,  1 Feb 2025 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lc4rnG6D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EDD154BFC
	for <linux-hyperv@vger.kernel.org>; Sat,  1 Feb 2025 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376261; cv=none; b=q5jLDxTToi+CioDdOixDr8Yj8ZeciQ8Kgp+IZbhxhx7JcufNAITbfD9w2n9X9hYqLZk0av7LOXn2kOLZPX7F58Yd2VhviCeNnIS8AkNc1EC3HYKqL9rIy6HELUielTI2GDPpLqnpE8PgHjeGk4vOXbIsgBBD5pzkQdATvJbAEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376261; c=relaxed/simple;
	bh=E6Iy1BiM9FEEtqnIX6/l7kPa8oyhyUi3aCV4SUPddsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sWFdgMHMRDkP3W67+Z3nNT+07aLVCNWuTcWTtQei0yRDAQZJYw7uOMQDhROaI7Zkz/IAAolRqMYEkz1k/pvdpHASXb5rHPFpJ2ODjBdfn14g6uLOdRRoqjZrZVzwVtJB54o0Y87nlfFLhA4//SwuQiJ262ezM3umeeaAKcKrhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lc4rnG6D; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso5211303a91.3
        for <linux-hyperv@vger.kernel.org>; Fri, 31 Jan 2025 18:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376259; x=1738981059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IW8kJcAcrKvt4c0vMOL7jWV1OXPEd6lfnHsLFZy4QXA=;
        b=Lc4rnG6Dm6msGUFDJy1doz8yyGyZL+0sW/L70hr/9AcdgDF+5ljhpV2WFFPRn59xG2
         JMdnkczVc3HsnISv79/GB/CFVO+fAEtoxVlJpu+kZF/gVUeb07RsEQ8nNNZfBAYosltb
         ZjFcPv6ISf6yg71vzNJ8W8xp5kUwNuFdgsrZiZWdwexHES8U+Lriigo1NV6MKdS2hmn6
         jdNhdPLfKyBJtILm3vcJMJgtyQybH50lEl5sRn78WFp376vxMXH4j3Kk41GdU1i9xYoV
         Dm3HaUG2Ig/4PLg+3w8X+jSA5loW/lZxaUezO2K+TY0aPfhsC+4yI73UpQjUpt3SCxKG
         L42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376259; x=1738981059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IW8kJcAcrKvt4c0vMOL7jWV1OXPEd6lfnHsLFZy4QXA=;
        b=jw9tF3ldaUt/A6oJ59S8y821Cawxqz4OAlYxZ1XKkd/R8BIi8UZ02Pq6gGV6R0dopB
         Lp1t8gjJaPOSCYm/zMbAjPwCJrZGAxh8JplsfHsUM36knX9OHO06epm/6nAC4mBNOCDV
         5v0YfmDngJYAUsITLqSr8p87eT7J4EZvQpGrxhRFvBj68Ei0hqBoCvIG19q/dR8M/66Q
         klNNn8CoFIJ6b7EEj0R8Ey5jW/e0fHIVQA3I9C995/wXFL0JjZ8J6HTleMyRIPYdcAhl
         azgCW65wfbbqq0jBE46Hdbqh69E+SV6vauEU96b7B48ErUl2ZJ2vo4krD5g+YWATJlou
         rSbg==
X-Forwarded-Encrypted: i=1; AJvYcCUYkotlnMG0UMLFAtg3U7R+JwpALF4f58ZnTzuoX1AyEfTdaK15uvX9Dz8EZEY0G6/ujpQWb1s0H3zLJuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/oRhZc5pAK8WyGXG+R90pdoQsoWhdtwVRvfcDnBuqL+vwR8A
	t1+goO8PoVR+huSD51zC9dDmpRnBdOpx3DVrf3ZkzkOKwWoIRGLkcA3CS0Fn7scixtha2DYErFg
	x5g==
X-Google-Smtp-Source: AGHT+IF5rIJ4SRqkvzrTVMPpN2jn4obzhnrXzWmKwhKWojp8QTZ0kuVpAxPsfycQKPuD0sAxN2zkeFmWkds=
X-Received: from pjbsb15.prod.google.com ([2002:a17:90b:50cf:b0:2ef:701e:21c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a08:b0:2ea:37b4:5373
 with SMTP id 98e67ed59e1d1-2f83abe2135mr21011714a91.10.1738376259599; Fri, 31
 Jan 2025 18:17:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:09 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-8-seanjc@google.com>
Subject: [PATCH 07/16] x86/acrn: Mark TSC frequency as known when using ACRN
 for calibration
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

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index c1506cb87d8c..2da3de4d470e 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -29,6 +29,7 @@ static void __init acrn_init_platform(void)
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	tsc_register_calibration_routines(acrn_get_tsc_khz,
 					  acrn_get_tsc_khz);
 }
-- 
2.48.1.362.g079036d154-goog


