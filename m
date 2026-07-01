Return-Path: <linux-hyperv+bounces-11728-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0AQdAhBsRWr0/goAu9opvQ
	(envelope-from <linux-hyperv+bounces-11728-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:35:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 667DE6F0EFD
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:35:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=TJ146Q72;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11728-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11728-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1195230FA273
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F293C4563;
	Wed,  1 Jul 2026 19:32:27 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0A3DC4D9
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934347; cv=none; b=T/yD2tIsrdfbf6Sa6EPvuKwcHDkzWyqOWp49bPq66uekJ1p8B5TwFgbWKt35liST1LsSwu9LujYa8PTr9IHAbrhx8vEVspUZCIdXJoCk/Wb8kT3M8ZC+E/Ip+4agwqGlbuRjlipkXPwN1PkQ7L5h+Cnm8SdNpNySMLMkFfIhGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934347; c=relaxed/simple;
	bh=UrrHgI5nxuV0K+nJlkYSwNJvN7a9iCCs3OUNM2aMIUE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jJ06W5mHYyg9JPrc4ytRgGIOd5uftq2tKMzo+wDDoDfzB60ghCLw4xiK4dPNFqC+WqH006fFN/KdVJcjk5i3hvThL610v1teGkUXiXhRCk4qimf8hu0HmYkPcQ6oIB07R1ZINABn6hbvIcoGcMACIm7bHwzQsVMYT75WAbcPJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJ146Q72; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37e16f658abso812979a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934345; x=1783539145; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q5DLB1BjKje3f1c5FruZIw3+wsrQVQC55+bIjsMSwHk=;
        b=TJ146Q72lTpzR2+IkTVamgzHt0YB963Q5xXvxs+I/zQsrhWstOaKYOGKr7Gis0koPM
         olTVQWe1d3+FHs78Q2119TMZQ0+QSgG4wVsXaEfuidzAW7rIocGvoX7wStdo4qEWc1I7
         IY0XvgoZlpiN3m0g3LkUodV1G2DbxHdKrAr0QNp48AQ7r9/9e75dfW/U4rknogAE0hBw
         F0JngpPN4aw7g0bWhivSLj3e9peRqE9A7nNFnZNduOzrRtgnuXJmZakFOf6xU45B5CNK
         16LQ1Fk5ZmbLQHq7TxSlole2iAOwvVarSzcvuNAj9hiEF5rQosh9kJy5JTXTcqq30uDI
         G4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934345; x=1783539145;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q5DLB1BjKje3f1c5FruZIw3+wsrQVQC55+bIjsMSwHk=;
        b=e4eg+AdXzvjigO4PQv8k7nzntb4sKvclrbkzFEZbGZpV31J+247mb1z98Aenaf2ihO
         QPO9wAuciPXGyjDggIqlgPXVWek1T15XcOgk7da6hrPK87QXVQWLyoC1zvduhqVkCorZ
         OiN9igNZ+iYm6yF0VMfHvyItEwVNnOUpYVC1eGuRC4jXE+lmorIgIOvVACGcqDvKHdhi
         6A8ux9o5I3dx8yb0UNQc0Ce00iGALkuY5Ea9l3SpylswMkqwACLFpaxEhrkmBBZtYxtE
         BGM9I76NccBI6Z4TH2fUiXBJ+L4kn/HnkDgi7urNE8SAd5EzmY2FTVI7yl4MwHEjsSBI
         F8Ew==
X-Forwarded-Encrypted: i=1; AHgh+Rq4Pl0yVp2EYN1gVpRCL9CZzptWKAsvXWT/EGzfVpyn7AhJiGI40U+D8jfFA6sUf43j3HSYhcogrrHTmx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQO7r/q9F/dzPZt0jntw1l1FRMVbRIo0fXn5IBeQhaB4QlN3Ue
	wgP8QZ+RbaJCX0VByk+DiXHWRcz0B/t0FicGCE2gQbjxwOQhpmn+soR8809q2+OF/dSllf7KTqQ
	1qRogLQ==
X-Received: from pjtl15.prod.google.com ([2002:a17:90a:c58f:b0:380:5553:77a7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52:b0:37f:9ce1:735e
 with SMTP id 98e67ed59e1d1-380ba94a46bmr2041513a91.31.1782934344390; Wed, 01
 Jul 2026 12:32:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:21 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-1-seanjc@google.com>
Subject: [PATCH v5 00/51] x86: Try to wrangle PV clocks vs. TSC
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11728-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 667DE6F0EFD

The primary goal of this series to fix flaws with SNP and TDX guests where a
PV clock provided by the untrusted hypervisor is used instead of the secure
TSC that is controlled by trusted firmware.

The secondary goal is modernize running under KVM.  Currently, KVM guests will
use TSC for clocksource, but not sched_clock.  And Linux-as-a-KVM-guest doesn't
support paravirt enumeration of the TSC/APIC frequencies, even though QEMU
provides that information by default.

The tertiary goal is to clean up the PV clock code to deduplicate logic across
hypervisors, and to hopefully make it all easier to maintain going forward.

The quaternary goal is to clean up the TSC calibration code, which was made
stupidly hard to follow by hypervisor code mixing in with the native
calibration routines, instead of being implemented as a pure alternative.

Note, the VMware and Xen changes still probably should get acks from those
maintainers, as my understanding of what they're trying to do may be flawed.

Lots more background on the SNP/TDX motiviation:
https://lore.kernel.org/all/20250106124633.1418972-13-nikunj@amd.com

As before, I deliberately omitted jailhouse-dev@googlegroups.com from the To/Cc,
as those emails bounced on v1, AFAICT nothing has changed.

v5:
 - Use cpu_feature_enabled() instead of boot_cpu_has(). [Boris]
 - WARN if recalibrate_cpu_khz() runs on a system with TSC_KNOWN_FREQ. [Thomas]
 - Opportunistically drop a line break in native_calibrate_tsc(). [Thomas]
 - Rely on callers of cpuid_get_tsc_info() to check the result instead of
   unnecessarily zeroing the structure. [Boris]
 - Ignore tsc_early_khz if the TSC frequency is provided by trusted firmware
   or by the hypervisor. [Thomas, Sashiko]
 - Cache CPUID output in acrn_init_platform() to avoid introducing a transient
   bug where TSC_KNOWN_FREQ could be set even if the ACRN hypervisor didn't
   actually provide the frequency. [Sashiko]
 - Drop kvmclock's useless/dead check_tsc_unstable() call (it occurs before the
   command line parameter is parsed). [Sashiko]
 - Add helpers to set lapic_timer_period, to fix not-so-theoretical overflow
   in the various "khz * 1000 / HZ" patterns. [Sashiko]
 - Drop the "x86/xen: Obtain TSC frequency from CPUID if present" patch as it
   doesn't have any dependencies/conflicts on/with this series, and Sashiko had
   concerns about the assumptions it was making. [Sashiko]
 - Collect reviews. [David] (Kirill's got dropped because the patch he reviewed
   got completely rewritten).


v4:
 - Use x86_init_noop() to skip save/restore on VMware and Xen instead of
   nullifying x86_platform.{save,restore}_sched_clock_state. [Sashiko]
 - Use '0' to indicate "failure" when getting the CPU frequency from CPUID, to
   avoid using an out-param and thus make it all but impossible to
   unintentionally clobber the global cpu_khz (which v3 did). [Sashiko]
 - Rename cpuid_get_cpu_freq() => __cpu_khz_from_cpuid() to capture its
   relationship with cpu_khz_from_cpuid().
 - Compute lapic_timer_period in units of ticks, not Khz. [Sashiko]
 - Kill off x86_platform_ops.calibrate_{cpu,tsc}(), and instead use dedicated
   hooks for hypervisor code, and direct calls for TDX and SNP. [David, loosely]
 - Drop SNP's secure TSC override of _CPU_ calibration, as there's zero
   evidence it's justified or a net positive.
 - Collect reviews/acks. [David, Wei]
 - Decouple getting TSC/APIC frequencies from KVM PV CPUID from kvmclock. [David]
 - Fix an amusing number of Opportunistically misspellings. [David]
 - Set kvm_sched_clock_offset _before_ registering kvmclock as sched_clock,
   and add a comment to guard against future goofs. [Sashiko]
 - Keep "setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE)" in Hyper-V's handling
   of HV_ACCESS_TSC_INVARIANT, as it's technically possible to have a VM
   with HV_ACCESS_TSC_INVARIANT but not HV_ACCESS_FREQUENCY_MSRS.  Though as
   a _very_ nice side effect of using dedicated sequencing for selecting the
   TSC frequency source, this would have naturally happened anyways. [Sashiko]

v3:
 - https://lore.kernel.org/all/20260515191942.1892718-1-seanjc@google.com
 - Collect reviews. [Michael, Thomas]
 - Use Hyper-V reference counter / refcounter instead of Hyper-V timer. [Michael]
 - Use the paravirt CPUID interface first proposed by VMware for KVM's
   "official" mechanism for communicating frequency to KVM-aware guests,
   instead of abusing Intel's CPUID leafs. [David]
 - Deal with paravirt code being moved into asm/timers.h and
   arch/x86/kernel/tsc.c.

v2:
 - https://lore.kernel.org/all/Z8YWttWDtvkyCtdJ@google.com
 - Add struct to hold the TSC CPUID output. [Boris]
 - Don't pointlessly inline the TSC CPUID helpers. [Boris]
 - Fix a variable goof in a helper, hopefully for real this time. [Dan]
 - Collect reviews. [Nikunj]
 - Override the sched_clock save/restore hooks if and only if a PV clock
   is successfully registered.
 - During resome, restore clocksources before reading persistent time.
 - Clean up more warts created by kvmclock.
 - Fix more bugs in kvmclock's suspend/resume handling.
 - Try to harden kvmclock against future bugs.

v1: https://lore.kernel.org/all/20250201021718.699411-1-seanjc@google.com

David Woodhouse (2):
  KVM: x86: Officially define CPUID 0x40000010 as PV Timing Info (TSC
    and Bus)
  x86/kvm: Obtain TSC frequency from PV CPUID if present

Sean Christopherson (49):
  x86/apic: Provide helpers to set local APIC timer period in hz and khz
  x86/apic: Add CONFIG_X86_LOCAL_APIC=n stubs for
    apic_set_timer_period_{,k}hz()
  x86/tsc: Ensure that TSC recalibration doesn't run if TSC frequency is
    known
  x86/tsc: Restrict recalibrate_cpu_khz() export to p4-clockmod and
    powernow-k7
  x86/sev: Mark TSC as reliable when configuring Secure TSC
  x86/sev: Don't override CPU frequency calibration for SNP's Secure TSC
  x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
  x86/sev: Shove SNP's secure/trusted TSC frequency directly into
    "calibration"
  x86/tsc: Add a standalone helper for getting TSC info from CPUID.0x15
  x86/tdx: Force TSC frequency with CPUID-based info provided by the
    TDX-Module
  x86/tsc: Add dedicated hypervisor hooks for getting known TSC/CPU
    frequencies
  x86/acrn: Register TSC/CPU frequency callbacks iff frequency is
    actually in CPUID
  x86/acrn: Mark TSC frequency as known when using ACRN for calibration
  x86/tsc: Consolidate forcing of X86_FEATURE_TSC_KNOWN_FREQ for PV code
  x86/tsc: Kill off x86_platform_ops.calibrate_{cpu,tsc}() hooks
  x86/tsc: Rename pit_hpet_ptimer_calibrate_cpu() =>
    native_calibrate_cpu_late()
  x86/tsc: Fold native_calibrate_cpu() into recalibrate_cpu_khz()
  x86/kvmclock: Rename kvm_get_tsc_khz() to kvmclock_get_tsc_khz()
  x86/kvmclock: Drop dead check on TSC being unstable during
    kvmclock_init()
  x86/kvm: Mark TSC as reliable when it's constant and nonstop
  x86/tsc: Add standalone helper for getting CPU frequency from CPUID
  x86/kvm: Get CPU base frequency from CPUID when it's available
  clocksource: hyper-v: Register sched_clock save/restore iff it's
    necessary
  clocksource: hyper-v: Drop wrappers to sched_clock save/restore
    helpers
  clocksource: hyper-v: Don't save/restore TSC offset when using HV
    sched_clock
  x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
  x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
  x86/paravirt: Remove unnecessary PARAVIRT=n stub for
    paravirt_set_sched_clock()
  x86/paravirt: Move handling of unstable PV clocks into
    paravirt_set_sched_clock()
  x86/kvmclock: Move sched_clock save/restore helpers up in kvmclock.c
  x86/xen/time: NOP-ify x86_platform's sched_clock save/restore hooks
  x86/vmware: NOP-ify save/restore hooks when using VMware's sched_clock
  x86/tsc: WARN if TSC sched_clock save/restore used with PV sched_clock
  x86/paravirt: Pass sched_clock save/restore helpers during
    registration
  x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
  x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
  x86/pvclock: Mark setup helpers and related various as
    __init/__ro_after_init
  x86/pvclock: WARN if pvclock's valid_flags are overwritten
  x86/kvmclock: Refactor handling of PVCLOCK_TSC_STABLE_BIT during
    kvmclock_init()
  timekeeping: Resume clocksources before reading persistent clock
  x86/kvmclock: Hook clocksource.suspend/resume when kvmclock isn't
    sched_clock
  x86/kvmclock: WARN if wall clock is read while kvmclock is suspended
  x86/paravirt: Mark __paravirt_set_sched_clock() as __init
  x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
  x86/paravirt: Don't use a PV sched_clock in CoCo guests with trusted
    TSC
  x86/kvmclock: Use TSC for sched_clock if it's constant and non-stop
  x86/kvmclock: Plumb in AP-online and BSP-resume to kvmlock, for
    documentation
  x86/paravirt: Move using_native_sched_clock() stub into timer.h
  x86/kvm: Get local APIC bus frequency from PV CPUID Timing Info

 .../admin-guide/kernel-parameters.txt         |   5 +
 Documentation/virt/kvm/x86/cpuid.rst          |  12 +
 arch/x86/coco/sev/core.c                      |  21 +-
 arch/x86/coco/tdx/tdx.c                       |  19 +-
 arch/x86/include/asm/acrn.h                   |   5 -
 arch/x86/include/asm/apic.h                   |   5 +-
 arch/x86/include/asm/kvm_para.h               |  12 +-
 arch/x86/include/asm/sev.h                    |   4 +-
 arch/x86/include/asm/tdx.h                    |   2 +
 arch/x86/include/asm/timer.h                  |  15 +-
 arch/x86/include/asm/tsc.h                    |  10 +-
 arch/x86/include/asm/x86_init.h               |   8 +-
 arch/x86/include/uapi/asm/kvm_para.h          |  11 +
 arch/x86/kernel/apic/apic.c                   |  12 +-
 arch/x86/kernel/cpu/acrn.c                    |  14 +-
 arch/x86/kernel/cpu/mshyperv.c                |  70 +-----
 arch/x86/kernel/cpu/vmware.c                  |  19 +-
 arch/x86/kernel/jailhouse.c                   |   9 +-
 arch/x86/kernel/kvm.c                         | 101 ++++++--
 arch/x86/kernel/kvmclock.c                    | 208 +++++++++++------
 arch/x86/kernel/pvclock.c                     |   9 +-
 arch/x86/kernel/tsc.c                         | 218 +++++++++++-------
 arch/x86/kernel/tsc_msr.c                     |   4 +-
 arch/x86/kernel/x86_init.c                    |   2 -
 arch/x86/mm/mem_encrypt_amd.c                 |   3 -
 arch/x86/xen/time.c                           |  14 +-
 drivers/clocksource/hyperv_timer.c            |  38 ++-
 include/clocksource/hyperv_timer.h            |   2 -
 kernel/time/timekeeping.c                     |   9 +-
 29 files changed, 540 insertions(+), 321 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.55.0.rc0.799.gd6f94ed593-goog


