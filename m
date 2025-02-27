Return-Path: <linux-hyperv+bounces-4113-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C54A472BE
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D84188CC7B
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C1C233D8D;
	Thu, 27 Feb 2025 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ja7voLrO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A7232395
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622793; cv=none; b=J8iDdo38xsIa76oo6C40MZJiXa+jR71XEMAar0jwdYIIVM5+MR2WMrh+rvxdu6cHMy0WTIiRwbcH0sjU+Biuls1McpkbPIUY3c5SD7cjv9eBJyQhtELNVK7lRBJ1e7smYwnwGhFb/CpQCIm1jPUd6dJfEC0v/nxcqjiJo6JCIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622793; c=relaxed/simple;
	bh=Bgq2jKvITCPJGjInNMTg9hShy45LprwLheePx172YI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LRc0oBx8Bd929JcK7Xza3tprBdThDGh1+Z3QCdL23dW0HtL8gdz9cw2KOduRMwtv1nEbX7BYD6Ab+YywqWRZxO9y0WOVG2F6emxuh8+Q0Il6O14ObgOW/TLi2e5rXff63TcWPuxbfu8d1fXEUwf0A2T3tXhFJ/9/wq3f+hTeqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ja7voLrO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe8de1297eso1024087a91.0
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622791; x=1741227591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=w772IaQ5YRbZvSP+H3ufucBFIq7F/07nn6vrGLJgcY8=;
        b=ja7voLrOwYQdv1Sdy9Os0Q93S6Z8KcXth3ggO2jhvDNp+8SztQ1N1vNGd0QmO6Zd+j
         +tLpDz5lVBuh9fJbb90Z9RP9MeWHgAunRGw6VEK4R5r0DN6hkFZq8SNDJ8064NhC8S/o
         u3smzhjRcCOaJfi2Tn08Ij1AWLjp8ckJlkww5RghW2YzIDw1bV8fXxNO/JsIj75+sneO
         2kgP6TkoDS8184soxCnxA3jygfgEL9hU/8VDIpsE/lPwq4jVIkvYOkEu+/Ph82GfkiBT
         fIUlG1X66B+jCqXRj5xPTcez7cJpA3PcQ4U7xeFafjEv14dEGceFjUyVGheNMb1AQ8Ih
         vVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622791; x=1741227591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w772IaQ5YRbZvSP+H3ufucBFIq7F/07nn6vrGLJgcY8=;
        b=JnoqMjYcr4gDWXKCsscEE3/vtMD79pEQQNEDVAUuCcyVeMV8yY+1sfu19mgAFZOswq
         wBqGQU/kLeBNimFQJt18HwxYDD5d1FFgDyOtq0aWodkJDur8mvv3Sd11WV2DoIVp4lfl
         fkb73jynaI2iOcT7C0oYp67SgXTXI4SDQEnQaXWinGR2dk2y6acVZpS57sTwYpScar5h
         9FlD/boJARCdZQqtaAMjPygrC0k0c31oiUgLcKWzL6mvqwMGfYXaztOj4WuVDg8hzPW5
         U9qkjCTjCGL8OefcqCFHtl0Pm+uxdBQ9dvhnKFdguPpjFBEcqmeaym18k175qtLu2Xyp
         NtMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4WLpIm+/bqX2kULF2IYJI6EagL/v9LO06Kl5MHAOiFPB2L7PtgDpO73E8YS7n2UjzoDqBs8zOG5waH8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtqHOw2P9OjuWBxwPifGbL0GESq1/rkw7q/lMcZn5OB6Ez62k
	JkLyQvkYbF1RoC7wsdaeBB0BnueH3kRIp04p7iADsIUFyMuM0nstUKYDYeDxhyfOZzhlzU92eBe
	aJA==
X-Google-Smtp-Source: AGHT+IFwaP3Gmshvc7uvq62wN2IryjydNwW4vN0WeuDaKx0968TrkTSYTEdNA9orJIr9gY0PmdxDWYBBhxM=
X-Received: from pjbsm1.prod.google.com ([2002:a17:90b:2e41:b0:2f8:4024:b59a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2688:b0:2f9:d0cd:3403
 with SMTP id 98e67ed59e1d1-2fea12fcb22mr2427211a91.16.1740622791492; Wed, 26
 Feb 2025 18:19:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:44 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-29-seanjc@google.com>
Subject: [PATCH v2 28/38] x86/paravirt: Mark __paravirt_set_sched_clock() as __init
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

Annotate __paravirt_set_sched_clock() as __init, and make its wrapper
__always_inline to ensure sanitizers don't result in a non-inline version
hanging around.  All callers run during __init, and changing sched_clock
after boot would be all kinds of crazy.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/paravirt.h | 9 +++++----
 arch/x86/kernel/paravirt.c      | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index dc26a3c26527..e6d5e77753c4 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -28,11 +28,12 @@ u64 dummy_sched_clock(void);
 DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				void (*save)(void), void (*restore)(void));
+void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				       void (*save)(void), void (*restore)(void));
 
-static inline void paravirt_set_sched_clock(u64 (*func)(void),
-					    void (*save)(void), void (*restore)(void))
+static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
+						     void (*save)(void),
+						     void (*restore)(void))
 {
 	__paravirt_set_sched_clock(func, true, save, restore);
 }
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 9673cd3a3f0a..92bf831a63b1 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -86,8 +86,8 @@ static u64 native_steal_clock(int cpu)
 DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				void (*save)(void), void (*restore)(void))
+void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				       void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
-- 
2.48.1.711.g2feabab25a-goog


