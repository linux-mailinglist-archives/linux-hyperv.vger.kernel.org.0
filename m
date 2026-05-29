Return-Path: <linux-hyperv+bounces-11332-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAi5JG2pGWodyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11332-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:57:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506B6041AD
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE5F34F11F6
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9E3F86FB;
	Fri, 29 May 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tizPqjee"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7E3F58E8
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065907; cv=none; b=C0Go44UDQPI4OgNoK+RY7jBaV0TOPiNDBCTojTIIz6blKz8jd6ETLIA8924m7BwK6v/OHpbRdgKcl/3BqNdWDhlBFeZFAJsmwhMuC6PanZ5fow4UmGusCsL+O1gjgzx5D6/PuiAUBgNQ2Cq4RsaIadc++DIo2BoHDqKx/pXsSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065907; c=relaxed/simple;
	bh=bU4yyxwDONnh6/m4AIrBZuy9EH4am/4yreSoKbC9BSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rXnELlRseZ0K/BlqskC/+br10XsAwLeZIUtvbKRBgw7YU4zlfD+hDjBgcUUcAXKfHYE6EeGPaVYyWj2VP+EPXeDL5fzRYrq2IY08P4Xa3281VfcYbgaU1v9W0K5i5arTX/gtFLDaBIfft9RFZh09Huebsz13mI8iUPjrkSUwjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tizPqjee; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf3636d6c0so492765ad.2
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065903; x=1780670703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=H0GwXhoguEvRGovrleKtlxRg6q5h/dMOER9+6opKAAY=;
        b=tizPqjeerMvAs1ipgETZNtmHwAPNyb0OuuwcGmcmrLVP5tcY4t1Ma+H4qi9/+IRBfe
         sUHkIdCgODWqmDTaCvQcHxOA4Axu2txonWQYjJF6nrYkgVLoXdc+bTHQ4lC2edjgqSc1
         KSy6YMLNiqXTlPSF8GRXkpMjVjJ2eMdoOTlL9H51QOGATdd+8rBvfW7MrNPeNCbZGZLN
         p/XdXaIXIHFuR0U/5fztbbouoLKkv8o2tvfF2eOKeuuNfk41pO/8NtP+0ICwDI5fUnGI
         Mz9QL5bejl9IRID5KilhLAeUQXC9mAgAXBHUlnSyG7xmyt2R2/cC6h1lTV9Bs0kdF+9U
         ehiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065903; x=1780670703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0GwXhoguEvRGovrleKtlxRg6q5h/dMOER9+6opKAAY=;
        b=feCMZ93qxuCY3qw8YYAOF0JjtM/AtyUMqOtQy8Ptlhekc+hgxQ0IQm72rdqcWtNbdt
         Rd0sO8dICV5xkzlwOwEmbVqYpfmaI1USE8b5xx4dntJnssjPQTKlchoq8BqvsnozV6vf
         lmRbmgymQiJlnj/rMisw/zGGM1siOIivxPCDOmaUgHNJTnkt6qMH8YN8+c3z+51yIPAe
         s006GODIj+Hy9Q+D1WSqk2E07Z6+fhDVHrbbk6wXdmxH8Fc88lwV/W3FTGix3vl5lbYT
         Licx3G44mRtTu7bfIVSZFmorslk3uVmcorAoe2UbUPvHHh0SY4TSx3FYbSS96p0wDkMB
         iuPg==
X-Forwarded-Encrypted: i=1; AFNElJ+1igMApcFhVLNlsHGGqbMw/Grqbxp3Y2sFURxDcxtpGrWx0pvfD62Ogc3eCftTa2aqZBeRpk3NkBmeNHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdmAvBqsYpvto55vsKZFAItbWeDiaVQsFELyad9hcjfiWfnUD
	xv4KCGOz+MdmPBwkq8dnYMqct9/0YM/C+oLyzxoLAbLtb/LrBeYf3f1BuG26qrrIqAO1BkTzrsk
	wyAm8LA==
