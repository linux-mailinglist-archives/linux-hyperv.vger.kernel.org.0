Return-Path: <linux-hyperv+bounces-9137-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPhBNmrDqGk0xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9137-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:42:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5F8209044
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3441F304EAB1
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A676375F93;
	Wed,  4 Mar 2026 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RG170y/+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED41F4C8C;
	Wed,  4 Mar 2026 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667751; cv=none; b=L5cwsAgDjFBtXQsP2d2hCwUxJsBu4QHrCpBVUceq3FQunr/58YOFB1te0SHyCdhFnFb3jcfJcZhN3SrrdZuoU6EmfYx5B50wdJv6KZcybl6Jdb9yfbqn/lkt+/clC2zFqYwOsTTPbEj5ZJ/Zk4yppWrVaMgaR/eZCmnGwHA1nCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667751; c=relaxed/simple;
	bh=ED4e55hsxtWpBvsYR4WOPikeT4OEN2h24PkF2/4I8NY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K/VxYPdVW94xuERXf8pv0gqkOmaY/K3c6uvdr5FKrnXTWSE2fcw3MdTGyNdkO5D+ih42hl1z3KozC3xHo0of4rZQnkIZhfTYK13SzvHB8QaHKXQ2AfATHh7kAqvz+PU4lsC1jSQAFFP+HyUn9D/vqIE1mGBadUp6C1fQsHLtwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RG170y/+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667750; x=1804203750;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ED4e55hsxtWpBvsYR4WOPikeT4OEN2h24PkF2/4I8NY=;
  b=RG170y/+1XKqAiqm7J6crLbI3dY7kQvG67IHlKev9HIdcIN15bDVn28I
   Mf1l9K8N5kZfDNoMZ1i0NCDH2AiGnCnjkNTflSos6CSCJNGA0C5kFsDAh
   N7Qg3mxz10KWAOFZZc42nEGGP3wlF8kQQy7ZSU7+kWMuhobCbvifhgubL
   0tb/HRSHzvisHFGaaBa3a3RoBI7ChWDx1Hm6EDuw3xfn1VvY583hXyeR0
   x3fYslThdduEVkov4XMKvLvdwK3+H7aeQ8z067RAE/Jmkx6yndHjz+Pwq
   0eMECFAjqgCcWzVCv0nGC3X6ScHl0RtNmJ2Oj7iUb9hd2KkB48RgTj2f7
   A==;
X-CSE-ConnectionGUID: vmRbopLIT8W0qixXeh/5Gg==
X-CSE-MsgGUID: S4hEfxs0TM+P1jPs8xfZcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359355"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359355"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:29 -0800
X-CSE-ConnectionGUID: Ty6GDMhyT0qHhqii3xAtJw==
X-CSE-MsgGUID: DwRbFlrmQnKT5FTTh05NSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376889"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:28 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v9 00/10] x86/hyperv/hv_vtl: Use a wakeup mailbox to boot
 secondary CPUs
Date: Wed, 04 Mar 2026 15:41:11 -0800
Message-Id: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjDqGkC/3XPTW7DIBAF4KtErIsFg/lxV71H1QVgqFEdiLDju
 op892JLaSrF3s1bzDdvbmhwObgBvZ5uKLspDCHFEpqXE7Kdjp8Oh7ZkBAQ4EQRwjmUBf+svd73
 gsw69STNmoJx3EhRhHpXVS3Y+zBv7/lGyz+mMxy47/cA4YbShnPIKalJTTHEOVuc2VdsFq/vW5
 RTf+hCvcxXi6PrKpvPKd2EYU/7ZSk/1euTej+33m2pMcMsZAwlGAoMndW058X8UyAOKr5TntTS
 0pY1w+5T4oyih4oAShSq/M+5Nwwg/oOSDovSolVwprYwCbaQFu0+pOyUIJUeUKhR4boRU3Jfhm
 VqW5RcCFYlROQIAAA==
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
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=8711;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=ED4e55hsxtWpBvsYR4WOPikeT4OEN2h24PkF2/4I8NY=;
 b=6euaeUYwkl9UIVm6JaZwSWQ08soJFbs0+xWUP76gdt02XmNg6+nooxWQZKjqbx62cjomIzCzu
 j5sK8SymL9TBSn4i/iBNi+CtTDC/OyVrtLej9HVOBg/z+wyrgGVNW0b
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: 1B5F8209044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9137-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvmm.dev:url,intel.com:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi x86 maintainers,

This is a new version of this patchset. The only change since the last
version is a fix for a warning from `make dt_binding_check`. Since v7, I
incorporated feedback from Boris. Also, the ACPI, DeviceTree and Hyper-V
maintainers have reviewed the patches. Any chance it could be merged?

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

Changes in v9:
- Fixed a warning from `make dt_binding_check` reported by Rob's bot.
- Link to v8: https://lore.kernel.org/r/20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com

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

 .../reserved-memory/intel,wakeup-mailbox.yaml      | 49 ++++++++++++++++++++++
 arch/x86/hyperv/hv_vtl.c                           | 38 +++++++++++++++--
 arch/x86/include/asm/acpi.h                        | 16 +++++++
 arch/x86/include/asm/topology.h                    |  3 ++
 arch/x86/include/asm/x86_init.h                    |  3 ++
 arch/x86/kernel/acpi/madt_wakeup.c                 | 16 +++++++
 arch/x86/kernel/devicetree.c                       | 47 +++++++++++++++++++++
 arch/x86/kernel/x86_init.c                         |  3 ++
 arch/x86/realmode/init.c                           |  7 ++--
 9 files changed, 174 insertions(+), 8 deletions(-)
---
base-commit: 18a93ea5e0ae3e3e6918a6efc6a1d60a37be47b2
change-id: 20250602-rneri-wakeup-mailbox-328efe72803f

Best regards,
-- 
Ricardo Neri <ricardo.neri-calderon@linux.intel.com>


