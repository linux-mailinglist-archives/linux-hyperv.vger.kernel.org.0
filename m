Return-Path: <linux-hyperv+bounces-4098-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B0DA47256
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CE23AA38A
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B701EB5C8;
	Thu, 27 Feb 2025 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nn0/JtXH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4191E8343
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622768; cv=none; b=iuCwwiXs0t5yF0VICxsLgyEHo9OsmcCRFw5tZKlP6zy1xAZOxdfIJuLl3cKTYShtO2dRlZ5+WKbYxI0cWdRczdS6J2RRkXUjIqDQu9iiBg2ryS5hRXuMpzmJvLW2TY4bu0PIg5hgGy+MEZSxVB0Kg2TRdUW4r0DG/cB5w4rOv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622768; c=relaxed/simple;
	bh=uls1GZWoryKNI+ZdGNLcku3CfoPFk/9lR0JDodIiYUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bvsYKDKBqVSojJl8oQRx7lMY0l2shqVVWK0bHNgs5IespLBvcF+hD9OuDZBJzSaVmlb+QWXE5+IyYXyIRw8MDmhsFYFu7FyP6XK+M6cwZemTh4BwnvqGQPsj2jePCJNROW08YtHjNIKJUWCOZ8f81bSSKO9RWYljzBeUqxekuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nn0/JtXH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22112e86501so7658595ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622766; x=1741227566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UfxMQF/rYWh5wJy03aYqaPrcV7f4BOaa6HmKd5c/EfY=;
        b=Nn0/JtXHxutzJ6n/fUVS4j4h157GScc0h43rNHp66lZcSO+UF+aA0aR3xT8RRpiCck
         6uMGqJG9n4RiOb/sgRK1Gy1QspKYb2lPN2P4P64Xv3BdR2RM9FVZn46tIHqOCwlam9Vs
         TBIRrTc4J/4V3erKpGAiBinbXtFTNYMEDZpSmFkmN31/w1UwnAYOiNjxQmYLe9WiYLUs
         A2Ib1dGFrr8r0fAOF7AlWISJfwqVZHklIBEyPAPoQIJeNaPbLQqo+dFcMEGXpjdzAqHQ
         txyQfW6ygJjNTomZTYR/XH1BGRRsNtmJvbSUUMYgSptbbrJMlczObhbePO4HNnVGH8/Q
         HreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622766; x=1741227566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfxMQF/rYWh5wJy03aYqaPrcV7f4BOaa6HmKd5c/EfY=;
        b=w/Gan3RMdyWl1TW3WbCEOFzGfWtCCYaKNW/3Kt/7/N9r6ZeP+pkYEhBuJMKRJ9gvuD
         n6Sha2BqDfOifReAwGitgQc1rLBsQkzqabT6QV2QtLN8kRnr7RD+o/XJnMa/5LTeggol
         ki8zfLc90bftb00ceQcUIiLg4MaYV/w3AFN9112A535Qz1oh2l+/Kh9a0k+35UFOObeU
         JNoLsqHWHOp+cKk7Oab6+vsVaOXT7at9SJWHBOVIy1YTi00gNJxx+8j0y+zNRPZyXTur
         WOErDZDmta+nNtzKYRmG/C4mJ2ZKu5FopeNCXMdefOWOIo0KB3xJMjs3AUae2+jKvylL
         yzmw==
X-Forwarded-Encrypted: i=1; AJvYcCWU1x8reni6Wf98MuAj6V1ohO0VqGKOeFAKckXJCcLuh0rLMkqFTtRAmgjw1sRjl/e5/XzxqMhgVaQMME0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8OykWXc2Y+jpv9zuXh7A7NNhFy+YPLf9G1o4H+ppuMoVhc1Tq
	WyRPwoGjRP0uIshR+vGXLatKCYOhSrY+M0X/qsqgI/mzL3psjoJe9Qx9LHXvUuRZnC38/e3uMfm
	LeA==
X-Google-Smtp-Source: AGHT+IE7Xj/t7ND33DY7WpQVYCStd1wMVi/xBc5OTLhEqC2e0MCFeJOTyP9t5m80ApVOgGC3SmRws/tVvjE=
X-Received: from pjuw3.prod.google.com ([2002:a17:90a:d603:b0:2fc:2b27:9d35])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8c:b0:21f:3e2d:7d2e
 with SMTP id d9443c01a7336-2219ffb8b65mr337766155ad.27.1740622765716; Wed, 26
 Feb 2025 18:19:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:29 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-14-seanjc@google.com>
Subject: [PATCH v2 13/38] x86/paravirt: Move handling of unstable PV clocks
 into paravirt_set_sched_clock()
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

Move the handling of unstable PV clocks, of which kvmclock is the only
example, into paravirt_set_sched_clock().  This will allow modifying
paravirt_set_sched_clock() to keep using the TSC for sched_clock in
certain scenarios without unintentionally marking the TSC-based clock as
unstable.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/paravirt.h | 7 ++++++-
 arch/x86/kernel/kvmclock.c      | 5 +----
 arch/x86/kernel/paravirt.c      | 6 +++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 041aff51eb50..cfceabd5f7e1 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -28,7 +28,12 @@ u64 dummy_sched_clock(void);
 DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
 
-void paravirt_set_sched_clock(u64 (*func)(void));
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable);
+
+static inline void paravirt_set_sched_clock(u64 (*func)(void))
+{
+	__paravirt_set_sched_clock(func, true);
+}
 
 static __always_inline u64 paravirt_sched_clock(void)
 {
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 223e5297f5ee..aae6fba21331 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -12,7 +12,6 @@
 #include <linux/hardirq.h>
 #include <linux/cpuhotplug.h>
 #include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/set_memory.h>
@@ -93,10 +92,8 @@ static noinstr u64 kvm_sched_clock_read(void)
 
 static inline void kvm_sched_clock_init(bool stable)
 {
-	if (!stable)
-		clear_sched_clock_stable();
 	kvm_sched_clock_offset = kvm_clock_read();
-	paravirt_set_sched_clock(kvm_sched_clock_read);
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa3397a67..55c819673a9d 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -14,6 +14,7 @@
 #include <linux/highmem.h>
 #include <linux/kprobes.h>
 #include <linux/pgtable.h>
+#include <linux/sched/clock.h>
 #include <linux/static_call.h>
 
 #include <asm/bug.h>
@@ -85,8 +86,11 @@ static u64 native_steal_clock(int cpu)
 DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
-void paravirt_set_sched_clock(u64 (*func)(void))
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
 {
+	if (!stable)
+		clear_sched_clock_stable();
+
 	static_call_update(pv_sched_clock, func);
 }
 
-- 
2.48.1.711.g2feabab25a-goog


