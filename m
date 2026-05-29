Return-Path: <linux-hyperv+bounces-11328-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM6IJiOoGWoIyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11328-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:52:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F01603FCF
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD4A430E7509
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603903F4122;
	Fri, 29 May 2026 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzER2GmV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76573F1AA8
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065902; cv=none; b=I3ylqHFHA83DtzvE/OmHz1BINtkUDcz4AnZQ2UGkxZOuDmq58mQbqkQGHemrd2vrPld8yaReoXPqkeqFvfsjTUoIhQ3pUBJ2NLUvWu1/FZsQwvOCDrHVLyBpOcc/zWChO3Or8GHs5C199sACRfTG01EWOfX2elRcmbIgXvo4lc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065902; c=relaxed/simple;
	bh=zdJO+zZEzsLby2yiiaTorWcznz9CLqIQq6bb6Lyhy/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KWThukpAnQ4kPoWeuWHNSiWq7FrZ6HD5Mt8xhJqk5EHDWEi8oZTRQojMfLC127EFGnajfeWE0DFzR6m8LoGOVsRfZDx3Q65E4zroeBWL8KwXKiY3E4w3n7N25OEGsnUAfekbvrXT2p+b36fj6XJk+YS5EfE7KGeppTao+1UQR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzER2GmV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso104583235ad.1
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065899; x=1780670699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fwFQzI2jeVi8q9emUB9u5qsW4Gj215t9UPhq3t/oEkw=;
        b=gzER2GmVZz5VH4DkuV4aq5aIIqKCatiTUK1xuGH/zTy8jeXuYTKlkmjCnKFJwWhWJk
         /vgtpNzlhj7OI0SUNdBiyeWE1sT/cJcD+sTQNZc9lpHCCmZ2Px31JPYH5eVUP4MBwN8f
         5LfpkTd8qOxchVTYBfZO6pHlZMMhh7Qhc5KbqH1bQu3WAgRjNVNnUqQQxSiLm8jElzTW
         bKluUVAMKnVfCx6xP9bkPUt0/bvKHUeY/oirC9h2JerzhpBWgdvWsUylPZbIBK/oCp5h
         2Vbwo4gHktOTb5EdshO+EEFQZr1BVc7+01V2IVoUoGINDe4ZKkyDvPnwqq72od041Axh
         xIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065899; x=1780670699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwFQzI2jeVi8q9emUB9u5qsW4Gj215t9UPhq3t/oEkw=;
        b=Xe5z/P6E/jQguYfuKUUyuv5IfZPb/k4yWbefCAvF/Z0Hq6fNghNouu1Rdy2m7OHPSP
         4zYEzcJPITxdQgZOGPpuYv/4gXSrt6bt77RQnCUy/YGpSK1CVgs9AT3MyXA9WluN3Z9d
         6yI+7WqBp+D9saBR08b7nKhDf+HOjxqpBfMgEHOB/YuWrGQdYNh8A8wPAWd5L23i2f3P
         cpnW53/eKlQW2g0ixLPMfOIQ9klBMC5IzCHBYMuWJD9pGKuu8lbK1WPouaXzxILVzj8G
         k0uRVmftk5CsEngIFk4cjfgxWmPVf8mdiCCL0MVckuuJo8GpLlY8XJd2iUy7Kjjnkfu2
         fnDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9udRY3uNoo/xFZ5b0zEkbOUvJEOc/fspSFApiU8LB4snr5A4GYHc6kuci8mhmr6qtdVa+pS+LvuhgqVJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmSzkyIS1M69bUTIuTFjwC4VCyz8Rjx0CC9MMR0oSNVHOEGls
	y0nZLqN4bfUhsArzVQIE1s7G1fvOdZMKonZydGfxS7dbwsHQDaI3ALPQhZi0iW0F+ssgG/9Q2Z9
	zzBnz0A==
X-Received: from plble15.prod.google.com ([2002:a17:902:fb0f:b0:2bf:aa7:47b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94c:b0:2b0:bebb:1081
 with SMTP id d9443c01a7336-2bf368698abmr864185ad.28.1780065898563; Fri, 29
 May 2026 07:44:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:53 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-7-seanjc@google.com>
Subject: [PATCH v4 06/47] x86/sev: Shove SNP's secure/trusted TSC frequency
 directly into "calibration"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11328-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 74F01603FCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

While it's rather weird, deliberately prioritize tsc_early_khz over all
else to maintain existing behavior.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c   | 14 ++++----------
 arch/x86/include/asm/sev.h |  4 ++--
 arch/x86/kernel/tsc.c      | 19 ++++++++++++-------
 3 files changed, 18 insertions(+), 19 deletions(-)

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
index 833eed5c048a..2b8f94c3fcc7 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1474,15 +1474,16 @@ static int __init init_tsc_clocksource(void)
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
@@ -1537,16 +1538,20 @@ static void __init tsc_enable_sched_clock(void)
 
 void __init tsc_early_init(void)
 {
+	unsigned int known_tsc_khz = 0;
+
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
 	/* Don't change UV TSC multi-chassis synchronization */
 	if (is_early_uv_system())
 		return;
 
-	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		snp_secure_tsc_init();
+	if (tsc_early_khz)
+		known_tsc_khz = tsc_early_khz;
+	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		known_tsc_khz = snp_secure_tsc_init();
 
-	if (!determine_cpu_tsc_frequencies(true))
+	if (!determine_cpu_tsc_frequencies(true, known_tsc_khz))
 		return;
 	tsc_enable_sched_clock();
 }
@@ -1567,7 +1572,7 @@ void __init tsc_init(void)
 
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
-		if (!determine_cpu_tsc_frequencies(false)) {
+		if (!determine_cpu_tsc_frequencies(false, 0)) {
 			mark_tsc_unstable("could not calculate TSC khz");
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
-- 
2.54.0.823.g6e5bcc1fc9-goog


