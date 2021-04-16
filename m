Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5386C36225F
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbhDPOfi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbhDPOfi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 10:35:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CC9C061574;
        Fri, 16 Apr 2021 07:35:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h10so32514388edt.13;
        Fri, 16 Apr 2021 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7g26aqLG1e9hWeG2bK6j0ADULzqPWoUC0oBsmf0+Wp8=;
        b=JdYH6n29/izNKIS2d2KdpdN/UsVRl02TtjsIe1XOaABwhfX2a2YhbuRsbFgd4/LFTL
         uM3WagvkB78koiCtBzska7KhGDVts6tICoaaTff6cCUXYshsA2xUvEBvyu/WiqdhOA8m
         +LFyU0t6xApCBovhICfZ4b8PPZyrWkGg3ulVaVZVEG5UHtHBEO132sGfHtg2w7V4FuTd
         OKiDYlVSLqNhQGtyn2ALMQiqyDz1WW1G0wnNVek/XrnIAuUbElncJDyfI06747X9b0v5
         spm+jsTtQG32ks522UwUAx6O883oXngCnL2VOHBnp1MxwBcqktUCnROFef9z7y+MTRFK
         6y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7g26aqLG1e9hWeG2bK6j0ADULzqPWoUC0oBsmf0+Wp8=;
        b=P9vo+DtVoJTBVEBSULjyYLn9eerogsPTjefp3dPDkAnyaRjJ4f5vjjQH0gPBaqoPHt
         8rmB4OofkW1Xch+0wNtx3XkkBkFMMJtrK5WURbkgrRhnwZNVAYbcuVh8p31hbxrLTcxY
         xvFRjVWn6SqT4d6el0C8jHoIHYj5MgU6abAxWc7UBd4y0aM+W8alaiApEhQ0iv5vVhJa
         CAW39zToOMjG2b0Z1TG7sY1ia3nutJXhnP0whSOUMmzHTnxjpOsmuIIot5RkjuNUAD6r
         oB9JzzhhEswW80cimgOt68onxmlv5NMln4/rQCj6+GrzhCF64sxPKPYHC718wj2Os/Zs
         +99A==
X-Gm-Message-State: AOAM5330jfI0YItos3lDESNcKmBfKR/5DYKQ8oKwTUHNfwpLAfInSB3H
        KmOtC8f/N48ZxUsYsJFUv5aFprNvsJ9UEQ==
X-Google-Smtp-Source: ABdhPJxB5/SCfL54QbuRgfBBSXW0bH55TjKyl7znTg7NhuEOyxPOpPrAQrBGglZQ6Y0F7+lsljbeaw==
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr10156370edu.100.1618583712031;
        Fri, 16 Apr 2021 07:35:12 -0700 (PDT)
Received: from anparri.mshome.net (mob-176-243-167-64.net.vodafone.it. [176.243.167.64])
        by smtp.gmail.com with ESMTPSA id x4sm5399472edd.58.2021.04.16.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:35:11 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v3 0/3] Drivers: hv: vmbus: Introduce CHANNELMSG_MODIFYCHANNEL_RESPONSE
Date:   Fri, 16 Apr 2021 16:34:46 +0200
Message-Id: <20210416143449.16185-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Changes since v2[1]:
  - fix VMbus protocol version name
  - add Reviewed-by: tag
  - refactor/simplyfy changes in hv_synic_cleanup()

Changes since v1[2]:
  - rebase on hyperv-next
  - split changes into three patches
  - fix&simplify error handling in send_modifychannel_with_ack()
  - remove rescind checks in send_modifychannel_with_ack()
  - remove unneeded test in hv_synic_event_pending()
  - add/amend inline comments
  - style changes

[1] https://lkml.kernel.org/r/20210414150118.2843-1-parri.andrea@gmail.com
[2] https://lkml.kernel.org/r/20201126191210.13115-1-parri.andrea@gmail.com

Andrea Parri (Microsoft) (3):
  Drivers: hv: vmbus: Introduce and negotiate VMBus protocol version 5.3
  Drivers: hv: vmbus: Drivers: hv: vmbus: Introduce
    CHANNELMSG_MODIFYCHANNEL_RESPONSE
  Drivers: hv: vmbus: Check for pending channel interrupts before taking
    a CPU offline

 drivers/hv/channel.c      | 99 ++++++++++++++++++++++++++++++++-------
 drivers/hv/channel_mgmt.c | 42 +++++++++++++++++
 drivers/hv/connection.c   |  3 +-
 drivers/hv/hv.c           | 56 ++++++++++++++++++++--
 drivers/hv/hv_trace.h     | 15 ++++++
 drivers/hv/vmbus_drv.c    |  4 +-
 include/linux/hyperv.h    | 13 ++++-
 7 files changed, 209 insertions(+), 23 deletions(-)

-- 
2.25.1

