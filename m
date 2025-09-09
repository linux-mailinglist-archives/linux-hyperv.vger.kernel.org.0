Return-Path: <linux-hyperv+bounces-6800-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD7B503B8
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 19:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B264A7B8775
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7251035AAA8;
	Tue,  9 Sep 2025 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IseFGEPG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE5E36C082;
	Tue,  9 Sep 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437141; cv=none; b=sigGzqrVuO8moAXs4UWT7bzjGAv3c+5GiJVgnbMflYmWl4MueIxcz3t9F/XtE0D/Tbcz3tBSPMABSPZEOO9bTDHgqOyyuTU+OPe0NsHszeop1o6r2tzKA3YftSdieb7ekp4cpICU5GzF1qo6aj6KQM96rwuT/Qkx02Ors/c61e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437141; c=relaxed/simple;
	bh=aoJnwv02rX2ix5GIbaZjz6uT+zQeNgx0isKr+s6r3RU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=UNCI921N8GB1DONtIW0vHT3LKkh8vRuNpp++CZeYkaCscUyuXfk2xZKCkn8WYibb3yGTZHh5xX7ss057KHIxIAp1bj/d9kcBMHKZRuNjlemxS91noBe5L98oRu89rORGiKGHxigYCoDjuq3mNbtY3CD/HSIsWYLK0TfCGwLctts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IseFGEPG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 364DC211427B;
	Tue,  9 Sep 2025 09:58:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 364DC211427B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757437139;
	bh=Pv/oU1LXiNBnw2C4KJ3lYYcVnQdW+CH48yjRQgrC+L4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IseFGEPGEssiCZUsSfUqVkDwtO0KMmulp8IPNNysyZ8DCurpGQBRJzhAkkpas8MHA
	 lemlmVu6EUk6jMKQj1yxU9fVbi0xJzsMQK5OKJ7e/7r80M6fwQnaMS3jJjETAr3gxu
	 8qwnn+/6D2oLsZOkkzYA1HMwhzmbwekVtpjzkTMY=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	drawat.floss@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	ptsm@linux.microsoft.com
Subject: [RFC 2/3] drm/hyperv: Remove reference to hyperv_fb driver
Date: Tue,  9 Sep 2025 09:58:49 -0700
Message-Id: <1757437129-2612-1-git-send-email-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <E2D7F2119CB4>
References: <E2D7F2119CB4>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Remove hyperv_fb references as the driver is removed.

Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/gpu/drm/Kconfig                   |  3 +--
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 15 +++++----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f7ea8e895c0c..a39e5171f107 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -405,8 +405,7 @@ config DRM_HYPERV
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


