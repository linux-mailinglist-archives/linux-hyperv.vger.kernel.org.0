Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86DD36796C
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Apr 2021 07:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhDVFq3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Apr 2021 01:46:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42554 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhDVFq2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Apr 2021 01:46:28 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 0BA8B20B8001; Wed, 21 Apr 2021 22:45:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0BA8B20B8001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1619070354;
        bh=da4GAf5UT4cTq4OpWKzAi6K3OXaw1sj8a0ojyk2KlE0=;
        h=From:To:Cc:Subject:Date:From;
        b=j0HHmoCgIxUpJmdxRXuVAmQoF8H9u0P8y3foPlLj2cqRa2dcDo3T4D8t3aj7T5L6K
         1TbuORoK4uYTJTkTBJ1g4b9+qTNwjY6hNJhY20wrmtNJKDftd+OlTLt8Z/HxiKelLj
         7GUGQcmk8bOvOppDsFTXOfouAyXF6PX9RfBFVKSI=
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
Subject: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the device
Date:   Wed, 21 Apr 2021 22:45:45 -0700
Message-Id: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
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

Fix this by flushing/stopping the workqueue of hbus before doing hbus remove.

Signed-off-by: Long Li <longli@microsoft.com>
---

Change in v2: Remove unused bus state hv_pcibus_removed

 drivers/pci/controller/pci-hyperv.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 27a17a1e4a7c..fc948a2ed703 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -444,7 +444,6 @@ enum hv_pcibus_state {
 	hv_pcibus_probed,
 	hv_pcibus_installed,
 	hv_pcibus_removing,
-	hv_pcibus_removed,
 	hv_pcibus_maximum
 };
 
@@ -3305,13 +3304,22 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 	hbus = hv_get_drvdata(hdev);
 	if (hbus->state == hv_pcibus_installed) {
+		tasklet_disable(&hdev->channel->callback_event);
+		hbus->state = hv_pcibus_removing;
+		tasklet_enable(&hdev->channel->callback_event);
+		destroy_workqueue(hbus->wq);
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
@@ -3326,7 +3334,6 @@ static int hv_pci_remove(struct hv_device *hdev)
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
-	destroy_workqueue(hbus->wq);
 
 	hv_put_dom_num(hbus->sysdata.domain);
 
-- 
2.27.0

