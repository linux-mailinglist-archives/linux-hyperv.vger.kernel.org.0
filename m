Return-Path: <linux-hyperv+bounces-10925-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIucETpyB2qd3wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10925-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:21:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A0556AF6
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B51B3016808
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFCD3803D4;
	Fri, 15 May 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCU8xqOk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0951F3B8A
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872829; cv=none; b=m6qSkBKIDVEFzvgxrIQbZGOBddmbRQPBj8dTFXxPTfWuVhA2ui1VN6Q+u7uJoD13HyUejLGaFNFuY0SeFW6wDrlSnMprYioxpU3Vpo9Tv13ErDweZHj4ChDkqZPbzmziJB73ryDugbXLVdQ12tUcUN/OLINHelgGG4NSCp7jun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872829; c=relaxed/simple;
	bh=t6/pbTUbmip8SEjdYzshXakw7OlEqETJaOfJu557UMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NoxT+U3AXHKhBk+sYz7vzH06LWFwJ+PnnVPCrYFBvmzz/UT/ECC0E42p6muJfDo3nx0tzoqGhiuhvWZhm2J4UPQ6Tz9KcMmdkSLfgAzzoLdaXLIKCMkKXzN0JU7qYopX0VjEBHkPEarUZh5wdDXUrlNauGIbKj0zkTFd1MUzjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCU8xqOk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b9fe2d6793so5567085ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872826; x=1779477626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4uXjPuEkhteosgn8xfkxRem+kth4PBQNYWCq/GT/iNY=;
        b=SCU8xqOkhpgm32xDP67rV5Xqp/yhtpMCLs3EedQ+/79fs59dRZrJM1XS7YY3a672NU
         ctXoyF0Not9zLs65ugCps9a1G8yainjjE0c1TDOpabCt7wb8lVtPbRjbCnUDKwy0EW6I
         5nJuZ/hn2RpBe/mfMQkBCnlNJ3WQphvQGc25BoLTjtXdNCbxO75sG/XzJvXFp2ZcEdYj
         sT7NAYvB4mjsLM/sfUa0n3zVCO4sxgOa6euEDifM8maFT6N68TFetZHQlslML+PHCQt1
         f7IsNwmTmztmQ5bci5OxancG5pAsw6KbML7XKj8JXiKg3MZlSr6nKxjQoM5SsW3F7EfU
         CT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872826; x=1779477626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uXjPuEkhteosgn8xfkxRem+kth4PBQNYWCq/GT/iNY=;
        b=UzQ+ZfAmw45hfGeOWWFP1NZYLlXTvNXM7G/8rwYwBex7hGSmCleg7TVRSP2Rc2udGq
         oIyRR+NjCL0N8i193qTruDW9vxP0vaMXU+IUxsocFJxVETTgGlUnoLSU5e9V2E68gd6/
         6Wlr7y/SJL1ha95dq0x5hVz4QtkyNBzkplMZ3dVrq9h069ffIcY2urY5zvmXxYgFG9zS
         UGABojESN/PWgzGFwMuPoABFEPoAvZNDPGCZXQViVKlpSarTLOqhG5zO29erl9wPVqbe
         4mmU5C7SxDoW8hktCZM68QsuQ8vCe4kgnaKBAfP8p8WkE2YMlPOQQLmyRq4VFbTPYv9l
         Ogtg==
X-Forwarded-Encrypted: i=1; AFNElJ++WEKl28/nuS9vfLES19LNlXRMOqxKK3moI7BPlUyWSVqUJ7hJeBHl57hcG3oNsw6ay9lnJeCvLG/Rn1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuEyo/dTef3ZfEFIjnntysZPZLbzq0a/ew2plI12FGjcxiiCOo
	peSpQZWHI72+sAx0H3Nl8PqhXB21EO7KB2v1AwwlA+jEbfsRbzN+qqn2brY5C3Y9RDQQLST7Pd2
	JA3H5/g==
