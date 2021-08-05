Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28E3E1DD1
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 23:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhHEVYs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 17:24:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46466 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhHEVYr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 17:24:47 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id CD703209F5E1;
        Thu,  5 Aug 2021 14:24:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD703209F5E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628198672;
        bh=0fsoNf54k8+IhiUVxg/cIDHFce/dbXd7b9LfIZWeFhk=;
        h=From:To:Cc:Subject:Date:From;
        b=TbWe4vRNzD8r0McIPtrjqwc99FVOxfuRoY5yt6IWvmVUSOoD7ENRxUKEV4WHgetpg
         2DOhYNKRQB3KodT+6+vLlE+AGdodmgTcETbdy5hifycY5yEIGY3hM62h07+yv+lHUe
         V8YdOQEMNuSwWetEH8XVLXrUJdRNzFH3DjWyrH1o=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH v2 00/19] Microsoft Hypervisor root partition ioctl interface
Date:   Thu,  5 Aug 2021 14:23:42 -0700
Message-Id: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch series provides a userspace interface for creating and running guest
virtual machines while running on the Microsoft Hypervisor [0].

Since managing guest machines can only be done when Linux is the root partition,
this series depends on Wei Liu's patch series merged in 5.12:
https://lore.kernel.org/linux-hyperv/20210203150435.27941-1-wei.liu@kernel.org/

The first two patches provide some helpers for converting hypervisor status
codes to linux error codes, and printing hypervisor status codes to dmesg for
debugging.

Hyper-V related headers asm-generic/hyperv-tlfs.h and x86/asm/hyperv-tlfs.h are
split into uapi and non-uapi. The uapi versions contain structures used in both
the ioctl interface and the kernel.

The mshv API is introduced in drivers/hv/mshv_main.c. As each interface is
introduced, documentation is added in Documentation/virt/mshv/api.rst.
The API is file-desciptor based, like KVM. The entry point is /dev/mshv.

/dev/mshv ioctls:
MSHV_CHECK_EXTENSION
MSHV_CREATE_PARTITION

Partition (vm) ioctls:
MSHV_MAP_GUEST_MEMORY, MSHV_UNMAP_GUEST_MEMORY
MSHV_INSTALL_INTERCEPT
MSHV_ASSERT_INTERRUPT
MSHV_GET_PARTITION_PROPERTY, MSHV_SET_PARTITION_PROPERTY
MSHV_CREATE_VP

Vp (vcpu) ioctls:
MSHV_GET_VP_REGISTERS, MSHV_SET_VP_REGISTERS
MSHV_RUN_VP
MSHV_GET_VP_STATE, MSHV_SET_VP_STATE
MSHV_VP_TRANSLATE_GVA
mmap() (register page)

[0] Hyper-V is more well-known, but it really refers to the whole stack
    including the hypervisor and other components that run in Windows kernel
    and userspace.

Changes since v1:
1. Correct mshv_dev mode to octal 0600
2. Fix bug in mshv_vp_iotcl_run - correctly set suspend registers on early exit
3. Fix bug in translate gva patch, provided by Anatol Belski
4. Address comments from Wei Liu, Sunil Muthuswamy, and Vitaly Kuznetsov
5. Run checkpatch.pl - fix whitespace and other style issues

Changes since RFC:
1. Moved code from virt/mshv to drivers/hv
2. Split hypercall helper functions and synic code to hv_call.c and hv_synic.c
3. MSHV_REQUEST_VERSION ioctl replaced with MSHV_CHECK_EXTENSION
3. Numerous suggestions, fixes, style changes, etc from Michael Kelley, Vitaly
   Kuznetsov, Wei Liu, and Vineeth Pillai
4. Added patch to enable hypervisor enlightenments on partition creation
5. Added Wei Liu's patch for GVA to GPA translation

Nuno Das Neves (18):
  x86/hyperv: convert hyperv statuses to linux error codes
  x86/hyperv: convert hyperv statuses to strings
  drivers/hv: minimal mshv module (/dev/mshv/)
  drivers/hv: check extension ioctl
  drivers/hv: create partition ioctl
  drivers/hv: create, initialize, finalize, delete partition hypercalls
  drivers/hv: withdraw memory hypercall
  drivers/hv: map and unmap guest memory
  drivers/hv: create vcpu ioctl
  drivers/hv: get and set vcpu registers ioctls
  drivers/hv: set up synic pages for intercept messages
  drivers/hv: run vp ioctl and isr
  drivers/hv: install intercept ioctl
  drivers/hv: assert interrupt ioctl
  drivers/hv: get and set vp state ioctls
  drivers/hv: mmap vp register page
  drivers/hv: get and set partition property ioctls
  drivers/hv: Add enlightenment bits to create partition ioctl

Wei Liu (1):
  drivers/hv: Translate GVA to GPA

 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 Documentation/virt/mshv/api.rst               |  173 +++
 arch/x86/hyperv/Makefile                      |    1 +
 arch/x86/hyperv/hv_init.c                     |    2 +-
 arch/x86/hyperv/hv_proc.c                     |   51 +-
 arch/x86/include/asm/hyperv-tlfs.h            |   15 +-
 arch/x86/include/asm/mshyperv.h               |    1 +
 arch/x86/include/uapi/asm/hyperv-tlfs.h       | 1274 +++++++++++++++++
 arch/x86/kernel/cpu/mshyperv.c                |   16 +
 drivers/hv/Kconfig                            |   18 +
 drivers/hv/Makefile                           |    3 +
 drivers/hv/hv_call.c                          |  742 ++++++++++
 drivers/hv/hv_synic.c                         |  181 +++
 drivers/hv/mshv.h                             |  120 ++
 drivers/hv/mshv_main.c                        | 1166 +++++++++++++++
 include/asm-generic/hyperv-tlfs.h             |  354 +++--
 include/asm-generic/mshyperv.h                |    4 +
 include/linux/mshv.h                          |   61 +
 include/uapi/asm-generic/hyperv-tlfs.h        |  242 ++++
 include/uapi/linux/mshv.h                     |  117 ++
 20 files changed, 4398 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/virt/mshv/api.rst
 create mode 100644 arch/x86/include/uapi/asm/hyperv-tlfs.h
 create mode 100644 drivers/hv/hv_call.c
 create mode 100644 drivers/hv/hv_synic.c
 create mode 100644 drivers/hv/mshv.h
 create mode 100644 drivers/hv/mshv_main.c
 create mode 100644 include/linux/mshv.h
 create mode 100644 include/uapi/asm-generic/hyperv-tlfs.h
 create mode 100644 include/uapi/linux/mshv.h

-- 
2.23.4

