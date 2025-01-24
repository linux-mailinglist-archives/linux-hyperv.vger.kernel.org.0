Return-Path: <linux-hyperv+bounces-3767-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B25A1AF6D
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Jan 2025 05:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D973A7FC2
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Jan 2025 04:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592461D63D4;
	Fri, 24 Jan 2025 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaRMY0Vj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244AA29;
	Fri, 24 Jan 2025 04:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693429; cv=none; b=DAMNmKJqB1IWgwRc5NUeLfjw4iVC1IwVfHyVkcLujUYaJwnzHUwM1d7T7FrouCp68jLBdDt+0/dvV6RYMqpW1fJOVeIWOrc0Fh0fzSztitOEat2uZ73LE3dvdfF6BGt44antnJKxX/aNshjaJ3FDCNpQkL3+2SAxcHJKBUN9RnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693429; c=relaxed/simple;
	bh=EAuycoBCZz1PY0p9KLgO0qh3AxGECBz16pxchXZK6r8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dwp3b6HJdGlIKsa5xNJa+ianELIRKVMLpxD+Cc5k8C7V22f1mMvDGyZtfQ2TQCI4ygkR9e594jLEtrKqJTJ9+WLPNJvFqive+0CwW8ZkolLfiqnfH5TJfL0v+rRqu5C9cjNmU6EyfEkZYVmzDBo6ZhbDNUoqKvusGE6czqNHBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaRMY0Vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65894C4CED2;
	Fri, 24 Jan 2025 04:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737693428;
	bh=EAuycoBCZz1PY0p9KLgO0qh3AxGECBz16pxchXZK6r8=;
	h=Date:From:To:Cc:Subject:From;
	b=KaRMY0VjppordpcAJMVR4aZBU/pcdw5apH8Z4BuA0qezvm5H66EVgZiqil+0apOxo
	 K/9MmMUAxL/cYzU28CcAa7ztI6LPE9f8nl8M5N4cq4zFGNSVTO4fK8OybURNqiujZ3
	 pT1g1QgfIS0T1bzBzUWGj+cGC6P3v/KM31wWRBiXAGBRTaf5qMUHD9Fu6Q0JlSU2/C
	 9sGh2swdMCHmXgYWD1lqdur3CyAxrdSFaJwDndHCsYquIgQpeAMKoAwmEO0wQs4vEa
	 c6dK7qcYNShEk/g3OaDkAuFbLh+SqobP5PmD3nbn5wPL7yuUuPuN1J6FRgX20Bn0DM
	 B2agL0aOifWww==
Date: Fri, 24 Jan 2025 04:37:07 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V patches for 6.14
Message-ID: <Z5MY8wmtnKFeCcAa@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20250123

for you to fetch changes up to 2e03358be78b65d28b66e17aca9e0c8700b0df78:

  Documentation: hyperv: Add overview of guest VM hibernation (2025-01-13 19:17:59 +0000)

----------------------------------------------------------------
hyperv-next for v6.14
 - Introduce a new set of Hyper-V headers in include/hyperv and replace the
   old hyperv-tlfs.h with the new headers (Nuno Das Neves)
 - Fixes for the Hyper-V VTL mode (Roman Kisel)
 - Fixes for cpu mask usage in Hyper-V code (Michael Kelley)
 - Document the guest VM hibernation behaviour (Michael Kelley)
 - Miscellaneous fixes and cleanups (Jacob Pan, John Starks, Naman Jain)
----------------------------------------------------------------
Jacob Pan (1):
      hv_balloon: Fallback to generic_online_page() for non-HV hot added mem

John Starks (1):
      Drivers: hv: vmbus: Log on missing offers if any

Michael Kelley (4):
      x86/hyperv: Don't assume cpu_possible_mask is dense
      Drivers: hv: Don't assume cpu_possible_mask is dense
      iommu/hyper-v: Don't assume cpu_possible_mask is dense
      Documentation: hyperv: Add overview of guest VM hibernation

Naman Jain (2):
      uio_hv_generic: Add a check for HV_NIC for send, receive buffers setup
      Drivers: hv: vmbus: Wait for boot-time offers during boot and resume

