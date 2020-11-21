Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F2D2BBADE
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgKUAau (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:30:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51164 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgKUAau (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:50 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4065820B717A;
        Fri, 20 Nov 2020 16:30:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4065820B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918649;
        bh=qL7T6ATcePrRBnydsz5PapiFX6SEvvtzilsCG4i/l5Q=;
        h=From:To:Cc:Subject:Date:From;
        b=q9oq3fIrueZe29lIOTh6gn0AH3XUDhwL2d+5pH1ImHf73gDyOJVyGOjUhHhY1FUbg
         WhHvjlyV8e4mhkbvKODnxdcl/S64e875joDzwxOmrpa3Ql3tqoHpuKlOQmEqD6i2MF
         CqT2mqlBgRhJJ3AIPZ22mXp7WOEzK7Eou6Xkl0SY=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 00/18] Microsoft Hypervisor root partition ioctl interface
Date:   Fri, 20 Nov 2020 16:30:19 -0800
Message-Id: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch series provides a userspace interface for creating and running guest
virtual machines while running on the Microsoft Hypervisor [0].

Since managing guest machines can only be done when Linux is the root partition,
this series depends on the RFC already posted by Wei Liu:
https://lore.kernel.org/linux-hyperv/20201105165814.29233-1-wei.liu@kernel.org/T/#t

The first two patches provide some helpers for converting hypervisor status
codes to linux error codes, and easily printing hypervisor status codes to dmesg
for debugging.

Hyper-V related headers asm-generic/hyperv-tlfs.h and x86/asm/hyperv-tlfs.h are
split into uapi and non-uapi. The uapi versions contain structures used in both
the ioctl interface and the kernel.

The mshv API is introduced in virt/mshv/mshv_main.c. As each interface is
introduced, documentation is added in Documentation/virt/mshv/api.rst.
The API is file-desciptor based, like KVM. The entry point is /dev/mshv.

/dev/mshv ioctls:
MSHV_REQUEST_VERSION
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
mmap() (register page)

[0] Hyper-V is more well-known, but it really refers to the whole stack
    including the hypervisor and other components that run in Windows kernel
    and userspace.

Nuno Das Neves (18):
  x86/hyperv: convert hyperv statuses to linux error codes
  asm-generic/hyperv: convert hyperv statuses to strings
  virt/mshv: minimal mshv module (/dev/mshv/)
  virt/mshv: request version ioctl
  virt/mshv: create partition ioctl
  virt/mshv: create, initialize, finalize, delete partition hypercalls
  virt/mshv: withdraw memory hypercall
  virt/mshv: map and unmap guest memory
  virt/mshv: create vcpu ioctl
  virt/mshv: get and set vcpu registers ioctls
  virt/mshv: set up synic pages for intercept messages
  virt/mshv: run vp ioctl and isr
  virt/mshv: install intercept ioctl
  virt/mshv: assert interrupt ioctl
  virt/mshv: get and set vp state ioctls
  virt/mshv: mmap vp register page
  virt/mshv: get and set partition property ioctls
  virt/mshv: Add enlightenment bits to create partition ioctl

 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 Documentation/virt/mshv/api.rst               |  173 ++
 arch/x86/Kconfig                              |    2 +
 arch/x86/hyperv/Kconfig                       |   22 +
 arch/x86/hyperv/Makefile                      |    4 +
 arch/x86/hyperv/hv_init.c                     |    2 +-
 arch/x86/hyperv/hv_proc.c                     |   40 +-
 arch/x86/include/asm/hyperv-tlfs.h            |   44 +-
 arch/x86/include/asm/mshyperv.h               |    1 +
 arch/x86/include/uapi/asm/hyperv-tlfs.h       | 1312 +++++++++++
 arch/x86/kernel/cpu/mshyperv.c                |   16 +
 include/asm-generic/hyperv-tlfs.h             |  324 ++-
 include/asm-generic/mshyperv.h                |    3 +
 include/linux/mshv.h                          |   61 +
 include/uapi/asm-generic/hyperv-tlfs.h        |  160 ++
 include/uapi/linux/mshv.h                     |  109 +
 virt/mshv/mshv_main.c                         | 2054 +++++++++++++++++
 17 files changed, 4178 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/virt/mshv/api.rst
 create mode 100644 arch/x86/hyperv/Kconfig
 create mode 100644 arch/x86/include/uapi/asm/hyperv-tlfs.h
 create mode 100644 include/linux/mshv.h
 create mode 100644 include/uapi/asm-generic/hyperv-tlfs.h
 create mode 100644 include/uapi/linux/mshv.h
 create mode 100644 virt/mshv/mshv_main.c

-- 
2.25.1

