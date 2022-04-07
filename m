Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA204F74CB
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 06:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbiDGEe1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 00:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbiDGEeU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 00:34:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452111E869E;
        Wed,  6 Apr 2022 21:32:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bh17so8285066ejb.8;
        Wed, 06 Apr 2022 21:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnlZDRRS7PR+XhZFKAMVuyrkTCKVrR39UF+kw4DUCS0=;
        b=BM9yF4lax9++9+ia/3A+nNKqN4zI6aKd9ErEK1F9b9SLYKIxtr/GuRoFFKh01k+5Gl
         7FYHRR/KzDJ1DMWQgccwTYACFks3lG9azjO5G93lyabu9XFUF338NE+BtZRzEbJN8LG3
         Bx0En7Cg1wBs4tXHuI+88Z7xY74SAzL2t2DSKMYVzMfnOeGqu49IEGF+jlvOn9l0ANhF
         d50+VqMjiUIZQuYIFujVSLXMX9olUig6tOoBtGBtgZQBu8v8Ft8pWPiRWRD6mF11N5cZ
         NDzgWg+Gagqm5NWS3ZyyuBfELYhxu53g37Hz834vXKEhgL7L2wVltekkBi7gaHfBp5Wv
         Kc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnlZDRRS7PR+XhZFKAMVuyrkTCKVrR39UF+kw4DUCS0=;
        b=CDbjziNummREBnzuEpBs5xm0EYJeyvUWiblHCQyXljvqQr087GyRnCoPo8Z8kJpV2C
         zGDnl0jyTMIfMRzTs3czKQQNDQ0W6L3ad+jvEAABuyloOQM61C7EK/BzChcM/4bYQCaB
         nsODnlrj+2VzPJfgPWmVNJTsyIBGCDOMiTbBhYr7N+DdkhUDzaxJ620A37ikRQ2C+sm/
         L5iQGtzhhHwpbrD+lFTH5/0+rzkjbz+g9bwP+F7a9dpGwsNwaJXOuq43wmZ8asoTgeks
         L8tlxHHsXprtwyzi8CVQp0zux6Uzp6iz0uIX4F+pGb7fNq1kFLJTKrsEan6SdklbyfFa
         zfOw==
X-Gm-Message-State: AOAM531ZiEZRR2UE84tfvKUBxp4CNsjTSO2KpvhtKS/a5FbGkp9POCt+
        JKzKZZWD9kqMOvFMAEDKx0M=
X-Google-Smtp-Source: ABdhPJzz9E6ugccX49b5so3/0qNL929ZI5Flwv/RHmpUhYr2mojndRYy9BSupaQ4p5pdfzbcYFNLEQ==
X-Received: by 2002:a17:907:60c8:b0:6da:83f0:9eaa with SMTP id hv8-20020a17090760c800b006da83f09eaamr11172034ejc.605.1649305940725;
        Wed, 06 Apr 2022 21:32:20 -0700 (PDT)
Received: from anparri.mshome.net (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id ke11-20020a17090798eb00b006e7fbf53398sm3531341ejc.129.2022.04.06.21.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 21:32:20 -0700 (PDT)
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
Subject: [PATCH 6/6] PCI: hv: Fix synchronization between channel callback and hv_compose_msi_msg()
Date:   Thu,  7 Apr 2022 06:30:28 +0200
Message-Id: <20220407043028.379534-7-parri.andrea@gmail.com>
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
The "Fixes:" tag is mainly a reference: a back-port would depend
on the entire series (which, in turn, shouldn't be backported to
commits preceding bf5fd8cae3c8f).

 drivers/pci/controller/pci-hyperv.c | 33 +++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index c1322ac37cda9..f1d794f8a5ef1 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1695,7 +1695,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 			struct pci_create_interrupt3 v3;
 		} int_pkts;
 	} __packed ctxt;
-
+	u64 trans_id;
 	u32 size;
 	int ret;
 
@@ -1757,10 +1757,10 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
@@ -1839,6 +1839,15 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
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
+	vmbus_request_addr_match(channel, trans_id, (unsigned long)&ctxt.pci_pkt);
 free_int_desc:
 	kfree(int_desc);
 drop_reference:
@@ -2717,6 +2726,7 @@ static void hv_pci_onchannelcallback(void *context)
 	struct pci_dev_inval_block *inval;
 	struct pci_dev_incoming *dev_message;
 	struct hv_pci_dev *hpdev;
+	unsigned long flags;
 
 	buffer = kmalloc(bufferlen, GFP_ATOMIC);
 	if (!buffer)
@@ -2751,8 +2761,11 @@ static void hv_pci_onchannelcallback(void *context)
 		switch (desc->type) {
 		case VM_PKT_COMP:
 
-			req_addr = chan->request_addr_callback(chan, req_id);
+			lock_requestor(chan, flags);
+			req_addr = __vmbus_request_addr_match(chan, req_id,
+							      VMBUS_RQST_ADDR_ANY);
 			if (req_addr == VMBUS_RQST_ERROR) {
+				unlock_requestor(chan, flags);
 				dev_warn_ratelimited(&hbus->hdev->device,
 						     "Invalid transaction ID %llx\n",
 						     req_id);
@@ -2760,9 +2773,17 @@ static void hv_pci_onchannelcallback(void *context)
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
+			unlock_requestor(chan, flags);
 			break;
 
 		case VM_PKT_DATA_INBAND:
-- 
2.25.1

