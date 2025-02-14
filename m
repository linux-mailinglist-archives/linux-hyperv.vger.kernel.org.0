Return-Path: <linux-hyperv+bounces-3948-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961BA3575A
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 07:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88763188FAF0
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 06:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD1202C4C;
	Fri, 14 Feb 2025 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MOPji41f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93A41FFC47;
	Fri, 14 Feb 2025 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515444; cv=none; b=PMa8SJU8QA6NNRYED5717QsIOnNGKiGFptuNRHaukWTmD/NP3oM5mvO4hOcdh+TWjE4c5dY7A7HYFURZUTKmu+F791HC4b4ErBeidrH8SyocV6mrEce5sk7GZPpnL4S/6H755o6g3SxNCylVJ/aG5gzn325+nztGAZqo10F2GIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515444; c=relaxed/simple;
	bh=0cjSIPXFWqVN+M0LfJRbfI3PrOSgHIWdBdEKzP3i4hw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QOoUJWqDclrQMToJcY7CXqcHircU9phyU/Pj1zUEQ/RhVGj4bb4Z6+iFuPWx++hydGAwRn3TmfEC46Z5gG9SMsp5nlecGnjZykE6RDUtzJQiUX1sYTzrOBcvoxIsj8IvjtyviQAJxqJJwA8MelmekT/uQhZPIO52Gt+gZyrbn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MOPji41f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 829FA203F3CB;
	Thu, 13 Feb 2025 22:43:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 829FA203F3CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739515442;
	bh=hd7FmfHbp/1gCUQKWw0IWSh8XDTrp007vlfiuUk9J2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=MOPji41fcVdAAYSzNXNkYiF4SBpJmmBNFNedKxICOSYQ4qgrl/Cunv8+haos3aI3V
	 tq0OG8vkQ2m5K/6N27N4XSXXBiB2aYyXMIHSdP7ShEqWio8bhWc3kRBYPUZllIc9tR
	 mOnNYSoj6PMdzPseOxYCvNQB2nj3MLl89AlrzXA0=
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
	Naman Jain <namjain@linux.microsoft.com>
Subject: [RFC PATCH] uio_hv_generic: Fix sysfs creation path for ring buffer
Date: Fri, 14 Feb 2025 12:13:51 +0530
Message-Id: <20250214064351.8994-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On regular bootup, devices get registered to vmbus first, so when
uio_hv_generic driver for a particular device type is probed,
the device is already initialized and added, so sysfs creation in
uio_hv_generic probe works fine. However, when device is removed
and brought back, the channel rescinds and again gets registered
to vmbus. However this time, the uio_hv_generic driver is already
registered to probe for that device and in this case sysfs creation
is tried before the device gets initialized completely. Fix this by
deferring sysfs creation till device gets initialized completely.

Problem path:
vmbus_device_register
    device_register
        uio_hv_generic probe
		    sysfs_create_bin_file (fails here)
	kset_create_and_add (dependency)
	vmbus_add_channel_kobj (dependency)

Fixes: 9ab877a6ccf8 ("uio_hv_generic: make ring buffer attribute for primary channel")
Cc: stable@kernel.org
Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---

DPDK use-case depend on this sysfs node so to maintain backward compatibility and not break
DPDK, we could not remove sysfs logic from uio_hv_generic probe.
https://github.com/DPDK/dpdk/blob/main/drivers/bus/vmbus/linux/vmbus_uio.c#L360

Tried reordering functions in vmbus_device_register and also finding alternate functions
for device initialization, but could not find any other viable solution.
Explored the use of ATTRIBUTE_GROUPS and DEVICE_ATTR_RW but with that, I could create sysfs
node for a particular device but not for the channel for that device, as we need to.

From previous discussions, I could see sysfs creation in driver probe is not encouraged,
and we are now adding more complexity to it, so I am not sure if this is the best way to
solve the problem. Hence sharing this as RFC to gather some review comments.

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
[   35.574358]  ret_from_fork+0x39/0x60
[   35.574362]  ? __pfx_kthread+0x10/0x10
[   35.574364]  ret_from_fork_asm+0x1a/0x30
[   35.574368]  </TASK>
[   35.574385] ---[ end trace 0000000000000000 ]---
[   35.574388] uio_hv_generic eb765408-105f-49b6-b4aa-c123b64d17d4: sysfs create ring bin file failed; -22

