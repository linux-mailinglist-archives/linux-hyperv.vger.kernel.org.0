Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A3B77778A
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Aug 2023 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjHJLwQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Aug 2023 07:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjHJLwQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Aug 2023 07:52:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAF61BD;
        Thu, 10 Aug 2023 04:52:15 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM4x34fsgzTmR6;
        Thu, 10 Aug 2023 19:50:15 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 19:52:12 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu@kernel.org>, <decui@microsoft.com>
CC:     <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH -next] hv_netvsc: Remove duplicated include
Date:   Thu, 10 Aug 2023 19:51:48 +0800
Message-ID: <20230810115148.21332-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Remove duplicated include of linux/slab.h.  Resolves checkincludes message.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 drivers/net/hyperv/rndis_filter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index af95947a87c5..ecc2128ca9b7 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -21,7 +21,6 @@
 #include <linux/rtnetlink.h>
 #include <linux/ucs2_string.h>
 #include <linux/string.h>
-#include <linux/slab.h>
 
 #include "hyperv_net.h"
 #include "netvsc_trace.h"
-- 
2.17.1

