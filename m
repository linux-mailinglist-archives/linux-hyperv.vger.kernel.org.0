Return-Path: <linux-hyperv+bounces-3817-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19043A246AE
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 03:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483371889B14
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B0F1ADC82;
	Sat,  1 Feb 2025 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVK9N+FI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1D1A23BE
	for <linux-hyperv@vger.kernel.org>; Sat,  1 Feb 2025 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376267; cv=none; b=r653DueOoI0BTOW8llZx9v3+7Z37UljIHQmebutSr4GU625l1FPlUt0tg+FfBoOK/E2dWRs6S9cvy9XkMueyWMNRNJJmy9VkdF8qoILh7dNIvV9QJXgM3eW8T1ytt+z8ST1X94oYqmX9sYVB2ooJABbi3hRuY3KunG5puMBz0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376267; c=relaxed/simple;
	bh=kx1WuhibcuTx6WiHPmvUxDfP1htj6y2KJdDmu/FjmBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GuuuoKEjEmKyiuq5NBSAKmSsS5+aMuHEvKgoTbZGaA91vfhlvAYFT51mUo3QqrZqPyi92VYxgKkvOYkbBy05pclDCQB9TbUkGR2wJRL2n+JowA9U6J/CdDpsE5OwBT/0Jb+jRnSGQ5kIo4y4DpF3SB7hrvflEakbTsoGH/3392I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVK9N+FI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2162259a5dcso84137215ad.3
        for <linux-hyperv@vger.kernel.org>; Fri, 31 Jan 2025 18:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376265; x=1738981065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W1XV2ZKxBzpt6fRRKseHNiWV51nuIILy1d39LBlT9SE=;
        b=wVK9N+FI4a2ceQOs7i0AkqT31sCQJmoaHqMMyptLTslSjOcDBE8Ilnx3viQKaXVXDH
         q2cIO9ilRm10t+7wHx6WV0reM/uqdKvGwoeB164bSV+wzhiH/IdkdJWDx6PhfsBV29Q9
         YR5MTjav3JjL7QB+qv0Sb4LJ6n0lRbr7ozI6QRfmuW6deEEmgVu2cxyNwwxdBNhiV0Bt
         bipYle1qf4jcKQjyHx2CDEH4uvOFD+LIp979llQaI6PgZ+bO+Zdfws2Vyi+C+P+jM9NS
         KrGnDAGI2gdzkz8Ws6TMx9SdyPsZOGGV+EZdw2+XMdnI3eukjkR/XMLmcmm10GNiIxsJ
         6XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376265; x=1738981065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1XV2ZKxBzpt6fRRKseHNiWV51nuIILy1d39LBlT9SE=;
        b=SbEHN8JEDjzeffoOF6v89ZetLOZ0dc0oCgsmmru50G3spv8cdL9k3abcckFsyfTVRu
         8Oz+dt8yBs0rKrmNgz5cxR08DifUe3A6Uqmv9R77lfbm2UmZ5CAS5t/iE6KFgJ28lY4L
         ekwsMRqiJQ2SqJMCBW0WdJb/UAixsYHxGBHwBtW6DfOCx1R3YxmdTpU8sfysfT+J6CJx
         NGmQLHYaIJr9W2JLSh+shLIjQTLqyIY7C1rM/7Xh6VPfLaL0lATyHH4p/OLiSLqsUrVS
         NzozK9Z1euSFTjbRhZbiZO9DkR0QfiHvg0xk2vAu2hXcsA0f6W4damDwNvx2X/dCTwOJ
         rVew==
X-Forwarded-Encrypted: i=1; AJvYcCVmqqEfic5P9bc8GR8GMzN6KyyB98yPDmuEvWp9kaSS8mChskdUycWznc5xSJ8AB9jRdb/5XdrqkqUoHGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIdLxHvGwc8SYlp377Rk3sqSg9MCaAZArSpRMarJsMBt5Feek
	51QSm8IO8kdPTTpa7yjEMH3EkmXdVSrqMRK10JJWKLroTp8pqjUG6iwRER0u98M/wCF1ojCE+f8
	06w==
X-Google-Smtp-Source: AGHT+IGSSeREbj02hPb3cDa39T9c0oKEk7xpncELnx14V1Vrs2HnSpCp6+OTk/Z1j4CkHarX3h8UUIGOLcI=
X-Received: from pjbsb14.prod.google.com ([2002:a17:90b:50ce:b0:2f4:465d:5c61])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244c:b0:215:f1c2:fcc4
 with SMTP id d9443c01a7336-21dd7deeff4mr227157665ad.41.1738376264849; Fri, 31
 Jan 2025 18:17:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:12 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-11-seanjc@google.com>
Subject: [PATCH 10/16] x86/paravirt: Move handling of unstable PV clocks into paravirt_set_sched_clock()
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
index b41ac7f27b9f..890535ddc059 100644
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
2.48.1.362.g079036d154-goog