X-Received: from pgno7.prod.google.com ([2002:a63:7e47:0:b0:c79:788d:5b72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e097:b0:39f:8c23:34c6
 with SMTP id adf61e73a8af0-3b22ecedb15mr6528440637.35.1778872826182; Fri, 15
 May 2026 12:20:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:03 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-3-seanjc@google.com>
Subject: [PATCH v3 02/41] x86/tsc: Add helper to register CPU and TSC freq
 calibration routines
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
X-Rspamd-Queue-Id: B07A0556AF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10925-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Add a helper to register non-native, i.e. PV and CoCo, CPU and TSC
frequency calibration routines.  This will allow consolidating handling
of common TSC properties that are forced by hypervisor (PV routines),
and will also allow adding sanity checks to guard against overriding a
TSC calibration routine with a routine that is less robust/trusted.

Make the CPU calibration routine optional, as Xen (very sanely) doesn't
assume the CPU runs as the same frequency as the TSC.

Wrap the helper in an #ifdef to document that the kernel overrides
the native routines when running as a VM, and to guard against unwanted
usage.  Add a TODO to call out that AMD_MEM_ENCRYPT is a mess and doesn't
depend on HYPERVISOR_GUEST because it gates both guest and host code.

No functional change intended.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c       |  4 ++--
 arch/x86/include/asm/tsc.h     |  4 ++++
 arch/x86/kernel/cpu/acrn.c     |  4 ++--
 arch/x86/kernel/cpu/mshyperv.c |  3 +--
 arch/x86/kernel/cpu/vmware.c   |  4 ++--
 arch/x86/kernel/jailhouse.c    |  4 ++--
 arch/x86/kernel/kvmclock.c     |  4 ++--
 arch/x86/kernel/tsc.c          | 17 +++++++++++++++++
 arch/x86/xen/time.c            |  2 +-
 9 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 7ed3da998489..d27cf8f8b025 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2048,8 +2048,8 @@ void __init snp_secure_tsc_init(void)
 
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
-	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
-	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
+	tsc_register_calibration_routines(securetsc_get_tsc_khz,
+					  securetsc_get_tsc_khz);
 
 	early_memunmap(mem, PAGE_SIZE);
 }
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 0c57fadc4a39..bae709f5f44d 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -94,6 +94,10 @@ extern int cpuid_get_tsc_freq(struct cpuid_tsc_info *info);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
+#if defined(CONFIG_HYPERVISOR_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
+extern void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(void),
+					      unsigned long (*calibrate_cpu)(void));
+#endif
 extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 2c5b51aad91a..c1506cb87d8c 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -29,8 +29,8 @@ static void __init acrn_init_platform(void)
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 
-	x86_platform.calibrate_tsc = acrn_get_tsc_khz;
-	x86_platform.calibrate_cpu = acrn_get_tsc_khz;
+	tsc_register_calibration_routines(acrn_get_tsc_khz,
+					  acrn_get_tsc_khz);
 }
 
 static bool acrn_x2apic_available(void)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 640e6b223c2d..8d2401be420c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -573,8 +573,7 @@ static void __init ms_hyperv_init_platform(void)
 
 	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
-		x86_platform.calibrate_tsc = hv_get_tsc_khz;
-		x86_platform.calibrate_cpu = hv_get_tsc_khz;
+		tsc_register_calibration_routines(hv_get_tsc_khz, hv_get_tsc_khz);
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 34b73573b108..b88d9ca01202 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -419,8 +419,8 @@ static void __init vmware_platform_setup(void)
 		}
 
 		vmware_tsc_khz = tsc_khz;
-		x86_platform.calibrate_tsc = vmware_get_tsc_khz;
-		x86_platform.calibrate_cpu = vmware_get_tsc_khz;
+		tsc_register_calibration_routines(vmware_get_tsc_khz,
+						  vmware_get_tsc_khz);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index f58ce9220e0f..db8f31fdb480 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -210,8 +210,6 @@ static void __init jailhouse_init_platform(void)
 	x86_init.mpparse.parse_smp_cfg		= jailhouse_parse_smp_config;
 	x86_init.pci.arch_init			= jailhouse_pci_arch_init;
 
-	x86_platform.calibrate_cpu		= jailhouse_get_tsc;
-	x86_platform.calibrate_tsc		= jailhouse_get_tsc;
 	x86_platform.get_wallclock		= jailhouse_get_wallclock;
 	x86_platform.legacy.rtc			= 0;
 	x86_platform.legacy.warm_reset		= 0;
@@ -221,6 +219,8 @@ static void __init jailhouse_init_platform(void)
 
 	machine_ops.emergency_restart		= jailhouse_no_restart;
 
+	tsc_register_calibration_routines(jailhouse_get_tsc, jailhouse_get_tsc);
+
 	while (pa_data) {
 		mapping = early_memremap(pa_data, sizeof(header));
 		memcpy(&header, mapping, sizeof(header));
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index b5991d53fc0e..e9e7394140dd 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -321,8 +321,8 @@ void __init kvmclock_init(void)
 	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
 
-	x86_platform.calibrate_tsc = kvm_get_tsc_khz;
-	x86_platform.calibrate_cpu = kvm_get_tsc_khz;
+	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz);
+
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
 #ifdef CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f92236f40cbc..7e639c0a94a2 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1281,6 +1281,23 @@ static void __init check_system_tsc_reliable(void)
 		tsc_disable_clocksource_watchdog();
 }
 
+/*
+ * TODO: Disentangle AMD_MEM_ENCRYPT and make SEV guest support depend on
+ *	 HYPERVISOR_GUEST.
+ */
+#if defined(CONFIG_HYPERVISOR_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
+void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(void),
+				       unsigned long (*calibrate_cpu)(void))
+{
+	if (WARN_ON_ONCE(!calibrate_tsc))
+		return;
+
+	x86_platform.calibrate_tsc = calibrate_tsc;
+	if (calibrate_cpu)
+		x86_platform.calibrate_cpu = calibrate_cpu;
+}
+#endif
+
 /*
  * Make an educated guess if the TSC is trustworthy and synchronized
  * over all CPUs.
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index d62c14334b35..3d3165eef821 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -569,7 +569,7 @@ static void __init xen_init_time_common(void)
 	static_call_update(pv_steal_clock, xen_steal_clock);
 	paravirt_set_sched_clock(xen_sched_clock);
 
-	x86_platform.calibrate_tsc = xen_tsc_khz;
+	tsc_register_calibration_routines(xen_tsc_khz, NULL);
 	x86_platform.get_wallclock = xen_get_wallclock;
 }
 
-- 
2.54.0.563.g4f69b47b94-goog


