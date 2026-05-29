Return-Path: <linux-hyperv+bounces-11349-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCw2KP6tGWpyyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11349-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:17:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F8604787
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C52130AB1BF
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572F3B3BED;
	Fri, 29 May 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GePsKUPF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091BF3DA7CC
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067222; cv=none; b=PjJq2Oc4FK1EzGXTgtmIqrDh5Ndewld35a/SkklnAXZrqObS2BeW9FxyUBc7fVk//o9ZvKiBvRXMyWnL0dkZ0Q2GUqR2SBOfpYN+mzWPfNVk9Srz1BlWQSXlEbfm3tnzguQGq8VWWrCT3TXafFDvv56k4d7hokbK2wBBZQoSBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067222; c=relaxed/simple;
	bh=HD6T6IXKxXHYYTEzA8sYaRKBtXpTOgGbEYUT2q1t41U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UahTwvHEidf/OCvZ0g73dM8veC9FnleVOA33+O9WWg63LJyFIlAT/HNT+fhXnfDr4qEBb6szR0DVBmVQx3ZrKO4dazAQstTxj7wdl6tFbb1qWqGBl6hVD0FvBPrzuEScclnXuL+1Jc6Nkzo/cVMDxCLiinsgeJDihO477Dzc7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GePsKUPF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8397b14a689so8957510b3a.2
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067220; x=1780672020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xaVkfsA2sOgFELwC+9kgheEWN7jnZ1tVtkSLe6gYY/I=;
        b=GePsKUPFHhVzYsmPLPHATURDMfbSytocbEzlem9fv5RLH548OfqM9+SjfiMTo5FXWF
         Bwgm9QtikZ5YMYZxeXSmF3i1xSjr+tsN7Zoh/viE/SEpmj1NkMLDkmkFm136Fu8nsJqQ
         NhqyqteCfdPXKDgj+bMWRwfJ82nr22GI2pX+A9d0WcREoh+nRqnUI9DifDPAvimxxKlF
         6MKOX1u+IyUTUMskE0bOks35rXOQN94fvj12DJgOGySQ56nRM11sxvCqj/wiwLoyhS/W
         oEDwp2AQO2DQTKuHL0NgaEBQrm/eg/XxtLL3K2Pj4KZpcS9xWjnuI5BkOVlJePu/eO+u
         Vi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067220; x=1780672020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaVkfsA2sOgFELwC+9kgheEWN7jnZ1tVtkSLe6gYY/I=;
        b=OJu6wx7M1l2LqiAWrhcivrB5HcOqbi8IZKvrzDNz+SNuE/GBsmpPBRipqmQDx1SdzZ
         xaf7jxBababk7zaLAY8nywpqSc2tka6SGQIqdQj6xRj49q4YV5yinQqWaMsAG8t6IfP+
         Oxd47AEUNGn5KYibjhHllbJTQwPqCkS3wUaqNaJp1lZM/cicKSMinw1/Z57V90IPPuSD
         jXhW24Y7uZi8YKHCLo8MBLTIiTUMSoF31feJbAwZrGBGMsiG9l3OeD2yrc3aNH0FGhgo
         n37LpyKT6uNg4Svhh3VVKgp7TikLG645vYb7Pd1QhW0VhDAwx5PzkCFXi3zdKldAHoJS
         6fNw==
X-Forwarded-Encrypted: i=1; AFNElJ867sY4PALpeU8m9Ix6FtzXx9dk5rF+hyKFa9MpoBTyUoOO8Ub1DDhfemnX/L6wioweUX5ASiZMdg5fODs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhPVduDKAXEa5Vbk5u/A/vlajweCTAzcD8wqXYP2EIOsYQ5EB
	VrBFXVxWhFMPBOoe/K7cZokX1tClGazCRos3IfbUYuo1pEARXVm1OWkjMR8P06A66SuFho4Fxzk
	Y9CaDrg==
X-Received: from pfkk14.prod.google.com ([2002:aa7:90ce:0:b0:82f:6245:a6ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8088:b0:838:c01a:7a50
 with SMTP id d2e1a72fcca58-84212ce8ccamr3369227b3a.30.1780067219938; Fri, 29
 May 2026 08:06:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:06:31 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150631.713818-1-seanjc@google.com>
Subject: [PATCH v4 27/47] x86/paravirt: Remove unnecessary PARAVIRT=n stub for paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11349-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amazon.co.uk:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[zytor.com,intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,infradead.org,outlook.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: A17F8604787
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the unnecessary paravirt_set_sched_clock() stub for PARAVIRT=n, as
all callers are gated by PARAVIRT=y.  Eliminating the stub will avoid a
pile of pointless churn as the "real" implementation evolves.

No functional change intended.

Fixes: 39965afb1151 ("x86/paravirt: Move paravirt_sched_clock() related code into tsc.c")
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 3 +++
 arch/x86/kernel/tsc.c        | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index fda18bcb19b4..c71b466d6ace 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -12,7 +12,10 @@ extern void recalibrate_cpu_khz(void);
 extern int no_timer_check;
 
 extern bool using_native_sched_clock(void);
+
+#ifdef CONFIG_PARAVIRT
 void paravirt_set_sched_clock(u64 (*func)(void));
+#endif
 
 /*
  * We use the full linear equation: f(x) = a + b*x, in order to allow
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index bdff8c988866..888bd1cbd9bc 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -288,7 +288,6 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
 
 bool using_native_sched_clock(void) { return true; }
-void paravirt_set_sched_clock(u64 (*func)(void)) { }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog


