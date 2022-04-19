Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48224506C60
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbiDSM0y (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 08:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352284AbiDSM0k (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 08:26:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C738F366A0;
        Tue, 19 Apr 2022 05:23:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z12so21033472edl.2;
        Tue, 19 Apr 2022 05:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+5KAN+1gGGEcZk/bVdKuKM/QW/CVm3QE/hSUlqBVr4=;
        b=CZlCg/CgiiTQDkg8mMqM/P6wU7s3WyA7gIYybU8X6zVlegvcHncMgsSxdba+wM59jV
         /AHce/xuR1rKlb3u7z3vminRhYFYCI+ViA0YLwpoYBsoGes73SNsCH1HtiUy2+thx/qP
         0B/6ntzyNRibw+H8B4uQ5JHKtyopCZanmWtXygmN5pzg4+VMzDpzQt60eGnbUHqtmCJU
         Acmj5FwuZOumZOcwAlKcTpehkhA0GYnY7TJaA9qeVvScPMiwzI9CCEI9gyVaaQNo7VUT
         zNzLC0JHAubOgeHwMU3s8Sm9+zKsFY8kkgtpOg9jga1EqqwzBN/VH8MmzoRoY5HrAwzz
         vi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+5KAN+1gGGEcZk/bVdKuKM/QW/CVm3QE/hSUlqBVr4=;
        b=NpzlmnGnl7JYLXRTbcg7GARofU6+i+b8HK7xThKYYcjzPPGnvkTLsj6gmFuaqG2tm6
         qx8lOAWsLEk+P5hbchLO60d/O5jVYzrXUjD5c+0jyb257twfVOA4aRpkcujZ74aemoFV
         8jLymX4Ot+5nGuB/c6sDvSMlVRjblnzN3p7mTpEJbts6ksM/Klb6/8/BaADnrpn8gD21
         g8kit0R9dplbZ0ChFDSXHspCU04m7cociQZ3WMey1JNuDk1aoZAwrgs3mO479Zwjyad1
         16O11FRb3GgmURdli1jnV0dC3DFlffIKxqzd5miYTIykgYIX/vkfrZhwZDF8WalreOwO
         HTbA==
X-Gm-Message-State: AOAM53362PTRlHPHdTMW51IhZkVtFr7XYWXNctcg1uRHs+tVqmdKfG7q
        oE44tzeEosVOBR3c0ST0/DU=
X-Google-Smtp-Source: ABdhPJzqVbeIg4CkpgbBc1vVsN/rrixxtmiOUwQVI5pA9uDsyD6QFhizkUR41/HIEDocsebckxD0jw==
X-Received: by 2002:a05:6402:2741:b0:41f:69dc:9bcd with SMTP id z1-20020a056402274100b0041f69dc9bcdmr17102553edd.239.1650371036322;
        Tue, 19 Apr 2022 05:23:56 -0700 (PDT)
Received: from anparri.mshome.net (host-82-53-3-95.retail.telecomitalia.it. [82.53.3.95])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm5644685ejm.189.2022.04.19.05.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:23:55 -0700 (PDT)
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
Subject: [PATCH v2 2/6] PCI: hv: Use vmbus_requestor to generate transaction IDs for VMbus hardening
Date:   Tue, 19 Apr 2022 14:23:21 +0200
Message-Id: <20220419122325.10078-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419122325.10078-1-parri.andrea@gmail.com>
References: <20220419122325.10078-1-parri.andrea@gmail.com>
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
index 88b3b56d05228..0252b4bbc8d15 100644
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
+				dev_err(&hbus->hdev->device,
+					"Invalid transaction ID %llx\n",
+					req_id);
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

