Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B19520704
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 May 2022 23:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiEIVym (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 May 2022 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiEIVxt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 May 2022 17:53:49 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9246D2CBF9A;
        Mon,  9 May 2022 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652132925; x=1683668925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kSh9rognUJ9GvISoKyUUnljnlRfgqjYQC5CisD4UWYY=;
  b=KpBp7f0SfO8iQPereyCpnwGx6PTV4aYefWyq0E0xJx1o0JWjtMetN9WX
   ZAXu+3dACs68FaIbFetx0z4aElXF7uW37hJGpSWywSE3g7fdb8XKeN3MZ
   iXg6Qt4PV5LkJS9oGZ/Mbdqjhk8hgUxvkcfol5KXb92CmTgAcf+X8RHV6
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 14:48:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 14:48:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 14:48:37 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 14:48:35 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>
CC:     <jakeo@microsoft.com>, <dazhan@microsoft.com>,
        <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 1/2] PCI: hv: Reuse existing ITRE allocation in compose_msi_msg()
Date:   Mon, 9 May 2022 15:48:21 -0600
Message-ID: <1652132902-27109-2-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
References: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently if compose_msi_msg() is called multiple times, it will free any
previous ITRE allocation, and generate a new allocation.  While nothing
prevents this from occurring, it is extranious when Linux could just reuse
the existing allocation and avoid a bunch of overhead.

However, when future ITRE allocations operate on blocks of MSIs instead of
a single line, freeing the allocation will impact all of the lines.  This
could cause an issue where an allocation of N MSIs occurs, then some of
the lines are retargeted, and finally the allocation is freed/reallocated.
The freeing of the allocation removes all of the configuration for the
entire block, which requires all the lines to be retargeted, which might
not happen since some lines might already be unmasked/active.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/pci/controller/pci-hyperv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cf2fe575..5e2e637 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1707,6 +1707,15 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	u32 size;
 	int ret;
 
+	/* Reuse the previous allocation */
+	if (data->chip_data) {
+		int_desc = data->chip_data;
+		msg->address_hi = int_desc->address >> 32;
+		msg->address_lo = int_desc->address & 0xffffffff;
+		msg->data = int_desc->data;
+		return;
+	}
+
 	pdev = msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
 	dest = irq_data_get_effective_affinity_mask(data);
 	pbus = pdev->bus;
@@ -1716,13 +1725,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	if (!hpdev)
 		goto return_null_message;
 
-	/* Free any previous message that might have already been composed. */
-	if (data->chip_data) {
-		int_desc = data->chip_data;
-		data->chip_data = NULL;
-		hv_int_desc_free(hpdev, int_desc);
-	}
-
 	int_desc = kzalloc(sizeof(*int_desc), GFP_ATOMIC);
 	if (!int_desc)
 		goto drop_reference;
-- 
2.7.4

