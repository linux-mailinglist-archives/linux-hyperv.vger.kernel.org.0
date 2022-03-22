Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15184E47D3
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Mar 2022 21:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiCVU4P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Mar 2022 16:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiCVU4O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Mar 2022 16:56:14 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DC56403;
        Tue, 22 Mar 2022 13:54:45 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id r13so10069182wrr.9;
        Tue, 22 Mar 2022 13:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Nm9kNxWjn7RnZBv7T0y2dpcp4X3ccJqY0HeY/D2prMg=;
        b=1wO5oV1GR/340cKtiuLmWpMy55MVgiNSDIkRt9YEFULoDGrvn2WXh97x8HjNNObCdu
         7iNPiT/Zw4FkEubhrWh5ApmkcsnSWA/vZogi0W6mwaGAkQktu6eXlcjblWhAKvf7s4kt
         yK33UQz9zan2nY52vZMCRrbXUD2aggc3Hxrzdb+qjxzN8KDAsmZ30G6GjYZ/dMdpXPLe
         PLcWR4IWjrfXkPpQaiHULIJnuAAb0s9gPLPZqd1hisfHg3p6wBmohqghq8aWiDqVt8+O
         DMoPSnmabnKrB5qdDYSC5RktUIKYDq7LFnVRuYLz4Qu0qM+6FMn/G7UDQdz8AWSG1A51
         4gUg==
X-Gm-Message-State: AOAM53117JlCX4RJtgCABCt+x3qfnnqtMXIjFU+ZlAMkhaH41R2Fj6rS
        SxGbduC6pV7goqDHLLK8Gdw=
X-Google-Smtp-Source: ABdhPJwMUpIb65NG6U4I7fCjG65Ju2blPyHep4hjnE+vnv2JJ/FNBvgFYbvAPI7Rc9Z9Uki0aR2gbw==
X-Received: by 2002:adf:f881:0:b0:203:f9b1:a6ab with SMTP id u1-20020adff881000000b00203f9b1a6abmr17046504wrp.410.1647982483671;
        Tue, 22 Mar 2022 13:54:43 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b0038c90f61942sm2624524wmq.28.2022.03.22.13.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 13:54:43 -0700 (PDT)
Date:   Tue, 22 Mar 2022 20:54:41 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V next for 5.18
Message-ID: <20220322205441.ah7k6aj7csdwa3b6@liuwe-devbox-debian-v2>
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

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220322

for you to fetch changes up to eeda29db98f429a3b6473117e6ce1c213ab614f2:

  x86/hyperv: Output host build info as normal Windows version number (2022-03-08 20:44:50 +0000)

----------------------------------------------------------------
hyperv-next for 5.18
  - Minor patches from various people
----------------------------------------------------------------
Anssi Hannula (1):
      hv_balloon: rate-limit "Unhandled message" warning

Gustavo A. R. Silva (1):
      Drivers: hv: vmbus: Use struct_size() helper in kmalloc()

Michael Kelley (2):
      hv_utils: Add comment about max VMbus packet size in VSS driver
      x86/hyperv: Output host build info as normal Windows version number

Stephen Brennan (1):
      drivers: hv: log when enabling crash_kexec_post_notifiers

Vitaly Kuznetsov (2):
      Drivers: hv: Rename 'alloced' to 'allocated'
      Drivers: hv: Compare cpumasks and not their weights in init_vp_index()

 arch/x86/kernel/cpu/mshyperv.c |  8 ++++----
 drivers/hv/channel_mgmt.c      | 19 +++++++++----------
 drivers/hv/hv_balloon.c        |  2 +-
 drivers/hv/hv_common.c         |  4 +++-
 drivers/hv/hv_snapshot.c       |  7 +++++--
 drivers/hv/hyperv_vmbus.h      | 14 +++++++-------
 drivers/hv/vmbus_drv.c         |  4 ++--
 include/uapi/linux/hyperv.h    | 11 +++++++++++
 8 files changed, 42 insertions(+), 27 deletions(-)
