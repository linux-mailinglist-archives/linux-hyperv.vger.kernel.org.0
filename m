Return-Path: <linux-hyperv+bounces-8176-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B639D0039D
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 22:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9344330222E0
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3EF2FD691;
	Wed,  7 Jan 2026 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCr2l0hG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C32F261C;
	Wed,  7 Jan 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822363; cv=none; b=ezcVwiQb+cM1KUT6oO8w5f3AEtCEpcF/d5ZUQ7S9fpJagrg3owTVnW2Jh2BLwYeCdTYXpn5uoafWMGy1E2oIKcF36FZ3YF1nrXGSOuQxOnZ7XF6e8wEG4VAHvg5UQ4g/ofgCa5Sk8cRy3mf5rX3NTcOwDPLgBkg1GsLZBtdPCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822363; c=relaxed/simple;
	bh=4W+oGcQ2gg0LEHLUvZck8IORIv8h8lQawEf9gAgqPKc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S7J9qULDpfgHCbxoyqDKvZ6M4r038aamttRguu9hVgDvRC3Z9tXqsRamFHnro4Wq5AOw4jqWV4NLnNKopwVAhxJQ4EVZeWDb8y9PZp3GEOXaE4hl/8h3JGcUKdJ4xzr8s6qA2TpiTFuBRFU/RajVGAiwEmXzbWZ1T53+3Kdlf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCr2l0hG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767822361; x=1799358361;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=4W+oGcQ2gg0LEHLUvZck8IORIv8h8lQawEf9gAgqPKc=;
  b=OCr2l0hGgRpej3XoTuLBtbdglS6Jn8NziW9+klFyj/el38O804oMk7Rk
   k0UwHhT7bJfCpqBFEdxqgzBqahN7DHsR3ziRiwJruWMw61OkAjn6l8w1P
   uYWZ+jTlLYB/rlGPmb4wGFS0aFe923UrD/TD+R5a2Mm16bBHCzIwIQ68O
   qidFBw1768/QymakkxtpiKMBIG0NrCUA2WSuzrgYQCt30AJAOkroUcLpg
   S/O7QknQg2J38mHAnHOFxZMXzVepn2G3RbUWC0cXXPv2Q87IFAYLr04x3
   LUsUIPQahEi6PhF9Wci+N5A3gbR2FKeQfYj1GHN6u/ai9MlfVBsbhtyFs
   Q==;
X-CSE-ConnectionGUID: js7cixPiSCOOx9O3vxO2mw==
X-CSE-MsgGUID: tMsNT6oJRTm0HLbmkBn59g==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69359262"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69359262"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:01 -0800
X-CSE-ConnectionGUID: UTk0Bl7ER0i5RDQIER8ApA==
X-CSE-MsgGUID: o7K0ddWYTle9BHaOPvsDUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207510889"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:01 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v8 00/10] x86/hyperv/hv_vtl: Use a wakeup mailbox to boot
 secondary CPUs
Date: Wed, 07 Jan 2026 13:44:36 -0800
Message-Id: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMTTXmkC/3XPwW6EIBQF0F+ZsC4GHiI6q/5H0wXgo5IqTNCxN
 hP/vWjSTpMZl3fxzr3vRkZMHkdyPt1IwtmPPoYc6pcTsZ0OH0h9mzMBBpJVDGgK+YB+6U+8Xui
 gfW/iQgXU6FBBzYQj+fSS0PllZ9/ec3YpDnTqEuo7JpngDZdcFlCyklNOk7c6tbHYG6zuW0wxv
 PY+XJfChwn7wsZh4zs/TjF976Pnciv53See75tLymgrhQAFRoGAB3VbOct/FKgDSm6Uk6UyvOV
 Nhc+p6o/ijFcHVJWp/LuQzjSCyQNK3SnOj1apjdK1qUEbZcE+Uuu6/gD8cEzp7gEAAA==
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri@intel.com>, kernel test robot <lkp@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
 "Rafael J. Wysocki (Intel)" <rafael.j.wysocki@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767822314; l=8466;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=4W+oGcQ2gg0LEHLUvZck8IORIv8h8lQawEf9gAgqPKc=;
 b=OpHUtMoecmXbMPpdL3CTIRoMz3wEZcOtx7RgMZ2acuJRhdSSLVWaTtZ+FdY1t2rb/ixqop9BW
 LiVBvyeMKogC3MA+H5SyRDRa2UGARgG10hL5LVg8yFUryffYJV7Q2VM
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Hi,

Happy New Year! I have a new version of this patchset to start the year.
I incorporated a patch that I had posted separately to fix a build break
that I found while working on this series [1]. I also added the Acked-by
tags from Rafael. No other changes.

