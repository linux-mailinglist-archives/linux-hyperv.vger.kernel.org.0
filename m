Return-Path: <linux-hyperv+bounces-11738-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pb3ILc1wRWoWAQsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11738-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:55:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 384856F1299
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:55:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NkHWJZZA;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11738-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11738-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33A4307CE1C
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E34DB54C;
	Wed,  1 Jul 2026 19:32:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2AB4D98E1
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934363; cv=none; b=X8AySPfzf+TJUiCyHFJmsJLLIsjgOO3Xsjvbk3hgrPLkNtg1HmGSEFSWBJGRoLa5z3JygW8pqrKg9SyjkxIQ5SYEFIDGOhaDBQ4PuudXw777St3jbBabq3K0qV4GfrUm0gUztTRc0uMj7Anl7bewmtY38+bu50ucpskAIPfPdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934363; c=relaxed/simple;
	bh=2jLs365s3w8BDnQY6NfYjlQLqeiijMlUXqB505qcFg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KY4HD8cxZxFNn5c++crrWTrgoMM0JS+lakQzrcp+r51za/nX4UmD1DuVEivzwHhYeuUe3QOWaI8bAoEijR6OmGUBH8u72dJ20UQeY3xmVo91GJh3T9pfMXzJSuCmkusqdE0rKu6Zy1z1/0DHerSTpe8/L+GKISBsuMByMtKs+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NkHWJZZA; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8620ee0971so942364a12.0
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934359; x=1783539159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ITMoYQtDH7A346RlpjwfIOo+apTMWXSUo7by9rtr/s0=;
        b=NkHWJZZAAcLhwpIlScPpXWYfwQXYGcSw1lJpf891nfDK5I2FZt2nPZQxUnmqms/9cp
         MvvrIdo5jYL7e2tT+L/+Wifv//DXLvoPKwWbAPRKVOpgGMbDRWcsj49hADNuKhsKt41N
         Z/RQrr5WxMQLIJq85COQWuXZFO7WHwfb6oAu3dJJAsEj+Yan/rTgTBkkzZjElHk29PFa
         20cThW1XzdhaqRxHkN+umolvevL4royu85Uw+pf3TACt92poKbYcMOA5Z79iiK5rhXL/
         IdNOGW/vCmUndWs155yYoMe2x/tLziaFi6tsLc9TnrtoRnB8a6E6NJL2qHUHGZF7vb+D
         5kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934359; x=1783539159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITMoYQtDH7A346RlpjwfIOo+apTMWXSUo7by9rtr/s0=;
        b=H1KB4NAAFXmJ9BljDpDgmq1Qyx+96w3dCjKe3UHJjCO5qbWx+E+sZTEGcd3UilJ315
         m8qh/qopo9K55dGYRQ4sNzi18tPRNLuXSMIdHJLE+Tikp6VJF6QX/StmtUUePPXFxAvQ
         pF6/SefdI8wry3YbjBSi7Q6bah2i/GrATS2RkGwsP6i/LjW1WVUnnHNPOW8RNsxpeObE
         z8wztHq02l0RT2FC/EJbrAaYNliA2F9fCKe12H6Rbbgw5GgPzyhQYotRPgUNugD4mn5k
         PoQvDkqxStGxmsamP49b4hnMojfS/pZgHN7smpvLbBbgsN28ZnRvBVfF9IksPKPdmA0A
         DeTA==
X-Forwarded-Encrypted: i=1; AFNElJ/fvfkXtI+k1z/RXjmU05PTkpmYCS2Jq1SklXETeXg/XtEvADObyXbITdRBZTg7UO+9f7rM290x/t9m+CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWDCujU4LxNULIrIb3czZSkYEJnMTHphakJvBd7en9Lm7a3k0
	VHxtTNP3a5vZvtWux+ONLsGbOCn/ucf3gEk3tw2296rYpaV6o00so9GrZNvWr1NW3GbwqiH1y0J
	dyAtjnQ==
