Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2FA3B7110
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 13:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhF2LE0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 07:04:26 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53871 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhF2LEY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 07:04:24 -0400
Received: by mail-wm1-f53.google.com with SMTP id w13so13545572wmc.3;
        Tue, 29 Jun 2021 04:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UxbYdjRBdJm5/fTVehzUZ/ohEPLj6Stc/4/xbrS9z3s=;
        b=PDCbCtUDgim4NBXGWnoyNqtELgSpFNPDCwCXNUKgDpVBV/a8F85YgMqehtdnYdTP+C
         QP9b1wgmMWCL/kDbCVtvPHkogzz/hW6dORa6evoQ+PSwrmK8rvJfn0Tv/KHGTpamzQVR
         ySIfhtKJ/0WC7jpdYMKIjzMTWkklTf3gLxswhRpqrxuytz0UbO/8z0daADyFOPJMbAS+
         TdOUVUqnMjvG53ufaOcQQKVX/ISWshzJgTfpxv7My2oTqJ00rooBjQCWh6R7PIEmPETo
         XZxy5Tn5IL9Ot5804JEyUtQMPjcmnzH/KHjuqoyzNcAbBU+b9cCPFompDeC/wc1jpKmE
         7W2w==
X-Gm-Message-State: AOAM533oukckfk0RwTE6pww1FnVqxQ/mQbbiJW79iJDT1Co+M6l+9PO2
        uMy91YqOX4yUAiBTIRdinEU=
X-Google-Smtp-Source: ABdhPJzfycVhMQwwXApDKWDgCAK3OwMR2lbsi++KFT1QOTNDWHRKC7mmpuNn4lmvCkCJYGXpnbVdzA==
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr32065101wmq.36.1624964516674;
        Tue, 29 Jun 2021 04:01:56 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u10sm16609971wmm.21.2021.06.29.04.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:01:56 -0700 (PDT)
Date:   Tue, 29 Jun 2021 11:01:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V commits for 5.14
Message-ID: <20210629110154.y7hegtxwjbo55kue@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210629

for you to fetch changes up to 7d815f4afa87f2032b650ae1bba7534b550a6b8b:

  PCI: hv: Add check for hyperv_initialized in init_hv_pci_drv() (2021-06-20 23:08:56 +0000)

Note that there may be a merge conflict with x86 tip tree due to a
comment movement. The correct resolution patch can be found at:

  https://lore.kernel.org/linux-next/20210621200125.46d66127@canb.auug.org.au/

Wei.

----------------------------------------------------------------
hyperv-next for 5.14
 - Just a few minor enhancement patches and bug fixes.
----------------------------------------------------------------
Andrea Parri (Microsoft) (1):
      scsi: storvsc: Use blk_mq_unique_tag() to generate requestIDs

Andres Beltran (1):
      Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer

Haiyang Zhang (1):
      PCI: hv: Add check for hyperv_initialized in init_hv_pci_drv()

Jiapeng Chong (2):
      hv_balloon: Remove redundant assignment to region_start
      drivers: hv: Fix missing error code in vmbus_connect()

Michael Kelley (1):
      Drivers: hv: Move Hyper-V extended capability check to arch neutral code

Praveen Kumar (1):
      x86/hyperv: fix logical processor creation

YueHaibing (1):
      hv_utils: Fix passing zero to 'PTR_ERR' warning

 arch/x86/hyperv/hv_init.c           |  47 ----------------
 arch/x86/kernel/cpu/mshyperv.c      |   2 +-
 drivers/Makefile                    |   2 +-
 drivers/hv/Makefile                 |   3 ++
 drivers/hv/channel.c                |  23 ++++----
 drivers/hv/connection.c             |   4 +-
 drivers/hv/hv_balloon.c             |   1 -
 drivers/hv/hv_common.c              |  66 +++++++++++++++++++++++
 drivers/hv/hv_fcopy.c               |   1 +
 drivers/hv/hv_kvp.c                 |   1 +
 drivers/hv/hv_util.c                |   4 +-
 drivers/hv/hyperv_vmbus.h           |   2 +-
 drivers/hv/ring_buffer.c            |  95 ++++++++++++++++++++++++++------
 drivers/net/hyperv/hyperv_net.h     |   7 +++
 drivers/net/hyperv/netvsc.c         |  10 ++--
 drivers/net/hyperv/rndis_filter.c   |   4 ++
 drivers/pci/controller/pci-hyperv.c |   3 ++
 drivers/scsi/storvsc_drv.c          | 104 +++++++++++++++++++++++++-----------
 include/linux/hyperv.h              |  61 +++++++++++++++++----
 net/vmw_vsock/hyperv_transport.c    |   4 +-
 20 files changed, 317 insertions(+), 127 deletions(-)
 create mode 100644 drivers/hv/hv_common.c
