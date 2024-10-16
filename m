Return-Path: <linux-hyperv+bounces-3148-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9379A15D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Oct 2024 00:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4578B1F23401
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Oct 2024 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C381D4174;
	Wed, 16 Oct 2024 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BN0Ikvoq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC251D279F;
	Wed, 16 Oct 2024 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729118257; cv=none; b=Eo1SjaaRPSwHHMcT/dH/AVPxuT656AkKOjn1P4bh9EdM+dQ8ijc/ukDJSoqNK4HEuSilqGCWBfC6W8LHcLZHvc2jIhDHRyY4jqneCIFbQmKm0e5vGbrmY298BaurU+9lA70+zm/5S+qeaXB3kaPkuEwiFpXxey1xa3FO7D5RGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729118257; c=relaxed/simple;
	bh=EQ4ml+O4TX3BjSDvRSV0hoFCLWMb87Ys4GS55Jll2xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P42rOlrRKk6KGCZS9L8kLhfUdMUTMYDxjK/LPsCGWEGAYWptn/XSvD4C88gNOTm66wuNssKfTxCfVrrFekFUrAv6ZwRMg1lCxbpKPEJFA7H/0CQueKzM9tbsHt7sHowZzOIFNn8qkz5okmccVtC7DpHlKyuzJK8dsGJJypbgHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BN0Ikvoq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.159.201])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3836D20E1AAE;
	Wed, 16 Oct 2024 15:37:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3836D20E1AAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729118255;
	bh=NWGATxjJC59rbkT0n4WXCatYd0kHKSQicgKPOVfHyH8=;
	h=From:To:Cc:Subject:Date:From;
	b=BN0Ikvoq0ZxCI0swOSjhsZKZUuYFNh1fd6t9j8zIqpLj2+1fZVIy/L2a73tOrjzWJ
	 nugcNpwOxxEyUbbf1G0g9/l1mga2EjdAjPeFoP8wJDNK2k4ldbgt7jGhGj5O0MKB/P
	 uf0zjCxKJ8LUQYoBg7hOUTwcON/kpN+4xxnMKdVc=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: lkp@intel.com,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [RFC PATCH] drivers: hv: Convert open-coded timeouts to msecs_to_jiffies()
Date: Wed, 16 Oct 2024 22:37:27 +0000
Message-ID: <20241016223730.531861-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have several places where timeouts are open-coded as N (seconds) * HZ,
but best practice is to use msecs_to_jiffies(). Convert the timeouts to
make them HZ invariant.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/hv/hv_balloon.c  | 9 +++++----
 drivers/hv/hv_kvp.c      | 4 ++--
 drivers/hv/hv_snapshot.c | 6 ++++--
 drivers/hv/vmbus_drv.c   | 2 +-
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index c38dcdfcb914d..3017d41f12681 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -756,7 +756,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 		 * adding succeeded, it is ok to proceed even if the memory was
 		 * not onlined in time.
 		 */
-		wait_for_completion_timeout(&dm_device.ol_waitevent, 5 * HZ);
+		wait_for_completion_timeout(&dm_device.ol_waitevent, msecs_to_jiffies(5 * 1000));
 		post_status(&dm_device);
 	}
 }
@@ -1373,7 +1373,8 @@ static int dm_thread_func(void *dm_dev)
 	struct hv_dynmem_device *dm = dm_dev;
 
 	while (!kthread_should_stop()) {
-		wait_for_completion_interruptible_timeout(&dm_device.config_event, 1 * HZ);
+		wait_for_completion_interruptible_timeout(&dm_device.config_event,
+							  msecs_to_jiffies(1 * 1000));
 		/*
 		 * The host expects us to post information on the memory
 		 * pressure every second.
@@ -1748,7 +1749,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	if (ret)
 		goto out;
 
-	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
+	t = wait_for_completion_timeout(&dm_device.host_event, msecs_to_jiffies(5 * 1000));
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto out;
@@ -1806,7 +1807,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	if (ret)
 		goto out;
 
-	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
+	t = wait_for_completion_timeout(&dm_device.host_event, msecs_to_jiffies(5 * 1000));
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto out;
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index d35b60c061148..8d9ae1b0e8788 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -655,7 +655,7 @@ void hv_kvp_onchannelcallback(void *context)
 		if (host_negotiatied == NEGO_NOT_STARTED) {
 			host_negotiatied = NEGO_IN_PROGRESS;
 			schedule_delayed_work(&kvp_host_handshake_work,
-				      HV_UTIL_NEGO_TIMEOUT * HZ);
+						msecs_to_jiffies(HV_UTIL_NEGO_TIMEOUT * 1000));
 		}
 		return;
 	}
@@ -724,7 +724,7 @@ void hv_kvp_onchannelcallback(void *context)
 		 */
 		schedule_work(&kvp_sendkey_work);
 		schedule_delayed_work(&kvp_timeout_work,
-					HV_UTIL_TIMEOUT * HZ);
+				      msecs_to_jiffies(HV_UTIL_TIMEOUT * 1000));
 
 		return;
 
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 0d2184be16912..be4955613db35 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -192,8 +192,10 @@ static void vss_send_op(void)
 
 	vss_transaction.state = HVUTIL_USERSPACE_REQ;
 
-	schedule_delayed_work(&vss_timeout_work, op == VSS_OP_FREEZE ?
-			VSS_FREEZE_TIMEOUT * HZ : HV_UTIL_TIMEOUT * HZ);
+	schedule_delayed_work(&vss_timeout_work,
+				op == VSS_OP_FREEZE ?
+				msecs_to_jiffies(VSS_FREEZE_TIMEOUT * 1000) :
+				msecs_to_jiffies(HV_UTIL_TIMEOUT * 1000));
 
 	rc = hvutil_transport_send(hvt, vss_msg, sizeof(*vss_msg), NULL);
 	if (rc) {
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 9b15f7daf5059..e35e0a615cb58 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2507,7 +2507,7 @@ static int vmbus_bus_resume(struct device *dev)
 	vmbus_request_offers();
 
 	if (wait_for_completion_timeout(
-		&vmbus_connection.ready_for_resume_event, 10 * HZ) == 0)
+		&vmbus_connection.ready_for_resume_event, msecs_to_jiffies(10 * 1000)) == 0)
 		pr_err("Some vmbus device is missing after suspending?\n");
 
 	/* Reset the event for the next suspend. */
-- 
2.43.0


