Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D54E9A03
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Mar 2022 16:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbiC1OpL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Mar 2022 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244035AbiC1OpJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Mar 2022 10:45:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE295FF02;
        Mon, 28 Mar 2022 07:43:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h4so9429087edr.3;
        Mon, 28 Mar 2022 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgQsnHWSKcUjSr0c0J8SsSRoM3VXhq2y61ybhNS+8g0=;
        b=O7nQGlk/gZojEGd5R9rpAToHuyXorMSSly1Ywl67lXXgV1Rq5gudAJf/TIafmwVEMf
         xBtvQDt4dmEZu7Oj5/BofdfDWkOTUr+GlS/A5ZrIEcx8cQeAW/BIcGrshxQ5t5HrIC6Q
         etkBf8srwhJyQV1x/HkKWHapueODt4cg9QNEhvg396VE3AsDyyxh7PdFlFFZVaFCtaij
         OK5AXy+0ULZPtxtt1n6f1IygWdlflDGvWssi/9vhtVnl8ApWLHsgt4x1zWXWadT53S1K
         7o7WEmUU4PbzhNve/1D88qZC09a6sv5UTn99kD5qXwhHQ2LJ8Znw/eorGyRm1fdanvxv
         zuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgQsnHWSKcUjSr0c0J8SsSRoM3VXhq2y61ybhNS+8g0=;
        b=z7pOaGtry8JQRSXA68uPJJIwrsN+d6/D6LAvT4DddK+Cpq/XWdwL99PP//ok1fnxHr
         QHx3wz/+9crhBxOVg2NY9CP8UztxI3PzsHOyqwBnltywd1HlnpVwy4PtHyKEU5eOomIN
         EIyWnxHast6nWozcl0dyOYmEzbbWHFnb5RClfXIVyBJdOqC24JVdG6izTHrRDIfIIXLa
         K6FSRWTPZQHmFEEnD7WbmP5KkOtiWhTp+8pnejXGxZkSNzoOyjIuWtfos3MRJVGQ7c/h
         aldj246uwr42EivnMSAlBvbA4kPQHztBrrkrR3XX8hptAh5xfktTs3Z6QpfZK0vCsFGp
         Ycnw==
X-Gm-Message-State: AOAM532rpKQjfDe7+u9dfRtYEyPIdV/T81+9upMSOLYUDjOsRVAibhcw
        Yj/5mLVKLi00WU7SjtS7rxk7GqHRw5Hftweo
X-Google-Smtp-Source: ABdhPJzulsjImQ7v6i6fPCBD9QIlnNfqUl8dIT0nJbMsdaHHW4UE9A3BrJMM4sKQmu/+AcmmhAb1hw==
X-Received: by 2002:a05:6402:270b:b0:419:3383:7a9f with SMTP id y11-20020a056402270b00b0041933837a9fmr16617576edd.191.1648478597530;
        Mon, 28 Mar 2022 07:43:17 -0700 (PDT)
