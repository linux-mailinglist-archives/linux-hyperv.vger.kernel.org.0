Return-Path: <linux-hyperv+bounces-3218-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DCC9B6B45
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2024 18:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7281C21823
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2024 17:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509651CC15C;
	Wed, 30 Oct 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UgCdEVzu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9F419A288;
	Wed, 30 Oct 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310478; cv=none; b=s7gpJPqTZPiPDu/+fMbYJkdndytM/FAlEYn3wL3oxEv4J3A+jCoMH+raq7Qfi1Lst2Q5PDtfra8XjQKoQ4+JMvmexz5PLTIAKb1LuXBL29bWdEj2pX5RN3n7abiY9mMEzdtuLv0/hKOw4CiO6PxLqG5dCdRKKLzZYhfH3i/M1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310478; c=relaxed/simple;
	bh=Y412xZzNOO5MY5f54d4tqDx7k+RoU/X0XQaCOxzYaA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0Cs8d/1wCr/l3AFSdI8ukiqyj6OMs86Tvg/afmZs67AXuEXBnTTfbFYEZWLCI9gW7bYUjfD1TZsGziAEqhXBSZSZ4KbFvP3p/kSjOyT3HR/4cFJyrcqr/4pW/b30XIoejHacafNNNF1r9ZKOlBhg5WX8cWkNLrD4XVq4TOuNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UgCdEVzu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id B85E72054B69;
	Wed, 30 Oct 2024 10:47:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B85E72054B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730310470;
	bh=bwsyKqQWUa0Kwp+K5MBC5j2XBjYIf72PRYb9FH/rEwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UgCdEVzurzBU+c8+arct7OHOSd0yrqb5/vHvfhed2xVDqVDS4AomkKuo0NGX43Epj
	 TK6Fn8unpF00LFLpdszi5GI6gi2r9zrl0tS/xupPDbqZ/gweAA68JB02GhPal18H1b
	 RNWS9USCx69f4ue8YEpBMHgt2hPJpSsxri4qqVzw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 30 Oct 2024 17:47:36 +0000
Subject: [PATCH v3 2/2] drivers: hv: Convert open-coded timeouts to
 secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-open-coded-timeouts-v3-2-9ba123facf88@linux.microsoft.com>
References: <20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com>
In-Reply-To: <20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Praveen Kumar <kumarpraveen@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

We have several places where timeouts are open-coded as N (seconds) * HZ,
but best practice is to use the utility functions from jiffies.h. Convert
the timeouts to be compliant. This doesn't fix any bugs, it's a simple code
improvement.

TO: "K. Y. Srinivasan" <kys@microsoft.com>
TO: Haiyang Zhang <haiyangz@microsoft.com>
TO: Wei Liu <wei.liu@kernel.org>
TO: Dexuan Cui <decui@microsoft.com>
TO: linux-hyperv@vger.kernel.org
TO: Anna-Maria Behnsen <anna-maria@linutronix.de>
TO: Thomas Gleixner <tglx@linutronix.de>
TO: Geert Uytterhoeven <geert@linux-m68k.org>
TO: Marcel Holtmann <marcel@holtmann.org>
TO: Johan Hedberg <johan.hedberg@gmail.com>
TO: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
TO: linux-bluetooth@vger.kernel.org
TO: linux-kernel@vger.kernel.org
CC: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/hv/hv_balloon.c  | 9 +++++----
 drivers/hv/hv_kvp.c      | 4 ++--
 drivers/hv/hv_snapshot.c | 3 ++-
 drivers/hv/vmbus_drv.c   | 2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index c38dcdfcb914dcc3515be100cba0beb4a3f9b975..a99112e6f0b8534cf5c8c963e343019061bd34f6 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -756,7 +756,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 		 * adding succeeded, it is ok to proceed even if the memory was
 		 * not onlined in time.
 		 */
-		wait_for_completion_timeout(&dm_device.ol_waitevent, 5 * HZ);
+		wait_for_completion_timeout(&dm_device.ol_waitevent, secs_to_jiffies(5));
 		post_status(&dm_device);
 	}
 }
@@ -1373,7 +1373,8 @@ static int dm_thread_func(void *dm_dev)
 	struct hv_dynmem_device *dm = dm_dev;
 
 	while (!kthread_should_stop()) {
-		wait_for_completion_interruptible_timeout(&dm_device.config_event, 1 * HZ);
+		wait_for_completion_interruptible_timeout(&dm_device.config_event,
+								secs_to_jiffies(1));
 		/*
 		 * The host expects us to post information on the memory
 		 * pressure every second.
@@ -1748,7 +1749,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	if (ret)
 		goto out;
 
-	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
+	t = wait_for_completion_timeout(&dm_device.host_event, secs_to_jiffies(5));
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto out;
@@ -1806,7 +1807,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	if (ret)
 		goto out;
 
-	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
+	t = wait_for_completion_timeout(&dm_device.host_event, secs_to_jiffies(5));
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto out;
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index d35b60c0611486c8c909d2f8f7c730ff913df30d..29e01247a0870fdb9eebd92bdd16fd371450240c 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -655,7 +655,7 @@ void hv_kvp_onchannelcallback(void *context)
 		if (host_negotiatied == NEGO_NOT_STARTED) {
 			host_negotiatied = NEGO_IN_PROGRESS;
 			schedule_delayed_work(&kvp_host_handshake_work,
-				      HV_UTIL_NEGO_TIMEOUT * HZ);
+						secs_to_jiffies(HV_UTIL_NEGO_TIMEOUT));
 		}
 		return;
 	}
@@ -724,7 +724,7 @@ void hv_kvp_onchannelcallback(void *context)
 		 */
 		schedule_work(&kvp_sendkey_work);
 		schedule_delayed_work(&kvp_timeout_work,
-					HV_UTIL_TIMEOUT * HZ);
+				      secs_to_jiffies(HV_UTIL_TIMEOUT));
 
 		return;
 
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 0d2184be16912559a8cfa784c762e6418ebd3279..86d87486ed40b3ca9f6674650e5a86a7184e2fa6 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -193,7 +193,8 @@ static void vss_send_op(void)
 	vss_transaction.state = HVUTIL_USERSPACE_REQ;
 
 	schedule_delayed_work(&vss_timeout_work, op == VSS_OP_FREEZE ?
-			VSS_FREEZE_TIMEOUT * HZ : HV_UTIL_TIMEOUT * HZ);
+				secs_to_jiffies(VSS_FREEZE_TIMEOUT) :
+				secs_to_jiffies(HV_UTIL_TIMEOUT));
 
 	rc = hvutil_transport_send(hvt, vss_msg, sizeof(*vss_msg), NULL);
 	if (rc) {
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 9b15f7daf5059750e17ea3607b52dee967c1c059..7db30881e83ad4b406413641413d68329fc663e2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2507,7 +2507,7 @@ static int vmbus_bus_resume(struct device *dev)
 	vmbus_request_offers();
 
 	if (wait_for_completion_timeout(
-		&vmbus_connection.ready_for_resume_event, 10 * HZ) == 0)
+		&vmbus_connection.ready_for_resume_event, secs_to_jiffies(10)) == 0)
 		pr_err("Some vmbus device is missing after suspending?\n");
 
 	/* Reset the event for the next suspend. */

-- 
2.34.1


