Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5E35DBB3
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 11:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbhDMJtm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 05:49:42 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59259 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241048AbhDMJtl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 05:49:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVRjtdp_1618307360;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UVRjtdp_1618307360)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 13 Apr 2021 17:49:20 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] Drivers: hv: vmbus: remove unused including <linux/version.h>
Date:   Tue, 13 Apr 2021 17:49:18 +0800
Message-Id: <1618307358-74492-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix the following versioncheck warning:
./drivers/hv/hv.c: 16 linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/hv/hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index f202ac7..2c3ae4d 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/hyperv.h>
-#include <linux/version.h>
 #include <linux/random.h>
 #include <linux/clockchips.h>
 #include <clocksource/hyperv_timer.h>
-- 
1.8.3.1