Received: from anparri.mshome.net (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7c842000000b0041314b98872sm7008983edt.22.2022.03.28.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:43:17 -0700 (PDT)
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
Subject: [RFC PATCH 4/4] PCI: hv: Fix synchronization between channel callback and hv_compose_msi_msg()
Date:   Mon, 28 Mar 2022 16:42:44 +0200
Message-Id: <20220328144244.100228-5-parri.andrea@gmail.com>
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

Dexuan wrote:

  "[...]  when we disable AccelNet, the host PCI VSP driver sends a
   PCI_EJECT message first, and the channel callback may set
   hpdev->state to hv_pcichild_ejecting on a different CPU.  This can
   cause hv_compose_msi_msg() to exit from the loop and 'return', and
   the on-stack variable 'ctxt' is invalid.  Now, if the response
   message from the host arrives, the channel callback will try to
   access the invalid 'ctxt' variable, and this may cause a crash."

Schematically:

  Hyper-V sends PCI_EJECT msg
    hv_pci_onchannelcallback()
      state = hv_pcichild_ejecting
                                       hv_compose_msi_msg()
                                         alloc and init comp_pkt
                                         state == hv_pcichild_ejecting
  Hyper-V sends VM_PKT_COMP msg
    hv_pci_onchannelcallback()
      retrieve address of comp_pkt
                                         'free' comp_pkt and return
      comp_pkt->completion_func()

Dexuan also showed how the crash can be triggered after introducing
suitable delays in the driver code, thus validating the 'assumption'
that the host can still normally respond to the guest's compose_msi
request after the host has started to eject the PCI device.

Fix the synchronization by leveraging the requestor lock as follows:

  - Before 'return'-ing in hv_compose_msi_msg(), remove the ID (while
    holding the requestor lock) associated to the completion packet.

  - Retrieve the address *and call ->completion_func() within a same
    (requestor) critical section in hv_pci_onchannelcallback().

Fixes: de0aa7b2f97d3 ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
Reported-by: Wei Hu <weh@microsoft.com>
Reported-by: Dexuan Cui <decui@microsoft.com>
Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 83 ++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9f963a46b8298..8876b318173f0 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1662,6 +1662,55 @@ static u32 hv_compose_msi_req_v3(
 	return sizeof(*int_pkt);
 }
 
+/* As in vmbus_request_addr() but without the requestor lock */
+static u64 __hv_pci_request_addr(struct vmbus_channel *channel, u64 trans_id)
+{
+	struct vmbus_requestor *rqstor = &channel->requestor;
+	u64 req_addr;
+
+	if (trans_id >= rqstor->size ||
+	    !test_bit(trans_id, rqstor->req_bitmap))
+		return VMBUS_RQST_ERROR;
+
+	req_addr = rqstor->req_arr[trans_id];
+	rqstor->req_arr[trans_id] = rqstor->next_request_id;
+	rqstor->next_request_id = trans_id;
+
+	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
+
+	return req_addr;
+}
+
+/*
+ * Clear/remove @trans_id from @channel's requestor, provided the memory
+ * address stored at @trans_id equals @rqst_addr.
+ */
+static void hv_pci_request_addr_match(struct vmbus_channel *channel,
+				      u64 trans_id, u64 rqst_addr)
+{
+	struct vmbus_requestor *rqstor = &channel->requestor;
+	unsigned long flags;
+	u64 req_addr;
+
+	spin_lock_irqsave(&rqstor->req_lock, flags);
+
+	if (trans_id >= rqstor->size ||
+	    !test_bit(trans_id, rqstor->req_bitmap)) {
+		spin_unlock_irqrestore(&rqstor->req_lock, flags);
+		return;
+	}
+
+	req_addr = rqstor->req_arr[trans_id];
+	if (req_addr == rqst_addr) {
+		rqstor->req_arr[trans_id] = rqstor->next_request_id;
+		rqstor->next_request_id = trans_id;
+
+		bitmap_clear(rqstor->req_bitmap, trans_id, 1);
+	}
+
+	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+}
+
 /**
  * hv_compose_msi_msg() - Supplies a valid MSI address/data
  * @data:	Everything about this MSI
@@ -1691,7 +1740,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 			struct pci_create_interrupt3 v3;
 		} int_pkts;
 	} __packed ctxt;
-
+	u64 trans_id;
 	u32 size;
 	int ret;
 
@@ -1753,10 +1802,10 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		goto free_int_desc;
 	}
 
-	ret = vmbus_sendpacket(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
-			       size, (unsigned long)&ctxt.pci_pkt,
-			       VM_PKT_DATA_INBAND,
-			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	ret = vmbus_sendpacket_getid(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
+				     size, (unsigned long)&ctxt.pci_pkt,
+				     &trans_id, VM_PKT_DATA_INBAND,
+				     VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret) {
 		dev_err(&hbus->hdev->device,
 			"Sending request for interrupt failed: 0x%x",
@@ -1835,6 +1884,16 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 enable_tasklet:
 	tasklet_enable(&channel->callback_event);
+	/*
+	 * The completion packet on the stack becomes invalid after 'return';
+	 * remove the ID from the VMbus requestor if the identifier is still
+	 * mapped to/associated with the packet.  (The identifier could have
+	 * been 're-used', i.e., already removed and (re-)mapped.)
+	 *
+	 * Cf. hv_pci_onchannelcallback().
+	 */
+	hv_pci_request_addr_match(channel, trans_id,
+				  (unsigned long)&ctxt.pci_pkt);
 free_int_desc:
 	kfree(int_desc);
 drop_reference:
@@ -2700,6 +2759,8 @@ static void hv_pci_onchannelcallback(void *context)
 	int ret;
 	struct hv_pcibus_device *hbus = context;
 	struct vmbus_channel *chan = hbus->hdev->channel;
+	struct vmbus_requestor *rqstor = &chan->requestor;
+	unsigned long flags;
 	u32 bytes_recvd;
 	u64 req_id, req_addr;
 	struct vmpacket_descriptor *desc;
@@ -2747,17 +2808,27 @@ static void hv_pci_onchannelcallback(void *context)
 		switch (desc->type) {
 		case VM_PKT_COMP:
 
-			req_addr = chan->request_addr_callback(chan, req_id);
+			spin_lock_irqsave(&rqstor->req_lock, flags);
+			req_addr = __hv_pci_request_addr(chan, req_id);
 			if (req_addr == VMBUS_RQST_ERROR) {
+				spin_unlock_irqrestore(&rqstor->req_lock, flags);
 				dev_warn_ratelimited(&hbus->hdev->device,
 						     "Invalid request ID\n");
 				break;
 			}
 			comp_packet = (struct pci_packet *)req_addr;
 			response = (struct pci_response *)buffer;
+			/*
+			 * Call ->completion_func() within the critical section to make
+			 * sure that the packet pointer is still valid during the call:
+			 * here 'valid' means that there's a task still waiting for the
+			 * completion, and that the packet data is still on the waiting
+			 * task's stack.  Cf. hv_compose_msi_msg().
+			 */
 			comp_packet->completion_func(comp_packet->compl_ctxt,
 						     response,
 						     bytes_recvd);
+			spin_unlock_irqrestore(&rqstor->req_lock, flags);
 			break;
 
 		case VM_PKT_DATA_INBAND:
-- 
2.25.1

