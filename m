Return-Path: <linux-hyperv+bounces-4085-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25892A4721F
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791371886982
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972D018D63A;
	Thu, 27 Feb 2025 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVdrYkSc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B53B1A5BA5
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622745; cv=none; b=vCubn1FpllUlZ+ttxUK62dvQ2WVAEgFJ8SUV5J7gbbfOxaIigMHm1vbLPWFuSgEBIyNyjb9eQavpGlk4GykAUuCWlO21gkydqZzPdoXVVUJE4ZFGX5p6t6LC8EWZpCB9hS2uamyRQHJIL83xz3Ta7hvQSewJR8LmkeHRf+YngQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622745; c=relaxed/simple;
	bh=6vzm1ly57iavrGyYCwy8YTCbhY8JsEYqKT94TS5Hqqk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J7hLFez7WAaumj59oNhgKWfLI5tBoySUrMpO63Ljnl+OvXpY9AfFaaTQyG6rDu0IOmATfkttQkE5RssLtznM4PqIz9aEEluyQsa+Kx+2eotWI0w7Pz7fMcmQ/V6kkEvr4Uxyh/8wudtB7Qqh0bthYpMtMbL0fvEfuLRjGJFeIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVdrYkSc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe9527c041so1100159a91.0
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622743; x=1741227543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st/MNJiEmtSZ09xGK+8+BbgbXd3TSC2HpMD5MWqL4Rs=;
        b=sVdrYkSci4HVmlUTo1W9WrFUdNNlNCBkbdq4grOsM0g+75OJJsta0WdjChwP80OOfq
         SANifiHZvtGZ8LuCDW18/zW0cDy9jGfyfWgtALPY0i7dfCUbAvIxE4waZgLOLUR7wPl2
         lB7gWBuyoC+I5J+FOjl8IPtxAjsEI6Qlx02tjvjJy0Wj7iOXZWuplePtmZMyaTc43tgT
         i3OJbbU8wu4UZVvMOHAtfudSUcwqAPdi3mbbzGMgLDhwF9on1fe2FFsz855PgBDL7m2v
         esMJ3YvIdXmZ8tadTksj/1CGnldcvC/wG/QYv4BGr0kfuSVTDZGNOXWtU7/17S0WOR+8
         tjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622743; x=1741227543;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=st/MNJiEmtSZ09xGK+8+BbgbXd3TSC2HpMD5MWqL4Rs=;
        b=VB0crSYv5oFTU3t6ShhIUpfAhwZ6gS1/zkWFC8EvWSb24OnVjm6DA2vUc9CSkXlxBF
         mZWUIj1ZQpSpQYHsY7JacqEqzCz5zpdcV1eOZTBsJcrdM3Lawg3qkCgLtajXT826TH4W
         8o6+Flw2PfXA7mGxXQAAtp4p/X+q0jvc+JbPw3h1idu/cdr8rr0KDDo+4IFToE8uxgr0
         arjOHkL5F6ORMelfAupCZSB+GjwQOGiC5lG1DEjVLIcB4+Z3RkFLb5AanWkISg/Wveg3
         E94DIY9ePhQHIZio+Wvf4XNKRnb7Qtt0xBVKBoVcWYfxyPxakmgzob4pQPgnHUbO+ged
         q84Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUIGECzbGSNIRyGE/2H9fweaUrH83I5Aj0EtuDy7oK+9qoVrc/M4QBXGmPC/n+jTJp+GY1RSKo6Fz1brI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXG7Fl3nhMoe++KtxwIpsB5GtSLw2xP5kqygDlX/E93OgzqRSs
	XCOGp5ZEXHaP6RoXhG52ZTOCRPPl1y8lAeUy4hn9kz0CQx9ASYlY8hfPQsQHMLCTveZUQ7iSEyB
	iSg==
X-Google-Smtp-Source: AGHT+IH0Z5GBXLArvAZe/lakaosQcAMuaUE8ywgN1crYyvWwIhA/1v2sV6rL/y5U8JWXjzB9EKIe2Lk1Tz0=
X-Received: from pjbqn6.prod.google.com ([2002:a17:90b:3d46:b0:2fc:201d:6026])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cd:b0:2f9:c139:b61f
 with SMTP id 98e67ed59e1d1-2fce78a3812mr44219981a91.14.1740622742780; Wed, 26
 Feb 2025 18:19:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:16 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-1-seanjc@google.com>
Subject: [PATCH v2 00/38] x86: Try to wrangle PV clocks vs. TSC
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

This... snowballed a bit.

The bulk of the changes are in kvmclock and TSC, but pretty much every
hypervisor's guest-side code gets touched at some point.  I am reaonsably
confident in the correctness of the KVM changes.  For all other hypervisors,
assume it's completely broken until proven otherwise.

