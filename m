Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138E9BBF8B
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2019 03:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392017AbfIXBDN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Sep 2019 21:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391905AbfIXBDN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Sep 2019 21:03:13 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C941520820;
        Tue, 24 Sep 2019 01:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569286992;
        bh=qmg0XKOekx1Lr0ZWPX6ojfaCtQmojTPifttjES8PVug=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=IS475RTN/QGdQKXxpG7VWLy5d4d8/khBojJoqkNzkeumPJY9A1mQMTmf8jEyY68dH
         vVY7djihvW6DGw4ylmMQ2dFFEKqyppt/X/+y7nTVT6+E1YEOzP6ClmArZCfLL0HqK1
         3DobOv716DUDnIKoNPY5r2ZDcD7ZafIluC/jss+0=
From:   Sasha Levin <sashal@kernel.org>
Date:   Mon, 23 Sep 2019 21:03:10 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V commits for 5.4
Message-Id: <20190924010311.C941520820@mail.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

for you to fetch changes up to d8bd2d442bb2688b428ac7164e5dc6d95d4fa65b:

  Drivers: hv: vmbus: Resume after fixing up old primary channels (2019-09-06 14:52:44 -0400)

- ----------------------------------------------------------------
- - First round of vmbus hibernation support from Dexuan Cui.
- - Removal of dependencies on PAGE_SIZE by Maya Nakamura.
- - Moving the hyper-v tools/ code into the tools build system by Andy
Shevchenko.
- - hyper-v balloon cleanups by Dexuan Cui.

- ----------------------------------------------------------------
Andy Shevchenko (1):
      Tools: hv: move to tools buildsystem

Dexuan Cui (11):
      hv_balloon: Use a static page for the balloon_up send buffer
      hv_balloon: Reorganize the probe function
      Drivers: hv: vmbus: Break out synic enable and disable operations
      Drivers: hv: vmbus: Suspend/resume the synic for hibernation
      Drivers: hv: vmbus: Add a helper function is_sub_channel()
      Drivers: hv: vmbus: Implement suspend/resume for VSC drivers for hibernation
      Drivers: hv: vmbus: Ignore the offers when resuming from hibernation
      Drivers: hv: vmbus: Suspend/resume the vmbus itself for hibernation
      Drivers: hv: vmbus: Clean up hv_sock channels by force upon suspend
      Drivers: hv: vmbus: Suspend after cleaning up hv_sock and sub channels
      Drivers: hv: vmbus: Resume after fixing up old primary channels

Maya Nakamura (1):
      HID: hv: Remove dependencies on PAGE_SIZE for ring buffer

 drivers/hid/hid-hyperv.c  |   4 +-
 drivers/hv/channel_mgmt.c | 161 +++++++++++++++++++++++++---
 drivers/hv/connection.c   |   8 +-
 drivers/hv/hv.c           |  66 +++++++-----
 drivers/hv/hv_balloon.c   | 143 ++++++++++++-------------
 drivers/hv/hyperv_vmbus.h |  30 ++++++
 drivers/hv/vmbus_drv.c    | 265 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hyperv.h    |  16 ++-
 tools/hv/Build            |   3 +
 tools/hv/Makefile         |  51 +++++++--
 10 files changed, 613 insertions(+), 134 deletions(-)
 create mode 100644 tools/hv/Build
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAl2Jaw0ACgkQ3qZv95d3
LNx6xg//WxLzQxi8rnxO2vYFWL9/Hq0ZZfUTHVE3FuRYJdI/IZlFhR0Kw/5MOcT3
PmAFuLNbGFDbDTP21oI+eXVHbrp8mWbSfNRR9EN/BGCErB6WAVTJlrm8ImEe8aBj
yDU4PjMp7gHwSCcuyYh813Uj9jlPybISyroCBnJ2q2M7iSLSb/wlUR+3KB+p99eS
ScyAl0KS7f/hUI1MRUEJ/0i+buEGwG9uBGsEFcicVLqNwD1Mly1ulmyXY6oQm+QZ
P7/PO7k3h/nlCr5QI9rJVsZqy0pZcRp5RI9JIriPHyCQNxy2V7bpvl979XtrODv6
3F2UNBw4I73XUZ4GcQlGeM7kVAc6CuuyiKnbRqa58e4Bjnhzj+VDbk5Brf4LFyYl
ZG4rDuBTBU5cfKi2fjmasYjgfGtQdWdhTeJM+aqsT7ScyevH/8N7k1Vte9K1s5O8
xx1MszBQ27/KxMqKD8TiL2GKQU036FiQdEnnS8We1XD1ryCR6EA+WgWRQennsZa0
jUbGJOTI3SPcjxM8oHzuiJSIK6gKRq+zKY51EVeTNwEOCPnp+WwqVO9I8inVSN0m
WwJd84pxGXuqjjIe8FvmtUE3B0AF7bW8bPV+aNeDEtPOPMPzSW9HHKWS+rllKnsA
3Z4ktdCl1Al8dsKU9mJPuzAGn0Sxg3zKQ9VPTvZUQt2WYRWjKi4=
=y2xA
-----END PGP SIGNATURE-----
