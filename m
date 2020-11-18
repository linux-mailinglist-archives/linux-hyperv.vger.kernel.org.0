Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC6D2B7F81
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Nov 2020 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKROhV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Nov 2020 09:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgKROhV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Nov 2020 09:37:21 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC59C0613D4;
        Wed, 18 Nov 2020 06:37:20 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so2406588wrc.8;
        Wed, 18 Nov 2020 06:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSNOadgDuSf0Kh14ug+1LzuE2/ssSyJri8G52JsgkEU=;
        b=skoTceNe0Ys7CdTFmrbPMoSzxw36XxYP/OqxOMPRsGFlce7W12fndwkIttkaTHC0xt
         eVDgpVZofJUqGP/0PehwZm4Av+CkyR7zrN0T+nVD12vutYDF60dqVIGMdktry9cOPHTL
         LXoVQWyy6gfik0HUs4/DKl2uhw8u3Dtue7wsJwY79aUr+RUQLeH+dDR/vEcp7LLF/lYn
         JeULTOkuIl52Bw0kK00+59899mUV2TrWRssdR6T1xUwovQmAQCdvk3wiXBZ0WTREFNYM
         eHMS1fbL2PVJG6oU3H5r6oRzWB9uOcuzpgHwczIpv9gBbIoDy+5TkeEQXlmT4//x5EMJ
         J6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSNOadgDuSf0Kh14ug+1LzuE2/ssSyJri8G52JsgkEU=;
        b=J3l7J+ekftXxPu2WAldLda1Iwi9QARzkqbBK8/+s0JaUf+y7btJw8Ho/h4k/94eq3x
         a73dCTrqiCar/RyV/gLSnd+By3ldy9zReSG6IfLg0TA76WrmFxqwJ4AYtump34111inK
         vE4wSpNJgI8ayzeN4ZPcrXgZVquuS3xnk2vjWknSsLkjlO9EmGRVtvtwxua8cyNLHo0e
         Ef/MZPnaSqKwD+WQ+9LlMQOy4dru+u6Lhw0nMbFlkAGH7LiioytnMS0RzUf3DSyivHaN
         fjRoNV3qq7Sleq7mc2AE7Fc6iJtafLAlhpV96KcwsWmQWwymEwCkaHElE1jHUr9vEyOK
         Mw4Q==
X-Gm-Message-State: AOAM531+V/kYSao80kzXTgEXNqpl/C4VWFNyLVopJwTlZYfJFmmEXOPj
        tmWhI4luhEoxPNbXQ/SX9f/ruUVx5jrwoQ==
X-Google-Smtp-Source: ABdhPJxscJcibGGUE5w7byT1afNZFElBH1a4Ocqe7CuqBFC4r4gZA/9IdVWBdz1tEmGCgkst+hPgbA==
X-Received: by 2002:a5d:4e4c:: with SMTP id r12mr5152053wrt.348.1605710234269;
        Wed, 18 Nov 2020 06:37:14 -0800 (PST)
Received: from localhost.localdomain (host-82-51-6-75.retail.telecomitalia.it. [82.51.6.75])
        by smtp.gmail.com with ESMTPSA id w10sm34795307wra.34.2020.11.18.06.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:37:13 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 0/6] Drivers: hv: vmbus: More VMBus-hardening changes
Date:   Wed, 18 Nov 2020 15:36:43 +0100
Message-Id: <20201118143649.108465-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

This set is a continuation of the work for hardening the VMBus drivers
against an erroneous or malicious host.  This is based on hyperv-next.

Thanks,
  Andrea

Andrea Parri (Microsoft) (6):
  Drivers: hv: vmbus: Initialize memory to be sent to the host
  Drivers: hv: vmbus: Avoid double fetch of msgtype in
    vmbus_on_msg_dpc()
  Drivers: hv: vmbus: Avoid double fetch of payload_size in
    vmbus_on_msg_dpc()
  Drivers: hv: vmbus: Avoid use-after-free in vmbus_onoffer_rescind()
  Drivers: hv: vmbus: Resolve race condition in vmbus_onoffer_rescind()
  Drivers: hv: vmbus: Do not allow overwriting
    vmbus_connection.channels[]

 drivers/hv/channel.c      |  4 ++--
 drivers/hv/channel_mgmt.c | 45 +++++++++++++++++++++++++++------------
 drivers/hv/hyperv_vmbus.h |  2 +-
 drivers/hv/vmbus_drv.c    | 33 ++++++++++++++++------------
 include/linux/hyperv.h    |  1 +
 5 files changed, 54 insertions(+), 31 deletions(-)

-- 
2.25.1

