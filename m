Return-Path: <linux-hyperv+bounces-4923-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95595A8A474
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A207ABF45
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA0D2820C6;
	Tue, 15 Apr 2025 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oLErywXU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB1F268C79;
	Tue, 15 Apr 2025 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735501; cv=none; b=ZQ+GUwhyhR6/lrdirVgxdTaTdnL1BJF6r59Kxpu7+RzdWnxRT66Kv4j1wLx2aPQNjJ0KDOWW7VBALMbK99ZFMZublE6fbd5PkVgL80bwIzOdfNBRvuckhxDvX8nd6v4ja/0Xmkj5HmiA8weOPmQOYcnk/8AhPF9+JvSk4evxdQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735501; c=relaxed/simple;
	bh=iEpqpZXqeN2n29COgcESMtKiYRb+ps3Zxh0HHGdvXXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K49fKFoXA+PpwjPS1ePgiXymZI5n6iUbumQ9PCftCG0d1IcjhoKbTBoTEUJ4OAdXUMIaJn/Qw3aJ2uZPHgrwgmSF6c4OrZ4PcZZDSrkiUMhNYORQgWfIE09WcnIGA4ecfpSgQC/jjWsJJxoPCWgO1NuDtNMyKa8AVyQeCnj3z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oLErywXU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-RSFL4TU.corp.microsoft.com (unknown [167.220.238.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 846AB210C443;
	Tue, 15 Apr 2025 09:44:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 846AB210C443
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744735498;
	bh=ZdwTpgYVk/8H0ck90jfVtYir+V/4pY1rBPYiTpnbXUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oLErywXU/3ODVENiCfr34WkPuBZ1gx0sgwCGd0C/jQmYnCT7vIqiutxsHcXFlRADe
	 SbC6Hio30tqrBGPhhyDHIZdKIRKIadO/BIj+VxynmrW5g8XBd7xNaDNY3Fy17xMo+u
	 1YerRN1rn7UXSlg9VuFWgfutsKYbUpifZefYOEYc=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: [PATCH v5 0/2] uio_hv_generic: Fix ring buffer sysfs creation path
Date: Tue, 15 Apr 2025 22:14:50 +0530
Message-Id: <20250415164452.170239-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
This patch series aims to address the sysfs creation issue for the ring
buffer by reorganizing the code. Additionally, it updates the ring sysfs
size to accurately reflect the actual ring buffer size, rather than a
fixed static value.

PFB change logs:

Changes since v4:
https://lore.kernel.org/all/20250410060847.82407-1-namjain@linux.microsoft.com/
* Added Reviewed-By and Tested-By tags from Michael.
* Fixed syntax by removing extra space (addressed Greg's comment)
* Rebased to latest linux-next tip

Changes since v3:
https://lore.kernel.org/all/20250328052745.1417-1-namjain@linux.microsoft.com/
* Addressed Michael's comments regarding handling of return value of
sysfs_update_group in uio_hv_generic.

Changes since v2:
https://lore.kernel.org/all/20250318061558.3294-1-namjain@linux.microsoft.com/
Addressed Greg's comments:
* Split the original patch into two.
* Updated the commit message to explain the problem scenario.
* Added comments for new APIs in the kerneldoc format.
* Highlighted potential race conditions and explained why sysfs should not be created in the
  driver probe.

* Made minor changes to how the sysfs_update_group return value is handled.

Changes since v1:
https://lore.kernel.org/all/20250225052001.2225-1-namjain@linux.microsoft.com/
* Fixed race condition in setting channel->mmap_ring_buffer by
  introducing a new variable for visibility of sysfs (addressed Greg's
  comments)
* Used binary attribute fields instead of regular ones for initializing attribute_group.
* Make size of ring sysfs dynamic based on actual ring buffer's size.
* Preferred to keep mmap function in uio_hv_generic to give more control over ring's
  mmap functionality, since this is specific to uio_hv_generic driver.
* Remove spurious warning during sysfs creation in uio_hv_generic probe.
* Added comments in a couple of places.

Changes since RFC patch:
https://lore.kernel.org/all/20250214064351.8994-1-namjain@linux.microsoft.com/
* Different approach to solve the problem is proposed (credits to
  Michael Kelley).
* Core logic for sysfs creation moved out of uio_hv_generic, to VMBus
  drivers where rest of the sysfs attributes for a VMBus channel
  are defined. (addressed Greg's comments)
* Used attribute groups instead of sysfs_create* functions, and bundled
  ring attribute with other attributes for the channel sysfs.  

Error logs:

[   35.574120] ------------[ cut here ]------------
[   35.574122] WARNING: CPU: 0 PID: 10 at fs/sysfs/file.c:591 sysfs_create_bin_file+0x81/0x90
[   35.574168] Workqueue: hv_pri_chan vmbus_add_channel_work
[   35.574172] RIP: 0010:sysfs_create_bin_file+0x81/0x90
[   35.574197] Call Trace:
[   35.574199]  <TASK>
[   35.574200]  ? show_regs+0x69/0x80
[   35.574217]  ? __warn+0x8d/0x130
[   35.574220]  ? sysfs_create_bin_file+0x81/0x90
[   35.574222]  ? report_bug+0x182/0x190
[   35.574225]  ? handle_bug+0x5b/0x90
[   35.574244]  ? exc_invalid_op+0x19/0x70
[   35.574247]  ? asm_exc_invalid_op+0x1b/0x20
[   35.574252]  ? sysfs_create_bin_file+0x81/0x90
[   35.574255]  hv_uio_probe+0x1e7/0x410 [uio_hv_generic]
[   35.574271]  vmbus_probe+0x3b/0x90
[   35.574275]  really_probe+0xf4/0x3b0
[   35.574279]  __driver_probe_device+0x8a/0x170
[   35.574282]  driver_probe_device+0x23/0xc0
[   35.574285]  __device_attach_driver+0xb5/0x140
[   35.574288]  ? __pfx___device_attach_driver+0x10/0x10
[   35.574291]  bus_for_each_drv+0x86/0xe0
[   35.574294]  __device_attach+0xc1/0x200
[   35.574297]  device_initial_probe+0x13/0x20
[   35.574315]  bus_probe_device+0x99/0xa0
[   35.574318]  device_add+0x647/0x870
[   35.574320]  ? hrtimer_init+0x28/0x70
[   35.574323]  device_register+0x1b/0x30
[   35.574326]  vmbus_device_register+0x83/0x130
[   35.574328]  vmbus_add_channel_work+0x135/0x1a0
[   35.574331]  process_one_work+0x177/0x340
[   35.574348]  worker_thread+0x2b2/0x3c0
[   35.574350]  kthread+0xe3/0x1f0
[   35.574353]  ? __pfx_worker_thread+0x10/0x10
[   35.574356]  ? __pfx_kthread+0x10/0x10


Naman Jain (2):
  uio_hv_generic: Fix sysfs creation path for ring buffer
  Drivers: hv: Make the sysfs node size for the ring buffer dynamic

 drivers/hv/hyperv_vmbus.h    |   6 ++
 drivers/hv/vmbus_drv.c       | 119 ++++++++++++++++++++++++++++++++++-
 drivers/uio/uio_hv_generic.c |  39 +++++-------
 include/linux/hyperv.h       |   6 ++
 4 files changed, 147 insertions(+), 23 deletions(-)


base-commit: 5b37f7bfff3b1582c34be8fb23968b226db71ebd
-- 
2.34.1


