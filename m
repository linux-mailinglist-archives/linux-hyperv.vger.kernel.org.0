Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F53F2D3BF8
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 08:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgLIHJl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 02:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLIHJl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 02:09:41 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39A6C0613CF;
        Tue,  8 Dec 2020 23:09:00 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id a12so514347wrv.8;
        Tue, 08 Dec 2020 23:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rQ/ZNUdmFU7oDkw5NtjKgkVVT3OTRORzHlb5LdRReo=;
        b=n5iW5B90gp6ggoyILoLSD7BBJzFpQQMkLn2k+R3MF05cYARnPaTjBJPp4UlDiwrATG
         h9oRzdsEJQTAXMA86V4VFrL1AcW4UQuNS16yfN1ZRcMurjfso18n/ArKeOeawu+N93+5
         XJ/ynJrRA6obNpYwF4mWSONH0yJzKPY5rD2lF17Ruvjr1g7cp67pUYtWcPVND/vWcIrt
         fjrD/8Wu1ou8sILx+TvuXM6+mi7ashO7DKf7ibjjyp3nxQKtqeQPRrZRM3FmxZzl+XV3
         O3RD3cYR0xMlIbVA9j35YQ+K90AL+glkz+ljiLjZH5ktiPTvZpKFkvxVW5x1HogKfakN
         ihcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rQ/ZNUdmFU7oDkw5NtjKgkVVT3OTRORzHlb5LdRReo=;
        b=Hhdxh1vXrVrALKNjR+3of/6BnBx0W9i488PR74sBOp3WZZ3tiMvdHEi2SHSL07AIdv
         VF0BCIrlUATxPwPloscx+blpOSJP9FUg/DOWtYrPg+k+06WXggpHjH2Dbhuk0KOdJRgM
         FsZu6wfcHLQFSSqzvwynmN2pgwGvr8WXEGlMcoUIS4Vo/5SkScHPeLSZfI/D5sNqnu5k
         2I7rJ9uwNCkvU/XPY/28yQxputmp+FIIg5dbLFV7kLASqdwrWNhbhXYfk0b5U7R4DOqi
         hbxN0FMbv0OaLivwMZNQCQBnIirqHqTnuLUF9482jY8hvivl/qfOM+UXkevH6bbk6ncm
         sFFw==
X-Gm-Message-State: AOAM532YeWvMdQYNgpPJd7DMVrMBqPTzB8QyMk018T1bNG+vuFc7/eBd
        0pAdUTXvThVsCo61htd+8Acfe4oUVIxbIA==
X-Google-Smtp-Source: ABdhPJxeLpRClh2EhtswTaGwRoTrQASGOKBzVPPpmonz5vCGN1UJ2mBbDOEeEpfsfEAjwisw/Bn1Yg==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr945121wru.299.1607497739263;
        Tue, 08 Dec 2020 23:08:59 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id p3sm1449122wrs.50.2020.12.08.23.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 23:08:58 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v3 0/6] Drivers: hv: vmbus: More VMBus-hardening changes
Date:   Wed,  9 Dec 2020 08:08:21 +0100
Message-Id: <20201209070827.29335-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Integrating feedback from Juan, Michael and Wei. [1]  Changelogs are
inline/in the patches.

Thanks,
  Andrea

[1] https://lkml.kernel.org/r/20201202092214.13520-1-parri.andrea@gmail.com

Andrea Parri (Microsoft) (6):
  Drivers: hv: vmbus: Initialize memory to be sent to the host
  Drivers: hv: vmbus: Reduce number of references to message in
    vmbus_on_msg_dpc()
  Drivers: hv: vmbus: Copy the hv_message in vmbus_on_msg_dpc()
  Drivers: hv: vmbus: Avoid use-after-free in vmbus_onoffer_rescind()
  Drivers: hv: vmbus: Resolve race condition in vmbus_onoffer_rescind()
  Drivers: hv: vmbus: Do not allow overwriting
    vmbus_connection.channels[]

 drivers/hv/channel.c      |  4 +--
 drivers/hv/channel_mgmt.c | 55 +++++++++++++++++++++++++++------------
 drivers/hv/hyperv_vmbus.h |  2 +-
 drivers/hv/vmbus_drv.c    | 43 ++++++++++++++++++------------
 include/linux/hyperv.h    |  1 +
 5 files changed, 69 insertions(+), 36 deletions(-)

-- 
2.25.1

