Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7A416F6C6
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Feb 2020 06:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgBZFGU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Feb 2020 00:06:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46666 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFGU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Feb 2020 00:06:20 -0500
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 8AA9A20B9C02; Tue, 25 Feb 2020 21:06:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AA9A20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1582693579;
        bh=M6hAL6bQfxjrPXP140hZfjRPROZHNA6CpObT49X0+tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqKv9zdkt58H9X3/JIBEnJ7qiQQoSts3UJ49vu0XqIqWkytMSF8Koa5UFpNWQPaBt
         WICAytpGcffct63rhLa8KJzL3rvz/AqXOUloaWigo1PITUCPwMrbp3elkIypM56JcF
         Pgn+lQMgLYAHF848sxvNNG2kgwGfAFoZSDoBE0e8=
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
Subject: [Patch v5 2/2] PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2
Date:   Tue, 25 Feb 2020 21:06:08 -0800
Message-Id: <1582693568-64759-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582693568-64759-1-git-send-email-longli@linuxonhyperv.com>
References: <1582693568-64759-1-git-send-email-longli@linuxonhyperv.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Starting with Hyper-V PCI protocol version 1.3, the host VSP can send
PCI_BUS_RELATIONS2 and pass the vNUMA node information for devices on the
bus. The vNUMA node tells which guest NUMA node this device is on based
on guest VM configuration topology and physical device information.

Add code to negotiate v1.3 and process PCI_BUS_RELATIONS2.

Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
Changes
v2: Changed some spaces to tabs, added put_pcichild() after get_pcichild_wslot(), renamed pci_assign_numa_node() to hv_pci_assign_numa_node()
v4: Fixed spelling
v5: Fixed spelling, rebased to current tree

 drivers/pci/controller/pci-hyperv.c | 109 ++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index dea197f..98d3776 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -63,6 +63,7 @@
 enum pci_protocol_version_t {
 	PCI_PROTOCOL_VERSION_1_1 = PCI_MAKE_VERSION(1, 1),	/* Win10 */
 	PCI_PROTOCOL_VERSION_1_2 = PCI_MAKE_VERSION(1, 2),	/* RS1 */
+	PCI_PROTOCOL_VERSION_1_3 = PCI_MAKE_VERSION(1, 3),	/* Vibranium */
 };
 
 #define CPU_AFFINITY_ALL	-1ULL
@@ -72,6 +73,7 @@ enum pci_protocol_version_t {
  * first.
  */
 static enum pci_protocol_version_t pci_protocol_versions[] = {
+	PCI_PROTOCOL_VERSION_1_3,
 	PCI_PROTOCOL_VERSION_1_2,
 	PCI_PROTOCOL_VERSION_1_1,
 };
@@ -119,6 +121,7 @@ enum pci_message_type {
 	PCI_RESOURCES_ASSIGNED2		= PCI_MESSAGE_BASE + 0x16,
 	PCI_CREATE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x17,
 	PCI_DELETE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x18, /* unused */
+	PCI_BUS_RELATIONS2		= PCI_MESSAGE_BASE + 0x19,
 	PCI_MESSAGE_MAXIMUM
 };
 
@@ -164,6 +167,26 @@ struct pci_function_description {
 	u32	ser;	/* serial number */
 } __packed;
 
+enum pci_device_description_flags {
+	HV_PCI_DEVICE_FLAG_NONE			= 0x0,
+	HV_PCI_DEVICE_FLAG_NUMA_AFFINITY	= 0x1,
+};
+
+struct pci_function_description2 {
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
+	u16	reserved;
+} __packed;
+
 /**
  * struct hv_msi_desc
  * @vector:		IDT entry
@@ -299,6 +322,12 @@ struct pci_bus_relations {
 	struct pci_function_description func[0];
 } __packed;
 
+struct pci_bus_relations2 {
+	struct pci_incoming_message incoming;
+	u32 device_count;
+	struct pci_function_description2 func[0];
+} __packed;
+
 struct pci_q_res_req_response {
 	struct vmpacket_descriptor hdr;
 	s32 status;			/* negative values are failures */
@@ -1415,6 +1444,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		break;
 
 	case PCI_PROTOCOL_VERSION_1_2:
+	case PCI_PROTOCOL_VERSION_1_3:
 		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
 					dest,
 					hpdev->desc.win_slot.slot,
@@ -1813,6 +1843,27 @@ static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
 	}
 }
 
+/*
+ * Set NUMA node for the devices on the bus
+ */
+static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
+{
+	struct pci_dev *dev;
+	struct pci_bus *bus = hbus->pci_bus;
+	struct hv_pci_dev *hv_dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		hv_dev = get_pcichild_wslot(hbus, devfn_to_wslot(dev->devfn));
+		if (!hv_dev)
+			continue;
+
+		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
+			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
+
+		put_pcichild(hv_dev);
+	}
+}
+
 /**
  * create_root_hv_pci_bus() - Expose a new root PCI bus
  * @hbus:	Root PCI bus, as understood by this driver
@@ -1835,6 +1886,7 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 
 	pci_lock_rescan_remove();
 	pci_scan_child_bus(hbus->pci_bus);
+	hv_pci_assign_numa_node(hbus);
 	pci_bus_assign_resources(hbus->pci_bus);
 	hv_pci_assign_slots(hbus);
 	pci_bus_add_devices(hbus->pci_bus);
@@ -2103,6 +2155,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 */
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->pci_bus);
+		hv_pci_assign_numa_node(hbus);
 		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
 		break;
@@ -2207,6 +2260,46 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 }
 
 /**
+ * hv_pci_devices_present2() - Handle list of new children
+ * @hbus:	Root PCI bus, as understood by this driver
+ * @relations:	Packet from host listing children
+ *
+ * This function is the v2 version of hv_pci_devices_present()
+ */
+static void hv_pci_devices_present2(struct hv_pcibus_device *hbus,
+				    struct pci_bus_relations2 *relations)
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
+		dr->func[i].flags = relations->func[i].flags;
+		dr->func[i].virtual_numa_node =
+			relations->func[i].virtual_numa_node;
+	}
+
+	if (hv_pci_start_relations_work(hbus, dr))
+		kfree(dr);
+}
+
+/**
  * hv_eject_device_work() - Asynchronously handles ejection
  * @work:	Work struct embedded in internal device struct
  *
@@ -2319,6 +2412,7 @@ static void hv_pci_onchannelcallback(void *context)
 	struct pci_response *response;
 	struct pci_incoming_message *new_message;
 	struct pci_bus_relations *bus_rel;
+	struct pci_bus_relations2 *bus_rel2;
 	struct pci_dev_inval_block *inval;
 	struct pci_dev_incoming *dev_message;
 	struct hv_pci_dev *hpdev;
@@ -2386,6 +2480,21 @@ static void hv_pci_onchannelcallback(void *context)
 				hv_pci_devices_present(hbus, bus_rel);
 				break;
 
+			case PCI_BUS_RELATIONS2:
+
+				bus_rel2 = (struct pci_bus_relations2 *)buffer;
+				if (bytes_recvd <
+				    offsetof(struct pci_bus_relations2, func) +
+				    (sizeof(struct pci_function_description2) *
+				     (bus_rel2->device_count))) {
+					dev_err(&hbus->hdev->device,
+						"bus relations v2 too small\n");
+					break;
+				}
+
+				hv_pci_devices_present2(hbus, bus_rel2);
+				break;
+
 			case PCI_EJECT:
 
 				dev_message = (struct pci_dev_incoming *)buffer;
-- 
1.8.3.1

