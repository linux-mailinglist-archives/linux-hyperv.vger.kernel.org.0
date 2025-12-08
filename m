Return-Path: <linux-hyperv+bounces-7990-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65909CAC3B5
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Dec 2025 07:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B0443063852
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Dec 2025 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1F327C0B;
	Mon,  8 Dec 2025 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZR+mUQ5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8A327C08;
	Mon,  8 Dec 2025 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765176376; cv=none; b=T5mbijBRl2p737wdrXnMvskXDCOHdZT1kj5T4agt1Doy7sbydlKwI3pippr3M6lWIizkg7VFz4w5JzI7BSmM5z3d/ih49eErj5ZNZJ7CSbcDvwB2abdmf+wcuo0Yg601++joQv1QwBDZYlgrszFK/3784tTlGdW86Hy/Gg7vGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765176376; c=relaxed/simple;
	bh=j47oboRY9QOaKL2qkeAfc0KTPKFYIz/8T+FGwo2p7B4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vGbFCg3jl/dyxNp/F8U1RKjfT+Vzd0F41l6qbyD6Du3zZWXn9VQz4SC6AnJOEXC7FpgUn5fpsdWXmi/NQgQEfSUTvNnidizAJP9Lp7ZguKqBJUUjaNMO3a4xrBwTpZqZRS+VnTDdkR9dPn3wiKrIRfiiXIKmolIC3mdcWs7AVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZR+mUQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D44C4CEF1;
	Mon,  8 Dec 2025 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765176376;
	bh=j47oboRY9QOaKL2qkeAfc0KTPKFYIz/8T+FGwo2p7B4=;
	h=Date:From:To:Cc:Subject:From;
	b=iZR+mUQ5C7msKqJyq2cvbKVN7ABZxIMGySSY25oL+wL8m8xaMLBOIRhNE1V5K/Sde
	 nD2msOrBTYjldbL263vWN3HbFGfiw5qRxBTCfaqv61UubW8MkfAE+dZeYihPm/xxU2
	 /990qbh9sbNEAwrhQaA2waeZ8g9Sw0Ywh42EKA6UvQilLm4j+eBx533iRg4zDxVsap
	 Nyp0sP58SkD4MnMwGLAmeCrEI/xBqM3rzxGeIW5k9+PyaAE3+ZD5TO3ZH6swxwVqhe
	 HREE6ysd8ISP+XbLSuCwZJGKaoQ2qkSP8TSapqbIy16+PWiFPu1zOq3pFVKrFCPRIP
	 TfVqH26yMsfkA==
Date: Mon, 8 Dec 2025 06:46:14 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Subject: [GIT PULL] Hyper-V patches for 6.19
Message-ID: <20251208064614.GA2485915@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20251207

for you to fetch changes up to 615a6e7d83f958e7ef3bc818e818f7c6433b4c2a:

  mshv: Cleanly shutdown root partition with MSHV (2025-12-05 23:25:05 +0000)

You will see a merge conflict with the master branch. The resolution is
here.

  https://lore.kernel.org/all/20251125171130.67ba74e1@canb.auug.org.au/

----------------------------------------------------------------
hyperv-next for v6.19
  - Enhancements to Linux as the root partition for Microsoft
    Hypervisor.
    * Support a new mode called L1VH, which allows Linux to drive
      the hypervisor running the Azure Host directly.
    * Support for MSHV crash dump collection.
    * Allow Linux's memory management subsystem to better manage guest
      memory regions.
    * Fix issues that prevented a clean shutdown of the whole system on
      bare metal and nested configurations.
    * ARM64 support for the MSHV driver.
    * Various other bug fixes and cleanups.
  - Add support for Confidential VMBus for Linux guest on Hyper-V.
  - Secure AVIC support for Linux guests on Hyper-V.
  - Add the mshv_vtl driver to allow Linux to run as the secure kernel
    in a higher virtual trust level for Hyper-V.
----------------------------------------------------------------
Anirudh Rayabharam (Microsoft) (1):
      mshv: Add ioctl for self targeted passthrough hvcalls

Gongwei Li (1):
      Drivers: hv: use kmalloc_array() instead of kmalloc()

Jiapeng Chong (1):
      x86: mshyperv: Remove duplicate asm/msr.h header

Jinank Jain (3):
      mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH
      mshv: Introduce new hypercall to map stats page for L1VH partitions
      mshv: adjust interrupt control structure for ARM64

Kriish Sharma (1):
      Drivers: hv: fix missing kernel-doc description for 'size' in request_arr_init()

Long Li (1):
      MAINTAINERS: Add Long Li as a Hyper-V maintainer

Magnus Kulke (1):
      mshv: Allow mappings that overlap in uaddr

Marco Crivellari (1):
      mshv: add WQ_PERCPU to alloc_workqueue users

Mukesh Rathor (6):
      x86/hyperv: Rename guest crash shutdown function
      hyperv: Add two new hypercall numbers to guest ABI public header
      hyperv: Add definitions for hypervisor crash dump support
      x86/hyperv: Add trampoline asm code to transition from hypervisor
      x86/hyperv: Implement hypervisor RAM collection into vmcore
      x86/hyperv: Enable build of hypervisor crashdump collection files

Muminul Islam (1):
      mshv: Extend create partition ioctl to support cpu features

Naman Jain (3):
      static_call: allow using STATIC_CALL_TRAMP_STR() from assembly
      Drivers: hv: Export some symbols for mshv_vtl
      Drivers: hv: Introduce mshv_vtl driver

