Return-Path: <linux-hyperv+bounces-3343-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D699D0A0B
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Nov 2024 08:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4488DB2274B
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Nov 2024 07:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0086E14A0B9;
	Mon, 18 Nov 2024 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bS+l5ioK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180973477;
	Mon, 18 Nov 2024 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913657; cv=none; b=GgomeK0LMUbXHx0gwb2DyMYYJlCmi6SMw7fYXAGpN8d84m6Ay9HRtCgvzInAP2l8cLP9VXQWdd9PuTB+25oweznhhbXnlRcUy9RWthNmM7TftNBeTBU8W/qzzVrouL6UA/fuFl+/FyqJytJGp9kHhe7QnB6qS0rgkhsgoIDqKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913657; c=relaxed/simple;
	bh=7uW5/kuYCVnb394iW6l1LWKJC7EOuAJmEg3BWIv/3jI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUBOEazfts8wrVjZrZrmcn7IQH9ZNAlrNxFEoPImTKdOoOB4F+yQ92x4apkNEg6CWo+HyTiKkHblHsgnKwdsl1EyVjTeaCLMHKsVExqM0zQKIk3GKdTRw3Wi1z/I7hlqIGCybnEvRKo2eO0LUUWSlX05aqqwJCeLPzF+t4sTBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bS+l5ioK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.corp.microsoft.com (unknown [131.107.159.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id EEC19206BCE5;
	Sun, 17 Nov 2024 23:07:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEC19206BCE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731913650;
	bh=Ky/RlkVVduaqKohgLotz0DLu08Aee3H/S1H6DmThXSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bS+l5ioKFmkBmUrdBFib98K9R4/VGE+XAt2+KGzQ6GdqYXSdTh82pIrk/PCuuNPx9
	 XZq2ryOFiMXmRQt0TVZFI9rzLNZNi3x5/TpSZVQ0kTI5PFsHK7xY4TyRyw5L1ksXS6
	 0zuUmA5rX49LzkdjjvikGcUDM/eV3YUV07vSgbrM=
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
Subject: [PATCH v4 1/2] Drivers: hv: vmbus: Wait for boot-time offers during boot and resume
Date: Sun, 17 Nov 2024 23:07:24 -0800
Message-Id: <20241118070725.3221-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118070725.3221-1-namjain@linux.microsoft.com>
References: <20241118070725.3221-1-namjain@linux.microsoft.com>
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
---
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
index d2856023d53c..66160995519a 100644
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


