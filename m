Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA67B16F6C1
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Feb 2020 06:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgBZFGP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Feb 2020 00:06:15 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46620 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFGP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Feb 2020 00:06:15 -0500
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 16AAE2007682; Tue, 25 Feb 2020 21:06:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16AAE2007682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1582693573;
        bh=hlRUdAVX3wkkEvhxQ0g5cLC1pC4DW7vjuNNBNi2C4zw=;
        h=From:To:Cc:Subject:Date:From;
        b=GfNSYy4QyOY61lNClJNafG0vUD1g7JYqzNK94hJX8LDmGi2TKHBs2tnGsmF1lO+7C
         fNCMqQR1NML0SU6UXvergDI8KXfAorvJpk9PeYqYufYpSDA3P4mvJ4w3FlNlqFG/Eq
         wBMWrL/WoQLSdBBD3ZaTGLwg8Q/z6TFXMmENEaOY=
From:   longli@linuxonhyperv.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v5 1/2] PCI: hv: Decouple the func definition in hv_dr_state from VSP message
Date:   Tue, 25 Feb 2020 21:06:07 -0800
Message-Id: <1582693568-64759-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

hv_dr_state is used to find present PCI devices on the bus. The structure
reuses struct pci_function_description from VSP message to describe a
device.

To prepare support for pci_function_description v2, decouple this
dependence in hv_dr_state so it can work with both v1 and v2 VSP messages.

There is no functionality change.

Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
Changes
v2: Changed some spaces to tabs, changed failure code to -ENOMEM
v3: Revised comment for function hv_pci_devices_present(), reformatted patch title
v4: Fixed spelling
v5: Rebased to current tree

 drivers/pci/controller/pci-hyperv.c | 100 +++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 15011a3..dea197f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -505,10 +505,24 @@ struct hv_dr_work {
 	struct hv_pcibus_device *bus;
 };
 
