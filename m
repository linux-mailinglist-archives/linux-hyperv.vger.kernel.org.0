Return-Path: <linux-hyperv+bounces-3200-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287539B3A34
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 20:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66D41F227DC
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 19:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4456F1E0E09;
	Mon, 28 Oct 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jpCaZmcT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87351E04A9;
	Mon, 28 Oct 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142678; cv=none; b=cNGuXSwY0Mq3NSytON8q4ZH7ZygJ2oZuHHLgOPso0jCfc68H03m92ZANzfc768+nvwYp2vmkU2jezz8nFZylbQ4qO+LXHZp7277MMJXIjBs1HGF6NatFSbwZuVOhGgdVJFP9bTsMEwIZAJYo0LziW/M4RDmFxVZprgzM9D4et7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142678; c=relaxed/simple;
	bh=ajW4Q6SMvwDmYENqZfeNKPa6n0l/QeIxkirVzPoVvFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B081DSAFcSYTzUB6kHqpoag076gvI7N1MMMSyNqsZqgNhNSWlG+49etCbzMJ6AOD/KQZYbs3WYjCsX9Ytlc3rvBSjb5/4HwyHxjkyXUlFEcFTjn+88OPGB4pWFolKQlsDK/0/zzzIn7eFY0790y1quYmHZTBpMRKA4qPhvq9Ai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jpCaZmcT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 586DD211F5FE;
	Mon, 28 Oct 2024 12:11:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 586DD211F5FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730142675;
	bh=Q72tolYhUo2oPbCH0Zh5EALhuSyE6L5YOQIDVIuvdRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jpCaZmcTHkc/L8GQOGYiqPg90/ElVRFlu8U5JRpDUzj/nksKdTaCp1aL91eQDTWAu
	 ZfbJRxoX7+v0LQCkwp4UJijmjd7NC2TacWi4Fy0QU1CsUacdDpKETzZ1HYX39lkERF
	 X9P86nCzE7z8m012DxN/AgDVTAzGal450BBo/PnA=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Mon, 28 Oct 2024 19:11:03 +0000
Subject: [PATCH v2 2/2] drivers: hv: Convert open-coded timeouts to
 secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-open-coded-timeouts-v2-2-c7294bb845a1@linux.microsoft.com>
References: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
In-Reply-To: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Kelley <mhklinux@outlook.com>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.1

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
index c38dcdfcb914..a99112e6f0b8 100644
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
index d35b60c06114..29e01247a087 100644
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
index 0d2184be1691..86d87486ed40 100644
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
index 9b15f7daf505..7db30881e83a 100644
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


