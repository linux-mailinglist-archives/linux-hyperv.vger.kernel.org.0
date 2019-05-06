Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5797143C4
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 May 2019 05:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfEFDbN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 May 2019 23:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFDbM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 May 2019 23:31:12 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3EBA205F4;
        Mon,  6 May 2019 03:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557113471;
        bh=M9uXTWCd59i3yL6Lq9BMIF3NB6ZynI9y1lfWYrkc0Po=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=JFm/4GN5qJ//IwxVQwrSW4GpzikcmvWf1kHLPKjVxc9IF7GBd8BIMSmR7PjhngIQQ
         Vyp3JOLnsH0xy8ejoOiPYitbqBaAMWRFuaL5jXSy8IjIqS8GCVmn3bOHRfJU7OL4vJ
         6kXEjlieB3L3g2fkaw1jRhu9dNh1Fx0h4OTSNI14=
From:   Sasha Levin <sashal@kernel.org>
Date:   Sun, 05 May 2019 23:31:04 -0400
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     haiyangz@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V commits for 5.2
Message-Id: <20190506033111.A3EBA205F4@mail.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

for you to fetch changes up to a3fb7bf369efa296c1fc68aead1b6fb3c735573b:

  drivers: input: serio: Add a module desription to the hyperv_keyboard driver (2019-04-23 15:41:40 -0400)

- ----------------------------------------------------------------
Adding module description to various hyper-v modules

- ----------------------------------------------------------------
Joseph Salisbury (3):
      drivers: hid: Add a module description line to the hid_hyperv driver
      drivers: hv: Add a module description line to the hv_vmbus driver
      drivers: input: serio: Add a module desription to the hyperv_keyboard driver

 drivers/hid/hid-hyperv.c              | 2 ++
 drivers/hv/vmbus_drv.c                | 1 +
 drivers/input/serio/hyperv-keyboard.c | 2 ++
 3 files changed, 5 insertions(+)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAlzPqkQACgkQ3qZv95d3
LNwABg//b9MataFZTizTER4WnV5+PWOeK+gEh5nlpM63vgzkx9G3WYT7XydhdoT4
vaw77zNEMHChyxIEn6s4BLpOk8nAP3L8VyvgxUDSemmjV9/FCDz4D98IoFMeWuWO
97HER2DUC9r/RejYz7qb2lGMesIkAFZkYAFdcg8coswP1WWS5dM0CnyTFb7wjvFu
MVRHCH3W6i55sZVid2YE2qm2gmza8wIJYkggoTUwKeRcOWyz1s9VNknpTi/8BaeK
0dsnrvfw7jdYL89QKkU4J4n8EycyNopibK2d35kj/6KiMrUs91YXTlncdS68WZ+t
8OhLs7Vk4XV5yxT+LApX0teON7NI5irVzrLNBPkNUcBRwRWD0oJhHCfy4p5ulEQ2
yKWEHJ4noZNGeJvrjEuhEn+mGKxjk8zvxY39qXUddWT2MXyjVyUtyxykDlYFLd+H
b3a3qDIrR/QM5jTmA/xoxjwFoqJnjcMakdz2kZAVqeNVHEi20lQrZJFa1RBw4dD/
hw1SOZUI6thDn4QCTPVJiva4w+zEqCocm1+qwoFevMig0LSH7+IymBde5S7heha6
Hj0BTKKsQndhD/utA8HWpBebfmZSqA0vK8SSfIcPLlAxU9QVeiYU/0qgLEpqFN5/
LCmbe0THf4RdryqJWjZbLe8qRzrhNEetSQibEPY+QuiiOeZJBjw=
=vWC7
-----END PGP SIGNATURE-----
