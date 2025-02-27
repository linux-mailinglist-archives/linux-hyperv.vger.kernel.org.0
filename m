Return-Path: <linux-hyperv+bounces-4104-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECBEA4725F
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD117A30D9
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4DE18DB35;
	Thu, 27 Feb 2025 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNGEAb2o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890E1EB1AE
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622778; cv=none; b=sgqe7Pt1uPt4/I4Jf3l3BH7wc9UwmjxcnjXqeMUcd0++ba/n/QcMZkDtSCTbGJcSOw1HPM/PkCR7fH4OKaU8neCD4qtlZ5C9cPieh3/oBuJhGJmRMat5iO+yCOvPWtcHJaSxk0vK4m8J5XPERM9ClOxYsSYbndb0iAoX+9ymMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622778; c=relaxed/simple;
	bh=6spaFA6jKPMfGFgmSBLcviB3IyQMP9osLaGs4X9wbRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+ncFzFRMUsNLOTfzfQsIwyhcuda3W9oXK8czXYEuEDbnqHgmIFw1aucemUfQlN5ndrU6g7Z1xFjLpv1i/hBK1Cm1fjIB0gBFmuPLVPvmr6IFhSRePBvkZX3gkODSYanqDdEiOLDDwmlsksPqOfkhVop/37o84rDdMKYrXpFnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNGEAb2o; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2234c09240fso7690845ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622776; x=1741227576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DqrQU03sQXOQDWLkbiIYCQHYscRa6LsfmxFd/y9lSQI=;
        b=YNGEAb2orJWT4DaRfs2+oc8Ryoe6Sgg9CpOjlncAktCi0oNOWV4j+zVPu4FHgHvPzm
         MisCMMOv0sElsSpzQpUX+g6iHQTJkRFheGKZHh2BzOgD/S3Uq5902KKHgqD1i+Hk8al4
         sM/fyuLzXj+ruTxCJMwBauBzGZWHNzXuZxveUxZ6vWYnYlUshB+BV7DLon93RCYNc24Q
         YP0CT/PtIZNkCkUGjJ4l0oo/MmgyB6/Asef0aUoxqNDZ6x3ojL+AcB4fGzxLFgutur5j
         JPNBai+sqzfURvnZIuSvoO9pnDcmJ/ONdWvZtG97GPGw885SiWIuuzHlgQvT2wQDRk9c
         ndEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622776; x=1741227576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqrQU03sQXOQDWLkbiIYCQHYscRa6LsfmxFd/y9lSQI=;
        b=rgoVmNHEmofpnyXt3hHWrbDVXMit9P5+me5+f/uKtDF2Nm5xNof8LhuIBAsUp1XA2X
         nsJ2OcxfWOzSV1NTAAm0xfAAbHWixiKIXOoYkntNfohyKtpAQc2tpN59GhmZzB45U3/v
         herO+UFioxpMwvOp4IQJ/Yf6Dx/IkXC3vIWFLhDab6ZeodqvyMsSHEpknaBZJGvnYw4p
         FKhhvGQW/Eo3sktS+5X19+y71yXPwypkC75NpXx43ed0rznSvsSjioeFN8Huxpez4W3y
         lFHYA/faw0bFUgPVe5VXf12R91AsVPnYSaILhOkXSORX/YiBlKPo3Lo7AGQOq9XtTj9o
         83HA==
X-Forwarded-Encrypted: i=1; AJvYcCWktZdc1+9D8eBCwOi6ixVufee98jyR+KbFPBnNqcr6vJDEBvOREB8ZME18BoL8+gfu5YnxNb4/C2jXrQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpk1RBHqkOrQ0zw6tYbfViHQ4uZXAFPYPoHxnnhQuwW/nM8x1q
	8/9beP9pkfVU9rQV9zvYUO5oTqQoNBPCduIryrjFCaKD1Qqdnym6nKrbOxWa3WLbMo/SMed/o1X
	4DQ==
X-Google-Smtp-Source: AGHT+IEOb0ihEjgZTJgsK50piH41vKgvY42fSlJ0VND1RngWC+UvT9KhzxC1r0flylu86Z/N4Su58D1alpU=
X-Received: from pllg7.prod.google.com ([2002:a17:902:7407:b0:223:2747:3d22])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58e:b0:21f:140e:2929
 with SMTP id d9443c01a7336-22307b52eb5mr158736135ad.15.1740622776273; Wed, 26
 Feb 2025 18:19:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:35 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-20-seanjc@google.com>
Subject: [PATCH v2 19/38] x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
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

Move kvm_sched_clock_init() "down" so that it can reference the global
kvm_clock structure without needing a forward declaration.

Opportunistically mark the helper as "__init" instead of "inline" to make
its usage more obvious; modern compilers don't need a hint to inline a
single-use function, and an extra CALL+RET pair during boot is a complete
non-issue.  And, if the compiler ignores the hint and does NOT inline the
function, the resulting code may not get discarded after boot due lack of
an __init annotation.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1ad3878cc1d9..934ee4a4c6d4 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -133,19 +133,6 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-static inline void kvm_sched_clock_init(bool stable)
-{
-	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state, kvm_restore_sched_clock_state);
-
-	pr_info("kvm-clock: using sched offset of %llu cycles",
-		kvm_sched_clock_offset);
-
-	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
-		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
-}
-
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
 	/*
@@ -302,6 +289,19 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
+static void __init kvm_sched_clock_init(bool stable)
+{
+	kvm_sched_clock_offset = kvm_clock_read();
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state, kvm_restore_sched_clock_state);
+
+	pr_info("kvm-clock: using sched offset of %llu cycles",
+		kvm_sched_clock_offset);
+
+	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+}
+
 void __init kvmclock_init(void)
 {
 	u8 flags;
-- 
2.48.1.711.g2feabab25a-goog