X-Received: from pgaf14.prod.google.com ([2002:a63:380e:0:b0:c98:2639:852e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b93:b0:842:57e8:1bdb
 with SMTP id d2e1a72fcca58-847c07be445mr3013550b3a.20.1782934359203; Wed, 01
 Jul 2026 12:32:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:32 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-12-seanjc@google.com>
Subject: [PATCH v5 11/51] x86/tsc: Add dedicated hypervisor hooks for getting
 known TSC/CPU frequencies
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11738-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 384856F1299

Add dedicated hypervisor hooks for getting known TSC/CPU frequencies
instead of overriding seemingly generic platform hooks, and explicitly
priotize hypervisor-provided frequencies over native methods, but do NOT
clobber the frequency obtained from trusted firmware.  While shuffling the
hooks around is arguably "six of one, half dozen of the other", scoping
them to x86_hyper_init makes their purpose more obvious, and allows for
explicitly defining the priority of sources (as is done here).

As is already done when trusted firmware provides the TSC frequency, ignore
ignore tsc_early_khz if the exact TSC frequency was obtained from the
hypervisor, as attempting to refine the TSC frequency when running in a VM
is all but guaranteed to cause problems sooner or later due to the
calibration sources being emulated devices in the vast majority of setups.

Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +-
 arch/x86/include/asm/acrn.h                   |  5 ----
 arch/x86/include/asm/x86_init.h               |  4 +++
 arch/x86/kernel/cpu/acrn.c                    | 10 +++++--
 arch/x86/kernel/cpu/mshyperv.c                |  6 ++--
 arch/x86/kernel/cpu/vmware.c                  |  8 ++---
 arch/x86/kernel/jailhouse.c                   |  6 ++--
 arch/x86/kernel/kvmclock.c                    |  6 ++--
 arch/x86/kernel/tsc.c                         | 29 ++++++++++++++-----
 arch/x86/xen/time.c                           |  4 +--
 10 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 490e6aa72fc2..a387bb2c47e2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7948,7 +7948,8 @@ Kernel parameters
 
 			Note, tsc_early_khz is ignored if the TSC frequency is
 			provided by trusted firmware when running as an SNP or
-			TDX guest.
+			TDX guest, or when the hypervisor provides the exact
+			frequency via a paravirtual interface.
 
 	tsx=		[X86] Control Transactional Synchronization
 			Extensions (TSX) feature in Intel processors that
diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index db42b477c41d..a892179c61c6 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -32,11 +32,6 @@ static inline u32 acrn_cpuid_base(void)
 	return 0;
 }
 
-static inline unsigned long acrn_get_tsc_khz(void)
-{
-	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
-}
-
 /*
  * Hypercalls for ACRN
  *
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 953d3199408a..0c89bf40f507 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -123,6 +123,8 @@ struct x86_init_pci {
  * @msi_ext_dest_id:		MSI supports 15-bit APIC IDs
  * @init_mem_mapping:		setup early mappings during init_mem_mapping()
  * @init_after_bootmem:		guest init after boot allocator is finished
+ * @get_tsc_khz:		get the TSC frequency (returns 0 if frequency is unknown)
+ * @get_cpu_khz:		get the CPU frequency (returns 0 if frequency is unknown)
  */
 struct x86_hyper_init {
 	void (*init_platform)(void);
@@ -131,6 +133,8 @@ struct x86_hyper_init {
 	bool (*msi_ext_dest_id)(void);
 	void (*init_mem_mapping)(void);
 	void (*init_after_bootmem)(void);
+	unsigned int (*get_tsc_khz)(void);
+	unsigned int (*get_cpu_khz)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index dc119af83524..ad8f2da8003b 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -24,13 +24,15 @@ static u32 __init acrn_detect(void)
 	return acrn_cpuid_base();
 }
 
+static unsigned int __init acrn_get_tsc_khz(void)
+{
+	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
+}
+
 static void __init acrn_init_platform(void)
 {
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
-
-	x86_platform.calibrate_tsc = acrn_get_tsc_khz;
-	x86_platform.calibrate_cpu = acrn_get_tsc_khz;
 }
 
 static bool acrn_x2apic_available(void)
@@ -78,4 +80,6 @@ const __initconst struct hypervisor_x86 x86_hyper_acrn = {
 	.type			= X86_HYPER_ACRN,
 	.init.init_platform     = acrn_init_platform,
 	.init.x2apic_available  = acrn_x2apic_available,
+	.init.get_tsc_khz	= acrn_get_tsc_khz,
+	.init.get_cpu_khz	= acrn_get_tsc_khz,
 };
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 87beecec76f0..f9bc1c2d8c93 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -395,7 +395,7 @@ static int hv_nmi_unknown(unsigned int val, struct pt_regs *regs)
 }
 #endif
 
-static unsigned long hv_get_tsc_khz(void)
+static unsigned int __init hv_get_tsc_khz(void)
 {
 	unsigned long freq;
 
@@ -573,8 +573,8 @@ static void __init ms_hyperv_init_platform(void)
 
 	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
-		x86_platform.calibrate_tsc = hv_get_tsc_khz;
-		x86_platform.calibrate_cpu = hv_get_tsc_khz;
+		x86_init.hyper.get_tsc_khz = hv_get_tsc_khz;
+		x86_init.hyper.get_cpu_khz = hv_get_tsc_khz;
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 13b97265c535..3cb473cae462 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -64,7 +64,7 @@ struct vmware_steal_time {
 	u64 reserved[7];
 };
 
-static unsigned long vmware_tsc_khz __ro_after_init;
+static unsigned long vmware_tsc_khz __initdata;
 static u8 vmware_hypercall_mode     __ro_after_init;
 
 unsigned long vmware_hypercall_slow(unsigned long cmd,
@@ -137,7 +137,7 @@ static inline int __vmware_platform(void)
 	return eax != UINT_MAX && ebx == VMWARE_HYPERVISOR_MAGIC;
 }
 
-static unsigned long vmware_get_tsc_khz(void)
+static unsigned int __init vmware_get_tsc_khz(void)
 {
 	return vmware_tsc_khz;
 }
@@ -419,8 +419,8 @@ static void __init vmware_platform_setup(void)
 		}
 
 		vmware_tsc_khz = tsc_khz;
-		x86_platform.calibrate_tsc = vmware_get_tsc_khz;
-		x86_platform.calibrate_cpu = vmware_get_tsc_khz;
+		x86_init.hyper.get_tsc_khz = vmware_get_tsc_khz;
+		x86_init.hyper.get_cpu_khz = vmware_get_tsc_khz;
 
 		/* Skip lapic calibration since we know the bus frequency. */
 		apic_set_timer_period_hz(ecx, "VMware hypervisor");
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index f2d4ef89c085..e24c05ab4fae 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -68,7 +68,7 @@ static void __init jailhouse_timer_init(void)
 	apic_set_timer_period_khz(setup_data.v1.apic_khz, "Jailhouse hypervisor");
 }
 
