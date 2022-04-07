Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32E94F74C3
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 06:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbiDGEeS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 00:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbiDGEeP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 00:34:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7041E6E8F;
        Wed,  6 Apr 2022 21:32:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bq8so8276209ejb.10;
        Wed, 06 Apr 2022 21:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLk82bq3hxGeZAsu9PKoYX7IPjIjTIMBZgaXITeK+Oo=;
        b=FgBomAD9uMBxBhvAxcGsyN8xGpx6a4yc7XbtSZF0jBwzC3SxUwv9d1sucKUMJQt14W
         p6RBZbhkhyBeQ6srNiXAw6b3PP6rAcp8GfwZSqRyogyhKhzcf+imd7HBVV+lN2Y5oed+
         M6V2lB6gWpouN051rJsiURiw3SA8U8aSjGtvw4Dzgzcq3L9t+Pt4xYL+Gad40UwBDUyS
         iRZzFSGvGF822WBLdeORC7hVGAId5/eEdrB0VMw896z0IRdGONoyBn40b2RleNmahIcG
         SNMSJGIHB4N6t02/jRH84aTyKmwez0wxDSV9rOgWmjSE9FAu21uqugOtm/gYZnqAjHax
         oPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLk82bq3hxGeZAsu9PKoYX7IPjIjTIMBZgaXITeK+Oo=;
        b=knQR2a8PSM2neMWN8ThE/XZHLM67AADZWJEbZ1+InP7KuxB67EajM3r9QKp6rLdMJw
         1n9dBBOv5s0nJMeLnNiFmwBt8UJbDTBDERUREVHwXCigyMs3J7wHGQFxGlN5/2d2TKXw
         UuKNaQYElQfyrr8OCi1Pkdt72w8+9QwOVD22HXPQKpAYpxMQ9PcuwPTi7obMtmA5HF7O
         JK9t+8WaXrc6VL3Jtn/IgfVM1xy3vHADB3RWuSsravNTiP1/XttBFm0o2wx+wFBrGR2e
         emxYaIKfMFhN0X6uePeZMkKOJTslgSh7Lr5++D41PB3cPegaD5wjjOCeM0m8+leXELPD
         evDg==
X-Gm-Message-State: AOAM532DEtssh5WJh/9/M4xu5wplhqilkfQw5PgdJ3TOYzQSrluTm186
        wnLyrRpVdKGOmT2fIaklC50=
X-Google-Smtp-Source: ABdhPJxfGXZZDvMla7/zEF1udPgXurPdzhQgieX4EzxF2MqJtQrYqZdQ1q2bbCDdmAdv1RRKwdagNw==
X-Received: by 2002:a17:907:6d2a:b0:6df:e513:5410 with SMTP id sa42-20020a1709076d2a00b006dfe5135410mr11302460ejc.544.1649305931920;
        Wed, 06 Apr 2022 21:32:11 -0700 (PDT)
Received: from anparri.mshome.net (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id ke11-20020a17090798eb00b006e7fbf53398sm3531341ejc.129.2022.04.06.21.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 21:32:11 -0700 (PDT)
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
Subject: [PATCH 2/6] PCI: hv: Use vmbus_requestor to generate transaction IDs for VMbus hardening
Date:   Thu,  7 Apr 2022 06:30:24 +0200
Message-Id: <20220407043028.379534-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407043028.379534-1-parri.andrea@gmail.com>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
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
 drivers/pci/controller/pci-hyperv.c | 39 +++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 88b3b56d05228..c1322ac37cda9 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -91,6 +91,13 @@ static enum pci_protocol_version_t pci_protocol_versions[] = {
 /* space for 32bit serial number as string */
 #define SLOT_NAME_SIZE 11
 
+/*
+ * Size of requestor for VMbus; the value is based on the observation
+ * that having more than one request outstanding is 'rare', and so 64
+ * should be generous in ensuring that we don't ever run out.
+ */
+#define HV_PCI_RQSTOR_SIZE 64
+
 /*
  * Message Types
  */
@@ -1407,7 +1414,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
 	int_pkt->wslot.slot = hpdev->desc.win_slot.slot;
 	int_pkt->int_desc = *int_desc;
 	vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt, sizeof(*int_pkt),
-			 (unsigned long)&ctxt.pkt, VM_PKT_DATA_INBAND, 0);
+			 0, VM_PKT_DATA_INBAND, 0);
 	kfree(int_desc);
 }
 
@@ -2649,7 +2656,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
 	ejct_pkt->wslot.slot = hpdev->desc.win_slot.slot;
 	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
-			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
+			 sizeof(*ejct_pkt), 0,
 			 VM_PKT_DATA_INBAND, 0);
 
 	/* For the get_pcichild() in hv_pci_eject_device() */
@@ -2696,8 +2703,9 @@ static void hv_pci_onchannelcallback(void *context)
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
@@ -2715,8 +2723,8 @@ static void hv_pci_onchannelcallback(void *context)
 		return;
 
 	while (1) {
-		ret = vmbus_recvpacket_raw(hbus->hdev->channel, buffer,
-					   bufferlen, &bytes_recvd, &req_id);
+		ret = vmbus_recvpacket_raw(chan, buffer, bufferlen,
+					   &bytes_recvd, &req_id);
 
 		if (ret == -ENOBUFS) {
 			kfree(buffer);
@@ -2743,11 +2751,14 @@ static void hv_pci_onchannelcallback(void *context)
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
+						     "Invalid transaction ID %llx\n",
+						     req_id);
+				break;
+			}
+			comp_packet = (struct pci_packet *)req_addr;
 			response = (struct pci_response *)buffer;
 			comp_packet->completion_func(comp_packet->compl_ctxt,
 						     response,
@@ -3428,6 +3439,10 @@ static int hv_pci_probe(struct hv_device *hdev,
 		goto free_dom;
 	}
 
+	hdev->channel->next_request_id_callback = vmbus_next_request_id;
+	hdev->channel->request_addr_callback = vmbus_request_addr;
+	hdev->channel->rqstor_size = HV_PCI_RQSTOR_SIZE;
+
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
@@ -3758,6 +3773,10 @@ static int hv_pci_resume(struct hv_device *hdev)
 
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

