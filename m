Return-Path: <linux-hyperv+bounces-11749-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yTJSEnFxRWpFAQsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11749-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:58:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7406F132D
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:58:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="lS9P9/vM";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11749-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11749-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB4731DC042
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8491412273;
	Wed,  1 Jul 2026 19:32:55 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68B4EA368
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934375; cv=none; b=oYYYt0Kvlh79BqSGbS5VAEug2AQbMPr/VdhlXZq36CFdiTo8kWOuPGdPx5LxTOgptyDr09CHcXjcvYZcvk1ue/IVxhL0jbR1JQllLHaQOT9VbXP+mEI5MacNqieXig+o9oN3YwruDHtNB/SbdTQH1KN+qhTUyCaSsVmgxULRmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934375; c=relaxed/simple;
	bh=Uu0k+yL30vMc62159eEgoszSNDN6Z8sh7pCxUk/baoA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t+IkHuWhoZpSHNXLcepU8i9iiv2uFeFhsTLsDnu2ljCGa2lvsGzgE3j/I0q7/F9pU08VKEm4YnPXem1caYZGEvfItlnd7EO4K6f9INHNwD1F1dhXmpyDSXsWWPJ4hUVxyAhBTiW7KTe1Vjx3TlbGOe92GMF4snq//nfJf8/KZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lS9P9/vM; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8895156101so863299a12.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934372; x=1783539172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK4DO2yTgoTSHNgYS/yt/30ZUc46SVmXG9Yy1qokrf0=;
        b=lS9P9/vM5micPWyAhGjEPBMvhD5gN1BGM+5PMW65A7MKZL6PcM/yBcc+OzlyJWOlMM
         08Pn2PESpBYku/K4CczQL77iL2RoMRKkaie05m7xC0xQef+bZ+SakdXT28PHLi7ovW6z
         EeXkG0bgyjSLW2pEWo3Co44CtWcvDJoEG9tDmG+QiOxm7MjCE703+ntAHVP/wbAIM7c1
         nFG8dBjOPULFfXv7oAKxSP6uxO7GjToGajs54szog9z6EOfBdW0x77aT4w048/zjjOSP
         n3MuxN2wu4OMAeLjz7csy0G8MFl/LxjoE2wV9Y3WTLzvAwcTgHrxArVWHJbXoCSVEfY1
         ABCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934372; x=1783539172;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YK4DO2yTgoTSHNgYS/yt/30ZUc46SVmXG9Yy1qokrf0=;
        b=qmpy31Ajoc6rRBHjF0HJPu48q1uA07GUEkc499qFPUq9YOu8nLBBEX/bcAxrYuHkU0
         qiPi/Zb7dzVtLyRwqpKlvwX65n0KXoJbQZCW7Wuvlbu2I3CrJoMHOaZobxHWo8fbbt5v
         9WzZ+uf3zvaJQK4zBwxU64SJEk35qB9Tzj4j+h3N5keCwuWfnyKTDo9TqnvCWqsyiYp2
         yuynsBdAXfNyzdl6/sBewp02ahm1Fh4swWns/mfDeanA+9glZ9+FNqBDSYrsFQKx7U79
         rIS6fDhKod3uwBReC7XxEC5I+Uy6LaO1dpG2TnRJgEXjvQ54w9axZ7Ne0w0LMVZ+bjZk
         jtiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C/2YRcHPOzc4ehEiYx8RJNJLIjrDsL3wowmra0o+qJjRwi+tlowMOsnexqHgxTsYtlN7Bt5cCXKHsWSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5lfaXDVv2dJM6Lrpdh1tofp5VL4a3pn1zzodeZOg9D9Ppi/t
	0B05Ri2Hmq0mE9bsRa9DKqg4t1JWaSTWEg/SLTFB9H1Bmv40mJc3Ils9W4qF+8UosHDf/7iqjHB
	Hr+sr8w==
X-Received: from pgam28.prod.google.com ([2002:a05:6a02:2b5c:b0:c96:bec2:5af7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7486:b0:3b4:65ac:e2e6
 with SMTP id adf61e73a8af0-3bfed362212mr3320468637.36.1782934371539; Wed, 01
 Jul 2026 12:32:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:42 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-22-seanjc@google.com>
Subject: [PATCH v5 21/51] x86/kvm: Obtain TSC frequency from PV CPUID if present
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
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lkml.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amazon.co.uk:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11749-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F7406F132D

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
index 29ca37e9a3bc..f55d0305d1f3 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -342,8 +342,10 @@ void __init kvmclock_init(void)
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
2.55.0.rc0.799.gd6f94ed593-goog


