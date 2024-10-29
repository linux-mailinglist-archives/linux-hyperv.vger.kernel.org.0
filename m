Return-Path: <linux-hyperv+bounces-3205-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7A59B43A9
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 09:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADDD28378F
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA23203712;
	Tue, 29 Oct 2024 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j0r4FG5Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F25D203709;
	Tue, 29 Oct 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188925; cv=none; b=MMNKoSsblMT06wn8bOjqN3NyddpexQ+qF4tJsIXLxS2m8JDdwI7jtX4YGlGXQuhGfC5Fzh8mDWQt5FWpRBizHrqQYW78Mh3TG1CSctQHe677FC06+rooPwjXievowd+Py4s2oYOPZWLGmOYMpnx75+nlQGuDRBPgJnOgJjt9ScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188925; c=relaxed/simple;
	bh=PkCj4yQQkYf8LNOq/5C51ZuCx5TaVY5ArRSohRDgWS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+6suhQwhGgwd5wzxd1t3x3+uRssNZlAnQfCuSRS8/cznQGN09IUS63gqba//GXPZJHjCsRMJTBRJ4WjpmQTmVFIQ5wmkEX93gTC3A846U7XjhX/l1grDAu8aSbwYX7iq28tFVv8y93VKrenDd6m1spt+MYN5mI0dkrbxdLmjs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j0r4FG5Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.corp.microsoft.com (unknown [131.107.147.150])
	by linux.microsoft.com (Postfix) with ESMTPSA id B3E62211F7A5;
	Tue, 29 Oct 2024 01:01:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3E62211F7A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730188917;
	bh=0wCSjlwzDEcBI0+xNE32qsIySj+0YCHIu64jRXUjXrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0r4FG5YbO7KF/+lg0BKw2sdDqb0qm+/ruUGJ0tevdI1Y35fVahC4RmDV2/1n8BLt
	 cDyu6xVm9cLZmcT9PANLnDGNLX5C6/6bQ7oHFliWKyUyDqaeFcvWI+3QkfgqaSaHlt
	 DIxQI6IbyG3GaKRpPczGAL98tyYO0o5Sca92e8Nk=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naman Jain <namjain@linux.microsoft.com>,
	John Starks <jostarks@microsoft.com>,
	jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: Wait for offers during boot
Date: Tue, 29 Oct 2024 01:01:46 -0700
Message-Id: <20241029080147.52749-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029080147.52749-1-namjain@linux.microsoft.com>
References: <20241029080147.52749-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Channel offers are requested during VMBus initialization and resume
from hibernation. Add support to wait for all channel offers to be
delivered and processed before returning from vmbus_request_offers.

This is in analogy to a PCI bus not returning from probe until it has
scanned all devices on the bus.

Without this, user mode can race with VMBus initialization and miss
channel offers. User mode has no way to work around this other than
sleeping for a while, since there is no way to know when VMBus has
finished processing offers.

With this added functionality, remove earlier logic which keeps track
of count of offered channels post resume from hibernation. Once all
offers delivered message is received, no further offers are going to
be received. Consequently, logic to prevent suspend from happening
after previous resume had missing offers, is also removed.

Co-developed-by: John Starks <jostarks@microsoft.com>
Signed-off-by: John Starks <jostarks@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
Changes since v1:
https://lore.kernel.org/all/20241018115811.5530-1-namjain@linux.microsoft.com
* Added Easwar's Reviewed-By tag
* Addressed Michael's comments:
  * Added explanation of all offers delivered message in comments
  * Removed infinite wait for offers logic, and changed it wait once.
  * Removed sub channel workqueue flush logic
  * Added comments on why MLX device offer is not expected as part of
    this essential boot offer list. I refrained from adding too many                                                        details on it as it felt like it is beyond the scope of this patch                                                      series and may not be relevant to this. However, please let me know if
    something needs to be added.
* Addressed Saurabh's comments:
  * Changed timeout value to 10000 ms instead of 10*10000
  * Changed commit msg as per suggestions
  * Added a comment for warning case of wait_for_completion timeout
---
 drivers/hv/channel_mgmt.c | 55 ++++++++++++++++++++++++++++-----------
 drivers/hv/connection.c   |  4 +--
 drivers/hv/hyperv_vmbus.h | 14 +++-------
 drivers/hv/vmbus_drv.c    | 16 ------------
 4 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 3c6011a48dab..a2e9ebe5bf72 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -944,16 +944,6 @@ void vmbus_initiate_unload(bool crash)
 		vmbus_wait_for_unload();
 }
 
-static void check_ready_for_resume_event(void)
-{
-	/*
-	 * If all the old primary channels have been fixed up, then it's safe
-	 * to resume.
-	 */
-	if (atomic_dec_and_test(&vmbus_connection.nr_chan_fixup_on_resume))
-		complete(&vmbus_connection.ready_for_resume_event);
-}
-
 static void vmbus_setup_channel_state(struct vmbus_channel *channel,
 				      struct vmbus_channel_offer_channel *offer)
 {
@@ -1109,8 +1099,6 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 
 		/* Add the channel back to the array of channels. */
 		vmbus_channel_map_relid(oldchannel);
-		check_ready_for_resume_event();
-
 		mutex_unlock(&vmbus_connection.channel_mutex);
 		return;
 	}
