Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E12290CB2
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Aug 2019 06:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfHQEJL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 17 Aug 2019 00:09:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38202 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQEJL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 17 Aug 2019 00:09:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id x4so8334605qts.5;
        Fri, 16 Aug 2019 21:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U5MFZKofzxf5IBLkI1H8UJY19VilCbeaQyBrCBQScso=;
        b=Q/I3qCqAHB5xClj/4hdquph+bTauZHKS3JUc0m5lkYvWR2K9x4ofE24hyDBwIVfx4V
         5dnq0wWy64xwjVljmP1fAm2QFlYOXGl2UNfTNpUThe/At8Y7PCxydL0askpjDmyanlo3
         S4QPJkbEGdoto06WDxKBieSmRWPblhws+Y/Wa3tBqIK9oOiy1fHGvdIzCbijS0QwqYVl
         TX0ufZujwJFJs3KUQxGdAmrmvnMCdI5y4/XDznr4huks/JwLBcYkSJCwY3ZX6p7OrPqj
         EAs+bBN0wvyPBe44jFebErLOthU3jxkuN/U4AlU2HA6qO5W4urvWZgZxr6wy4ik1a6e2
         VcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U5MFZKofzxf5IBLkI1H8UJY19VilCbeaQyBrCBQScso=;
        b=UIBrkLzaF8RjBfdM/XbjATH/CtGGzyabxj6NHSRS2p1ltOcNC+zRWCrEvMa22hEXvb
         TL297U1R1tXEQozWwWDlfPeGeLKPCYFCZdijYOtBqN2K2Mq92+OglVhdNaTHbpvpf1/E
         /hqddXo++1xD5RgZzf272dQUaoWkyLYfwh8IoamU+nmGHfaLI0T1wNQjew2Gn2YnTVXu
         1kr3qp/cjoD78e2xDpT2BOuYTL72z5GR1j63k/Av6Koqmvlw5ePM3ycIp8Awa8mrVSXt
         hM3Pp90p9Bm12ZKIeqxFKhiP3ijCLu32cIO4sfsV6sVmNCs/zfYSHn8VehpnCZP3eZe3
         09Cw==
X-Gm-Message-State: APjAAAUZuEDbBCQ4aivMW2UdgX15Z+5RjBALwFjNlTs7RVLf0Gc0xNHC
        29EQOTKlIgVzuSLoJZCX+uQ=
X-Google-Smtp-Source: APXvYqxsDvy12wIWRB4+aqdWFtE31nAl3Qg2e/vbCuklD9bx/wuEgoP/vOU+Bpll2XY1dAcGgRu6NA==
X-Received: by 2002:ac8:1654:: with SMTP id x20mr12012632qtk.349.1566014950138;
        Fri, 16 Aug 2019 21:09:10 -0700 (PDT)
Received: from Hyper-V ([23.96.94.62])
        by smtp.gmail.com with ESMTPSA id h26sm4239578qta.58.2019.08.16.21.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:09:09 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
X-Google-Original-From: Himadri Pandya <himadri18.07@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, mikelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH] Drivers: hv: balloon: Remove dependencies on guest page size
Date:   Sat, 17 Aug 2019 04:08:50 +0000
Message-Id: <20190817040850.4812-1-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V assumes page size to be 4K. This might not be the case for
ARM64 architecture. Hence use hyper-v specific page size and page
shift definitions to avoid conflicts between different host and guest
page sizes on ARM64.

Also, remove some old and incorrect comments and redefine ballooning
granularities to handle larger page sizes correctly.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
 drivers/hv/hv_balloon.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 34bd73526afd..935904830d42 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -23,6 +23,7 @@
 #include <linux/percpu_counter.h>
 
 #include <linux/hyperv.h>
+#include <asm/hyperv-tlfs.h>
 
 #define CREATE_TRACE_POINTS
 #include "hv_trace_balloon.h"
@@ -341,8 +342,6 @@ struct dm_unballoon_response {
  *
  * mem_range: Memory range to hot add.
  *
- * On Linux we currently don't support this since we cannot hot add
- * arbitrary granularity of memory.
  */
 
 struct dm_hot_add {
@@ -477,7 +476,7 @@ module_param(pressure_report_delay, uint, (S_IRUGO | S_IWUSR));
 MODULE_PARM_DESC(pressure_report_delay, "Delay in secs in reporting pressure");
 static atomic_t trans_id = ATOMIC_INIT(0);
 
-static int dm_ring_size = (5 * PAGE_SIZE);
+static int dm_ring_size = 20 * 1024;
 
 /*
  * Driver specific state.
@@ -493,10 +492,10 @@ enum hv_dm_state {
 };
 
 
-static __u8 recv_buffer[PAGE_SIZE];
-static __u8 balloon_up_send_buffer[PAGE_SIZE];
-#define PAGES_IN_2M	512
-#define HA_CHUNK (32 * 1024)
+static __u8 recv_buffer[HV_HYP_PAGE_SIZE];
+static __u8 balloon_up_send_buffer[HV_HYP_PAGE_SIZE];
+#define PAGES_IN_2M (2 * 1024 * 1024 / PAGE_SIZE)
+#define HA_CHUNK (128 * 1024 * 1024 / PAGE_SIZE)
 
 struct hv_dynmem_device {
 	struct hv_device *dev;
@@ -1076,7 +1075,7 @@ static void process_info(struct hv_dynmem_device *dm, struct dm_info_msg *msg)
 			__u64 *max_page_count = (__u64 *)&info_hdr[1];
 
 			pr_info("Max. dynamic memory size: %llu MB\n",
-				(*max_page_count) >> (20 - PAGE_SHIFT));
+				(*max_page_count) >> (20 - HV_HYP_PAGE_SHIFT));
 		}
 
 		break;
@@ -1218,7 +1217,7 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 
 	for (i = 0; (i * alloc_unit) < num_pages; i++) {
 		if (bl_resp->hdr.size + sizeof(union dm_mem_page_range) >
-			PAGE_SIZE)
+			HV_HYP_PAGE_SIZE)
 			return i * alloc_unit;
 
 		/*
@@ -1274,9 +1273,9 @@ static void balloon_up(struct work_struct *dummy)
 
 	/*
 	 * We will attempt 2M allocations. However, if we fail to
-	 * allocate 2M chunks, we will go back to 4k allocations.
+	 * allocate 2M chunks, we will go back to PAGE_SIZE allocations.
 	 */
-	alloc_unit = 512;
+	alloc_unit = PAGES_IN_2M;
 
 	avail_pages = si_mem_available();
 	floor = compute_balloon_floor();
@@ -1292,7 +1291,7 @@ static void balloon_up(struct work_struct *dummy)
 	}
 
 	while (!done) {
-		memset(balloon_up_send_buffer, 0, PAGE_SIZE);
+		memset(balloon_up_send_buffer, 0, HV_HYP_PAGE_SIZE);
 		bl_resp = (struct dm_balloon_response *)balloon_up_send_buffer;
 		bl_resp->hdr.type = DM_BALLOON_RESPONSE;
 		bl_resp->hdr.size = sizeof(struct dm_balloon_response);
@@ -1491,7 +1490,7 @@ static void balloon_onchannelcallback(void *context)
 
 	memset(recv_buffer, 0, sizeof(recv_buffer));
 	vmbus_recvpacket(dev->channel, recv_buffer,
-			 PAGE_SIZE, &recvlen, &requestid);
+			 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
 
 	if (recvlen > 0) {
 		dm_msg = (struct dm_message *)recv_buffer;
-- 
2.17.1

