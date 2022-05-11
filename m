Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19228524054
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 May 2022 00:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbiEKWcd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348790AbiEKWc3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 18:32:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887666352A;
        Wed, 11 May 2022 15:32:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so6719425ejj.10;
        Wed, 11 May 2022 15:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBRuCmP2siWBRF1mJGIqu92AfzuFsib8CXOarE94Pec=;
        b=n2QnsrARZfRY2HojclW+Ojnkv82EmY9t8X1xvOClhSc9hBsIdUTj18Qqr5glQ49f2u
         xkvhWUhbW8uUjKrlcLSeiIS6AUV2FeHJMeoL8+AICZolXzMg9dsk1nRznkSdUSqbGJwa
         IDgj7Qbl/PG5cyyRWLnz+FGPUIcCBvgSMOA+QJ9SRIq9NP1rmwx/onl/+JD/TXuQrSRy
         JEAIJOPV8vxa0OADNhYNZqgjw4Bk7PSkw6yzWPWmOwcoseXQJwmrWeS1fiZof8VqOLHR
         k187oZoebyLihXoeQY9krZktcX8rUHhtaml9T2qOdVyWgYRgWqJ6huJf6kyUfqOUvpNy
         xojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBRuCmP2siWBRF1mJGIqu92AfzuFsib8CXOarE94Pec=;
        b=zlvFFN9tLXmg9xsB2gBNKO3skue8RMqlHX/z8hocrUaffeY8KAUeqRqxeZeeym4Z+z
         DGBJTjIuDieu53GCfbDMsBe0vtX3SSDHyTmIyZo8k9yeG8P+p09rV/peno/bq+LslCxp
         fyfAlihK5G9G2X7fIG6+QW6M3V5Gg4/Ogsm/a5H2g898Wijmvw6YeFsrz173YAlgVckI
         D/w7bOVgreMb91q7tMmo2EPpMRvHu+6DYUVM8lWOxvqwq46tDELDJLXfpf8yM8unNWuA
         u32Uh6ziekyMIE9Zo/k9yC9VWe3pTYuUEDBm3vHf35jFO3NqhaXML6XqaSkiOFFl7aiC
         qjkA==
X-Gm-Message-State: AOAM532TDewYaQS2flcbsgaWnEXFANybRwoEnJQQWkgnRqMiIHAgOHAM
        RtZ9P4Aw6PCP4acMclj2IYU=
X-Google-Smtp-Source: ABdhPJzvE2W+LU+8iVBW8Ghx0/iWtRXQlPYrP1RxK1o32UgdLkTxBTZlS+vImiPkDg5Ioe0IqYeYqg==
X-Received: by 2002:a17:906:6a10:b0:6f5:5e4:9d5 with SMTP id qw16-20020a1709066a1000b006f505e409d5mr26598518ejc.122.1652308347095;
        Wed, 11 May 2022 15:32:27 -0700 (PDT)
Received: from anparri.mshome.net (host-79-30-69-23.retail.telecomitalia.it. [79.30.69.23])
        by smtp.gmail.com with ESMTPSA id f1-20020a1709064dc100b006fa84a0af2asm1468456ejw.16.2022.05.11.15.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:32:26 -0700 (PDT)
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
Subject: [PATCH v2 2/2] PCI: hv: Fix synchronization between channel callback and hv_pci_bus_exit()
Date:   Thu, 12 May 2022 00:32:07 +0200
Message-Id: <20220511223207.3386-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511223207.3386-1-parri.andrea@gmail.com>
References: <20220511223207.3386-1-parri.andrea@gmail.com>
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index a06e2cf946580..db814f7b93baa 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3664,6 +3664,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 {
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
+	struct vmbus_channel *chan = hdev->channel;
 	struct {
 		struct pci_packet teardown_packet;
 		u8 buffer[sizeof(struct pci_message)];
@@ -3671,13 +3672,14 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
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
@@ -3714,16 +3716,26 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
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

