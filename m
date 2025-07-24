Return-Path: <linux-hyperv+bounces-6373-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B1B10378
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 10:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252F817D3CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E692749FE;
	Thu, 24 Jul 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SyIDkjl5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C63274666;
	Thu, 24 Jul 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345559; cv=none; b=j3Zf58jv9fXGtCfnLFS65sIVihv63Sc8/2E1b94TwkRYJxe2DAahiPEaOjZ4QcdW0cuXCh9E2cy1oZaIVy3/9F+bKh8ivt5q7cFHJ1ecnH1iV0dlf/HuFuwPMGkqfuuSqdxVtyXfVvz88vCVXUE7Y23umLUCrWQhLaUs1aZb3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345559; c=relaxed/simple;
	bh=2UzttSm57GVFbz5gMdon/tnPeByrj0jcTAcnKiXlKE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qnjA2NGq8STzv6/xgU9q8W7vL41+e4W5qaVeqqIKngHraf4GsBE7QW6dlPse0uch70+J/DIh7pcm6XydwkEZHo3/hI9WLAhZ59GlWXkAsqNVpEyhmY8tln1YBp0gVR6P3eWLUVFig2bhezFB6Rf2mg6FCKPk9KvvvWPdkZ9rNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SyIDkjl5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 94303201BA36;
	Thu, 24 Jul 2025 01:25:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94303201BA36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753345557;
	bh=vgNLNKNb8ShhARg/IkJlxqgeJhKmPyZ9zPD5CzpLHQ8=;
	h=From:To:Cc:Subject:Date:From;
	b=SyIDkjl5CehIZsS4yIyAx4DmpMTGWYJAOgltuvv/b/QwRJ5FjCbVpOJkjBG9OzdSa
	 D6Q65Ey6ZgxejS1cJIGCu5W1bWz7TVnZa9wmtqkFqcjQIUdQBXv/loZFytq6tELhB7
	 UpFhi4z/uslkym5fwqK0lp5paruQkrqxYzKisxo0=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v6 0/2] Drivers: hv: Introduce new driver - mshv_vtl
Date: Thu, 24 Jul 2025 13:55:45 +0530
Message-Id: <20250724082547.195235-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
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

 drivers/hv/Kconfig          |   22 +
 drivers/hv/Makefile         |    7 +-
 drivers/hv/hv.c             |    3 +
 drivers/hv/hyperv_vmbus.h   |    1 +
 drivers/hv/mshv_vtl.h       |   52 ++
 drivers/hv/mshv_vtl_main.c  | 1508 +++++++++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c      |    4 +-
 include/hyperv/hvgdk_mini.h |  106 +++
 include/uapi/linux/mshv.h   |   80 ++
 9 files changed, 1781 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hv/mshv_vtl.h
 create mode 100644 drivers/hv/mshv_vtl_main.c


base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
-- 
2.34.1


