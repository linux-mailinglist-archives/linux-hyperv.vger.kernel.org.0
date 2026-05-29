Return-Path: <linux-hyperv+bounces-11338-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF6GHEupGWomyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11338-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:57:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D33604166
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6134308EDD0
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65B3FE37C;
	Fri, 29 May 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0MNStYO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBBE3EDADC
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065914; cv=none; b=ECzOACNbXGA4HqdHPxxlomcEu0K5xe4UyzleLu71cbpb5M9r+QEh5vVztQKesAPcCQQZ1vK4wyEfqeNt/Q6kX8BvwiazzOPfr6RkvGtJA4X7psvSg1p8ofQ9ckxlG51PxtvtxfKdPy2HFe5g8pQEAABLIf/ld06ZmRPPpdHQOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065914; c=relaxed/simple;
	bh=367+/Zpr6KHk7eYYDaXSVUgo5iAHZwFbHGvXpB65Nmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aFS04Hff8+YJ9eyTWYvjIHo9ClbEt++/DCvVWiwToW4uNywCFtKvkwkQ1XrKHNrC95on/MxfBCFNq5LtSurpeU2SjO4I1HIudQ/w7GR3AU5j8gNToySklFlIWFYliU1vTdmbAk7GDVPdxhjMCftO8TYuG07mV8IbbAa2obaYssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0MNStYO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf08c2a24bso22524125ad.2
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065911; x=1780670711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoqgLgRaMBwMlzlRb5ZdKmNASLSl22kGdknpkiNEuDA=;
        b=t0MNStYOFi6pd8H6B3F0StVdV68M8/rV+cumiWC1Bs2oN6gXcgUzUCHT0VWjKAi7t+
         CHwNWWH0qkdyv0tLtZzW8iSTolwJlDS93NMoEu6sD3Zb7f3vTL7H4dTHkHdLvCHGP12m
         3wGK8EWSpmJNhakcIOd+YEQ6bl0G5B84Az6wNyA/lkyzqkQjdmRTUl1fgS97bQwNFhWp
         CDSKdm8VO7FWvL/y8d+UC+2UEbGWqVaCfseYJ7k+2wIrFB3sy0+R2w1sBrfz3aNzOutb
         9i6V7K2JzEU5Cdv+UEqoV2fwJy29pvpz0gni95EVqS4Z9ffpq2da1D+jvvNQhFmKwFSG
         smJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065911; x=1780670711;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FoqgLgRaMBwMlzlRb5ZdKmNASLSl22kGdknpkiNEuDA=;
        b=XWymQeX4Hpj8VtqZTd5gJVYLzw3D8yAcnWVrr13GKcZjeykSzJu1zrKC/ChtuYJVtd
         YlSv+z8CcRwPkn0GlJ9asvs+o8C9VBAK4uItDSYCm0Lsy2XQbBn84K03+Egc9ganUjJp
         F6BJCc/wFh3cSVb/bkAMiMZ0OSU+b4lbYCpPDoH90WgFEpBf7Oez4WohHPJibNjn5TtS
         dQ8QAyMtJEmP2cJ48KSUuESHiBCXqLkEMsruMlbHR8fx2lEJYB+o5d3RWu5SxUn2PYe/
         mU6gmNnF6vZWqNRyi083KhkwXkzOh+O15ZieILIm0pIqlPO7nAHJTrvJYAQY8sEJz5j+
         B3iQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KPdPe/5EqZkwN4nCHY9jXo86Lbz4vOtFr2VCDYJh/F/3TF68NbmZkFk8ZfoEj72AnmRNe3JOiDktiuvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuo7YL5eTHazI+7kCIg9yu7qiAWPIoaBI9KPj/N1NI/zA0elB7
	c3CSB3DQowvJnLclkkp7riRK7qJVNnztMwenDNFgptAErApm7CYioTiJI+ET2vSiZSe5doEk3ks
	ZNJ3qLw==
