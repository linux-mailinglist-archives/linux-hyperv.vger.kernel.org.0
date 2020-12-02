Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F02CB8AC
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 10:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgLBJXX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 04:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgLBJXW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 04:23:22 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A42C0613D4;
        Wed,  2 Dec 2020 01:22:36 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k14so2728705wrn.1;
        Wed, 02 Dec 2020 01:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwrjU6762QSJwiWh0r8/mVMOyaJCyDaBwDy1dg3d6Is=;
        b=BBa+/wYaigbPVikShx/N9TYS3+S8E6FW3coJHXiUOFz2RFdhVF+ZVIm7Htrt8//kfe
         7+gkNYAoxad3xbeivbEuhUQZRFTrDtcps9Usn0XHPmiXxfnKvoBhEy28GSkqambtabzS
         qKpJSqq/2pEo/P0y+X54ulGylWlb1fhitPLQeCIGMkHxg50zKk3Sx/W9+IoLR9DmD6dZ
         l2EyNA0MExEmMAk8Rym0E89OcioCIy4ryg1ZCWZxFNi8SKP/yevuoKVLbxGlMy0rj/9r
         LZ/UlvLS/ZMQEd/Aarl57kQujQXwQ3hDSMSTCsKM90L60PUx28WYGus1BfZdO0OZ2Q36
         DhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwrjU6762QSJwiWh0r8/mVMOyaJCyDaBwDy1dg3d6Is=;
        b=GMkr6/xWNg91WddU7mIW28NLGqLXru0Ea8oF6mIEBX62Zu6kLsZLDgwVRXIDqI1kOD
         Bq/Dn8Ua4RGY9fYm1L313GEtNB1LUairyajkEXWJue3FLKFZSI6nI38UD9N6Tr1VJkQw
         Qgo607ERAIdwp1uH1IjO7LYpyIkz/3fHlx+wfQIFYcH7AFNQp4r1HjiI8ifLWM5Iqcgj
         Ny3uZaQlRlWGSlOCPziU8oc+P/84JrR2DliM0R+CFGc8Rg/KSi1h36YIelc+iEfRirUD
         MkTLbRmtsC8R7aSnjKe+G9vG437Nehgb9qhpdJMUnUs8IQocbqIz1skoseZkaurB3MDM
         OYPQ==
X-Gm-Message-State: AOAM533gwEQJIz+BgQAVuR/7R/CryV3r8oHB2VWeB4KBkfuXe6blKRHw
        VYuZ5TEOB7+4Nc72LiQwiEAX/fBAWYWmCg==
X-Google-Smtp-Source: ABdhPJxwnwXt20YrRHzg9cLM1lQNBJ6tLPQlYKRtVv5ZPXbPVDACngcnWlB6WqxmtOuW08Mr2lggoA==
X-Received: by 2002:adf:93e6:: with SMTP id 93mr2177456wrp.197.1606900954124;
        Wed, 02 Dec 2020 01:22:34 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id e27sm1535936wrc.9.2020.12.02.01.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:22:33 -0800 (PST)
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
Subject: [PATCH v2 0/7] Drivers: hv: vmbus: More VMBus-hardening changes
Date:   Wed,  2 Dec 2020 10:22:07 +0100
Message-Id: <20201202092214.13520-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

This is v2 of [1], integrating feedback from Juan and Wei and adding
patch 4/7 (after Juan's suggestion).  Changelogs are in the patches.

Thanks,
  Andrea

[1] https://lkml.kernel.org/r/20201118143649.108465-1-parri.andrea@gmail.com

Andrea Parri (Microsoft) (7):
  Drivers: hv: vmbus: Initialize memory to be sent to the host
  Drivers: hv: vmbus: Avoid double fetch of msgtype in
    vmbus_on_msg_dpc()
  Drivers: hv: vmbus: Avoid double fetch of payload_size in
    vmbus_on_msg_dpc()
  Drivers: hv: vmbus: Copy the hv_message object in vmbus_on_msg_dpc()
  Drivers: hv: vmbus: Avoid use-after-free in vmbus_onoffer_rescind()
  Drivers: hv: vmbus: Resolve race condition in vmbus_onoffer_rescind()
  Drivers: hv: vmbus: Do not allow overwriting
    vmbus_connection.channels[]

 drivers/hv/channel.c      |  4 +--
 drivers/hv/channel_mgmt.c | 53 +++++++++++++++++++++++++++------------
 drivers/hv/hyperv_vmbus.h |  2 +-
 drivers/hv/vmbus_drv.c    | 43 ++++++++++++++++++-------------
 include/linux/hyperv.h    |  1 +
 5 files changed, 67 insertions(+), 36 deletions(-)

-- 
2.25.1

