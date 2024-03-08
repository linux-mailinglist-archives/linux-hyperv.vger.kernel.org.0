Return-Path: <linux-hyperv+bounces-1685-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA5876039
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 09:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BA71C2254A
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549E53818;
	Fri,  8 Mar 2024 08:52:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A3535BC
	for <linux-hyperv@vger.kernel.org>; Fri,  8 Mar 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887920; cv=none; b=lu3TYdmxr7xTv//t4TxiDiZhatig/vz53ZEs9OVWwyFBrnw/HdlVDHZexnYosPKSQrqf6Md4eRC5H/pE04vf+XCTjZy03v5MivK6Pbfii616eDL1FBFK1QjT3mN7aeAQwtNjkkvotdYJ/pvyRIszYW1To1R9TxbdAfr6tuXcjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887920; c=relaxed/simple;
	bh=21qlWdEL13zxAc3GgDFH9Z+YSzcIC+Cu/2RsQE7l5PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HF08tFTVTX3zERKNFeX9ed+zwDCU7IvW9dnlj9/aEE1F9iDfsyEApnfHdCYlH3aG7W1UZeZJ6DSw44lE0p6pcWQUJRJkKI7bSz8BPo+Ed6nNR/bFE8XWEyYeLVRaJ8NFaffQJQu2p9mdEAC8aF+oSytLr7qO0Lgzaum5av1VjSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxF-0006vm-QH; Fri, 08 Mar 2024 09:51:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxF-0056N9-C0; Fri, 08 Mar 2024 09:51:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxF-00245Z-0v;
	Fri, 08 Mar 2024 09:51:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] hv: vmbus: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:08 +0100
Message-ID:  <920230729ddbeb9f3c4ff8282a18b0c0e1a37969.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=21qlWdEL13zxAc3GgDFH9Z+YSzcIC+Cu/2RsQE7l5PM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6tF+CE7/qQ6HxTa4lYuJBCgeRW9yVBn0QcUNb kSGSpQrvuuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZerRfgAKCRCPgPtYfRL+ TtNGB/sGfaGKOcejaIVdJdr9jZCvUYOPmOmjwJMwkeakEGebqtsBbjtA6U6NguP6OoR8sY+bDoZ R2R+f4hdGOMYwZ0z2siCax1pC9IzXyQ189nnJ/Ep7/7n01bOhLEq4M1H6Dbxx0R8bZlO0KGNI8G Wt4Lm4OEYIgnqcWxwMh/aiRi4w85u08zyDACc1J4+g/ARbK6B7biZVZdD4K0XLRpHiot0MWHmVk StqsJy9HkdD28lTVPD9JMlPwBi61Goeo3dvrNBBcTNk9LxckezgPZ7V2043p6XEVh7H25mC3n9E OIhfsHOLbG+eSGK5GM9VUm5EUl1Q7mabrgOh/0vz2QjgG2Zx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-hyperv@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/hv/vmbus_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 7f7965f3d187..4cb17603a828 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2359,10 +2359,9 @@ static int vmbus_platform_driver_probe(struct platform_device *pdev)
 		return vmbus_acpi_add(pdev);
 }
 
-static int vmbus_platform_driver_remove(struct platform_device *pdev)
+static void vmbus_platform_driver_remove(struct platform_device *pdev)
 {
 	vmbus_mmio_remove();
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -2542,7 +2541,7 @@ static const struct dev_pm_ops vmbus_bus_pm = {
 
 static struct platform_driver vmbus_platform_driver = {
 	.probe = vmbus_platform_driver_probe,
-	.remove = vmbus_platform_driver_remove,
+	.remove_new = vmbus_platform_driver_remove,
 	.driver = {
 		.name = "vmbus",
 		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


