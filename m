Return-Path: <linux-hyperv+bounces-10956-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIExDI90B2r03wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10956-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:31:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AB2556DE5
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83685306C294
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B0940EBDC;
	Fri, 15 May 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4h9PO3T"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2873CF030
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872875; cv=none; b=lxwBTrqE1zFUbT36Gh/78otqboz3gN48pr3S/Pr4N7rixN4ZEIlhXZsc7a/GYdR96N0e1UZAOkzgp5F8bZyU91QjCNxiNH9ODlSqKf/zeGsf/a51nWSQOYCFuMVtcuBY27IIMT1dGTt6toX3BY1OWyCqskzvlyP9TtGPOzQwW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872875; c=relaxed/simple;
	bh=oS9aSnkApcPsOGR1rkhF7MOLa9irLvbbIXlzkW7Bx9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N8ivWcrOX8YHreiOKiF1BFwvRtHCfl+fkpSo34fXs65ol0N+CpVhZjGVXNCHdOKetbYtLqMMU2up/cxa23Ftp+oDHt65AeowsOOVoJu0RCGCFiaJ7oXaB6kqRIFk3rzQ3olYU/5P7AN4KttlWHVINEyiQ9UePxnpxv83QUR0LWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4h9PO3T; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-365faf6006dso89041a91.1
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872873; x=1779477673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=POYAFJXhX15R3hmqAgfLZg3VsZ+0XFpd3jcwWXWllKs=;
        b=S4h9PO3T7GqvxtmsyA+U+1kQ+MILJvZmlfREvidSg9AqxRxK+Tb7nd6oTwvQLhhT28
         VsYwZuHAHwyO1vn82gqZAKOZuWZAVtTJbaf6ENpMuVp7REawk0TpomwojJn2XOxTF3lr
         BATSfykPMxsQyTEHqOEFwdu4eT9dLWHbSm8gcVBArNfWY689szW7/H6lM+GFEHl2Gppt
         WOO8WftwMltN1M76QnsK3O+SGcFOCaVpvJl6TYKhciR3iRhqlNBmvFqgnxhbtYAJPpVh
         sC1sVlTKbUmf6vXWPHrLODwxtCwfvhiciR809dJl+4oQfMyXh6j5GIXKniWc5KiKawUK
         pnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872873; x=1779477673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POYAFJXhX15R3hmqAgfLZg3VsZ+0XFpd3jcwWXWllKs=;
        b=QByH0jld4LmwJZfE8faxEI1wIrmXxW+EaevbZMhIzAlXg4+3UOsyJupKU8oTpppJV1
         wF6S2nSEt5amc4pj7B0G3I+BinSv3dvWN1iMxA6bAWfLJS3ck+BUFJHgyZ3IjlkyEuqr
         2bPLXGLoV6DBKBTKriCP5w5ERIKKUVeuYaouau1q3UKYaD0yAFT0yHONngmQhpHwzgZO
         6vHuRhWkTl6Q5V4gqHwgJ0ZoYh3cmqCUNlp/jIBI02D+2tdxmTEWHwwz7Xi62wE7vUtB
         GnUUBOlx45HbwH4vCAwLGVvcsXHJMKEDG7KB9be60spGdTlMpTqqIOTgRvxSBTh8dyRL
         r7xA==
X-Forwarded-Encrypted: i=1; AFNElJ9laCwHFvtfYM0nBnM5Is0KeovFlW04CIIdO/YZvIfvyJCD7PX/TZYYy8ukHeOCGeV06Dljz76PQxXHs0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+L5+RGoe8a6Pa6HkfLgeenfmvv0Ksyyc0hDnIFDW/AY1Nki3
	imXeL0pAVavwGuf8Yv3NtHlIyZW60SBfc7I+Y94pIQMfK41rwrMERm+40MPjNP/Wq7HsTni70cW
	JjlL+qg==
X-Received: from pgla17.prod.google.com ([2002:a63:b51:0:b0:c82:2e5b:8f33])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3505:b0:364:edd2:812
 with SMTP id 98e67ed59e1d1-36951cb3086mr5037302a91.25.1778872872299; Fri, 15
 May 2026 12:21:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:34 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-34-seanjc@google.com>
Subject: [PATCH v3 33/41] x86/kvmclock: Mark TSC as reliable when it's
 constant and nonstop
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
X-Rspamd-Queue-Id: 11AB2556DE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10956-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Mark the TSC as reliable if the hypervisor (KVM) has enumerated the TSC
as constant and nonstop, and the admin hasn't explicitly marked the TSC
as unstable.  Like most (all?) virtualization setups, any secondary
clocksource that's used as a watchdog is guaranteed to be less reliable
than a constant, nonstop TSC, as all clocksources the kernel uses as a
watchdog are all but guaranteed to be emulated when running as a KVM
guest.  I.e. any observed discrepancies between the TSC and watchdog will
be due to jitter in the watchdog.

This is especially true for KVM, as the watchdog clocksource is usually
emulated in host userspace, i.e. reading the clock incurs a roundtrip
cost of thousands of cycles.

Marking the TSC reliable addresses a flaw where the TSC will occasionally
be marked unstable if the host is under moderate/heavy load.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index b6b2018c51db..47f7df1e81a0 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -363,6 +363,7 @@ static __init void kvm_sched_clock_init(bool stable)
 
 void __init kvmclock_init(void)
 {
+	enum tsc_properties tsc_properties = TSC_FREQUENCY_KNOWN;
 	bool stable = false;
 
 	if (!kvm_para_available() || !kvmclock)
@@ -401,18 +402,6 @@ void __init kvmclock_init(void)
 			 PVCLOCK_TSC_STABLE_BIT;
 	}
 
-	kvm_sched_clock_init(stable);
-
-	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
-					  TSC_FREQUENCY_KNOWN);
-
-	x86_platform.get_wallclock = kvm_get_wallclock;
-	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_SMP
-	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
-#endif
-	kvm_get_preset_lpj();
-
 	/*
 	 * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
 	 * with P/T states and does not stop in deep C-states.
@@ -423,8 +412,22 @@ void __init kvmclock_init(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-	    !check_tsc_unstable())
+	    !check_tsc_unstable()) {
 		kvm_clock.rating = 299;
+		tsc_properties = TSC_FREQ_KNOWN_AND_RELIABLE;
+	}
+
+	kvm_sched_clock_init(stable);
+
+	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
+					  tsc_properties);
+
+	x86_platform.get_wallclock = kvm_get_wallclock;
+	x86_platform.set_wallclock = kvm_set_wallclock;
+#ifdef CONFIG_SMP
+	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
+#endif
+	kvm_get_preset_lpj();
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
 	pv_info.name = "KVM";
-- 
2.54.0.563.g4f69b47b94-goog


