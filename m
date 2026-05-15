Return-Path: <linux-hyperv+bounces-10928-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC5QK4NyB2pX3wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10928-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:22:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F7F556B4D
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 473ED306127F
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66FF391E5C;
	Fri, 15 May 2026 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUNBfaUF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D7389116
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872832; cv=none; b=XKlArVgyWNSDzYXUvz25fDV5aeHzmLXXNiQbS/nP9oOf4upVjj67H7g27ZWDo2wZ5VQYNoMmdttpYKDIYGLawoB8M6JHfGngIshHb6WQncXDjZTF/o9A7MFS+pIgOY2w6PK/sen7Hf9fz/ITqO/aEyAMX3p00Cxm9kp/eOU5mz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872832; c=relaxed/simple;
	bh=a/C0vtyL90QijKFqEXuRoJ0Idw3MprCujvV9iw9j0eQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYKIEz+VLZ+25Lu463aaLLRuYAqUkqWaJ+yPHjNfeDoW8d0PDU5S2F/r/V8gdhxfH5IPzNJL2H2I5h25nbZ7+4hAxff88muatq9KJCw+u3gwFVcH6WkurCuxqrCI7ilt68xPoKphPy89H+u2pM3yGK7/w2MyU83ZwpDTJZvbNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUNBfaUF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2babbeff9e4so1100175ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872830; x=1779477630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYn60803QiVrZ6qwk1MLFZ7C4I/KRQoL9rhTP31HXeM=;
        b=qUNBfaUFBLy01At/mUS2IuuY0gC46ykaeHerlZHtMOa2zpyVD/cBBROYKAkiCfNtvA
         kX4VF5wBTQaeD6CPEb0Abqbx5mSCSC+1DXue1wsBt0IHmvu6wSvzLCHEZeux3ol17JAj
         X3elnEXnBglwocuVQ+DOlX0FAcE4BNUd8K6/MA/SR4lY0WYYVRfkNgnOEu11XqtiRtYp
         +cUonqlLlD7I+yWq4wXl8k7Xf74Z/Q/EfXQ6rzxP/UDLb+xqK+oPaCmTkavSYJ2aRPTS
         yJmFovltkNEsA9U5JuVyszX02JeckqqUzXhjY6eJnoH4IEkOCLlQbo+pTs6gSNEje+MK
         5mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872830; x=1779477630;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uYn60803QiVrZ6qwk1MLFZ7C4I/KRQoL9rhTP31HXeM=;
        b=oVg/t6z2D/vz2Wwp20axlRacqJU5yRLUrwDVS/SJ+A/2UKBwqzHWJ582vSUwh1pYPq
         hwlMQeP07MP96bd3slPapIvnCKGIi/PFZjtPoeFPi8Q3BSmzPM8NFCR8aMYfEffl4dPS
         zCjN6yPhU0WpBlp5h7RBk0ThLDvYfW3Xq1A1KZZjdt8wScN42eUlymUz3KD6hUOy6zOI
         rQuEHbOot70N/r1HyS2tUTjXFAbf4QMJh7lpioqTr6AoR9YlTd+kyK/mlLNPIG8kz9Sv
         BV3Qfcwhtc6y3cCiHPwb83DOZfRGwBiWlRtXU0BHeVWhuMsitXPANX0R/uNc0n3MxpfZ
         SC7w==
X-Forwarded-Encrypted: i=1; AFNElJ+2yrwIolciKYUNq5HHhoW+q74wg6G1nSEbwqwLPkiwNflGyGtNfrhgKA2+Vhb8UgvRMG5DRPhzKWeplB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AnUEQZaYINqD68DOJi63t864aLvjflo8O5H56ct/worIGxq/
	UZHEJzlwS51t7C2LogXAI0YNzSN5SF5FxYXbVGA96FMGpx9OcXaakHvCe8XnjJHVV/cXAqsSr+Z
	a6NjBSQ==
