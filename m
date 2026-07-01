Return-Path: <linux-hyperv+bounces-11729-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8aRNISZsRWr8/goAu9opvQ
	(envelope-from <linux-hyperv+bounces-11729-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:36:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F256F0F03
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:36:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=h0EGsYus;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11729-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11729-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ECC03109047
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F54C77D0;
	Wed,  1 Jul 2026 19:32:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D0386C20
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934348; cv=none; b=ajX05dGV8kyieW5d60PPuQ3DszCim5B+8RjdqFB3v+BBUfaZOh2Li/6CJ7EIDq7o4784Ddv4NQiBwbrN6QLzLceweNTtr4iIwQJ3kiR7GzNBpivJnHs+U73ZX3XUXn1XhOtE4VLo6iCq3FZdMq2xnN6teE08G9CIRF/tenUT/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934348; c=relaxed/simple;
	bh=6P/nXhvLLHVY7aCiqrJ9XFDbwYykHu9VlZ2cDwh7A7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V5zvb1CFwK4tHUMjy8+mUbhOsH2y7l3mlixgkT9Kcr3sT0GTlLBrm3YkCKMIQ19REnBEeasxeQxDmYAxoH4PekNlaOIn/h5qLjdeL52I1Rhw2LJXjGt8o0ZZWPyXbuV0RjYQucNkh45dyXFadyQNjQLHD9KZYNpPl8diw+mm/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0EGsYus; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9b71388fbso20567515ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934346; x=1783539146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=esF5eJj/7ACJs9NShhG3o0+XzSBpzRsvPz4C7FhhKMM=;
        b=h0EGsYusshBW9s4KNgPNLvKeBm8yMuWTheKo4SKBCNz8Y5+S0u5pG7M+tgg0FxkrLw
         GjsVeLa7qwQzF1ItyRsp0GPi9ubazgWNYfr12zo3ex22mZ30W+Mn2v2XhVu6LIqkj2tb
         MEkC/YduUpHWHdfjnG4e8Tbm5vepcREFONoLEmdbothtytZiya+p88HnrFSyGaFCJLQ5
         /3nTfkXVHNfkMG5Jxo9EJe/CxQvUFX/2CwqaguYRq5oBc72gAnLVl04eXt57HX0H9I7s
         y4EYj7qdRiVIxuwd8QRKQJqO0XEMf4nNNl3DMyxo1tfGhW7eG9+VXSz8/e6W3x8f18Vm
         AkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934346; x=1783539146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esF5eJj/7ACJs9NShhG3o0+XzSBpzRsvPz4C7FhhKMM=;
        b=L6ZRIkj/+3upMRdxxMWKDjhB99xRomoxr3z5QdVwfVz6/Dfbmsc2G/RuaHOOa7kBAy
         kx/aN+eS5ecZSsW0g0kPnY6OoLMjmYYg6Ik49vjvKgIUB99qPLhyH8+vFDoerLOJoOZc
         elo7IPYHwFF9BjVzrem1xRQIXY1kkeYMDEjYVZgl97+t62Z4pa3ZHwoAmKngmrGJMl5f
         euwf3/7mc+Dc9/WIhXoeZNyYwCC8kalH9tI8xRskVIR8pll6m9kRhhooJbKDeS6lk4Ov
         14NetSK6ClX0VdTaELJK+zjYSQj4GF0trkH5NCUXOOJJ536tWotvZ+BuMxwoe+wmz67l
         lgKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvRyAH/RAuzJ6h//m2NQuXjVIGdlYX+bGZB9qmqleM6KwAECBdalyd6DZDRUifRy0N++QlW1i1EbFEuTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPAYF7ruMWTpgnSZ2/9PBaIHAN3LtfjiPCAj3IwmQ+Sf1EBZ/
	hsXZtbnlACIBI4qV68iCmNsThVDZXRR7Is/ys1rTWqMHCyNunNXlaW7/eayjJjUq2YRKOODNngk
	GkNR/bw==
X-Received: from plfz4.prod.google.com ([2002:a17:902:d544:b0:2c7:f3dc:ae29])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e811:b0:2c9:f73d:4b38
 with SMTP id d9443c01a7336-2ca7e6db91bmr32521425ad.19.1782934345724; Wed, 01
 Jul 2026 12:32:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:22 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-2-seanjc@google.com>
Subject: [PATCH v5 01/51] x86/apic: Provide helpers to set local APIC timer
 period in hz and khz
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11729-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: D5F256F0F03

Add and use APIs to set the local APIC timer period instead of open coding
the subtle HZ math in a all external callers, and make lapic_timer_period
local to apic.c.  Provide APIs to specify the frequency in both hertz and
kilohertz so that Hyper-V and VMware code aren't forced to lose precision.

Opportunistically use mul_u64_u32_div() to harden against the possibility
that the period in Khz is greater than 4294967, i.e. if the APIC timer runs
at ~4.29 GHz.  As pointed out by Sashiko, 4294968 * 1000 == 0x1_000002c0,
and thus a Khz period of 4294968 would silently overflow the 32-bit
unsigned integer used by most callers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/apic.h    |  3 ++-
 arch/x86/kernel/apic/apic.c    | 12 +++++++++++-
 arch/x86/kernel/cpu/mshyperv.c |  5 +----
 arch/x86/kernel/cpu/vmware.c   |  4 +---
 arch/x86/kernel/jailhouse.c    |  2 +-
 arch/x86/kernel/tsc.c          |  2 +-
 arch/x86/kernel/tsc_msr.c      |  2 +-
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9cd493d467d4..cd84a94688a2 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -63,7 +63,6 @@ extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
 extern bool apic_is_disabled;
-extern unsigned int lapic_timer_period;
 
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
@@ -138,6 +137,8 @@ void register_lapic_address(unsigned long address);
 extern void setup_boot_APIC_clock(void);
 extern void setup_secondary_APIC_clock(void);
 extern void lapic_update_tsc_freq(void);
+extern void apic_set_timer_period_hz(u64 period_hz, const char *source);
+extern void apic_set_timer_period_khz(u64 period_khz, const char *source);
 
 #ifdef CONFIG_X86_64
 static inline bool apic_force_enable(unsigned long addr)
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index aa1e19979aa8..8d3d930576fd 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -176,7 +176,7 @@ static struct resource lapic_resource = {
 };
 
 /* Measured in ticks per HZ. */
-unsigned int lapic_timer_period = 0;
+static unsigned int lapic_timer_period;
 
 static void apic_pm_activate(void);
 
@@ -796,6 +796,16 @@ bool __init apic_needs_pit(void)
 	return lapic_timer_period == 0;
 }
 
