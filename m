Return-Path: <linux-hyperv+bounces-11358-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLLZDjWxGWqtyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11358-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:31:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F84604BE1
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29520308E107
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CB23FA5F9;
	Fri, 29 May 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LY2MhMwH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EC3F9F52
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067292; cv=none; b=PEQ3r1Hi4g5RfRMzYEOy/GOHju/S2VmYdrqzyAsnjEFT2a+HZEsTjgZbI/h7kMRyLBcwmQodyJP/V7iEY74Lmd6RhFtmCL27OGS2lWcZz6lAf81ORDGqgC2ahw3FC7DIGaVCrb2Irgnj9qkntwuWjxr3JJ85C8b/MlLoZM19BR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067292; c=relaxed/simple;
	bh=cC+ojIAc3Le9jXEf/baGTObcFZeIkk6RSMDwnRnXepg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J8OIBUA9bAHZ4fPOocxa+0EvvSmDbS8NTof83GDcmBWT0Z0u5UTFLh7uaJmgN9pJ5T7rltn8p06GAj1NOe2XcNxS1HbGvHn9eRqb3Lr2NRh0DY8c9L/A6FK3kS7HBa8xi+B95kad46CcwLznsPIfPPw3m+z/7W0EEQ5MXUg/27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LY2MhMwH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c829366cf25so17888840a12.0
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067290; x=1780672090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4xsn0b4/TuAYVw8d7nIvqzj+ui/IxR9VfuC7re3vJ7o=;
        b=LY2MhMwHvBJG6o7piM7J8Uab8RlyAcwY/d7TsX8L6ZwIl/5/f7Mv6KwOL6apiOmiYA
         dPDkyPA6E5Z92zzQjNlyY7lMWFz0z0lLY9i2L41e64WX+iuEq5DKLbNC6fu0x5OqBK3q
         9rdW/gTpckhSoqH8rWodFKCeyItxLmfuP1EBNcXxT+qBWRXAppwC3TXeOJKMfvm/qFuB
         CxFyAHW23Cmh4zTqU75DcWwA/LltcPvkcIWRT/7aRMbZkB76to/1tZIqXz8tcQ+GMana
         LNiWm1UTwp2oUHyVqPWln+hY7e42mj5qpnFaPy3xPUjNwG0n+1BJT+l6ntN20l+/xDzk
         p0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067290; x=1780672090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xsn0b4/TuAYVw8d7nIvqzj+ui/IxR9VfuC7re3vJ7o=;
        b=Vp9XwgOGY9bayUXxNpFDXOqWjYcVBkwanKYm2Ijw2vcsI284c2NL4NUTD5M/K5YBUw
         1C7oKsdV4W67abaUsCjFGIgk3Cgd9aAsca3/nkVtTRuqCqfUOp48B5brd6UGYFUmtOe9
         fM1Jsr2jEfm60v+zqxH/wd4oHNs817o+34LRNYdkIAmmVjkM5ETWxn0Mktg1LmkF+CvU
         rq0kjvwWE8TpPxDv92RS5hov9wqXPTMZX85fywUtpzSXlIrYODdp1at1NwXakLVsbnBv
         /9/4rZiMkRHKiUEYbxrW+y16VNwMThmv7rW8LhUx6ApG5byhk0KHxitCbFT9qoJY3Csj
         Fetw==
X-Forwarded-Encrypted: i=1; AFNElJ8aznZg9dAxTV+8CoZP+8oGj4t4Vsc2jJZG8xpo9mtDK7CJxAT1wyiEZ44WJjcEedjLSFJqy5wEaLDc+sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQ9mO3JncmCgccaNUHLTsvmL9fz8lTvVmsJN4jQ6bzb/oIPB0
	Y8Hi6DZDNThf0w16VuL08QvA5TrF+bq3OapRlaP4peEgMFOsuK7VFIj1Ph4S0r1w8g1taCbqZxK
	WKcVMgg==
X-Received: from pgfu20.prod.google.com ([2002:a65:6714:0:b0:c85:82f6:34d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2452:b0:3b3:24d5:d656
 with SMTP id adf61e73a8af0-3b411deb049mr3990553637.23.1780067290086; Fri, 29
 May 2026 08:08:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:07 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150807.714538-1-seanjc@google.com>
Subject: [PATCH v4 36/47] x86/pvclock: Mark setup helpers and related various
 as __init/__ro_after_init
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11358-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: D1F84604BE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that Xen PV clock and kvmclock explicitly do setup only during init,
tag the common PV clock flags/vsyscall variables and their mutators with
__init.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/pvclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index b3f81379c2fc..a51adce67f92 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -16,10 +16,10 @@
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 
-static u8 valid_flags __read_mostly = 0;
-static struct pvclock_vsyscall_time_info *pvti_cpu0_va __read_mostly;
+static u8 valid_flags __ro_after_init = 0;
+static struct pvclock_vsyscall_time_info *pvti_cpu0_va __ro_after_init;
 
-void pvclock_set_flags(u8 flags)
+void __init pvclock_set_flags(u8 flags)
 {
 	valid_flags = flags;
 }
@@ -153,7 +153,7 @@ void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
 	set_normalized_timespec64(ts, now.tv_sec, now.tv_nsec);
 }
 
-void pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
+void __init pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
 {
 	WARN_ON(vclock_was_used(VDSO_CLOCKMODE_PVCLOCK));
 	pvti_cpu0_va = pvti;
-- 
2.54.0.823.g6e5bcc1fc9-goog


