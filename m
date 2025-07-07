Return-Path: <linux-hyperv+bounces-6124-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D52EAFAEEE
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 10:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070AB1888F28
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36F28A70D;
	Mon,  7 Jul 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IvUGnz3t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2C1C5D7D;
	Mon,  7 Jul 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878291; cv=none; b=MZZaHYKwmKYG++gGSokcJccsJkmn8ok176jy4WArY0J+Y9uMu3OgU/inwfrYe68t04P12rnaW7r41DHdqJNbdwpw/fST+xt4P94pdToZt/60fdCLP4fZEQfitqUXDSOMN7vY/t3qTnIjqbmZoUrICmcLOqCnJmUwiQB0exnJCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878291; c=relaxed/simple;
	bh=xyXSjUac5AGCu2QSk4UshgnsvQfLhCvPryWR7LixtPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VqOfwF4HxSDCvlmmMv1yRlkhe0dyujas/VenTQaiRWMm8uyoGvcVZ7lpDoqIsGSXV+879qUPEGBXANoqpKtmjFtaQ6iEOPX9HPkeZtCsJcPZ7GzhQ9lPJRqJS4jGsn28yV8udHIsEFCOBViRZjDi94jZux7sqA4lnXmtOw2jEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IvUGnz3t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.46])
	by linux.microsoft.com (Postfix) with ESMTPSA id C5632211159A;
	Mon,  7 Jul 2025 01:43:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5632211159A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751877811;
	bh=IzZxjdEKdUzEmCBBclWYxqtPmDvV/k2c6OKLkjo+vRU=;
	h=From:To:Cc:Subject:Date:From;
	b=IvUGnz3t3Y0x8uLWeFSC+jA8vYApPVKomRvcYkSTFIzpp5dQq12KESKd5CL3NJVkx
	 jBvaF72SOGq5YbF+FCtQo6JToz3V5TMFHJVY1bWBn68czDBV1tTH9ML4F+rL2a0gPu
	 PZAiLKOdB7813nsGixFM0bDnhiITwh2bAGOtHPQo=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Roman Kisel <romank@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	namjain@microsoft.com
Subject: [PATCH] Drivers: hv: Fix the check for HYPERVISOR_CALLBACK_VECTOR
Date: Mon,  7 Jul 2025 14:13:22 +0530
Message-Id: <20250707084322.1763-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__is_defined(HYPERVISOR_CALLBACK_VECTOR) would return 1, only if
HYPERVISOR_CALLBACK_VECTOR macro is defined as 1. However its value is
0xf3 and this leads to __is_defined() returning 0. The expectation
was to just check whether this MACRO is defined or not and get 1 if
it's defined. Replace __is_defined with #ifdef blocks instead to
fix it.

Fixes: 1dc5df133b98 ("Drivers: hv: vmbus: Get the IRQ number from DeviceTree")
Cc: stable@kernel.org
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 33b524b4eb5e..2ed5a1e89d69 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2509,7 +2509,7 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 	return 0;
 }
 #endif
-
+#ifndef HYPERVISOR_CALLBACK_VECTOR
 static int vmbus_set_irq(struct platform_device *pdev)
 {
 	struct irq_data *data;
@@ -2534,6 +2534,7 @@ static int vmbus_set_irq(struct platform_device *pdev)
 
 	return 0;
 }
+#endif
 
 static int vmbus_device_add(struct platform_device *pdev)
 {
@@ -2549,11 +2550,11 @@ static int vmbus_device_add(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (!__is_defined(HYPERVISOR_CALLBACK_VECTOR))
-		ret = vmbus_set_irq(pdev);
+#ifndef HYPERVISOR_CALLBACK_VECTOR
+	ret = vmbus_set_irq(pdev);
 	if (ret)
 		return ret;
-
+#endif
 	for_each_of_range(&parser, &range) {
 		struct resource *res;
 

base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
-- 
2.34.1


