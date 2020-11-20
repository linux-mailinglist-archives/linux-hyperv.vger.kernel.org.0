Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BE2BA97E
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Nov 2020 12:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgKTLqf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 06:46:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:55910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbgKTLqf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 06:46:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605872794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fjHe3+rmjY5cASW1XAPrcDHWzGbizvpE61ZYWB4j3cw=;
        b=rHmTXjwVBmFJKyhCEqOmhgg9FGZswY8WJdm/UueRf8DddoT49obCKWkkpulXZkEmbMyr53
        +tF6wEHiJQUjLKUN11yRtxzw2OPKHPWiM+6wvnAdRmBLFldnpbyUuBKOY+QFrHkVnZVwFO
        BIZuxt25L9jBmyI/EuK0mKwTZgHx17c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C23BCAD57;
        Fri, 20 Nov 2020 11:46:33 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterz@infradead.org, luto@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v2 00/12] x86: major paravirt cleanup
Date:   Fri, 20 Nov 2020 12:46:18 +0100
Message-Id: <20201120114630.13552-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is a major cleanup of the paravirt infrastructure aiming at
eliminating all custom code patching via paravirt patching.

This is achieved by using ALTERNATIVE instead, leading to the ability
to give objtool access to the patched in instructions.

In order to remove most of the 32-bit special handling from pvops the
time related operations are switched to use static_call() instead.

At the end of this series all paravirt patching has to do is to
replace indirect calls with direct ones. In a further step this could
be switched to static_call(), too, but that would require a major
header file disentangling.

Note that an updated objtool is needed for this series, as otherwise
lots of warnings due to alternative instructions modifying the stack
will be issued during the build.

Changes in V2:
- added patches 5-12

Juergen Gross (12):
  x86/xen: use specific Xen pv interrupt entry for MCE
  x86/xen: use specific Xen pv interrupt entry for DF
  x86/pv: switch SWAPGS to ALTERNATIVE
  x86/xen: drop USERGS_SYSRET64 paravirt call
  x86: rework arch_local_irq_restore() to not use popf
  x86/paravirt: switch time pvops functions to use static_call()
  x86: add new features for paravirt patching
  x86/paravirt: remove no longer needed 32-bit pvops cruft
  x86/paravirt: switch iret pvops to ALTERNATIVE
  x86/paravirt: add new macros PVOP_ALT* supporting pvops in
    ALTERNATIVEs
  x86/paravirt: switch functions with custom code to ALTERNATIVE
  x86/paravirt: have only one paravirt patch function

 arch/x86/Kconfig                      |   1 +
 arch/x86/entry/entry_32.S             |   4 +-
 arch/x86/entry/entry_64.S             |  32 ++--
 arch/x86/include/asm/cpufeatures.h    |   3 +
 arch/x86/include/asm/idtentry.h       |   6 +
 arch/x86/include/asm/irqflags.h       |  51 ++----
 arch/x86/include/asm/mshyperv.h       |  11 --
 arch/x86/include/asm/paravirt.h       | 170 ++++++--------------
 arch/x86/include/asm/paravirt_time.h  |  38 +++++
 arch/x86/include/asm/paravirt_types.h | 222 ++++++++++++--------------
 arch/x86/kernel/Makefile              |   3 +-
 arch/x86/kernel/alternative.c         |  30 +++-
 arch/x86/kernel/asm-offsets.c         |   8 -
 arch/x86/kernel/asm-offsets_64.c      |   3 -
 arch/x86/kernel/cpu/vmware.c          |   5 +-
 arch/x86/kernel/head_64.S             |   2 -
 arch/x86/kernel/irqflags.S            |  11 --
 arch/x86/kernel/kvm.c                 |   3 +-
 arch/x86/kernel/kvmclock.c            |   3 +-
 arch/x86/kernel/paravirt.c            |  70 +++-----
 arch/x86/kernel/paravirt_patch.c      | 109 -------------
 arch/x86/kernel/tsc.c                 |   3 +-
 arch/x86/xen/enlighten_pv.c           |  36 +++--
 arch/x86/xen/irq.c                    |  23 ---
 arch/x86/xen/time.c                   |  12 +-
 arch/x86/xen/xen-asm.S                |  52 +-----
 arch/x86/xen/xen-ops.h                |   3 -
 drivers/clocksource/hyperv_timer.c    |   5 +-
 drivers/xen/time.c                    |   3 +-
 kernel/sched/sched.h                  |   1 +
 30 files changed, 325 insertions(+), 598 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt_time.h
 delete mode 100644 arch/x86/kernel/paravirt_patch.c

-- 
2.26.2

