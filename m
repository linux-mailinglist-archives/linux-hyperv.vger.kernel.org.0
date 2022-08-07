Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9023958BCEE
	for <lists+linux-hyperv@lfdr.de>; Sun,  7 Aug 2022 22:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiHGUoj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 7 Aug 2022 16:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHGUoi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 7 Aug 2022 16:44:38 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8550B62E6;
        Sun,  7 Aug 2022 13:44:37 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id l4so8799049wrm.13;
        Sun, 07 Aug 2022 13:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=PR3j4bog8pPMOjA9orzRxcsnCEIbbXpovcv+p87CHi4=;
        b=OH21hVGzWusfdyaZjo5YaXtZflDRXzE2AYWMoPVtax3YmOCW4SFPBZSFzAP7Y5b2tZ
         0+8reXgNh/eXmf0tz6HqDbynyFds8pIWpH5hJBD7yBK0b+nycibcry9VHpQ/cJqTB5SY
         h4v5FIOQfeQ3Tp3nhYpajGjOZTw/yGG0tEYKshlLQw0edRvIPVPMM86T4ZGNjAPtz/1x
         NtOApFqC6T8acyAa9KbvD5JMMpeA+bIa69t21EGBBYIi9HZachWI0SVDSeTls44F2Wkx
         TNT0CaLmGDeBpWNpuAd2+3Vy8wmkahgwS/VFjmSsEvXarwYIAEMlvXGeKb+yikANjqRb
         7l9w==
X-Gm-Message-State: ACgBeo3pLSmCrFODYTKu2toJVoB5frNnz34pygBj0syTcPBLZVpFu9Vf
        Pf/Lub+fpHS4rmAaFcN6AYKdr4vzOVc=
X-Google-Smtp-Source: AA6agR484PVx2gjGv91YCXEUs4vjgAODNVSeUDoaQ6sgiJv+n3uJDFEBGN8/l1lS0V7VLWvi406drw==
X-Received: by 2002:adf:fb43:0:b0:21a:22eb:da43 with SMTP id c3-20020adffb43000000b0021a22ebda43mr9491379wrs.347.1659905075751;
        Sun, 07 Aug 2022 13:44:35 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b4-20020adff904000000b0021e9fafa601sm9707536wrr.22.2022.08.07.13.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 13:44:35 -0700 (PDT)
Date:   Sun, 7 Aug 2022 20:44:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V next patches
Message-ID: <20220807204433.k4lcpmfbradclnnq@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220807

for you to fetch changes up to d180e0a1be6cea2b7436fadbd1c96aecdf3c46c7:

  Drivers: hv: Create debugfs file with hyper-v balloon usage information (2022-07-18 11:19:02 +0000)

----------------------------------------------------------------
hyperv-next 20220807

A few miscellaneous patches. There is no large patch series for this
merge window.

Their subject lines are self-explanatory so I don't bother summarizing
them.
----------------------------------------------------------------
Alexander Atanasov (1):
      Drivers: hv: Create debugfs file with hyper-v balloon usage information

Samuel Holland (1):
      PCI: hv: Take a const cpumask in hv_compose_msi_req_get_cpu()

Saurabh Sengar (1):
      drm/hyperv : Removing the restruction of VRAM allocation with PCI bar size

Shradha Gupta (1):
      Drivers: hv: vm_bus: Handle vmbus rescind calls after vmbus is suspended

 drivers/gpu/drm/hyperv/hyperv_drm_drv.c |  74 +----------------
 drivers/hv/connection.c                 |  11 +++
 drivers/hv/hv_balloon.c                 | 135 ++++++++++++++++++++++++++++++--
 drivers/hv/hyperv_vmbus.h               |   7 ++
 drivers/hv/vmbus_drv.c                  |  27 +++++--
 drivers/pci/controller/pci-hyperv.c     |   2 +-
 6 files changed, 170 insertions(+), 86 deletions(-)
