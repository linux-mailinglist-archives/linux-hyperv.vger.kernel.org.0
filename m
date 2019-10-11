Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E501D439A
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Oct 2019 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfJKPBH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Oct 2019 11:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfJKPBG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Oct 2019 11:01:06 -0400
Received: from localhost (unknown [216.243.17.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44699206CD;
        Fri, 11 Oct 2019 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570806066;
        bh=+dKL3nlFRBgEOBKqcEDRWWa7FCXXcAwLRghCPvETWd4=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=s/PPYHwKVSRDXPyMf5H4BNnvLTVBQOlHEmiGfPbCIUG83GL1WO6EAogY/cJ2IJuNc
         MbdgocKyg7fWZOtFtGaOaR3YNp4qGIex87vjtgRW/X+bT0sF6AUj/w1cXGMqNnQf3a
         uxE679MNdBQ+3uCkK5wM253M6Ie3eOzDtmd7yeHw=
From:   Sasha Levin <sashal@kernel.org>
Date:   Fri, 11 Oct 2019 11:01:05 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V commits for v5.4-rc
Message-Id: <20191011150106.44699206CD@mail.kernel.org>
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

for you to fetch changes up to 83b50f83a96899f30c6369ef5988412fa2354ab2:

  Drivers: hv: vmbus: Fix harmless building warnings without CONFIG_PM_SLEEP (2019-10-01 14:49:45 -0400)

- ----------------------------------------------------------------
Two fixes from Dexuan Cui:

 - Fix for a (harmless) warning when building vmbus without
CONFIG_PM_SLEEP.
 - Fix for a memory leak (and optimization) in the hyperv mouse code.

- ----------------------------------------------------------------
Dexuan Cui (2):
      HID: hyperv: Use in-place iterator API in the channel callback
      Drivers: hv: vmbus: Fix harmless building warnings without CONFIG_PM_SLEEP

 drivers/hid/hid-hyperv.c | 56 +++++++++---------------------------------------
 drivers/hv/vmbus_drv.c   |  6 ++++++
 2 files changed, 16 insertions(+), 46 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAl2gmN4ACgkQ3qZv95d3
LNxJ4Q/8DadwqP9vA75eReW1Ww55wxUprF4Vny+mtvaRYEEys4MKZwj4Dq/jSyon
D5X6WbphZZtAy+azhD5LKda6wsUZdSP4lJCX4QOq1nTGgFwzHEudXkshm0bJwJe9
B8nM7aAU0HuYi/RNBunEXoKUq5EZ7vNGaNs16iOWq30cnLhUSKNE/9fwTT3sC818
XhKJBKwZTDLYLzx8TXW3lgbhG6LG9ABKqnTLaKm0IiaGjvHSNjfdgh1hdWNOFdYE
zFPY9gT/Of7r6IM7O4G6BodGpvkkO6L+Gil6naAA9uDzasLM83NTlrFE26zYaf0l
n9diccfxOFnrstqR2yN82bKjgrfx9iv7tEODW66NeiWIvkJBzR2GfPdB9enHQ0dA
v3fTYny/XgaqnjIqj5WTIKwU+yGiwfiG0FjBhp/4ZFPRnfdg9ik0EoMkF7ZuK+37
OAbdoo6wDUns3Y49Z5WofK0okGXDKMHWuUlg2EmtQzsV5COUJyOz/bJTau0h2L+r
rp/ewkdp98+iozCyqRODDcBs9Za8pr/brME4+hYYvRiOCBunQU+RadOApev2jThe
GMNwwMclQo+AKGNmfPmq4Nul1stDpB6NIytud2pBxXqCZkAOadKRntgt/anc/1pt
XxEIfxVc6Ca1AqMOUoO3mxM6KoqjW6TmYx9it2sAk2aH9herwtM=
=9JAl
-----END PGP SIGNATURE-----
