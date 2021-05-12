Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685EC37B77E
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 May 2021 10:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhELIIW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 May 2021 04:08:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51404 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhELIIW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 May 2021 04:08:22 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id C18F020B7178; Wed, 12 May 2021 01:07:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C18F020B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1620806834;
        bh=ONMUm9lGQb0L+PrjIyabqO4fxeAhk5qGinvEBfGFW50=;
        h=From:To:Cc:Subject:Date:From;
        b=V8O3IdMmNHNOqBI7ZYNB9Gp6GBaxst/A9k6HOUoYKz0QZOkrdJ3CjglMrYocF8LGr
         3b0qKQrCEsX+Akyjd7idsv+oJF2w8n0RMRP0VvE60Br6JpdHR+9/mzDAxjAImjdudf
         AkMYKifl3pDBTAOaXrP8TXOiChUP6g8nflX060gE=
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
Subject: [PATCH] PCI: hv: Move completion variable from stack to heap in hv_compose_msi_msg()
Date:   Wed, 12 May 2021 01:07:04 -0700
Message-Id: <1620806824-31151-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

hv_compose_msi_msg() may be called with interrupt disabled. It calls
wait_for_completion() in a loop and may exit the loop earlier if the device is
being ejected or it's hitting other errors. However the VSP may send
completion packet after the loop exit and the completion variable is no
longer valid on the stack. This results in a kernel oops.

Fix this by relocating completion variable from stack to heap, and use hbus
to maintain a list of leftover completions for future cleanup if necessary.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 97 +++++++++++++++++++----------
 1 file changed, 65 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9499ae3275fe..29fe26e2193c 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -473,6 +473,9 @@ struct hv_pcibus_device {
 	struct msi_controller msi_chip;
 	struct irq_domain *irq_domain;
 
+	struct list_head compose_msi_msg_ctxt_list;
+	spinlock_t compose_msi_msg_ctxt_list_lock;
+
 	spinlock_t retarget_msi_interrupt_lock;
 
 	struct workqueue_struct *wq;
@@ -552,6 +555,17 @@ struct hv_pci_compl {
 	s32 completion_status;
 };
 
+struct compose_comp_ctxt {
+	struct hv_pci_compl comp_pkt;
+	struct tran_int_desc int_desc;
+};
+
+struct compose_msi_msg_ctxt {
+	struct list_head list;
+	struct pci_packet pci_pkt;
+	struct compose_comp_ctxt comp;
+};
+
 static void hv_pci_onchannelcallback(void *context);
 
 /**
@@ -1293,11 +1307,6 @@ static void hv_irq_unmask(struct irq_data *data)
 	pci_msi_unmask_irq(data);
 }
 
-struct compose_comp_ctxt {
-	struct hv_pci_compl comp_pkt;
-	struct tran_int_desc int_desc;
-};
-
 static void hv_pci_compose_compl(void *context, struct pci_response *resp,
 				 int resp_packet_size)
 {
@@ -1373,16 +1382,12 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
 	struct cpumask *dest;
-	struct compose_comp_ctxt comp;
 	struct tran_int_desc *int_desc;
-	struct {
-		struct pci_packet pci_pkt;
-		union {
-			struct pci_create_interrupt v1;
-			struct pci_create_interrupt2 v2;
-		} int_pkts;
-	} __packed ctxt;
-
+	struct compose_msi_msg_ctxt *ctxt;
+	union {
+		struct pci_create_interrupt v1;
+		struct pci_create_interrupt2 v2;
+	} int_pkts;
 	u32 size;
 	int ret;
 
@@ -1402,18 +1407,24 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		hv_int_desc_free(hpdev, int_desc);
 	}
 
+	ctxt = kzalloc(sizeof(*ctxt), GFP_ATOMIC);
+	if (!ctxt)
+		goto drop_reference;
+
 	int_desc = kzalloc(sizeof(*int_desc), GFP_ATOMIC);
-	if (!int_desc)
+	if (!int_desc) {
+		kfree(ctxt);
 		goto drop_reference;
+	}
 
-	memset(&ctxt, 0, sizeof(ctxt));
-	init_completion(&comp.comp_pkt.host_event);
-	ctxt.pci_pkt.completion_func = hv_pci_compose_compl;
-	ctxt.pci_pkt.compl_ctxt = &comp;
+	memset(ctxt, 0, sizeof(*ctxt));
+	init_completion(&ctxt->comp.comp_pkt.host_event);
+	ctxt->pci_pkt.completion_func = hv_pci_compose_compl;
+	ctxt->pci_pkt.compl_ctxt = &ctxt->comp;
 
 	switch (hbus->protocol_version) {
 	case PCI_PROTOCOL_VERSION_1_1:
-		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
+		size = hv_compose_msi_req_v1(&int_pkts.v1,
 					dest,
 					hpdev->desc.win_slot.slot,
 					cfg->vector);
@@ -1421,7 +1432,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	case PCI_PROTOCOL_VERSION_1_2:
 	case PCI_PROTOCOL_VERSION_1_3:
-		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
+		size = hv_compose_msi_req_v2(&int_pkts.v2,
 					dest,
 					hpdev->desc.win_slot.slot,
 					cfg->vector);
@@ -1434,17 +1445,18 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		 */
 		dev_err(&hbus->hdev->device,
 			"Unexpected vPCI protocol, update driver.");
+		kfree(ctxt);
 		goto free_int_desc;
 	}
 
