Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A241933ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 23:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCYW4U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 18:56:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42362 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYW4U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 18:56:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so5567402wrx.9;
        Wed, 25 Mar 2020 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=beOM8tvZcK+IG1c1LmUZ7yOcke+m4w+v951ks0snusQ=;
        b=bgoJlehyHGlqqH1u3eDJkZfeYDkT3KgG655qZqERqrdefoDmvF4Mz2LKmlkTA1k0oP
         PEA3mu1cFjC6P+rBwTVc2LSE7+PXNLpc7d/VIIZfJ/PkDibdfxpykb3tpjsKaGvxOJEE
         v6ZHKLZtxBjM0SHadWjEnf4tdesdc71f0NJDHW/ANPjQqmAtRwCdafDeV6u72EfU3UV+
         L4OLClTKSvNyjeAoeXrUTBd2VznT5HpN1GILa3gRj72qre6GpB0N02Z0BfolsB9a8Uvi
         AM7TMrk4H8CTywfsxfUNJBIyfEvN5aKA7ZCerelNVPEIQST99d051HUAl1Wofg/xd5Gq
         XYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beOM8tvZcK+IG1c1LmUZ7yOcke+m4w+v951ks0snusQ=;
        b=iPceqM0K6PpGPT7RXx9Sj73VdPMqfgm0TF3M/GZRO5lJkNAUMMHTOgV1Hzc7df3oY2
         3N3xAnXMIZl6MUqJ3cScXq7xXbnZoCLfNsfdc0RQ+QV7GZh1FdfHxbeVeoDn5SEVFoWl
         oydDGc4NMlAsua1ZhqynsFD/vsQceIWNqXdHeCmgHzsI4z4ow/nMnSS4sTp8286Njwrr
         ad4sPzDMchDPfUvbIFY6QEhrdGyIGE57E0vSFjGfV/rh7IBVFFZarJfZWXvpeddjZs1r
         3JECYNZHEXxm/3ZwZfekak8rXrcJ12i9jlGcVIdPxmsEgc60JgHQVWsdgcwD+kEN1mJb
         xNQg==
X-Gm-Message-State: ANhLgQ0ZlJL75oMLEmJS9lJyCDM6K8MML44GpYdR4HRW66Q3KSFtlWFm
        NwkUxSZhuwIJG8BQgswtfamLhGJwIU6/juK1
X-Google-Smtp-Source: ADFU+vsPk2ATsHMQCxNJekYZV/fkj+E3mHAa94WMH6mF/xorVxV9s3zuo3vmgW2TvN28XaXTRrXB/Q==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr5707573wru.131.1585176977065;
        Wed, 25 Mar 2020 15:56:17 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id q72sm790278wme.31.2020.03.25.15.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:56:16 -0700 (PDT)
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
Subject: [RFC PATCH 02/11] Drivers: hv: vmbus: Don't bind the offer&rescind works to a specific CPU
Date:   Wed, 25 Mar 2020 23:54:56 +0100
Message-Id: <20200325225505.23998-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200325225505.23998-1-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
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
index 0370364169c4e..1191f3d76d111 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1025,11 +1025,22 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
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
index 7600615e13754..903b1ec6a259e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1048,8 +1048,9 @@ void vmbus_on_msg_dpc(unsigned long data)
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
@@ -1071,16 +1072,34 @@ void vmbus_on_msg_dpc(unsigned long data)
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
@@ -1124,9 +1143,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 
 	INIT_WORK(&ctx->work, vmbus_onmessage_work);
 
-	queue_work_on(VMBUS_CONNECT_CPU,
-		      vmbus_connection.work_queue,
-		      &ctx->work);
+	queue_work(vmbus_connection.work_queue, &ctx->work);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.24.0

