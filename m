Return-Path: <linux-hyperv+bounces-6799-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BDDB50394
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 19:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C937B7A19
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CFC3705BC;
	Tue,  9 Sep 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RMD74kV8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951436CE19;
	Tue,  9 Sep 2025 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437051; cv=none; b=HUHRvpNEqmsO3LdHgIiuuChrp42SEANoSvylVvU++BzQCX7dYL942rM9jiwkQxA+T0J2dLuxju7z4/fKoCaOtrxfRsp2zZGMObc0mhlte+0o0y4TRE5SNBQPpyAavp65mxLcQ7vsjazYu5ABJHmGPkoWIaV3FwBsXLwQRNLoZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437051; c=relaxed/simple;
	bh=HVmUZ+Kf9fN2pSWhKRRh4CN/CjjrHWPGz82cE6IRqns=;
	h=From:To:Subject:Date:Message-Id; b=BmKa7fIn/BLcn+wKYx6pb5+/CQ+lh5BOYDbgUHnLKF3n4PLy/rfjNgf0blAEbqbrNNJruwlRrdkMEy07u61LL1wMyvDvM+MtdwSYju6sObnCB0l4XOz06nFEojMAgesjFqbKKwyrhQVfDWSXpp13vh+Fs0h88B1EqaAyjcysQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RMD74kV8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E2D7F2119CB4;
	Tue,  9 Sep 2025 09:57:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2D7F2119CB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757437048;
	bh=lme8K4Nr1+yoqaz7H6lvUNp0A2O6Va0RIFe2JGydUTE=;
	h=From:To:Subject:Date:From;
	b=RMD74kV8g9ic+OtmzX19t+LcdSJGDKWM+owfdL/97U9Rv2f17n/HsuVdRDK6OM4OG
	 hfscUIZphxW4NztwU18/7Y96smpq2BtQ86ZSLWuhmyIQt8XLwnqjGi7QvFo4hNSD1J
	 ipB3HSpms4C9ET8HhqVHPDC1oXI2wBW+8h4LwogU=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	drawat.floss@gmail.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	deller@gmx.de,
	arnd@arndb.de,
	soci@c64.rulez.org,
	rdunlap@infradead.org,
	gonzalo.silvalde@gmail.com,
	bartosz.golaszewski@linaro.org,
	mhklinux@outlook.com,
	ssengar@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [RFC 0/3] fbdev: remove Hyper-V framebuffer driver
Date: Tue,  9 Sep 2025 09:57:24 -0700
Message-Id: <1757437044-2170-1-git-send-email-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This series removes the Hyper-V framebuffer driver. The Hyper-V DRM
driver is available since kernel version 5.14 and provides full KMS
support along with fbdev emulation via the DRM fbdev helpers. This makes
the hyperv_fb driver redundant. So remove hyperv_fb driver.

Prasanna Kumar T S M (3):
  drivers: video: fbdev: Remove hyperv_fb driver
  drm: hyprev: Remove reference to hyperv_fb driver
  drivers: hv: vmbus_drv: Remove reference to hpyerv_fb

 MAINTAINERS                               |    1 -
 drivers/gpu/drm/Kconfig                   |    3 +-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c |   15 +-
 drivers/hv/vmbus_drv.c                    |    4 +-
 drivers/video/fbdev/Kconfig               |    8 -
 drivers/video/fbdev/Makefile              |    1 -
 drivers/video/fbdev/hyperv_fb.c           | 1386 ---------------------
 7 files changed, 8 insertions(+), 1410 deletions(-)
 delete mode 100644 drivers/video/fbdev/hyperv_fb.c

--
2.49.0