X-Received: from plbjh24.prod.google.com ([2002:a17:903:3298:b0:2bf:14c9:866d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c2:b0:2bf:2589:7bc2
 with SMTP id d9443c01a7336-2bf367d3ab7mr1162735ad.15.1780065910985; Fri, 29
 May 2026 07:45:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:03 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-17-seanjc@google.com>
Subject: [PATCH v4 16/47] x86/kvm: Obtain TSC frequency from PV CPUID if present
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
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-11338-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lkml.org:url,amazon.co.uk:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 11D33604166
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

In https://lkml.org/lkml/2008/10/1/246 a proposal was made for generic
CPUID conventions across hypervisors. It was mostly shot down in flames,
but the leaf at 0x40000010 containing timing information didn't die.

It's used by XNU and FreeBSD guests under all hypervisors=C2=B9=C2=B2 to de=
termine
the TSC frequency, and also exposed by the EC2 Nitro hypervisor (as
well as, presumably, VMware). FreeBSD's Bhyve is probably just about
to start exposing it too.

Use it under KVM to obtain the TSC frequency more accurately, instead of
reverse-calculating the frequency from the mul/shift values in the KVM
clock.  Use the information to get the CPU frequency as well (kvmclock
feeds in kvm_get_tsc_khz() for both TSC and CPU calibration), as the info
from CPUID is superior in every way; whether or not kvmclock should be
overriding CPU calibration in the first place is an entirely different
question.

Use the info from CPUID even if the user explicitly disables kvmclock, or
if it's unsupported.  The PV CPUID leaf has no dependency on kvmclock, and
is in fact more useful if kvmclock is disabled since the kernel won't be
able to use kvmclock to derive a derive the TSC frequency.

Before:
[    0.000020] tsc: Detected 2900.014 MHz processor

After:
[    0.000020] tsc: Detected 2900.015 MHz processor

$ cpuid -1 -l 0x40000010
CPU:
   hypervisor generic timing information (0x40000010):
      TSC frequency (Hz) =3D 2900015
      bus frequency (Hz) =3D 1000000

Note!  *Independently* query for non-null get_{cpu,tsc}_khz() overrides so
that kvmclock doesn't clobber x86_init.hyper.get_cpu_khz() if/when KVM adds
support for getting the CPU frequency separately from the TSC frequency.

=C2=B9 https://github.com/apple/darwin-xnu/blob/main/osfmk/i386/cpuid.c
=C2=B2 https://github.com/freebsd/freebsd-src/commit/4a432614f68

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c      | 33 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/kvmclock.c |  6 ++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index dcef84da304b..909d3e5e5bcd 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -49,6 +49,8 @@
 #include <asm/svm.h>
 #include <asm/e820/api.h>
=20
+static unsigned int kvm_tsc_khz_cpuid __initdata;
+
 DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
=20
 static int kvmapf =3D 1;
@@ -911,6 +913,21 @@ bool kvm_para_available(void)
 }
 EXPORT_SYMBOL_GPL(kvm_para_available);
=20
+static u32 __init kvm_cpuid_timing_info_leaf(void)
+{
+	u32 base =3D kvm_cpuid_base();
+
+	if (!base || cpuid_eax(base) < (base | KVM_CPUID_TIMING_INFO))
+		return 0;
+
+	return base | KVM_CPUID_TIMING_INFO;
+}
+
+static unsigned int __init kvm_get_tsc_khz(void)
+{
+	return kvm_tsc_khz_cpuid;
+}
+
 unsigned int kvm_arch_para_features(void)
 {
 	return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_FEATURES);
@@ -960,6 +977,7 @@ static void __init kvm_init_platform(void)
 		.mask_lo =3D (u32)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
 		.mask_hi =3D (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
+	u32 timing_info_leaf;
=20
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
 	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
@@ -1007,6 +1025,21 @@ static void __init kvm_init_platform(void)
 			wrmsrq(MSR_KVM_MIGRATION_CONTROL,
 			       KVM_MIGRATION_READY);
 	}
+
+	/*
+	 * If KVM advertises the frequency directly in CPUID, use that instead
+	 * of reverse-calculating it from the KVM clock data, or worse, trying
+	 * to calibratate the TSC using an emulated device.
+	 */
+	timing_info_leaf =3D kvm_cpuid_timing_info_leaf();
+	if (timing_info_leaf) {
+		kvm_tsc_khz_cpuid =3D cpuid_eax(timing_info_leaf);
+		if (kvm_tsc_khz_cpuid) {
+			x86_init.hyper.get_tsc_khz =3D kvm_get_tsc_khz;
+			x86_init.hyper.get_cpu_khz =3D kvm_get_tsc_khz;
+		}
+	}
+
 	kvmclock_init();
 	x86_platform.apic_post_init =3D kvm_apic_init;
=20
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index c4a782a0c903..404f60741aa8 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -320,8 +320,10 @@ void __init kvmclock_init(void)
 	flags =3D pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
=20
-	x86_init.hyper.get_tsc_khz =3D kvmclock_get_tsc_khz;
-	x86_init.hyper.get_cpu_khz =3D kvmclock_get_tsc_khz;
+	if (!x86_init.hyper.get_tsc_khz)
+		x86_init.hyper.get_tsc_khz =3D kvmclock_get_tsc_khz;
+	if (!x86_init.hyper.get_cpu_khz)
+		x86_init.hyper.get_cpu_khz =3D kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock =3D kvm_get_wallclock;
 	x86_platform.set_wallclock =3D kvm_set_wallclock;
 #ifdef CONFIG_X86_LOCAL_APIC
--=20
2.54.0.823.g6e5bcc1fc9-goog


