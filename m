Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331E939EB33
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jun 2021 03:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhFHBGl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Jun 2021 21:06:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45952 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHBGj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Jun 2021 21:06:39 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 1120B20B83DC; Mon,  7 Jun 2021 18:04:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1120B20B83DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1623114287;
        bh=3vxqkyGRhBaT7pcg0ehBPl+PLk3CkrLebAfbcTtqf8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfzcLpIA4wR3JtcKCcmn50qLVFKJA/ulA0KLNkzM4UEqC03xHnJI7wiWG6g8PkqAl
         MzN4Fz+2immwNDUVbuvo/xDNB9V05KDEpobg3lw71xvMW0BNhh6sWm347cKQS4lwet
         CwVh2MN0aAOMFQASSkM1XGWpaXWvcNeADFzcq9Wo=
From:   longli@linuxonhyperv.com
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 1/2] Drivers: hv: vmbus: add support to ignore certain PCIE devices
Date:   Mon,  7 Jun 2021 18:04:35 -0700
Message-Id: <1623114276-11696-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
References: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

When Hyper-v presents a FlexIOV device to VMBUS, this device has its VMBUS
channel and a PCIE channel. The PCIE channel is not used in Linux and does
not have a backing PCIE device on Hyper-v. For such FlexIOV devices, add
the code to ignore those PCIE devices so they are not getting probed by the
PCI subsystem.

Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index caf6d0c..6fd7ae5 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -26,6 +26,20 @@
 
 static void init_vp_index(struct vmbus_channel *channel);
 
+/*
+ * Hyper-v presents FlexIOV devices on the PCIE.
+ * Those devices have no real PCI implementation in Hyper-V, and should be
+ * ignored and not presented to the PCI layer.
+ */
+static const guid_t vpci_ignore_instances[] = {
+	/*
+	 * XStore Fastpath instance ID in VPCI introduced by FlexIOV
+	 * {d4573da2-2caa-4711-a8f9-bbabf4ee9685}
+	 */
+	GUID_INIT(0xd4573da2, 0x2caa, 0x4711, 0xa8, 0xf9,
+		0xbb, 0xab, 0xf4, 0xee, 0x96, 0x85),
+};
+
 const struct vmbus_device vmbus_devs[] = {
 	/* IDE */
 	{ .dev_type = HV_IDE,
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
@@ -958,6 +982,17 @@ static bool vmbus_is_valid_device(const guid_t *guid)
 	return false;
 }
 
+static bool is_pcie_offer(struct vmbus_channel_offer_channel *offer)
+{
+	int i;
+
+	for (i = HV_IDE; i < HV_UNKNOWN; i++)
+		if (guid_equal(&offer->offer.if_type, &vmbus_devs[i].guid))
+			break;
+
+	return i == HV_PCIE;
+}
+
 /*
  * vmbus_onoffer - Handler for channel offers from vmbus in parent partition.
  *
@@ -1051,6 +1086,14 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 		return;
 	}
 
+	/* Check to see if we should ignore this PCIe channel */
+	if (is_pcie_offer(offer) &&
+	    ignore_pcie_device(&offer->offer.if_instance)) {
+		pr_info("Ignore instance %pUl over VPCI\n",
+			&offer->offer.if_instance);
+		return;
+	}
+
 	/* Allocate the channel object and save this offer. */
 	newchannel = alloc_channel();
 	if (!newchannel) {
-- 
1.8.3.1

