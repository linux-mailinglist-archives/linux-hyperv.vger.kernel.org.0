Return-Path: <linux-hyperv+bounces-3006-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A33977399
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 23:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196B81F251B8
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE21C2DD9;
	Thu, 12 Sep 2024 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mNwjzcjE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7511273FC;
	Thu, 12 Sep 2024 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176494; cv=none; b=RC2uJGXA7mKnktxJAVXDagagrnzX3cRfB7NARb1AeBm0UhsMAtq1To5V7rQfb2FfJGRWl/zM79EkFEHgNO8dPtJrAU91uik8hRLEIu+7lYqrc/gzE7KeS0GAHIs7d/L0XCjshH4fpVtTrQF/jrRZ8HAfDgP7+WFPE2TUOheFNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176494; c=relaxed/simple;
	bh=C/0k5h/lz8R84whuzaRUihDwkeowMkaSPX+29qXmSxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NNIl2eraVSaLdyf2FsxwflaIn/UwFBHIgHHOLeMJdCRZp9piS4kLlY7N5ONhpg0oTJM2hM/cq51ZMlVcpy3meZZQi9b1HC7JzY3uVeTnmuAx7l5hbmLWZsdjBMfybd1J0vrapwrk79mwJw0tZCNNyYyBnmOEzml+kYiaeKdtkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mNwjzcjE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 7A1DD20B9A7D; Thu, 12 Sep 2024 14:28:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A1DD20B9A7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726176492;
	bh=FiAEiFQKFxwfSrfKohS2aGHA4PAserjex5R9EsRTrSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNwjzcjEAkOH7NAGjLka2rBCaKvi0P0S65n+M7KIlbOO4MfGreD5lkC4WgIPB/ekS
	 bUAFFtTAX4tTk7bn64X6+UKMp75hhFHyQpbarHz+RjVJzcnZI0gVUTaQkKM7+g0GSm
	 f0qytzxHFfJaT47qlaF8hlK+78e3G1mJIj6Sytj0=
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
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
Date: Thu, 12 Sep 2024 14:27:48 -0700
Message-Id: <1726176470-13133-2-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

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

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 965d2a4efb7e..4efd8856392f 100644
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
@@ -969,7 +982,7 @@ static void vmbus_device_release(struct device *device)
  */
 
 static const struct dev_pm_ops vmbus_pm = {
-	.suspend_noirq	= NULL,
+	.suspend_noirq  = vmbus_freeze,
 	.resume_noirq	= NULL,
 	.freeze_noirq	= vmbus_suspend,
 	.thaw_noirq	= vmbus_resume,
-- 
2.34.1


