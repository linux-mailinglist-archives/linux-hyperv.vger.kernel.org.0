Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867BC48A509
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jan 2022 02:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbiAKB0b (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Jan 2022 20:26:31 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54865 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243671AbiAKB01 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Jan 2022 20:26:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V1X3B4-_1641864384;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1X3B4-_1641864384)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Jan 2022 09:26:25 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] PCI: hv: Unsigned comparison with less than zero
Date:   Tue, 11 Jan 2022 09:26:22 +0800
Message-Id: <20220111012622.19447-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The return from the call to bitmap_find_free_region() is int, it can be
a negative error code, however this is being assigned to an unsigned
int variable 'index', so making 'index' an int.

Eliminate the following coccicheck warning:
./drivers/pci/controller/pci-hyperv.c:712:5-10: WARNING: Unsigned
expression compared with zero: index < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
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

