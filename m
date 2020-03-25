Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71C81933E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYW4I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 18:56:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51136 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYW4H (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 18:56:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id d198so4657049wmd.0;
        Wed, 25 Mar 2020 15:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBkDa1/hytZETbuj2tpOYG47B7NXMEkPeVfxoKj2RlY=;
        b=uuSbknCfLrcZSlYqiz4zbn8lx14lTu2O528nDK6f51AC1drW+VdTAOlqZyDNBfpEW6
         /mqohFO5tpQRKEkxE3rbaAxj1xahstEi/dulrBfheWseEp/ec/GB9p8C+lkOTaY6krH8
         8tTG8ba3ewNf5VRdFwcfBaa5LYX5Qq1iEXJnRgOkvgeukcWg9lEOLxhTOKrZeWtrBO5l
         ZQZE9JnbmslODv7XoBc8mt3JQlmbp58rTgAkX3u5/T6BPdnuvjtzTDPwFVV2zH9L2R9s
         JGcq9aKiiP2l9zjd0gmGWmobOhhZpmu/wQjDBjxR8ZktMqKwoDhqQ4XRoUaDbiXbzeAh
         4kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBkDa1/hytZETbuj2tpOYG47B7NXMEkPeVfxoKj2RlY=;
        b=ORe0+IbeLJesUrjRTarzWaiXPtaAgsHQYDzHYsxzHk2BYmxHcQr4TAMFvIknI2iBMW
         49fkaUR6euN0c8hjVMGa9ZZKy4URRWhpXbXvpQGB/1sZynwKSmNyZ4gz14xJCx2gPgLo
         CI2UKA0ALqo2U6EbT66p7kf0TtRcDEPP5PduorxWtN34nnpTAojbmVUYctXwX7oBMLzk
         hkL8m76dHDYdQeD5PIWSfzGTqnGpeCaMFgKmofX3nytZ4FJEvsIKPbOutnnjKIcRpeK/
         vTcj7Az85OrMt8ckuCA9eFTVyXHrBkPs29XH13S9WasUwJAcBZCQjqByBVqkpOqkXySb
         uxEQ==
X-Gm-Message-State: ANhLgQ1bQp5y2XEt3x1cjd5PdcOnBIwKb5Ss9+Oxq3eM0Nud+AxDjIYA
        unc5rFn28AU0D75LjDFIB2SxHzKi4zs8Nm93
X-Google-Smtp-Source: ADFU+vvb7A9NN8O1weYx+G42hUC4sy4eKcaEFppZbW4ak83J8Jf/EacvhO7dvt9+oP8kY+h4Aiwjrw==
X-Received: by 2002:a1c:2c8a:: with SMTP id s132mr5661043wms.22.1585176965234;
        Wed, 25 Mar 2020 15:56:05 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id q72sm790278wme.31.2020.03.25.15.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:56:04 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [RFC PATCH 00/11] VMBus channel interrupt reassignment
Date:   Wed, 25 Mar 2020 23:54:54 +0100
Message-Id: <20200325225505.23998-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

This series introduces changes in the VMBus drivers to reassign (at
runtime) the CPU that a VMbus channel will interrupt.  This feature
can be used for load balancing or other purposes, e.g. to offline a
given vCPU (vCPUs with no interrupts assigned can be taken offline).

Thanks,
  Andrea

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>

Andrea Parri (Microsoft) (11):
  Drivers: hv: vmbus: Always handle the VMBus messages on CPU0
  Drivers: hv: vmbus: Don't bind the offer&rescind works to a specific
    CPU
  Drivers: hv: vmbus: Replace the per-CPU channel lists with a global
    array of channels
  hv_netvsc: Disable NAPI before closing the VMBus channel
  hv_utils: Always execute the fcopy and vss callbacks in a tasklet
  Drivers: hv: vmbus: Use a spin lock for synchronizing channel
    scheduling vs. channel removal
  PCI: hv: Prepare hv_compose_msi_msg() for the
    VMBus-channel-interrupt-to-vCPU reassignment functionality
  Drivers: hv: vmbus: Remove the unused HV_LOCALIZED channel affinity
    logic
  Drivers: hv: vmbus: Synchronize init_vp_index() vs. CPU hotplug
  Drivers: hv: vmbus: Introduce the CHANNELMSG_MODIFYCHANNEL message
    type
  scsi: storvsc: Re-init stor_chns when a channel interrupt is
    re-assigned

 drivers/hv/channel.c                |  58 +++--
 drivers/hv/channel_mgmt.c           | 326 ++++++++++++++--------------
 drivers/hv/connection.c             |  58 +----
 drivers/hv/hv.c                     |  16 +-
 drivers/hv/hv_fcopy.c               |   2 +-
 drivers/hv/hv_snapshot.c            |   2 +-
 drivers/hv/hv_trace.h               |  19 ++
 drivers/hv/hyperv_vmbus.h           |  32 ++-
 drivers/hv/vmbus_drv.c              | 241 ++++++++++++++++----
 drivers/net/hyperv/netvsc.c         |   7 +-
 drivers/pci/controller/pci-hyperv.c |  44 ++--
 drivers/scsi/storvsc_drv.c          |  95 +++++++-
 include/linux/hyperv.h              |  51 ++---
 13 files changed, 599 insertions(+), 352 deletions(-)

-- 
2.24.0

