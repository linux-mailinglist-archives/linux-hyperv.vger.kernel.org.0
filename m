Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258A81FD287
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2020 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFQQrm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jun 2020 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQQrm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jun 2020 12:47:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E316EC06174E;
        Wed, 17 Jun 2020 09:47:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c71so2514744wmd.5;
        Wed, 17 Jun 2020 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzP90zRfteOPiS50AHA0iyJn5jZaMdoAKPdTATIDAk0=;
        b=Ro/jAlAGw4M2CS3G8RW2pmQS0ola4zCJwUlkGuTXUbDBGqMbBtSiYZteSps6NttKMp
         HkMJAlwjxnEBSRTJV2G6IBclkeXtjnXJSOoqrpgPpVXg6tTucJZeM9bUzE28ibqFnCWh
         ezG1UHM8ATn0fUhAMrrgThRsQwTlQQY+BeqbGrGZ12LttEPvvla9u+k/SgwwhKrU8/LP
         5sIzGTxXn6aO6LM8RDLtZnyQL+9ciyarmbpEFMvNh0URuRLjNRZM8eHwEXJy+FF7uL5e
         mbhzsZryWAE8hFF9rf8kb3kx4RWpM9d8sBvWiuNiOSbIfR+IEBLIqv43CCixMDkAjwMB
         ugVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzP90zRfteOPiS50AHA0iyJn5jZaMdoAKPdTATIDAk0=;
        b=R3hi57Kgkb0mjqiDhRpSTg08S5zcwkly11XksiFHmB5qSeBo8Bi3EyJuODDbC9hhQN
         H0+/WPmyBQwsXucIdXVIrz7OFnHinTaSpdWztDfmZOAwAMpf6A4Gp1/3X30NcjWfDX28
         VVi6JfH2HRAVigKAYnTKei8KTv+7kNn7yHDLrytNk+VhbdD81bR6gbbjEhTpYV+UIR1e
         vw80rQNTXK+fDzuobbGaFUxL/ubkqd23Ghfq/+0CwXr5VFuzsGCMgQ6m1yeib5NcaW8B
         /vRQlaVgEutbT0Bh327Zftat94rbTQzS0ZLMBm0qMPgUCnSY8uaclc2XRcWOlgrozdTw
         xJ3A==
X-Gm-Message-State: AOAM533j5D4StQDjqTyi01VaK14oEW4ugvnhjinxyBInujCTi/eQ7v2l
        d6v8nf61quRQjZGbKsSAr8Y=
X-Google-Smtp-Source: ABdhPJwz6NM2m53Nl29prWuICuKsCu4NxVmzz62srThpnPMfT5RbQ7t9ixisr3khn6OfyBYn1JD9Ng==
X-Received: by 2002:a05:600c:21c2:: with SMTP id x2mr9532127wmj.33.1592412460358;
        Wed, 17 Jun 2020 09:47:40 -0700 (PDT)
Received: from localhost.localdomain (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id g3sm199165wrb.46.2020.06.17.09.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:47:39 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 0/8] Drivers: hv: vmbus: Miscellaneous cleanups
Date:   Wed, 17 Jun 2020 18:46:34 +0200
Message-Id: <20200617164642.37393-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

I went back to my "cleanup list" recently and I wrote these patches:
here you can find, among other things,

  1) the removal of the fields 'target_vp' and 'numa_node' from the
     channel data structure, as suggested by Michael back in May;

  2) various cleanups for channel->lock, which is actually *removed
     by the end of this series!  ;-)

I'm sure there is room for further "cleanups",  ;-) but let me check
if these (relatively small) changes make sense first...

Thanks,
  Andrea

Andrea Parri (Microsoft) (8):
  Drivers: hv: vmbus: Remove the target_vp field from the vmbus_channel
    struct
  Drivers: hv: vmbus: Remove the numa_node field from the vmbus_channel
    struct
  Drivers: hv: vmbus: Replace cpumask_test_cpu(, cpu_online_mask) with
    cpu_online()
  Drivers: hv: vmbus: Remove unnecessary channel->lock critical sections
    (sc_list readers)
  Drivers: hv: vmbus: Use channel_mutex in channel_vp_mapping_show()
  Drivers: hv: vmbus: Remove unnecessary channel->lock critical sections
    (sc_list updaters)
  scsi: storvsc: Introduce the per-storvsc_device spinlock
  Drivers: hv: vmbus: Remove the lock field from the vmbus_channel
    struct

 drivers/hv/channel.c       |  9 +++------
 drivers/hv/channel_mgmt.c  | 31 ++++++-------------------------
 drivers/hv/hv.c            |  3 ---
 drivers/hv/vmbus_drv.c     | 17 +++++------------
 drivers/scsi/storvsc_drv.c | 16 +++++++++++-----
 include/linux/hyperv.h     | 22 +++++++---------------
 6 files changed, 32 insertions(+), 66 deletions(-)

-- 
2.25.1

