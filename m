Return-Path: <linux-hyperv+bounces-4189-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDF0A4ACC4
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 17:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95423B66D9
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223DE1E4928;
	Sat,  1 Mar 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hadrIRIn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA6E1D90B3;
	Sat,  1 Mar 2025 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740845801; cv=none; b=DZhxPSCLTMiqZ0ZbnkiQ71drSVdqJw9BWJXZ6aNuztHXX805BiwfLwY8n/phnl+scCZIvr38KQMoXIQQdoJZvALuYRyl+ddGtq58eaKuiGA6Oe5BX6yBShD9wN6qmwpAiDG4SN8UJh49CvXMNfda1DOHEnRJTwjkELurXoDlt9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740845801; c=relaxed/simple;
	bh=ThW6x6jEbi3YwvsTGyO9W7L6HPAXyomQaT9YP7neygM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KrjkUy2w1w8OAkcYkxmQmYZRbsMyxRlXtJYWMdp67VRX2Jv7jqgr8YhbNN2PnurLuI6g5dipPCMBdp7QB79vkzCDsq6wz+vY67VpHihkOSeAfTH22DXm6I8ZuPTpxRLxuY/eGZ82RnN4OeOFECRPNogE8yAJTWzCYUIKDy/DLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hadrIRIn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1C4E72038A40;
	Sat,  1 Mar 2025 08:16:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C4E72038A40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740845799;
	bh=8gqAcMLnchdt5cB0aO9gsMnZQpWztt0YAxo1ANaGVKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hadrIRIn2gZ30Xw12Fa87w8bx4DQEfoRmfgICzUQYqP9zX4vdO9IhVDkXKnilYRBE
	 EI/B/wuXhZTdzADIPNIAb8ANnWYE5g2e2PN+eg/7JqWTTSm/yVSjmGjq7f2gZB1uUp
	 +WZ13FEXqGGxHhNjEC/t8+aKNYcLksQJAMHUcTME=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	deller@gmx.de,
	akpm@linux-foundation.org,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	mhklinux@outlook.com
Subject: [PATCH v3 2/2] fbdev: hyperv_fb: Allow graceful removal of framebuffer
Date: Sat,  1 Mar 2025 08:16:31 -0800
Message-Id: <1740845791-19977-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740845791-19977-1-git-send-email-ssengar@linux.microsoft.com>
References: <1740845791-19977-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

When a Hyper-V framebuffer device is unbind, hyperv_fb driver tries to
release the framebuffer forcefully. If this framebuffer is in use it
produce the following WARN and hence this framebuffer is never released.

[   44.111220] WARNING: CPU: 35 PID: 1882 at drivers/video/fbdev/core/fb_info.c:70 framebuffer_release+0x2c/0x40
< snip >
[   44.111289] Call Trace:
[   44.111290]  <TASK>
[   44.111291]  ? show_regs+0x6c/0x80
[   44.111295]  ? __warn+0x8d/0x150
[   44.111298]  ? framebuffer_release+0x2c/0x40
[   44.111300]  ? report_bug+0x182/0x1b0
[   44.111303]  ? handle_bug+0x6e/0xb0
[   44.111306]  ? exc_invalid_op+0x18/0x80
[   44.111308]  ? asm_exc_invalid_op+0x1b/0x20
[   44.111311]  ? framebuffer_release+0x2c/0x40
[   44.111313]  ? hvfb_remove+0x86/0xa0 [hyperv_fb]
[   44.111315]  vmbus_remove+0x24/0x40 [hv_vmbus]
[   44.111323]  device_remove+0x40/0x80
[   44.111325]  device_release_driver_internal+0x20b/0x270
[   44.111327]  ? bus_find_device+0xb3/0xf0

Fix this by moving the release of framebuffer and assosiated memory
to fb_ops.fb_destroy function, so that framebuffer framework handles
it gracefully.

While we fix this, also replace manual registrations/unregistration of
framebuffer with devm_register_framebuffer.

Fixes: 68a2d20b79b1 ("drivers/video: add Hyper-V Synthetic Video Frame Buffer Driver")

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V3]
 - using simplified hvfb_putmem()

 drivers/video/fbdev/hyperv_fb.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 09fb025477f7..76a42379c8df 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -282,6 +282,8 @@ static uint screen_depth;
 static uint screen_fb_size;
 static uint dio_fb_size; /* FB size for deferred IO */
 
+static void hvfb_putmem(struct fb_info *info);
+
 /* Send message to Hyper-V host */
 static inline int synthvid_send(struct hv_device *hdev,
 				struct synthvid_msg *msg)
@@ -862,6 +864,17 @@ static void hvfb_ops_damage_area(struct fb_info *info, u32 x, u32 y, u32 width,
 		hvfb_ondemand_refresh_throttle(par, x, y, width, height);
 }
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup related to
+ * framebuffer here.
+ */
+static void hvfb_destroy(struct fb_info *info)
+{
+	hvfb_putmem(info);
+	framebuffer_release(info);
+}
+
 /*
  * TODO: GEN1 codepaths allocate from system or DMA-able memory. Fix the
  *       driver to use the _SYSMEM_ or _DMAMEM_ helpers in these cases.
@@ -877,6 +890,7 @@ static const struct fb_ops hvfb_ops = {
 	.fb_set_par = hvfb_set_par,
 	.fb_setcolreg = hvfb_setcolreg,
 	.fb_blank = hvfb_blank,
+	.fb_destroy	= hvfb_destroy,
 };
 
 /* Get options from kernel paramenter "video=" */
@@ -1172,7 +1186,7 @@ static int hvfb_probe(struct hv_device *hdev,
 	if (ret)
 		goto error;
 
-	ret = register_framebuffer(info);
+	ret = devm_register_framebuffer(&hdev->device, info);
 	if (ret) {
 		pr_err("Unable to register framebuffer\n");
 		goto error;
@@ -1220,14 +1234,10 @@ static void hvfb_remove(struct hv_device *hdev)
 
 	fb_deferred_io_cleanup(info);
 
-	unregister_framebuffer(info);
 	cancel_delayed_work_sync(&par->dwork);
 
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
-
-	hvfb_putmem(info);
-	framebuffer_release(info);
 }
 
 static int hvfb_suspend(struct hv_device *hdev)
-- 
2.43.0


