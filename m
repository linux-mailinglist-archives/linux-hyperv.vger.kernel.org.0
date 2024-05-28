Return-Path: <linux-hyperv+bounces-2224-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA78D179B
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 11:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CA41F230F9
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D90167271;
	Tue, 28 May 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZgkR5Ls"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366217E8F4;
	Tue, 28 May 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890136; cv=none; b=FfOggH2zBz5T1rE3sf1FoPpt4xDpLHVotrTTSjYacIM3HKLma2xq1wIGwXJ3E3fp87XuZ08L9RrYFxGUXzOk6K9l+lAGXlR8gBObAA32Whp5tJX1bXoZSG5ICp3ee6fEG0z1+bj7bzAwsyk3ZtmFiquEG7RcsuWZI9X/1WXM5oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890136; c=relaxed/simple;
	bh=huXOPXxBBmooXDv7Jaxf8rN49Ys2JGANH6aq7ipaCDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+Mm4yTnO+duLH/ZG/QeeL97wNsX3e1/eFgX4nqZkqJsSJF0RWijUVL/DzC3JCTAkicB9BDJ/LAckNXMkIr5Z7n4Yd911y8Q+LaU+THV0tA1w32oL65CGQRR9G0BAyx5vaDN/Q48d6L+43EmXZvKqgl8iDFZW75vIBvWla/to+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZgkR5Ls; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716890134; x=1748426134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=huXOPXxBBmooXDv7Jaxf8rN49Ys2JGANH6aq7ipaCDU=;
  b=dZgkR5LsoW4UMrmwMwAJiNNCAKmGciq+S4hqjVX+man4qoGYnm0fSOBq
   c54wKQxP91I7tRivJmKQRkmXAT1C2Joe6RNeQbKLOW7xWSBNVL6XOZbGy
   RUMU4xYOF2odoCkFXTfsOdQBkQngMYhOz4smuUzFXJqUjuZdIB30ABvZ5
   M5qQnZSllpdNvxhb7Io7qkVYViM5iaGnXFfqzzTBFqRNCIrtsySt33F1g
   jUK/ndu3qTKwyIJ5fssbdSSaiuvR43nHrpGfmG+oZi0vUGe8f0XDZzeW5
   +igImcjra35A/RZ1cbuMTFV4NXwggNjlmGhYIntp1xFuuqquhsULxTjQ0
   w==;
X-CSE-ConnectionGUID: boZZbx1+S7e4Wii/0waItw==
X-CSE-MsgGUID: G6V+P9otSFi/c+GgUjJctQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13097631"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13097631"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:55:33 -0700
X-CSE-ConnectionGUID: QeQ88LlTQHmXZBOwKDT1KQ==
X-CSE-MsgGUID: 3F9Oadd5Q4+gAgq9uE9iNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34951647"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 02:55:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 26228184; Tue, 28 May 2024 12:55:25 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHv11 00/19] x86/tdx: Add kexec support
Date: Tue, 28 May 2024 12:55:03 +0300
Message-ID: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset adds bits and pieces to get kexec (and crashkernel) work on
TDX guest.

The last patch implements CPU offlining according to the approved ACPI
spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
kernel. It requires BIOS-side enabling. If it missing we fallback to booting
2nd kernel with single CPU.

Please review. I would be glad for any feedback.

[1] https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher

v11:
  - Rebased onto current tip/master;
  - Rename CONFIG_X86_ACPI_MADT_WAKEUP to CONFIG_ACPI_MADT_WAKEUP;
  - Drop CC_ATTR_GUEST_MEM_ENCRYPT checks around x86_platform.guest.enc_kexec_*
    callbacks;
  - Rename x86_platform.guest.enc_kexec_* callbacks;
  - Report error code in case of vmm call fail in __set_memory_enc_pgtable();
  - Update commit messages and comments;
  - Add Reviewed-bys;
v10:
  - Rebased to current tip/master;
  - Preserve CR4.MCE instead of setting it unconditionally;
  - Fix build error in Hyper-V code after rebase;
  - Include Ashish's patch for real;
v9:
  - Rebased;
  - Keep page tables that maps E820_TYPE_ACPI (Ashish);
  - Ack/Reviewed/Tested-bys from Sathya, Kai, Tao;
  - Minor printk() message adjustments;
v8:
  - Rework serialization of around conversion memory back to private;
  - Print ACPI_MADT_TYPE_MULTIPROC_WAKEUP in acpi_table_print_madt_entry();
  - Drop debugfs interface to dump info on shared memory;
  - Adjust comments and commit messages;
  - Reviewed-bys by Baoquan, Dave and Thomas;
v7:
  - Call enc_kexec_stop_conversion() and enc_kexec_unshare_mem() after shutting
    down IO-APIC, lapic and hpet. It meets AMD requirements.
  - Minor style changes;
  - Add Acked/Reviewed-bys;
v6:
  - Rebased to v6.8-rc1;
  - Provide default noop callbacks from .enc_kexec_stop_conversion and
    .enc_kexec_unshare_mem;
  - Split off patch that introduces .enc_kexec_* callbacks;
  - asm_acpi_mp_play_dead(): program CR3 directly from RSI, no MOV to RAX
    required;
  - Restructure how smp_ops.stop_this_cpu() hooked up in crash_nmi_callback();
  - kvmclock patch got merged via KVM tree;