X-Received: from pgc24.prod.google.com ([2002:a05:6a02:2f98:b0:c80:192c:51ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94c:b0:2b2:be01:5532
 with SMTP id d9443c01a7336-2bf3686d1dcmr856725ad.35.1780065903103; Fri, 29
 May 2026 07:45:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:57 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-11-seanjc@google.com>
Subject: [PATCH v4 10/47] x86/tsc: Consolidate forcing of X86_FEATURE_TSC_KNOWN_FREQ
 for PV code
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11332-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 3506B6041AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all paravirt code that explicitly specifies the TSC frequency
also sets X86_FEATURE_TSC_KNOWN_FREQ, replace all of the one-off code
and simply set X86_FEATURE_TSC_KNOWN_FREQ if the TSC frequency is known.

Do NOT force set TSC_KNOWN_FREQ if the "known" TSC frequency was provided
by the user.  Per commit bd35c77e32e4 ("x86/tsc: Add tsc_early_khz command
line parameter"), one of the goals of the param is to allow the refined
calibration work "to do meaningful error checking".

Note, preferring the user-provided TSC frequency over the frequency from
the hypervisor or trusted firmware, while simultaneously not treating the
user-provided frequency as gospel, is obviously incongruous.  Sweep the
problem under the rug for now to avoid opening a big can of worms that
likely doesn't have a great answer.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c       | 1 -
 arch/x86/coco/tdx/tdx.c        | 1 -
 arch/x86/kernel/cpu/acrn.c     | 2 --
 arch/x86/kernel/cpu/mshyperv.c | 1 -
 arch/x86/kernel/cpu/vmware.c   | 2 --
 arch/x86/kernel/jailhouse.c    | 1 -
 arch/x86/kernel/kvmclock.c     | 1 -
 arch/x86/kernel/tsc.c          | 9 +++++++++
 arch/x86/xen/time.c            | 1 -
 9 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index bc5ae9ef74da..72313b36b6f5 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2027,7 +2027,6 @@ unsigned int __init snp_secure_tsc_init(void)
 
 	secrets = (__force struct snp_secrets_page *)mem;
 
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 5d7976359220..ab463c2b2dab 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -1205,7 +1205,6 @@ unsigned int __init tdx_tsc_init(void)
 
 	/* TSC is the only reliable clock in TDX guest */
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 
 	return info.tsc_khz;
 }
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 0303fe6a2efa..ad8f2da8003b 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -33,8 +33,6 @@ static void __init acrn_init_platform(void)
 {
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
-
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 }
 
 static bool acrn_x2apic_available(void)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 733e12d5a7dd..f8653fc05a40 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -575,7 +575,6 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_init.hyper.get_tsc_khz = hv_get_tsc_khz;
 		x86_init.hyper.get_cpu_khz = hv_get_tsc_khz;
-		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 7c8cf4885e82..2d0624c66799 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -390,8 +390,6 @@ static void __init vmware_set_capabilities(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-	if (vmware_tsc_khz)
-		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
 		setup_force_cpu_cap(X86_FEATURE_VMCALL);
 	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 4034e08c5f11..e4d7d9e2cd69 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -255,7 +255,6 @@ static void __init jailhouse_init_platform(void)
 	pr_debug("Jailhouse: PM-Timer IO Port: %#x\n", pmtmr_ioport);
 
 	precalibrated_tsc_khz = setup_data.v1.tsc_khz;
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 
 	pci_probe = 0;
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ec888eef74aa..69752b170e0a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -117,7 +117,6 @@ static inline void kvm_sched_clock_init(bool stable)
  */
 static unsigned int __init kvm_get_tsc_khz(void)
 {
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 362596612442..8cef918486db 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1569,6 +1569,15 @@ void __init tsc_early_init(void)
 	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
 		known_tsc_khz = x86_init.hyper.get_tsc_khz();
 
+	/*
+	 * Mark the TSC frequency as known if it was obtained from a hypervisor
+	 * or trusted firmware.  Don't mark the frequency as known if the user
+	 * specified the frequency, as the user-provided frequency is intended
+	 * as a "starting point", not a known, guaranteed frequency.
+	 */
+	if (known_tsc_khz && !tsc_early_khz)
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
 	if (!determine_cpu_tsc_frequencies(true, known_cpu_khz, known_tsc_khz))
 		return;
 	tsc_enable_sched_clock();
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 1adb44fdddb2..487ad838c441 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -43,7 +43,6 @@ static unsigned int __init xen_tsc_khz(void)
 	struct pvclock_vcpu_time_info *info =
 		&HYPERVISOR_shared_info->vcpu_info[0].time;
 
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(info);
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog


