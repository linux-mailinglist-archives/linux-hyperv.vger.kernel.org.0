Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0BE5E7D61
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiIWOl3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Sep 2022 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiIWOlZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Sep 2022 10:41:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B6962C6;
        Fri, 23 Sep 2022 07:41:23 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYvt55vckzHpsy;
        Fri, 23 Sep 2022 22:39:09 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 22:41:21 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 22:41:21 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-rdma@vger.kernel.org>, <linux-hyperv@vger.kernel.org>
CC:     <longli@microsoft.com>, <jgg@nvidia.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] RDMA/mana_ib: change mana_ib_dev_ops to static
Date:   Fri, 23 Sep 2022 22:48:09 +0800
Message-ID: <20220923144809.108030-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

mana_ib_dev_ops is only used in device.c now, change it
to static.

Fixes: 6dce3468a04c ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/infiniband/hw/mana/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index c0a5a37583ff..4724af751f33 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -10,7 +10,7 @@ MODULE_DESCRIPTION("Microsoft Azure Network Adapter IB driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(NET_MANA);
 
-const struct ib_device_ops mana_ib_dev_ops = {
+static const struct ib_device_ops mana_ib_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_MANA,
 	.uverbs_abi_ver = MANA_IB_UVERBS_ABI_VERSION,
-- 
2.25.1

