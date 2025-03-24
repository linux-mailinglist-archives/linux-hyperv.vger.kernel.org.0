Return-Path: <linux-hyperv+bounces-4679-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8A3A6E18F
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Mar 2025 18:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCD63AE703
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Mar 2025 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1555F26461C;
	Mon, 24 Mar 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3o+whsa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11902641FC;
	Mon, 24 Mar 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837803; cv=none; b=IbH+fgsIO/hv40/bYyZbodU7GOIAfiJmjSTp8drXcdgXc/KhBodDOC09e3veNDKKKw1dIvKBZRJq5HnnpJs5HEjK3VWNhlYl4x6FvSoPR/1/lZGOQ5v/EZNkCLM2zNDE7PvVxqRWST4AzruZsqiCw8KEv/3mrrCoQ0U5PiupLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837803; c=relaxed/simple;
	bh=+25jEvHEESNINi6+64Bl9j1NggULgv81xjHU1aPWSZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cXVvMsWbnj1j6bZDr0Bg2+SFqVp9G2f0Ynsy4NJfoqzR5cGjbb4Qb9+oRg2p0lZEH7xCNs/g2Ypk6TxuEIRvRDnWqtvB2EOX7tAVef7Win06l9Y06GOFbVsbFerXARx2YlBBvlqyUriJxWVybG0xTW+fUJevSP+IGhe+CxZA30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3o+whsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7C2C4CEDD;
	Mon, 24 Mar 2025 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742837802;
	bh=+25jEvHEESNINi6+64Bl9j1NggULgv81xjHU1aPWSZk=;
	h=Date:From:To:Cc:Subject:From;
	b=c3o+whsa46fydE3RC51ZYro7T5XNgIaZ977VtUfZ9kehOn5JgAF2hBgCkWdBcWi2E
	 sj2sJZoRk2S+gO8LEm9wNyV64H0OLwtsnpNvoP6bTRWVWmiAEV1/C/LJEHDrLJVJqH
	 m7WAj/jr8+5xsenFS++9IW1GaGJGTYYLsCXT0OV+KuXtSxwYYktT9SLgPZL2J5UnJQ
	 75c1tsr/PwMjkN5ErXSPI13fWMOkZT7YLTlw5a49UNjMsqVNZw0+iNhoytr6GaKrIi
	 8Rz0N2FLXWqiS+vIEcoj8Kh74XC9iN+PXZCJbzbG1F41nomVcfsZYwt5QeGkuZwNwg
	 k0ODsGse/rVHQ==
Date: Mon, 24 Mar 2025 17:36:41 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V patches for 6.15
Message-ID: <Z-GYKSuytHh-Weas@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Linus,

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20250324

for you to fetch changes up to 628cc040b3a2980df6032766e8ef0688e981ab95:

  x86/hyperv: fix an indentation issue in mshyperv.h (2025-03-21 22:41:56 +0000)

----------------------------------------------------------------
hyperv-next for 6.15
 - Add support for running as the root partition in Hyper-V (Microsoft
   Hypervisor) by exposing /dev/mshv (Nuno and various people)
 - Add support for CPU offlining in Hyper-V (Hamza Mahfooz)
 - Misc fixes and cleanups (Roman Kisel, Tianyu Lan, Wei Liu, Michael Kelley,
   Thorsten Blum)
----------------------------------------------------------------
Hamza Mahfooz (3):
      cpu: export lockdep_assert_cpus_held()
      drivers/hv: introduce vmbus_channel_set_cpu()
      drivers/hv: add CPU offlining support

Michael Kelley (1):
      x86/hyperv: Add comments about hv_vpset and var size hypercall input args

Nuno Das Neves (14):
      hyperv: Move hv_current_partition_id to arch-generic code
      hyperv: Move arch/x86/hyperv/hv_proc.c to drivers/hv
      hyperv: Convert hypercall statuses to linux error codes
      hyperv: Change hv_root_partition into a function
      hyperv: Add CONFIG_MSHV_ROOT to gate root partition support
      hyperv: Log hypercall status codes as strings
      arm64/hyperv: Add some missing functions to arm64
      hyperv: Introduce hv_recommend_using_aeoi()
      acpi: numa: Export node_to_pxm()
      Drivers: hv: Export some functions for use by root partition module
      Drivers: hv: Introduce per-cpu event ring tail
      x86: hyperv: Add mshv_handler() irq handler and setup function
      hyperv: Add definitions for root partition driver to hv headers
      Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs

