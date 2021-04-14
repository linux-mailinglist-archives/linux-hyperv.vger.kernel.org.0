Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5014C35ED27
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 08:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349193AbhDNGWA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 02:22:00 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:34361 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232405AbhDNGVv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 02:21:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVWCFKV_1618381283;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVWCFKV_1618381283)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 14:21:28 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] Drivers: hv: vmbus: remove unused function
Date:   Wed, 14 Apr 2021 14:21:22 +0800
Message-Id: <1618381282-119135-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix the following clang warning:

drivers/hv/ring_buffer.c:89:1: warning: unused function
'hv_set_next_read_location' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hv/ring_buffer.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 35833d4..78d4043 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -84,15 +84,6 @@ static void hv_signal_on_write(u32 old_write, struct vmbus_channel *channel)
 	ring_info->ring_buffer->write_index = next_write_location;
 }
 
-/* Set the next read location for the specified ring buffer. */
-static inline void
-hv_set_next_read_location(struct hv_ring_buffer_info *ring_info,
-		    u32 next_read_location)
-{
-	ring_info->ring_buffer->read_index = next_read_location;
-	ring_info->priv_read_index = next_read_location;
-}
-
 /* Get the size of the ring buffer. */
 static inline u32
 hv_get_ring_buffersize(const struct hv_ring_buffer_info *ring_info)
-- 
1.8.3.1

