Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3073B37B779
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 May 2021 10:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhELIID (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 May 2021 04:08:03 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51312 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhELIIA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 May 2021 04:08:00 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id E977920B7178; Wed, 12 May 2021 01:06:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E977920B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1620806812;
        bh=WLJTTpiddylx0coDo9QIv6P+OA6IRCluOS4wXCiLTio=;
        h=From:To:Cc:Subject:Date:From;
        b=rD7KzrvGJM8wfdXyL2yu3OAP96tULI/mFlF2Esc7HMECeysK09ksET21Dttzksx9z
         Qejlj/R+GGpSNqhQspB+mara7OEYySCLjUQNXZOlYAO9tXQ/q/qcCvc/lSAkESapMY
         hkTnaHPJw3ILNKkyRB6VWqyhJ7c69PWuFcuWurjM=
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
Subject: [Patch v3 2/2] PCI: hv: Remove unused refcount and supporting functions for handling bus device removal
Date:   Wed, 12 May 2021 01:06:49 -0700
Message-Id: <1620806809-31055-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

With the new method of flushing/stopping the workqueue before doing bus
removal, the old mechanism of using refcount and wait for completion
is no longer needed. Remove those dead code.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 34 +++--------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index c6122a1b0c46..9499ae3275fe 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -452,7 +452,6 @@ struct hv_pcibus_device {
 	/* Protocol version negotiated with the host */
 	enum pci_protocol_version_t protocol_version;
 	enum hv_pcibus_state state;
-	refcount_t remove_lock;
 	struct hv_device *hdev;
 	resource_size_t low_mmio_space;
 	resource_size_t high_mmio_space;
@@ -460,7 +459,6 @@ struct hv_pcibus_device {
 	struct resource *low_mmio_res;
 	struct resource *high_mmio_res;
 	struct completion *survey_event;
-	struct completion remove_event;
 	struct pci_bus *pci_bus;
 	spinlock_t config_lock;	/* Avoid two threads writing index page */
 	spinlock_t device_list_lock;	/* Protect lists below */
@@ -593,9 +591,6 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
 		kfree(hpdev);
 }
 
-static void get_hvpcibus(struct hv_pcibus_device *hv_pcibus);
-static void put_hvpcibus(struct hv_pcibus_device *hv_pcibus);
-
 /*
  * There is no good way to get notified from vmbus_onoffer_rescind(),
  * so let's use polling here, since this is not a hot path.
@@ -2067,10 +2062,8 @@ static void pci_devices_present_work(struct work_struct *work)
 	}
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
-	if (!dr) {
-		put_hvpcibus(hbus);
+	if (!dr)
 		return;
-	}
 
 	/* First, mark all existing children as reported missing. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
@@ -2153,7 +2146,6 @@ static void pci_devices_present_work(struct work_struct *work)
 		break;
 	}
 
-	put_hvpcibus(hbus);
 	kfree(dr);
 }
 
@@ -2194,12 +2186,10 @@ static int hv_pci_start_relations_work(struct hv_pcibus_device *hbus,
 	list_add_tail(&dr->list_entry, &hbus->dr_list);
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
-	if (pending_dr) {
+	if (pending_dr)
 		kfree(dr_wrk);
-	} else {
-		get_hvpcibus(hbus);
+	else
 		queue_work(hbus->wq, &dr_wrk->wrk);
-	}
 
 	return 0;
 }
@@ -2342,8 +2332,6 @@ static void hv_eject_device_work(struct work_struct *work)
 	put_pcichild(hpdev);
 	put_pcichild(hpdev);
 	/* hpdev has been freed. Do not use it any more. */
-
-	put_hvpcibus(hbus);
 }
 
 /**
@@ -2367,7 +2355,6 @@ static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
 	hpdev->state = hv_pcichild_ejecting;
 	get_pcichild(hpdev);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
-	get_hvpcibus(hbus);
 	queue_work(hbus->wq, &hpdev->wrk);
 }
 
@@ -2967,17 +2954,6 @@ static int hv_send_resources_released(struct hv_device *hdev)
 	return 0;
 }
 
-static void get_hvpcibus(struct hv_pcibus_device *hbus)
-{
-	refcount_inc(&hbus->remove_lock);
-}
-
-static void put_hvpcibus(struct hv_pcibus_device *hbus)
-{
-	if (refcount_dec_and_test(&hbus->remove_lock))
-		complete(&hbus->remove_event);
-}
-
 #define HVPCI_DOM_MAP_SIZE (64 * 1024)
 static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
 
@@ -3097,14 +3073,12 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus->sysdata.domain = dom;
 
 	hbus->hdev = hdev;
-	refcount_set(&hbus->remove_lock, 1);
 	INIT_LIST_HEAD(&hbus->children);
 	INIT_LIST_HEAD(&hbus->dr_list);
 	INIT_LIST_HEAD(&hbus->resources_for_children);
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
-	init_completion(&hbus->remove_event);
 	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
 					   hbus->sysdata.domain);
 	if (!hbus->wq) {
@@ -3341,8 +3315,6 @@ static int hv_pci_remove(struct hv_device *hdev)
 	hv_pci_free_bridge_windows(hbus);
 	irq_domain_remove(hbus->irq_domain);
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
-	put_hvpcibus(hbus);
-	wait_for_completion(&hbus->remove_event);
 
 	hv_put_dom_num(hbus->sysdata.domain);
 
-- 
2.27.0

