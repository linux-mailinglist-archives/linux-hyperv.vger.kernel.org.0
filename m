Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBEB4A924B
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Feb 2022 03:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiBDC1G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 21:27:06 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:45702 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiBDC1G (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 21:27:06 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1724A72C905;
        Fri,  4 Feb 2022 05:27:05 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id E9B1C4A46F0;
        Fri,  4 Feb 2022 05:27:04 +0300 (MSK)
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
Subject: [PATCH v2] drivers: hv: vmbus: Fix build on Clang 12 failed by DMA_BIT_MASK(64) expansion
Date:   Fri,  4 Feb 2022 05:26:27 +0300
Message-Id: <20220204022627.4183515-1-vt@altlinux.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Clang 12.0.1 cannot understand that value 64 is excluded from the shift
at compile time (for use in global context) resulting in build error[1]:

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
Link: https://lore.kernel.org/linux-hyperv/20220203235828.hcsj6najsl7yxmxa@altlinux.org/
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Changes since v1:
- Patch description updated, s/GCC 11/Clang 12/.

 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 17bf55fe3169..2376ee484362 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2079,7 +2079,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 	return child_device_obj;
 }
 
-static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
+static u64 vmbus_dma_mask = ~0ULL;
 /*
  * vmbus_device_register - Register the child device
  */
-- 
2.33.0

