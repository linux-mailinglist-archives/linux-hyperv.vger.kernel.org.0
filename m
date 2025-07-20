Return-Path: <linux-hyperv+bounces-6308-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B9B0B3BB
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Jul 2025 08:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06D31896202
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Jul 2025 06:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD144192598;
	Sun, 20 Jul 2025 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+d+WaYC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7720ED;
	Sun, 20 Jul 2025 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752992019; cv=none; b=r66FfcoGJw3pywAbrB4jMmGyuLvO4Pxy2/4zbTeG0pqjpcKE84p8X19xTQKwuVg8HdvlOhqE/c7aU3MzxGB+dplETl2AlHlR44USKflnyx6VFQ6CrB/lsInurwM4spCPD5MnaxFefWCPSoG4qOXT+1FArupYfk8KiWzn3zbWgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752992019; c=relaxed/simple;
	bh=iY9GwdvX1j+zM7IjLzM3rKUqZsDjHqFzro8h6bbwFwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ukd4STgpu9rNWnUx3cF5DMoLjkLb2Zffbmxca0+piWleT8xZCLmPs1pIMTFYSIqGiaUFRGiB0pi/g03cNUNJMzSMuRKtcB9tBrOKiNk0/mRjabQdvC/Y5pR6t5AAJkTJgxbhA8quDcguoAiPTzwPvMnTwksJsKvPN2JiTgkkI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+d+WaYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC1FC4CEE7;
	Sun, 20 Jul 2025 06:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752992017;
	bh=iY9GwdvX1j+zM7IjLzM3rKUqZsDjHqFzro8h6bbwFwQ=;
	h=Date:From:To:Cc:Subject:From;
	b=d+d+WaYCjnTr2qCRdt5BZGgxbKndS/IXBOBebSUsMlFvk73cqpkGec3MLaROPOmXE
	 0bu6UP1JiR4vDbifC9VN4DxKDwAI3RL+cQj4kKrsfKUwVgYx5bKIh3m2+Y6NQ4Om66
	 /l8k3IW6YLX9nv+vBZif2sJNd8J/jif8yDmdJQZjQDOS/d9tWhlXBVEAhdi5oPyWdu
	 wtGDxrCGQ3jZaLE3/hkzcywxJ3/r6JPVVoO42WH0tG4+witZryCaAtRcsF5CMRCDwr
	 aQRFezja6zoLcXlx/+tzS6UEBFb1E3X7X7vo38aWt6RASBX2RydcBOrHYBlre+jvB4
	 wpczCuYwy2T5w==
Date: Sun, 20 Jul 2025 06:13:35 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 6.16-rc7
Message-ID: <aHyJD7tQPytwl0nS@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20250718

for you to fetch changes up to a4131a50d072b369bfed0b41e741c41fd8048641:

  tools/hv: fcopy: Fix irregularities with size of ring buffer (2025-07-15 06:25:33 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.16-rc7
 - Select use CONFIG_SYSFB only if EFI is enabled (Michael Kelley)
 - An assorted set of fixes to remove warnings for missing
   export.h header inclusion (Naman Jain)
 - An assorted set of fixes for when Linux run as the root partition for
   Microsoft Hypervisor (Mukesh Rathor, Nuno Das Neves, Stanislav
   Kinsburskii)
 - Fix the check for HYPERVISOR_CALLBACK_VECTOR (Naman Jain)
 - Fix fcopy tool to handle irregularities with size of ring buffer
   (Naman Jain)
 - Fix incorrect file path conversion in fcopy tool (Yasumasa Suenaga)
----------------------------------------------------------------
Michael Kelley (1):
      Drivers: hv: Select CONFIG_SYSFB only if EFI is enabled

Mukesh Rathor (1):
      PCI: hv: Don't load the driver for baremetal root partition

Naman Jain (7):
      Drivers: hv: Fix the check for HYPERVISOR_CALLBACK_VECTOR
      Drivers: hv: Fix warnings for missing export.h header inclusion
      x86/hyperv: Fix warnings for missing export.h header inclusion
      clocksource: hyper-v: Fix warnings for missing export.h header inclusion
      PCI: hv: Fix warnings for missing export.h header inclusion
      net: mana: Fix warnings for missing export.h header inclusion
      tools/hv: fcopy: Fix irregularities with size of ring buffer

Nuno Das Neves (3):
      x86/hyperv: Fix usage of cpu_online_mask to get valid cpu
      x86/hyperv: Clean up hv_map/unmap_interrupt() return values
      Drivers: hv: Use nested hypercall for post message and signal event

Stanislav Kinsburskii (2):
      x86/hyperv: Expose hv_map_msi_interrupt()
      PCI: hv: Use the correct hypercall for unmasking interrupts on nested

Yasumasa Suenaga (1):
      tools/hv: fcopy: Fix incorrect file path conversion

 arch/x86/hyperv/hv_init.c                       |   1 +
 arch/x86/hyperv/irqdomain.c                     |  69 +++++++------
 arch/x86/hyperv/ivm.c                           |   1 +
 arch/x86/hyperv/nested.c                        |   1 +
 arch/x86/include/asm/mshyperv.h                 |  22 +---
 drivers/clocksource/hyperv_timer.c              |   1 +
 drivers/hv/Kconfig                              |   2 +-
 drivers/hv/channel.c                            |   1 +
 drivers/hv/channel_mgmt.c                       |   1 +
 drivers/hv/connection.c                         |   5 +-
 drivers/hv/hv.c                                 |   6 +-
 drivers/hv/hv_proc.c                            |   1 +
 drivers/hv/mshv_common.c                        |   1 +
 drivers/hv/mshv_root_hv_call.c                  |   1 +
 drivers/hv/ring_buffer.c                        |   1 +
 drivers/hv/vmbus_drv.c                          |   9 +-
 drivers/iommu/hyperv-iommu.c                    |  33 +++---
 drivers/net/ethernet/microsoft/mana/gdma_main.c |   1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c   |   1 +
 drivers/pci/controller/pci-hyperv-intf.c        |   1 +
 drivers/pci/controller/pci-hyperv.c             |  21 +++-
 tools/hv/hv_fcopy_uio_daemon.c                  | 128 ++++++++++++++++++------
 22 files changed, 196 insertions(+), 112 deletions(-)

