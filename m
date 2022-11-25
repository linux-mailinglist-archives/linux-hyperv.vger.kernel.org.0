Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01167638D04
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Nov 2022 16:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiKYPG7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Nov 2022 10:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiKYPGu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Nov 2022 10:06:50 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0603326F1;
        Fri, 25 Nov 2022 07:06:48 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id n3so7173422wrp.5;
        Fri, 25 Nov 2022 07:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kod/sSUm0wLDUTyF3c3Bwj38yqBYf7XmvKWJJ25nb04=;
        b=GKneF8XKf4Z2ezdNQYR/CUx2t/Bra9CHPG/d7qHpnGQVgAlRktDpBVWI3VZHGWk+Jq
         JzMIEimXrEZ3iypKM3+zPdOvPkxAXqw9A/rMQ3xrVaVR+6ks+HUaOp+xAWup5dCpMZw+
         sH9Ig/YGTSlR5bNfJI84fpFlmg5aVQVXdrxhImcUeA3p7jk5eanJr/pRu0of1G1MUwWp
         RO8BbQqo70wwiqnzTjo6WwBYqi6laiWXcvRNBC6ww9MhYyZc3rjVIB855J0PsmJFiJfI
         VShlc+QGivXq5bci/NeqUg0qPEWTIYKISbhX9XiqA9XvWSTd0pfQe8B0P/nENoGIDJmY
         1ABA==
X-Gm-Message-State: ANoB5pnVOjgSaZ9I/qH6qWYGcWpbB73mkrsID7Bu+yADUdRinmORP8cg
        s0+WHlwqG/8I52TJZ1Hz7Qyw+bcbzYo=
X-Google-Smtp-Source: AA0mqf6sEwnB3ICrjmBjS8jv+g4IxfnaY6jMWefHkGzHM1uDTPmR7LkuMwZwVRW001CsLMnJ6HHsSA==
X-Received: by 2002:a05:6000:a12:b0:241:c4d1:41a6 with SMTP id co18-20020a0560000a1200b00241c4d141a6mr20758450wrb.324.1669388807007;
        Fri, 25 Nov 2022 07:06:47 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003cf7292c553sm6443748wms.13.2022.11.25.07.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:06:46 -0800 (PST)
Date:   Fri, 25 Nov 2022 15:06:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 6.1-rc7
Message-ID: <Y4DaBH/mNVLQ2XhF@liuwe-devbox-debian-v2>
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

The following changes since commit e70af8d040d2b7904dca93d942ba23fb722e21b1:

  PCI: hv: Fix the definition of vector in hv_compose_msi_msg() (2022-11-03 15:50:28 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20221125

for you to fetch changes up to 25c94b051592c010abe92c85b0485f1faedc83f3:

  Drivers: hv: vmbus: fix possible memory leak in vmbus_device_register() (2022-11-21 10:57:42 +0000)

----------------------------------------------------------------
hyperv-fixes for 6.1-rc7
 - Fix IRTE allocation in Hyper-V PCI controller (Dexuan Cui)
 - Fix handling of SCSI srb_status and capacity change events (Michael
   Kelley)
 - Restore VP assist page after CPU offlining and onlining (Vitaly
   Kuznetsov)
 - Fix some memory leak issues in VMBus (Yang Yingliang)
----------------------------------------------------------------
Dexuan Cui (1):
      PCI: hv: Only reuse existing IRTE allocation for Multi-MSI

Michael Kelley (1):
      scsi: storvsc: Fix handling of srb_status and capacity change events

Vitaly Kuznetsov (1):
      x86/hyperv: Restore VP assist page after cpu offlining/onlining

Yang Yingliang (2):
      Drivers: hv: vmbus: fix double free in the error path of vmbus_add_channel_work()
      Drivers: hv: vmbus: fix possible memory leak in vmbus_device_register()

 arch/x86/hyperv/hv_init.c           | 54 +++++++++++-----------
 drivers/hv/channel_mgmt.c           |  6 ++-
 drivers/hv/vmbus_drv.c              |  1 +
 drivers/pci/controller/pci-hyperv.c | 90 ++++++++++++++++++++++++++++++-------
 drivers/scsi/storvsc_drv.c          | 69 ++++++++++++++--------------
 5 files changed, 141 insertions(+), 79 deletions(-)
