Return-Path: <linux-hyperv+bounces-7243-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66A4BE6FCE
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 09:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6A45E5FB8
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1318E1EDA26;
	Fri, 17 Oct 2025 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R9CKc/ZC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F89922DFA4;
	Fri, 17 Oct 2025 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687145; cv=none; b=tEieLgWIaUd8WKml13cAJuZqPouiP9oezDBU4PEaedBFixq17JPavS7SE1qWZUYOsXxuixxKwnbVjY261kouZn7WYn4Fh91YewVFgFs3Anr0g8jK9oMkry9NOZmvOHvHJ3JAhZLttSGi0+FrZVDlelpz3W5J3KJsFlUPZjuJxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687145; c=relaxed/simple;
	bh=HFITFOJjTYXQZfvjeunEMgcI61xEj//dFWWXRV7Knfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcDwi+XmX9WNEVuMJDO0+CTllmmO7uCIYy4HlKp0YpSKMpL3SvBb7HxSR9zVI2IraKmAjFRKapjTB2DMTGKC6UoDIOQwDZ2jBi1JkfS+9jM2nQJYc2oa1/tysBoY5FE0kLfKDiSRmWt4YM36se/8I81UQlbM33XliYWgpo+dHRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R9CKc/ZC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-1AYIP.redmond.corp.microsoft.com (unknown [4.213.232.40])
	by linux.microsoft.com (Postfix) with ESMTPSA id BEC5B201724C;
	Fri, 17 Oct 2025 00:45:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BEC5B201724C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760687136;
	bh=44+EUmrFQ/qhBVKQwxImHXyBUOoddaXSVwRpO0l6hFg=;
	h=From:To:Cc:Subject:Date:From;
	b=R9CKc/ZCjtpUlJtLckOIHvuzVEuLoIFr+g/9t+HX2YouD2CsaRjvc+x1VTxdYz1Zd
	 qYhGXcpMght1YJISK8vYms6W5sRmUkk9MTjgrcPjM7K2GGdA+j/a4bpUuNkD7e1ZzO
	 lo5dlmE3icHgXQ49ncbRTySInPXl/a8sYnudTV/s=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [PATCH v9 0/2] Drivers: hv: Introduce new driver - mshv_vtl
Date: Fri, 17 Oct 2025 07:45:05 +0000
Message-ID: <20251017074507.142704-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new mshv_vtl driver to provide an interface for Virtual
Machine Monitor like OpenVMM and its use as OpenHCL paravisor to
control VTL0 (Virtual trust Level).
Expose devices and support IOCTLs for features like VTL creation,
VTL0 memory management, context switch, making hypercalls,
mapping VTL0 address space to VTL2 userspace, getting new VMBus
messages and channel events in VTL2 etc.

OpenVMM : https://openvmm.dev/guide/

Changes since v8:
https://lore.kernel.org/all/20251013060353.67326-1-namjain@linux.microsoft.com/
Addressed Sean's comments:
* Removed forcing SIGPENDING, and other minor changes, in
  mshv_vtl_ioctl_return_to_lower_vtl after referring
  to Sean's earlier changes for xfer_to_guest_mode_handle_work.

* Rebased and resolved merge conflicts, compilation errors on latest
  linux-next kernel tip, after Roman's Confidential VM changes,
  which merged recently. No functional changes.
  https://lore.kernel.org/all/20251008233419.20372-1-romank@linux.microsoft.com/

Changes since v7:
https://lore.kernel.org/all/20250729051436.190703-1-namjain@linux.microsoft.com/
Addressed Peter's concerns. Thanks Peter, Paolo, Sean for valuable inputs.
Discussion- https://lore.kernel.org/all/20250825055208.238729-1-namjain@linux.microsoft.com/
* moved assembly code to arch/x86/
  * This prevents the need to export hv_hypercall_pg
  * Will make it easier to add support for other architectures in the future
* moved assembly code to a separate .S file (arch/x86/hyperv/mshv_vtl_asm.S)
* Used noinstr for this new function in .S file
* Fixed save/restore logic of callee registers, rbp to fix previous objtool warning
* used static call instead of indirect call
* used asm offsets similar to KVM code in assembly file (arch/x86/hyperv/mshv-asm-offsets.c)
* Removed the usage of STACK_FRAME_NON_STANDARD.

Other changes-
* Changed logic to use xfer_to_guest_mode_handle_work and VIRT_XFER_TO_GUEST_WORK
  after recently merged changes.
* Removed Reviewed-by Tags after recent changes.

Changes since v6:
https://lore.kernel.org/all/20250724082547.195235-1-namjain@linux.microsoft.com/
Addressed Michael's comments:
* Corrected MAX_BITMAP_SIZE size - finally
* Added missing __packed to hv_synic_overlay_page_msr
* Fixed typo in comment, added CPU hotplug info in comments
* Reverted to mutex_lock/unlock in mshv_vtl_ioctl_set_poll_file
* Unified mshv_vtl_set_reg and mshv_vtl_get_reg
* Dynamic to static allocation of reg in mshv_vtl_ioctl_(get|set)_regs
* Fixed error handling in mshv_vtl_sint_ioctl_signal_event()

Changes since v5:
https://lore.kernel.org/all/20250611072704.83199-1-namjain@linux.microsoft.com/
Addressed Michael Kelley's suggestions:
* Added "depends on HYPERV_VTL_MODE", removed "depends on HYPERV" in Kconfig
* Removed unused macro MAX_GUEST_MEM_SIZE
* Made macro dependency explicit: MSHV_PG_OFF_CPU_MASK and MSHV_REAL_OFF_SHIFT
* Refactored and corrected how allow_bitmap is used and defined. Removed PAGE_SIZE dependency.
* Added __packed for structure definitions wherever it was missing.
* Moved hv_register_vsm_* union definitions to hvgdk_mini.h, kept mshv_synic_overlay_page_msr
  in the driver, renamed it and added a comment. (Nuno)
