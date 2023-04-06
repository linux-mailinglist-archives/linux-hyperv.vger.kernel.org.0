Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BFD6DB58C
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Apr 2023 22:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjDGU6W (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Apr 2023 16:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjDGU6T (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Apr 2023 16:58:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45E1AC17E;
        Fri,  7 Apr 2023 13:58:17 -0700 (PDT)
Received: from skinsburskii.localdomain (unknown [131.107.1.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id AE674213B634;
        Fri,  7 Apr 2023 13:58:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE674213B634
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680901096;
        bh=32mhPLCSnFqlWC0muL7q44icEI++yknNcaEQIU1ZLvE=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=rLRQUe03PQBMKbXvSZ/VJWDxgdc9PySimsj3H5+d3DxKwZjzOd7WeHSUUetID2zxh
         nayWNjg4p5Co3J52iHGyG4JgzQm14NIt/oJhXv8wMvDRwEzY6CKH3KWd94mThdmOxA
         wVJYjO39KNVcye7uCLbs6BOrthe+MQi/hGzv8c+c=
Subject: [PATCH 2/2] PCI: hv: Deal with nested MSHV setup
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Apr 2023 09:33:24 -0700
Message-ID: <168079879905.14175.16212926378045082102.stgit@skinsburskii.localdomain>
In-Reply-To: <168079806973.14175.17999267023207421381.stgit@skinsburskii.localdomain>
References: <168079806973.14175.17999267023207421381.stgit@skinsburskii.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.2 required=5.0 tests=DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>

Running Microsoft hypervisor as nested (i.e., on top of another Microsoft
hypervisor) imposes a different requirement for the PCI-hyperv controller.

In this setup, the interrupt will first come to the nested (L1) hypervisor
from the hypervisor, running on bare metal (L0), and then the L1 hypervisor
will deliver the interrupt to the appropriate CPU of the nested root
partition.

Thus, instead of issuing the RETARGET hypercall to the L0 hypervisor,
MAP_DEVICE_INTERRUPT hypercall should be issued to the L1 hypervisor to
complete the interrupt setup.

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>
CC: Wei Liu <wei.liu@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Krzysztof Wilczyński" <kw@linux.com>
CC: Rob Herring <robh@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-hyperv@vger.kernel.org
CC: linux-pci@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/pci-hyperv.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index f33370b75628..61bee8babad4 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1570,7 +1570,16 @@ static void hv_irq_mask(struct irq_data *data)
 
 static void hv_irq_unmask(struct irq_data *data)
 {
-	hv_arch_irq_unmask(data);
+	if (hv_nested && hv_root_partition)
+		/*
+		 * In case of the nested root partition, the nested hypervisor
+		 * is taking care of interrupt remapping and thus the
+		 * MAP_DEVICE_INTERRUPT hypercall is required instead of the
+		 * RETARGET_INTERRUPT one.
+		 */
+		(void)hv_map_msi_interrupt(data, NULL);
+	else
+		hv_arch_irq_unmask(data);
 
 	if (data->parent_data->chip->irq_unmask)
 		irq_chip_unmask_parent(data);


