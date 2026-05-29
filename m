Return-Path: <linux-hyperv+bounces-11323-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FVKMJGnGWruyAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11323-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:49:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F0603F17
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B082A30B11E7
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7B3ED3D1;
	Fri, 29 May 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpTJri8U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4E3EAC8A
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065895; cv=none; b=bBfwOhz5qVnSTc9xi5iQB6VoPdyxpP57/XCPSD9Yk1lb25auF+D8IQrsPptIlhg/UggrOq9XZNDc1e3vJlZgJoSR85vBP1ffnws3x0t32CHKLqsjZq8SHRk01vONBLk4hox6Xcfnbffi5MS8Wo8PGG1iOFEKOrZdL/7cZR6qdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065895; c=relaxed/simple;
	bh=3cpMbzFFqk1fqsz2bupF/ffg3SDdqCGa7/msOxpC62s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gRgOaQTPPQEqP0yWWyNIiozkZvRH9mJCWtdqs2hM7+uhvD0Amfo8lFsyh/RVfNqyw2Qcf/utyYHRryUvh1Li7bAmUbksGM0aDeH0zLrEuwjyNw2wIzNTXo7wj39emUoXVtcxnlEmPSX5B9Ps/fQxHPtrHnOZgWhsW6WcKumhHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpTJri8U; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d0d71c61so7488235b3a.1
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065891; x=1780670691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZSmySQjJHcnKIUXjsIIs83nT6d2RU++b42lJ4OxIH4=;
        b=MpTJri8U3UySK4F4MHJBGmiiMCjnVeBa7VlyDZcxwFbBl7WyhGogFAKAZ3IZZVK6qS
         3pioov7sC+Q2iwfI5XWfOClBf67nFHWktoDMM9z7RkMRKsCm9LOdVBsqIVAgv/e3njKV
         NHYsTEl4mXCqcZeZ0D/np5uImPvbWiw7OWmJSCuZ2Bh2Y0ctqO+xHKdZ4CW4B0AlG6RW
         Er8twC1x4J3+SwSM9dAOIzSn+CPnYWlFUul0qgLyYvQ8s2fVUnSjS70gZP3IXtHyZxdv
         ePhRcyxJ0hrEArlVlPQ9ePP3LYS0nTj2HPm+MDTT60sillwir+jzzop5DbkkB9QfczyT
         1Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065891; x=1780670691;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZSmySQjJHcnKIUXjsIIs83nT6d2RU++b42lJ4OxIH4=;
        b=Aad0O9e82n3iQ7BlReOEhQAJoxrfU5YTTXcXjltdUxdy2AZjPA7lGhPwrEugJZnR9r
         d+jPxcjRUn6ZA2Qx1pkgdlrNOJy6EmsqJhituHN4bpQ879fC1vpMufGl62cXfsg0iFV2
         krK4bAM4PnT4OL8xq/16xNLNP0nhcHeR4gYK7+xodU6DI1aEzPy0loHaJZwDMEI3WeIQ
         L+CRZoQYBley+xZeh2ITCAhVnQoglBTViG9T6E9qBBSbrJF3jrSBI2PxATOBk6FOvDdY
         ioGFUtTSAWX0ZE67dFW2XKMSZXG57V8z+UyI/q6E9/2xAhiHkWVHwn9krC+ADhi/CEJf
         XFnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9eXTqtCSIN0XEmtJW3blHQFqyPI5b0C0udFICqTFaSK62FUI8l5Z0vswWRPm4QwG90gK8njPgK1eoybHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhtXhSQp/jfz/FsOZu9LpVKAIwIf2OckSTA30tRk4hszZq+z6
	Dz8QDptgTmxETKEmcSM8PxMCcXp0tZddvkhAN5Gm8jAi8981nXkXG9cc0fmmHMJraQwGwWXuaCa
	4WH6cfA==