Nuno Das Neves (5):
      hyperv: Move hv_connection_id to hyperv-tlfs.h
      hyperv: Clean up unnecessary #includes
      hyperv: Add new Hyper-V headers in include/hyperv
      hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h
      hyperv: Remove the now unused hyperv-tlfs.h files

Roman Kisel (3):
      hyperv: Enable the hypercall output page for the VTL mode
      hyperv: Do not overlap the hvcall IO areas in get_vtl()
      hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()

 Documentation/virt/hyperv/hibernation.rst |  336 +++++++
 Documentation/virt/hyperv/index.rst       |    1 +
 MAINTAINERS                               |    8 +-
 arch/arm64/hyperv/hv_core.c               |    3 +-
 arch/arm64/hyperv/mshyperv.c              |    4 +-
 arch/arm64/include/asm/hyperv-tlfs.h      |   71 --
 arch/arm64/include/asm/mshyperv.h         |    7 +-
 arch/x86/hyperv/hv_apic.c                 |    1 -
 arch/x86/hyperv/hv_init.c                 |   23 +-
 arch/x86/hyperv/hv_proc.c                 |    3 +-
 arch/x86/hyperv/hv_vtl.c                  |    2 +-
 arch/x86/hyperv/ivm.c                     |    1 -
 arch/x86/hyperv/mmu.c                     |    1 -
 arch/x86/hyperv/nested.c                  |    2 +-
 arch/x86/include/asm/hyperv-tlfs.h        |  811 -----------------
 arch/x86/include/asm/kvm_host.h           |    3 +-
 arch/x86/include/asm/mshyperv.h           |    3 +-
 arch/x86/include/asm/svm.h                |    2 +-
 arch/x86/kernel/cpu/mshyperv.c            |    2 +-
 arch/x86/kvm/vmx/hyperv_evmcs.h           |    2 +-
 arch/x86/kvm/vmx/vmx_onhyperv.h           |    2 +-
 arch/x86/mm/pat/set_memory.c              |    2 -
 drivers/clocksource/hyperv_timer.c        |    2 +-
 drivers/hv/channel_mgmt.c                 |   61 +-
 drivers/hv/connection.c                   |    4 +-
 drivers/hv/hv_balloon.c                   |   22 +-
 drivers/hv/hv_common.c                    |   17 +-
 drivers/hv/hv_kvp.c                       |    2 +-
 drivers/hv/hv_snapshot.c                  |    2 +-
 drivers/hv/hyperv_vmbus.h                 |   16 +-
 drivers/hv/vmbus_drv.c                    |   31 +-
 drivers/iommu/hyperv-iommu.c              |    4 +-
 drivers/uio/uio_hv_generic.c              |   86 +-
 include/asm-generic/hyperv-tlfs.h         |  874 -------------------
 include/asm-generic/mshyperv.h            |    7 +-
 include/clocksource/hyperv_timer.h        |    2 +-
 include/hyperv/hvgdk.h                    |  308 +++++++
 include/hyperv/hvgdk_ext.h                |   46 +
 include/hyperv/hvgdk_mini.h               | 1348 +++++++++++++++++++++++++++++
 include/hyperv/hvhdk.h                    |  733 ++++++++++++++++
 include/hyperv/hvhdk_mini.h               |  311 +++++++
 include/linux/hyperv.h                    |   11 +-
 net/vmw_vsock/hyperv_transport.c          |    6 +-
 43 files changed, 3261 insertions(+), 1922 deletions(-)
 create mode 100644 Documentation/virt/hyperv/hibernation.rst
 delete mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 delete mode 100644 arch/x86/include/asm/hyperv-tlfs.h
 delete mode 100644 include/asm-generic/hyperv-tlfs.h
 create mode 100644 include/hyperv/hvgdk.h
 create mode 100644 include/hyperv/hvgdk_ext.h
 create mode 100644 include/hyperv/hvgdk_mini.h
 create mode 100644 include/hyperv/hvhdk.h
 create mode 100644 include/hyperv/hvhdk_mini.h