* Introduced global variables input_vtl_zero and input_vtl_normal and used them everywhere these
  were defined locally
* s/"page_to_phys(reg_page) >> HV_HYP_PAGE_SHIFT"/"page_to_hvpfn(reg_page)" in
  mshv_vtl_configure_reg_page
* Refactored mshv_vtl_vmbus_isr() to reduce complexity in finding and resetting bits similar to
  how vmbus_chan_sched is implemented.
* Used __get_free_page() instead in mshv_vtl_alloc_context()
* Added fallback hv_setup_vmbus_handler(vmbus_isr) in hv_vtl_setup_synic() and in
  hv_vtl_remove_synic().
* Maintained symmetry of functions in hv_vtl_remove_synic
* Added a note for explanation of excluding last PFN in the range provided in
  mshv_vtl_ioctl_add_vtl0_mem()
* Added comments for hotplug being not supported, wherever cpu_online() was used to check if CPU
  is online or not.
* Added a check for input.cpu to make sure it's less than nr_cpu_ids in
  mshv_vtl_ioctl_set_poll_file()
* Removed switch-case and implemented static tables in mshv_vtl_(get|set)_reg for reducing LOC
* Simplified mshv_vtl_ioctl_(get|set)_regs to process one register at a time, and fixed earlier
  bug with array of registers processing.
* Used hv_result_to_errno() in mshv_vtl_sint_ioctl_signal_event()
* Added a READ_ONCE() while reading old_eventfd in mshv_vtl_sint_ioctl_set_eventfd()
* Renamed mshv_vtl_hvcall and mshv_vtl_hvcall_setup to remove ambiguity
* Took care of latest mm patches regarding PFN_DEV, pfn_t deprecation
* Few other minor changes while reorganizing code.

Addressed Markus Elfring's suggestions:
* Used guard(mutex) for better mutex handling.


Changes since v4:
https://lore.kernel.org/all/20250610052435.1660967-1-namjain@linux.microsoft.com/
* Fixed warnings from kernel test robot for missing export.h when the
  kernel is compiled with W=1 option.
  Some recent changes in kernel flags these warnings and that's why it
  was not seen in previous runs. Warnings in other Hyper-V drivers
  will be fixed separately.
* No functional changes

Changes since v3:
https://lore.kernel.org/all/20250519045642.50609-1-namjain@linux.microsoft.com/
Addressed Stanislav's, Nuno's comments.
* Change data types for different variables, excluding the ones in uapi headers
* Added comment for the need of HUGEPAGES config in Kconfig.
* generalized new IOCTL names by removing VTL in their name.

* Rebased and added Saurabh's Reviewed-by tag

Changes since v2:
https://lore.kernel.org/all/20250512140432.2387503-1-namjain@linux.microsoft.com/
* Removed CONFIG_OF dependency (addressed Saurabh's comments)
* Fixed typo in "allow_map_intialized" variable name

Changes since v1:
https://lore.kernel.org/all/20250506084937.624680-1-namjain@linux.microsoft.com/
Addressed Saurabh's comments:
* Split the patch in 2 to keep export symbols separate
* Make MSHV_VTL module tristate and fixed compilation warning that would come when HYPERV is
  compiled as a module.
* Remove the use of ref_count
* Split functionality of mshv_vtl_ioctl_get_set_regs to different functions
  mshv_vtl_ioctl_(get|set)_regs as it actually make things simpler
* Fixed use of copy_from_user in atomic context in mshv_vtl_hvcall_call.
  Added ToDo comment for info.
* Added extra code to free memory for vtl in error scenarios in mshv_ioctl_create_vtl()

Addressed Alok's comments regarding:
* Additional conditional checks
* corrected typo in HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB case
* empty lines before return statement
* Added/edited comments, variable names, structure field names as suggested to improve
  documentation - no functional change here.

Naman Jain (2):
  Drivers: hv: Export some symbols for mshv_vtl
  Drivers: hv: Introduce mshv_vtl driver

 arch/x86/hyperv/Makefile           |   10 +-
 arch/x86/hyperv/hv_vtl.c           |   37 +
 arch/x86/hyperv/mshv-asm-offsets.c |   37 +
 arch/x86/hyperv/mshv_vtl_asm.S     |   95 ++
 arch/x86/include/asm/mshyperv.h    |   32 +
 drivers/hv/Kconfig                 |   26 +-
 drivers/hv/Makefile                |    7 +-
 drivers/hv/hv.c                    |    3 +
 drivers/hv/hyperv_vmbus.h          |    1 +
 drivers/hv/mshv_vtl.h              |   25 +
 drivers/hv/mshv_vtl_main.c         | 1392 ++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c             |    4 +-
 include/hyperv/hvgdk_mini.h        |  106 +++
 include/uapi/linux/mshv.h          |   80 ++
 14 files changed, 1851 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/hyperv/mshv-asm-offsets.c
 create mode 100644 arch/x86/hyperv/mshv_vtl_asm.S
 create mode 100644 drivers/hv/mshv_vtl.h
 create mode 100644 drivers/hv/mshv_vtl_main.c


base-commit: 1fdbb3ff1233e204e26f9f6821ae9c125a055229
-- 
2.43.0


