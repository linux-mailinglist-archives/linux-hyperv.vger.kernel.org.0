Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ADD2D98CC
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Dec 2020 14:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439865AbgLNN3U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Dec 2020 08:29:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34551 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439794AbgLNN3R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Dec 2020 08:29:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so8888540wrn.1;
        Mon, 14 Dec 2020 05:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CSLcLSc7CiiS7b7+SSoJyzYFL1moSrI19dfbunSKTh4=;
        b=T2OYeO5nWMQjSGPa7qAtcLMgtjs4BmZQ3LW1+opgcnq/l/6fV/jv5J6lfC/KqwEntV
         zVjlqRmaQYjBAmUQWSUNirCRRQZ9/ICtz3Q/L87ZKL0xR6HscWkP/3u94X98Ff9zd+sC
         DfgRmVFDxHdfmBMSW6ZjsjTr41z8wB5BGGzlxyqWAhhp0iXiYEPU7tLCQNVH0fBq8YuJ
         /DW59niXte5Ia7rx+VqDEG7c9Fxte0f3B6/Zg8m7pcLXGzf+diuDFejozt0KuOmtml4n
         EXj6qRcitMOT5yjpWqbmaaVUA7e57FOY5i0VWeBGid4qnkHV9n0oZ/LiMZRgWQHfHde/
         DPCQ==
X-Gm-Message-State: AOAM532+buiVuTJW7AqZpv/VrxGEjjNGIhC+i/CIs01dC9d5D/QfmnJI
        +QLC3ONKnmeSHR7czHF/Uw4=
X-Google-Smtp-Source: ABdhPJxw7J0qM0FdTD/4AUGg+xeSCh5/UoZOOnVs2GF9qzdNUI0UP8DCo79RTLI9GIZT61Wj5AzyRQ==
X-Received: by 2002:a5d:60cb:: with SMTP id x11mr29194226wrt.0.1607952515796;
        Mon, 14 Dec 2020 05:28:35 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n12sm34163067wrg.76.2020.12.14.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 05:28:35 -0800 (PST)
Date:   Mon, 14 Dec 2020 13:28:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: [GIT PULL] Hyper-V commits for 5.11
Message-ID: <20201214132833.vtqxw46vemhez5mb@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

Please pull the following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20201214

for you to fetch changes up to d1df458cbfdb0c3384c03c7fbcb1689bc02a746c:

  hv_balloon: do adjust_managed_page_count() when ballooning/un-ballooning (2020-12-13 15:06:10 +0000)

----------------------------------------------------------------
hyperv-next for 5.11
  - Patches from Andres Beltran to harden VMBus
  - Patches from Matheus Castello to clean up VMBus driver
  - Patches from Vitaly Kuznetsov to fix hv_balloon reporting
  - A patch from Andrea Parri to fix a potential OOB issue
  - A patch from Stefan Eschenbacher to remove an obsolete TODO item

----------------------------------------------------------------
Andrea Parri (Microsoft) (1):
      hv_netvsc: Validate number of allocated sub-channels

Andres Beltran (3):
      Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening
      scsi: storvsc: Use vmbus_requestor to generate transaction IDs for VMBus hardening
      hv_netvsc: Use vmbus_requestor to generate transaction IDs for VMBus hardening

Matheus Castello (5):
      drivers: hv: Fix hyperv_record_panic_msg path on comment
      drivers: hv: vmbus: Replace symbolic permissions by octal permissions
      drivers: hv: vmbus: Fix checkpatch LINE_SPACING
      drivers: hv: vmbus: Fix call msleep using < 20ms
      drivers: hv: vmbus: Fix checkpatch SPLIT_STRING

Stefan Eschenbacher (1):
      drivers/hv: remove obsolete TODO and fix misleading typo in comment

Vitaly Kuznetsov (2):
      hv_balloon: simplify math in alloc_balloon_pages()
      hv_balloon: do adjust_managed_page_count() when ballooning/un-ballooning

 drivers/hv/channel.c              | 174 ++++++++++++++++++++++++++++++++++++--
 drivers/hv/hv_balloon.c           |   5 +-
 drivers/hv/hyperv_vmbus.h         |   6 +-
 drivers/hv/ring_buffer.c          |  29 ++++++-
 drivers/hv/vmbus_drv.c            |  52 +++++++-----
 drivers/net/hyperv/hyperv_net.h   |  13 +++
 drivers/net/hyperv/netvsc.c       |  22 +++--
 drivers/net/hyperv/rndis_filter.c |   6 ++
 drivers/scsi/storvsc_drv.c        |  26 +++++-
 include/linux/hyperv.h            |  23 +++++
 10 files changed, 313 insertions(+), 43 deletions(-)
