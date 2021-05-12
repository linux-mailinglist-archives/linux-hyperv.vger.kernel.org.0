Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ABD37B774
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 May 2021 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhELIHw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 May 2021 04:07:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51292 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhELIHv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 May 2021 04:07:51 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id CB0FA20B7178; Wed, 12 May 2021 01:06:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB0FA20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1620806803;
        bh=DrcN8Mc9KoSHKP7jY6XiaePM+j+mzg7Iow8prdIghf0=;
        h=From:To:Cc:Subject:Date:From;
        b=cpXXmKQzKjD8LAfx72n+KOFE+yatDg57u5PXrl4fc6zOflX6Xvn5eOHlpDRC8qXu3
         Px7AmTsB1dssov92YBP7y3GR9szkwWmoMGsraSXZW3V1EZanyDSP+1010G1S0/EMjf
         T7K08eSVyVtJdg567pPM3XkkoyoM1apRlw6z/meY=
From:   longli@linuxonhyperv.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 1/2] PCI: hv: Fix a race condition when removing the device
Date:   Wed, 12 May 2021 01:06:40 -0700
Message-Id: <1620806800-30983-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

On removing the device, any work item (hv_pci_devices_present() or
hv_pci_eject_device()) scheduled on workqueue hbus->wq may still be running
and race with hv_pci_remove().

This can happen because the host may send PCI_EJECT or PCI_BUS_RELATIONS(2)
and decide to rescind the channel immediately after that.

Fix this by flushing/destroying the workqueue of hbus before doing hbus remove.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change in v2: Remove unused bus state hv_pcibus_removed
Change in v3: Change hv_pci_bus_exit() to not use workqueue to remove PCI devices

 drivers/pci/controller/pci-hyperv.c | 30 ++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 27a17a1e4a7c..c6122a1b0c46 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -444,7 +444,6 @@ enum hv_pcibus_state {
 	hv_pcibus_probed,
 	hv_pcibus_installed,
 	hv_pcibus_removing,
-	hv_pcibus_removed,
 	hv_pcibus_maximum
 };
 
@@ -3247,8 +3246,9 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 		struct pci_packet teardown_packet;
 		u8 buffer[sizeof(struct pci_message)];
 	} pkt;
-	struct hv_dr_state *dr;
 	struct hv_pci_compl comp_pkt;
+	struct hv_pci_dev *hpdev, *tmp;
+	unsigned long flags;
 	int ret;
 
 	/*
@@ -3260,9 +3260,16 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 
 	if (!keep_devs) {
 		/* Delete any children which might still exist. */
-		dr = kzalloc(sizeof(*dr), GFP_KERNEL);
-		if (dr && hv_pci_start_relations_work(hbus, dr))
-			kfree(dr);
+		spin_lock_irqsave(&hbus->device_list_lock, flags);
+		list_for_each_entry_safe(hpdev, tmp, &hbus->children, list_entry) {
+			list_del(&hpdev->list_entry);
+			if (hpdev->pci_slot)
+				pci_destroy_slot(hpdev->pci_slot);
+			/* For the two refs got in new_pcichild_device() */
+			put_pcichild(hpdev);
+			put_pcichild(hpdev);
+		}
+		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 	}
 
 	ret = hv_send_resources_released(hdev);
@@ -3305,13 +3312,23 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 	hbus = hv_get_drvdata(hdev);
 	if (hbus->state == hv_pcibus_installed) {
+		tasklet_disable(&hdev->channel->callback_event);
+		hbus->state = hv_pcibus_removing;
+		tasklet_enable(&hdev->channel->callback_event);
+		destroy_workqueue(hbus->wq);
+		hbus->wq = NULL;
+		/*
+		 * At this point, no work is running or can be scheduled
+		 * on hbus-wq. We can't race with hv_pci_devices_present()
+		 * or hv_pci_eject_device(), it's safe to proceed.
+		 */
+
 		/* Remove the bus from PCI's point of view. */
 		pci_lock_rescan_remove();
 		pci_stop_root_bus(hbus->pci_bus);
 		hv_pci_remove_slots(hbus);
 		pci_remove_root_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
-		hbus->state = hv_pcibus_removed;
 	}
 
 	ret = hv_pci_bus_exit(hdev, false);
@@ -3326,7 +3343,6 @@ static int hv_pci_remove(struct hv_device *hdev)
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
-	destroy_workqueue(hbus->wq);
 
 	hv_put_dom_num(hbus->sysdata.domain);
 
-- 
2.27.0

