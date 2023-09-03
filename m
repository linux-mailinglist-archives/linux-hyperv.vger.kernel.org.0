Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C421A790AD6
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Sep 2023 07:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbjICFBp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 3 Sep 2023 01:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjICFBp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Sep 2023 01:01:45 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05272116;
        Sat,  2 Sep 2023 22:01:42 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-34e1c1405easo1725435ab.1;
        Sat, 02 Sep 2023 22:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693717301; x=1694322101;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CaVDN1nihPl3lV/HLl0YpBXy4Ok1xeBZKYUuheQAYI=;
        b=J57BfiKhZ5omKuKMSgjCLX5oXKlmXIHaNpmq+PKa/qMetRoBn/hiwlL83ankQD7Yn8
         in3MROYsPU5vFu4EHWqJ8B9kifaY4+QJZFmeoKOvZ15MDWLTXiHlUGDeewFS6QWenZr+
         wzcSx9W6C+D2aaamcLZUNfqJ32/a67JTXpcqyoSAEDQtgWbdf3bJNWrG8yEx/jM3BrPv
         s+n0QiAF7IVquqpkApUhCURGHaZ/TpHjfJU+iYEXS71YkJY5VXj+dsva1o2Rck/sDyue
         Ha1xg5TsJYo0cb1PiDFzuGOJLz/LnElzcC+yJGPocVLOlU3vcMiUI8bIfiLYFi7gG2Pz
         reFw==
X-Gm-Message-State: AOJu0YwR/cjOjaowD9JTl5ldtKVeCbaKEI12wsfyVB41iuSgGY0wkMgA
        b0A6K1pF2IU6F/YfjnON5UU=
X-Google-Smtp-Source: AGHT+IFvWs2quJDRQGDGA4RuH5Ebl9T+mSdO8p3dS40ScCJgItVQl2248OPloWbbJn27q+Fh50SdOw==
X-Received: by 2002:a92:cb4e:0:b0:34c:d86f:46e9 with SMTP id f14-20020a92cb4e000000b0034cd86f46e9mr7232010ilq.12.1693717301105;
        Sat, 02 Sep 2023 22:01:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id mn3-20020a17090b188300b0027360359b70sm2280043pjb.48.2023.09.02.22.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 22:01:40 -0700 (PDT)
Date:   Sun, 3 Sep 2023 05:01:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V commits for 6.6
Message-ID: <ZPQTFyfzgvlp3QkW@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20230902

for you to fetch changes up to 284930a0146ade1ce0250a1d3bae7a675af4bb3b:

  x86/hyperv: Remove duplicate include (2023-08-25 00:05:45 +0000)

----------------------------------------------------------------
hyperv-next for v6.6
 - Support for SEV-SNP guests on Hyper-V (Tianyu Lan)
 - Support for TDX guests on Hyper-V (Dexuan Cui)
 - Use SBRM API in Hyper-V balloon driver (Mitchell Levy)
 - Avoid dereferencing ACPI root object handle in VMBus driver
   (Maciej S. Szmigiero)
 - A few misecllaneous fixes (Jiapeng Chong, Nathan Chancellor,
   Saurabh Sengar)
----------------------------------------------------------------
Dexuan Cui (11):
      x86/hyperv: Fix undefined reference to isolation_type_en_snp without CONFIG_HYPERV
      x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
      x86/hyperv: Support hypercalls for fully enlightened TDX guests
      Drivers: hv: vmbus: Support fully enlightened TDX guests
      x86/hyperv: Fix serial console interrupts for fully enlightened TDX guests
      Drivers: hv: vmbus: Support >64 VPs for a fully enlightened TDX/SNP VM
      x86/hyperv: Introduce a global variable hyperv_paravisor_present
      Drivers: hv: vmbus: Bring the post_msg_page back for TDX VMs with the paravisor
      x86/hyperv: Use TDX GHCI to access some MSRs in a TDX VM with the paravisor
      x86/hyperv: Remove hv_isolation_type_en_snp
      x86/hyperv: Move the code in ivm.c around to avoid unnecessary ifdef's

Jiapeng Chong (1):
      x86/hyperv: Remove duplicate include

Maciej S. Szmigiero (1):
      Drivers: hv: vmbus: Don't dereference ACPI root object handle

Mitchell Levy (1):
      hv_balloon: Update the balloon driver to use the SBRM API

Nathan Chancellor (1):
      x86/hyperv: Add missing 'inline' to hv_snp_boot_ap() stub

Saurabh Sengar (1):
      hv: hyperv.h: Replace one-element array with flexible-array member

Tianyu Lan (8):
      x86/hyperv: Add sev-snp enlightened guest static key
      x86/hyperv: Set Virtual Trust Level in VMBus init message
      x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP enlightened guest
      drivers: hv: Mark percpu hvcall input arg page unencrypted in SEV-SNP enlightened guest
      x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp enlightened guest
      clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp enlightened guest
      x86/hyperv: Add smp support for SEV-SNP guest
      x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES

 arch/x86/hyperv/hv_apic.c          |  15 ++-
 arch/x86/hyperv/hv_init.c          | 105 +++++++++++++--
 arch/x86/hyperv/ivm.c              | 263 +++++++++++++++++++++++++++++++++++--
 arch/x86/include/asm/hyperv-tlfs.h |  10 +-
 arch/x86/include/asm/mshyperv.h    |  71 ++++++++--
 arch/x86/kernel/cpu/mshyperv.c     |  91 ++++++++++++-
 drivers/clocksource/hyperv_timer.c |   2 +-
 drivers/hv/connection.c            |  16 ++-
 drivers/hv/hv.c                    | 131 ++++++++++++++++--
 drivers/hv/hv_balloon.c            |  82 ++++++------
 drivers/hv/hv_common.c             |  48 ++++++-
 drivers/hv/hyperv_vmbus.h          |  11 ++
 drivers/hv/vmbus_drv.c             |   3 +-
 include/asm-generic/hyperv-tlfs.h  |   1 +
 include/asm-generic/mshyperv.h     |  17 ++-
 include/linux/hyperv.h             |   6 +-
 16 files changed, 759 insertions(+), 113 deletions(-)
