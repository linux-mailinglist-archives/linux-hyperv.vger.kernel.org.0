Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985B2506C5B
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 14:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352331AbiDSM1D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 08:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352332AbiDSM0v (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 08:26:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F453630B;
        Tue, 19 Apr 2022 05:24:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 11so15996928edw.0;
        Tue, 19 Apr 2022 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9vVuKoFEUiAyR7uHlRWZOSe/ValeOqxLUrvDR3GU6A=;
        b=UI3zSmDvVjSx3x59YT49ml46fOa2/gH7mpzyEwcgftQOKtwNdEbUOAIDY5Q/hL+sKA
         uzbTUVkfv1BmEvyNIWb0Cz5mO5pJlCp9Jejgc72KTEnk5HFyD7ZMi7VUuT4fpzmc9u37
         JGAjUj7WXDODpzlE1+42uBEPfS1GBjcBfBPEWkB+kE7B74d8QtO/fzawhGQ3OSPy9qR6
         yMYCRDl1xNLOTOpefyVWmpteVpSkFKbwNHoUJSTewIv3OMro7YfCFCcamI9UP0igBszl
         9dfO6IOIlSQUyKkwF2pW9dErF2UVDUtT06YMgaarnGBMGLlUdR0/N6uQNcOa70mNbFxY
         THnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9vVuKoFEUiAyR7uHlRWZOSe/ValeOqxLUrvDR3GU6A=;
        b=Fwclr8NzuzrKB7uIZmQRsIyv189cJxrICuOcoOfUk/7/+dmT7/dLVnWVgvBwvv7oNj
         MnszkuH8hYTGk+I9VBYNaNUAP05+J5nvfzxFzHSJ/aTDgXrgwMj2oNg4t3k/zvxp87ME
         dvWfRTA7YBBQsGawi+QBEaseb64oJJ9jHgHUxPqYTfWpiunvgd7XnYa1aS0dbaZOQ+U5
         Zq7KNJt1donL5EmfXZALX2Ta7mlxZzJqkEA8dEp2h4ha7atb2veGgzsErIkeo6PP2xfi
         crZZpn3Eyv7T75GjhoX6Y2i2/lpf09d0okYsgB8fv2F24a5D4rBhMjcGBAtxYMBW6iwl
         n/Aw==
X-Gm-Message-State: AOAM532mgSRL2aiwRfelHF9cUIeJE7zyFaINVCpgpHOlBT2MDHIsyT/a
        AXh/vOgA3x7vfb0Qnv0UD3M=
X-Google-Smtp-Source: ABdhPJwER2iIHbaJTcgShZKvo6stLL+1j9ZpSjYitNR6t4O4i1nSfwp/iVr7lNu+bDxW/YOV0NKekA==
X-Received: by 2002:aa7:dcd3:0:b0:41d:70e4:bf4d with SMTP id w19-20020aa7dcd3000000b0041d70e4bf4dmr17093932edu.223.1650371046380;
        Tue, 19 Apr 2022 05:24:06 -0700 (PDT)
Received: from anparri.mshome.net (host-82-53-3-95.retail.telecomitalia.it. [82.53.3.95])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm5644685ejm.189.2022.04.19.05.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:24:05 -0700 (PDT)
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
Subject: [PATCH v2 6/6] PCI: hv: Fix synchronization between channel callback and hv_compose_msi_msg()
Date:   Tue, 19 Apr 2022 14:23:25 +0200
Message-Id: <20220419122325.10078-7-parri.andrea@gmail.com>
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

Reported-by: Wei Hu <weh@microsoft.com>
Reported-by: Dexuan Cui <decui@microsoft.com>
Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
v1 included:

Fixes: de0aa7b2f97d3 ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")

as a reference, but not a reference for the stable-kernel bots.
The back-port would depend on the entire series which, in turn,
shouldn't be backported to commits preceding bf5fd8cae3c8f.

 drivers/pci/controller/pci-hyperv.c | 33 +++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 0252b4bbc8d15..59f0197b94c78 100644
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
 				dev_err(&hbus->hdev->device,
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

