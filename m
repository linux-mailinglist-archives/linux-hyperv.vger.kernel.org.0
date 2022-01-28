Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C549FD8E
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 17:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiA1QDs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 11:03:48 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:39924 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiA1QDr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 11:03:47 -0500
Received: by mail-wm1-f50.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso8501901wmh.4;
        Fri, 28 Jan 2022 08:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dfivR9duFF12f7+6yAgovh6L+nViV0lQs8MikOxe6qo=;
        b=h0lTgnxuEq+WAlL7/ao4ADV67Nfhc+i2s72cIdkaLP4JznSRqkv3/z78gSQmemxbrk
         9ui2r2Du0rUvmAnADJoRXZ0Q0g5HOLdJGQh5gqx2ssQTZPasIzef7IVtXrN4keVY/yhp
         2quX0ZvN9OBYGD6ywq03QUqTjOBSlFqwf0TpwsG/qKkMjjP6Ho8sT84/t6aI9WNe2ER1
         GJrw1enSnPsuA9ruNTiD27D/tQw5WJWXAoo8KejnjBRgpW7isewIG2Co2NFi22fsx1QA
         B0Xqv+kfn89/LPbty5KBDwEygJ0yDynIb4cV7DiIWJRRwI3Vape7lkTPRN266HumWalD
         3jYA==
X-Gm-Message-State: AOAM531WzSnNkbjx64swxhaM/54uWXyISEOSvD0afMWd8Cm+Kfd4fv/Z
        Jm9x8jmbvP5TjfI28ws5hXc=
X-Google-Smtp-Source: ABdhPJy9E6HnRIQR1YPTnxsCqZGUSxQBRCy9FCV2jv08kLdf4Q6yoiTXd9NZr4ZDlErsZ6w7CeyC0g==
X-Received: by 2002:a05:600c:22d4:: with SMTP id 20mr16819751wmg.41.1643385826465;
        Fri, 28 Jan 2022 08:03:46 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t1sm6009345wre.45.2022.01.28.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:03:46 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:03:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 5.17-rc2
Message-ID: <20220128160344.ihcyofyvxvgwq2r4@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220128

for you to fetch changes up to 9ff5549b1d1d3c3a9d71220d44bd246586160f1d:

  video: hyperv_fb: Fix validation of screen resolution (2022-01-24 14:01:12 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.17-rc2
  - Fix screen resolution for hyperv framebuffer (Michael Kelley)
  - Fix packet header accounting for balloon driver (Yanming Liu)
----------------------------------------------------------------
Michael Kelley (1):
      video: hyperv_fb: Fix validation of screen resolution

Yanming Liu (1):
      Drivers: hv: balloon: account for vmbus packet header in max_pkt_size

 drivers/hv/hv_balloon.c         |  7 +++++++
 drivers/video/fbdev/hyperv_fb.c | 16 +++-------------
 2 files changed, 10 insertions(+), 13 deletions(-)
