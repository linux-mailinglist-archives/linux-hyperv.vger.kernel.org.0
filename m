Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD7C519FFF
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 May 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350048AbiEDMyq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 May 2022 08:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350025AbiEDMyn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 May 2022 08:54:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA3340DF;
        Wed,  4 May 2022 05:51:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l18so2675774ejc.7;
        Wed, 04 May 2022 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4oUj7O1NwJKsfpkZYyH3UkjfTQ0Yjl6gl4HxIj+8zVw=;
        b=MEb2d+PxSJCuqZOwnllnt/62Wd7GMRUtBYnzNjs1ff4SKu/3pNBjnpeboa0sajWeJp
         89hF2rFzTdEKo5hnkFVjq2JBX0Ky70LKfZGDIJBiGJljv7pcb8/uvG9JNunt0wq4hgad
         VYwy9I5C6Ns1qPuCxNbIqi1j6ze7sEueUidGiMDOUpA8eq4eIZ1ew9Qua9CQdsHSllEU
         nU2g5QaYxUtQe0nvMuD78LLBTlaod7OTxK9wC/P0h/GbJo+x/RBsRQCS/KPTdU0P76ZC
         zCXARGNTDcY0fTpIK02bJM0KBij9teAtnDVn76mBRYqBcoKf5dUo6O9M25Qcp74HGAvL
         pl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4oUj7O1NwJKsfpkZYyH3UkjfTQ0Yjl6gl4HxIj+8zVw=;
        b=oacBXH+TpRFsdA/SE9mykVZ6kKiQJDKAFJgb3/5g4jSVW4nDPId+dRlaUeE0TGErew
         9OfYovcy3atvhsS8xCR8cC64M4NYEz+zPrd/8klOBVcS44BmGtGt8S+Ws/T+4ETG5JBM
         tSb7txjqvFFy/AIsuLp+tfp2Gr8QRHT3zk6SdU7cSMSAzlmHQJjQOAMqGAt4VaNDoNMp
         R2SLfXvcoKQlqS8zPY/O5EMotyNChFqwFdUjXwUESHec3zcWJchO9Q7tXmm5eJ5ZWPSB
         8PlngQm46ABUnk6RLHdubpbk9v1zY7dgowuCRkljDpIZQ6YJQ2XXTrvcKXOUEu8kt6eP
         w02w==
X-Gm-Message-State: AOAM5304yNc6FThkEFZgBfbV1mG/psJFzuk4LRioB6HPCd72dYgkTqKv
        3lAa76a09mbyybh6u0uVlhc=
X-Google-Smtp-Source: ABdhPJzKz5xW6gV7XNgNc0HAq4cChXpUz/hEyX9kk5b86BCBFvkIE27EFe9Pe8Mk0bZ1ZMgwJEuCEA==
X-Received: by 2002:a17:906:8301:b0:6e4:896d:59b1 with SMTP id j1-20020a170906830100b006e4896d59b1mr19397788ejx.396.1651668665762;
        Wed, 04 May 2022 05:51:05 -0700 (PDT)
Received: from anparri.mshome.net (host-2-117-178-169.business.telecomitalia.it. [2.117.178.169])
        by smtp.gmail.com with ESMTPSA id hz7-20020a1709072ce700b006f3ef214dc9sm5743045ejc.47.2022.05.04.05.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:51:05 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 2/2] PCI: hv: Fix synchronization between channel callback and hv_pci_bus_exit()
Date:   Wed,  4 May 2022 14:50:39 +0200
Message-Id: <20220504125039.2598-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504125039.2598-1-parri.andrea@gmail.com>
References: <20220504125039.2598-1-parri.andrea@gmail.com>
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

[ Similarly to commit a765ed47e4516 ("PCI: hv: Fix synchronization
  between channel callback and hv_compose_msi_msg()"): ]

The (on-stack) teardown packet becomes invalid once the completion
timeout in hv_pci_bus_exit() has expired and hv_pci_bus_exit() has
returned.  Prevent the channel callback from accessing the invalid
packet by removing the ID associated to such packet from the VMbus
requestor in hv_pci_bus_exit().

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9a3e17b682eb7..db4b3f86726b2 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3620,6 +3620,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 {
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
+	struct vmbus_channel *chan = hdev->channel;
 	struct {
 		struct pci_packet teardown_packet;
 		u8 buffer[sizeof(struct pci_message)];
@@ -3627,13 +3628,14 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 	struct hv_pci_compl comp_pkt;
 	struct hv_pci_dev *hpdev, *tmp;
 	unsigned long flags;
+	u64 trans_id;
 	int ret;
 
 	/*
 	 * After the host sends the RESCIND_CHANNEL message, it doesn't
 	 * access the per-channel ringbuffer any longer.
 	 */
-	if (hdev->channel->rescind)
+	if (chan->rescind)
 		return 0;
 
 	if (!keep_devs) {
@@ -3670,16 +3672,26 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 	pkt.teardown_packet.compl_ctxt = &comp_pkt;
 	pkt.teardown_packet.message[0].type = PCI_BUS_D0EXIT;
 
-	ret = vmbus_sendpacket(hdev->channel, &pkt.teardown_packet.message,
-			       sizeof(struct pci_message),
-			       (unsigned long)&pkt.teardown_packet,
-			       VM_PKT_DATA_INBAND,
-			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	ret = vmbus_sendpacket_getid(chan, &pkt.teardown_packet.message,
+				     sizeof(struct pci_message),
+				     (unsigned long)&pkt.teardown_packet,
+				     &trans_id, VM_PKT_DATA_INBAND,
+				     VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret)
 		return ret;
 
-	if (wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ) == 0)
+	if (wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ) == 0) {
+		/*
+		 * The completion packet on the stack becomes invalid after
+		 * 'return'; remove the ID from the VMbus requestor if the
+		 * identifier is still mapped to/associated with the packet.
+		 *
+		 * Cf. hv_pci_onchannelcallback().
+		 */
+		vmbus_request_addr_match(chan, trans_id,
+					 (unsigned long)&pkt.teardown_packet);
 		return -ETIMEDOUT;
+	}
 
 	return 0;
 }
-- 
2.25.1

