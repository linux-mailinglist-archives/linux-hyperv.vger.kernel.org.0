Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE0F10CBAA
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Nov 2019 16:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfK1PZe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Nov 2019 10:25:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfK1PZe (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Nov 2019 10:25:34 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF4D2168B;
        Thu, 28 Nov 2019 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574954733;
        bh=SXi1FhBxOBc8pfX0BP+8av8//BEzAd2vxFMoZ4HWUcs=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=FhmSZ9N7rJ/ov/Z9581j7Q5CvOrHagCkU2yASsIhCifgrco9C0CTVa0mxvzxSnHbz
         CEP0Jwe6eMrz1XA4CQ1TvRd/ZlYlQtD+D8uYvanchjiT0Ir2Lba+URbLQcGZlTquv4
         K+rFWr/+C3Q0ja2TmuHiLzteMjokBYKdyQ3TdCuA=
From:   Sasha Levin <sashal@kernel.org>
Date:   Thu, 28 Nov 2019 10:25:31 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V commits for v5.5
Message-Id: <20191128152532.DAF4D2168B@mail.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

for you to fetch changes up to 7a1323b5dfe44a9013a2cc56ef2973034a00bf88:

  Drivers: hv: vmbus: Fix crash handler reset of Hyper-V synic (2019-11-21 20:10:46 -0500)

- ----------------------------------------------------------------
- - Support for new VMBus protocols (Andrea Parri).
- - Hibernation support (Dexuan Cui).
- - Latency testing framework (Branden Bonaby).
- - Decoupling Hyper-V page size from guest page size (Himadri Pandya).

- ----------------------------------------------------------------
Andrea Parri (3):
      Drivers: hv: vmbus: Introduce table of VMBus protocol versions
      Drivers: hv: vmbus: Enable VMBus protocol versions 4.1, 5.1 and 5.2
      Drivers: hv: vmbus: Add module parameter to cap the VMBus version

Boqun Feng (1):
      drivers: iommu: hyperv: Make HYPERV_IOMMU only available on x86

Branden Bonaby (2):
      drivers: hv: vmbus: Introduce latency testing
      tools: hv: add vmbus testing tool

Davidlohr Bueso (1):
      drivers/hv: Replace binary semaphore with mutex

Dexuan Cui (7):
      scsi: storvsc: Add the support of hibernation
      video: hyperv_fb: Add the support of hibernation
      hv_sock: Add the support of hibernation
      hv_netvsc: Add the support of hibernation
      x86/hyperv: Implement hv_is_hibernation_supported()
      hv_balloon: Add the support of hibernation
      HID: hyperv: Add the support of hibernation

Himadri Pandya (5):
      Drivers: hv: Specify receive buffer size using Hyper-V page size
      Drivers: hv: util: Specify ring buffer size using Hyper-V page size
      x86: hv: Add function to allocate zeroed page for Hyper-V
      Drivers: hv: vmbus: Remove dependencies on guest page size
      Drivers: hv: balloon: Remove dependencies on guest page size

Michael Kelley (1):
      Drivers: hv: vmbus: Fix crash handler reset of Hyper-V synic

Wei Hu (2):
      video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V host
      video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver

 Documentation/ABI/testing/debugfs-hyperv |  23 ++
 MAINTAINERS                              |   1 +
 arch/x86/hyperv/hv_init.c                |  15 ++
 arch/x86/include/asm/mshyperv.h          |   1 +
 drivers/hid/hid-hyperv.c                 |  34 +++
 drivers/hv/Makefile                      |   1 +
 drivers/hv/connection.c                  |  87 ++++---
 drivers/hv/hv_balloon.c                  | 112 ++++++--
 drivers/hv/hv_debugfs.c                  | 178 +++++++++++++
 drivers/hv/hv_fcopy.c                    |   3 +-
 drivers/hv/hv_kvp.c                      |   3 +-
 drivers/hv/hv_snapshot.c                 |   3 +-
 drivers/hv/hv_util.c                     |  13 +-
 drivers/hv/hyperv_vmbus.h                |  31 +++
 drivers/hv/ring_buffer.c                 |   2 +
 drivers/hv/vmbus_drv.c                   |  27 +-
 drivers/iommu/Kconfig                    |   2 +-
 drivers/net/hyperv/hyperv_net.h          |   3 +
 drivers/net/hyperv/netvsc_drv.c          |  57 ++++
 drivers/scsi/storvsc_drv.c               |  41 +++
 drivers/video/fbdev/Kconfig              |   1 +
 drivers/video/fbdev/hyperv_fb.c          | 428 ++++++++++++++++++++++++++++---
 include/asm-generic/mshyperv.h           |   2 +
 include/linux/hyperv.h                   |  31 ++-
 lib/Kconfig.debug                        |   7 +
 net/vmw_vsock/hyperv_transport.c         |  20 ++
 tools/hv/vmbus_testing                   | 376 +++++++++++++++++++++++++++
 27 files changed, 1386 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-hyperv
 create mode 100644 drivers/hv/hv_debugfs.c
 create mode 100755 tools/hv/vmbus_testing
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAl3f5okACgkQ3qZv95d3
LNwLEQ//biCeM3j2rks/f2pEaY1CM2dGDHpi8wRwgnN1RNvWpc/M6JFGM/+g6a3j
U0FDmCU2mTdomM09zInq7RYW1ahHMGLO8shzvuP7LZxUdElzaaGXBVmOjFbL4NRJ
9vpDjhdpBmfR1Zy6ekLszp8NH9ZHR0FGmXt99Ljtjg8nyxBbSgBohVosbOkN55NQ
x7kLa9dPB0tm7mMCLCm00PK7+U5e520D0sML1YfMpf7FJROz+locdILI6IBRdN56
9xSSJV/hVmcGxr3tG3Aa7wQc30Hp64T2BjF9wv7yJMU98bJJE0lNP18FM/AbHi9P
YGSL9jFM26a8BFxgsBou+kLZCotk4A+MAV5jLU83g9/8tfLSBk2zVlPb1Bk6V8in
6KBP4GaBCTOa2OoL6QD/8mny+weByCaB4silgzjThBQ/BMjcQu9TpLp19GXSAZk3
dJhZkK/qYgqr4u7GOgnsVtrk2cU66YIT5+FBWt4wWhVCdvOa5BeSvYEks+eb+qFl
RUM0iI7y1BhLORztoMttLS+wrBh/Thm+UtEg2/ipI0R2JuKRsYLcbw+QATW2l02W
8mDeM94Z9KcHIMUy1MO5X+VeAfSgTzT0zBoeC5IeC5VAZNu02aoVKfLNM30vD7rY
IkdiUoLBNmKNrfbw7o+py820bFLzgYDKeDckKe2cMDXGrnykpQA=
=6xUH
-----END PGP SIGNATURE-----