Thanks.
---
 drivers/hv/vmbus_drv.c       |  7 +++++++
 drivers/uio/uio_hv_generic.c | 33 ++++++++++++++++++++++++++++-----
 include/linux/hyperv.h       |  4 ++++
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0f6cd44fff29..16f7d7f2d7fd 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -835,6 +835,7 @@ static int vmbus_probe(struct device *child_device)
 	struct hv_device *dev = device_to_hv_device(child_device);
 	const struct hv_vmbus_device_id *dev_id;
 
+	dev->device_registered = false;
 	dev_id = hv_vmbus_get_id(drv, dev);
 	if (drv->probe) {
 		ret = drv->probe(dev, dev_id);
@@ -1927,6 +1928,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
 	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
 
+	init_waitqueue_head(&child_device_obj->wait_event);
 	/*
 	 * Register with the LDM. This will kick off the driver/device
 	 * binding...which will eventually call vmbus_match() and vmbus_probe()
@@ -1951,6 +1953,11 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 		pr_err("Unable to register primary channeln");
 		goto err_kset_unregister;
 	}
+
+	/* channel kobj allocated, now inform anyone waiting for it */
+	child_device_obj->device_registered = true;
+	wake_up_interruptible(&child_device_obj->wait_event);
+
 	hv_debug_add_dev_dir(child_device_obj);
 
 	return 0;
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 1b19b5647495..99d6ecaa8f86 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -63,6 +63,8 @@ struct hv_uio_private_data {
 	void	*send_buf;
 	struct vmbus_gpadl send_gpadl;
 	char	send_name[32];
+
+	struct work_struct sysfs_work;
 };
 
 /*
@@ -243,6 +245,29 @@ hv_uio_release(struct uio_info *info, struct inode *inode)
 	return ret;
 }
 
+static void hv_uio_sysfs_work(struct work_struct *work)
+{
+	struct hv_uio_private_data *pdata =
+		container_of(work, struct hv_uio_private_data, sysfs_work);
+	struct vmbus_channel *channel = pdata->device->channel;
+	int ret;
+
+	ret = pdata->device->channels_kset ||
+		wait_event_interruptible_timeout(pdata->device->wait_event,
+						 pdata->device->device_registered,
+						 msecs_to_jiffies(5));
+	if (!ret) {
+		dev_warn(&pdata->device->device,
+			 "kset taking too long to initialize; %d\n", ret);
+		return;
+	}
+
+	ret = sysfs_create_bin_file(&channel->kobj, &ring_buffer_bin_attr);
+	if (ret)
+		dev_notice(&pdata->device->device,
+			   "sysfs create ring bin file failed; %d\n", ret);
+}
+
 static int
 hv_uio_probe(struct hv_device *dev,
 	     const struct hv_vmbus_device_id *dev_id)
@@ -349,11 +374,8 @@ hv_uio_probe(struct hv_device *dev,
 		dev_err(&dev->device, "hv_uio register failed\n");
 		goto fail_close;
 	}
-
-	ret = sysfs_create_bin_file(&channel->kobj, &ring_buffer_bin_attr);
-	if (ret)
-		dev_notice(&dev->device,
-			   "sysfs create ring bin file failed; %d\n", ret);
+	INIT_WORK(&pdata->sysfs_work, hv_uio_sysfs_work);
+	schedule_work(&pdata->sysfs_work);
 
 	hv_set_drvdata(dev, pdata);
 
@@ -376,6 +398,7 @@ hv_uio_remove(struct hv_device *dev)
 		return;
 
 	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
+	cancel_work_sync(&pdata->sysfs_work);
 	uio_unregister_device(&pdata->info);
 	hv_uio_cleanup(dev, pdata);
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 4179add2864b..6180231aff8d 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1302,6 +1302,10 @@ struct hv_device {
 	u16 vendor_id;
 	u16 device_id;
 
+	/* check for device registration completion */
+	bool			device_registered;
+	wait_queue_head_t	wait_event;
+
 	struct device device;
 	/*
 	 * Driver name to force a match.  Do not set directly, because core

base-commit: 00f3246adeeacbda0bd0b303604e46eb59c32e6e
-- 
2.34.1