v5:
  - Rename smp_ops.crash_play_dead to smp_ops.stop_this_cpu and use it in
    stop_this_cpu();
  - Split off enc_kexec_stop_conversion() from enc_kexec_unshare_mem();
  - Introduce kernel_ident_mapping_free();
  - Add explicit include for alternatives and stringify.
  - Add barrier() after setting conversion_allowed to false;
  - Mark cpu_hotplug_offline_disabled __ro_after_init;
  - Print error if failed to hand over CPU to BIOS;
  - Update comments and commit messages;
v4:
  - Fix build for !KEXEC_CORE;
  - Cleaner ATLERNATIVE use;
  - Update commit messages and comments;
  - Add Reviewed-bys;
v3:
  - Rework acpi_mp_crash_stop_other_cpus() to avoid invoking hotplug state
    machine;
  - Free page tables if reset vector setup failed;
  - Change asm_acpi_mp_play_dead() to pass reset vector and PGD as arguments;
  - Mark acpi_mp_* variables as static and __ro_after_init;
  - Use u32 for apicid;
  - Disable CPU offlining if reset vector setup failed;
  - Rename madt.S -> madt_playdead.S;
  - Mark tdx_kexec_unshare_mem() as static;
  - Rebase onto up-to-date tip/master;
  - Whitespace fixes;
  - Reorder patches;
  - Add Reviewed-bys;
  - Update comments and commit messages;
v2:
  - Rework how unsharing hook ups into kexec codepath;
  - Rework kvmclock_disable() fix based on Sean's;
  - s/cpu_hotplug_not_supported()/cpu_hotplug_disable_offlining()/;
  - use play_dead_common() to implement acpi_mp_play_dead();
  - cond_resched() in tdx_shared_memory_show();
  - s/target kernel/second kernel/;
  - Update commit messages and comments;

Ashish Kalra (1):
  x86/mm: Do not zap page table entries mapping unaccepted memory table
    during kdump.

Borislav Petkov (1):
  x86/relocate_kernel: Use named labels for less confusion

Kirill A. Shutemov (17):
  x86/acpi: Extract ACPI MADT wakeup code into a separate file
  x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
  cpu/hotplug: Add support for declaring CPU offlining not supported
  cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
  x86/kexec: Keep CR4.MCE set during kexec for TDX guest
  x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
  x86/mm: Return correct level from lookup_address() if pte is none
  x86/tdx: Account shared memory
  x86/mm: Add callbacks to prepare encrypted memory for kexec
  x86/tdx: Convert shared memory back to private on kexec
  x86/mm: Make e820__end_ram_pfn() cover E820_TYPE_ACPI ranges
  x86/acpi: Rename fields in acpi_madt_multiproc_wakeup structure
  x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
  x86/smp: Add smp_ops.stop_this_cpu() callback
  x86/mm: Introduce kernel_ident_mapping_free()
  x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method
  ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed

 arch/x86/Kconfig                     |   7 +
 arch/x86/coco/core.c                 |   1 -
 arch/x86/coco/tdx/tdx.c              |  96 ++++++++-
 arch/x86/hyperv/ivm.c                |  22 +-
 arch/x86/include/asm/acpi.h          |   7 +
 arch/x86/include/asm/init.h          |   3 +
 arch/x86/include/asm/pgtable.h       |   5 +
 arch/x86/include/asm/pgtable_types.h |   1 +
 arch/x86/include/asm/set_memory.h    |   3 +
 arch/x86/include/asm/smp.h           |   1 +
 arch/x86/include/asm/x86_init.h      |  13 +-
 arch/x86/kernel/acpi/Makefile        |   1 +
 arch/x86/kernel/acpi/boot.c          |  86 +-------
 arch/x86/kernel/acpi/madt_playdead.S |  28 +++
 arch/x86/kernel/acpi/madt_wakeup.c   | 292 +++++++++++++++++++++++++++
 arch/x86/kernel/crash.c              |  12 ++
 arch/x86/kernel/e820.c               |   9 +-
 arch/x86/kernel/process.c            |   7 +
 arch/x86/kernel/reboot.c             |  18 ++
 arch/x86/kernel/relocate_kernel_64.S |  25 ++-
 arch/x86/kernel/x86_init.c           |   8 +-
 arch/x86/mm/ident_map.c              |  73 +++++++
 arch/x86/mm/init_64.c                |  16 +-
 arch/x86/mm/mem_encrypt_amd.c        |   8 +-
 arch/x86/mm/pat/set_memory.c         |  74 +++++--
 drivers/acpi/tables.c                |  14 ++
 include/acpi/actbl2.h                |  19 +-
 include/linux/cc_platform.h          |  10 -
 include/linux/cpu.h                  |   2 +
 kernel/cpu.c                         |  12 +-
 30 files changed, 707 insertions(+), 166 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/madt_playdead.S
 create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

-- 
2.43.0


