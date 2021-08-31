Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F113FC996
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Aug 2021 16:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbhHaOTV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Aug 2021 10:19:21 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:54891 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhHaOTH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Aug 2021 10:19:07 -0400
Received: by mail-wm1-f45.google.com with SMTP id g138so11343904wmg.4;
        Tue, 31 Aug 2021 07:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=J6eKb5G7dwkSA2nibFR3P1xpWcWeiiioYWCPCHIbl4U=;
        b=UxpdUUDFRvg+8UzYZkQyov6lnulcxkAAWGTRvcuZ60JocLu7RB0fduQZAG084aLbM4
         jk3rcDQl4rnYH9DhvNMaa7jcuOLZRPfzOPid52sg/0ooJg6sxnjzIFd7C5x+1igqUxAS
         yHhMhBSe/vJfiNDmjNGhHelhTaIzh7xj6DWwku6klCAMET5PMXTGhhdmDbHZp8YQVmGp
         1nzkCY5hWYzL7Kul1UQa8vJTVpkB3aYU9M4H6LwllZ77keXnb6ocmYiulIgaTfQSR+RY
         wr2fHBA9vnMGNzfx+xNBkmNx1kEcBMC9uUTFC7fyssE9FK2ENY4KeDVQXuFkOh6+NvV4
         tLmw==
X-Gm-Message-State: AOAM531e2o37ynnei/WvGMIhryKQtJ/1pdcN7jtWzMnN1XTfPb53kEh1
        JTpRVxkVc2VNWzHmyP54efKHuTeVjd0=
X-Google-Smtp-Source: ABdhPJzEv9XPfUjOakdEet8VntZ2tU/haexi7EnGedmwTfxAT4POCOlT46jme3VwBTIMi6QJWqFFfQ==
X-Received: by 2002:a05:600c:a4b:: with SMTP id c11mr4471457wmq.97.1630419491427;
        Tue, 31 Aug 2021 07:18:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z19sm18849015wrg.28.2021.08.31.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:18:10 -0700 (PDT)
Date:   Tue, 31 Aug 2021 14:18:08 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V commits for 5.15
Message-ID: <20210831141808.m4i2b3dc2phjjabb@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210831

for you to fetch changes up to 9d68cd9120e4e3af38f843e165631c323b86b4e4:

  hv_utils: Set the maximum packet size for VSS driver to the length of the receive buffer (2021-08-25 19:03:20 +0000)

----------------------------------------------------------------
hyperv-next for 5.15
  - Patches to make Hyper-V code arch-agnostic from Michael Kelley
  - Patches to fix sched_clock behaviour on Hyper-V from Ani Sinha
  - One patch to fix a fault when Linux runs as the root partition on
    MSHV from Praveen Kumar
  - One patch to fix VSS driver from Vitaly Kuznetsov
  - One cleanup patch from Sonia Sharma

----------------------------------------------------------------
Ani Sinha (2):
      x86/hyperv: fix for unwanted manipulation of sched_clock when TSC marked unstable
      x86/hyperv: add comment describing TSC_INVARIANT_CONTROL MSR setting bit 0

Michael Kelley (10):
      asm-generic/hyperv: Add missing #include of nmi.h
      Drivers: hv: Make portions of Hyper-V init code be arch neutral
      Drivers: hv: Add arch independent default functions for some Hyper-V handlers
      Drivers: hv: Move Hyper-V misc functionality to arch-neutral code
      drivers: hv: Decouple Hyper-V clock/timer code from VMbus drivers
      arm64: hyperv: Add Hyper-V hypercall and register access utilities
      arm64: hyperv: Add panic handler
      arm64: hyperv: Initialize hypervisor on boot
      arm64: efi: Export screen_info
      Drivers: hv: Enable Hyper-V code to be built on ARM64

Praveen Kumar (1):
      x86/hyperv: fix root partition faults when writing to VP assist page MSR

Sonia Sharma (1):
      hv: hyperv.h: Remove unused inline functions

Vitaly Kuznetsov (1):
      hv_utils: Set the maximum packet size for VSS driver to the length of the receive buffer

 MAINTAINERS                          |   3 +
 arch/arm64/Kbuild                    |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_core.c          | 181 +++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c         |  87 ++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++
 arch/arm64/include/asm/mshyperv.h    |  54 +++++++++
 arch/arm64/kernel/efi.c              |   1 +
 arch/x86/hyperv/hv_init.c            | 165 +++++++++-----------------
 arch/x86/include/asm/hyperv-tlfs.h   |   9 ++
 arch/x86/include/asm/mshyperv.h      |   4 -
 arch/x86/kernel/cpu/mshyperv.c       |  38 +++---
 drivers/clocksource/hyperv_timer.c   |   3 -
 drivers/hv/Kconfig                   |   7 +-
 drivers/hv/hv_common.c               | 219 +++++++++++++++++++++++++++++++++++
 drivers/hv/hv_snapshot.c             |   1 +
 drivers/hv/hv_util.c                 |   5 -
 include/asm-generic/mshyperv.h       |  13 +++
 include/clocksource/hyperv_timer.h   |  11 +-
 include/linux/hyperv.h               |  16 ---
 20 files changed, 724 insertions(+), 165 deletions(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h
