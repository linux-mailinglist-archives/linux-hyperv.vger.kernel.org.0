Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE64B6B45
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Feb 2022 12:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiBOLhz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Feb 2022 06:37:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBOLhy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Feb 2022 06:37:54 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF903BF54;
        Tue, 15 Feb 2022 03:37:41 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso1239615wmq.4;
        Tue, 15 Feb 2022 03:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nzGDqbhu0Wl/32WelYjIbt2kiyQEkr31ABCIpew9vYE=;
        b=vys3Np6vQPwLZkndQK0ulubZQrQD2aXyUKJ6SpojqQ1/YOjK2yVgWFAXHCNb0TdlZl
         E/FkKETw/dy4HgDdLHzY19K9hMm3WUpfjcUR4UEiTTO9ms9/yL/cqTl/6ZwYbMUZgeC9
         eyVudCWTLWL1Mux304SjSnCsk91Ar+A4Wq2gEYS+IMlIO5nHJCAvtmWPd+PZkUm3x4w5
         AQ+fcMxvJJNPpNYZWFTWM8gldBHnIa/KbBMYFiLek+E0UKs2TcadZAnZuG3+M8Yg/X9C
         lnE14znhcQWcXNEafzYk6fJKrgZh2cfdiKkjPhCucsta+quLmZwdBRa4AOM/Ny+GccOQ
         tP3w==
X-Gm-Message-State: AOAM531DWSf+yLobDOeQ58/ap5SQ1+ZngMOADXRGC9DHv1kutcTxdXT5
        jDzCijuG59SBkUnR2ARJ2ng=
X-Google-Smtp-Source: ABdhPJysij4hHMdNvbblAfSvxt10FmWza9mHTmGndJe6es2yf5HqOb4Xb1wMYY3xF3XJJwvk6YPU0g==
X-Received: by 2002:a05:600c:1e88:: with SMTP id be8mr2743037wmb.125.1644925060305;
        Tue, 15 Feb 2022 03:37:40 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i3sm34392404wrq.72.2022.02.15.03.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 03:37:39 -0800 (PST)
Date:   Tue, 15 Feb 2022 11:37:38 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 5.17-rc5
Message-ID: <20220215113738.mewd4wwbw6defcuj@liuwe-devbox-debian-v2>
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

Hi Linus,

The following changes since commit 9ff5549b1d1d3c3a9d71220d44bd246586160f1d:

  video: hyperv_fb: Fix validation of screen resolution (2022-01-24 14:01:12 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20220215

for you to fetch changes up to ffc58bc4af9365d4eea72526bb3cf6a83615c673:

  Drivers: hv: utils: Make use of the helper macro LIST_HEAD() (2022-02-09 14:33:21 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.17-rc5
  - Rework use of DMA_BIT_MASK in vmbus to work around a clang bug
    (Michael Kelley)
  - Fix NUMA topology (Long Li)
  - Fix a memory leak in vmbus (Miaoqian Lin)
  - One minor clean-up patch (Cai Huoqing)
----------------------------------------------------------------
Cai Huoqing (1):
      Drivers: hv: utils: Make use of the helper macro LIST_HEAD()

Long Li (1):
      PCI: hv: Fix NUMA node assignment when kernel boots with custom NUMA topology

Miaoqian Lin (1):
      Drivers: hv: vmbus: Fix memory leak in vmbus_add_channel_kobj

Michael Kelley (1):
      Drivers: hv: vmbus: Rework use of DMA_BIT_MASK(64)

 drivers/hv/hv_utils_transport.c     |  2 +-
 drivers/hv/vmbus_drv.c              |  9 ++++++---
 drivers/pci/controller/pci-hyperv.c | 13 +++++++++++--
 include/linux/hyperv.h              |  1 +
 4 files changed, 19 insertions(+), 6 deletions(-)
