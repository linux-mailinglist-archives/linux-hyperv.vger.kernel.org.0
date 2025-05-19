Return-Path: <linux-hyperv+bounces-5551-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C0BABB438
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 May 2025 06:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67411893A13
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 May 2025 04:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED031E8335;
	Mon, 19 May 2025 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pEeXOmPl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9957C8635E;
	Mon, 19 May 2025 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747630617; cv=none; b=o3zP3jea/dlZ42ge1De9hM4/LsxriM91p4hSl216188Ce0Be55W5eByOyzDcscxKlsd7ux23HfhXoqnwLSuz874kVqTMzPTGMbbR+m5rFkVG9rkEVo2PHWD/qOGStWIuYcbH2jBm25BOnmBRe5Ketx8vUdHHz7WHMm1Z/hndiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747630617; c=relaxed/simple;
	bh=7VNU9EVrLD6wMv3LSaTWNi5V1hDYgaurDDD7SFuYqYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z41gXGIF8KyPbkmmQ3uvd+Wr+OzM1HRdJJYEMijl/BEn6osLaf5Ph8I4ZwLCiVj47H+xLwJzq4N6Ze1lVesgQbYHny3WH4j+vfUrvoG2RmkPgOcTHUN9SrIGIoamwLgtMS3oHqSqSV3FJvNGT55jxIRHoY/Yl9lO+nWSiwB00Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pEeXOmPl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-RSFL4TU.corp.microsoft.com (unknown [167.220.238.139])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9D1CD206B757;
	Sun, 18 May 2025 21:56:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D1CD206B757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747630608;
	bh=jYzPcCwCx0ZuAkQ6LsWHdiUhP2EPWdbGyZuN42IVN3w=;
	h=From:To:Cc:Subject:Date:From;
	b=pEeXOmPl1DTWh3GofVG9Fh1iDhwA5TE6XVJ1/rzxY5iEsB2uuqhqWfTE86R22++R1
	 0t3dC6/x+8KM8GTJejk0mvhVlmXjpeOFU/KUOjGsXcTAMLUa7iWjqJgajoY5+72G+T
	 UGHJJRp/beUGvKZ3CYkPV078nxiR5DjwMtBiHgj4=
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
Subject: [PATCH v3 0/2] Drivers: hv: Introduce new driver - mshv_vtl
Date: Mon, 19 May 2025 10:26:40 +0530
Message-Id: <20250519045642.50609-1-namjain@linux.microsoft.com>
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

Changes since v2:
https://lore.kernel.org/all/20250512140432.2387503-1-namjain@linux.microsoft.com/
* Removed CONFIG_OF dependency (addressed Saurabh's comments
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

 drivers/hv/Kconfig          |   20 +
 drivers/hv/Makefile         |    7 +-
 drivers/hv/hv.c             |    2 +
 drivers/hv/hyperv_vmbus.h   |    1 +
 drivers/hv/mshv_vtl.h       |   52 +
 drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c      |    3 +-
 include/hyperv/hvgdk_mini.h |   81 ++
 include/hyperv/hvhdk.h      |    1 +
 include/uapi/linux/mshv.h   |   82 ++
 10 files changed, 2030 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hv/mshv_vtl.h
 create mode 100644 drivers/hv/mshv_vtl_main.c


base-commit: 8566fc3b96539e3235909d6bdda198e1282beaed
-- 
2.34.1


