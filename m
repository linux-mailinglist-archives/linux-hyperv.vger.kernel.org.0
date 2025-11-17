Return-Path: <linux-hyperv+bounces-7630-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A91C65732
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 438AF355DD5
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1233E340;
	Mon, 17 Nov 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvcwNiaf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4230C601;
	Mon, 17 Nov 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399045; cv=none; b=J6eKQbx1bZHoZxi5z8n11zaEhjDvW49t0AScuCPdF35i1Slg8sYWMaOQjxcLir7ddAHtHEMsbHuRW+BP5XSZPqsboqTi1ippZew9FRTveV++HKY/mffH/8du1O1/CC5oUsrRr3XMxPdDUX/XnNY0zaNR45cyNLEPwEz5tyUFUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399045; c=relaxed/simple;
	bh=vGrHhmXQ4TodDzqmZAFshuYEYupMpjDw4+9+3n6uqbg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HTxAA362hOp3lIC6oZmhR7PgHPB5Pe2SWbTGa7cJm+jU00nr0T0f9JDSxlP+IaNEnEujbm4NRrPfjowTdaOKlQJAV2DnVsAg7x6lIzqQCI95yNk+EVIeT2JE44uVnt+IofuPekNyc4HDsirz5JcxVBhTiAEhBhvSuACZ/Zwtc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvcwNiaf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763399043; x=1794935043;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=vGrHhmXQ4TodDzqmZAFshuYEYupMpjDw4+9+3n6uqbg=;
  b=mvcwNiaf2G+gmsTJ3iXeeGHDUBll966ml8ijOQaQ6p8l49O8hnJeXeN6
   /2iuZ39sXzW46Q0zq23+2UEJcE9wjlJHfdkckSSy2dseBPshlkiMjZf0w
   G5JVxMM39OTlIely3MLxkGn0FJPKC68t8XJezjwbHMQT+9JB04q5bYjB5
   OASb7MdhK7YbU1IBerXQMIK5zp8jTiEtPgb+chvtW59EyvELKquDys8oJ
   YFlHQbP60ItvqUA3A5wPXDMRx7VJ+ku2xTPjictuFlo3ECg96wBqu/sqr
   WPHD8XBQJqOrYdS+sah6ALvpFlS3+wyraZ11sTSkpBnE86oGWPKvD6j09
   Q==;
X-CSE-ConnectionGUID: 31g8GBc9Qu6VO2+FjKY2jw==
X-CSE-MsgGUID: lPDkqTomTducF20MkG3o0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69253631"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="69253631"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:04:01 -0800
X-CSE-ConnectionGUID: YolEjJnlTP24cwv/JK08ZA==
X-CSE-MsgGUID: I33gCioIRt2KYeBDtiFI8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="195445166"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:04:01 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v7 0/9] x86/hyperv/hv_vtl: Use a wakeup mailbox to boot
 secondary CPUs
Date: Mon, 17 Nov 2025 09:02:46 -0800
Message-Id: <20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZVG2kC/3XPy26DMBAF0F+JvK6RPX6FrPofVRcGj4tVsCNDK
 FXEv9cg9SGVLO9izr1zJyPmgCO5nO4k4xzGkGIJ5ulE2s7GN6TBlUyAgWKaAc2xHNAP+463Kx1
 s6Ju0UAFn9GjgzIQn5fSa0YdlZ19eS/Y5DXTqMtpfTDHBa664qkAyySmnObQ2u1TtDa3tHeYUn
 /sQb0sV4oR91aZh47swTil/7qNnuZV87xPH+2ZJGXVKCDDQGBDwT91WzuoPBeYBpTbKK2ka7ni
 t8ZjSPxRnXD+gdKHK70L5phZMHVDrun4BBH6UiqMBAAA=
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
 Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
 "Rafael J. Wysocki (Intel)" <rafael.j.wysocki@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763398999; l=8299;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=vGrHhmXQ4TodDzqmZAFshuYEYupMpjDw4+9+3n6uqbg=;
 b=Gctc+F43mWkhjqg3rRHFLzuI5JsD3yrpnH3nuOEaDVe2sijWQoF9dZacfMJpmedq28lTfCq94
 nn5xhdKm0VODwAUDNURcv0M2a9fGXUMnluzfguYRyHH6cIEJLiS9OKt
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Hi,

Many thanks to Boris, Rafael, Rob, and Dexuan for their valuable feedback!
The main change in this version is the removal of the patch that moved the
ACPI mailbox code from the x86 ACPI subsystem to a generic location. Users
with DeviceTree-based firmware who wish use the ACPI wakeup mailbox need to
select CONFIG_ACPI=y.

I dropped the Reviewed-by and Acked-by tags from patches 1, 7, and 8 as I
made non-trivial changes to them. Once reviewed, maybe the patchset is
ready to be merged?

I made minor changes to the cover letter to reflect the contents of this
updated version.

Thanks in advance for your feedback!

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

   * Expose functions to reuse the code handling the ACPI Multiprocessor
     Wakeup Structure outside of ACPI code. (patch 1)
   * Define DeviceTree bindings to enumerate a mailbox as described in
     the ACPI specification. (patch 2)
   * Find and set up the wakeup mailbox if enumerated in the DeviceTree
     graph. (patch 3)
   * Prepare Hyper-V VTL2 TDX guests to use the Wakeup Mailbox to boot
     secondary CPUs when available. (patches 4-9)

I have tested this patchset on a Hyper-V host with VTL2 OpenHCL, QEMU, and
physical hardware.

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

[1]. https://lore.kernel.org/all/aNxGzWMoM_oQ6n1N@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net/
[2]. https://openvmm.dev/guide/user_guide/openhcl.html
--
2.43.0

---
Ricardo Neri (5):
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
 arch/x86/hyperv/hv_vtl.c                           | 36 ++++++++++++++--
 arch/x86/include/asm/acpi.h                        | 16 +++++++
 arch/x86/include/asm/x86_init.h                    |  3 ++
 arch/x86/kernel/acpi/madt_wakeup.c                 | 16 +++++++
 arch/x86/kernel/devicetree.c                       | 47 ++++++++++++++++++++
 arch/x86/kernel/x86_init.c                         |  3 ++
 arch/x86/realmode/init.c                           |  7 ++-
 8 files changed, 170 insertions(+), 8 deletions(-)
---
base-commit: 6f85aad74a70d17919a64ecd93037aa51c08698d
change-id: 20250602-rneri-wakeup-mailbox-328efe72803f

Best regards,
-- 
Ricardo Neri <ricardo.neri-calderon@linux.intel.com>


