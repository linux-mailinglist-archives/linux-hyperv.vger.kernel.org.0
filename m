Return-Path: <linux-hyperv+bounces-11736-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YhO7JChtRWpU/woAu9opvQ
	(envelope-from <linux-hyperv+bounces-11736-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:40:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D044D6F0F8F
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:40:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=LHlwxdHQ;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11736-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11736-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CC85317EC1A
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74334D90D9;
	Wed,  1 Jul 2026 19:32:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714E4D8DBD
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934359; cv=none; b=BpwT2HFkXjKZq8usq+791zPoExV9GqSrCjyoW6guHREhLKfWSei3EHzNaonCrES01fn28gW1qMvn9wAZs3Ea3xIbrwpfQGvmn4NJ1QhoXOtJWQnnKQx1aviN3StTVVvX/bMz398nGZFj9GYy1OjDMXpGC/KSEYmmytIIw0cWoRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934359; c=relaxed/simple;
	bh=49eeGZWtzh77YK8enS+18Uedac5nFOhPwjQ2h1LQiuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gWLqDonyWDgxl0BNrWI1q13erRhPISx0JtNZkUyMPpnkWoV3W82hWIQNCoYy3teiQYwGlnYZg7c0AmHUOqBxgaeFpjhhOWTj666TlXN56ROoln8b3PPvR3v1pRXZm74liW3cNwm/oIv9JWLxC0gKwY+KByNM+OeEZb/v/IGYEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHlwxdHQ; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so885969a12.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934356; x=1783539156; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=02bcXtHfI4JvUWCbZ/FGUqsIhMJvDsaJ6tKyxXO+eMA=;
        b=LHlwxdHQJLajoJsEcsKc8JxTfIzLHuT2T5SYi/SJzB10Me4dP9boZ+l/8xsWjeftiY
         mdJgdZocNMdMMAHbgWE0o4608EXm0khttPiuA6sjLzG913w7+TBLtD0As5ba7FwA867l
         WsF+w+9XyR7N/GtFwFsyTtSV2M9WItMUJsT1b2Z2MRRsbXozSxXxzs1UFqA6KB0prmpw
         hldjLQFwA/tuC4f/u+Jzw6YMOWGY5hE3WWXY3wvKAvUu/eUSF6X+5DW8QGvRdxcLybC2
         PnNqxgV8o+ZkHizE38acKofCVWXGmK8rRtN/HTgSl9z+1QlR4rBzimf2lqdMu/grfk5r
         EBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934356; x=1783539156;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02bcXtHfI4JvUWCbZ/FGUqsIhMJvDsaJ6tKyxXO+eMA=;
        b=Io0WO3+EfZZl6GEL++c6nc+2Akj96U8Yi9krudfs+j4NOGYnmGgcp1gOBQ/p8wiLFK
         2dQqLnTpvYffIeYXA7rQMod1bC773GU5szS9sFb53x9ZaXrffaABUC22FnzHpiKJooA9
         lhG754uDWFTbJniiFK9RqYPpV9poqrXXTlaEKJTXC6t1iLlG1FISUJJdJPEKRKLCVEkM
         REXG8n85uluLD2yycOIAKoVtCVNSKHLsuw5Jk2Lk1NDH5mIebLc/i3HxeId/o8Qn7+Sz
         9c3mcdLMSykL6+Rbosd3bXfh7E7wUT0zRt1MH0woENuKEWObdJgp4liTSnjNnVzXNyAw
         J2ug==
X-Forwarded-Encrypted: i=1; AFNElJ8tVEPRbQqB/lxlxh5Lx+J3+EpMVBT4h9JHKwcAMnLQ98hfCLkOSRygtpDw1E9d5AcD1yXfPvLWgf/fJEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywBxkwmcq5pUyIZ4jbTyI/0BnrhBvIGJvH7rj1/QPipInOJ4n7
	EP8gf4MYZ7eZ8N/QbrV1t9SOFW6y+Z++UMR+3RF5mclNfCzNKpAWdQP3Po2YrJUuICANTWB282j
	aw1/kxw==
X-Received: from pgko8.prod.google.com ([2002:a63:f148:0:b0:c99:aff5:708f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d807:b0:3bf:9a30:3a20
 with SMTP id adf61e73a8af0-3bff40a18cemr2476915637.16.1782934355934; Wed, 01
 Jul 2026 12:32:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:29 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-9-seanjc@google.com>
Subject: [PATCH v5 08/51] x86/sev: Shove SNP's secure/trusted TSC frequency
 directly into "calibration"
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11736-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,zytor.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,amazon.co.uk,infradead.org,outlook.com,linutronix.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D044D6F0F8F

As a first step towards dropping .calibrate_{cpu,tsc}() and explicitly
defining precedence/priority for "calibration" routines, pass the secure
TSC frequency obtained from SNP firmware directly to
determine_cpu_tsc_frequencies() instead of overriding the .calibrate_tsc()
hook.

Unlike the native calibration routines, all of the paravirtual overrides,
including SNP and TDX, are constant in the sense that the frequency
provided by the hypervisor or trusted firmware is fixed, known, and always
available during early boot.  More importantly, for CoCo (SNP and TDX) VMs,
it's imperative that the kernel uses the frequency provided by the trusted
firmware, not by the untrusted hypervisor.  Enforcing the priority between
sources by carefully ordering seemingly unrelated init calls, so that the
trusted override "wins", is brittle and all but impossible to follow.

Explicitly ignore tsc_early_khz if the exact TSC frequency was obtained
from trusted firmware, as per commit bd35c77e32e4 ("x86/tsc: Add
tsc_early_khz command line parameter"), the goal of the param is to play
nice with setups that provide partial frequency information in CPUID, i.e.
is NOT intended to be a hard override.  Neither SNP's secure TSC nor TDX
was supported when commit bd35c77e32e4 landed back in 2020, i.e. lack of
consideration for the interaction was purely due to oversight when SNP and
TDX support came along.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 arch/x86/coco/sev/core.c                      | 14 +++--------
 arch/x86/include/asm/sev.h                    |  4 +--
 arch/x86/kernel/tsc.c                         | 25 ++++++++++++++-----
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..181149f633c3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7946,6 +7946,10 @@ Kernel parameters
 			with CPUID.16h support and partial CPUID.15h support.
 			Format: <unsigned int>
 
+			Note, tsc_early_khz is ignored if the TSC frequency is
+			provided by trusted firmware when running as an SNP
+			guest.
+
 	tsx=		[X86] Control Transactional Synchronization
 			Extensions (TSX) feature in Intel processors that
 			support TSX control.
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 403dcea86452..bc5ae9ef74da 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -99,7 +99,6 @@ static const char * const sev_status_feat_names[] = {
  */
 static u64 snp_tsc_scale __ro_after_init;
 static u64 snp_tsc_offset __ro_after_init;
-static unsigned long snp_tsc_freq_khz __ro_after_init;
 
 DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
@@ -2014,15 +2013,10 @@ void __init snp_secure_tsc_prepare(void)
 	pr_debug("SecureTSC enabled");
 }
 
-static unsigned long securetsc_get_tsc_khz(void)
-{
-	return snp_tsc_freq_khz;
-}
-
-void __init snp_secure_tsc_init(void)
+unsigned int __init snp_secure_tsc_init(void)
 {
+	unsigned long snp_tsc_freq_khz, tsc_freq_mhz;
 	struct snp_secrets_page *secrets;
-	unsigned long tsc_freq_mhz;
 	void *mem;
 
 	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
@@ -2043,7 +2037,7 @@ void __init snp_secure_tsc_init(void)
 
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
-	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
-
 	early_memunmap(mem, PAGE_SIZE);
+
+	return snp_tsc_freq_khz;
 }
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 594cfa19cbd4..05ebf0b73ef4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -530,7 +530,7 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 int snp_svsm_vtpm_send_command(u8 *buffer);
 
 void __init snp_secure_tsc_prepare(void);
-void __init snp_secure_tsc_init(void);
+unsigned int snp_secure_tsc_init(void);
 enum es_result savic_register_gpa(u64 gpa);
 enum es_result savic_unregister_gpa(u64 *gpa);
 u64 savic_ghcb_msr_read(u32 reg);
@@ -637,7 +637,7 @@ static inline int snp_send_guest_request(struct snp_msg_desc *mdesc,
 					 struct snp_guest_req *req) { return -ENODEV; }
 static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
-static inline void __init snp_secure_tsc_init(void) { }
+static inline unsigned int __init snp_secure_tsc_init(void) { return 0; }
 static inline void sev_evict_cache(void *va, int npages) {}
 static inline enum es_result savic_register_gpa(u64 gpa) { return ES_UNSUPPORTED; }
 static inline enum es_result savic_unregister_gpa(u64 *gpa) { return ES_UNSUPPORTED; }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 8f1604ffe986..f049c126e47c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1440,15 +1440,16 @@ static int __init init_tsc_clocksource(void)
  */
 device_initcall(init_tsc_clocksource);
 
-static bool __init determine_cpu_tsc_frequencies(bool early)
+static bool __init determine_cpu_tsc_frequencies(bool early,
+						 unsigned int known_tsc_khz)
 {
 	/* Make sure that cpu and tsc are not already calibrated */
 	WARN_ON(cpu_khz || tsc_khz);
 
 	if (early) {
 		cpu_khz = x86_platform.calibrate_cpu();
-		if (tsc_early_khz)
-			tsc_khz = tsc_early_khz;
+		if (known_tsc_khz)
+			tsc_khz = known_tsc_khz;
 		else
 			tsc_khz = x86_platform.calibrate_tsc();
 	} else {
@@ -1503,6 +1504,8 @@ static void __init tsc_enable_sched_clock(void)
 
 void __init tsc_early_init(void)
 {
+	unsigned int known_tsc_khz = 0;
+
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
 	/* Don't change UV TSC multi-chassis synchronization */
@@ -1510,9 +1513,19 @@ void __init tsc_early_init(void)
 		return;
 
 	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		snp_secure_tsc_init();
+		known_tsc_khz = snp_secure_tsc_init();
 
-	if (!determine_cpu_tsc_frequencies(true))
+	/*
+	 * Ignore the user-provided TSC frequency if the exact frequency was
+	 * obtained from trusted firmware, as the user-provided frequency is
+	 * intended as a "starting point", not a known, guaranteed frequency.
+	 */
+	if (!known_tsc_khz)
+		known_tsc_khz = tsc_early_khz;
+	else if (tsc_early_khz)
+		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware.\n");
+
+	if (!determine_cpu_tsc_frequencies(true, known_tsc_khz))
 		return;
 	tsc_enable_sched_clock();
 }
@@ -1533,7 +1546,7 @@ void __init tsc_init(void)
 
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
-		if (!determine_cpu_tsc_frequencies(false)) {
+		if (!determine_cpu_tsc_frequencies(false, 0)) {
 			mark_tsc_unstable("could not calculate TSC khz");
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


