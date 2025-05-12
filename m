Return-Path: <linux-hyperv+bounces-5468-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBF4AB39FB
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 16:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B1419E0383
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3C11E260C;
	Mon, 12 May 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lE5pbyLD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF631DF72C;
	Mon, 12 May 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058680; cv=none; b=Tdr+pWX4Ft0rF44F49ZRdsxLcXyd+vW2quJ8qnHbuRSs6Tnz/gz3TcUBdeJEmw8mD+iybhOYxriveYsiD6ucXAwAe7Smg0GIHFkLqr8zQZ8ATMk+7K/jdOnrnuPh5XW4liawpKwNrFKEOjM1VzjZiDXJxhwL7TabJvPzAkINJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058680; c=relaxed/simple;
	bh=NI+SAgGRP2h+D/Hrzl6N9NDpENQvxz2VHaSHfMPrZFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nTpbs+MrVwxF/+3t6loG/JitUexJtCGGZfIvPDvvgBRw7WIY1MhDg3Q6oKWUmqooU2Pu3ji9sJ1bIJ9F4K1eMHoguLGc2jr5LAVG2qE8cOJe2+6JISk6rcUWyB+V2w1uKKzKkx8nJ80E+3KD4MQ5yOtqh7M9LNt7KnMMFLeTU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lE5pbyLD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-RSFL4TU.corp.microsoft.com (unknown [167.220.238.139])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1F186211D8D1;
	Mon, 12 May 2025 07:04:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F186211D8D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747058678;
	bh=Ae2T/qTf75NVPbtzWkNGMvWzJ6fqDy6p9tR5bc3aNAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lE5pbyLDYQuRBs6HWNPvl+axF3+5pExI8e+2aT3XgDysvvBv9nYX36kF4/X8tB1IR
	 VX49Bk8Ws/YmaJ/0l82/e8MKaPMgqqa1wRS4Pd3quBBiWCgOg8phOEGRegN72v7rvU
	 XwqfCIG0TvxfPHr0iy9Cp/uKCMbXMrbHZlRvyPOE=
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
Subject: [PATCH v2 0/2] Drivers: hv: Introduce new driver - mshv_vtl
Date: Mon, 12 May 2025 19:34:30 +0530
Message-Id: <20250512140432.2387503-1-namjain@linux.microsoft.com>
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

Changes since v1:
https://lore.kernel.org/all/20250506084937.624680-1-namjain@linux.microsoft.com/
Addressed Saurabh's comments:
* Split the patch in 2 to keep export symbols separate
* Make MSHV_VTL module tristate and fixed compilation warning that would come when HYPERV is compiled as a module.
* Remove the use of ref_count
* Split functionality of mshv_vtl_ioctl_get_set_regs to different functions mshv_vtl_ioctl_(get|set)_regs as it actually make things simpler
* Fixed use of copy_from_user in atomic context in mshv_vtl_hvcall_call. Added ToDo comment for info.
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

 drivers/hv/Kconfig          |   21 +
 drivers/hv/Makefile         |    7 +-
 drivers/hv/hv.c             |    2 +
 drivers/hv/hyperv_vmbus.h   |    1 +
 drivers/hv/mshv_vtl.h       |   52 +
 drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c      |    3 +-
 include/hyperv/hvgdk_mini.h |   81 ++
 include/hyperv/hvhdk.h      |    1 +
 include/uapi/linux/mshv.h   |   82 ++
 10 files changed, 2031 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hv/mshv_vtl.h
 create mode 100644 drivers/hv/mshv_vtl_main.c


base-commit: ed61cb3d78d585209ec775933078e268544fe9a4
-- 
2.34.1


