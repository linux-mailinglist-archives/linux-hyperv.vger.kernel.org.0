Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEEB6E74A1
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Apr 2023 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjDSIG2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Apr 2023 04:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjDSIG2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Apr 2023 04:06:28 -0400
X-Greylist: delayed 120 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Apr 2023 01:06:24 PDT
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 11FEC5FD1;
        Wed, 19 Apr 2023 01:06:23 -0700 (PDT)
Received: from who-virtual-machine (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 37A521835D256E;
        Wed, 19 Apr 2023 16:03:42 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Suhui <suhui@nfschina.com>
To:     "K . Y . Srinivasa" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suhui <suhui@nfschina.com>
Subject: [PATCH] Drivers: hv: vmbus: Remove unnecessary (void*) conversions
Date:   Wed, 19 Apr 2023 16:03:31 +0800
Message-Id: <20230419080331.505798-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No need cast (void*) to (struct hv_ring_buffer *).

Signed-off-by: Suhui <suhui@nfschina.com>
---
 drivers/hv/ring_buffer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index c6692fd5ab15..5471321169e9 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -209,9 +209,8 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 		for (i = 0; i < 2 * (page_cnt - 1); i++)
 			pfns_wraparound[i + 1] = pfn + i % (page_cnt - 1) + 1;
 
-		ring_info->ring_buffer = (struct hv_ring_buffer *)
-			vmap_pfn(pfns_wraparound, page_cnt * 2 - 1,
-				 PAGE_KERNEL);
+		ring_info->ring_buffer = vmap_pfn(pfns_wraparound, page_cnt * 2 - 1,
+						  PAGE_KERNEL);
 		kfree(pfns_wraparound);
 
 		if (!ring_info->ring_buffer)
@@ -231,9 +230,8 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 			pages_wraparound[i + 1] =
 				&pages[i % (page_cnt - 1) + 1];
 
-		ring_info->ring_buffer = (struct hv_ring_buffer *)
-			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
-				PAGE_KERNEL);
+		ring_info->ring_buffer = vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
+					      PAGE_KERNEL);
 
 		kfree(pages_wraparound);
 		if (!ring_info->ring_buffer)
-- 
2.34.1

