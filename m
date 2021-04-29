Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FEF36E899
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Apr 2021 12:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhD2KWS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Apr 2021 06:22:18 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59306 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237774AbhD2KWR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Apr 2021 06:22:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UX9ogQY_1619691683;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UX9ogQY_1619691683)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Apr 2021 18:21:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] hv_balloon: Remove redundant assignment to region_start
Date:   Thu, 29 Apr 2021 18:21:21 +0800
Message-Id: <1619691681-86256-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Variable region_start is set to pg_start but this value is never
read as it is overwritten later on, hence it is a redundant
assignment and can be removed.

Cleans up the following clang-analyzer warning:

drivers/hv/hv_balloon.c:1013:3: warning: Value stored to 'region_start'
is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hv/hv_balloon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 58af84e..7f11ea0 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1010,7 +1010,6 @@ static void hot_add_req(struct work_struct *dummy)
 		 * that need to be hot-added while ensuring the alignment
 		 * and size requirements of Linux as it relates to hot-add.
 		 */
-		region_start = pg_start;
 		region_size = (pfn_cnt / HA_CHUNK) * HA_CHUNK;
 		if (pfn_cnt % HA_CHUNK)
 			region_size += HA_CHUNK;
-- 
1.8.3.1

