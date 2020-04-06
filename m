Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713A619EED0
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 02:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgDFAQq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Apr 2020 20:16:46 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37329 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgDFAQq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Apr 2020 20:16:46 -0400
Received: by mail-wr1-f43.google.com with SMTP id w10so15392076wrm.4;
        Sun, 05 Apr 2020 17:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+9S0jyo9MRQv/zHeTKhyTdeaIwkRelQt+B7vvYXTEg=;
        b=sQgWJaBRA8YuYxu5qM/5cMbrQY+VLEPF98XVEuaNKb8L3Mx9K2OL01Hoa+5sl9wl2U
         zgSfytI5qzVN8tMwRCBz5m90d0Emo6kP8+5HY4YDMUhO+9VoKhE8omtA8zEjAhOcVLfg
         ABIPY+DgjW9VFH1RnqG5bj+r6hX53eA/TDMKhMTVl6kl9McRWn94jnx5kYHJZHY5cN/L
         Y8bv+hoPjh3dfPGfJeVb4UiM5UcH385MqXWpJDtO+gsx+20XCq/w3g2aeNtemjVtK/Cu
         Wx2Eu0EqkO4R5vykWPbDHj8TI0HUnOjjrwkf17zkoQNyiW5ZwyKJzoN9DQSR/HGezhUo
         PwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+9S0jyo9MRQv/zHeTKhyTdeaIwkRelQt+B7vvYXTEg=;
        b=amrOCEV+QEgDVUeQBHIttwGx2c9T+MOSZvyDTDJv2QklPYqhlV/C5K5uw1xzCPkGL9
         C/+mnP/esORHWwE6KWY9SRMkphNwGgVSiVkpX83czzu/NSyXORb15h+ooJK4bfJllxdr
         H+yoaBEM1eKsC7UNuM2GpdxS3e1QLUwfM8ppyDj4lHrQqPSffKPmH9sR25PKvJ90sdNS
         pZG868U++uDV7UeVgH74V18waaaVQaG6yjxYpYe9z/Bq1dGa3vozsXZ/3Yd2wSOtXWnY
         tp1GEpbRcDPACJpMzX4Cm6FyKtPz8SaGTC4ZfBx3b+YDqfDzp4FMQVek/NTPoBgIq3ny
         LnBQ==
X-Gm-Message-State: AGi0PuY485b3biJa/PC4whzY1yxD0CGMH6E0FyPbmP6L5uFrpGC31b/y
        4Eonb9VtANnE5UehbOJQhW2w6k+CBeR19A==
X-Google-Smtp-Source: APiQypL01b1gbOD3u2myb/BNfq5hGX/6HV/oqVlLSxtT65yzGZDG0TQwAbJg1WiTDrQUerKoIX0LzQ==
X-Received: by 2002:a5d:6906:: with SMTP id t6mr21705637wru.64.1586132202839;
        Sun, 05 Apr 2020 17:16:42 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j9sm817432wrn.59.2020.04.05.17.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:16:42 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 02/11] Drivers: hv: vmbus: Don't bind the offer&rescind works to a specific CPU
Date:   Mon,  6 Apr 2020 02:15:05 +0200
Message-Id: <20200406001514.19876-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406001514.19876-1-parri.andrea@gmail.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The offer and rescind works are currently scheduled on the so called
"connect CPU".  However, this is not really needed: we can synchronize
the works by relying on the usage of the offer_in_progress counter and
of the channel_mutex mutex.  This synchronization is already in place.
So, remove this unnecessary "bind to the connect CPU" constraint and
update the inline comments accordingly.

Suggested-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 21 ++++++++++++++++-----
 drivers/hv/vmbus_drv.c    | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 501c43c5851dc..aed8db59a5ff8 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1028,11 +1028,22 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
 	 * offer comes in first and then the rescind.
 	 * Since we process these events in work elements,
 	 * and with preemption, we may end up processing
-	 * the events out of order. Given that we handle these
-	 * work elements on the same CPU, this is possible only
-	 * in the case of preemption. In any case wait here
-	 * until the offer processing has moved beyond the
-	 * point where the channel is discoverable.
+	 * the events out of order.  We rely on the synchronization
+	 * provided by offer_in_progress and by channel_mutex for
+	 * ordering these events:
+	 *
+	 * { Initially: offer_in_progress = 1 }
+	 *
+	 * CPU1				CPU2
+	 *
+	 * [vmbus_process_offer()]	[vmbus_onoffer_rescind()]
+	 *
+	 * LOCK channel_mutex		WAIT_ON offer_in_progress == 0
+	 * DECREMENT offer_in_progress	LOCK channel_mutex
+	 * INSERT chn_list		SEARCH chn_list
+	 * UNLOCK channel_mutex		UNLOCK channel_mutex
+	 *
+	 * Forbids: CPU2's SEARCH from *not* seeing CPU1's INSERT
 	 */
 
 	while (atomic_read(&vmbus_connection.offer_in_progress) != 0) {
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a491d44362f9f..41ec0c95df33f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1075,8 +1075,9 @@ void vmbus_on_msg_dpc(unsigned long data)
 		/*
 		 * The host can generate a rescind message while we
 		 * may still be handling the original offer. We deal with
-		 * this condition by ensuring the processing is done on the
-		 * same CPU.
+		 * this condition by relying on the synchronization provided
+		 * by offer_in_progress and by channel_mutex.  See also the
+		 * inline comments in vmbus_onoffer_rescind().
 		 */
 		switch (hdr->msgtype) {
 		case CHANNELMSG_RESCIND_CHANNELOFFER:
@@ -1098,16 +1099,34 @@ void vmbus_on_msg_dpc(unsigned long data)
 			 * work queue: the RESCIND handler can not start to
 			 * run before the OFFER handler finishes.
 			 */
-			schedule_work_on(VMBUS_CONNECT_CPU,
-					 &ctx->work);
+			schedule_work(&ctx->work);
 			break;
 
 		case CHANNELMSG_OFFERCHANNEL:
+			/*
+			 * The host sends the offer message of a given channel
+			 * before sending the rescind message of the same
+			 * channel.  These messages are sent to the guest's
+			 * connect CPU; the guest then starts processing them
+			 * in the tasklet handler on this CPU:
+			 *
+			 * VMBUS_CONNECT_CPU
+			 *
+			 * [vmbus_on_msg_dpc()]
+			 * atomic_inc()  // CHANNELMSG_OFFERCHANNEL
+			 * queue_work()
+			 * ...
+			 * [vmbus_on_msg_dpc()]
+			 * schedule_work()  // CHANNELMSG_RESCIND_CHANNELOFFER
+			 *
+			 * We rely on the memory-ordering properties of the
+			 * queue_work() and schedule_work() primitives, which
+			 * guarantee that the atomic increment will be visible
+			 * to the CPUs which will execute the offer & rescind
+			 * works by the time these works will start execution.
+			 */
 			atomic_inc(&vmbus_connection.offer_in_progress);
-			queue_work_on(VMBUS_CONNECT_CPU,
-				      vmbus_connection.work_queue,
-				      &ctx->work);
-			break;
+			fallthrough;
 
 		default:
 			queue_work(vmbus_connection.work_queue, &ctx->work);
@@ -1151,9 +1170,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 
 	INIT_WORK(&ctx->work, vmbus_onmessage_work);
 
-	queue_work_on(VMBUS_CONNECT_CPU,
-		      vmbus_connection.work_queue,
-		      &ctx->work);
+	queue_work(vmbus_connection.work_queue, &ctx->work);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.24.0

