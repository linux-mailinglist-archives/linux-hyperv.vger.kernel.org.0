Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A9336B803
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Apr 2021 19:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhDZRV1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Apr 2021 13:21:27 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39626 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbhDZRV1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Apr 2021 13:21:27 -0400
Received: by mail-wr1-f51.google.com with SMTP id q9so2532902wrs.6;
        Mon, 26 Apr 2021 10:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RcF5tPt3L7kSNuZ7O4Oz7bEH7/xm5Ci/hHwq0pRDk7s=;
        b=sFsSgu4NEO5dwKVbH0zbObBnMCG9AnYlDRgyWDVgIcv0nkhUXn483uNuS7FdIVgxQp
         GV1rC1ass9e9lyNyiqwSIcCCZhU16EewRIc574vgL9r7lrMA3wdT1cEmgPEVEOI9Lw+I
         JkeCoZPBdD1rkjg2hoWxvXy+1m+ucWJ2uhc1yGPUfGJh/xKY1BHysQWXGFkXageexetl
         OxE7LeSPa84O3pwQbx5rAE47y1j7czULNWi1uLhjX0SkjpO87lzEfVxFL8IOLC6lZ6z1
         AtShSSpL9z0YP6pOxRo617LxOjrhlhVCEJTpEqsdjekRF3vgw1oZWc8ptPr9QE1S2wDW
         Hdiw==
X-Gm-Message-State: AOAM533glFBmbV2U+9HT2EKSmiQbcSQSvx4rMBPIrKyn9Z70dH0fZnDr
        5FPJ1njH9+Dyr37MQx6S/CnEDq+BFKw=
X-Google-Smtp-Source: ABdhPJwa8w5bUkBq+7bVJdcbLk23q5hAtNSbjItNpBXLO4KZH7lken+IG0UOZouDo6/l17WUHDhK2w==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr24529136wru.166.1619457643931;
        Mon, 26 Apr 2021 10:20:43 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h10sm947924wrt.40.2021.04.26.10.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 10:20:43 -0700 (PDT)
Date:   Mon, 26 Apr 2021 17:20:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V commits for 5.13
Message-ID: <20210426172042.tzl7i3mdr6dc4iyp@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210426

for you to fetch changes up to 753ed9c95c37d058e50e7d42bbe296ee0bf6670d:

  drivers: hv: Create a consistent pattern for checking Hyper-V hypercall status (2021-04-21 09:49:19 +0000)

Please be aware that there may be a conflict with the x86 tip tree in
arch/x86/include/asm/mshyperv.h. A resolution can be found at

https://lore.kernel.org/lkml/20210315143505.35af617b@canb.auug.org.au/

Thanks,
Wei.

----------------------------------------------------------------
hyperv-next for 5.13
  - VMBus enhancement.
  - Free page reporting support for Hyper-V balloon driver.
  - Some patches for running Linux as Arm64 Hyper-V guest.
  - A few misc clean-up patches.
----------------------------------------------------------------
Andrea Parri (Microsoft) (5):
      Drivers: hv: vmbus: Drop error message when 'No request id available'
      Drivers: hv: vmbus: Introduce and negotiate VMBus protocol version 5.3
      Drivers: hv: vmbus: Drivers: hv: vmbus: Introduce CHANNELMSG_MODIFYCHANNEL_RESPONSE
      Drivers: hv: vmbus: Check for pending channel interrupts before taking a CPU offline
      Drivers: hv: vmbus: Initialize unload_event statically

Bhaskar Chowdhury (1):
      hv: hyperv.h: a few mundane typo fixes

Dan Carpenter (1):
      Drivers: hv: vmbus: Use after free in __vmbus_open()

Jiapeng Chong (1):
      Drivers: hv: vmbus: remove unused function

Joseph Salisbury (2):
      x86/hyperv: Move hv_do_rep_hypercall to asm-generic
      drivers: hv: Create a consistent pattern for checking Hyper-V hypercall status

Michael Kelley (13):
      Drivers: hv: vmbus: Move Hyper-V page allocator to arch neutral code
      x86/hyper-v: Move hv_message_type to architecture neutral module
      Drivers: hv: Redo Hyper-V synthetic MSR get/set functions
      Drivers: hv: vmbus: Move hyperv_report_panic_msg to arch neutral code
      Drivers: hv: vmbus: Handle auto EOI quirk inline
      Drivers: hv: vmbus: Move handling of VMbus interrupts
      clocksource/drivers/hyper-v: Handle vDSO differences inline
      clocksource/drivers/hyper-v: Handle sched_clock differences inline
      clocksource/drivers/hyper-v: Set clocksource rating based on Hyper-V feature
      clocksource/drivers/hyper-v: Move handling of STIMER0 interrupts
      asm-generic/hyperv: Add missing function prototypes per -W1 warnings
      Drivers: hv: vmbus: Increase wait time for VMbus unload
      video: hyperv_fb: Add ratelimit on error message

Qiheng Lin (1):
      Drivers: hv: vmbus: Remove unused linux/version.h header

Sunil Muthuswamy (1):
      x86/Hyper-V: Support for free page reporting

Vasanth (2):
      drivers: hv: Fix whitespace errors
      drivers: hv: Fix EXPORT_SYMBOL and tab spaces issue

Xu Yihang (2):
      x86/hyperv: Fix unused variable 'msr_val' warning in hv_qlock_wait
      x86/hyperv: Fix unused variable 'hi' warning in hv_apic_read

Zheng Yongjun (1):
      x86/hyperv: remove unused linux/version.h header

 arch/x86/hyperv/hv_apic.c           |  18 ++-
 arch/x86/hyperv/hv_init.c           | 106 +++++++--------
 arch/x86/hyperv/hv_proc.c           |  26 ++--
 arch/x86/hyperv/hv_spinlock.c       |   8 +-
 arch/x86/hyperv/irqdomain.c         |   6 +-
 arch/x86/hyperv/mmu.c               |   8 +-
 arch/x86/hyperv/nested.c            |   8 +-
 arch/x86/include/asm/hyperv-tlfs.h  | 131 +++++++++----------
 arch/x86/include/asm/mshyperv.h     | 100 ++-------------
 arch/x86/kernel/cpu/mshyperv.c      |  32 ++---
 drivers/clocksource/hyperv_timer.c  | 249 +++++++++++++++++++++++++-----------
 drivers/hv/Kconfig                  |   1 +
 drivers/hv/channel.c                | 103 ++++++++++++---
 drivers/hv/channel_mgmt.c           |  86 +++++++++++--
 drivers/hv/connection.c             |   7 +-
 drivers/hv/hv.c                     | 152 ++++++++++++++++++----
 drivers/hv/hv_balloon.c             |  89 +++++++++++++
 drivers/hv/hv_trace.h               |  15 +++
 drivers/hv/ring_buffer.c            |  10 --
 drivers/hv/vmbus_drv.c              |  93 ++++++++++++--
 drivers/pci/controller/pci-hyperv.c |   2 +-
 drivers/video/fbdev/hyperv_fb.c     |   2 +-
 include/asm-generic/hyperv-tlfs.h   |  70 +++++++++-
 include/asm-generic/mshyperv.h      |  72 +++++++++--
 include/clocksource/hyperv_timer.h  |   3 +-
 include/linux/hyperv.h              |  21 ++-
 26 files changed, 973 insertions(+), 445 deletions(-)
