Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D86770C67
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Aug 2023 01:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjHDX3g (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Aug 2023 19:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHDX3c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Aug 2023 19:29:32 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599A610D2
        for <linux-hyperv@vger.kernel.org>; Fri,  4 Aug 2023 16:29:31 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-686f25d045cso2025051b3a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 04 Aug 2023 16:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691191771; x=1691796571;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIvpjXFzOW4PHZ7iDQg7OcFVfcqV6VEM+eJL/5bVg2o=;
        b=QaGD9YCXC9hwmKr5hseLJy5VsqL8ECk2k4H5zUZrMnR4togVYbd2XWQbJhTDaBGK97
         zG+g2NWjSgJfriZV/Q0zlO1Jto/jelqac+aO4y8c1pYSVN1VFTH6buf26ayaqXVgWg+u
         if3YX5zpHZHusoBgKsvUoDpux5zweSEKuNl+SplHucTPaRWHE3hP/Oj4YoDLSdScISUf
         tVyWuNMEEfuGEBLtfTO1NAQMaoSsX7M/sL0rQ5TqETdjMro0K6rrDZbwtMZhvW9Xefgv
         3PPvNwPFg+6aAVQD4QOWEb8zk0/t2ALlxcQji0sidhRjxDahHIxMSXOcp1KMJ9lfrvr3
         q/GA==
X-Gm-Message-State: AOJu0Yx9VZUQZBTQPJpf+NnZxmEnqdxE2zLNG8NuNngJwQ7oyBvcdeGK
        pM51oTudznMinEDXcbebY3M=
X-Google-Smtp-Source: AGHT+IF74knsuhXNbf0VH7Vo47rEzvAwMfY/FBjHr21CkTjRwKNmXZDzneWcVmOLhoMS6rnlGTo5rg==
X-Received: by 2002:a05:6a21:498b:b0:13e:904b:5f8 with SMTP id ax11-20020a056a21498b00b0013e904b05f8mr2955124pzc.61.1691191770583;
        Fri, 04 Aug 2023 16:29:30 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902c19400b001bbb7af4963sm2276337pld.68.2023.08.04.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 16:29:30 -0700 (PDT)
Date:   Fri, 4 Aug 2023 23:29:22 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 6.5-rc5
Message-ID: <ZM2J0hRj7HXbFF+b@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit 6995e2de6891c724bfeb2db33d7b87775f913ad1:

  Linux 6.4 (2023-06-25 16:29:58 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20230804

for you to fetch changes up to 6ad0f2f91ad14ba0a3c2990c054fd6fbe8100429:

  Drivers: hv: vmbus: Remove unused extern declaration vmbus_ontimer() (2023-08-02 23:29:08 +0000)

----------------------------------------------------------------
hyperv-fixes for 6.5-rc5
 - Fixing a bug in a python script for Hyper-V (Ani Sinha)
 - Workaround a bug in Hyper-V when IBT is enabled (Michael Kelley)
 - Fix an issue for parsing MP table when Linux runs in VTL2 (Saurabh Sengar)
 - Several cleanup patches (Nischala Yelchuri, Kameron Carr, YueHaibing, ZhiHu)
----------------------------------------------------------------
Ani Sinha (1):
      vmbus_testing: fix wrong python syntax for integer value comparison

Kameron Carr (1):
      Drivers: hv: Change hv_free_hyperv_page() to take void * argument

Michael Kelley (1):
      x86/hyperv: Disable IBT when hypercall page lacks ENDBR instruction

Nischala Yelchuri (1):
      x86/hyperv: Improve code for referencing hyperv_pcpu_input_arg

Saurabh Sengar (1):
      x86/hyperv: add noop functions to x86_init mpparse functions

YueHaibing (1):
      Drivers: hv: vmbus: Remove unused extern declaration vmbus_ontimer()

ZhiHu (1):
      x86/hyperv: fix a warning in mshyperv.h

 arch/x86/hyperv/hv_apic.c       |  4 +---
 arch/x86/hyperv/hv_init.c       | 21 +++++++++++++++++++++
 arch/x86/hyperv/hv_vtl.c        |  4 ++++
 arch/x86/hyperv/ivm.c           |  7 +++----
 arch/x86/hyperv/mmu.c           | 12 ++----------
 arch/x86/hyperv/nested.c        | 11 ++---------
 arch/x86/include/asm/mshyperv.h |  2 +-
 drivers/hv/connection.c         | 13 ++++++-------
 drivers/hv/hv_balloon.c         |  2 +-
 drivers/hv/hv_common.c          | 10 +++++-----
 include/asm-generic/mshyperv.h  |  2 +-
 include/linux/hyperv.h          |  3 ---
 tools/hv/vmbus_testing          |  4 ++--
 13 files changed, 49 insertions(+), 46 deletions(-)
