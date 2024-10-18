Return-Path: <linux-hyperv+bounces-3155-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DF69A3DA8
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 13:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3FEB23580
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988A22301;
	Fri, 18 Oct 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Zgp7pfVz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5B17C61;
	Fri, 18 Oct 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252701; cv=none; b=B0dvVfL106wuCIqTpHbqh+Dv/WDB+iBF/leCU85L7lLxq4+zKiQhnxTasDOxjBIYJpRJ1F2PioFaCNbiLTyO8dQEH4UrXrGaj4gF5PZPgVB1sHgNbDXt4+wOCZO9VsEVExjMO8h06mCQC/2SAV+xYn1eJ6wsCQdsnzUQtiBtSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252701; c=relaxed/simple;
	bh=YGAXuv4vpBvANdbwr/v9ZbCdCB90AepDrdWjSENjrGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4OpFIufd/d0q9+dQoZ5KeqjdTwcyYlquQxLt8cPNEeDqrZ/fUrVpTxE0yRD4iD6+AVHlOqVKu7z+OjdXmQscobiy9+o1XwZa1b/uWplu39YKdYWPMcFxRQQYDaJsDjmPF19NOgdO+y16JEn1ixTb5+Bdknj6wG8mwHS8d0tNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Zgp7pfVz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.corp.microsoft.com (unknown [131.107.147.150])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0C79D20FE9AB;
	Fri, 18 Oct 2024 04:58:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C79D20FE9AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729252698;
	bh=puHCziW+wtYlhrGuaO6qgn3UMg3ZZmZ85y/SDJsH2cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zgp7pfVzX3MVf6Z3UiTr365nfNuHh1PxO7V6iVnmZy3IiDOjBxVgN48c4dbDPFc4l
	 sx6u+chbXZzVCpikoiW8MTAlItq164R1rO0ICVEHphTro2TRFRUvOhoqeZmbRgKANP
	 2vTCLSrxZOi07Ds9YC9Fm7OZLgMgjqMTTw2NgRbA=
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
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
Date: Fri, 18 Oct 2024 04:58:10 -0700
Message-Id: <20241018115811.5530-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018115811.5530-1-namjain@linux.microsoft.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Channels offers are requested during vmbus initialization and resume
from hibernation. Add support to wait for all channel offers to be
delivered and processed before returning from vmbus_request_offers.
This is to support user mode (VTL0) in OpenHCL (A Linux based
paravisor for Confidential VMs) to ensure that all channel offers
are present when init begins in VTL0, and it knows which channels
the host has offered and which it has not.

This is in analogy to a PCI bus not returning from probe until it has
scanned all devices on the bus.

Without this, user mode can race with vmbus initialization and miss
channel offers. User mode has no way to work around this other than
sleeping for a while, since there is no way to know when vmbus has
finished processing offers.

With this added functionality, remove earlier logic which keeps track
of count of offered channels post resume from hibernation. Once all
offers delivered message is received, no further offers are going to
be received. Consequently, logic to prevent suspend from happening
after previous resume had missing offers, is also removed.

Co-developed-by: John Starks <jostarks@microsoft.com>
Signed-off-by: John Starks <jostarks@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/channel_mgmt.c | 38 +++++++++++++++++++++++---------------
 drivers/hv/connection.c   |  4 ++--
 drivers/hv/hyperv_vmbus.h | 14 +++-----------
 drivers/hv/vmbus_drv.c    | 16 ----------------
 4 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 3c6011a48dab..ac514805dafe 100644
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
@@ -1297,12 +1285,11 @@ EXPORT_SYMBOL_GPL(vmbus_hvsock_device_unregister);
 /*
  * vmbus_onoffers_delivered -
  * This is invoked when all offers have been delivered.
- *
- * Nothing to do here.
  */
 static void vmbus_onoffers_delivered(
 			struct vmbus_channel_message_header *hdr)
 {
+	complete(&vmbus_connection.all_offers_delivered_event);
 }
 
 /*
@@ -1578,7 +1565,8 @@ void vmbus_onmessage(struct vmbus_channel_message_header *hdr)
 }
 
 /*
- * vmbus_request_offers - Send a request to get all our pending offers.
+ * vmbus_request_offers - Send a request to get all our pending offers
+ * and wait for all offers to arrive.
  */
 int vmbus_request_offers(void)
 {
@@ -1596,6 +1584,10 @@ int vmbus_request_offers(void)
 
 	msg->msgtype = CHANNELMSG_REQUESTOFFERS;
 
+	/*
+	 * This REQUESTOFFERS message will result in the host sending an all
+	 * offers delivered message.
+	 */
 	ret = vmbus_post_msg(msg, sizeof(struct vmbus_channel_message_header),
 			     true);
 
@@ -1607,6 +1599,22 @@ int vmbus_request_offers(void)
 		goto cleanup;
 	}
 
+	/* Wait for the host to send all offers. */
+	while (wait_for_completion_timeout(
+		&vmbus_connection.all_offers_delivered_event, msecs_to_jiffies(10 * 1000)) == 0) {
+		pr_warn("timed out waiting for all offers to be delivered...\n");
+	}
+
+	/*
+	 * Flush handling of offer messages (which may initiate work on
+	 * other work queues).
+	 */
+	flush_workqueue(vmbus_connection.work_queue);
+
+	/* Flush processing the incoming offers. */
+	flush_workqueue(vmbus_connection.handle_primary_chan_wq);
+	flush_workqueue(vmbus_connection.handle_sub_chan_wq);
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


