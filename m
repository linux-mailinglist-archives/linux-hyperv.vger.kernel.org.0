Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C4048BBE3
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 01:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347233AbiALAda (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Jan 2022 19:33:30 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52306 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236299AbiALAd3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Jan 2022 19:33:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V1c8Vp-_1641947606;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1c8Vp-_1641947606)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Jan 2022 08:33:26 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     helgaas@kernel.org, kys@microsoft.com
Cc:     sunilmut@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, mikelley@microsoft.com, maz@kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] PCI: hv: Fix an ignored error return from bitmap_find_free_region()
Date:   Wed, 12 Jan 2022 08:33:24 +0800
Message-Id: <20220112003324.62755-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

An error return from bitmap_find_free_region() is currently ignored 
and we instead return a completely bogus *hwirq from 
hv_pci_vec_alloc_device_irq().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: c10bdb758ca4 ("PCI: hv: Add arm64 Hyper-V vPCI support")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

Change in v2:
--According to Bjorn's suggestion, the corresponding changes were made.
  https://lore.kernel.org/lkml/20220111155412.GA142851@bhelgaas/

 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 26c9c8ec0989..20ea2ee330b8 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -701,7 +701,7 @@ static int hv_pci_vec_alloc_device_irq(struct irq_domain *domain,
 				       irq_hw_number_t *hwirq)
 {
 	struct hv_pci_chip_data *chip_data = domain->host_data;
-	unsigned int index;
+	int index;
 
 	/* Find and allocate region from the SPI bitmap */
 	mutex_lock(&chip_data->map_lock);
-- 
2.20.1.7.g153144c

