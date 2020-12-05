Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4922CFCAD
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Dec 2020 19:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgLESTT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Dec 2020 13:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgLESJP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Dec 2020 13:09:15 -0500
X-Greylist: delayed 127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Dec 2020 09:30:26 PST
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9386C02B8F1;
        Sat,  5 Dec 2020 09:30:26 -0800 (PST)
Received: from cip4d0.informatik.uni-erlangen.de (cip4d0.cip.cs.fau.de [IPv6:2001:638:a000:4160:131:188:60:59])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 77C0B241063;
        Sat,  5 Dec 2020 18:30:25 +0100 (CET)
Received: by cip4d0.informatik.uni-erlangen.de (Postfix, from userid 68457)
        id 7556ED8049E; Sat,  5 Dec 2020 18:30:25 +0100 (CET)
From:   Stefan Eschenbacher <stefan.eschenbacher@fau.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Stefan Eschenbacher <stefan.eschenbacher@fau.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Max Stolze <max.stolze@fau.de>
Subject: [PATCH 2/3] drivers/hv: fix misleading typo in comment
Date:   Sat,  5 Dec 2020 18:30:24 +0100
Message-Id: <20201205173024.2628-1-stefan.eschenbacher@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
References: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fixes a misleading typo in the comment for the macro MAX_NUM_CHANNELS,
where two digits have been twisted.

Signed-off-by: Stefan Eschenbacher <stefan.eschenbacher@fau.de>
Co-developed-by: Max Stolze <max.stolze@fau.de>
Signed-off-by: Max Stolze <max.stolze@fau.de>
---
 drivers/hv/hyperv_vmbus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index edeee1c0497d..52dcfa1c17ef 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -187,7 +187,7 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 		       u64 *requestid, bool raw);
 
 /*
- * The Maximum number of channels (16348) is determined by the size of the
+ * The Maximum number of channels (16384) is determined by the size of the
  * interrupt page, which is HV_HYP_PAGE_SIZE. 1/2 of HV_HYP_PAGE_SIZE is to
  * send endpoint interrupts, and the other is to receive endpoint interrupts.
  */
-- 
2.20.1

