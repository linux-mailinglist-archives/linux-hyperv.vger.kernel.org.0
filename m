Return-Path: <linux-hyperv+bounces-6911-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11ADB7FE0D
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 16:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682CF6281C8
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602512D73B6;
	Wed, 17 Sep 2025 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PEB67Qwu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CC22D6418;
	Wed, 17 Sep 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117815; cv=none; b=IHDZP9qsMBgoNIrhGuDNATYktxHP5JiwE47P3oQopjjR754ENUbXpLfeaer7udn7xVBsczsEBOoq9bfdZk5h0flkbOr+rdz4BaB4QtXIdQ4hjYN4bsU53qXFYUXi980m78XhCziVPy34w7Brl2kDR8ZotKxQQubZgslW2ikKn5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117815; c=relaxed/simple;
	bh=u0wbcF6OGthgQeSflKBB4VyNlmLDy7R8VPtmoSJtoPE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=SuUm76NOPGbdgJeS3LCxGERvsPpx0++ffDMoGB0EOXjolRdKFcreswrfdxUL99FMvV3tNLL7H5m+bj2ukhJWNW0s6SjKAKRpPX89QAKHht8TXG2vjjRqhnXUjnc0GYidVZ/7K9ItOsUGcK3G5VOEmw/+9hVmz3WEGMnV+0ybr6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PEB67Qwu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C86B2018E7D;
	Wed, 17 Sep 2025 07:03:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C86B2018E7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758117808;
	bh=+S/7jRUtEY2oOKEMYyruSC0TCMCRVkdm3aSdtS0WsSs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PEB67Qwuwpz0mYUXQ58kC1t65Lb10hInkPI2Q4FQplvf/KGN6Uafghd+vLV8gonCY
	 gbekvyiCdKwfA9EDO4b0dTssrf4iIG5zjsobXdf9fxappCTJjld0gKlTbnz3nK6PdJ
	 W+VzhmmAdfB+Lqv917oNQnr0pst2I2jjhHy1Bdjo=
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
Subject: [PATCH 2/2] MAINTAINERS: Mark hyperv_fb driver Obsolete
Date: Wed, 17 Sep 2025 07:03:24 -0700
Message-Id: <1758117804-20798-1-git-send-email-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <E5C2A201B1BD>
References: <E5C2A201B1BD>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The hyperv_fb driver is deprecated in favor of Hyper-V DRM driver. Split
the hyperv_fb entry from the hyperv drivers list, mark it obsolete.

Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 MAINTAINERS | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6206963efbf..aa9d0fa6020b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11424,7 +11424,6 @@ F:	drivers/pci/controller/pci-hyperv-intf.c
 F:	drivers/pci/controller/pci-hyperv.c
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
-F:	drivers/video/fbdev/hyperv_fb.c
 F:	include/asm-generic/mshyperv.h
 F:	include/clocksource/hyperv_timer.h
 F:	include/hyperv/hvgdk.h
@@ -11438,6 +11437,16 @@ F:	include/uapi/linux/hyperv.h
 F:	net/vmw_vsock/hyperv_transport.c
 F:	tools/hv/
 
+HYPER-V FRAMEBUFFER DRIVER
+M:	"K. Y. Srinivasan" <kys@microsoft.com>
+M:	Haiyang Zhang <haiyangz@microsoft.com>
+M:	Wei Liu <wei.liu@kernel.org>
+M:	Dexuan Cui <decui@microsoft.com>
+L:	linux-hyperv@vger.kernel.org
+S:	Obsolete
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
+F:	drivers/video/fbdev/hyperv_fb.c
+
 HYPERBUS SUPPORT
 M:	Vignesh Raghavendra <vigneshr@ti.com>
 R:	Tudor Ambarus <tudor.ambarus@linaro.org>
-- 
2.49.0