I include the cover letter from the previous version for convenience.

Thanks a lot to all those who have reviewed the series!

...

This patchset adds functionality to use the ACPI wakeup mailbox to boot
secondary CPUs in Hyper-V VTL level 2 TDX guests with DeviceTree-based
virtual firmware. Although this is the target use case, the use of the
mailbox depends solely on it being enumerated in the DeviceTree graph.

On x86 platforms, secondary CPUs are typically booted using INIT assert,
de-assert followed by Start-Up IPI messages. Virtual machines can also use
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
[2]) instead of ACPI to describe the hardware.

Provided that the wakeup mailbox enumerated in a DeviceTree-based platform
firmware is implemented as described in the ACPI specification, the kernel
can use the existing ACPI code for both DeviceTree and ACPI systems. The
DeviceTree firmware does not need to use any ACPI table to enumerate the
mailbox.

This patchset is structured as follows:

   * Add missing dependencies to arch/x86/include/asm/topology.h. (patch 1)
   * Expose functions to reuse the code handling the ACPI Multiprocessor
     Wakeup Structure outside of ACPI code. (patch 2)
   * Define DeviceTree bindings to enumerate a mailbox as described in
     the ACPI specification. (patch 3)
   * Find and set up the wakeup mailbox if enumerated in the DeviceTree
     graph. (patch 4)
   * Prepare Hyper-V VTL2 TDX guests to use the Wakeup Mailbox to boot
     secondary CPUs when available. (patches 5-10)

I have tested this patchset on a Hyper-V host with VTL2 OpenHCL, QEMU, and
physical hardware.

Changes in v8:
- Fixed a build break. Same patch as [1].
- Added two Acked-by tags from Rafael. Thanks!
- Link to v7: https://lore.kernel.org/r/20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com

Changes in v7:
- Dropped the patch that relocated the ACPI wakeup mailbox to an generic
  location. (Boris)
- Instead, added function declarations to use the wakeup mailbox from
  outside ACPI code. Also added stubs for !CONFIG_ACPI.
- Link to v6: https://lore.kernel.org/r/20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com

Changes in v6:
- Fixed a build error with !CONFIG_X86_MAILBOX_WAKEUP and
  CONFIG_HYPER_VTL_MODE.
- Added Acked-by tags from Rafael. Thanks!
- Added Reviewed-by tags from Dexuan and Rob. Thanks!
- Corrected typos and function names in the changelog.
- Link to v5: https://lore.kernel.org/r/20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com

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

[1]. https://lore.kernel.org/all/20251117-rneri-topology-cpuinfo-bug-v1-1-a905bb5f91e2@linux.intel.com/
[2]. https://openvmm.dev/guide/user_guide/openhcl.html
--
2.43.0

---
Ricardo Neri (6):
      x86/topology: Add missing struct declaration and attribute dependency
      x86/acpi: Add functions to setup and access the wakeup mailbox
      dt-bindings: reserved-memory: Wakeup Mailbox for Intel processors
      x86/dt: Parse the Wakeup Mailbox for Intel processors
      x86/acpi: Add a helper get the address of the wakeup mailbox
      x86/hyperv/vtl: Use the wakeup mailbox to boot secondary CPUs

Yunhong Jiang (4):
      x86/hyperv/vtl: Set real_mode_header in hv_vtl_init_platform()
      x86/realmode: Make the location of the trampoline configurable
      x86/hyperv/vtl: Setup the 64-bit trampoline for TDX guests
      x86/hyperv/vtl: Mark the wakeup mailbox page as private

 .../reserved-memory/intel,wakeup-mailbox.yaml      | 50 ++++++++++++++++++++++
 arch/x86/hyperv/hv_vtl.c                           | 38 ++++++++++++++--
 arch/x86/include/asm/acpi.h                        | 16 +++++++
 arch/x86/include/asm/topology.h                    |  3 ++
 arch/x86/include/asm/x86_init.h                    |  3 ++
 arch/x86/kernel/acpi/madt_wakeup.c                 | 16 +++++++
 arch/x86/kernel/devicetree.c                       | 47 ++++++++++++++++++++
 arch/x86/kernel/x86_init.c                         |  3 ++
 arch/x86/realmode/init.c                           |  7 ++-
 9 files changed, 175 insertions(+), 8 deletions(-)
---
base-commit: 39127143100254ceb5f31469ac9a10a2a5b71285
change-id: 20250602-rneri-wakeup-mailbox-328efe72803f

Best regards,
-- 
Ricardo Neri <ricardo.neri-calderon@linux.intel.com>


