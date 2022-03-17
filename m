Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F824DC1E7
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 09:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiCQIxD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 04:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiCQIwv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 04:52:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B0F9F6E7;
        Thu, 17 Mar 2022 01:51:35 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KK1711QT5zfZ2D;
        Thu, 17 Mar 2022 16:50:05 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 16:51:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <boqun.feng@gmail.com>
CC:     <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] PCI: hv: Remove unused function hv_set_msi_entry_from_desc()
Date:   Thu, 17 Mar 2022 16:51:30 +0800
Message-ID: <20220317085130.36388-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch fix the following build error:

drivers/pci/controller/pci-hyperv.c:769:13: error: ‘hv_set_msi_entry_from_desc’ defined but not used [-Werror=unused-function]
  769 | static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,

On arm64 hv_set_msi_entry_from_desc() is not used anymore since
commit d06957d7a692 ("PCI: hv: Avoid the retarget interrupt hypercall in irq_unmask() on ARM64").

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/controller/pci-hyperv.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index df84d221e3de..558b35aba610 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -766,14 +766,6 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
 	return irqd->parent_data->hwirq;
 }
 
-static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
-				       struct msi_desc *msi_desc)
-{
-	msi_entry->address = ((u64)msi_desc->msg.address_hi << 32) |
-			      msi_desc->msg.address_lo;
-	msi_entry->data = msi_desc->msg.data;
-}
-
 /*
  * @nr_bm_irqs:		Indicates the number of IRQs that were allocated from
  *			the bitmap.
-- 
2.17.1

