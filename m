Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA1E9AE1
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2019 12:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfJ3LhE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Oct 2019 07:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJ3LhE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Oct 2019 07:37:04 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266992083E;
        Wed, 30 Oct 2019 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572435423;
        bh=HADBrgwJF8SpkSFNq10ts5EgPNqAlWpwbph3HURGSoQ=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=Z4rFH4sd/tjdRCY3KYKxEQUOPmGTOmGj9NCpG77yAmzySv63TRVnesAiu1wBLh+tj
         dElVWv0nTVs0VM+p07Bd9hzzQ7OSrn7eKSvzefhnKHFhee5I4Hvd/65ptsUzG7dXr0
         5AWzgJwXO8iZiVdnNpbi/7CUjo7dyL6cI4Z2zujE=
From:   Sasha Levin <sashal@kernel.org>
Date:   Wed, 30 Oct 2019 07:37:00 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V commits for 5.4-rc
Message-Id: <20191030113703.266992083E@mail.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to 590c28b9199c99593b879cbb82d7d4be605894ec:

  Drivers: hv: vmbus: Fix harmless building warnings without CONFIG_PM_SLEEP (2019-10-28 12:24:53 -0400)

- ----------------------------------------------------------------
- - Fix a leak and improve the handling of the ring buffer in the Hyper-V
HID driver from Dexuan Cui.
- - Fix a (harmless) build warning in vmbus PM code by Dexuan Cui.
- - A fix for a build issue in the Hyper-V IOMMU driver resulting from
enablement on new architectures by Boqun Feng.

- ----------------------------------------------------------------
Boqun Feng (1):
      drivers: iommu: hyperv: Make HYPERV_IOMMU only available on x86

Dexuan Cui (2):
      HID: hyperv: Use in-place iterator API in the channel callback
      Drivers: hv: vmbus: Fix harmless building warnings without CONFIG_PM_SLEEP

 drivers/hid/hid-hyperv.c | 56 +++++++++---------------------------------------
 drivers/hv/vmbus_drv.c   |  6 ++++++
 drivers/iommu/Kconfig    |  2 +-
 3 files changed, 17 insertions(+), 47 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAl25dZ0ACgkQ3qZv95d3
LNwEXg/+LjI3+t8Qw5rd2aaCU2NUEVTQJA1bMOx8HT62lKVhrbPT7Y3XZ+zP2K9P
fE6c3bHjTnSymrAx3XMNO2qAXYocA6fo3ggNVleTSA7zrh21fIR2XV0NVDoDNZ/d
KEU/kJbAMyVADKRlwnKA9+O+bfOQhvP4wDb3r1fKaKQ+HznEw8rrbQ0NgohGRO0i
85diHq3KUkXfGvh1PzkzeXGSuxMlmoM/ZtsjE+8Okj4NU0R3Wp0nd6kJzi2EwkDz
ZGmxLpV5Se+qilA7gUfayhSdYS0UyFO0BX+rONfKPdEOLwxVS81/5wROwtivJ2xJ
gMqfZg78X8yiqEkFEMfVngxoeARzJGcFYiqjl8iOGL57tU875Mz2yZgAx1PH0J4y
nZ86X44A13ZViOYlMwV0JG0h94FRtiab3PeVbLCXNU1ULSBJcppLP4lUxdVgeZyz
F9xS6RY35QaGxyT1/cb+g2qr//TAXPQaJh4vnh5vEx/U3lI86+IyCs0xuaOhKP06
frdoXOTdRmLZoqm7ruoCt4gTJUIGbYvGruisAVifdS0401UxXssIKoh1/1CHbBE6
1/bUofBwNrXtyfbru2VyROxRqb/uxZj+UECQwRqJkkg4JUOglBz08h+O+Rjie79i
PrUjPAwhUAKxQ19Cj59M+r6MlT5U9L/Fp2q/BODk1gu1jC3bRAM=
=UL+8
-----END PGP SIGNATURE-----
