Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F132E38FF9D
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 May 2021 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhEYLAS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 May 2021 07:00:18 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33171 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229581AbhEYLAR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 May 2021 07:00:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ua4Ghke_1621940322;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Ua4Ghke_1621940322)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 May 2021 18:58:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] drivers: hv: Fix missing error code in vmbus_connect()
Date:   Tue, 25 May 2021 18:58:41 +0800
Message-Id: <1621940321-72353-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Eliminate the follow smatch warning:

drivers/hv/connection.c:236 vmbus_connect() warn: missing error code
'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hv/connection.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 311cd00..5e479d5 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -232,8 +232,10 @@ int vmbus_connect(void)
 	 */
 
 	for (i = 0; ; i++) {
-		if (i == ARRAY_SIZE(vmbus_versions))
+		if (i == ARRAY_SIZE(vmbus_versions)) {
+			ret = -EDOM;
 			goto cleanup;
+		}
 
 		version = vmbus_versions[i];
 		if (version > max_version)
-- 
1.8.3.1

