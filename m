Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105704A99A6
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Feb 2022 14:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348766AbiBDNFb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 08:05:31 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:46190 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353272AbiBDNFW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 08:05:22 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6D88072C905;
        Fri,  4 Feb 2022 16:05:21 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id 4E3104A470D;
        Fri,  4 Feb 2022 16:05:21 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>
Subject: [PATCH v3] drivers: hv: vmbus: Fix build on Clang 12 failed by DMA_BIT_MASK(64) expansion
Date:   Fri,  4 Feb 2022 16:05:03 +0300
Message-Id: <20220204130503.76738-1-vt@altlinux.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Clang 12.0.1 cannot understand that value 64 is excluded from the shift
at compile time (for use in global context) resulting in build error:

  drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
  static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
			      ^~~~~~~~~~~~~~~~
  ./include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
  #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
						       ^ ~~~

Avoid using DMA_BIT_MASK macro for that corner case.

Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 drivers/hv/vmbus_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 17bf55fe3169..a1306ca15d3f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2079,7 +2079,8 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 	return child_device_obj;
 }
 
-static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
+/* Use ~0ULL instead of DMA_BIT_MASK(64) to work around a bug in Clang. */
+static u64 vmbus_dma_mask = ~0ULL;
 /*
  * vmbus_device_register - Register the child device
  */
-- 
2.33.0