Nuno Das Neves (4):
      mshv: Fix VpRootDispatchThreadBlocked value
      mshv: Fix deposit memory in MSHV_ROOT_HVCALL
      mshv: Only map vp->vp_stats_pages if on root scheduler
      mshv: Fix create memory region overlap check

Praveen K Paladugu (3):
      mshv: Add definitions for MSHV sleep state configuration
      mshv: Use reboot notifier to configure sleep state
      mshv: Cleanly shutdown root partition with MSHV

Purna Pavan Chandra Aekkaladevi (2):
      mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX hypercall
      mshv: Get the vmm capabilities offered by the hypervisor

Rahul Kumar (1):
      Drivers: hv: Use kmalloc_array() instead of kmalloc()

Roman Kisel (17):
      Documentation: hyperv: Confidential VMBus
      Drivers: hv: VMBus protocol version 6.0
      arch/x86: mshyperv: Discover Confidential VMBus availability
      arch: hyperv: Get/set SynIC synth.registers via paravisor
      arch/x86: mshyperv: Trap on access for some synthetic MSRs
      Drivers: hv: Rename fields for SynIC message and event pages
      Drivers: hv: Allocate the paravisor SynIC pages when required
      Drivers: hv: Post messages through the confidential VMBus if available
      Drivers: hv: remove stale comment
      Drivers: hv: Check message and event pages for non-NULL before iounmap()
      Drivers: hv: Rename the SynIC enable and disable routines
      Drivers: hv: Functions for setting up and tearing down the paravisor SynIC
      Drivers: hv: Allocate encrypted buffers when requested
      Drivers: hv: Free msginfo when the buffer fails to decrypt
      Drivers: hv: Support confidential VMBus channels
      Drivers: hv: Set the default VMBus version to 6.0
      Drivers: hv: Support establishing the confidential VMBus connection

Stanislav Kinsburskii (7):
      Drivers: hv: Resolve ambiguity in hypervisor version log
      mshv: Refactor and rename memory region handling functions
      mshv: Centralize guest memory region destruction
      mshv: Move region management to mshv_regions.c
      mshv: Fix huge page handling in memory region traversal
      mshv: Add refcount and locking to mem regions
      mshv: Add support for movable memory regions

Tianyu Lan (4):
      x86/hyperv: Don't use hv apic driver when Secure AVIC is available
      drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
      x86/hyperv: Don't use auto-eoi when Secure AVIC is available
      x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts

 Documentation/virt/hyperv/coco.rst      |  139 ++-
 MAINTAINERS                             |    3 +
 arch/x86/hyperv/Makefile                |   16 +-
 arch/x86/hyperv/hv_apic.c               |    8 +
 arch/x86/hyperv/hv_crash.c              |  642 ++++++++++++++
 arch/x86/hyperv/hv_init.c               |    9 +
 arch/x86/hyperv/hv_trampoline.S         |  101 +++
 arch/x86/hyperv/hv_vtl.c                |   30 +
 arch/x86/hyperv/mshv-asm-offsets.c      |   37 +
 arch/x86/hyperv/mshv_vtl_asm.S          |  116 +++
 arch/x86/include/asm/mshyperv.h         |   45 +
 arch/x86/kernel/cpu/mshyperv.c          |   88 +-
 drivers/hv/Kconfig                      |   29 +-
 drivers/hv/Makefile                     |    9 +-
 drivers/hv/channel.c                    |   75 +-
 drivers/hv/channel_mgmt.c               |   27 +-
 drivers/hv/connection.c                 |    6 +-
 drivers/hv/hv.c                         |  377 ++++++---
 drivers/hv/hv_common.c                  |   27 +-
 drivers/hv/hv_util.c                    |    2 +-
 drivers/hv/hyperv_vmbus.h               |   76 +-
 drivers/hv/mshv_common.c                |   99 +++
 drivers/hv/mshv_eventfd.c               |    8 +-
 drivers/hv/mshv_irq.c                   |    4 +
 drivers/hv/mshv_regions.c               |  555 ++++++++++++
 drivers/hv/mshv_root.h                  |   57 +-
 drivers/hv/mshv_root_hv_call.c          |  196 ++++-
 drivers/hv/mshv_root_main.c             |  749 +++++++++--------
 drivers/hv/mshv_synic.c                 |    6 +-
 drivers/hv/mshv_vtl.h                   |   25 +
 drivers/hv/mshv_vtl_main.c              | 1392 +++++++++++++++++++++++++++++++
 drivers/hv/ring_buffer.c                |    5 +-
 drivers/hv/vmbus_drv.c                  |  188 +++--
 include/asm-generic/mshyperv.h          |   63 +-
 include/hyperv/hvgdk_mini.h             |  115 ++-
 include/hyperv/hvhdk.h                  |   46 +
 include/hyperv/hvhdk_mini.h             |  128 +++
 include/linux/compiler_types.h          |    8 +-
 include/linux/hyperv.h                  |   69 +-
 include/linux/static_call_types.h       |    4 +
 include/uapi/linux/mshv.h               |  116 ++-
 tools/include/linux/static_call_types.h |    4 +
 42 files changed, 5005 insertions(+), 694 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_crash.c
 create mode 100644 arch/x86/hyperv/hv_trampoline.S
 create mode 100644 arch/x86/hyperv/mshv-asm-offsets.c
 create mode 100644 arch/x86/hyperv/mshv_vtl_asm.S
 create mode 100644 drivers/hv/mshv_regions.c
 create mode 100644 drivers/hv/mshv_vtl.h
 create mode 100644 drivers/hv/mshv_vtl_main.c

