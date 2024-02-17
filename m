Return-Path: <linux-hyperv+bounces-1555-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAB485916D
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 19:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4B1C20CC5
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416E37E0F2;
	Sat, 17 Feb 2024 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BQtdT+8h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8057D414;
	Sat, 17 Feb 2024 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193075; cv=none; b=Mh9jnz/sVc532wUz2FNOsptzhb3XQSmA3pnfv17FfqKYL6ffv9CQmCKigqANyE36CjUqmNErRYG95Y0maZ4SO2NSWJXnbjBZea7zufieKJNuJ80aU0pHh1zQdRTHG/Xji9EskChar+kxh4m4QX6AKhbbyxphUUWdbh40PThkTjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193075; c=relaxed/simple;
	bh=fklp+eyYWX9Fo/GEKVCDaXngLiUmi5JBAtthR4Q1kP4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JhHoghN7uksaqB9/IsC+r2rQ0Kx9HqwnF0eSWXI0kKMB8bROpHJBbw3qjlCPr/LKr8tdRKjw/lJY5Y1INyoyWXtI/1HRGeXw5lYBXJvNwK1dCsqHmio+67P8oVH5z5lndN6avSRm8O+eYwGvMRCrvkWOe3lK6Od7arz9prl2xP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BQtdT+8h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 536BC207FD29;
	Sat, 17 Feb 2024 10:04:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 536BC207FD29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708193067;
	bh=/mwh7BUNN6hVP+Q7Cbl+W954u6dPawCLv2iDZVI1u+I=;
	h=From:To:Cc:Subject:Date:From;
	b=BQtdT+8hwyc6VxrbOrCRcE/lUMlBDTjDF7Abn3UHikJxOmR1mmDmYnFs7stVAYvoV
	 u0NTTGhsgSI/Ql7s2fB23QFTI8PoiKKW2wBm7OJ/67Yu4gE1c/iRMgqyCr2u5jcA9Z
	 SzCn5hqzpVSgXiHMHYug+ACisQ+uV3dzfGJgx6Vc=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH 0/6] Low speed Hyper-V devices support
Date: Sat, 17 Feb 2024 10:03:34 -0800
Message-Id: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
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
https://lore.kernel.org/lkml/1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com/
https://lore.kernel.org/lkml/1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com/
https://lore.kernel.org/lkml/1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com/

Saurabh Sengar (6):
  Drivers: hv: vmbus: Add utility function for querying ring size
  uio_hv_generic: Query the ringbuffer size for device
  uio_hv_generic: Enable interrupt for low speed VMBus devices
  tools: hv: Add vmbus_bufring
  tools: hv: Add new fcopy application based on uio driver
  Drivers: hv: Remove fcopy driver

 drivers/hv/Makefile            |   2 +-
 drivers/hv/channel_mgmt.c      |   7 +-
 drivers/hv/hv_fcopy.c          | 427 -----------------------------
 drivers/hv/hv_util.c           |  12 -
 drivers/hv/hyperv_vmbus.h      |   5 +
 drivers/uio/uio_hv_generic.c   |  14 +-
 include/linux/hyperv.h         |   1 +
 tools/hv/Build                 |   3 +-
 tools/hv/Makefile              |  10 +-
 tools/hv/hv_fcopy_daemon.c     | 266 ------------------
 tools/hv/hv_fcopy_uio_daemon.c | 488 +++++++++++++++++++++++++++++++++
 tools/hv/vmbus_bufring.c       | 316 +++++++++++++++++++++
 tools/hv/vmbus_bufring.h       | 158 +++++++++++
 13 files changed, 988 insertions(+), 721 deletions(-)
 delete mode 100644 drivers/hv/hv_fcopy.c
 delete mode 100644 tools/hv/hv_fcopy_daemon.c
 create mode 100644 tools/hv/hv_fcopy_uio_daemon.c
 create mode 100644 tools/hv/vmbus_bufring.c
 create mode 100644 tools/hv/vmbus_bufring.h

-- 
2.34.1


