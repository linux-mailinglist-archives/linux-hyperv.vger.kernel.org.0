Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D635BC2EE
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Sep 2022 08:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiISGij (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Sep 2022 02:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiISGii (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Sep 2022 02:38:38 -0400
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB1811471;
        Sun, 18 Sep 2022 23:38:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VQ716uf_1663569499;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VQ716uf_1663569499)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 14:38:31 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] Drivers: hv: vmbus: Fix kernel-doc
Date:   Mon, 19 Sep 2022 14:38:15 +0800
Message-Id: <20220919063815.1881-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

drivers/hv/vmbus_drv.c:1587: warning: expecting prototype for __vmbus_child_driver_register(). Prototype was for __vmbus_driver_register() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2210
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 7b9f3fc3adf7..621702a1725f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1573,7 +1573,7 @@ static int vmbus_bus_init(void)
 }
 
 /**
- * __vmbus_child_driver_register() - Register a vmbus's driver
+ * __vmbus_driver_register() - Register a vmbus's driver
  * @hv_driver: Pointer to driver structure you want to register
  * @owner: owner module of the drv
  * @mod_name: module name string
-- 
2.20.1.7.g153144c

