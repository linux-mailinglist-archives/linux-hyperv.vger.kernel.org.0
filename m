Return-Path: <linux-hyperv+bounces-5326-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA34AA8218
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E4B7ACC02
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2627E7E9;
	Sat,  3 May 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6hsKgKD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF342DC789;
	Sat,  3 May 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299413; cv=none; b=dGpKZOyYTEZ6LWQD7btMOxG8VjBbY5VMYAjF91bb+EfDeUv0CH9P1b8GPzrQNlerW/71b3H9HaWRA/JIKEdhxa8rCfvH/XUcrlsbcCzoMQVJaVKww+7TiJkj/GEh5PLdIr7l5usUldOY+aEBpMLHDA/oqgL+uyFr4rptvbrYeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299413; c=relaxed/simple;
	bh=FbP3ivNjme43qE4kLCKkGteBw1VX+DS/lTWMuvg+vog=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DFS9YvRe48KEFtQTbc3SaFPh/3Q6kpjGBV9ctywW2etp+dFSfE6LRc19vr9S7x8Td8ZO2fRfEo3nOf1IfTI8WTLYWntUhDyR59WpiD1xMqOMnsRkeDWFazwg03z4xrP4uCjQgEA7fNGw10IqvQkEpsDBWli1c+F3vsJdtyOW13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6hsKgKD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299412; x=1777835412;
  h=from:to:cc:subject:date:message-id;
  bh=FbP3ivNjme43qE4kLCKkGteBw1VX+DS/lTWMuvg+vog=;
  b=J6hsKgKDJzO5bYOo1ukQbJgvrgi7mDOGhhcBwyj5EYyO0KsBcb0b9O2B
   7gUWjZTzghlQnlmGJ1g7w06DG+UQcADYmNk1MTSrBMnY6WXC2u70FpCoz
   0WoC8s5CG1xbxW730Bd9XQ5x55p/kpvokfrVTMS31PT5YvOj1pnteskBI
   iue7Ivskd+273miTOoXAwqGfU0RyhirCJZbNUP3CXqaipAS1CaDOrQqlh
   sFrhupY/u4b6pO/jC/lIwz6pqN5tH0pyeUCyLB1orjM+nI1QnN/6nfv6X
   kCA7bEgLlzMVrTiwVcb7qVuYdVNVcU8cvFB0JarkNv8zOLoQ4+fgtS3ed
   Q==;
X-CSE-ConnectionGUID: Oks2LhVoR8u4nUp7xmjRlA==
X-CSE-MsgGUID: HMdXZ6QXTWySLvr86yRzPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095599"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095599"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:10 -0700
X-CSE-ConnectionGUID: Vu9k5b06Txmdk4CFuY7dAw==
X-CSE-MsgGUID: HUuAKM5ASi2XChz3I0h8UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046078"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:09 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org ,
	linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v3 00/13] x86/hyperv/hv_vtl: Use a wakeup mailbox to boot secondary CPUs
Date: Sat,  3 May 2025 12:15:02 -0700
Message-Id: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Hi,

I have taken over this work from Yunhong Jiang [1]. I have implemented all
the feedback received in his last submission. I think that the acpi,
smpboot, and hyperv portions are in good shape and ready for review by the
x86 maintainers. I did major rework on the DeviceTree bindings and in my
opinion are also ready for review by the maintainer too.

Thanks in advance for your feedback!

---

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
[2]) instead of ACPI to describe the hardware.

Provided that a Wakeup Mailbox defined in the DeviceTree is compatible in
structure and operation with the ACPI Multiprocessor Wakeup Structure, the
kernel can use common code for both.

This patcheset is structured as follows:

   * Relocate portions of the ACPI Multiprocessor Wakeup Structure code to
     to a common location. (patches 1-3)
   * Add DeviceTree schema and bindings to define a Wakeup Mailbox for
     Intel processors that is compatible with the ACPI Multiprocessor
     Wakeup Structure as well as a new enable-method property for cpu@N
     nodes (patches 4, 6).
   * Add support to parse the enable-method property in the cpu@N nodes of
     DeviceTree graphs for x86 and enable the Wakeup Mailbox if available.
     (patches 5, 7)
   * Prepare Hyper-V VTL2 TDX guests to use the Wakeup Mailbox to boot
     secondary CPUs when available. (patches 8-13)

I have tested this patchset on a Hyper-V host with VTL2 OpenHCL, QEMU, and
physical hardware.

Thanks and BR,
Ricardo

Changes since v2:
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

Changes since v1:
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

[1]. https://lore.kernel.org/lkml/20240823232327.2408869-7-yunhong.jiang@linux.intel.com/T/#ma1f56fc7eee585b777829fa7e8bd39cd3e780fe0
[2]. https://openvmm.dev/guide/user_guide/openhcl.html

Ricardo Neri (9):
  x86/acpi: Add a helper function to setup the wakeup mailbox
  x86/acpi: Add a helper function to get a pointer to the wakeup mailbox
  x86/acpi: Move acpi_wakeup_cpu() and helpers to smpboot.c
  dt-bindings: x86: Add CPU bindings for x86
  x86/dt: Parse the `enable-method` property of CPU nodes
  dt-bindings: reserved-memory: Wakeup Mailbox for Intel processors
  x86/dt: Parse the Wakeup Mailbox for Intel processors
  x86/smpboot: Add a helper get the address of the wakeup mailbox
  x86/hyperv/vtl: Use the wakeup mailbox to boot secondary CPUs

Yunhong Jiang (4):
  x86/hyperv/vtl: Set real_mode_header in hv_vtl_init_platform()
  x86/realmode: Make the location of the trampoline configurable
  x86/hyperv/vtl: Setup the 64-bit trampoline for TDX guests
  x86/hyperv/vtl: Mark the wakeup mailbox page as private

 .../reserved-memory/intel,wakeup-mailbox.yaml |  87 +++++++++++
 .../devicetree/bindings/x86/cpus.yaml         |  80 ++++++++++
 arch/x86/hyperv/hv_vtl.c                      |  35 ++++-
 arch/x86/include/asm/smp.h                    |   6 +
 arch/x86/include/asm/x86_init.h               |   3 +
 arch/x86/kernel/acpi/madt_wakeup.c            |  75 +---------
 arch/x86/kernel/devicetree.c                  | 141 +++++++++++++++++-
 arch/x86/kernel/smpboot.c                     |  83 +++++++++++
 arch/x86/kernel/x86_init.c                    |   3 +
 arch/x86/realmode/init.c                      |   7 +-
 10 files changed, 440 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
 create mode 100644 Documentation/devicetree/bindings/x86/cpus.yaml

-- 
2.43.0