Roman Kisel (2):
      x86/hyperv: Add VTL mode emergency restart callback
      x86/hyperv: Add VTL mode callback for restarting the system

Stanislav Kinsburskii (1):
      x86/mshyperv: Add support for extended Hyper-V features

Thorsten Blum (1):
      hyperv: Remove unused union and structs

Tianyu Lan (1):
      x86/hyperv: Fix check of return value from snp_set_vmsa()

Wei Liu (1):
      x86/hyperv: fix an indentation issue in mshyperv.h

 Documentation/userspace-api/ioctl/ioctl-number.rst |    2 +
 arch/arm64/hyperv/hv_core.c                        |   17 +
 arch/arm64/hyperv/mshyperv.c                       |    6 +
 arch/arm64/include/asm/mshyperv.h                  |   13 +
 arch/x86/hyperv/Makefile                           |    2 +-
 arch/x86/hyperv/hv_apic.c                          |    5 +
 arch/x86/hyperv/hv_init.c                          |   35 +-
 arch/x86/hyperv/hv_vtl.c                           |   34 +
 arch/x86/hyperv/irqdomain.c                        |    6 +-
 arch/x86/hyperv/ivm.c                              |    2 +-
 arch/x86/hyperv/mmu.c                              |    4 +
 arch/x86/include/asm/mshyperv.h                    |    8 +-
 arch/x86/kernel/cpu/mshyperv.c                     |   40 +-
 drivers/acpi/numa/srat.c                           |    1 +
 drivers/clocksource/hyperv_timer.c                 |    4 +-
 drivers/hv/Kconfig                                 |   17 +
 drivers/hv/Makefile                                |    4 +
 drivers/hv/hv.c                                    |   94 +-
 drivers/hv/hv_common.c                             |  198 +-
 {arch/x86/hyperv => drivers/hv}/hv_proc.c          |   27 +-
 drivers/hv/mshv.h                                  |   30 +
 drivers/hv/mshv_common.c                           |  161 ++
 drivers/hv/mshv_eventfd.c                          |  833 +++++++
 drivers/hv/mshv_eventfd.h                          |   71 +
 drivers/hv/mshv_irq.c                              |  124 ++
 drivers/hv/mshv_portid_table.c                     |   83 +
 drivers/hv/mshv_root.h                             |  311 +++
 drivers/hv/mshv_root_hv_call.c                     |  849 +++++++
 drivers/hv/mshv_root_main.c                        | 2307 ++++++++++++++++++++
 drivers/hv/mshv_synic.c                            |  665 ++++++
 drivers/hv/vmbus_drv.c                             |   54 +-
 drivers/iommu/hyperv-iommu.c                       |    8 +-
 include/asm-generic/mshyperv.h                     |   72 +-
 include/hyperv/hvgdk_mini.h                        |   83 +-
 include/hyperv/hvhdk.h                             |  132 +-
 include/hyperv/hvhdk_mini.h                        |   91 +
 include/linux/hyperv.h                             |   57 +-
 include/uapi/linux/mshv.h                          |  291 +++
 kernel/cpu.c                                       |    1 +
 39 files changed, 6514 insertions(+), 228 deletions(-)
 rename {arch/x86/hyperv => drivers/hv}/hv_proc.c (90%)
 create mode 100644 drivers/hv/mshv.h
 create mode 100644 drivers/hv/mshv_common.c
 create mode 100644 drivers/hv/mshv_eventfd.c
 create mode 100644 drivers/hv/mshv_eventfd.h
 create mode 100644 drivers/hv/mshv_irq.c
 create mode 100644 drivers/hv/mshv_portid_table.c
 create mode 100644 drivers/hv/mshv_root.h
 create mode 100644 drivers/hv/mshv_root_hv_call.c
 create mode 100644 drivers/hv/mshv_root_main.c
 create mode 100644 drivers/hv/mshv_synic.c
 create mode 100644 include/uapi/linux/mshv.h

