Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BBD9BF05
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2019 19:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHXRjh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Aug 2019 13:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfHXRjh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Aug 2019 13:39:37 -0400
Received: from localhost (unknown [8.46.76.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A412146E;
        Sat, 24 Aug 2019 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566668376;
        bh=lg7cBLejUnCUIm/8Ksu5Im1ffp3HT/icNWP9P/u7q0w=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=x5XXvSniHxtgenvYKofe65l8lQ81Ewf4fhg0susaiYoP6QfO0vNG9W5z3xfZHPVtl
         LeBuqJIA0JtsipPdSl/++0+nBmXSG7teyBKqgmYp477ESQBpb5KxpU8qpKdLYPs7lp
         zkKy+yakS4oA8QgHkDB0aaTkGIOh8a3OTb8sutuk=
From:   Sasha Levin <sashal@kernel.org>
Date:   Sat, 24 Aug 2019 10:59:21 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V commits for v5.3-rc
Message-Id: <20190824173935.63A412146E@mail.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to a9fc4340aee041dd186d1fb8f1b5d1e9caf28212:

  Drivers: hv: vmbus: Fix virt_to_hvpfn() for X86_PAE (2019-08-20 12:49:57 -0400)

- ----------------------------------------------------------------
- - Fix for panics and network failures on PAE guests by Dexuan Cui.
- - Fix of a memory leak (and related cleanups) in the hyper-v keyboard
driver by Dexuan Cui.
- - Code cleanups for hyper-v clocksource driver during the merge window
by Dexuan Cui.
- - Fix for a false positive warning in the userspace hyper-v KVP store by
Vitaly Kuznetsov.

- ----------------------------------------------------------------
Dexuan Cui (3):
      Drivers: hv: vmbus: Remove the unused "tsc_page" from struct hv_context
      Input: hyperv-keyboard: Use in-place iterator API in the channel callback
      Drivers: hv: vmbus: Fix virt_to_hvpfn() for X86_PAE

Vitaly Kuznetsov (1):
      Tools: hv: kvp: eliminate 'may be used uninitialized' warning

 drivers/hv/channel.c                  |  2 +-
 drivers/hv/hyperv_vmbus.h             |  2 --
 drivers/input/serio/hyperv-keyboard.c | 35 ++++++-----------------------------
 tools/hv/hv_kvp_daemon.c              |  2 +-
 4 files changed, 8 insertions(+), 33 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAl1hUC4ACgkQ3qZv95d3
LNzfPQ/7B2htJA7ZjiRqqoTFN6yQBGuuyCeoJyZhYOTRc5CZ3IPnEg7wcZ5cJ9xi
3ByRiRPWn3hqYgZXDA7pS6K4vAk/Gkafnq9E7d3SGhSNF9d+n9YzcIG5haRpFCfM
nenQ1WCP6wXeF/VlwOCLnTIKPqWEzwaFAANvhbS/19Ab/6n8ww1J+jilvI1QOBCR
hcUjP6+4Q/QuBZLQ/451ol7KMbAJkCdlq8tNJ2/OUm5dExajJuTVU55W/Qozmf9o
X3Q7nKkK54N+iIj0N2oh8kaH0HzTLWM64qy48KDN5czgiQtTeesHq8BTkAldokPZ
xZgK0jkJkZQL43ZzYs257rslr59j8Ol7CgnnIPrtM0YIE9tCiZdwBblKV0XgL/7m
Op1cQheZc0gavm1ynq3/w0kOOdkBM32LExnJI112LfNP7nQPZ8MX+efT7z2IsMbh
QK/NxcQL7pbgPs640uWqFicMQR+umwwQomEb39LDUh1/uzQEw9YCgVZU1JkcxJjd
Se+ldSi1yEQJ66p1Jf2lyAdDiDg5OwvjZhL1SNmAvvwpw/tSY0t94cwpJxVZ8WuI
pRDvWcVdxBJUExr7u0BaUWu3J8hYl+974GFCt+66M7tKDf8bsCOsfeBEqfPN5PNb
/qU0a5pnQolJmEqdxY7TU0qBgA1xfaNbdJNrBOvsPr0dSRz4ElQ=
=Dwtt
-----END PGP SIGNATURE-----
