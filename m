Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429EC4DE044
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Mar 2022 18:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiCRRua (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Mar 2022 13:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiCRRu3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Mar 2022 13:50:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB311760C8;
        Fri, 18 Mar 2022 10:49:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bi12so18482199ejb.3;
        Fri, 18 Mar 2022 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PY1MKz3GK376F26Y2e1hmURAMqKtMT7svoGQd9OkBqQ=;
        b=Z7vJ2aDj0GP0mfiY/C1sIz0D2WnXmQv7qFLUMiH5BIkWkVkLfyWY8yV6pXA66od9dY
         IHqwLLo/UGE6rerayTB4xHwAU9ioMun8Tr41/RZN92p9sQN0NrYAwkQE+1K4D2Nb2j3B
         9pKiTbdrVb/olorbiCS8bYXfDpCusbpzp97MUt9+QcbjLtbJAlOibtoKt3smEh4si3lC
         TOgadfm4kZEj/fmnRx88356No+PnXqBnWIRHPFnIsU0Sg6cdaw5w2tMXonqehUF67q0l
         eB5Zw8zuHipnbLW/vVawV7wOcFBveTJLZvH0o7cGl0JRvFmXHWhK4wszjr4zV++rlWKG
         /wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PY1MKz3GK376F26Y2e1hmURAMqKtMT7svoGQd9OkBqQ=;
        b=EgOH8sX3BQCjxHOelnoR0U+B2RqaO+kvKzjDkrL18SLz7kQClC4Aix0WfAwsDpV/NZ
         IO7Kf77QYPLbOkeLN1Ri306VwXw/BsibivV+I45NIzMB8bkwpaN4mxoFmGO+Kvg1LCNv
         wKJOjTYR216bWWAPphXOwjBYbA3bsDmZ3Kq3llZm55UbzqZ7G1EMk+ZLInTRhRWVH2BH
         TKlwvv443rbGyZrmZ9MSQ0BbXDDV+wXdU88nvBw6tSJg03UZDfp0lp7Krix5GWOQVfTp
         chuLhkiiWYs6qtiUvlsgotpgeuJA9aBjlJdc9oeDI01rJZ+NRSbbFwjcdwi3kqmnPnO3
         pF2Q==
X-Gm-Message-State: AOAM530787kx81q6cRcb0lW5TMVM2OZ35UNMXFxHbtXfTU9l6XbPQq7e
        giPucCvZGaIs4uvK6iiIdNU=
X-Google-Smtp-Source: ABdhPJw9GmQS5+azXCuU9548AMXUF8/InESEGo/HUOKL/6XJRV/oO4eEZsgusIagxAee7AC+2lTJKw==
X-Received: by 2002:a17:907:761c:b0:6d6:e553:7bd1 with SMTP id jx28-20020a170907761c00b006d6e5537bd1mr9745013ejc.5.1647625743349;
        Fri, 18 Mar 2022 10:49:03 -0700 (PDT)
Received: from anparri.mshome.net (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id y15-20020a170906518f00b006df87a2bb16sm3218730ejk.89.2022.03.18.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:49:03 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 1/2] PCI: hv: Use IDR to generate transaction IDs for VMBus hardening
Date:   Fri, 18 Mar 2022 18:48:47 +0100
Message-Id: <20220318174848.290621-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318174848.290621-1-parri.andrea@gmail.com>
References: <20220318174848.290621-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, pointers to guest memory are passed to Hyper-V as transaction
IDs in hv_pci.  In the face of errors or malicious behavior in Hyper-V,
hv_pci should not expose or trust the transaction IDs returned by
Hyper-V to be valid guest memory addresses.  Instead, use small integers
generated by IDR as request (transaction) IDs.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 190 ++++++++++++++++++++--------
 1 file changed, 135 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ae0bc2fee4ca8..fbc62aab08fdc 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -495,6 +495,9 @@ struct hv_pcibus_device {
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
 
+	spinlock_t idr_lock; /* Serialize accesses to the IDR */
+	struct idr idr; /* Map guest memory addresses */
+
 	struct list_head children;
 	struct list_head dr_list;
 
@@ -1208,6 +1211,27 @@ static void hv_pci_read_config_compl(void *context, struct pci_response *resp,
 	complete(&comp->comp_pkt.host_event);
 }
 
+static inline int alloc_request_id(struct hv_pcibus_device *hbus,
+				   void *ptr, gfp_t gfp)
+{
+	unsigned long flags;
+	int req_id;
+
+	spin_lock_irqsave(&hbus->idr_lock, flags);
+	req_id = idr_alloc(&hbus->idr, ptr, 1, 0, gfp);
+	spin_unlock_irqrestore(&hbus->idr_lock, flags);
+	return req_id;
+}
+
+static inline void remove_request_id(struct hv_pcibus_device *hbus, int req_id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hbus->idr_lock, flags);
+	idr_remove(&hbus->idr, req_id);
+	spin_unlock_irqrestore(&hbus->idr_lock, flags);
+}
+
 /**
  * hv_read_config_block() - Sends a read config block request to
  * the back-end driver running in the Hyper-V parent partition.
@@ -1232,7 +1256,7 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
 	} pkt;
 	struct hv_read_config_compl comp_pkt;
 	struct pci_read_block *read_blk;
-	int ret;
+	int req_id, ret;
 
 	if (len == 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
 		return -EINVAL;
@@ -1250,16 +1274,19 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
 	read_blk->block_id = block_id;
 	read_blk->bytes_requested = len;
 
+	req_id = alloc_request_id(hbus, &pkt.pkt, GFP_KERNEL);
+	if (req_id < 0)
+		return req_id;
+
 	ret = vmbus_sendpacket(hbus->hdev->channel, read_blk,
-			       sizeof(*read_blk), (unsigned long)&pkt.pkt,
-			       VM_PKT_DATA_INBAND,
+			       sizeof(*read_blk), req_id, VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret)
-		return ret;
+		goto exit;
 
 	ret = wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event);
 	if (ret)
-		return ret;
+		goto exit;
 
 	if (comp_pkt.comp_pkt.completion_status != 0 ||
 	    comp_pkt.bytes_returned == 0) {
@@ -1267,11 +1294,14 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
 			"Read Config Block failed: 0x%x, bytes_returned=%d\n",
 			comp_pkt.comp_pkt.completion_status,
 			comp_pkt.bytes_returned);
-		return -EIO;
+		ret = -EIO;
+		goto exit;
 	}
 
 	*bytes_returned = comp_pkt.bytes_returned;
-	return 0;
+exit:
+	remove_request_id(hbus, req_id);
+	return ret;
 }
 
 /**
@@ -1313,8 +1343,8 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
 	} pkt;
 	struct hv_pci_compl comp_pkt;
 	struct pci_write_block *write_blk;
+	int req_id, ret;
 	u32 pkt_size;
-	int ret;
 
 	if (len == 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
 		return -EINVAL;
@@ -1340,24 +1370,30 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
 	 */
 	pkt_size += sizeof(pkt.reserved);
 
+	req_id = alloc_request_id(hbus, &pkt.pkt, GFP_KERNEL);
+	if (req_id < 0)
+		return req_id;
+
 	ret = vmbus_sendpacket(hbus->hdev->channel, write_blk, pkt_size,
-			       (unsigned long)&pkt.pkt, VM_PKT_DATA_INBAND,
+			       req_id, VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret)
-		return ret;
+		goto exit;
 
 	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event);
 	if (ret)
