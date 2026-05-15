Return-Path: <linux-hyperv+bounces-10962-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNaVJhx2B2pL4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10962-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:38:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CF0556F8F
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7586301A725
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7244033EA;
	Fri, 15 May 2026 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXEMbnvg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F163D6491
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872886; cv=none; b=fiamT8t0tPOSTpsITvQFMpmZ2ffFNZrAihUycLokQszBHgFKFGx45fwXMIKXglnX1x55bPTysQ81Q9+O1G7qzyXVNxw9t/VCUXT51HsxVRclAM2RpesQC3GeLhEsBASfcdRyjL0F3WPVwU3eHld/8dK3UdR6Vr/HjUBlb5EY3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872886; c=relaxed/simple;
	bh=iobt3mMcxUgFyEoOEmLnGtiXka6utk5+xSHE3bisqLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RoiYNu60oYy99y+N+W9b2KIjw6IOL1hpVHM4uN4et4q4Aiwf/ZHC0fGTcPE1Kcq2iC1Iph92Bm2ZYwBRKvF0SYU2uqT8GAS2UnPoSxhzKwFLhNju3q31zbvPIMH+oglZbRnw1CseIdYFpQlbNNiRQQteybbEAlA9yOpOtttgpGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXEMbnvg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so260900b3a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872882; x=1779477682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ9Kqslov6eJXg3tHpdlTt5rxLZvQw1ej96frcIls5c=;
        b=YXEMbnvgg6l0uKD6wsZPuFH8e21NihcxH9ZlNNKRqFSt0mdPcxMre6Gjjke+3vlKHq
         mtRhqG6ei8i7WBwUyBvb5tK8+GCLhtT7bTyPNxZn5ixZp6BQr7qLIPYCqYaUd3IZaP6H
         Q0Qw4UnvbFstDQ1o0jce7lTz3/HtuVBlAQ6aur2jioWFINpDmSMkn4z1JDGzv8LY2lBg
         tZoqluuSYqQUd6Jfhz/RLiWoSzloQHycgpp18RJ4wtMO8JiPeXgleJCJaDORnpfaPzC2
         fFz1ArilyKGjicvvI0a4bA4kiyvlsCyFIMU5OP9dCQPn4b0WP5+5gzLEkWolKo03IiO2
         Z5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872882; x=1779477682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJ9Kqslov6eJXg3tHpdlTt5rxLZvQw1ej96frcIls5c=;
        b=clKA53CgeczkhN/YN3SmCAdZJaOxrz2GLtkp2zCouSgdvx/HiYkSOpuzARdaWZTg7x
         j4PJN3PMJBHDPPd68eyxYmHkLiVQBCZGdKSnjczkwE29FPNcTcA8D9vJDJOqa6DXFOX7
         28YSZOyVvBiTuOAfuvC+y3paDk6CkEwK8YKkIIpVJUoy/HC/uFYcsjAYyOE4qh83Wp9u
         BvKIX/g1mKn+9gDlX6Y3lWo66+1lfS2FYa2+h6bCoY4QLHdyT0H6dMJSb9p8uESE9Gvy
         JWxn42q13+ZV2yETdTgMFOz2lJiKIMDtwgGaQVB9umpY+PhkKgb9iaxO1ohg6XUWZ+f2
         PJWg==
X-Forwarded-Encrypted: i=1; AFNElJ/7vojOFgxb1tbSZZKE0+wKAIm8i8vkW04zYhunjCZItpoR6x8DZp+LKKUuCjnM+D849XoIa8IQerYJ0yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl76XKwsAH2/F0s8VmFsxHtilB8qcJzGECKELxi4TWUGlqo50P
	c6jQ1rOVtXPqd6DWOxq7sRLHxoJob5tkGkxJrbSq5MyGtrfypLYpp8SSAHT4yKumcYJtpwHu3+b
	pU6HjSg==
X-Received: from pfmm20.prod.google.com ([2002:a05:6a00:2494:b0:835:43a4:4aaa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d19:b0:82f:a89e:e16f
 with SMTP id d2e1a72fcca58-83f33b2f58fmr5940174b3a.14.1778872881979; Fri, 15
 May 2026 12:21:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:40 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-40-seanjc@google.com>
Subject: [PATCH v3 39/41] x86/paravirt: Move using_native_sched_clock() stub
 into timer.h
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B7CF0556F8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10962-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de,amazon.co.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Now that timer.h ended up with CONFIG_PARAVIRT #ifdeffery anyways, move the
PARAVIRT=n using_native_sched_clock() stub into timer.h as a "free"
optimization.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 5 +++--
 arch/x86/kernel/tsc.c        | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index ab1271bd9c3b..d8cb9c84f2c7 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -11,9 +11,9 @@ extern void recalibrate_cpu_khz(void);
 
 extern int no_timer_check;
 
-extern bool using_native_sched_clock(void);
-
 #ifdef CONFIG_PARAVIRT
+extern bool using_native_sched_clock(void);
+
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void),
 				      void (*start_secondary));
@@ -27,6 +27,7 @@ static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 void paravirt_sched_clock_start_secondary(void);
 #else
 static inline void paravirt_sched_clock_start_secondary(void) { }
+static inline bool using_native_sched_clock(void) { return true; }
 #endif
 
 /*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f78e86494dec..1b569954ae5e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -316,8 +316,6 @@ int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
-
-bool using_native_sched_clock(void) { return true; }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.54.0.563.g4f69b47b94-goog


