Return-Path: <linux-hyperv+bounces-4715-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D332A74358
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Mar 2025 06:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5A1178FA0
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Mar 2025 05:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC81DDC15;
	Fri, 28 Mar 2025 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IHxKW8M3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138B028373;
	Fri, 28 Mar 2025 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743139677; cv=none; b=EWr+pEBWU43CTdsJITfI9sAWNJ6AxZ5/b5ZWbXOLgZuMXFl6uEA4wSgnFQrYy1stH2UnU+NJCdH/Tvkkijogk5FrIgh5KjksJk6uSYqjPp+T4VLmLxTAxwjEf51IIzWkmTBmh6jBtGzYSstsi5MPZ9q3DTWl7xhq2dIY+jBXMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743139677; c=relaxed/simple;
	bh=WBme0HkyRRbDQ8Leq+Bd79QqsRz7MTEZD4uciGXbfQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Czirl+cxcjfuhUcCqMPeF3/E6SLLSxvJVdMZ6xRF732IV/TtooPNmzDsCrRi36z1psjMhS/PFdA2LCw22N8VTPQDuKnnOTbYlkMUS3C3MS9eJmIqjz7/hL51u6XxsxIiHdSy5sYLSgXZG3Q2LyBtL2OSdZCQoqD8Pm4T+/B3QP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IHxKW8M3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 789272025649;
	Thu, 27 Mar 2025 22:27:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 789272025649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743139674;
	bh=/2fyyVl7aEx5o80jahY1lO4oF3T0nV2EB9vhYbdzV0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=IHxKW8M3Q3RXYtVWRK5U/MJj/grBs37XoNfaVJalUddmFYUsW37RPPD4AsCLjf6J5
	 MBnHzeeQCk0UYmtC0SQTIws3aOd6VjcEDPC8RRriYegT1GpIsfyGhvSoJ43rzdogHf
	 W8z4wZkOA9j7Lte/3NLjaAQthJy7vNmChE06/M0M=
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
Subject: [PATCH v3 0/2] uio_hv_generic: Fix ring buffer sysfs creation path
Date: Fri, 28 Mar 2025 10:57:43 +0530
Message-Id: <20250328052745.1417-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
PFB change logs:

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

Regards,
Naman

Naman Jain (2):
  uio_hv_generic: Fix sysfs creation path for ring buffer
  Drivers: hv: Make the sysfs node size for the ring buffer dynamic

 drivers/hv/hyperv_vmbus.h    |   6 ++
 drivers/hv/vmbus_drv.c       | 119 ++++++++++++++++++++++++++++++++++-
 drivers/uio/uio_hv_generic.c |  33 ++++------
 include/linux/hyperv.h       |   6 ++
 4 files changed, 143 insertions(+), 21 deletions(-)


base-commit: db8da9da41bced445077925f8a886c776a47440c
-- 
2.34.1