-		return ret;
+		goto exit;
 
 	if (comp_pkt.completion_status != 0) {
 		dev_err(&hbus->hdev->device,
 			"Write Config Block failed: 0x%x\n",
 			comp_pkt.completion_status);
-		return -EIO;
+		ret = -EIO;
 	}
 
-	return 0;
+exit:
+	remove_request_id(hbus, req_id);
+	return ret;
 }
 
 /**
@@ -1407,7 +1443,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
 	int_pkt->wslot.slot = hpdev->desc.win_slot.slot;
 	int_pkt->int_desc = *int_desc;
 	vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt, sizeof(*int_pkt),
-			 (unsigned long)&ctxt.pkt, VM_PKT_DATA_INBAND, 0);
+			 0, VM_PKT_DATA_INBAND, 0);
 	kfree(int_desc);
 }
 
@@ -1688,9 +1724,8 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 			struct pci_create_interrupt3 v3;
 		} int_pkts;
 	} __packed ctxt;
-
+	int req_id, ret;
 	u32 size;
-	int ret;
 
 	pdev = msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
 	dest = irq_data_get_effective_affinity_mask(data);
@@ -1750,15 +1785,18 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		goto free_int_desc;
 	}
 
+	req_id = alloc_request_id(hbus, &ctxt.pci_pkt, GFP_ATOMIC);
+	if (req_id < 0)
+		goto free_int_desc;
+
 	ret = vmbus_sendpacket(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
-			       size, (unsigned long)&ctxt.pci_pkt,
-			       VM_PKT_DATA_INBAND,
+			       size, req_id, VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret) {
 		dev_err(&hbus->hdev->device,
 			"Sending request for interrupt failed: 0x%x",
 			comp.comp_pkt.completion_status);
-		goto free_int_desc;
+		goto remove_id;
 	}
 
 	/*
@@ -1811,7 +1849,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		dev_err(&hbus->hdev->device,
 			"Request for interrupt failed: 0x%x",
 			comp.comp_pkt.completion_status);
-		goto free_int_desc;
+		goto remove_id;
 	}
 
 	/*
@@ -1827,11 +1865,14 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_lo = comp.int_desc.address & 0xffffffff;
 	msg->data = comp.int_desc.data;
 
+	remove_request_id(hbus, req_id);
 	put_pcichild(hpdev);
 	return;
 
 enable_tasklet:
 	tasklet_enable(&channel->callback_event);
+remove_id:
+	remove_request_id(hbus, req_id);
 free_int_desc:
 	kfree(int_desc);
 drop_reference:
@@ -2258,7 +2299,7 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 		u8 buffer[sizeof(struct pci_child_message)];
 	} pkt;
 	unsigned long flags;
-	int ret;
+	int req_id, ret;
 
 	hpdev = kzalloc(sizeof(*hpdev), GFP_KERNEL);
 	if (!hpdev)
@@ -2275,16 +2316,19 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 	res_req->message_type.type = PCI_QUERY_RESOURCE_REQUIREMENTS;
 	res_req->wslot.slot = desc->win_slot.slot;
 
+	req_id = alloc_request_id(hbus, &pkt.init_packet, GFP_KERNEL);
+	if (req_id < 0)
+		goto error;
+
 	ret = vmbus_sendpacket(hbus->hdev->channel, res_req,
-			       sizeof(struct pci_child_message),
-			       (unsigned long)&pkt.init_packet,
+			       sizeof(struct pci_child_message), req_id,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret)
-		goto error;
+		goto remove_id;
 
 	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
-		goto error;
+		goto remove_id;
 
 	hpdev->desc = *desc;
 	refcount_set(&hpdev->refs, 1);
@@ -2293,8 +2337,11 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 
 	list_add_tail(&hpdev->list_entry, &hbus->children);
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
+	remove_request_id(hbus, req_id);
 	return hpdev;
 
+remove_id:
+	remove_request_id(hbus, req_id);
 error:
 	kfree(hpdev);
 	return NULL;
@@ -2648,8 +2695,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	ejct_pkt = (struct pci_eject_response *)&ctxt.pkt.message;
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
 	ejct_pkt->wslot.slot = hpdev->desc.win_slot.slot;
-	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
-			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
+	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt, sizeof(*ejct_pkt), 0,
 			 VM_PKT_DATA_INBAND, 0);
 
 	/* For the get_pcichild() in hv_pci_eject_device() */
