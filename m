Return-Path: <linux-hyperv+bounces-5152-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53132A9CEB6
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 18:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CDF4A1123
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997C1E32D9;
	Fri, 25 Apr 2025 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLQOU3uM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4919A2A3;
	Fri, 25 Apr 2025 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599671; cv=none; b=oQseGlJJuyNa9bUZvk1lp9b4gFa2VxWI/eLyKlP6NlXdgCyNuTpL4iXfVFEprCEWFMbosuEMXQzxMRwUrYXOY46lA7uZUqLBig3SjMjv0MXy/uiYjlyytEdurXfBjrlVIAGW195EwAMP5fCEriyE88Bt/e5mE028gVdpz7WfWLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599671; c=relaxed/simple;
	bh=FFxelLyQhizUrgBRLtTl6Mt5QLcllVjsjcCtcjbSdXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j4bs5n4IG3NrbHC7VXb0mUcej+RaUZLjZ4xsve/b++5h3aBTyu+6PESO/CWX0E7OW2azUvagU6n9IEbHTS7xqkBkgb3v2FwVAiZ5R/3dAWegsRPsn+ixwt4r/o+IXvIWxYo0mcMlWvMT5bcWm9HLAYwZ0A42M5zPXbroYFK7g7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLQOU3uM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFA6C4CEE4;
	Fri, 25 Apr 2025 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745599671;
	bh=FFxelLyQhizUrgBRLtTl6Mt5QLcllVjsjcCtcjbSdXk=;
	h=Date:From:To:Cc:Subject:From;
	b=kLQOU3uMw/G3uqOs1AQd6/lwKpto5Wrl14h7srjhGFHtQVxqzUOWPG+vXU3CbR99G
	 V4Gnb7Uz/7mIiJNTCeyQ9jtsz6G2nfMqk7P4gw1hNB2pPAoEzP+FZGhgut8w6eH/eS
	 LeqwQ2ufHSQMxT6rfASiuEKW7KHsnY9ua/9czMX2GRJ0ooR/Gu2Py3bM+tt9tVWri4
	 OJPQZcABe9/SthiqNQ+gEB7w/AEBgHHxqf1mTsrcOrRCX89iGQGR0a71bm8y8QCRja
	 0Fu5h7+iMX9Pz+IgHbTG4KGdvpIY2++XDY2V90TkbTkjoaTZIi113VqmAFrRTOp1+9
	 ksrxgr/6aJvew==
Date: Fri, 25 Apr 2025 10:47:38 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] PCI: hv: Avoid multiple -Wflex-array-member-not-at-end
 warnings
Message-ID: <aAu8qsMQlbgH82iN@kspp>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for a few on-stack definitions
of a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warnings:

drivers/pci/controller/pci-hyperv.c:3809:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/pci/controller/pci-hyperv.c:2831:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/pci/controller/pci-hyperv.c:2468:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/pci/controller/pci-hyperv.c:1830:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/pci/controller/pci-hyperv.c:1593:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/pci/controller/pci-hyperv.c:1504:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/pci/controller/pci-hyperv.c:1424:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 126 ++++++++++++----------------
 1 file changed, 55 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e1eaa24559a2..f2b5036bcf64 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1420,10 +1420,8 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
 	struct hv_pcibus_device *hbus =
 		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
 			     sysdata);
-	struct {
-		struct pci_packet pkt;
-		char buf[sizeof(struct pci_read_block)];
-	} pkt;
+	DEFINE_RAW_FLEX(struct pci_packet, pkt, message,
+			sizeof(struct pci_read_block));
 	struct hv_read_config_compl comp_pkt;
 	struct pci_read_block *read_blk;
 	int ret;
@@ -1435,17 +1433,16 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
 	comp_pkt.buf = buf;
 	comp_pkt.len = len;
 