X-Received: from pfbgg3.prod.google.com ([2002:a05:6a00:6303:b0:838:ec6d:449c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:140f:b0:83e:ccd6:2dc8
 with SMTP id d2e1a72fcca58-84212ce3e9emr3273017b3a.27.1780065890910; Fri, 29
 May 2026 07:44:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:47 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-1-seanjc@google.com>
Subject: [PATCH v4 00/47] x86: Try to wrangle PV clocks vs. TSC
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11323-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,googlegroups.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: AD5F0603F17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Well, the number of patches in the series is going in the wrong direction,
but I'm much happier with this version, which eschews the x86_platform
overrides entirely in favor of a fixed sequence for selecting the TSC/CPU
frequency "routine".

Given that previous versions had fatal NULL pointer deref bugs that affected
VMware and Xen, this series needs testing and acks from those maintainers.

The primary goal of this series to fix flaws with SNP and TDX guests where a
PV clock provided by the untrusted hypervisor is used instead of the secure
TSC that is controlled by trusted firmware.

The secondary goal is modernize running under KVM.  Currently, KVM guests will
use TSC for clocksource, but not sched_clock.  And Linux-as-a-KVM-guest doesn't
support paravirt enumeration of the TSC/APIC frequencies, even though QEMU
provides that information by default.

The tertiary goal is to clean up the PV clock code to deduplicate logic across
hypervisors, and to hopefully make it all easier to maintain going forward.

v4 also adds a quaternary goal of cleaning up the TSC calibration code, which
was made stupidly hard to follow by hypervisor code mixing in with the native
calibration routines, instead of being implemented as a pure alternative.

Lots more background on the SNP/TDX motiviation:
https://lore.kernel.org/all/20250106124633.1418972-13-nikunj@amd.com

As before, I deliberately omitted jailhouse-dev@googlegroups.com from the To/Cc,
as those emails bounced on v1, AFAICT nothing has changed.

Note, I deliberately didn't collect a few reviews as the patches changed quite
a bit from what was reviewed in v3.

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

David Woodhouse (3):
  KVM: x86: Officially define CPUID 0x40000010 as PV Timing Info (TSC
    and Bus)
  x86/kvm: Obtain TSC frequency from PV CPUID if present
  x86/xen: Obtain TSC frequency from CPUID if present

Sean Christopherson (44):
  x86/tsc: Never re-calibrate TSC frequency if its exact timing is known
  x86/tsc: Add a standalone helpers for getting TSC info from CPUID.0x15
  x86/sev: Mark TSC as reliable when configuring Secure TSC
  x86/sev: Don't override CPU frequency calibration for SNP's Secure TSC
  x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
  x86/sev: Shove SNP's secure/trusted TSC frequency directly into
    "calibration"
  x86/tdx: Force TSC frequency with CPUID-based info provided by the
    TDX-Module
  x86/tsc: Add dedicated hypervisor hooks for getting known TSC/CPU
    frequencies
  x86/acrn: Mark TSC frequency as known when using ACRN for calibration
  x86/tsc: Consolidate forcing of X86_FEATURE_TSC_KNOWN_FREQ for PV code
  x86/tsc: Kill off x86_platform_ops.calibrate_{cpu,tsc}() hooks
  x86/tsc: Rename pit_hpet_ptimer_calibrate_cpu() =>
    native_calibrate_cpu_late()
  x86/tsc: Fold native_calibrate_cpu() into recalibrate_cpu_khz()
  x86/kvmclock: Rename kvm_get_tsc_khz() to kvmclock_get_tsc_khz()
  x86/kvm: Mark TSC as reliable when it's constant and nonstop
  x86/kvm: Get local APIC bus frequency from PV CPUID Timing Info
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

 Documentation/virt/kvm/x86/cpuid.rst |  12 ++
 arch/x86/coco/sev/core.c             |  21 +--
 arch/x86/coco/tdx/tdx.c              |  19 ++-
 arch/x86/include/asm/acrn.h          |   5 -
 arch/x86/include/asm/kvm_para.h      |  12 +-
 arch/x86/include/asm/sev.h           |   4 +-
 arch/x86/include/asm/tdx.h           |   2 +
 arch/x86/include/asm/timer.h         |  15 +-
 arch/x86/include/asm/tsc.h           |  11 +-
 arch/x86/include/asm/x86_init.h      |   8 +-
 arch/x86/include/uapi/asm/kvm_para.h |  11 ++
 arch/x86/kernel/cpu/acrn.c           |  10 +-
 arch/x86/kernel/cpu/mshyperv.c       |  65 +-------
 arch/x86/kernel/cpu/vmware.c         |  13 +-
 arch/x86/kernel/jailhouse.c          |   7 +-
 arch/x86/kernel/kvm.c                | 108 +++++++++++--
 arch/x86/kernel/kvmclock.c           | 208 ++++++++++++++++---------
 arch/x86/kernel/pvclock.c            |   9 +-
 arch/x86/kernel/tsc.c                | 218 +++++++++++++++++----------
 arch/x86/kernel/x86_init.c           |   2 -
 arch/x86/mm/mem_encrypt_amd.c        |   3 -
 arch/x86/xen/time.c                  |  25 ++-
 drivers/clocksource/hyperv_timer.c   |  38 +++--
 include/clocksource/hyperv_timer.h   |   2 -
 kernel/time/timekeeping.c            |   9 +-
 25 files changed, 533 insertions(+), 304 deletions(-)


base-commit: 4678d11f294de0fd295a265e02955b5d1a4a2684
-- 
2.54.0.823.g6e5bcc1fc9-goog