-static unsigned long jailhouse_get_tsc(void)
+static unsigned int __init jailhouse_get_tsc(void)
 {
 	return precalibrated_tsc_khz;
 }
@@ -210,8 +210,6 @@ static void __init jailhouse_init_platform(void)
 	x86_init.mpparse.parse_smp_cfg		= jailhouse_parse_smp_config;
 	x86_init.pci.arch_init			= jailhouse_pci_arch_init;
 
-	x86_platform.calibrate_cpu		= jailhouse_get_tsc;
-	x86_platform.calibrate_tsc		= jailhouse_get_tsc;
 	x86_platform.get_wallclock		= jailhouse_get_wallclock;
 	x86_platform.legacy.rtc			= 0;
 	x86_platform.legacy.warm_reset		= 0;
@@ -293,5 +291,7 @@ const struct hypervisor_x86 x86_hyper_jailhouse __refconst = {
 	.detect			= jailhouse_detect,
 	.init.init_platform	= jailhouse_init_platform,
 	.init.x2apic_available	= jailhouse_x2apic_available,
+	.init.get_tsc_khz	= jailhouse_get_tsc,
+	.init.get_cpu_khz	= jailhouse_get_tsc,
 	.ignore_nopv		= true,
 };
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index cb3d0ca1fa22..4f8299303a19 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -136,7 +136,7 @@ static inline void kvm_sched_clock_init(bool stable)
  * poll of guests can be running and trouble each other. So we preset
  * lpj here
  */
