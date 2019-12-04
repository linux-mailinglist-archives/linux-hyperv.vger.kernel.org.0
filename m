Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 330E411219D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2019 03:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLDCxq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Dec 2019 21:53:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56184 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfLDCxp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Dec 2019 21:53:45 -0500
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 85E9C20B7185; Tue,  3 Dec 2019 18:53:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85E9C20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1575428024;
        bh=zD1VstL0WWSJSKj5SLiHaiJQUWQv4EYx/XzCCkUI55M=;
        h=From:To:Cc:Subject:Date:From;
        b=BAfTP3DzVUstbG73/BnjLOO5qJrpcdA3S5NS13M4GCMPWJ6zZLH9DlwSxgkEz+hdP
         Yl/pffxS5f9ySpS4oPyfbeKqFiZHpox56srxIFaMRS+04eCneG1VhEuDDZTZT0RfIF
         asCBnaeYbZBSxtUFvUiNVNc20Vx/C6KBmkC2VFCE=
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
Subject: [Patch v2 1/2] PCI: hv: decouple the func definition in hv_dr_state from VSP message
Date:   Tue,  3 Dec 2019 18:53:36 -0800
Message-Id: <1575428017-87914-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

hv_dr_state is used to find present PCI devices on the bus. The structure
reuses struct pci_function_description from VSP message to describe a device.

To prepare support for pci_function_description v2, we need to decouple this
dependence in hv_dr_state so it can work with both v1 and v2 VSP messages.

There is no functionality change.

Signed-off-by: Long Li <longli@microsoft.com>
---

Changes
v2: changed some spaces to tabs, changed failure code to -ENOMEM

 drivers/pci/controller/pci-hyperv.c | 100 +++++++++++++++++++---------
 1 file changed, 69 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index f1f300218fab..8c1533be6ad0 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -507,10 +507,24 @@ struct hv_dr_work {
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
@@ -527,7 +541,7 @@ struct hv_pci_dev {
 	refcount_t refs;
 	enum hv_pcichild_state state;
 	struct pci_slot *pci_slot;
-	struct pci_function_description desc;
+	struct hv_pcidev_description desc;
 	bool reported_missing;
 	struct hv_pcibus_device *hbus;
 	struct work_struct wrk;
@@ -1862,7 +1876,7 @@ static void q_resource_requirements(void *context, struct pci_response *resp,
  * Return: Pointer to the new tracking struct
  */
 static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
-		struct pci_function_description *desc)
+		struct hv_pcidev_description *desc)
 {
 	struct hv_pci_dev *hpdev;
 	struct pci_child_message *res_req;
@@ -1973,7 +1987,7 @@ static void pci_devices_present_work(struct work_struct *work)
 {
 	u32 child_no;
 	bool found;
-	struct pci_function_description *new_desc;
+	struct hv_pcidev_description *new_desc;
 	struct hv_pci_dev *hpdev;
 	struct hv_pcibus_device *hbus;
 	struct list_head removed;
@@ -2090,43 +2104,26 @@ static void pci_devices_present_work(struct work_struct *work)
 	put_hvpcibus(hbus);
 	kfree(dr);
 }
-
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
-	unsigned long flags;
 	bool pending_dr;
+	unsigned long flags;
 
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
@@ -2144,6 +2141,46 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 		get_hvpcibus(hbus);
 		queue_work(hbus->wq, &dr_wrk->wrk);
 	}
+
+	return 0;
+}
+
+/**
+ * hv_pci_devices_present() - Handles list of new children
+ * @hbus:	Root PCI bus, as understood by this driver
+ * @relations:	Packet from host listing children
+ *
+ * This function is invoked whenever a new list of devices for
+ * this bus appears.
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
@@ -3018,7 +3055,7 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
 		struct pci_packet teardown_packet;
 		u8 buffer[sizeof(struct pci_message)];
 	} pkt;
-	struct pci_bus_relations relations;
+	struct hv_dr_state *dr;
 	struct hv_pci_compl comp_pkt;
 	int ret;
 
@@ -3030,8 +3067,9 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
 		return;
 
 	/* Delete any children which might still exist. */
-	memset(&relations, 0, sizeof(relations));
-	hv_pci_devices_present(hbus, &relations);
+	dr = kzalloc(sizeof(*dr), GFP_KERNEL);
+	if (dr && hv_pci_start_relations_work(hbus, dr))
+		kfree(dr);
 
 	ret = hv_send_resources_released(hdev);
 	if (ret)
-- 
2.17.1