X-Received: from plkj6.prod.google.com ([2002:a17:902:6906:b0:2bd:a0e6:1a81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3843:b0:2b0:6068:4c5f
 with SMTP id d9443c01a7336-2bd526ed865mr87328355ad.8.1778872829653; Fri, 15
 May 2026 12:20:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:06 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-6-seanjc@google.com>
Subject: [PATCH v3 05/41] x86/tdx: Override PV calibration routines with
 CPUID-based calibration
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
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 48F7F556B4D
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
	TAGGED_FROM(0.00)[bounces-10928-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email];
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

When running as a TDX guest, explicitly override the TSC frequency
calibration routine with CPUID-based calibration instead of potentially
relying on a hypervisor-controlled PV routine.  For TDX guests, CPUID.0x15
is always emulated by the TDX-Module, i.e. the information from CPUID is
more trustworthy than the information provided by the hypervisor.

To maintain backwards compatibility with TDX guest kernels that use native
calibration, and because it's the least awful option, retain
native_calibrate_tsc()'s stuffing of the local APIC bus period using the
core crystal frequency.  While it's entirely possible for the hypervisor
to emulate the APIC timer at a different frequency than the core crystal
frequency, the commonly accepted interpretation of Intel's SDM is that APIC
timer runs at the core crystal frequency when that latter is enumerated via
CPUID:

  The APIC timer frequency will be the processor=E2=80=99s bus clock or cor=
e
  crystal clock frequency (when TSC/core crystal clock ratio is enumerated
  in CPUID leaf 0x15).

If the hypervisor is malicious and deliberately runs the APIC timer at the
wrong frequency, nothing would stop the hypervisor from modifying the
frequency at any time, i.e. attempting to manually calibrate the frequency
out of paranoia would be futile.

Deliberately leave the CPU frequency calibration routine as is, since the
TDX-Module doesn't provide any guarantees with respect to CPUID.0x16.

Opportunistically add a comment explaining that CoCo TSC initialization
needs to come after hypervisor specific initialization.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/tdx/tdx.c    | 30 +++++++++++++++++++++++++++---
 arch/x86/include/asm/tdx.h |  2 ++
 arch/x86/kernel/tsc.c      |  8 ++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 29b6f1ed59ec..26890cea790b 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+#include <asm/apic.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -1123,9 +1124,6 @@ void __init tdx_early_init(void)
=20
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
=20
-	/* TSC is the only reliable clock in TDX guest */
-	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-
 	cc_vendor =3D CC_VENDOR_INTEL;
=20
 	/* Configure the TD */
@@ -1195,3 +1193,29 @@ void __init tdx_early_init(void)
=20
 	tdx_announce();
 }
+
+static unsigned long tdx_get_tsc_khz(void)
+{
+	struct cpuid_tsc_info info;
+
+	if (WARN_ON_ONCE(cpuid_get_tsc_freq(&info)))
+		return 0;
+
+	lapic_timer_period =3D info.crystal_khz * 1000 / HZ;
+
+	return info.tsc_khz;
+}
+
+void __init tdx_tsc_init(void)
+{
+	/* TSC is the only reliable clock in TDX guest */
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
+	/*
+	 * Override the PV calibration routines (if set) with more trustworthy
+	 * CPUID-based calibration.  The TDX module emulates CPUID, whereas any
+	 * PV information is provided by the hypervisor.
+	 */
+	tsc_register_calibration_routines(tdx_get_tsc_khz, NULL);
+}
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 15eac89b0afb..60deab0ed979 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -57,6 +57,7 @@ struct ve_info {
 #ifdef CONFIG_INTEL_TDX_GUEST
=20
 void __init tdx_early_init(void);
+void __init tdx_tsc_init(void);
=20
 void tdx_get_ve_info(struct ve_info *ve);
=20
@@ -78,6 +79,7 @@ void __init tdx_dump_td_ctls(u64 td_ctls);
 #else
=20
 static inline void tdx_early_init(void) { };
+static inline void tdx_tsc_init(void) { }
 static inline void tdx_halt(void) { };
=20
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return fals=
e; }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 243999692aea..e00f53e3dd8d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -34,6 +34,7 @@
 #include <asm/topology.h>
 #include <asm/uv/uv.h>
 #include <asm/sev.h>
+#include <asm/tdx.h>
=20
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -1559,8 +1560,15 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
=20
+	/*
+	 * Do CoCo specific "secure" TSC initialization *after* hypervisor
+	 * platform initialization so that the secure variant can override the
+	 * hypervisor's PV calibration routine with a more trusted method.
+	 */
 	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
 		snp_secure_tsc_init();
+	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		tdx_tsc_init();
=20
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
--=20
2.54.0.563.g4f69b47b94-goog