-static unsigned long kvm_get_tsc_khz(void)
+static unsigned int __init kvm_get_tsc_khz(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(this_cpu_pvti());
@@ -343,8 +343,8 @@ void __init kvmclock_init(void)
 	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
 
-	x86_platform.calibrate_tsc = kvm_get_tsc_khz;
-	x86_platform.calibrate_cpu = kvm_get_tsc_khz;
+	x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
+	x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
 #ifdef CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 86384a83a5f6..1dca9464b41c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1451,13 +1451,17 @@ static int __init init_tsc_clocksource(void)
 device_initcall(init_tsc_clocksource);
 
 static bool __init determine_cpu_tsc_frequencies(bool early,
+						 unsigned int known_cpu_khz,
 						 unsigned int known_tsc_khz)
 {
 	/* Make sure that cpu and tsc are not already calibrated */
 	WARN_ON(cpu_khz || tsc_khz);
 
 	if (early) {
-		cpu_khz = x86_platform.calibrate_cpu();
+		if (known_cpu_khz)
+			cpu_khz = known_cpu_khz;
+		else
+			cpu_khz = x86_platform.calibrate_cpu();
 		if (known_tsc_khz)
 			tsc_khz = known_tsc_khz;
 		else
@@ -1514,7 +1518,7 @@ static void __init tsc_enable_sched_clock(void)
 
 void __init tsc_early_init(void)
 {
-	unsigned int known_tsc_khz = 0;
+	unsigned int known_cpu_khz = 0, known_tsc_khz = 0;
 
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
@@ -1522,22 +1526,33 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
 
+	if (x86_init.hyper.get_cpu_khz)
+		known_cpu_khz = x86_init.hyper.get_cpu_khz();
+
 	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
 		known_tsc_khz = snp_secure_tsc_init();
 	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
 		known_tsc_khz = tdx_tsc_init();
 
+	/*
+	 * If the TSC frequency wasn't provided by trusted firmware, try to get
+	 * it from the hypervisor (which is untrusted when running as a CoCo guest).
+	 */
+	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
+		known_tsc_khz = x86_init.hyper.get_tsc_khz();
+
 	/*
 	 * Ignore the user-provided TSC frequency if the exact frequency was
-	 * obtained from trusted firmware, as the user-provided frequency is
-	 * intended as a "starting point", not a known, guaranteed frequency.
+	 * obtained from trusted firmware or the hypervisor, as the user-
+	 * provided frequency is intended as a "starting point", not a known,
+	 * guaranteed frequency.
 	 */
 	if (!known_tsc_khz)
 		known_tsc_khz = tsc_early_khz;
 	else if (tsc_early_khz)
-		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware.\n");
+		pr_err("Ignoring 'tsc_early_khz' in favor of firmware/hypervisor.\n");
 
-	if (!determine_cpu_tsc_frequencies(true, known_tsc_khz))
+	if (!determine_cpu_tsc_frequencies(true, known_cpu_khz, known_tsc_khz))
 		return;
 	tsc_enable_sched_clock();
 }
@@ -1558,7 +1573,7 @@ void __init tsc_init(void)
 
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
-		if (!determine_cpu_tsc_frequencies(false, 0)) {
+		if (!determine_cpu_tsc_frequencies(false, 0, 0)) {
 			mark_tsc_unstable("could not calculate TSC khz");
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index d62c14334b35..1adb44fdddb2 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -38,7 +38,7 @@
 static u64 xen_sched_clock_offset __read_mostly;
 
 /* Get the TSC speed from Xen */
-static unsigned long xen_tsc_khz(void)
+static unsigned int __init xen_tsc_khz(void)
 {
 	struct pvclock_vcpu_time_info *info =
 		&HYPERVISOR_shared_info->vcpu_info[0].time;
@@ -569,7 +569,7 @@ static void __init xen_init_time_common(void)
 	static_call_update(pv_steal_clock, xen_steal_clock);
 	paravirt_set_sched_clock(xen_sched_clock);
 
-	x86_platform.calibrate_tsc = xen_tsc_khz;
+	x86_init.hyper.get_tsc_khz = xen_tsc_khz;
 	x86_platform.get_wallclock = xen_get_wallclock;
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


