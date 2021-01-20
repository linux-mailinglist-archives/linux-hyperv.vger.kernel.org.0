Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0122FD247
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 15:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbhATODq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 09:03:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:43966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387646AbhATN1A (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 08:27:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611149174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CpmyovsicWRsraKS/oNts+zojxJvItjt3KCZ7hy85ig=;
        b=YoQQYyi997NN0sL65a0YYcDujYywf5i4Ag7KpzfJ88RqXywvxFU4fjjUrkFdBLLs+2EdEe
        FmwSt0fjJPJqEsQNSSKHl7g8Q0WLZeDQLdTCe9dgWo8A2HWnLWPkj1p1QYY+Qctq5Ar+lD
        Wn2hf5TRnZUn4VzS1ZuroHV9nujUBC0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F7E4AAAE;
        Wed, 20 Jan 2021 13:26:14 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     bpetkov@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v4 00/15] x86: major paravirt cleanup
Date:   Wed, 20 Jan 2021 14:25:58 +0100
Message-Id: <20210120132613.31487-1-jgross@suse.com>
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

For a clean build without any objtool warnings a modified objtool is
required. Currently this is available in the "tip" tree in the
objtool/core branch.

Changes in V4:
- fixed several build failures
- removed objtool patch, as objtool patches are in tip now
- added patch 1 for making usage of static_call easier
- even more cleanup

Changes in V3:
- added patches 7 and 12
- addressed all comments

Changes in V2:
- added patches 5-12

Juergen Gross (14):
  x86/xen: use specific Xen pv interrupt entry for MCE
  x86/xen: use specific Xen pv interrupt entry for DF
  x86/pv: switch SWAPGS to ALTERNATIVE
  x86/xen: drop USERGS_SYSRET64 paravirt call
  x86: rework arch_local_irq_restore() to not use popf
  x86/paravirt: switch time pvops functions to use static_call()
  x86/alternative: support "not feature" and ALTERNATIVE_TERNARY
  x86: add new features for paravirt patching
  x86/paravirt: remove no longer needed 32-bit pvops cruft
  x86/paravirt: simplify paravirt macros
  x86/paravirt: switch iret pvops to ALTERNATIVE
  x86/paravirt: add new macros PVOP_ALT* supporting pvops in
    ALTERNATIVEs
  x86/paravirt: switch functions with custom code to ALTERNATIVE
  x86/paravirt: have only one paravirt patch function

Peter Zijlstra (1):
  static_call: Pull some static_call declarations to the type headers

 arch/x86/Kconfig                        |   1 +
 arch/x86/entry/entry_32.S               |   4 +-
 arch/x86/entry/entry_64.S               |  28 ++-
 arch/x86/include/asm/alternative-asm.h  |   4 +
 arch/x86/include/asm/alternative.h      |   7 +
 arch/x86/include/asm/cpufeatures.h      |   2 +
 arch/x86/include/asm/idtentry.h         |   6 +
 arch/x86/include/asm/irqflags.h         |  53 ++----
 arch/x86/include/asm/mshyperv.h         |   2 +-
 arch/x86/include/asm/paravirt.h         | 197 ++++++++------------
 arch/x86/include/asm/paravirt_types.h   | 227 +++++++++---------------
 arch/x86/kernel/Makefile                |   3 +-
 arch/x86/kernel/alternative.c           |  49 ++++-
 arch/x86/kernel/asm-offsets.c           |   7 -
 arch/x86/kernel/asm-offsets_64.c        |   3 -
 arch/x86/kernel/cpu/vmware.c            |   5 +-
 arch/x86/kernel/irqflags.S              |  11 --
 arch/x86/kernel/kvm.c                   |   2 +-
 arch/x86/kernel/kvmclock.c              |   2 +-
 arch/x86/kernel/paravirt-spinlocks.c    |   9 +
 arch/x86/kernel/paravirt.c              |  83 +++------
 arch/x86/kernel/paravirt_patch.c        | 109 ------------
 arch/x86/kernel/tsc.c                   |   2 +-
 arch/x86/xen/enlighten_pv.c             |  36 ++--
 arch/x86/xen/irq.c                      |  23 ---
 arch/x86/xen/time.c                     |  11 +-
 arch/x86/xen/xen-asm.S                  |  52 +-----
 arch/x86/xen/xen-ops.h                  |   3 -
 drivers/clocksource/hyperv_timer.c      |   5 +-
 drivers/xen/time.c                      |   2 +-
 include/linux/static_call.h             |  20 ---
 include/linux/static_call_types.h       |  27 +++
 tools/include/linux/static_call_types.h |  27 +++
 33 files changed, 376 insertions(+), 646 deletions(-)
 delete mode 100644 arch/x86/kernel/paravirt_patch.c

-- 
2.26.2

