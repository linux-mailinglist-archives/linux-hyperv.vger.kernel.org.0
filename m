Return-Path: <linux-hyperv+bounces-5845-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A9AD4C8C
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 09:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2849318916DF
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0453227BA9;
	Wed, 11 Jun 2025 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eup5+bjs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A761EE7BE;
	Wed, 11 Jun 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749626832; cv=none; b=ZJ7PrixH5KVYYRaUJDacVJdb2ikbUdyptPf+BqDPSLqIRGAQYLHW1Cw39PzBODMzIT8u+sRoWdDHYtyMVynii9GXZzvm32XPQ2POKRSIYFhwSlvLO7RXuF8+yh5tewRNLUdUQBq6eHQCaGqz2Gm8KXx8U5TRwddsEXSJCMrMq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749626832; c=relaxed/simple;
	bh=eWouii4NBpFMCnLapUAuDtNvdVW/WsNucs1WRUxmYjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rk79zXDwBiTOmhXufpjgqfStENufRyVwBGogQq8dbeK/nPpHmP02Gzr4+YienGZ6KxcFvPwpFJtPIq/txmuImX+3YBUJ6Tz5aK962qOpQqG59JfCTvPJk0gWp88G9yHCxGGWMHIjrXXYUaJmCHmOGV/sxHK0w28L4gSbc7WtTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eup5+bjs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-RSFL4TU.corp.microsoft.com (unknown [167.220.238.139])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1503E2115189;
	Wed, 11 Jun 2025 00:27:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1503E2115189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749626830;
	bh=AFgpOPiPm/TLKe6dPh1oPq32+YcW78FV1eIzH81SdI4=;
	h=From:To:Cc:Subject:Date:From;
	b=eup5+bjs6Py33xbxr8GW6PxGcPAkCWd9xjIEVYyywG2+SvFPfkLc6oKxUbMDCT7GW
	 tDtaJnimiEuu8Kw0EQr1vOuaF2BQxa+OKBH5+W6epVmTWsDA2kWrupl+dEindxvpp/
	 ve8nZ2qtpwOX1lBeZcF0OmKSbyubo8jqjl7StDHw=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v5 0/2] Drivers: hv: Introduce new driver - mshv_vtl
Date: Wed, 11 Jun 2025 12:57:02 +0530
Message-Id: <20250611072704.83199-1-namjain@linux.microsoft.com>
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

 drivers/hv/Kconfig          |   23 +
 drivers/hv/Makefile         |    7 +-
 drivers/hv/hv.c             |    3 +
 drivers/hv/hyperv_vmbus.h   |    1 +
 drivers/hv/mshv_vtl.h       |   52 +
 drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c      |    4 +-
 include/hyperv/hvgdk_mini.h |   81 ++
 include/hyperv/hvhdk.h      |    1 +
 include/uapi/linux/mshv.h   |   82 ++
 10 files changed, 2035 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hv/mshv_vtl.h
 create mode 100644 drivers/hv/mshv_vtl_main.c


base-commit: 475c850a7fdd0915b856173186d5922899d65686
-- 
2.34.1


