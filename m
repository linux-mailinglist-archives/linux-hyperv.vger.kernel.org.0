Return-Path: <linux-hyperv+bounces-8086-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8A4CDF43C
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Dec 2025 05:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA5930057FB
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Dec 2025 04:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB519E968;
	Sat, 27 Dec 2025 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ov3p6SNM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F4189F20;
	Sat, 27 Dec 2025 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766809909; cv=none; b=hYRw7uz/v6PLOVU1VUjGNfNMZIDl3gpYU/VeN0PX2yCDoR+enezHZ2bLqLaLiuQFbGLxgGA20+erO4Bmow9hL6VuMBAYjvIzgksr4+f4xXM2wlxbeGR9kFwM+x6AxfN2159NWunnVJTKbVlcetEj4HXK+0jk/0b9O5H1bINTv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766809909; c=relaxed/simple;
	bh=V7cC50v6/XkIj1G5qZUWvHIelciUfwVt7KWXGu4qctk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qRAIPrq2pIFemet9bzxzkEBTOnY5DibSU02p0A3AlDFvQtxBcDCKnZABrufcyOx45mmDJH+TILcs9YYd6eAnFRA7Ky1I1CRFAXXIUJ8GGIfJuSHqahiYYMTwcKsqrJ4Sf4dUEFPrHlEp3EmZ9QojA4P6rXczxnaQHjL1JZeUj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ov3p6SNM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D227B21244C0;
	Fri, 26 Dec 2025 20:31:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D227B21244C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1766809906;
	bh=nAryqAjlxZ51ntKq8w3T+63nHBfKHSvkDBHjt9RQKlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ov3p6SNMayn6kmpNQPi3LK9poaEPTXs+Ubu+C4fO9UaLW7JIAZXb1Q5PzDpuBkDLg
	 zbw9J3Ft1bw/IWwxbvAy7JJdcFT819sfEcsqn1GcrHG7DODAF3vkiHqAz2AzEh4mBc
	 aZNrqnMjtgFCvzEyNA4FdZaq7qURHdJtlaRU8iHQ=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: ptsm@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	drawat.floss@gmail.com,
	tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	simona@ffwll.ch,
	airlied@gmail.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com
Subject: [PATCH 3/3] drm/hyprev: Remove reference to hyperv_fb driver
Date: Fri, 26 Dec 2025 20:31:46 -0800
Message-Id: <1766809906-26535-1-git-send-email-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1766809486-24731-1-git-send-email-ptsm@linux.microsoft.com>
References: <1766809486-24731-1-git-send-email-ptsm@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Remove hyperv_fb reference as the driver is removed.

Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/gpu/drm/Kconfig                   |  3 +--
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 15 +++++----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 7e6bc0b3a589..01a1438b35a0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -407,8 +407,7 @@ config DRM_HYPERV
 	help
 	 This is a KMS driver for Hyper-V synthetic video device. Choose this
 	 option if you would like to enable drm driver for Hyper-V virtual
-	 machine. Unselect Hyper-V framebuffer driver (CONFIG_FB_HYPERV) so
-	 that DRM driver is used by default.
+	 machine.
 
 	 If M is selected the module will be called hyperv_drm.
 
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 013a7829182d..051ecc526832 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2021 Microsoft
- *
- * Portions of this code is derived from hyperv_fb.c
  */
 
 #include <linux/hyperv.h>
@@ -304,16 +302,13 @@ int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
  * but the Hyper-V host still draws a point as an extra mouse pointer,
  * which is unwanted, especially when Xorg is running.
  *
- * The hyperv_fb driver uses synthvid_send_ptr() to hide the unwanted
- * pointer, by setting msg.ptr_pos.is_visible = 1 and setting the
- * msg.ptr_shape.data. Note: setting msg.ptr_pos.is_visible to 0 doesn't
+ * Hide the unwanted pointer, by setting msg.ptr_pos.is_visible = 1 and setting
+ * the msg.ptr_shape.data. Note: setting msg.ptr_pos.is_visible to 0 doesn't
  * work in tests.
  *
- * Copy synthvid_send_ptr() to hyperv_drm and rename it to
- * hyperv_hide_hw_ptr(). Note: hyperv_hide_hw_ptr() is also called in the
- * handler of the SYNTHVID_FEATURE_CHANGE event, otherwise the host still
- * draws an extra unwanted mouse pointer after the VM Connection window is
- * closed and reopened.
+ * The hyperv_hide_hw_ptr() is also called in the handler of the
+ * SYNTHVID_FEATURE_CHANGE event, otherwise the host still draws an extra
+ * unwanted mouse pointer after the VM Connection window is closed and reopened.
  */
 int hyperv_hide_hw_ptr(struct hv_device *hdev)
 {
-- 
2.49.0


