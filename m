Return-Path: <linux-hyperv+bounces-3092-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D4C989D08
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 10:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF4A281156
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829F180A76;
	Mon, 30 Sep 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a3rX9lz7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322517BED6;
	Mon, 30 Sep 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685712; cv=none; b=fdKnFxkDH5ILaRqD79RPzP+lo+gfQfAzUPYJscxbg57P5QsrnNZPjKvWoCBIcfsOa8SxuedTMMX04BJL6SKMHaYYU1kPwyhVaBsJD3Cf45l5whyJUikTCotG5iQxRGzbYnA/smktonsmbQfYlMDpBXXZiHqni6jjWBITBEe3p5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685712; c=relaxed/simple;
	bh=+YGaNF4FO3cX1vlao6rYtqjzOGhG8HKZmGpJ/sq0YDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XPp8KoDRtnL2p3NUFXd3k1VMViNk+9btiyisth9vpRel0px9OxIlmkrNEe1uoUzDGHQjfOxPWmsoCXEV+o5+gfdJbhiPnO6gqRtc9P/bhqks4lISgc42F2Cd16+c2m0rCdV+Wl8G+OUZuJbU5LcU+/pOBCtpCMFYwImK4PerAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a3rX9lz7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id A87D820C8C63; Mon, 30 Sep 2024 01:41:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A87D820C8C63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727685710;
	bh=N2pr1JnBEbZjhT/+blNm+E4qrbSBpWcm4Sv7x6ysoK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3rX9lz7H7C+IQGHr1kFxEUIksbuNIApmf1UWN3iGz1fJdeWcsoTm69i5+EvQ8mWZ
	 MI/9+fjB6I9YSxNT/M8h4CT5aSrUBjuvBv9phHhQt/uOOOU8IoS61N6+5dTEuWwbLO
	 LPyUqb57y4ZMpP90pYDFdefpvxuj82sP3Uzygbfw=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	mikelley@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	stable@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v3 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
Date: Mon, 30 Sep 2024 01:41:46 -0700
Message-Id: <1727685708-3524-2-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727685708-3524-1-git-send-email-ernis@linux.microsoft.com>
References: <1727685708-3524-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This change is specific to Hyper-V based VMs.
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

$echo freeze > /sys/power/state
> bash: echo: write error: Operation not supported

Fixes: 1a06d017fb3f ("Drivers: hv: vmbus: Fix Suspend-to-Idle for Generation-2 VM")
Cc: stable@vger.kernel.org
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v2:
* Add "#define vmbus_freeze NULL" when CONFIG_PM_SLEEP is not 
  enabled.
* Change commit message to clarify that this change is specifc to
  Hyper-V based VMs.
Changes in v3:
* Add 'Cc: stable@vger.kernel.org' in sign-off area.
---
 drivers/hv/vmbus_drv.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 965d2a4efb7e..8f445c849512 100644
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

