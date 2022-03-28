Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A283C4E99FB
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Mar 2022 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbiC1Oo5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Mar 2022 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiC1Oo4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Mar 2022 10:44:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461E3261F;
        Mon, 28 Mar 2022 07:43:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id yy13so29179834ejb.2;
        Mon, 28 Mar 2022 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kph0VowbW7jN5384Zdt/0e4BwkBNNpSO83jQo1/O5Oo=;
        b=VwlVKLd/IhOAMrpouDw2zXjM7Hw7smfMJI7DKfJ4b6lIUN4la92Q7L1DWY5+MvhRlD
         Ar5ouEPtXHrgXLUXQSSovjG1ylAmPtb8ygAUxmq6Dvh9tXkm6rV2bIwYPT+J4tpB3Lp7
         wlfUPcu2xy+T3HNn/uLGX3Gff6VuRY2z/mi6hkmaV1/X41zTfBvBNCftFc8T+iVmIOk5
         W6aMroxQksMcB3ZpjPyhewK4cwOOIPkq5/FI27Um77rQynXUGi282LquHlMjAFRlHZ2c
         D4JvS/A+aLhRqIVme3IqYhCKD4QAwH53/StDREafZ4IPQ8hLvAAAESgWi52CnAoYStVr
         t86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kph0VowbW7jN5384Zdt/0e4BwkBNNpSO83jQo1/O5Oo=;
        b=2qPn7tWYTb4YqPdGH/xXPs7B5D1MjwdMvlyTdwylzj35uGtkErSTBGd8iYP3rcX4r/
         CNcuyC5aLLB9hAv7F8MpElioxg1/MngNsSF6a6c76gi1lW1F/6xRC8kFjPHjNiueAR83
         r1g9oA/WwoEK0qjnLh0bQm9iQ053EXn38qSiQUIu3EG0F2JYhJwYevRV+fLwQXSrWe99
         Wr5aigghiRheVRNvZLo0E2FNHExLTEP6pQS/J8IChLSi29V5tF+XTdpqidtge3H15OXD
         LRFe7QKmNd0qBKCzpfhe/049OIDCzU5Nxhlv5i5aLNO6lKBb6xaYW5kPH9Aoz3T6LrUs
         bJnA==
X-Gm-Message-State: AOAM53218QzfSJ2PBiUFwgWPCMIG4CTuckth68MOH/yamy8MouYBRz+Y
        eX4/ldQrCXqsaSiNCcOnEx8=
X-Google-Smtp-Source: ABdhPJwCqESW17eriXR9TX/L14+0d5lkvW0vbdPQ7JEsHTwUQx8whIKnLLab5xez/7d7mSvwrAGK9A==
X-Received: by 2002:a17:907:7e85:b0:6e0:dd95:9fc6 with SMTP id qb5-20020a1709077e8500b006e0dd959fc6mr13175214ejc.256.1648478592626;
        Mon, 28 Mar 2022 07:43:12 -0700 (PDT)
Received: from anparri.mshome.net (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7c842000000b0041314b98872sm7008983edt.22.2022.03.28.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:43:12 -0700 (PDT)
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
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [RFC PATCH 2/4] PCI: hv: Use vmbus_requestor to generate transaction IDs for VMbus hardening
Date:   Mon, 28 Mar 2022 16:42:42 +0200
Message-Id: <20220328144244.100228-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328144244.100228-1-parri.andrea@gmail.com>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
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
generated by vmbus_requestor as request (transaction) IDs.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 30 +++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ae0bc2fee4ca8..9f963a46b8298 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -91,6 +91,9 @@ static enum pci_protocol_version_t pci_protocol_versions[] = {
 /* space for 32bit serial number as string */
 #define SLOT_NAME_SIZE 11
 
+/* Size of requestor for VMbus */
+#define HV_PCI_RQSTOR_SIZE 64
+
 /*
  * Message Types
  */
@@ -1407,7 +1410,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
 	int_pkt->wslot.slot = hpdev->desc.win_slot.slot;
 	int_pkt->int_desc = *int_desc;
 	vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt, sizeof(*int_pkt),
-			 (unsigned long)&ctxt.pkt, VM_PKT_DATA_INBAND, 0);
+			 0, VM_PKT_DATA_INBAND, 0);
 	kfree(int_desc);
 }
 
@@ -2649,7 +2652,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
 	ejct_pkt->wslot.slot = hpdev->desc.win_slot.slot;
 	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
-			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
+			 sizeof(*ejct_pkt), 0,
 			 VM_PKT_DATA_INBAND, 0);
 
 	/* For the get_pcichild() in hv_pci_eject_device() */
@@ -2696,8 +2699,9 @@ static void hv_pci_onchannelcallback(void *context)
 	const int packet_size = 0x100;
 	int ret;
 	struct hv_pcibus_device *hbus = context;
+	struct vmbus_channel *chan = hbus->hdev->channel;
 	u32 bytes_recvd;
-	u64 req_id;
+	u64 req_id, req_addr;
 	struct vmpacket_descriptor *desc;
 	unsigned char *buffer;
 	int bufferlen = packet_size;
@@ -2743,11 +2747,13 @@ static void hv_pci_onchannelcallback(void *context)
 		switch (desc->type) {
 		case VM_PKT_COMP:
 
-			/*
-			 * The host is trusted, and thus it's safe to interpret
-			 * this transaction ID as a pointer.
-			 */
-			comp_packet = (struct pci_packet *)req_id;
+			req_addr = chan->request_addr_callback(chan, req_id);
+			if (req_addr == VMBUS_RQST_ERROR) {
+				dev_warn_ratelimited(&hbus->hdev->device,
+						     "Invalid request ID\n");
+				break;
+			}
+			comp_packet = (struct pci_packet *)req_addr;
 			response = (struct pci_response *)buffer;
 			comp_packet->completion_func(comp_packet->compl_ctxt,
 						     response,
@@ -3419,6 +3425,10 @@ static int hv_pci_probe(struct hv_device *hdev,
 		goto free_dom;
 	}
 
+	hdev->channel->next_request_id_callback = vmbus_next_request_id;
+	hdev->channel->request_addr_callback = vmbus_request_addr;
+	hdev->channel->rqstor_size = HV_PCI_RQSTOR_SIZE;
+
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
@@ -3749,6 +3759,10 @@ static int hv_pci_resume(struct hv_device *hdev)
 
 	hbus->state = hv_pcibus_init;
 
+	hdev->channel->next_request_id_callback = vmbus_next_request_id;
+	hdev->channel->request_addr_callback = vmbus_request_addr;
+	hdev->channel->rqstor_size = HV_PCI_RQSTOR_SIZE;
+
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
-- 
2.25.1