+struct hv_pcidev_description {
+	u16	v_id;	/* vendor ID */
+	u16	d_id;	/* device ID */
+	u8	rev;
+	u8	prog_intf;
+	u8	subclass;
+	u8	base_class;
+	u32	subsystem_id;
+	union	win_slot_encoding win_slot;
+	u32	ser;	/* serial number */
+	u32	flags;
+	u16	virtual_numa_node;
+};
+
 struct hv_dr_state {
 	struct list_head list_entry;
 	u32 device_count;
-	struct pci_function_description func[0];
+	struct hv_pcidev_description func[0];
 };
 
 enum hv_pcichild_state {
@@ -525,7 +539,7 @@ struct hv_pci_dev {
 	refcount_t refs;
 	enum hv_pcichild_state state;
 	struct pci_slot *pci_slot;
-	struct pci_function_description desc;
+	struct hv_pcidev_description desc;
 	bool reported_missing;
 	struct hv_pcibus_device *hbus;
 	struct work_struct wrk;
@@ -1877,7 +1891,7 @@ static void q_resource_requirements(void *context, struct pci_response *resp,
  * Return: Pointer to the new tracking struct
  */
 static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
-		struct pci_function_description *desc)
+		struct hv_pcidev_description *desc)
 {
 	struct hv_pci_dev *hpdev;
 	struct pci_child_message *res_req;
@@ -1988,7 +2002,7 @@ static void pci_devices_present_work(struct work_struct *work)
 {
 	u32 child_no;
 	bool found;
-	struct pci_function_description *new_desc;
+	struct hv_pcidev_description *new_desc;
 	struct hv_pci_dev *hpdev;
 	struct hv_pcibus_device *hbus;
 	struct list_head removed;
@@ -2107,17 +2121,15 @@ static void pci_devices_present_work(struct work_struct *work)
 }
 
 /**
- * hv_pci_devices_present() - Handles list of new children
+ * hv_pci_start_relations_work() - Queue work to start device discovery
  * @hbus:	Root PCI bus, as understood by this driver
- * @relations:	Packet from host listing children
+ * @dr:		The list of children returned from host
  *
- * This function is invoked whenever a new list of devices for
- * this bus appears.
+ * Return:  0 on success, -errno on failure
  */
-static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
-				   struct pci_bus_relations *relations)
+static int hv_pci_start_relations_work(struct hv_pcibus_device *hbus,
+				       struct hv_dr_state *dr)
 {
-	struct hv_dr_state *dr;
 	struct hv_dr_work *dr_wrk;
 	unsigned long flags;
 	bool pending_dr;
@@ -2125,29 +2137,15 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 	if (hbus->state == hv_pcibus_removing) {
 		dev_info(&hbus->hdev->device,
 			 "PCI VMBus BUS_RELATIONS: ignored\n");
-		return;
+		return -ENOENT;
 	}
 
 	dr_wrk = kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
 	if (!dr_wrk)
-		return;
-
-	dr = kzalloc(offsetof(struct hv_dr_state, func) +
-		     (sizeof(struct pci_function_description) *
-		      (relations->device_count)), GFP_NOWAIT);
-	if (!dr)  {
-		kfree(dr_wrk);
-		return;
-	}
+		return -ENOMEM;
 
 	INIT_WORK(&dr_wrk->wrk, pci_devices_present_work);
 	dr_wrk->bus = hbus;
-	dr->device_count = relations->device_count;
-	if (dr->device_count != 0) {
-		memcpy(dr->func, relations->func,
-		       sizeof(struct pci_function_description) *
-		       dr->device_count);
-	}
 
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	/*
@@ -2165,6 +2163,47 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 		get_hvpcibus(hbus);
 		queue_work(hbus->wq, &dr_wrk->wrk);
 	}
+
+	return 0;
+}
+
+/**
+ * hv_pci_devices_present() - Handle list of new children
+ * @hbus:      Root PCI bus, as understood by this driver
+ * @relations: Packet from host listing children
+ *
+ * Process a new list of devices on the bus. The list of devices is
+ * discovered by VSP and sent to us via VSP message PCI_BUS_RELATIONS,
+ * whenever a new list of devices for this bus appears.
+ */
+static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
+				   struct pci_bus_relations *relations)
+{
+	struct hv_dr_state *dr;
+	int i;
+
+	dr = kzalloc(offsetof(struct hv_dr_state, func) +
+		     (sizeof(struct hv_pcidev_description) *
+		      (relations->device_count)), GFP_NOWAIT);
+
+	if (!dr)
+		return;
+
+	dr->device_count = relations->device_count;
+	for (i = 0; i < dr->device_count; i++) {
+		dr->func[i].v_id = relations->func[i].v_id;
+		dr->func[i].d_id = relations->func[i].d_id;
+		dr->func[i].rev = relations->func[i].rev;
+		dr->func[i].prog_intf = relations->func[i].prog_intf;
+		dr->func[i].subclass = relations->func[i].subclass;
+		dr->func[i].base_class = relations->func[i].base_class;
+		dr->func[i].subsystem_id = relations->func[i].subsystem_id;
+		dr->func[i].win_slot = relations->func[i].win_slot;
+		dr->func[i].ser = relations->func[i].ser;
+	}
+
+	if (hv_pci_start_relations_work(hbus, dr))
+		kfree(dr);
 }
 
 /**
@@ -3069,7 +3108,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
 		struct pci_packet teardown_packet;
 		u8 buffer[sizeof(struct pci_message)];
 	} pkt;
-	struct pci_bus_relations relations;
+	struct hv_dr_state *dr;
 	struct hv_pci_compl comp_pkt;
 	int ret;
 
@@ -3082,8 +3121,9 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
 
 	if (!hibernating) {
 		/* Delete any children which might still exist. */
-		memset(&relations, 0, sizeof(relations));
-		hv_pci_devices_present(hbus, &relations);
+		dr = kzalloc(sizeof(*dr), GFP_KERNEL);
+		if (dr && hv_pci_start_relations_work(hbus, dr))
+			kfree(dr);
 	}
 
 	ret = hv_send_resources_released(hdev);
-- 
1.8.3.1

