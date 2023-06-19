Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C67736013
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 01:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFSXTh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jun 2023 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSXTg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jun 2023 19:19:36 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA68F9;
        Mon, 19 Jun 2023 16:19:35 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-54f73f09765so1818255a12.1;
        Mon, 19 Jun 2023 16:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216774; x=1689808774;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tm8k626C7qGMC9sSzDj2ShaNEjkau+rD80jKlJLNIXU=;
        b=NSBwLeE6MPpEmyYs/Wt+d/TwJtkBNOiZoGAp/+8ED/cgn/rCKzqtYDUuOuKPN3N9iQ
         +oZG3Cewwb5nf+wQFh8/+HTHMekO635Oy0qrJcwucA5oLqFhWN16lbYPMCksTooltlXA
         pUpr/UE6tL73UBhsO9IKMunQcjRDR3faEOJaaIDZ1qfnRvSLY9xD5OE3Izp9oX4rlpIO
         HXJUJdtv3PaP4u1e4bchC7LkfML6cws937ij3cyqQQp3pdk/8P3w2mJKIQgoePyxS4Fd
         i6/gySXnjevLv25+dUDDTLln+nZgDtrqUh3TGUf/DuXV7/JypJuZe0aO5RIGKCvX7f5Y
         hhUg==
X-Gm-Message-State: AC+VfDxIRtTq3SSto6tiEX8Br3tsegKZzCGyYtEpuHWzR3hYyqZsvfsB
        b/TBHD9uBxRFVfpO6di2gRE=
X-Google-Smtp-Source: ACHHUZ4g0kIAdH9egh+GmR2cwqNKvb0CxisOi4lkBa/DzqpEYgj4TFalHr26WMBiJsN99XMwoXKjLw==
X-Received: by 2002:a05:6a20:158d:b0:10d:951f:58ba with SMTP id h13-20020a056a20158d00b0010d951f58bamr8241163pzj.52.1687216774430;
        Mon, 19 Jun 2023 16:19:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902e88f00b001b53d3d911dsm327950plg.69.2023.06.19.16.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:19:33 -0700 (PDT)
Date:   Mon, 19 Jun 2023 23:19:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 6.4-rc8
Message-ID: <ZJDihKX5BT38Rkab@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20230619

for you to fetch changes up to 067d6ec7ed5b49380688e06c1e5f883a71bef4fe:

  PCI: hv: Add a per-bus mutex state_lock (2023-06-18 03:05:40 +0000)

----------------------------------------------------------------
hyperv-fixes for 6.4-rc8
  - Fix races in Hyper-V PCI controller (Dexuan Cui)
  - Fix handling of hyperv_pcpu_input_arg (Michael Kelley)
  - Fix vmbus_wait_for_unload to scan present CPUs (Michael Kelley)
  - Call hv_synic_free in the failure path of hv_synic_alloc (Dexuan
    Cui)
  - Add noop for real mode handlers for virtual trust level code
    (Saurabh Sengar)
----------------------------------------------------------------
Dexuan Cui (6):
      Drivers: hv: vmbus: Call hv_synic_free() if hv_synic_alloc() fails
      PCI: hv: Fix a race condition bug in hv_pci_query_relations()
      PCI: hv: Fix a race condition in hv_irq_unmask() that can cause panic
      PCI: hv: Remove the useless hv_pcichild_state from struct hv_pci_dev
      Revert "PCI: hv: Fix a timing issue which causes kdump to fail occasionally"
      PCI: hv: Add a per-bus mutex state_lock

Michael Kelley (3):
      Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs
      x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline
      arm64/hyperv: Use CPUHP_AP_HYPERV_ONLINE state to fix CPU online sequencing

Saurabh Sengar (1):
      x86/hyperv/vtl: Add noop for realmode pointers

 arch/arm64/hyperv/mshyperv.c        |   2 +-
 arch/x86/hyperv/hv_init.c           |   2 +-
 arch/x86/hyperv/hv_vtl.c            |   2 +
 drivers/hv/channel_mgmt.c           |  18 ++++-
 drivers/hv/hv_common.c              |  48 ++++++-------
 drivers/hv/vmbus_drv.c              |   5 +-
 drivers/pci/controller/pci-hyperv.c | 139 +++++++++++++++++++++---------------
 include/linux/cpuhotplug.h          |   1 +
 8 files changed, 129 insertions(+), 88 deletions(-)
