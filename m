Return-Path: <linux-hyperv+bounces-11362-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOZPNmqxGWqtyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11362-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:31:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79954604C38
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB3F731584AB
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DCD3FFAD6;
	Fri, 29 May 2026 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKnqxczI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9A3FF8AE
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067302; cv=none; b=n9+N2Kyb986HUaIwujT1Lb6jl+BlvIgwjwagNMUaLw/2eYqiliMGTW62drFpGqLzYe4fnU0NhuMCz1TkgbifF7uvcmVtlPYXLPzJbU4grMvoEFcyGjVRMwHGiqCliZJXlFDnDOLeMkeHc4XV2p/t0l+y1OTmyxqK9cbqidYlC5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067302; c=relaxed/simple;
	bh=FXFmm/bt28qzsjhzY8TENCjzEiTjb//R/uZtmzqCTi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pz/jag+KztiHaq7+UUSHi2ADNHjcFBSuHaas5sC/0EKpHVlnnwU020M2MjrJm6Fg/Baz8Ib72BxpR60IFhPhqOu1u7S7Q58DFmyRbgqCsenrjR2Nt5xsvMRb8eKAySwjrX0cSuab9sSCDsyfTefoyDD55AgRoSHvJlKM1n7a3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKnqxczI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso9300767b3a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067300; x=1780672100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hiLxlYw3clwD2dLxI09vlAh7vN9DHw/HVEHbWWzJKBk=;
        b=YKnqxczI3yawyQxppQjpZXSdQey8KrFecNNN0NvjBTtgm0bcy3t+XH1QKRoKsRMtMk
         VyLieqz2PAHG55nVmLrlV6FfVLLshwR499Lc7dHchGVk5vIboZKP6qHuuO7sEFD4aiBR
         RCzta4gO3pwvos5mcUFstAR/sBhCVsP8qyDIddv4BHjfdaXglNYq8aufIk/P+T1S1HPA
         UUSgsfudVdVs3XHt2HaU0nn0aJyfuTgE8J1Z4Wv8woe/80qke/fQmlvWvnEIGyykZ/SQ
         8wHYOruGsqFE90xIsKTv7MdB7Os1ItoGcE96asK5DBJ6t0b7Ac91cCZrOArYiALAp5B1
         cyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067300; x=1780672100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiLxlYw3clwD2dLxI09vlAh7vN9DHw/HVEHbWWzJKBk=;
        b=abdw3UboKEMFnEXy6aDNGGUS2dWo9kO3zyRlTuKeyHKb7PBfhyCQdrhWSa6o7NGrFe
         juQMPhvZeuYUEw8ifZGZn6MI6aVWU49A3OH8QaslBiz7AJUpVJAK0Nr7zYPZkGtLgg2R
         QsBSucBraKKjrLRtmOdU5ZnjnDkQMyzYmd8GEKWh/osAc5MkSalQeiADmaMUdUGLcyUs
         9YuWkpYIJA6PiVnHKANB7ilkDGCZgXGPpjLvQEaoVGHLBIlZ96xGp1JMUxhtM8+wg7GK
         boMHuEUJqOU+f/9qs0IcuZ5YIye4mAFAmsT/KqGa0L3lWCSEjE2bqcGrDjIwXGA1J6JV
         aa5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8rtrPTZQOSmavnql/nSDR8xmSkhzD/BWcTJ1ZskM2a1LOu498KLQF1cVLYd3EffwqScU28Q6319vJy3ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqWNRv4Gv+Z4+ISYbqjOKkhAhMy3Z4ljDSFUTIQWbSg28QXpO
	J07JUFpdloaZeSb57Og2Q6kAq+AUba9Rt5LMJOmJqXT2rhfZFH9CbSS1HPU8T7r0FuhZtJ41c1I
	zh6/tpA==
X-Received: from pgx6.prod.google.com ([2002:a63:1746:0:b0:c79:81bb:79ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9149:b0:3b2:a958:a725
 with SMTP id adf61e73a8af0-3b411e478f7mr4139551637.41.1780067299927; Fri, 29
 May 2026 08:08:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:18 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150818.714760-1-seanjc@google.com>
Subject: [PATCH v4 40/47] x86/kvmclock: Hook clocksource.suspend/resume when
 kvmclock isn't sched_clock
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
	TAGGED_FROM(0.00)[bounces-11362-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 79954604C38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Save/restore kvmclock across suspend/resume via clocksource hooks when
kvmclock isn't being used for sched_clock.  This will allow using kvmclock
as a clocksource (or for wallclock!) without also using it for sched_clock.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 4e304f1c887d..5dfac79a5d30 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -131,7 +131,17 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
-	kvm_register_clock("primary cpu clock, resume");
+	kvm_register_clock("primary cpu, sched_clock resume");
+}
+
+static void kvmclock_suspend(struct clocksource *cs)
+{
+	kvmclock_disable();
+}
+
+static void kvmclock_resume(struct clocksource *cs)
+{
+	kvm_register_clock("primary cpu, clocksource resume");
 }
 
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
@@ -201,6 +211,8 @@ static struct clocksource kvm_clock = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.id     = CSID_X86_KVM_CLK,
 	.enable	= kvm_cs_enable,
+	.suspend = kvmclock_suspend,
+	.resume = kvmclock_resume,
 };
 
 static void __init kvmclock_init_mem(void)
@@ -296,6 +308,15 @@ static __init void kvm_sched_clock_init(bool stable)
 				   kvm_save_sched_clock_state,
 				   kvm_restore_sched_clock_state);
 
+	/*
+	 * The BSP's clock is managed via dedicated sched_clock save/restore
+	 * hooks when kvmclock is used as sched_clock, as sched_clock needs to
+	 * be kept alive until the very end of suspend entry, and restored as
+	 * quickly as possible after resume.
+	 */
+	kvm_clock.suspend = NULL;
+	kvm_clock.resume = NULL;
+
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
 
-- 
2.54.0.823.g6e5bcc1fc9-goog