@@ -2709,6 +2755,7 @@ static void hv_pci_onchannelcallback(void *context)
 	struct pci_dev_inval_block *inval;
 	struct pci_dev_incoming *dev_message;
 	struct hv_pci_dev *hpdev;
+	unsigned long flags;
 
 	buffer = kmalloc(bufferlen, GFP_ATOMIC);
 	if (!buffer)
@@ -2743,11 +2790,19 @@ static void hv_pci_onchannelcallback(void *context)
 		switch (desc->type) {
 		case VM_PKT_COMP:
 
-			/*
-			 * The host is trusted, and thus it's safe to interpret
-			 * this transaction ID as a pointer.
-			 */
-			comp_packet = (struct pci_packet *)req_id;
+			if (req_id > INT_MAX) {
+				dev_err_ratelimited(&hbus->hdev->device,
+						    "Request ID > INT_MAX\n");
+				break;
+			}
+			spin_lock_irqsave(&hbus->idr_lock, flags);
+			comp_packet = (struct pci_packet *)idr_find(&hbus->idr, req_id);
+			spin_unlock_irqrestore(&hbus->idr_lock, flags);
+			if (!comp_packet) {
+				dev_warn_ratelimited(&hbus->hdev->device,
+						     "Request ID not found\n");
+				break;
+			}
 			response = (struct pci_response *)buffer;
 			comp_packet->completion_func(comp_packet->compl_ctxt,
 						     response,
@@ -2858,8 +2913,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
 	struct pci_version_request *version_req;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
-	int ret;
-	int i;
+	int req_id, ret, i;
 
 	/*
 	 * Initiate the handshake with the host and negotiate
@@ -2877,12 +2931,18 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
 	version_req = (struct pci_version_request *)&pkt->message;
 	version_req->message_type.type = PCI_QUERY_PROTOCOL_VERSION;
 
+	req_id = alloc_request_id(hbus, pkt, GFP_KERNEL);
+	if (req_id < 0) {
+		kfree(pkt);
+		return req_id;
+	}
+
 	for (i = 0; i < num_version; i++) {
 		version_req->protocol_version = version[i];
 		ret = vmbus_sendpacket(hdev->channel, version_req,
-				sizeof(struct pci_version_request),
-				(unsigned long)pkt, VM_PKT_DATA_INBAND,
-				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+				       sizeof(struct pci_version_request),
+				       req_id, VM_PKT_DATA_INBAND,
+				       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 		if (!ret)
 			ret = wait_for_response(hdev, &comp_pkt.host_event);
 
@@ -2917,6 +2977,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
 	ret = -EPROTO;
 
 exit:
+	remove_request_id(hbus, req_id);
 	kfree(pkt);
 	return ret;
 }
@@ -3079,7 +3140,7 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	struct pci_bus_d0_entry *d0_entry;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
-	int ret;
+	int req_id, ret;
 
 	/*
 	 * Tell the host that the bus is ready to use, and moved into the
@@ -3098,8 +3159,14 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	d0_entry->message_type.type = PCI_BUS_D0ENTRY;
 	d0_entry->mmio_base = hbus->mem_config->start;
 
+	req_id = alloc_request_id(hbus, pkt, GFP_KERNEL);
+	if (req_id < 0) {
+		kfree(pkt);
+		return req_id;
+	}
+
 	ret = vmbus_sendpacket(hdev->channel, d0_entry, sizeof(*d0_entry),
-			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
+			       req_id, VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (!ret)
 		ret = wait_for_response(hdev, &comp_pkt.host_event);
@@ -3112,12 +3179,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 			"PCI Pass-through VSP failed D0 Entry with status %x\n",
 			comp_pkt.completion_status);
 		ret = -EPROTO;
-		goto exit;
 	}
 
-	ret = 0;
-
 exit:
+	remove_request_id(hbus, req_id);
 	kfree(pkt);
 	return ret;
 }
@@ -3175,11 +3240,10 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 	struct pci_resources_assigned *res_assigned;
 	struct pci_resources_assigned2 *res_assigned2;
 	struct hv_pci_compl comp_pkt;
+	int wslot, req_id, ret = 0;
 	struct hv_pci_dev *hpdev;
 	struct pci_packet *pkt;
 	size_t size_res;
-	int wslot;
-	int ret;
 
 	size_res = (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
 			? sizeof(*res_assigned) : sizeof(*res_assigned2);
@@ -3188,7 +3252,11 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 	if (!pkt)
 		return -ENOMEM;
 
-	ret = 0;
+	req_id = alloc_request_id(hbus, pkt, GFP_KERNEL);
+	if (req_id < 0) {
+		kfree(pkt);
+		return req_id;
+	}
 
 	for (wslot = 0; wslot < 256; wslot++) {
 		hpdev = get_pcichild_wslot(hbus, wslot);
@@ -3215,10 +3283,9 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 		}
 		put_pcichild(hpdev);
 
-		ret = vmbus_sendpacket(hdev->channel, &pkt->message,
-				size_res, (unsigned long)pkt,
-				VM_PKT_DATA_INBAND,
-				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+		ret = vmbus_sendpacket(hdev->channel, &pkt->message, size_res,
+				       req_id, VM_PKT_DATA_INBAND,
+				       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 		if (!ret)
 			ret = wait_for_response(hdev, &comp_pkt.host_event);
 		if (ret)
@@ -3235,6 +3302,7 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 		hbus->wslot_res_allocated = wslot;
 	}
 
+	remove_request_id(hbus, req_id);
 	kfree(pkt);
 	return ret;
 }
@@ -3412,6 +3480,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
+	spin_lock_init(&hbus->idr_lock);
 	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
 					   hbus->bridge->domain_nr);
 	if (!hbus->wq) {
@@ -3419,6 +3488,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 		goto free_dom;
 	}
 
+	idr_init(&hbus->idr);
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
@@ -3537,6 +3607,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hv_free_config_window(hbus);
 close:
 	vmbus_close(hdev->channel);
+	idr_destroy(&hbus->idr);
 destroy_wq:
 	destroy_workqueue(hbus->wq);
 free_dom:
@@ -3556,7 +3627,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 	struct hv_pci_compl comp_pkt;
 	struct hv_pci_dev *hpdev, *tmp;
 	unsigned long flags;
-	int ret;
+	int req_id, ret;
 
 	/*
 	 * After the host sends the RESCIND_CHANNEL message, it doesn't
@@ -3599,18 +3670,23 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 	pkt.teardown_packet.compl_ctxt = &comp_pkt;
 	pkt.teardown_packet.message[0].type = PCI_BUS_D0EXIT;
 
+	req_id = alloc_request_id(hbus, &pkt.teardown_packet, GFP_KERNEL);
+	if (req_id < 0)
+		return req_id;
+
 	ret = vmbus_sendpacket(hdev->channel, &pkt.teardown_packet.message,
-			       sizeof(struct pci_message),
-			       (unsigned long)&pkt.teardown_packet,
+			       sizeof(struct pci_message), req_id,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret)
-		return ret;
+		goto exit;
 
 	if (wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ) == 0)
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
 
-	return 0;
+exit:
+	remove_request_id(hbus, req_id);
+	return ret;
 }
 
 /**
@@ -3648,6 +3724,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	ret = hv_pci_bus_exit(hdev, false);
 
 	vmbus_close(hdev->channel);
+	idr_destroy(&hbus->idr);
 
 	iounmap(hbus->cfg_addr);
 	hv_free_config_window(hbus);
@@ -3704,6 +3781,7 @@ static int hv_pci_suspend(struct hv_device *hdev)
 		return ret;
 
 	vmbus_close(hdev->channel);
+	idr_destroy(&hbus->idr);
 
 	return 0;
 }
@@ -3749,6 +3827,7 @@ static int hv_pci_resume(struct hv_device *hdev)
 
 	hbus->state = hv_pcibus_init;
 
+	idr_init(&hbus->idr);
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
@@ -3780,6 +3859,7 @@ static int hv_pci_resume(struct hv_device *hdev)
 	return 0;
 out:
 	vmbus_close(hdev->channel);
+	idr_destroy(&hbus->idr);
 	return ret;
 }
 
-- 
2.25.1

