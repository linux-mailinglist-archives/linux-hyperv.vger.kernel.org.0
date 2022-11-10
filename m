Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C6D624CC9
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Nov 2022 22:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKJVUD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Nov 2022 16:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKJVUC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Nov 2022 16:20:02 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EB3BB4;
        Thu, 10 Nov 2022 13:20:01 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id w14so4030138wru.8;
        Thu, 10 Nov 2022 13:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGQnIXEIAxYBs4pZEA120RBnVil7XdWyPz26Nc7lr1s=;
        b=kd0RWtcPJ5vn2eQMSWCosTG9lPurl5KbKT7wTlD1UUQTfjxIinV2wvBA6ZRY9JT7H/
         kW56sx7Ej7tqECpZ/NXD8MvxHJ6LtLqS82b4aNQmDi1jH2jPfrBoGxktuK4nA/JDMahG
         DKBNLiGWFm5/uZSy+dBYAOS1UMFxRJ39cVLhdbW3hph9Ws2GiVGL1fN75Y6VdzweSSum
         3IB+nGOq0V5odkttaRAKqWrrZ/8spv4nGsG7bU5qscWLUSF74nHYA4UK8WK8XNGuo+9p
         4asCs2fpMDnJ4M/LWct/FZkQdWu1VXBSUlaAdBZraRmZA/WgoGP4adgnVYKe0Gvc7HfA
         rAag==
X-Gm-Message-State: ACrzQf3/KOGazl9C57gvzbvvJDaivS7qswomnk+qDIseLNXgQCuOM5MG
        Gsl1Twka+O8eh9cDqe5HZwB6uyiBSqs=
X-Google-Smtp-Source: AMsMyM6kN4tNlAB9XgZVNBYkQvoSd0QdC3/mHTOGYurmfCOtCcaIv/AQpolDpAYXGaJWZilHVBv4cA==
X-Received: by 2002:a5d:5710:0:b0:236:cdd4:4cf4 with SMTP id a16-20020a5d5710000000b00236cdd44cf4mr38255171wrv.376.1668115200006;
        Thu, 10 Nov 2022 13:20:00 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003b435c41103sm8367301wmo.0.2022.11.10.13.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:19:59 -0800 (PST)
Date:   Thu, 10 Nov 2022 21:19:57 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 6.1-rc5
Message-ID: <Y21q/c7CywEAdiDo@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20221110

for you to fetch changes up to e70af8d040d2b7904dca93d942ba23fb722e21b1:

  PCI: hv: Fix the definition of vector in hv_compose_msi_msg() (2022-11-03 15:50:28 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.1-rc5
 - Fix TSC MSR write for root partition (Anirudh Rayabharam)
 - Fix definition of vector in pci-hyperv driver (Dexuan Cui)
 - A few other misc patches
----------------------------------------------------------------
Anirudh Rayabharam (2):
      clocksource/drivers/hyperv: add data structure for reference TSC MSR
      x86/hyperv: fix invalid writes to MSRs during root partition kexec

Dexuan Cui (1):
      PCI: hv: Fix the definition of vector in hv_compose_msi_msg()

Jilin Yuan (1):
      Drivers: hv: fix repeated words in comments

Stephen Hemminger (1):
      MAINTAINERS: remove sthemmin

Zhao Liu (1):
      x86/hyperv: Remove BUG_ON() for kmap_local_page()

 MAINTAINERS                         |  1 -
 arch/x86/hyperv/hv_init.c           | 19 ++++++++++---------
 drivers/clocksource/hyperv_timer.c  | 29 +++++++++++++++--------------
 drivers/hv/hv_balloon.c             |  2 +-
 drivers/pci/controller/pci-hyperv.c | 22 ++++++++++++++++------
 include/asm-generic/hyperv-tlfs.h   |  9 +++++++++
 6 files changed, 51 insertions(+), 31 deletions(-)