+void apic_set_timer_period_khz(u64 period_khz, const char *source)
+{
+	lapic_timer_period = mul_u64_u32_div(period_khz, 1000, HZ);
+}
+
+void apic_set_timer_period_hz(u64 period_hz, const char *source)
+{
+	lapic_timer_period = div_u64(period_hz, HZ);
+}
+
 static int __init calibrate_APIC_clock(void)
 {
 	struct clock_event_device *levt = this_cpu_ptr(&lapic_events);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 185d4f677ec0..87beecec76f0 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -646,10 +646,7 @@ static void __init ms_hyperv_init_platform(void)
 		u64	hv_lapic_frequency;
 
 		rdmsrq(HV_X64_MSR_APIC_FREQUENCY, hv_lapic_frequency);
-		hv_lapic_frequency = div_u64(hv_lapic_frequency, HZ);
-		lapic_timer_period = hv_lapic_frequency;
-		pr_info("Hyper-V: LAPIC Timer Frequency: %#x\n",
-			lapic_timer_period);
+		apic_set_timer_period_hz(hv_lapic_frequency, "Hyper-V hypervisor");
 	}
 
 	register_nmi_handler(NMI_UNKNOWN, hv_nmi_unknown, NMI_FLAG_FIRST,
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 34b73573b108..36f779dd311d 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -424,9 +424,7 @@ static void __init vmware_platform_setup(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
-		lapic_timer_period = ecx / HZ;
-		pr_info("Host bus clock speed read from hypervisor : %u Hz\n",
-			ecx);
+		apic_set_timer_period_hz(ecx, "VMware hypervisor");
 #endif
 	} else {
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index f58ce9220e0f..f2d4ef89c085 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -65,7 +65,7 @@ static void jailhouse_get_wallclock(struct timespec64 *now)
 
 static void __init jailhouse_timer_init(void)
 {
-	lapic_timer_period = setup_data.v1.apic_khz * (1000 / HZ);
+	apic_set_timer_period_khz(setup_data.v1.apic_khz, "Jailhouse hypervisor");
 }
 
 static unsigned long jailhouse_get_tsc(void)
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index ce10ae4b298b..f9ecc9256863 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -717,7 +717,7 @@ unsigned long native_calibrate_tsc(void)
 	 * lapic_timer_period here to avoid having to calibrate the APIC
 	 * timer later.
 	 */
-	lapic_timer_period = crystal_khz * 1000 / HZ;
+	apic_set_timer_period_khz(crystal_khz, "CPUID 0x15/0x16");
 #endif
 
 	return crystal_khz * ebx_numerator / eax_denominator;
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 48e6cc1cb017..7e990871e041 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -211,7 +211,7 @@ unsigned long cpu_khz_from_msr(void)
 		pr_err("Error MSR_FSB_FREQ index %d is unknown\n", index);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	lapic_timer_period = (freq * 1000) / HZ;
+	apic_set_timer_period_khz(freq, "MSR_FSB_FREQ");
 #endif
 
 	/*
-- 
2.55.0.rc0.799.gd6f94ed593-goog


