Return-Path: <linux-hyperv+bounces-3566-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB39FF9A2
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 14:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A06118836F2
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFC819DF60;
	Thu,  2 Jan 2025 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KAU2oOVw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6A7483;
	Thu,  2 Jan 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735823244; cv=none; b=GfRfKO9+GICPa7eSTPU39SqesctApXgfFQBwPMPNbeGPamRvdeUZtVpGUYJbr5x9MMSE9frlgo+AI+WQBsQdomPXcYqJw0owfQ2twPEOauEPemdAtXsJREpzd0fQvo8zsc2KfPD5oDwJtnbxpTfuVQoN35Iqf14sJkeAddZv70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735823244; c=relaxed/simple;
	bh=DCQzilbsM8G8lcQIL4MuG9EVrn2DnZaxx2ZRLD2hzIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVS2eGQyviQjCAgQYFZwv/2/jAIpWvVJQNKud0oUgXJXCthr3EfeRbWWcWAiQJLKk+YLIP2SDx9Ihz1nTSZzISwAmM7D4qapm/cC9pEGwbkr4JgtAoa9eRu9UxLMGhbRZe2nncNogbUdbbBqh1t7bOMHaV+4ma4zH+sOdiPzvPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KAU2oOVw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-hibernation.4uyjgaamrtuunfhsycmekme4ua.xx.internal.cloudapp.net (unknown [20.94.232.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id C79352066C28;
	Thu,  2 Jan 2025 05:07:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C79352066C28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735823236;
	bh=vBdaKQr3HTUZv3dxmih7Hpf6U6cs03dKZiDqDGVxoSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAU2oOVwfy29buSjc91yu4XV2pouumbLuFugvqT4d1CQoez+hNlf1uSTXjrEjAeu6
	 Yc0H6QgKtaWSOlfhLnCO3L7HQ+76Ox+eqxLhfL41VVQcqNamgQyC5mmujVfwPI+5Yg
	 rxfz1VC2o1wST5MS1yLVWBHVkRCvobbDoU2weeRc=
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
Subject: [PATCH v5 1/2] Drivers: hv: vmbus: Wait for boot-time offers during boot and resume
Date: Thu,  2 Jan 2025 13:07:10 +0000
Message-ID: <20250102130712.1661-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102130712.1661-1-namjain@linux.microsoft.com>
References: <20250102130712.1661-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Channel offers are requested during VMBus initialization and resume from
hibernation. Add support to wait for all boot-time channel offers to
be delivered and processed before returning from vmbus_request_offers.

This is in analogy to a PCI bus not returning from probe until it has
scanned all devices on the bus.

Without this, user mode can race with VMBus initialization and miss
channel offers. User mode has no way to work around this other than
sleeping for a while, since there is no way to know when VMBus has
finished processing boot-time offers.

With this added functionality, remove earlier logic which keeps track
of count of offered channels post resume from hibernation. Once all
offers delivered message is received, no further boot-time offers are
going to be received. Consequently, logic to prevent suspend from
happening after previous resume had missing offers, is also removed.

Co-developed-by: John Starks <jostarks@microsoft.com>
Signed-off-by: John Starks <jostarks@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
Changes since v4:
Rebased and added Michael's Reviewed-by tag.

Changes since v3:
Fixed checkpatch style warnings coming with "--strict" option,
addressing Saurabh's comments.
FYI, I kept code style same as earlier for below, to keep consistency
with other similar fields in the code and because of lack of options
due to 100 char limit.
***
CHECK: Lines should not end with a '('
FILE: drivers/hv/connection.c:37:
+       .all_offers_delivered_event = COMPLETION_INITIALIZER(
***

Changes since v2:
* Incorporated Easwar's suggestion to use secs_to_jiffies() as his
  changes are now merged.
* Addressed Michael's comments:
  * Used boot-time offers/channels/devices to maintain consistency
  * Rephrased CHANNELMSG_ALLOFFERS_DELIVERED handler function comments
    for better explanation. Thanks for sharing the write-up.
  * Changed commit msg and other things as per suggestions
* Addressed Dexuan's comments, which came up in offline discussion:
  * Changed timeout for waiting for all offers delivered msg to 60s instead of 10s.
    Reason being, the host can experience some servicing events or diagnostics events,
    which may take a long time and hence may fail to offer all the devices within 10s.
  * Minor additions in commit subject.

Changes since v1:
* Added Easwar's Reviewed-By tag
* Addressed Michael's comments:
  * Added explanation of all offers delivered message in comments
  * Removed infinite wait for offers logic, and changed it wait once.
  * Removed sub channel workqueue flush logic
  * Added comments on why MLX device offer is not expected as part of
    this essential boot offer list. I refrained from adding too many
    details on it as it felt like it is beyond the scope of this patch
    series and may not be relevant to this. However, please let me know if
    something needs to be added.
* Addressed Saurabh's comments:
  * Changed timeout value to 10000 ms instead of 10*10000
  * Changed commit msg as per suggestions
  * Added a comment for warning case of wait_for_completion timeout
---
 drivers/hv/channel_mgmt.c | 61 +++++++++++++++++++++++++++++----------
 drivers/hv/connection.c   |  4 +--
 drivers/hv/hyperv_vmbus.h | 14 ++-------
 drivers/hv/vmbus_drv.c    | 16 ----------
 4 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 3c6011a48dab..6e084c207414 100644
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
@@ -1296,13 +1284,28 @@ EXPORT_SYMBOL_GPL(vmbus_hvsock_device_unregister);
 
 /*
  * vmbus_onoffers_delivered -
- * This is invoked when all offers have been delivered.
+ * The CHANNELMSG_ALLOFFERS_DELIVERED message arrives after all
+ * boot-time offers are delivered. A boot-time offer is for the primary
+ * channel for any virtual hardware configured in the VM at the time it boots.
+ * Boot-time offers include offers for physical devices assigned to the VM
+ * via Hyper-V's Discrete Device Assignment (DDA) functionality that are
+ * handled as virtual PCI devices in Linux (e.g., NVMe devices and GPUs).
+ * Boot-time offers do not include offers for VMBus sub-channels. Because
+ * devices can be hot-added to the VM after it is booted, additional channel
+ * offers that aren't boot-time offers can be received at any time after the
+ * all-offers-delivered message.
  *
- * Nothing to do here.
+ * SR-IOV NIC Virtual Functions (VFs) assigned to a VM are not considered
+ * to be assigned to the VM at boot-time, and offers for VFs may occur after
+ * the all-offers-delivered message. VFs are optional accelerators to the
+ * synthetic VMBus NIC and are effectively hot-added only after the VMBus
+ * NIC channel is opened (once it knows the guest can support it, via the
+ * sriov bit in the netvsc protocol).
  */
 static void vmbus_onoffers_delivered(
 			struct vmbus_channel_message_header *hdr)
 {
+	complete(&vmbus_connection.all_offers_delivered_event);
 }
 
 /*
@@ -1578,7 +1581,8 @@ void vmbus_onmessage(struct vmbus_channel_message_header *hdr)
 }
 
 /*
- * vmbus_request_offers - Send a request to get all our pending offers.
+ * vmbus_request_offers - Send a request to get all our pending offers
+ * and wait for all boot-time offers to arrive.
  */
 int vmbus_request_offers(void)
 {
@@ -1596,6 +1600,10 @@ int vmbus_request_offers(void)
 
 	msg->msgtype = CHANNELMSG_REQUESTOFFERS;
 
+	/*
+	 * This REQUESTOFFERS message will result in the host sending an all
+	 * offers delivered message after all the boot-time offers are sent.
+	 */
 	ret = vmbus_post_msg(msg, sizeof(struct vmbus_channel_message_header),
 			     true);
 
@@ -1607,6 +1615,29 @@ int vmbus_request_offers(void)
 		goto cleanup;
 	}
 
+	/*
+	 * Wait for the host to send all boot-time offers.
+	 * Keeping it as a best-effort mechanism, where a warning is
+	 * printed if a timeout occurs, and execution is resumed.
+	 */
+	if (!wait_for_completion_timeout(&vmbus_connection.all_offers_delivered_event,
+					 secs_to_jiffies(60))) {
+		pr_warn("timed out waiting for all boot-time offers to be delivered.\n");
+	}
+
+	/*
+	 * Flush handling of offer messages (which may initiate work on
+	 * other work queues).
+	 */
+	flush_workqueue(vmbus_connection.work_queue);
+
+	/*
+	 * Flush workqueue for processing the incoming offers. Subchannel
+	 * offers and their processing can happen later, so there is no need to
+	 * flush that workqueue here.
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
index fad31e30cd53..29780f3a7478 100644
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
+	 * Completed once the host has offered all boot-time channels.
+	 * Note that some channels may still be under process on a workqueue.
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
index 2892b8da20a5..bf5608a74056 100644
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
-		&vmbus_connection.ready_for_resume_event, secs_to_jiffies(10)) == 0)
-		pr_err("Some vmbus device is missing after suspending?\n");
-
 	/* Reset the event for the next suspend. */
 	reinit_completion(&vmbus_connection.ready_for_suspend_event);
 
-- 
2.43.0


