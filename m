Return-Path: <linux-hyperv+bounces-3175-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C89AB631
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 20:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104B0284AFC
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9453B1CB31A;
	Tue, 22 Oct 2024 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MsY4p/CA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233321C9DC5;
	Tue, 22 Oct 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623242; cv=none; b=QbplQFt1kSXZVuTJ47RQhQuXCeG0J1b9tEuTfjZI8SXLEl2A2sPNNhInTGq6uIFlaAm3rtEh5005JzxIY3pELZn5B3De0daZLyTb6A3SRnqRGK/wClk+FFGwKTlMfWvc4fxc7MjFwfffb0BKGSqabdAITxz8F88ItGOf/iBMpNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623242; c=relaxed/simple;
	bh=hbwdO/HGZgXheZdv4bWPZtTJjpSjdlvgPY9dK7YgesU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ejcfe2UuACWOnCXDZQNUVMmz0mw/bmsLXjmg5dQ4Zz3/OC6r/s0EK3pKF7LN+sJnLTqtBN9zObpwmuy4srUix7LRR0ZMVEH+DI3qnATqQ/n82H6siuy6EfSjnwcVhkGHSp1A/aohEocrxkgFhWgTmFvlKX/Ek51a/sQaTlnjinE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MsY4p/CA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id BEFD821112EB;
	Tue, 22 Oct 2024 11:54:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BEFD821112EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729623240;
	bh=5QmE36PovEZHStErq5Ahhyj2HI06iagMlMdubf3NbHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MsY4p/CAcqhcO1K/nXe51W55O1LeXOV/doBBUHVdxjGDG3TLE5oxhxKKMXoNc/EWL
	 TpMIP11dmpDnaWlpNkKPpiOfhyKOH3UFlqJlqvilXH7KEGi9Kb/XsS/HpZTzqWtbyn
	 fjNszdUIeOQa3TgHZBap4sUR080q+K0Q1HswVpnc=
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
Subject: [PATCH 2/2] drivers: hv: Convert open-coded timeouts to secs_to_jiffies()
Date: Tue, 22 Oct 2024 18:53:50 +0000
Message-Id: <20241022185353.2080021-2-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
References: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have several places where timeouts are open-coded as N (seconds) * HZ,
but best practice is to use the utility functions from jiffies.h. Convert
the timeouts to be compliant. This doesn't fix any bugs, it's a simple code
improvement.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/hv/hv_balloon.c  | 8 ++++----
 drivers/hv/hv_kvp.c      | 4 ++--
 drivers/hv/hv_snapshot.c | 3 ++-
 drivers/hv/vmbus_drv.c   | 2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index c38dcdfcb914..79a72e68f427 100644
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
@@ -1373,7 +1373,7 @@ static int dm_thread_func(void *dm_dev)
 	struct hv_dynmem_device *dm = dm_dev;
 
 	while (!kthread_should_stop()) {
-		wait_for_completion_interruptible_timeout(&dm_device.config_event, 1 * HZ);
+		wait_for_completion_interruptible_timeout(&dm_device.config_event, secs_to_jiffies(1));
 		/*
 		 * The host expects us to post information on the memory
 		 * pressure every second.
@@ -1748,7 +1748,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	if (ret)
 		goto out;
 
-	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
+	t = wait_for_completion_timeout(&dm_device.host_event, secs_to_jiffies(5));
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto out;
@@ -1806,7 +1806,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
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


