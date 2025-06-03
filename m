Return-Path: <linux-hyperv+bounces-5718-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B5ACC005
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 08:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEB83A6468
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2A817A318;
	Tue,  3 Jun 2025 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhhcIyTr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209E4A35;
	Tue,  3 Jun 2025 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748930989; cv=none; b=ZAC0fAnLFOkIRiF+yvm7pgaFEcCRbQP6QP9fAZDlUg3bMiyXc5bE8tiIQUfawosMLNRGWzy2sYsMpOXwhZWipgwvU9JSQFktGV+wGIzNMNqKLOlK21OckWIIjxdlQbH9C1o1ZRlgP+EeUEeqsSsNBpER4BPQXVPTACoz4Gb5J0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748930989; c=relaxed/simple;
	bh=UtF4PfDjBcBu1DL9nnNddav9W3fQEtadGM/IMb9N4jE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gMkoCN76lQWS03MWyV5EBBcKgjRDpJNW1dyJFR/ynrkErTmSegYkZ8nzrCZECekuqmZqh5YLVCN9CzTt9lIket0ZwlB9qLBRFr0uGm3EbLICH9thUaHwxsaNXPxsnZL1P7B+2RCY7Cmb/ht6yriL+S3msSXZ1Px/UajopUAzLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhhcIyTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0960AC4CEED;
	Tue,  3 Jun 2025 06:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748930989;
	bh=UtF4PfDjBcBu1DL9nnNddav9W3fQEtadGM/IMb9N4jE=;
	h=Date:From:To:Cc:Subject:From;
	b=BhhcIyTrhHCWljR/itBfW9/kFaoIzI06VuG0RxttT/E+Angd4Xx5XFk7UgpdDTbGa
	 N67aNl2qLmAxqqs8ANXpeqCp6YJKSzVKQfCkr3U6y/cH8XK0/m47Umk2rEIPxpt3KX
	 acw2lwfJZa4ymx1hJXLxfJ07/unL8T5FjdEESqQQtoL6ZlAz8+0tzyM+bZek9cS4iD
	 6zSeFrHQDJy8nQN5NwJM5qbZxtIN1cEzrZRA+3KPfgSdz3+/5zkeG5YwKoyF8Q30CQ
	 Jx5mJP+v+nW76eMb7enjpvsxYPh6L5v8zhO61TVQNMnLKc41Cb2aNLE9Akz0QTTFp2
	 Dgho0RsIEPHhA==
Date: Tue, 3 Jun 2025 06:09:47 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V patches for 6.16
Message-ID: <aD6Rq7Hm499y5ybR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3:

  Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20250602

for you to fetch changes up to 96959283a58d91ae20d025546f00e16f0a555208:

  Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests (2025-05-23 16:39:37 +0000)

You will see a conflict when you merge this tag. A resolution can be
found here:

   https://lore.kernel.org/linux-next/20250515181414.354d8ef7@canb.auug.org.au/

----------------------------------------------------------------
hyperv-next for v6.16
  - Support for Virtual Trust Level (VTL) on arm64 (Roman Kisel)
  - Fixes for Hyper-V UIO driver (Long Li)
  - Fixes for Hyper-V PCI driver (Michael Kelley)
  - Select CONFIG_SYSFB for Hyper-V guests (Michael Kelley)
  - Documentation updates for Hyper-V VMBus (Michael Kelley)
  - Enhance logging for hv_kvp_daemon (Shradha Gupta)
----------------------------------------------------------------
Long Li (5):
      Drivers: hv: Allocate interrupt and monitor pages aligned to system page boundary
      uio_hv_generic: Use correct size for interrupt and monitor pages
      uio_hv_generic: Align ring size to system page
      Drivers: hv: Use kzalloc for panic page allocation
      Drivers: hv: Remove hv_alloc/free_* helpers

Michael Kelley (4):
      PCI: hv: Remove unnecessary flex array in struct pci_packet
      Documentation: hyperv: Update VMBus doc with new features and info
      Drivers: hv: vmbus: Add comments about races with "channels" sysfs dir
      Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests

Roman Kisel (13):
      arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID
      arm64: hyperv: Use SMCCC to detect hypervisor presence
      Drivers: hv: Enable VTL mode for arm64
      Drivers: hv: Provide arch-neutral implementation of get_vtl()
      arm64: hyperv: Initialize the Virtual Trust Level field
      arm64, x86: hyperv: Report the VTL the system boots in
      dt-bindings: microsoft,vmbus: Add interrupt and DMA coherence properties
      Drivers: hv: vmbus: Get the IRQ number from DeviceTree
      Drivers: hv: vmbus: Introduce hv_get_vmbus_root_device()
      ACPI: irq: Introduce acpi_get_gsi_dispatcher()
      PCI: hv: Get vPCI MSI IRQ domain from DeviceTree
      x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()
      arch/x86: Provide the CPU number in the wakeup AP callback

Shradha Gupta (1):
      tools: hv: Enable debug logs for hv_kvp_daemon

 .../devicetree/bindings/bus/microsoft,vmbus.yaml   | 16 +++-
 Documentation/virt/hyperv/vmbus.rst                | 28 +++++-
 arch/arm64/hyperv/mshyperv.c                       | 53 ++++++++++--
 arch/arm64/kvm/hypercalls.c                        | 10 ++-
 arch/x86/coco/sev/core.c                           | 13 +--
 arch/x86/hyperv/hv_init.c                          | 67 ++++++++-------
 arch/x86/hyperv/hv_vtl.c                           | 61 +++----------
 arch/x86/hyperv/ivm.c                              | 11 ++-
 arch/x86/include/asm/apic.h                        |  8 +-
 arch/x86/include/asm/mshyperv.h                    |  7 +-
 arch/x86/kernel/acpi/madt_wakeup.c                 |  2 +-
 arch/x86/kernel/apic/apic_noop.c                   |  8 +-
 arch/x86/kernel/apic/apic_numachip.c               |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c                 |  2 +-
 arch/x86/kernel/smpboot.c                          | 10 +--
 drivers/acpi/irq.c                                 | 16 +++-
 drivers/firmware/smccc/kvm_guest.c                 | 10 +--
 drivers/firmware/smccc/smccc.c                     | 17 ++++
 drivers/hv/Kconfig                                 |  7 +-
 drivers/hv/connection.c                            | 23 +++--
 drivers/hv/hv_common.c                             | 76 ++++++++---------
 drivers/hv/vmbus_drv.c                             | 95 ++++++++++++++++++---
 drivers/pci/controller/pci-hyperv.c                | 99 +++++++++++++++++-----
 drivers/uio/uio_hv_generic.c                       |  7 +-
 include/asm-generic/mshyperv.h                     | 10 ++-
 include/hyperv/hvgdk_mini.h                        |  4 +-
 include/linux/acpi.h                               |  5 +-
 include/linux/arm-smccc.h                          | 64 +++++++++++++-
 include/linux/hyperv.h                             |  2 +
 tools/hv/hv_kvp_daemon.c                           | 64 ++++++++++++--
 30 files changed, 562 insertions(+), 235 deletions(-)

