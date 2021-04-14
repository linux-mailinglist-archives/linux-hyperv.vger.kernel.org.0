Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1770B35F720
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhDNPBy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 11:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhDNPBx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 11:01:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09FFC061574;
        Wed, 14 Apr 2021 08:01:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d21so3988469edv.9;
        Wed, 14 Apr 2021 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/yBNto60R+fD1Kjtsz5bkcthA6aae5QmXotBrldzFM=;
        b=a0Z8gqMfJ+q+dSW1XN7BqZk8r0N+fbJkgVuZa81mSQCPbUYpe/WtQzutd3iRvoozO+
         Jl4wCHVS9llqYDwrrqON9Q4zn4SFNZnlnwTWvSCL1gn2uUhrT2OjfMljIcnu3yA7lq1z
         es00Ke5W57Ua6kW865WmOIzJQzUNAgZLzs6Er6jnTG7ULCFzqe15wJMuj62uZSBIEzqH
         //rLCiwBQTykeL7oXvinPJDLgNY8p7yDlRdnTApdfjyGrf9nT4O4RvFcRgkeDFH3B1Bx
         3PffBGWnWVDwQPG60H672h2otZ+hVGjFXa2AjKqEqzWdVaPVCKiB2vNKJPnIrZ/T+6oV
         m/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/yBNto60R+fD1Kjtsz5bkcthA6aae5QmXotBrldzFM=;
        b=Iu9exUrHDlEZKgNRd9iw4R3okLPPQoJAcXtkMJ063kl1atgouliauRfDSCyKtZU7xo
         +dbyBg8jz38mUimLg/SnKICDNGB/BDmkWWzfEdrjEqHJNG0GtEIF5KlCzxspnaVfZT3u
         H6+/Ji0peREHLs/qFLbRiwX2Kv45s7PmkVVae/0d3YAyq3wz5JkW8p39yeqTTa/2yqL7
         tToV58rcYOg9IQguqaKmoieW9h6QJ9rN77nfmTjeh6/nkLLO+RpmL3S9VbbdEctya9Pb
         PWMdzVBZH/t8xQblmgehCf1FZGkMzaP0Hk8AqEDbGP2p2Y5nFeSgtn1uy43OFB347Zam
         AedA==
X-Gm-Message-State: AOAM533D2T9bEVxiJAV1ehRuHEm3Ke/l01WgBhEeUasmQpvMZtvqsmHo
        79QPa3RyWtgVPbq64JAolKShEQXIMJXS6Q==
X-Google-Smtp-Source: ABdhPJwGx0TerQirD7v1yrnKBH+raTt66QtalS7QVyD71+xovFg8WapXljZc8vP0kxPw9RCgFRwWnA==
X-Received: by 2002:a50:f181:: with SMTP id x1mr28098172edl.250.1618412489307;
        Wed, 14 Apr 2021 08:01:29 -0700 (PDT)
Received: from anparri.mshome.net (host-95-232-15-7.retail.telecomitalia.it. [95.232.15.7])
        by smtp.gmail.com with ESMTPSA id c12sm12683393edx.54.2021.04.14.08.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:01:29 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 0/3] Drivers: hv: vmbus: Introduce CHANNELMSG_MODIFYCHANNEL_RESPONSE
Date:   Wed, 14 Apr 2021 17:01:15 +0200
Message-Id: <20210414150118.2843-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Changes since v1[1]:
  - rebase on hyperv-next
  - split changes into three patches
  - fix&simplify error handling in send_modifychannel_with_ack()
  - remove rescind checks in send_modifychannel_with_ack()
  - remove unneeded test in hv_synic_event_pending()
  - add/amend inline comments
  - style changes

[1] https://lkml.kernel.org/r/20201126191210.13115-1-parri.andrea@gmail.com

Andrea Parri (Microsoft) (3):
  Drivers: hv: vmbus: Introduce and negotiate VMBus protocol version 5.3
  Drivers: hv: vmbus: Drivers: hv: vmbus: Introduce
    CHANNELMSG_MODIFYCHANNEL_RESPONSE
  Drivers: hv: vmbus: Check for pending channel interrupts before taking
    a CPU offline

 drivers/hv/channel.c      | 99 ++++++++++++++++++++++++++++++++-------
 drivers/hv/channel_mgmt.c | 42 +++++++++++++++++
 drivers/hv/connection.c   |  3 +-
 drivers/hv/hv.c           | 49 +++++++++++++++++++
 drivers/hv/hv_trace.h     | 15 ++++++
 drivers/hv/vmbus_drv.c    |  4 +-
 include/linux/hyperv.h    | 13 ++++-
 7 files changed, 205 insertions(+), 20 deletions(-)

-- 
2.25.1