-	memset(&pkt, 0, sizeof(pkt));
-	pkt.pkt.completion_func = hv_pci_read_config_compl;
-	pkt.pkt.compl_ctxt = &comp_pkt;
-	read_blk = (struct pci_read_block *)&pkt.pkt.message;
+	pkt->completion_func = hv_pci_read_config_compl;
+	pkt->compl_ctxt = &comp_pkt;
+	read_blk = (struct pci_read_block *)pkt->message;
 	read_blk->message_type.type = PCI_READ_BLOCK;
 	read_blk->wslot.slot = devfn_to_wslot(pdev->devfn);
 	read_blk->block_id = block_id;
 	read_blk->bytes_requested = len;
 
 	ret = vmbus_sendpacket(hbus->hdev->channel, read_blk,
-			       sizeof(*read_blk), (unsigned long)&pkt.pkt,
+			       sizeof(*read_blk), (unsigned long)pkt,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret)
@@ -1500,11 +1497,8 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
 	struct hv_pcibus_device *hbus =
 		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
 			     sysdata);
-	struct {
-		struct pci_packet pkt;
-		char buf[sizeof(struct pci_write_block)];
-		u32 reserved;
-	} pkt;
+	DEFINE_RAW_FLEX(struct pci_packet, pkt, message,
+			sizeof(struct pci_write_block) + sizeof(u32));
 	struct hv_pci_compl comp_pkt;
 	struct pci_write_block *write_blk;
 	u32 pkt_size;
@@ -1515,10 +1509,9 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
 
 	init_completion(&comp_pkt.host_event);
 
-	memset(&pkt, 0, sizeof(pkt));
-	pkt.pkt.completion_func = hv_pci_write_config_compl;
-	pkt.pkt.compl_ctxt = &comp_pkt;
-	write_blk = (struct pci_write_block *)&pkt.pkt.message;
+	pkt->completion_func = hv_pci_write_config_compl;
+	pkt->compl_ctxt = &comp_pkt;
+	write_blk = (struct pci_write_block *)pkt->message;
 	write_blk->message_type.type = PCI_WRITE_BLOCK;
 	write_blk->wslot.slot = devfn_to_wslot(pdev->devfn);
 	write_blk->block_id = block_id;
@@ -1532,10 +1525,10 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
 	 * and new hosts, because, on them, what really matters is the length
 	 * specified in write_blk->byte_count.
 	 */
-	pkt_size += sizeof(pkt.reserved);
+	pkt_size += sizeof(u32);
 
 	ret = vmbus_sendpacket(hbus->hdev->channel, write_blk, pkt_size,
-			       (unsigned long)&pkt.pkt, VM_PKT_DATA_INBAND,
+			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret)
 		return ret;