@@ -1296,13 +1284,22 @@ EXPORT_SYMBOL_GPL(vmbus_hvsock_device_unregister);
 
 /*
  * vmbus_onoffers_delivered -
- * This is invoked when all offers have been delivered.
+ * CHANNELMSG_ALLOFFERS_DELIVERED message arrives after all the essential
+ * boot-time offers are delivered. Other channels can be hot added
+ * or removed later, even immediately after the all-offers-delivered
+ * message. A boot-time offer will be any of the virtual hardware the
+ * VM is configured with at boot.
  *
- * Nothing to do here.
+ * Virtual devices like Mellanox NIC may not be included in the list of
+ * these initial boot offers because it is an optional accelerator to
+ * the synthetic VMBus NIC. It is hot added only after the VMBus NIC
+ * channel is opened (once it knows the guest can support it, via the
+ * sriov bit in the netvsc protocol).
  */
 static void vmbus_onoffers_delivered(
 			struct vmbus_channel_message_header *hdr)
 {
+	complete(&vmbus_connection.all_offers_delivered_event);
 }
 
 /*
@@ -1578,7 +1575,8 @@ void vmbus_onmessage(struct vmbus_channel_message_header *hdr)
 }
 
 /*
- * vmbus_request_offers - Send a request to get all our pending offers.
+ * vmbus_request_offers - Send a request to get all our pending offers
+ * and wait for all offers to arrive.
  */
 int vmbus_request_offers(void)
 {
@@ -1596,6 +1594,10 @@ int vmbus_request_offers(void)
 
 	msg->msgtype = CHANNELMSG_REQUESTOFFERS;
 
+	/*
+	 * This REQUESTOFFERS message will result in the host sending an all
+	 * offers delivered message.
+	 */
 	ret = vmbus_post_msg(msg, sizeof(struct vmbus_channel_message_header),
 			     true);
 
@@ -1607,6 +1609,29 @@ int vmbus_request_offers(void)
 		goto cleanup;
 	}
 
+	/*
+	 * Wait for the host to send all offers.
+	 * Keeping it as a best-effort mechanism, where a warning is
+	 * printed if a timeout occurs, and execution is resumed.
+	 */
+	if (!wait_for_completion_timeout(
+		&vmbus_connection.all_offers_delivered_event, msecs_to_jiffies(10000))) {
+		pr_warn("timed out waiting for all offers to be delivered...\n");
+	}
+
+	/*
+	 * Flush handling of offer messages (which may initiate work on
+	 * other work queues).
+	 */
+	flush_workqueue(vmbus_connection.work_queue);
+
+	/*
+	 * Flush workqueues for processing the incoming offers. Subchannel
+	 * offers and processing can happen later, so there is no need to
+	 * flush those workqueues here.
+	 */
+	flush_workqueue(vmbus_connection.handle_primary_chan_wq);
+
 cleanup:
 	kfree(msginfo);
 
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index f001ae880e1d..8351360bba16 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -34,8 +34,8 @@ struct vmbus_connection vmbus_connection = {
 
 	.ready_for_suspend_event = COMPLETION_INITIALIZER(
 				  vmbus_connection.ready_for_suspend_event),
-	.ready_for_resume_event	= COMPLETION_INITIALIZER(
-				  vmbus_connection.ready_for_resume_event),
+	.all_offers_delivered_event = COMPLETION_INITIALIZER(
+				  vmbus_connection.all_offers_delivered_event),
 };
 EXPORT_SYMBOL_GPL(vmbus_connection);
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index d2856023d53c..80cc65dac740 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -287,18 +287,10 @@ struct vmbus_connection {
 	struct completion ready_for_suspend_event;
 
 	/*
-	 * The number of primary channels that should be "fixed up"
-	 * upon resume: these channels are re-offered upon resume, and some
-	 * fields of the channel offers (i.e. child_relid and connection_id)
-	 * can change, so the old offermsg must be fixed up, before the resume
-	 * callbacks of the VSC drivers start to further touch the channels.
+	 * Completed once the host has offered all channels. Note that
+	 * some channels may still be being process on a work queue.
 	 */
-	atomic_t nr_chan_fixup_on_resume;
-	/*
-	 * vmbus_bus_resume() waits for "nr_chan_fixup_on_resume" to
-	 * drop to zero.
-	 */
-	struct completion ready_for_resume_event;
+	struct completion all_offers_delivered_event;
 };
 
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 9b15f7daf505..bd3fc41dc06b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2427,11 +2427,6 @@ static int vmbus_bus_suspend(struct device *dev)
 	if (atomic_read(&vmbus_connection.nr_chan_close_on_suspend) > 0)
 		wait_for_completion(&vmbus_connection.ready_for_suspend_event);
 
-	if (atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) != 0) {
-		pr_err("Can not suspend due to a previous failed resuming\n");
-		return -EBUSY;
-	}
-
 	mutex_lock(&vmbus_connection.channel_mutex);
 
 	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
@@ -2456,17 +2451,12 @@ static int vmbus_bus_suspend(struct device *dev)
 			pr_err("Sub-channel not deleted!\n");
 			WARN_ON_ONCE(1);
 		}
-
-		atomic_inc(&vmbus_connection.nr_chan_fixup_on_resume);
 	}
 
 	mutex_unlock(&vmbus_connection.channel_mutex);
 
 	vmbus_initiate_unload(false);
 
-	/* Reset the event for the next resume. */
-	reinit_completion(&vmbus_connection.ready_for_resume_event);
-
 	return 0;
 }
 
@@ -2502,14 +2492,8 @@ static int vmbus_bus_resume(struct device *dev)
 	if (ret != 0)
 		return ret;
 
-	WARN_ON(atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) == 0);
-
 	vmbus_request_offers();
 
-	if (wait_for_completion_timeout(
-		&vmbus_connection.ready_for_resume_event, 10 * HZ) == 0)
-		pr_err("Some vmbus device is missing after suspending?\n");
-
 	/* Reset the event for the next suspend. */
 	reinit_completion(&vmbus_connection.ready_for_suspend_event);
 
-- 
2.34.1


