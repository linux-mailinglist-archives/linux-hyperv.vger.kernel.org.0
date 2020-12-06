Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EE22D02F2
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Dec 2020 11:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLFKuA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Dec 2020 05:50:00 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:52948 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgLFKuA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Dec 2020 05:50:00 -0500
X-Greylist: delayed 62343 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Dec 2020 05:49:59 EST
Received: from cip4d0.informatik.uni-erlangen.de (cip4d0.cip.cs.fau.de [IPv6:2001:638:a000:4160:131:188:60:59])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id CD27A240281;
        Sun,  6 Dec 2020 11:49:14 +0100 (CET)
Received: by cip4d0.informatik.uni-erlangen.de (Postfix, from userid 68457)
        id BA09FD8041C; Sun,  6 Dec 2020 11:49:14 +0100 (CET)
From:   Stefan Eschenbacher <stefan.eschenbacher@fau.de>
To:     Michael Kelley <mikelley@microsoft.com>,
        Max Stolze <max.stolze@fau.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Stefan Eschenbacher <stefan.eschenbacher@fau.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH] drivers/hv: remove obsolete TODO and fix misleading typo in comment
Date:   Sun,  6 Dec 2020 11:48:50 +0100
Message-Id: <20201206104850.24843-1-stefan.eschenbacher@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <MW2PR2101MB1052B86A1C6C9A64E8DDBA6ED7F01@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <MW2PR2101MB1052B86A1C6C9A64E8DDBA6ED7F01@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Removes an obsolete TODO in the VMBus module and fixes a misleading typo
in the comment for the macro MAX_NUM_CHANNELS, where two digits have been
twisted.

Signed-off-by: Stefan Eschenbacher <stefan.eschenbacher@fau.de>
Co-developed-by: Max Stolze <max.stolze@fau.de>
Signed-off-by: Max Stolze <max.stolze@fau.de>
---
 drivers/hv/hyperv_vmbus.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 02f3e8988836..9416e09ebd58 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -187,14 +187,13 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 		       u64 *requestid, bool raw);
 
 /*
- * The Maximum number of channels (16348) is determined by the size of the
+ * The Maximum number of channels (16384) is determined by the size of the
  * interrupt page, which is HV_HYP_PAGE_SIZE. 1/2 of HV_HYP_PAGE_SIZE is to
  * send endpoint interrupts, and the other is to receive endpoint interrupts.
  */
 #define MAX_NUM_CHANNELS	((HV_HYP_PAGE_SIZE >> 1) << 3)
 
 /* The value here must be in multiple of 32 */
-/* TODO: Need to make this configurable */
 #define MAX_NUM_CHANNELS_SUPPORTED	256
 
 #define MAX_CHANNEL_RELIDS					\
-- 
2.20.1

