Return-Path: <linux-hyperv+bounces-6034-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5FAEC47C
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A204A4348
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7140F21ADC6;
	Sat, 28 Jun 2025 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Azr7iryP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1611D6187;
	Sat, 28 Jun 2025 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081721; cv=none; b=iKL1fEj7A9oVjl3L+5Wvy67HL7gppN8M6jIXOWImLKOQXfkZh999DLQN3khpjfW5+3E/DgmoGvXeyH+4bysACs/tZ+CQCNXhcCj9ayG6psRPrsf/dHAeHx5M3/jdg5zRXsd+ZWptU/Fl3CrIF/LVorVYoK+0qRp+6ccmBNi85iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081721; c=relaxed/simple;
	bh=ockXzS+ZjNSsCGNwgsq5TEMjFWUEMysLduNfQaxzfn0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UCSoaKGy0caMhf971kn9ipY65tXnCzIYyqZ0Qa06yPl3tsl6HzCsV+wCO4MYjli5jg7bKAaoKXf8vn1uGSQBZWzSbH30Oj5m3WCL+sLSpk3sVcwXesjifZJD4f3QnTJcuA4MzUx2JcOT5yYMGwOjR8HEc3agK4MUKE4uzzSbwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Azr7iryP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081720; x=1782617720;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ockXzS+ZjNSsCGNwgsq5TEMjFWUEMysLduNfQaxzfn0=;
  b=Azr7iryPANPeXneMYTbqnFuX1wb62u7BZSn8hc0dauJvjZ2v082ImcJi
   7/UiPL0wLSuNezbmyPLjsi4KNs3IUboeVnZHAVzs869P3CbpO6MUTOtPG
   rSCUcETkV9MKdThyyTVXUiUS/cpwCRTCRRb0vMw6dIEoP7Allc/+5jfRh
   zA9P7PUgcSHJOBBpDwfeRyuemtseuj7WbmWKIwtQ7GqgM8uMk9rj4M5w7
   iVKqLOJLM4xUtGeA696LHSAVWBuP0ZeqAH9oXVL3yPFvr6xzWb/t2m9L2
   JDot97U2LA+yKTY8sqJeW+eIduFzGl+YbVB+0tUNZgIdTiko7Xmdx/c3e
   A==;
X-CSE-ConnectionGUID: /FEjSQ9RRauLjYGZObXdfQ==
X-CSE-MsgGUID: v4DQ4iqKQSGAwnEkEzlFgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335309"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335309"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:19 -0700
X-CSE-ConnectionGUID: 9h8YryBzSBusAuIdET+0ZQ==
X-CSE-MsgGUID: HHw2sYQGRqu+WOdNfcABJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141913"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:18 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v5 00/10] x86/hyperv/hv_vtl: Use a wakeup mailbox to boot
 secondary CPUs
Date: Fri, 27 Jun 2025 20:35:06 -0700
Message-Id: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOpiX2gC/22OQW6DMBBFrxJ53UH2GJc0q96jysLAEEYBGw2EU
 iHuHgcpyiJdvsV//61qJGEa1emwKqGZR44hgfs4qKr14ULAdWKFGp3+1AgS0gB+/ZVuA/SeuzI
 uYPFIDRV41LZRaToINbzs2p9z4kZiD1Mr5F8yp635Ms64DHOdGzAgXHmpY7Y/VL6rSWL47jjcl
 ozDRF1Wxf6hb3mcovzt0XP+OHn22f/75hw01M5aLLAs0OKb9bxt2x0p8VbeDQEAAA==
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=7517;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=ockXzS+ZjNSsCGNwgsq5TEMjFWUEMysLduNfQaxzfn0=;
 b=idAF01MHRiPxPSjXgLz6n5rUGWxbaGbyjSn0Z+fpnB6Yp79vK04tUyKxwmu29ShtH+KsUGcnK
 2s6574oqtL3DoGUL2ZsfmDMZcBo/QlUYUmYWmsf8nRta+r4rGMa3Ach
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Hi,

Here is a new version of this series. Thanks to Rafael for his feedback!
I incorporated his feedback in this updated version. Please see the
changelog for details.

If the DeviceTree bindings look good, then the patches should be ready for
review by the x86, ACPI, and Hyper-V maintainers.

I did not change the cover letter but I included it here for completeness.

Thanks in advance for your feedback!

...

This patchset adds functionality to use a wakeup mailbox to boot secondary
CPUs in Hyper-V VTL level 2 TDX guests with virtual firmware that describes
hardware using a DeviceTree graph. Although this is the target use case,
the use of the mailbox depends solely on it being enumerated in the
DeviceTree.

On x86 platforms, secondary CPUs are typically booted using INIT assert,
de-assert followed by Start-Up IPI messages. Virtual machines can also make
hypercalls to bring up secondary CPUs to a desired execution state. These
two mechanisms require support from the hypervisor. Confidential computing
VMs in a TDX environment cannot use this mechanism because the hypervisor
is considered an untrusted entity.

Linux already supports the ACPI Multiprocessor Wakeup Structure in which
the guest platform firmware boots the secondary CPUs and transfers control
to the kernel using a mailbox. This mechanism does not need involvement
of the VMM. It can be used in a Hyper-V VTL level 2 TDX guest.

Currently, this mechanism can only be used on x86 platforms with firmware
that supports ACPI. There are platforms that use DeviceTree (e.g., OpenHCL
[5]) instead of ACPI to describe the hardware.

Provided that the wakeup mailbox enumerated in a DeviceTree-based platform
firmware is implemented as described in the ACPI specification, the kernel
can used common code for both DeviceTree and ACPI systems. The DeviceTree
firmware does not need to use any ACPI table to publish the mailbox.

