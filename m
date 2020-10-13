Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F21428CEF7
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Oct 2020 15:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgJMNMV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Oct 2020 09:12:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38574 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgJMNMV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Oct 2020 09:12:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id n18so23997333wrs.5;
        Tue, 13 Oct 2020 06:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=xwiQxdIni+OoOgjyTcFMAfcFR0s4rkAhFvFMhOPoExM=;
        b=TJtWLbJaZHAlQxWnuW4+9aJ85pCm3CBl2GKP3NmDKRLgX/pYwrDn2Q/iI7gW8PDs4D
         900HsmYKN6VDi5YGEnPBbDW4I8dlEU6SpEP8F7T1r7EN0PixlJVTf1Ct6P5L3Hy7vJSy
         uQOQcrZgEO5OvsQE3o/TCqR4hPbiFd1H+gZGwRJtl3RJ+20mNHQEl+kjdJ3dRZq02hxb
         R4Jfjasgd9cGe4ZVz6Ud+ohpnvtCqX277cLzMjmFT4EfXod49S1+/Eo+LcqOgTL6rnkF
         dtixV0YKwvycfx5GeZ/w2Du6v17rpwMTo5NvtrRIV9dpVbri/TWQmAwZTz13BHRes5RQ
         y4Ew==
X-Gm-Message-State: AOAM532j9wHffOB0+hOMffHHSmDrJLz3j6X+EhzVutaG6WJMfuHhSrtI
        A6gOMoAfOGy/Hl0THQy+TU8DxgIqGxU=
X-Google-Smtp-Source: ABdhPJydF+OkFkTjToGwDY4RqfrKdQfRwK+5w+ay+jROLpCMHJd9hwvt4Qa7bE5tYh2vy/3am/3HSw==
X-Received: by 2002:adf:a415:: with SMTP id d21mr26256079wra.408.1602594737034;
        Tue, 13 Oct 2020 06:12:17 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u195sm4860219wmu.18.2020.10.13.06.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 06:12:15 -0700 (PDT)
Date:   Tue, 13 Oct 2020 13:12:14 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V commits for 5.10
Message-ID: <20201013131214.ej4ek5expi5dywer@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

Please pull the following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

for you to fetch changes up to 1f3aed01473c41c9f896fbf4c30d330655e8aa7c:

  hv: clocksource: Add notrace attribute to read_hv_sched_clock_*() functions (2020-09-28 09:04:48 +0000)

----------------------------------------------------------------
hyperv-next for 5.10

 - A patch series from Boqun Feng to support page size larger than 4K
 - A few miscellaneous clean-up patches

----------------------------------------------------------------
Boqun Feng (11):
      Drivers: hv: vmbus: Always use HV_HYP_PAGE_SIZE for gpadl
      Drivers: hv: vmbus: Move __vmbus_open()
      Drivers: hv: vmbus: Introduce types of GPADL
      Drivers: hv: Use HV_HYP_PAGE in hv_synic_enable_regs()
      Drivers: hv: vmbus: Move virt_to_hvpfn() to hyperv header
      hv: hyperv.h: Introduce some hvpfn helper functions
      hv_netvsc: Use HV_HYP_PAGE_SIZE for Hyper-V communication
      Input: hyperv-keyboard: Use VMBUS_RING_SIZE() for ringbuffer sizes
      HID: hyperv: Use VMBUS_RING_SIZE() for ringbuffer sizes
      Driver: hv: util: Use VMBUS_RING_SIZE() for ringbuffer sizes
      scsi: storvsc: Support PAGE_SIZE larger than 4K

Joseph Salisbury (1):
      x86/hyperv: Remove aliases with X64 in their name

Krzysztof Wilczyński (1):
      PCI: hv: Document missing hv_pci_protocol_negotiation() parameter

Mohammed Gamal (1):
      hv: clocksource: Add notrace attribute to read_hv_sched_clock_*() functions

Olaf Hering (1):
      drivers: hv: remove cast from hyperv_die_event

 arch/x86/hyperv/hv_init.c             |   8 +-
 arch/x86/hyperv/hv_spinlock.c         |   2 +-
 arch/x86/include/asm/hyperv-tlfs.h    |  33 ---
 arch/x86/kernel/cpu/mshyperv.c        |   8 +-
 arch/x86/kvm/hyperv.c                 |  20 +-
 drivers/clocksource/hyperv_timer.c    |   4 +-
 drivers/hid/hid-hyperv.c              |   4 +-
 drivers/hv/channel.c                  | 461 +++++++++++++++++++++-------------
 drivers/hv/hv.c                       |   4 +-
 drivers/hv/hv_util.c                  |  11 +-
 drivers/hv/vmbus_drv.c                |   2 +-
 drivers/input/serio/hyperv-keyboard.c |   4 +-
 drivers/net/hyperv/netvsc.c           |   2 +-
 drivers/net/hyperv/netvsc_drv.c       |  46 ++--
 drivers/net/hyperv/rndis_filter.c     |  13 +-
 drivers/pci/controller/pci-hyperv.c   |   5 +-
 drivers/scsi/storvsc_drv.c            |  56 ++++-
 include/linux/hyperv.h                |  68 ++++-
 18 files changed, 468 insertions(+), 283 deletions(-)
