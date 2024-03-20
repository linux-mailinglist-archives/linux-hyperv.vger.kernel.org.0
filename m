Return-Path: <linux-hyperv+bounces-1795-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBC880FDE
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8905E1F21547
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B7F42067;
	Wed, 20 Mar 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dsv+Xf4p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC313D961;
	Wed, 20 Mar 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930591; cv=none; b=rRiZUzbZNAOJg0+0lW5rkaEFqGPfB4dl+39y1Vq6PoUOcReBeTgcIKWJlrDHI7w3yx996h8qFw2xIoXFJA5/PweOIoOWBrIYtVbC+zFFwt2veTnygMr/EJC5V16eQ5xmCqaKZdQh1ITdbL0umEfCh0iT7sLn7tt+0gpYTATvOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930591; c=relaxed/simple;
	bh=geAsHSgeoAGhC8U08DTF8rjrCr2+aPCGWcsh9myfgNc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TPUfICOT1/2W5hqxFKJ9N46TmizDDlFjuZ0D4WJ6G8Ub1PcgKOUpay97baRZ7nmE2CRkPXYOfMXirTAC9CVjUlVHZpP5hKklgcZ42WQBjZsCXhW9TqMiGIYAYPoGt9RTXGy6koQQeNDdgHvkTZOeB0cmVlVQ73hDaNfzkG3/Z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dsv+Xf4p; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id EB0ED20B74C0;
	Wed, 20 Mar 2024 03:29:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB0ED20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710930588;
	bh=1+6DqdSL8zTYy13g+Zh/YVDiL5MLBwy/pU0R6IovjBU=;
	h=From:To:Cc:Subject:Date:From;
	b=Dsv+Xf4pkeaucoCXAC4tzMtQuTxroWZt/sWPJvKnrM6U6ty7kLrkhheX5uMeiT7zR
	 CiGsAX02rA34y8j6HK8l1Lv7Ct1v3ycR9XaAj6cMaOrVIAl4VMW6q0WAA7gF6gggfD
	 yBX+k4v2VTlc6Mnb5EUR9PYn1JUIgzB5ZEI1BepM=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: longli@microsoft.com,
	ssengar@microsoft.com
Subject: [PATCH v2 0/7] Low speed Hyper-V devices support
Date: Wed, 20 Mar 2024 03:29:37 -0700
Message-Id: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Hyper-V is adding multiple low speed "speciality" synthetic devices.
Instead of writing a new kernel-level VMBus driver for each device,
make the devices accessible to user space through UIO-based
uio_hv_generic driver. Each device can then be supported by a user
space driver. This approach optimizes the development process and
provides flexibility to user space applications to control the key
interactions with the VMBus ring buffer.

The new synthetic devices are low speed devices that don't support
VMBus monitor bits, and so they must use vmbus_setevent() to notify
the host of ring buffer updates. These new devices also have smaller
ring buffer sizes which requires to add support for variable ring buffer
sizes.

Moreover, this patch series adds a new implementation of the fcopy
application that uses the new UIO driver. The older fcopy driver and
application will be phased out gradually. Development of other similar
userspace drivers is still underway.

Efforts have been made previously to implement this solution earlier.
Here are the discussions related to those attempts:
Attempt 1: Upgrade uio_hv_generic to cater to Underhill slow devices. But this was rejected due
to use of module parameters.
https://lore.kernel.org/lkml/1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com/

Attempt 2: Enable interrupt for low speed VMBus devices in uio_hv_generic and was rejected due to
unavailability of userspace driver for it.
https://lore.kernel.org/lkml/Y05bdCWBs0miLjOu@kroah.com/

Attempt 3: Wrote a new UIO driver but was rejected due to its complexity.
https://lore.kernel.org/lkml/1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com/


[V2]
- Went through internal review, got few reviewed-by from Long Li.
- Added more details in cover letter for previous attempts.
- Added more details in commit messages.
- Added comments for preferred ring sizes and there values.
- Removed need_sign arg from vmbus_txbr_write
- Change (4 * 4096) to 0x4000 for ring buffer size.
- Removed some unnecessary type casting.
- Removed rte_smp_rwmb as its duplicate of rte_compiler_barrier.
- Added more comment for rte_compiler_barrierx.
- Mentioned in file copyright header that this code is copied.
- Changed the print from "Registration failed" to "Signal to host failed".
- Fixed mask for rx buffer interrupt to 0 before waiting for interrupt.

Saurabh Sengar (7):
  Drivers: hv: vmbus: Add utility function for querying ring size
  uio_hv_generic: Query the ringbuffer size for device
  uio_hv_generic: Enable interrupt for low speed VMBus devices
  tools: hv: Add vmbus_bufring
  tools: hv: Add new fcopy application based on uio driver
  Drivers: hv: Remove fcopy driver
  uio_hv_generic: Remove use of PAGE_SIZE

 drivers/hv/Makefile            |   2 +-
 drivers/hv/channel_mgmt.c      |  15 +-
 drivers/hv/hv_fcopy.c          | 427 ----------------------------
 drivers/hv/hv_util.c           |  12 -
 drivers/hv/hyperv_vmbus.h      |   5 +
 drivers/uio/uio_hv_generic.c   |  19 +-
 include/linux/hyperv.h         |   2 +
 tools/hv/Build                 |   3 +-
 tools/hv/Makefile              |  10 +-
 tools/hv/hv_fcopy_daemon.c     | 266 ------------------
 tools/hv/hv_fcopy_uio_daemon.c | 490 +++++++++++++++++++++++++++++++++
 tools/hv/vmbus_bufring.c       | 318 +++++++++++++++++++++
 tools/hv/vmbus_bufring.h       | 158 +++++++++++
 13 files changed, 1002 insertions(+), 725 deletions(-)
 delete mode 100644 drivers/hv/hv_fcopy.c
 delete mode 100644 tools/hv/hv_fcopy_daemon.c
 create mode 100644 tools/hv/hv_fcopy_uio_daemon.c
 create mode 100644 tools/hv/vmbus_bufring.c
 create mode 100644 tools/hv/vmbus_bufring.h

-- 
2.34.1


