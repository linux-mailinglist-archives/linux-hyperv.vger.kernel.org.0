Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775AA19EECC
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 02:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgDFAQg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Apr 2020 20:16:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44946 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgDFAQg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Apr 2020 20:16:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id m17so15284463wrw.11;
        Sun, 05 Apr 2020 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilLIZZY1ZTef+uy+Q7pfKbP5pegyvZMVI25fKVDA1p0=;
        b=TXrwlpTlaPpc2Y+d7kJaMaxhnHhTDv7UubglkvvMdxhoHLU6mX2fEJhex9PzTWb3Lh
         wiOwPTITEZR2g0y1IB/k08ycYjqhPVQY+XqgKq7TMI49gZw8udF41A3mZZMfeJnV2tN4
         sEkQsoCdilkCsRuQUl2/wcpM96caYZXiMLTThUqOM1i8Ap1kM6cW/N3zPVfM0GJ6nP7k
         WStAZyUYVi+K560H4dWAKV7f/kPaCYGRdD7/5cHrQMx6DMUevlI6eDQpbaYNR03LiORv
         mdlrK0fj4vG47pt+AXiEvhdPy6j5zJ2hlqvEYhcYCnW87Pt/z0Bjd82qnWY7BcZyw3Jo
         qqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilLIZZY1ZTef+uy+Q7pfKbP5pegyvZMVI25fKVDA1p0=;
        b=MvhZ4QByH7yURGz6a64RmAXkvmIzjwwB8KeQ2HBnyMVr15Com5eyCCMPP3QfIkGP7i
         7zcwg2/lcqncEgbduuItKSqkg4Pz/3dupLBMvig0F5DwYill7LgiXTuk0LOu0NEGCMKo
         InglyKgby1ojDRdGYQCdBjvAI2Y0J7dfBMgtXVpzBrgvzPBWSylJVIWEjoebXm16Frkh
         /alRBCB2RHEYjmiVZeUClgWyffQunC5JXPbOZr7WijOzvLpFdHpiph/tuqgBWjhMNMeL
         zg5dt0Jm+xyov3AWRFXT5oq2skccAmFbb3q3TMfqcBWwRmzKHvbXAmjFYqYPXZTRkMut
         AqCQ==
X-Gm-Message-State: AGi0PuZjeGc7LQwfx9QD5t1aIbwirI68BhPD3VMT7eWLI6PJtgezgxHC
        b1W+sw2oeDRjwMOHTOWHzxlCbryGR8m+Qg==
X-Google-Smtp-Source: APiQypLNJ1X/3/73bJYhaIgJorgfuSgNQqL/G8ATwZmq09esJO03yj9NOUF/DNacYHVuIlEVK4YCbw==
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr21491009wrs.252.1586132193213;
        Sun, 05 Apr 2020 17:16:33 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j9sm817432wrn.59.2020.04.05.17.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:16:32 -0700 (PDT)
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
Subject: [PATCH 00/11] VMBus channel interrupt reassignment
Date:   Mon,  6 Apr 2020 02:15:03 +0200
Message-Id: <20200406001514.19876-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

This is a follow-up on the RFC submission [1].  The series introduces
changes in the VMBus drivers to reassign the CPU that a VMbus channel
will interrupt.  This feature can be used for load balancing or other
purposes (e.g. CPU offlining).  The submission integrates feedback in
the RFC to amend the handling of the 'array of channels' (patch #3).

Thanks,
  Andrea

[1] https://lkml.kernel.org/r/20200325225505.23998-1-parri.andrea@gmail.com

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
 drivers/hv/channel_mgmt.c           | 347 +++++++++++++++-------------
 drivers/hv/connection.c             |  58 +----
 drivers/hv/hv.c                     |  16 +-
 drivers/hv/hv_fcopy.c               |   2 +-
 drivers/hv/hv_snapshot.c            |   2 +-
 drivers/hv/hv_trace.h               |  19 ++
 drivers/hv/hyperv_vmbus.h           |  32 ++-
 drivers/hv/vmbus_drv.c              | 241 +++++++++++++++----
 drivers/net/hyperv/netvsc.c         |   7 +-
 drivers/pci/controller/pci-hyperv.c |  44 ++--
 drivers/scsi/storvsc_drv.c          |  95 +++++++-
 include/linux/hyperv.h              |  51 ++--
 13 files changed, 620 insertions(+), 352 deletions(-)

-- 
2.24.0

