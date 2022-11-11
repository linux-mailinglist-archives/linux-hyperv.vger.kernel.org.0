Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7167B624FE8
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Nov 2022 02:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiKKBuR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Nov 2022 20:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiKKBuQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Nov 2022 20:50:16 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F14B1C126
        for <linux-hyperv@vger.kernel.org>; Thu, 10 Nov 2022 17:50:15 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7hTz13yCz15MWs;
        Fri, 11 Nov 2022 09:49:59 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 09:50:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 09:50:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-hyperv@vger.kernel.org>
CC:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <yangyingliang@huawei.com>
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: fix double free in the error path of vmbus_add_channel_work()
Date:   Fri, 11 Nov 2022 09:48:46 +0800
Message-ID: <20221111014847.673576-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111014847.673576-1-yangyingliang@huawei.com>
References: <20221111014847.673576-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In the error path of vmbus_device_register(), device_unregister() is
called, hv_device has already been freed in vmbus_device_release(),
remove the kfree() in vmbus_add_channel_work() to avoid double free.

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/hv/channel_mgmt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 5b120402d405..576ebaf729a8 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -533,13 +533,15 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	 * Add the new device to the bus. This will kick off device-driver
 	 * binding which eventually invokes the device driver's AddDevice()
 	 * method.
+	 * If vmbus_device_register() fails, the 'device_obj' will be freed
+	 * in vmbus_device_release() in vmbus_device_register(). In the outside
+	 * error path, it's no need to free it.
 	 */
 	ret = vmbus_device_register(newchannel->device_obj);
 
 	if (ret != 0) {
 		pr_err("unable to add child device object (relid %d)\n",
 			newchannel->offermsg.child_relid);
-		kfree(newchannel->device_obj);
 		goto err_deq_chan;
 	}
 
-- 
2.25.1

