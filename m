Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B151EC156
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jun 2020 19:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBRr5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Jun 2020 13:47:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40163 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBRr5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Jun 2020 13:47:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id r15so4005187wmh.5;
        Tue, 02 Jun 2020 10:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Hac4NbkKwQMIBWzkyLbsnlFGvKNTeYymNblYtF3qCYI=;
        b=LHL6LYLcuYeDFRfVd/+ii8gkT8DEYXQsGeKDCIug3U44y+4VPg9Su/oPIUwKDmsbMw
         HG6FjFTJZGuFjecdVBh1bAC41HjffN4TkBWApQzPVZeY93X2ODr59Qvd70sfLQBtJenb
         CWCmZgzXXrffZZZTL1EQkCRWHfxM+V9T+EG3e9tTry2wzeofdPfC4g6T37vYVRFY42+z
         K1mseZnsKjjlxevq8Uy3uWdN6VUPdPjVApOTf9wmEZ78LOL2fEiszL317L7c4iqwympS
         GbzxK1v6l7gkKk0VXtpNmmpsRDMYq90j2wA1YzGNU/llItoo0cV8IR8V5BmCqF/Phsuu
         ZJMQ==
X-Gm-Message-State: AOAM5320WU5sIFWtiJZ/i8YwNw/yYjMMqrZjPHzsIDNHK6F6+q1gYcS4
        HJiyS9w+G9o84RawiwIasWs=
X-Google-Smtp-Source: ABdhPJzdI0Af12c/h6zywVKhzVzAyUSBB0Ph4N0UZxvGFQcJshQSaq0/y2I1K8LEJE1xCLYF24XopQ==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr4732456wmj.143.1591120074168;
        Tue, 02 Jun 2020 10:47:54 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u10sm554074wmc.31.2020.06.02.10.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 10:47:53 -0700 (PDT)
Date:   Tue, 2 Jun 2020 17:47:52 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V commits for 5.8
Message-ID: <20200602174752.u67tmpxojt5dv655@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

Please pull the signed tag for Hyper-V commits for 5.8.

There is a conflict in arch/x86/include/asm/hyperv-tlfs.h with a patch
in KVM tree. Michael Kelley and Jon Doron touched that file separately.
Michael's patches are going through the Hyper-V tree while Jon's patches
are going through KVM tree.

A fix for the conflict can be found at:

https://lore.kernel.org/lkml/20200602171802.560d07bc@canb.auug.org.au/

For the same reason, you will see a build failure after merging Hyper-V
and KVM tree.  That's because a constant was renamed from
HV_X64_DEBUGGING to HV_DEBUGGING. A patch to fix the build can be found
at:

https://lore.kernel.org/lkml/20200602173556.17ad06a1@canb.auug.org.au/

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

for you to fetch changes up to afaa33da08abd10be8978781d7c99a9e67d2bbff:

  Drivers: hv: vmbus: Resolve more races involving init_vp_index() (2020-05-23 09:07:00 +0000)

----------------------------------------------------------------

 - A series from Andrea to support channel reassignment
 - A series from Vitaly to clean up Vmbus message handling
 - A series from Michael to clean up and augment hyperv-tlfs.h
 - Patches from Andy to clean up GUID usage in Hyper-V code
 - A few other misc patches

----------------------------------------------------------------
Andrea Parri (Microsoft) (13):
      Drivers: hv: vmbus: Always handle the VMBus messages on CPU0
      Drivers: hv: vmbus: Don't bind the offer&rescind works to a specific CPU
      Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels
      hv_netvsc: Disable NAPI before closing the VMBus channel
      hv_utils: Always execute the fcopy and vss callbacks in a tasklet
      Drivers: hv: vmbus: Use a spin lock for synchronizing channel scheduling vs. channel removal
      PCI: hv: Prepare hv_compose_msi_msg() for the VMBus-channel-interrupt-to-vCPU reassignment functionality
      Drivers: hv: vmbus: Remove the unused HV_LOCALIZED channel affinity logic
      Drivers: hv: vmbus: Synchronize init_vp_index() vs. CPU hotplug
      Drivers: hv: vmbus: Introduce the CHANNELMSG_MODIFYCHANNEL message type
      scsi: storvsc: Re-init stor_chns when a channel interrupt is re-assigned
      Drivers: hv: vmbus: Resolve race between init_vp_index() and CPU hotplug
      Drivers: hv: vmbus: Resolve more races involving init_vp_index()

Andy Shevchenko (4):
      hyper-v: Use UUID API for exporting the GUID (part 2)
      hyper-v: Supply GUID pointer to printf() like functions
      hyper-v: Replace open-coded variant of %*phN specifier
      hyper-v: Switch to use UUID types directly

Colin Ian King (1):
      drivers: hv: remove redundant assignment to pointer primary_channel

Gustavo A. R. Silva (1):
      vmbus: Replace zero-length array with flexible-array

Michael Kelley (4):
      KVM: x86: hyperv: Remove duplicate definitions of Reference TSC Page
      x86/hyperv: Remove HV_PROCESSOR_POWER_STATE #defines
      x86/hyperv: Split hyperv-tlfs.h into arch dependent and independent files
      asm-generic/hyperv: Add definitions for Get/SetVpRegister hypercalls

Vitaly Kuznetsov (5):
      Drivers: hv: copy from message page only what's needed
      Drivers: hv: allocate the exact needed memory for messages
      Drivers: hv: avoid passing opaque pointer to vmbus_onmessage()
      Drivers: hv: make sure that 'struct vmbus_channel_message_header' compiles correctly
      Drivers: hv: check VMBus messages lengths

Wei Liu (1):
      Driver: hv: vmbus: drop a no long applicable comment

 MAINTAINERS                         |   1 +
 arch/x86/include/asm/hyperv-tlfs.h  | 472 +++-------------------------------
 arch/x86/include/asm/kvm_host.h     |   2 +-
 arch/x86/kvm/hyperv.c               |   4 +-
 drivers/hv/channel.c                |  58 +++--
 drivers/hv/channel_mgmt.c           | 439 +++++++++++++++++---------------
 drivers/hv/connection.c             |  58 +----
 drivers/hv/hv.c                     |  16 +-
 drivers/hv/hv_fcopy.c               |   2 +-
 drivers/hv/hv_snapshot.c            |   2 +-
 drivers/hv/hv_trace.h               |  25 +-
 drivers/hv/hyperv_vmbus.h           |  81 ++++--
 drivers/hv/vmbus_drv.c              | 314 +++++++++++++++++------
 drivers/net/hyperv/netvsc.c         |   7 +-
 drivers/pci/controller/pci-hyperv.c |  44 ++--
 drivers/scsi/storvsc_drv.c          |  96 ++++++-
 include/asm-generic/hyperv-tlfs.h   | 493 ++++++++++++++++++++++++++++++++++++
 include/linux/hyperv.h              |  68 +++--
 include/linux/mod_devicetable.h     |   2 +-
 19 files changed, 1309 insertions(+), 875 deletions(-)
 create mode 100644 include/asm-generic/hyperv-tlfs.h
