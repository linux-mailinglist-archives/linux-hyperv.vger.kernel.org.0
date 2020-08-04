Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2284B23B88D
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Aug 2020 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgHDKP1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Aug 2020 06:15:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37455 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgHDKPU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Aug 2020 06:15:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id k8so2345084wma.2;
        Tue, 04 Aug 2020 03:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vsGbhhKgXTUUJkFhYjSRWE+DKY65nuYoudNERqqQhRU=;
        b=ZHGZWmri2HbiNqTykox0dNEQWDXZoB1H5fgHfuXPmKsHUpMcm/V2WQYgbTSEfhhTMt
         wEUQrwTjXm9WKgASIB4ZHnBQH3pmPq9+nT+rKC2aZVMMOT5vXto6iRL/SWS3S0ej6c21
         mRofqCxm1txYDwCA6sM35ilPCUlAexCmle3C6Q6LG7An30j5taAHpyFeWZZ9N+rz7RnW
         oq+ozHc/LtBvmoi7A+Q53xBLptD5diSGxbMs3dJLK1QoTY3s3cU+kO1V2hoHaJij6MkX
         ovFvCZBxkSJPq+FUOoN6hV9V2N5TIRxZ4+b8VtW9YVxSf8odFcKgUFrKpAAxV7ZQ6Yrs
         YifA==
X-Gm-Message-State: AOAM531XEvzENAfPf82c/CdEku11Nu8xfy5gnWAKfenvIdnMlVfZwbk9
        zP6vgEQlLLpBvKODSYb5akg=
X-Google-Smtp-Source: ABdhPJz9qmKOJQGeUFkACEeNFGz4MhV5U0n6Kn83N+9jCZYDEQroNOOHrHmY6g8uFBCrpN023CzreQ==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr3286704wmb.75.1596536118534;
        Tue, 04 Aug 2020 03:15:18 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d14sm29519453wre.44.2020.08.04.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 03:15:18 -0700 (PDT)
Date:   Tue, 4 Aug 2020 10:15:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V commits for 5.9
Message-ID: <20200804101516.xtytsljxre3wheae@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

Please pull the following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

for you to fetch changes up to 7deff7b5b4395784b194bae3631b8333d3423938:

  hyperv: hyperv.h: drop a duplicated word (2020-07-23 17:55:20 +0000)

----------------------------------------------------------------
hyperv-next for 5.9
  - A patch series from Andrea to improve vmbus code.
  - Two clean-up patches from Alexander and Randy.

----------------------------------------------------------------
Alexander A. Klimov (1):
      tools: hv: change http to https in hv_kvp_daemon.c

Andrea Parri (Microsoft) (8):
      Drivers: hv: vmbus: Remove the target_vp field from the vmbus_channel struct
      Drivers: hv: vmbus: Remove the numa_node field from the vmbus_channel struct
      Drivers: hv: vmbus: Replace cpumask_test_cpu(, cpu_online_mask) with cpu_online()
      Drivers: hv: vmbus: Remove unnecessary channel->lock critical sections (sc_list readers)
      Drivers: hv: vmbus: Use channel_mutex in channel_vp_mapping_show()
      Drivers: hv: vmbus: Remove unnecessary channel->lock critical sections (sc_list updaters)
      scsi: storvsc: Introduce the per-storvsc_device spinlock
      Drivers: hv: vmbus: Remove the lock field from the vmbus_channel struct

Randy Dunlap (1):
      hyperv: hyperv.h: drop a duplicated word

 drivers/hv/channel.c        |  9 +++------
 drivers/hv/channel_mgmt.c   | 31 ++++++-------------------------
 drivers/hv/hv.c             |  3 ---
 drivers/hv/vmbus_drv.c      | 17 +++++------------
 drivers/scsi/storvsc_drv.c  | 16 +++++++++++-----
 include/linux/hyperv.h      | 22 +++++++---------------
 include/uapi/linux/hyperv.h |  2 +-
 tools/hv/hv_kvp_daemon.c    |  2 +-
 8 files changed, 34 insertions(+), 68 deletions(-)