@@ -1589,17 +1582,14 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
 			     struct tran_int_desc *int_desc)
 {
 	struct pci_delete_interrupt *int_pkt;
-	struct {
-		struct pci_packet pkt;
-		u8 buffer[sizeof(struct pci_delete_interrupt)];
-	} ctxt;
+	DEFINE_RAW_FLEX(struct pci_packet, pkt, message,
+			sizeof(struct pci_delete_interrupt));
 
 	if (!int_desc->vector_count) {
 		kfree(int_desc);
 		return;
 	}
-	memset(&ctxt, 0, sizeof(ctxt));
-	int_pkt = (struct pci_delete_interrupt *)&ctxt.pkt.message;
+	int_pkt = (struct pci_delete_interrupt *)pkt->message;
 	int_pkt->message_type.type =
 		PCI_DELETE_INTERRUPT_MESSAGE;
 	int_pkt->wslot.slot = hpdev->desc.win_slot.slot;
@@ -1798,6 +1788,12 @@ static u32 hv_compose_msi_req_v3(
 	return sizeof(*int_pkt);
 }
 
+union int_pkts {
+	struct pci_create_interrupt v1;
+	struct pci_create_interrupt2 v2;
+	struct pci_create_interrupt3 v3;
+};
+
 /**
  * hv_compose_msi_msg() - Supplies a valid MSI address/data
  * @data:	Everything about this MSI
@@ -1811,6 +1807,13 @@ static u32 hv_compose_msi_req_v3(
  */
 static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
+	DEFINE_RAW_FLEX(struct pci_packet, pkt, message, sizeof(union int_pkts));
+	struct pci_create_interrupt *pkt_v1 =
+				(struct pci_create_interrupt *)pkt->message;
+	struct pci_create_interrupt2 *pkt_v2 =
+				(struct pci_create_interrupt2 *)pkt->message;
+	struct pci_create_interrupt3 *pkt_v3 =
+				(struct pci_create_interrupt3 *)pkt->message;
 	struct hv_pcibus_device *hbus;
 	struct vmbus_channel *channel;
 	struct hv_pci_dev *hpdev;
@@ -1826,14 +1829,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	 */
 	u16 vector_count;
 	u32 vector;
-	struct {
-		struct pci_packet pci_pkt;
-		union {
-			struct pci_create_interrupt v1;
-			struct pci_create_interrupt2 v2;
-			struct pci_create_interrupt3 v3;
-		} int_pkts;
-	} __packed ctxt;
 	bool multi_msi;
 	u64 trans_id;
 	u32 size;
@@ -1910,14 +1905,13 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	 * can't exceed u8. Cast 'vector' down to u8 for v1/v2 explicitly
 	 * for better readability.
 	 */
-	memset(&ctxt, 0, sizeof(ctxt));
 	init_completion(&comp.comp_pkt.host_event);
-	ctxt.pci_pkt.completion_func = hv_pci_compose_compl;
-	ctxt.pci_pkt.compl_ctxt = &comp;
+	pkt->completion_func = hv_pci_compose_compl;
+	pkt->compl_ctxt = &comp;
 
 	switch (hbus->protocol_version) {
 	case PCI_PROTOCOL_VERSION_1_1:
-		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
+		size = hv_compose_msi_req_v1(pkt_v1,
 					hpdev->desc.win_slot.slot,
 					(u8)vector,
 					vector_count);
@@ -1925,7 +1919,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	case PCI_PROTOCOL_VERSION_1_2:
 	case PCI_PROTOCOL_VERSION_1_3:
-		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
+		size = hv_compose_msi_req_v2(pkt_v2,
 					cpu,
 					hpdev->desc.win_slot.slot,
 					(u8)vector,
@@ -1933,7 +1927,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		break;
 
 	case PCI_PROTOCOL_VERSION_1_4:
-		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
+		size = hv_compose_msi_req_v3(pkt_v3,
 					cpu,
 					hpdev->desc.win_slot.slot,
 					vector,
@@ -1950,8 +1944,8 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		goto free_int_desc;
 	}
 
-	ret = vmbus_sendpacket_getid(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
-				     size, (unsigned long)&ctxt.pci_pkt,
+	ret = vmbus_sendpacket_getid(hpdev->hbus->hdev->channel, pkt->message,
+				     size, (unsigned long)pkt,
 				     &trans_id, VM_PKT_DATA_INBAND,
 				     VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret) {
@@ -2034,7 +2028,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	 *
 	 * Cf. hv_pci_onchannelcallback().
 	 */
-	vmbus_request_addr_match(channel, trans_id, (unsigned long)&ctxt.pci_pkt);
+	vmbus_request_addr_match(channel, trans_id, (unsigned long)pkt);
 free_int_desc:
 	kfree(int_desc);
 drop_reference:
@@ -2464,10 +2458,8 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 	struct hv_pci_dev *hpdev;
 	struct pci_child_message *res_req;
 	struct q_res_req_compl comp_pkt;
-	struct {
-		struct pci_packet init_packet;
-		u8 buffer[sizeof(struct pci_child_message)];
-	} pkt;
+	DEFINE_RAW_FLEX(struct pci_packet, pkt, message,
+			sizeof(struct pci_child_message));
 	unsigned long flags;
 	int ret;
 
@@ -2477,18 +2469,17 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 
 	hpdev->hbus = hbus;
 
-	memset(&pkt, 0, sizeof(pkt));
 	init_completion(&comp_pkt.host_event);
 	comp_pkt.hpdev = hpdev;
-	pkt.init_packet.compl_ctxt = &comp_pkt;
-	pkt.init_packet.completion_func = q_resource_requirements;
-	res_req = (struct pci_child_message *)&pkt.init_packet.message;
+	pkt->compl_ctxt = &comp_pkt;
+	pkt->completion_func = q_resource_requirements;
+	res_req = (struct pci_child_message *)pkt->message;
 	res_req->message_type.type = PCI_QUERY_RESOURCE_REQUIREMENTS;
 	res_req->wslot.slot = desc->win_slot.slot;
 
 	ret = vmbus_sendpacket(hbus->hdev->channel, res_req,
-			       sizeof(struct pci_child_message),
-			       (unsigned long)&pkt.init_packet,
+			       __member_size(pkt->message),
+			       (unsigned long)pkt,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret)
@@ -2827,10 +2818,8 @@ static void hv_eject_device_work(struct work_struct *work)
 	struct pci_dev *pdev;
 	unsigned long flags;
 	int wslot;
-	struct {
-		struct pci_packet pkt;
-		u8 buffer[sizeof(struct pci_eject_response)];
-	} ctxt;
+	DEFINE_RAW_FLEX(struct pci_packet, pkt, message,
+			sizeof(struct pci_eject_response));
 
 	hpdev = container_of(work, struct hv_pci_dev, wrk);
 	hbus = hpdev->hbus;
@@ -2859,8 +2848,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	if (hpdev->pci_slot)
 		pci_destroy_slot(hpdev->pci_slot);
 
-	memset(&ctxt, 0, sizeof(ctxt));
-	ejct_pkt = (struct pci_eject_response *)&ctxt.pkt.message;
+	ejct_pkt = (struct pci_eject_response *)pkt->message;
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
 	ejct_pkt->wslot.slot = hpdev->desc.win_slot.slot;
 	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
@@ -3805,10 +3793,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 {
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
 	struct vmbus_channel *chan = hdev->channel;
-	struct {
-		struct pci_packet teardown_packet;
-		u8 buffer[sizeof(struct pci_message)];
-	} pkt;
+	DEFINE_RAW_FLEX(struct pci_packet, pkt, message, 1);
 	struct hv_pci_compl comp_pkt;
 	struct hv_pci_dev *hpdev, *tmp;
 	unsigned long flags;
@@ -3850,15 +3835,14 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 		return ret;
 	}
 
-	memset(&pkt.teardown_packet, 0, sizeof(pkt.teardown_packet));
 	init_completion(&comp_pkt.host_event);
-	pkt.teardown_packet.completion_func = hv_pci_generic_compl;
-	pkt.teardown_packet.compl_ctxt = &comp_pkt;
-	pkt.teardown_packet.message[0].type = PCI_BUS_D0EXIT;
+	pkt->completion_func = hv_pci_generic_compl;
+	pkt->compl_ctxt = &comp_pkt;
+	pkt->message[0].type = PCI_BUS_D0EXIT;
 
-	ret = vmbus_sendpacket_getid(chan, &pkt.teardown_packet.message,
-				     sizeof(struct pci_message),
-				     (unsigned long)&pkt.teardown_packet,
+	ret = vmbus_sendpacket_getid(chan, pkt->message,
+				     __member_size(pkt->message),
+				     (unsigned long)pkt,
 				     &trans_id, VM_PKT_DATA_INBAND,
 				     VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret)
@@ -3873,7 +3857,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 		 * Cf. hv_pci_onchannelcallback().
 		 */
 		vmbus_request_addr_match(chan, trans_id,
-					 (unsigned long)&pkt.teardown_packet);
+					 (unsigned long)pkt);
 		return -ETIMEDOUT;
 	}
 
-- 
2.43.0