-	ret = vmbus_sendpacket(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
-			       size, (unsigned long)&ctxt.pci_pkt,
+	ret = vmbus_sendpacket(hpdev->hbus->hdev->channel, &int_pkts,
+			       size, (unsigned long)&ctxt->pci_pkt,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret) {
 		dev_err(&hbus->hdev->device,
-			"Sending request for interrupt failed: 0x%x",
-			comp.comp_pkt.completion_status);
+			"Sending request for interrupt failed: 0x%x", ret);
+		kfree(ctxt);
 		goto free_int_desc;
 	}
 
@@ -1458,7 +1470,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	 * Since this function is called with IRQ locks held, can't
 	 * do normal wait for completion; instead poll.
 	 */
-	while (!try_wait_for_completion(&comp.comp_pkt.host_event)) {
+	while (!try_wait_for_completion(&ctxt->comp.comp_pkt.host_event)) {
 		unsigned long flags;
 
 		/* 0xFFFF means an invalid PCI VENDOR ID. */
@@ -1494,10 +1506,11 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	tasklet_enable(&channel->callback_event);
 
-	if (comp.comp_pkt.completion_status < 0) {
+	if (ctxt->comp.comp_pkt.completion_status < 0) {
 		dev_err(&hbus->hdev->device,
 			"Request for interrupt failed: 0x%x",
-			comp.comp_pkt.completion_status);
+			ctxt->comp.comp_pkt.completion_status);
+		kfree(ctxt);
 		goto free_int_desc;
 	}
 
@@ -1506,23 +1519,36 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	 * irq_set_chip_data() here would be appropriate, but the lock it takes
 	 * is already held.
 	 */
-	*int_desc = comp.int_desc;
+	*int_desc = ctxt->comp.int_desc;
 	data->chip_data = int_desc;
 
 	/* Pass up the result. */
-	msg->address_hi = comp.int_desc.address >> 32;
-	msg->address_lo = comp.int_desc.address & 0xffffffff;
-	msg->data = comp.int_desc.data;
+	msg->address_hi = ctxt->comp.int_desc.address >> 32;
+	msg->address_lo = ctxt->comp.int_desc.address & 0xffffffff;
+	msg->data = ctxt->comp.int_desc.data;
 
 	put_pcichild(hpdev);
+	kfree(ctxt);
 	return;
 
 enable_tasklet:
 	tasklet_enable(&channel->callback_event);
+
+	/*
+	 * Move uncompleted context to the leftover list.
+	 * The host may send completion at a later time, and we ignore this
+	 * completion but keep the memory reference valid.
+	 */
+	spin_lock(&hbus->compose_msi_msg_ctxt_list_lock);
+	list_add_tail(&ctxt->list, &hbus->compose_msi_msg_ctxt_list);
+	spin_unlock(&hbus->compose_msi_msg_ctxt_list_lock);
+
 free_int_desc:
 	kfree(int_desc);
+
 drop_reference:
 	put_pcichild(hpdev);
+
 return_null_message:
 	msg->address_hi = 0;
 	msg->address_lo = 0;
@@ -3076,9 +3102,11 @@ static int hv_pci_probe(struct hv_device *hdev,
 	INIT_LIST_HEAD(&hbus->children);
 	INIT_LIST_HEAD(&hbus->dr_list);
 	INIT_LIST_HEAD(&hbus->resources_for_children);
+	INIT_LIST_HEAD(&hbus->compose_msi_msg_ctxt_list);
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
+	spin_lock_init(&hbus->compose_msi_msg_ctxt_list_lock);
 	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
 					   hbus->sysdata.domain);
 	if (!hbus->wq) {
@@ -3282,6 +3310,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 static int hv_pci_remove(struct hv_device *hdev)
 {
 	struct hv_pcibus_device *hbus;
+	struct compose_msi_msg_ctxt *ctxt, *tmp;
 	int ret;
 
 	hbus = hv_get_drvdata(hdev);
@@ -3318,6 +3347,10 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 	hv_put_dom_num(hbus->sysdata.domain);
 
+	list_for_each_entry_safe(ctxt, tmp, &hbus->compose_msi_msg_ctxt_list, list) {
+		list_del(&ctxt->list);
+		kfree(ctxt);
+	}
 	kfree(hbus);
 	return ret;
 }
-- 
2.27.0

