Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7709115008E
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 03:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBCC1s (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 2 Feb 2020 21:27:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbgBCC1s (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 2 Feb 2020 21:27:48 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7473A205F4;
        Mon,  3 Feb 2020 02:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580696867;
        bh=a68+GV2ko4evTdfKpR5+M/MKoeUlK5EiIuHzfwvafCY=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=meoLxkCVSgWhjpRUiqUjzXQKikkVs0tt7z1tu0+1+HHjT9nrRGhsJTTZDsm5RBTsT
         8UwlQMnXap7EkVH2Htniz8Gm91jAfk/c4BnRFsEqTMWTtbsDNmWIn9vPq+rh/g27Sg
         gdCLSPyN0Dn7pr0VUbPDjXRNnesFsZCX931Vg6VM=
From:   Sasha Levin <sashal@kernel.org>
Date:   Sun, 02 Feb 2020 21:27:46 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V commits for v5.6
Message-Id: <20200203022747.7473A205F4@mail.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

for you to fetch changes up to 54e19d34011fea26d39aa74781131de0ce642a01:

  hv_utils: Add the support of hibernation (2020-01-26 22:10:17 -0500)

- ----------------------------------------------------------------
- - Most of the commits here are work to enable host-initiated hibernation
support by Dexuan Cui.
- - Fix for a warning shown when host sends non-aligned balloon requests
by Tianyu Lan.

- ----------------------------------------------------------------
Dexuan Cui (7):
      Input: hyperv-keyboard: Add the support of hibernation
      video: hyperv_fb: Fix hibernation for the deferred IO feature
      Drivers: hv: vmbus: Ignore CHANNELMSG_TL_CONNECT_RESULT(23)
      Tools: hv: Reopen the devices if read() or write() returns errors
      hv_utils: Support host-initiated restart request
      hv_utils: Support host-initiated hibernation request
      hv_utils: Add the support of hibernation

Tianyu Lan (1):
      hv_balloon: Balloon up according to request page number

Wei Hu (1):
      video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.

 drivers/hv/channel_mgmt.c             |  21 ++--
 drivers/hv/hv_balloon.c               |  13 +--
 drivers/hv/hv_fcopy.c                 |  54 +++++++++-
 drivers/hv/hv_kvp.c                   |  43 +++++++-
 drivers/hv/hv_snapshot.c              |  55 +++++++++-
 drivers/hv/hv_util.c                  | 148 +++++++++++++++++++++++++--
 drivers/hv/hyperv_vmbus.h             |   6 ++
 drivers/hv/vmbus_drv.c                |   4 +
 drivers/input/serio/hyperv-keyboard.c |  27 +++++
 drivers/video/fbdev/Kconfig           |   1 +
 drivers/video/fbdev/hyperv_fb.c       | 184 +++++++++++++++++++++++++++-------
 include/linux/hyperv.h                |   4 +
 tools/hv/hv_fcopy_daemon.c            |  37 ++++++-
 tools/hv/hv_kvp_daemon.c              |  36 ++++---
 tools/hv/hv_vss_daemon.c              |  49 +++++++--
 15 files changed, 574 insertions(+), 108 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAl43hNkACgkQ3qZv95d3
LNzSMA/7BCxCW9lMFzTCtL2bhAw48CFxFTpCvj5oM39kCLaxT99l/ub5BydOi8+2
URGnnWL+6wQSVpnCLjm6BBhbj8CX2jSoG7PgrsT5E1/wpMQafP8vVzi5HmBh2VJL
usL3ZrvbeHsRlHPr06l9QGe+CMr+eovfd51/v2/aiQEvzl/ekRBqctYH30boXRR3
CuknWJaS4MRuw5IdnSW6l1wfWn1uzpG5qRD7uHDvK0fkRRKq9Bd7gOOj525qrhYP
raLwziF3y6cAwco5YPgPWoQvPoT1Kx04CYi5+HH5na4OVXGxI0wNAJDiwuj9h94n
rfA0FfoBYU0vwT4cp++fIjp3wC2INe1rbrOapy6oFoVn/8wIUe7re23nAO04Vr+g
sRqDO1qkDQaqWHw27GbtiXtrb8Y5nHpvv6/dAWCNFQnXipeWHzRlF+ppgTi3aQLE
cl/GhqUVa10owOP06JiEB3ArPDh4UVetjOYAmF8LYkmEgo3nXK/Fptoi/BEUN5tY
L8iIdvSz5pkuZTM0pXyLjRfBozZCtHj4vx39Q6eyMkFqD1hPQi8zq1PqfdyMmucq
I33D515yl0qIVB/Qu/I+93ne2sdPQlC889lEDm8CwLbKoSDATYam64mPSd0gDuBU
YiNvjqSIfqa/uxPTk40C5Y/YdBgmOFKbM7Sx1XI8YVYvcRVZ9LM=
=tt50
-----END PGP SIGNATURE-----
