Return-Path: <linux-hyperv+bounces-3484-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E053A9F419D
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 05:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13DA7A3F68
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 04:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4480914F132;
	Tue, 17 Dec 2024 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TnM3iiaH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22FB14D456;
	Tue, 17 Dec 2024 04:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409041; cv=none; b=ShOGPbXiApmvqp927koMHiUvuTuxuq4MPeuNs/fVB7s0583b8ImUQvLcNfeeqs/+jF694MDmCw9Byi+h8dolztvA5j9rcelUAsz+cmd91Bpc35L1XTnPzyNtTqzZI5CwkkBbEEaxdqLqLmWwTjq1wj0URqwBNEcScq49y6sTK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409041; c=relaxed/simple;
	bh=wbI0mKMWdKJTpHoGI+h2MBkSNibVAgdQ8V1iBKzfkQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=c58aChuyGMH347g6mfSRqKqrSsMgVRbRRWOwKjoRFmBzzyqeonbcWCXr88kczH73P7P8x5eD/w3+xT7J4Tj2Kj5drSfe6u8eL0XuUgJp701CRoID7izuh17XW/0GeUJCYb/x64M+1DKL0e9/cJEJbhkr8AyCmpPVwzNJA0oLUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TnM3iiaH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 63230204720E; Mon, 16 Dec 2024 20:17:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63230204720E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734409039;
	bh=rohi30jQued/musal8jVbkH2QFLeJasEFrkrbds2La4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnM3iiaHo7K6UE6HpBYOL6z9JRnTJrJmB6bvFlL44sb+TTPgoU4J2WYJobgIlGRgw
	 bIlda3ThmedYRWVkwyAWQk0ur+gGzCDPZjBSVbqmSkrjru+oiazGhiHI6VqnapKMsf
	 QKd2Dfau95SHALpUSGdzZfYvzlZNuXm8L6T/YTxs=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	stable@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v4 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
Date: Mon, 16 Dec 2024 20:17:07 -0800
Message-Id: <1734409029-10419-2-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1734409029-10419-1-git-send-email-ernis@linux.microsoft.com>
References: <1734409029-10419-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This change is specific to Hyper-V VM user.
If the Virtual Machine Connection window is focused,
a Hyper-V VM user can unintentionally touch the keyboard/mouse
when the VM is hibernating or resuming, and consequently the
hibernation or resume operation can be aborted unexpectedly.
Fix the issue by no longer registering the keyboard/mouse as
wakeup devices (see the other two patches for the
changes to drivers/input/serio/hyperv-keyboard.c and
drivers/hid/hid-hyperv.c).

The keyboard/mouse were registered as wakeup devices because the
VM needs to be woken up from the Suspend-to-Idle state after
a user runs "echo freeze > /sys/power/state". It seems like
the Suspend-to-Idle feature has no real users in practice, so
let's no longer support that by returning -EOPNOTSUPP if a
user tries to use that.

Fixes: 1a06d017fb3f ("Drivers: hv: vmbus: Fix Suspend-to-Idle for Generation-2 VM")
Cc: stable@vger.kernel.org
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>>
---
Changes in v4:
* No change

Changes in v3:
* Add "Cc: stable@vger.kernel.org" in sign-off area.

Changes in v2:
* Add "#define vmbus_freeze NULL" when CONFIG_PM_SLEEP is not 
  enabled.
---
 drivers/hv/vmbus_drv.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 6d89d37b069a..4df6b12bf6a1 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -900,6 +900,19 @@ static void vmbus_shutdown(struct device *child_device)
 }
 
 #ifdef CONFIG_PM_SLEEP
+/*
+ * vmbus_freeze - Suspend-to-Idle
+ */
+static int vmbus_freeze(struct device *child_device)
+{
+/*
+ * Do not support Suspend-to-Idle ("echo freeze > /sys/power/state") as
+ * that would require registering the Hyper-V synthetic mouse/keyboard
+ * devices as wakeup devices, which can abort hibernation/resume unexpectedly.
+ */
+	return -EOPNOTSUPP;
+}
+
 /*
  * vmbus_suspend - Suspend a vmbus device
  */
@@ -938,6 +951,7 @@ static int vmbus_resume(struct device *child_device)
 	return drv->resume(dev);
 }
 #else
+#define vmbus_freeze NULL
 #define vmbus_suspend NULL
 #define vmbus_resume NULL
 #endif /* CONFIG_PM_SLEEP */
@@ -969,7 +983,7 @@ static void vmbus_device_release(struct device *device)
  */
 
 static const struct dev_pm_ops vmbus_pm = {
-	.suspend_noirq	= NULL,
+	.suspend_noirq  = vmbus_freeze,
 	.resume_noirq	= NULL,
 	.freeze_noirq	= vmbus_suspend,
 	.thaw_noirq	= vmbus_resume,
-- 
2.34.1


