Return-Path: <linux-hyperv+bounces-3818-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC622A246B3
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 03:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D11889787
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 02:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F11B0F2F;
	Sat,  1 Feb 2025 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+zdv+FC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07471ADC6F
	for <linux-hyperv@vger.kernel.org>; Sat,  1 Feb 2025 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376268; cv=none; b=amYkH+LsihTDkTV3nYnuvYUdiNtN4Mm8jRdlc9hr5dErw3K4rybw6egsuv8Bi0/IeU/L8EJgBEz+/Q5NbfoM4gixK+E97xM8iv++UHbNx7xpodRIQSi87bekt7erLHogAxzc84ngAXXcAizZpuNwxTed6t7/8+0+x2ZdYGWs46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376268; c=relaxed/simple;
	bh=I7ICP95Ld9V+B6MPp3tXCsSnHLq4xQG7ZATAfWkmSSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DwFiHGj/3SozFIiXzUvyRF5oV4Vj3JBUYZayX3poI2XXawJ0Qqtu7e3cs6cA9absqECQghK4uFr+1Jk2Uuw3xG96ICF3FY/AOdIOa3fBIAyE6Whkhvdhb+JGPLvHP2HFa7/tlGEyOmno5HXAtvMnW4S0J7L1cfBsntTw0nVpzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+zdv+FC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216430a88b0so54945595ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 31 Jan 2025 18:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376266; x=1738981066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AK/mWgvwJvlM2VErSRU3T5I3ox4v68bEfhNUVA1UAEc=;
        b=I+zdv+FCyeDWqU0kLUOvk/nmJt/mmLOaIPkGd9fKk3eqlgFdOen7wrBVa+Jl7uqGv8
         W0WS1cGB+qD/QjfZYzHw+yYVfPPereyHMsADL+cI5XM5jCbyI4g+DVRZFYDfPz9mtosg
         DNxkdLmGqlduIuV9X4RBLGfjuBYCq0ENTuOZ0AoyfPM09VwLnl1TDeaE8d3jLrrZAfSN
         HJHFD1vm4eCbocB9LmehkDWaUa+BZIZsEVdJJ09AvtkGgdmB6iXWtBRv4pSq+MhRW+V5
         P1iA3ZThC+0U0drg5FOYMsmn+g001KkAlvMm1MgdWNitNNc/cyMnQvYZZIgVRUOhnhic
         S68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376266; x=1738981066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AK/mWgvwJvlM2VErSRU3T5I3ox4v68bEfhNUVA1UAEc=;
        b=cDNIJFyjqGkC+IaLGryTlQHgxWRZa6PfU72wYnsfBsd/rQoRXOvEwGIOWXRTscRv9s
         4p8miN2poRn7idzwWpKeLdop96jYWsJ4hgxBdiX2ItuIzJAcwCP2DhW8Eb0C+UnFv7Oz
         bmZOOf/k/Jo+hSFvFuvqEVnaHQP73J9+eSuf39TSivrJcqXEB0Fvn6GttaAMPoIiUe65
         atfNkXce1JorlETEHkREAmSUg9hzfEnIFSI8kobp0pCvK4KxPWxflONf4JiJXKV1o6xr
         YaXUw9ZS/zJrtNDX9+Nd+zAWvigs/PIMesZ4VZtuFV6qlrzBOiVFrJR89Ro4ttztc3R/
         WS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXXpgjC9QV83uRwRUhzYF1wOL1rh6gXyjrDv9eB/r+KGFYCzdg5JXetLSf4cseBR3HlGYugjakoHhPbPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNi9LD0b9megsS1zVOKeSrcyv9RL3ktYaf5R4W22JHyxeSa0l
	5+N1Z/U8U6wAgIzQ13SzbRWzTd2WKx6Ta9ddGuf6X2DIAZsymI4JuF5JG2BUzXOQuFvnAP69OoC
	Rkg==
X-Google-Smtp-Source: AGHT+IGIBUdgj+cCgBZpvoXPxY6FOVmtNbk7sDeQo6dqnIl0GeJKfhw5O39y3pDqzJDExNb4JeazGQgwjQ8=
X-Received: from pjbdy6.prod.google.com ([2002:a17:90b:6c6:b0:2ef:7483:e770])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c3:b0:215:b1a3:4701
 with SMTP id d9443c01a7336-21dd7d64c1emr194518565ad.13.1738376266294; Fri, 31
 Jan 2025 18:17:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:13 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-12-seanjc@google.com>
Subject: [PATCH 11/16] x86/paravirt: Don't use a PV sched_clock in CoCo guests
 with trusted TSC
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

Silently ignore attempts to switch to a paravirt sched_clock when running
as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
hypervisor could attack the guest by manipulating the PV clock to affect
guest scheduling in some weird and/or predictable way.  More importantly,
reading TSC on such platforms is faster than any PV clock, and sched_clock
is all about speed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/paravirt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 55c819673a9d..980440d34997 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -88,6 +88,15 @@ DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
 void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
 {
+	/*
+	 * Don't replace TSC with a PV clock when running as a CoCo guest and
+	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
+	 * which isn't in the guest's TCB.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
+	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		return;
+
 	if (!stable)
 		clear_sched_clock_stable();
 
-- 
2.48.1.362.g079036d154-goog


