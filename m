Return-Path: <linux-hyperv+bounces-4043-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7640EA4387B
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Feb 2025 10:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9DE188A129
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Feb 2025 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A8261399;
	Tue, 25 Feb 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H/LYjlo3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBC261377;
	Tue, 25 Feb 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473814; cv=none; b=mUV7RpJPapZxf0oTJuf3l2OnNf6obMxolGUkpnXB7om4IvdEo05jcwvVsybU3KocWoN15h+9Q5Cp7sclZCtNzfTM1ojJxZOMYM4IWmpecXIDVH4VJnPMJrTwXxUlhhOSu35U3HpGCfWFa3g1FCMvKM8ArP4cyDMkDfscb72yQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473814; c=relaxed/simple;
	bh=xK7rR3Fb24DhYqFd+mFc5/pOSB5LTqsDJV6IARJmUmA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ku8HoBDPG7NXiymbWbZs2x7gr4VhhAc6JHci5GqCvF+dsc3nKdlR2LbhkXZmlOUem8s2S679HNKbKyvMq2fvEdM5qQoAkpldhBHAFW554zKjkrIo8lnX36X1h5O65nPTu6rZNu9dqP3d1pvfm7fHdsOM6WW1Du3IM4SXAIEt3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H/LYjlo3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id B3FFA203CDEA;
	Tue, 25 Feb 2025 00:56:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3FFA203CDEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740473812;
	bh=PpyTpXfBNfIkxMxQ2X9BAlpbRJPjk5rPH6tAPN34JZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=H/LYjlo37YspwwuSfIFx5TYbcn34YOJ7TTUrTwmJUhwFniZVVfeoWo0Tw48jiP8W5
	 +iRy0B0ZMnRzUMHHBdB/VQiZxkHPMxt9nZt/R7smA+Duhx2pB/Ed/oOoD3liIEOhZe
	 vJv2FBFC9AvMfbT1AiDBirB/esQhgXzkQGfWF3QU=
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
Subject: [PATCH v2] fbdev: hyperv_fb: Allow graceful removal of framebuffer
Date: Tue, 25 Feb 2025 00:56:48 -0800
Message-Id: <1740473808-9754-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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
V2 : Move hvfb_putmem into destroy()

 drivers/video/fbdev/hyperv_fb.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 363e4ccfcdb7..89ee49f1c3dc 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -282,6 +282,8 @@ static uint screen_depth;
 static uint screen_fb_size;
 static uint dio_fb_size; /* FB size for deferred IO */
 
+static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info);
+
 /* Send message to Hyper-V host */
 static inline int synthvid_send(struct hv_device *hdev,
 				struct synthvid_msg *msg)
@@ -862,6 +864,24 @@ static void hvfb_ops_damage_area(struct fb_info *info, u32 x, u32 y, u32 width,
 		hvfb_ondemand_refresh_throttle(par, x, y, width, height);
 }
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup related to
+ * framebuffer here.
+ */
+static void hvfb_destroy(struct fb_info *info)
+{
+	struct hv_device *hdev;
+	struct device *dev;
+	void *driver_data = (void *)info;
+
+	dev = container_of(driver_data, struct device, driver_data);
+	hdev = container_of(dev, struct hv_device, device);
+
+	hvfb_putmem(hdev, info);
+	framebuffer_release(info);
+}
+
 /*
  * TODO: GEN1 codepaths allocate from system or DMA-able memory. Fix the
  *       driver to use the _SYSMEM_ or _DMAMEM_ helpers in these cases.
@@ -877,6 +897,7 @@ static const struct fb_ops hvfb_ops = {
 	.fb_set_par = hvfb_set_par,
 	.fb_setcolreg = hvfb_setcolreg,
 	.fb_blank = hvfb_blank,
+	.fb_destroy	= hvfb_destroy,
 };
 
 /* Get options from kernel paramenter "video=" */
@@ -1172,7 +1193,7 @@ static int hvfb_probe(struct hv_device *hdev,
 	if (ret)
 		goto error;
 
-	ret = register_framebuffer(info);
+	ret = devm_register_framebuffer(&hdev->device, info);
 	if (ret) {
 		pr_err("Unable to register framebuffer\n");
 		goto error;
@@ -1220,14 +1241,9 @@ static void hvfb_remove(struct hv_device *hdev)
 
 	fb_deferred_io_cleanup(info);
 
-	unregister_framebuffer(info);
 	cancel_delayed_work_sync(&par->dwork);
 
 	vmbus_close(hdev->channel);
-	hv_set_drvdata(hdev, NULL);
-
-	hvfb_putmem(hdev, info);
-	framebuffer_release(info);
 }
 
 static int hvfb_suspend(struct hv_device *hdev)
-- 
2.43.0