Note, I deliberately omitted:

  Alexey Makhalov <alexey.amakhalov@broadcom.com>
  jailhouse-dev@googlegroups.com

from the To/Cc, as those emails bounced on the last version, and I have zero
desire to get 38*2 emails telling me an email couldn't be delivered.

The primary goal of this series is (or at least was, when I started) to
fix flaws with SNP and TDX guests where a PV clock provided by the untrusted
hypervisor is used instead of the secure/trusted TSC that is controlled by
trusted firmware.

The secondary goal is to draft off of the SNP and TDX changes to slightly
modernize running under KVM.  Currently, KVM guests will use TSC for
clocksource, but not sched_clock.  And they ignore Intel's CPUID-based TSC
and CPU frequency enumeration, even when using the TSC instead of kvmclock.
And if the host provides the core crystal frequency in CPUID.0x15, then KVM
guests can use that for the APIC timer period instead of manually calibrating
the frequency.

Lots more background on the SNP/TDX motiviation:
https://lore.kernel.org/all/20250106124633.1418972-13-nikunj@amd.com

v2:
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

Sean Christopherson (38):
  x86/tsc: Add a standalone helpers for getting TSC info from CPUID.0x15
  x86/tsc: Add standalone helper for getting CPU frequency from CPUID
  x86/tsc: Add helper to register CPU and TSC freq calibration routines
  x86/sev: Mark TSC as reliable when configuring Secure TSC
  x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
  x86/tdx: Override PV calibration routines with CPUID-based calibration
  x86/acrn: Mark TSC frequency as known when using ACRN for calibration
  clocksource: hyper-v: Register sched_clock save/restore iff it's
    necessary
  clocksource: hyper-v: Drop wrappers to sched_clock save/restore
    helpers
  clocksource: hyper-v: Don't save/restore TSC offset when using HV
    sched_clock
  x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
  x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
  x86/paravirt: Move handling of unstable PV clocks into
    paravirt_set_sched_clock()
  x86/kvmclock: Move sched_clock save/restore helpers up in kvmclock.c
  x86/xen/time: Nullify x86_platform's sched_clock save/restore hooks
  x86/vmware: Nullify save/restore hooks when using VMware's sched_clock
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
  x86/kvmclock: Enable kvmclock on APs during onlining if kvmclock isn't
    sched_clock
  x86/paravirt: Mark __paravirt_set_sched_clock() as __init
  x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
  x86/paravirt: Don't use a PV sched_clock in CoCo guests with trusted
    TSC
  x86/tsc: Pass KNOWN_FREQ and RELIABLE as params to registration
  x86/tsc: Rejects attempts to override TSC calibration with lesser
    routine
  x86/kvmclock: Mark TSC as reliable when it's constant and nonstop
  x86/kvmclock: Get CPU base frequency from CPUID when it's available
  x86/kvmclock: Get TSC frequency from CPUID when its available
  x86/kvmclock: Stuff local APIC bus period when core crystal freq comes
    from CPUID
  x86/kvmclock: Use TSC for sched_clock if it's constant and non-stop
  x86/paravirt: kvmclock: Setup kvmclock early iff it's sched_clock

 arch/x86/coco/sev/core.c           |   9 +-
 arch/x86/coco/tdx/tdx.c            |  27 ++-
 arch/x86/include/asm/kvm_para.h    |  10 +-
 arch/x86/include/asm/paravirt.h    |  16 +-
 arch/x86/include/asm/tdx.h         |   2 +
 arch/x86/include/asm/tsc.h         |  20 +++
 arch/x86/include/asm/x86_init.h    |   2 -
 arch/x86/kernel/cpu/acrn.c         |   5 +-
 arch/x86/kernel/cpu/mshyperv.c     |  69 +-------
 arch/x86/kernel/cpu/vmware.c       |  11 +-
 arch/x86/kernel/jailhouse.c        |   6 +-
 arch/x86/kernel/kvm.c              |  39 +++--
 arch/x86/kernel/kvmclock.c         | 260 +++++++++++++++++++++--------
 arch/x86/kernel/paravirt.c         |  35 +++-
 arch/x86/kernel/pvclock.c          |   9 +-
 arch/x86/kernel/smpboot.c          |   2 +-
 arch/x86/kernel/tsc.c              | 141 ++++++++++++----
 arch/x86/kernel/x86_init.c         |   1 -
 arch/x86/mm/mem_encrypt_amd.c      |   3 -
 arch/x86/xen/time.c                |  13 +-
 drivers/clocksource/hyperv_timer.c |  38 +++--
 include/clocksource/hyperv_timer.h |   2 -
 kernel/time/timekeeping.c          |   9 +-
 23 files changed, 487 insertions(+), 242 deletions(-)


base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.48.1.711.g2feabab25a-goog