This patcheset is structured as follows:

   * Relocate portions of the code handling the ACPI Multiprocessor Wakeup
     Structure code to a common location. (patches 1, 2)
   * Define DeviceTree bindings to enumerate a mailbox as described in
     the ACPI specification. (patch 3)
   * Find and setup the wakeup mailbox if found in the DeviceTree graph.
     (patch 4)
   * Prepare Hyper-V VTL2 TDX guests to use the Wakeup Mailbox to boot
     secondary CPUs when available. (patches 5-10)

I have tested this patchset on a Hyper-V host with VTL2 OpenHCL, QEMU, and
physical hardware.

Changes in v5:
- Referred in the DeviceTree binding documentation the section and
  section of the ACPI specification that defines the wakeup mailbox.
- Moved the dependency on CONFIG_OF to patch 4, where the flattened
  DeviceTree is parsed for the mailbox.
- Fixed a warning from yamllint regarding line lengths.
- Link to v4: https://lore.kernel.org/r/20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com

Changes in v4:
- Added Reviewed-by: tags from Michael Kelley. Thanks!
- Relocated the common wakeup code from acpi/madt_wakeup.c to a new
  smpwakeup.c to be used in DeviceTree- and ACPI-based systems.
- Dropped the x86 CPU bindings as they are not a good fit to document
  firmware features.
- Dropped the code that parsed and validated of the `enable-method`
  property for cpu@N nodes in x86. Instead, unconditionally parse and use
  the wakeup mailbox when found.
- Updated the wakeup mailbox schema to avoid redefing the structure and
  operation of the mailbox. Instead, refer to the ACPI specification.
  Also clarified that the enumeration of the mailbox is done separately.
- Prefixed helper functions of wakeup code with acpi_.
- Link to v3: https://lore.kernel.org/r/20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com

Changes in v3:
- Only move out of the acpi directory acpi_wakeup_cpu() and its
  accessory variables. Use helper functions to access the mailbox as
  needed. This also fixed the warnings about unused code with CONFIG_
  ACPI=n that Michael reported.
- Major rework of the DeviceTree bindings and schema. Now there is a
  reserved-memory binding for the mailbox as well as a new x86 CPU
  bindings. Both have `compatible` properties.
- Rework of the code parsing the DeviceTree bindings for the mailbox.
  Now configuring the mailbox depends solely on its enumeration in the
  DeviceTree and not on Hyper-V VTL2 TDX guest.
- Do not make reserving the first 1MB of memory optional. It is not
  needed and may introduce bugs.
- Prepare Hyper-V VTL2 guests to unconditionally use the mailbox in TDX
  environments. If the mailbox is not available, booting secondary CPUs
  will fail gracefully.
- Link to v2: https://lore.kernel.org/r/20240823232327.2408869-1-yunhong.jiang@linux.intel.com

Changes in v2:
- Fix the cover letter's summary phrase.
- Fix the DT binding document to pass validation.
- Change the DT binding document to be ACPI independent.
- Move ACPI-only functions into the #ifdef CONFIG_ACPI.
- Change dtb_parse_mp_wake() to return mailbox physical address.
- Rework the hv_is_private_mmio_tdx().
- Remove unrelated real mode change from the patch that marks mailbox
  page private.
- Check hv_isolation_type_tdx() instead of wakeup_mailbox_addr in
  hv_vtl_init_platform() because wakeup_mailbox_addr is not parsed yet.
- Add memory range support to reserve_real_mode.
- Remove realmode_reserve callback and use the memory range.
- Move setting the real_mode_header to hv_vtl_init_platform.
- Update comments and commit messages.
- Minor style changes.
- Link to v1: https://lore.kernel.org/r/20240806221237.1634126-1-yunhong.jiang@linux.intel.com

[1]. https://openvmm.dev/guide/user_guide/openhcl.html
--
2.43.0

---
Ricardo Neri (6):
      x86/acpi: Add a helper functions to setup and access the wakeup mailbox
      x86/acpi: Move acpi_wakeup_cpu() and helpers to smpwakeup.c
      dt-bindings: reserved-memory: Wakeup Mailbox for Intel processors
      x86/dt: Parse the Wakeup Mailbox for Intel processors
      x86/smpwakeup: Add a helper get the address of the wakeup mailbox
      x86/hyperv/vtl: Use the wakeup mailbox to boot secondary CPUs

Yunhong Jiang (4):
      x86/hyperv/vtl: Set real_mode_header in hv_vtl_init_platform()
      x86/realmode: Make the location of the trampoline configurable
      x86/hyperv/vtl: Setup the 64-bit trampoline for TDX guests
      x86/hyperv/vtl: Mark the wakeup mailbox page as private

 .../reserved-memory/intel,wakeup-mailbox.yaml      | 50 ++++++++++++
 arch/x86/Kconfig                                   |  7 ++
 arch/x86/hyperv/hv_vtl.c                           | 35 ++++++++-
 arch/x86/include/asm/smp.h                         |  4 +
 arch/x86/include/asm/x86_init.h                    |  3 +
 arch/x86/kernel/Makefile                           |  1 +
 arch/x86/kernel/acpi/madt_wakeup.c                 | 76 ++-----------------
 arch/x86/kernel/devicetree.c                       | 47 ++++++++++++
 arch/x86/kernel/smpwakeup.c                        | 88 ++++++++++++++++++++++
 arch/x86/kernel/x86_init.c                         |  3 +
 arch/x86/realmode/init.c                           |  7 +-
 11 files changed, 242 insertions(+), 79 deletions(-)
---
base-commit: e51a38e71974982abb3f2f16141763a1511f7a3f
change-id: 20250602-rneri-wakeup-mailbox-328efe72803f

Best regards,
-- 
Ricardo Neri <ricardo.neri-calderon@linux.intel.com>


