Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD713E0EC3
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 09:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhHEHAr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 03:00:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48604 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhHEHAq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 03:00:46 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 1B3C320B36E8; Thu,  5 Aug 2021 00:00:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B3C320B36E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1628146833;
        bh=8ZS3qjGMVs6QTqYWCjbIVHJG68fUEK73WxNFX/N/e88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IL/3MfEA1NOR257CrrfTVGRpSUkPAFZRMwd3FYMIGU5S7MvIqSq9To7SsTALVeG31
         uh4Vo/8UHV799RbMLhhw9j6SaHUnzazxG62fORkNyKIP7J6qLdWl3FdXQtk9rlDtnN
         GontWuq906VewSAtOv7zQ84jT9BBYmMHgorLLHMc=
From:   longli@linuxonhyperv.com
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: [Patch v5 1/3] Drivers: hv: vmbus: add support to ignore certain PCIE devices
Date:   Thu,  5 Aug 2021 00:00:10 -0700
Message-Id: <1628146812-29798-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Under certain configurations when Hyper-v presents a device to VMBUS, it
may have a VMBUS channel and a PCIe channel. The PCIe channel is not used
in Linux and does not have a backing PCIE device on Hyper-v. For such
devices, ignore those PCIe channels so they are not getting probed by the
PCI subsystem.

Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 48 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index caf6d0c..705e95d 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -26,6 +26,21 @@
 
 static void init_vp_index(struct vmbus_channel *channel);
 
+/*
+ * For some VMBUS devices, Hyper-v also presents certain PCIE devices as
+ * part of the host device implementation. Those devices have no real
+ * PCI implementation in Hyper-V, and should be ignored and not presented
+ * to the PCI layer.
+ */
+static const guid_t vpci_ignore_instances[] = {
+	/*
+	 * Azure Blob instance ID in VPCI
+	 * {d4573da2-2caa-4711-a8f9-bbabf4ee9685}
+	 */
+	GUID_INIT(0xd4573da2, 0x2caa, 0x4711, 0xa8, 0xf9,
+		  0xbb, 0xab, 0xf4, 0xee, 0x96, 0x85),
+};
+
 const struct vmbus_device vmbus_devs[] = {
 	/* IDE */
 	{ .dev_type = HV_IDE,
@@ -187,20 +202,19 @@ static bool is_unsupported_vmbus_devs(const guid_t *guid)
 	return false;
 }
 
-static u16 hv_get_dev_type(const struct vmbus_channel *channel)
+static u16 hv_get_dev_type(const guid_t *guid)
 {
-	const guid_t *guid = &channel->offermsg.offer.if_type;
 	u16 i;
 
-	if (is_hvsock_channel(channel) || is_unsupported_vmbus_devs(guid))
+	if (is_unsupported_vmbus_devs(guid))
 		return HV_UNKNOWN;
 
 	for (i = HV_IDE; i < HV_UNKNOWN; i++) {
 		if (guid_equal(guid, &vmbus_devs[i].guid))
-			return i;
+			return vmbus_devs[i].dev_type;
 	}
 	pr_info("Unknown GUID: %pUl\n", guid);
-	return i;
+	return HV_UNKNOWN;
 }
 
 /**
@@ -487,6 +501,16 @@ void vmbus_free_channels(void)
 	}
 }
 
+static bool ignore_pcie_device(guid_t *if_instance)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vpci_ignore_instances); i++)
+		if (guid_equal(&vpci_ignore_instances[i], if_instance))
+			return true;
+	return false;
+}
+
 /* Note: the function can run concurrently for primary/sub channels. */
 static void vmbus_add_channel_work(struct work_struct *work)
 {
@@ -910,7 +934,11 @@ static void vmbus_setup_channel_state(struct vmbus_channel *channel,
 	       sizeof(struct vmbus_channel_offer_channel));
 	channel->monitor_grp = (u8)offer->monitorid / 32;
 	channel->monitor_bit = (u8)offer->monitorid % 32;
-	channel->device_id = hv_get_dev_type(channel);
+	if (is_hvsock_channel(channel))
+		channel->device_id = HV_UNKNOWN;
+	else
+		channel->device_id =
+			hv_get_dev_type(&channel->offermsg.offer.if_type);
 }
 
 /*
@@ -972,6 +1000,14 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 
 	trace_vmbus_onoffer(offer);
 
+	/* Check to see if we should ignore this PCIe channel */
+	if (hv_get_dev_type(&offer->offer.if_type) == HV_PCIE &&
+	    ignore_pcie_device(&offer->offer.if_instance)) {
+		pr_debug("Ignore instance %pUl over VPCI\n",
+			 &offer->offer.if_instance);
+		return;
+	}
+
 	if (!vmbus_is_valid_device(&offer->offer.if_type)) {
 		pr_err_ratelimited("Invalid offer %d from the host supporting isolation\n",
 				   offer->child_relid);
-- 
1.8.3.1

