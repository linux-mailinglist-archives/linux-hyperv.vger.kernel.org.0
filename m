Return-Path: <linux-hyperv+bounces-6910-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D462B7FE2B
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED011C85126
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC212D3758;
	Wed, 17 Sep 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aurBuFcB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460E623D7F4;
	Wed, 17 Sep 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117792; cv=none; b=u8A+dUHOP3McmpncqPmTSum9F+WGq4Z1pd6msENavGh2w+wUZrnMHBck3ENkPLo/2/j9BCbLwSKlWFYlRLwaoWDM/LUbwa0/0FlL06v6aUrV6KQemXsOSrhhJC8bLnQ3O3NozZgb4CNxcH+L6//wfzD3X++J1SHF7zcrH2IPRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117792; c=relaxed/simple;
	bh=9Z4lilKpTTrW31r8mRXcW6FoQHOiRapMsHIU5lpj1ZE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=SEC5a7uP6wDqVV4Zi793Z4gdTosCi0ZzbJ4gQNgCyI4PkGlMnMi4tTopKAcgcJqls/bj1mgPFU936xl0bDe+dcVT3LX5/NY8iDW7T5LGI3UrfzPYwpoeFKRsqRoDjN5s/BbrRIvkAkOYlB9p1hKHv81CY8NNNNDwjROJ1XpdyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aurBuFcB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90A592018E7D;
	Wed, 17 Sep 2025 07:03:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90A592018E7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758117790;
	bh=R0iXWeZ0yvccNH0jWPajLtukW7dSkCEEiXwfJnLS9oY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aurBuFcBsGMr5E6fG2nGZOE2PDW0RcbGIO2P3NWxMpIt+zbX4eJjDYrS6KJTs/6+C
	 7qQExQF2rRIHmUFAoNKdNrCeRefhkh/iKBs3NZ150UThI5IZMRtykly/cwYeNJMd+G
	 8BDRNrU/sy85br8YEYArd+d+jglp8JB53iieG7IQ=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com,
	mhklinux@outlook.com,
	ptsm@linux.microsoft.com,
	rdunlap@infradead.org,
	bartosz.golaszewski@linaro.org,
	gonzalo.silvalde@gmail.com,
	arnd@arndb.de,
	tzimmermann@suse.de,
	decui@microsoft.com,
	wei.liu@kernel.org,
	deller@gmx.de,
	kys@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 1/2] fbdev/hyperv_fb: deprecate this in favor of Hyper-V DRM driver
Date: Wed, 17 Sep 2025 07:03:05 -0700
Message-Id: <1758117785-20653-1-git-send-email-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <E5C2A201B1BD>
References: <E5C2A201B1BD>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The Hyper-V DRM driver is available since kernel version 5.14 and it
provides full KMS support and fbdev emulation via the DRM fbdev helpers.
Deprecate this driver in favor of Hyper-V DRM driver.

Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/video/fbdev/Kconfig     | 5 ++++-
 drivers/video/fbdev/hyperv_fb.c | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index c21484d15f0c..48c1c7417f6d 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1773,13 +1773,16 @@ config FB_BROADSHEET
 	  a bridge adapter.
 
 config FB_HYPERV
-	tristate "Microsoft Hyper-V Synthetic Video support"
+	tristate "Microsoft Hyper-V Synthetic Video support (DEPRECATED)"
 	depends on FB && HYPERV
 	select DMA_CMA if HAVE_DMA_CONTIGUOUS && CMA
 	select FB_IOMEM_HELPERS_DEFERRED
 	help
 	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
 
+	  This driver is deprecated, please use the Hyper-V DRM driver at
+	  drivers/gpu/drm/hyperv (CONFIG_DRM_HYPERV) instead.
+
 config FB_SIMPLE
 	tristate "Simple framebuffer support"
 	depends on FB
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 75338ffc703f..c99e2ea4b3de 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1357,6 +1357,8 @@ static int __init hvfb_drv_init(void)
 {
 	int ret;
 
+	pr_warn("Deprecated: use Hyper-V DRM driver instead\n");
+
 	if (fb_modesetting_disabled("hyper_fb"))
 		return -ENODEV;
 
-- 
2.49.0


