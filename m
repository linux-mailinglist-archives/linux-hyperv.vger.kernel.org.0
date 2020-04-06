Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D6519EECE
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 02:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDFAQm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Apr 2020 20:16:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40869 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgDFAQm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Apr 2020 20:16:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so13947743wmf.5;
        Sun, 05 Apr 2020 17:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQEL71/8vXYzinrn6WfQyyeCcrX9DfzeNT6xHoYFSXQ=;
        b=C+kflWZii0Qd7EC5y+mN7dLXTXJCmsHgjelXc4A3uxrlXLzFFiMZgoKYMvDvzUYER+
         Xg/YoDHJFKGxzgLlxjyJQxip6FqKNUkTZJwycmpNmRaiLcu8ikvJ6STkmk7M4KTySuvH
         IZ4KWDaByKLltwXFiQ2ge80DT/L0+juc8k8iMTBPmb95MhnVde+m3oAiUb7qzbvw1Wrd
         GW5hodv8h6XP8rEaSKSnO/t+jlHZ3hNMah3nLSPqh93sQupgs+GYcOlDxhh77NPdksQX
         8lIgRmS+pMIJB7hnDUY/+WOHoxXCsnQkuqCd1G9EL0/KqHDOxSBVQsYXftOKGFP/OnX2
         6OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQEL71/8vXYzinrn6WfQyyeCcrX9DfzeNT6xHoYFSXQ=;
        b=AQsfAAQfWuOcDbCVjX/7XA2QKZokywJjl9RpvWtISvHYyyy8ToMVs3wh4MtgMp10pT
         in9HHbH65ZjxWQvwh0p0BSz41q56AvPXR2qd5xwQgJX8c0FdQ0vzKbpFMlMR/orVvTlx
         1ToI7a1yLlLxtIkjNoobG6HoeIyxqxoz42bJGuhDxT4FAlvsVgyY5Ae6VsdIGO9oVp3i
         9y4711ItLd62m3KFuCqY7DlxqSaa2kwDjl1clBC6mEtylFSiulKaQmtFt021xSFNl+GJ
         CuKve8oEi2cK3idCs3ahkJigFVFlOMfMFsV68NILAsBLXNWlkSH2yWo7bzSLJF8IpKte
         Cqyw==
X-Gm-Message-State: AGi0PuaZ/qdEO+y9jYqtlOeNlyc/Ptp/5Y8al6nTziFR6D77iR/8Q5+w
        Zv/OUKrP0lEVKRxV8sbiBjA1GsVRBgNXsA==
X-Google-Smtp-Source: APiQypL8xzj3Oe4AVi6DS5BRLP1sDvcTZUjp7G6/l6yFpVr11mNHSFE/qLVJVx26WuA75d1ZezxTAg==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr1819840wmj.14.1586132199859;
        Sun, 05 Apr 2020 17:16:39 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j9sm817432wrn.59.2020.04.05.17.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:16:39 -0700 (PDT)
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
Subject: [PATCH 01/11] Drivers: hv: vmbus: Always handle the VMBus messages on CPU0
Date:   Mon,  6 Apr 2020 02:15:04 +0200
Message-Id: <20200406001514.19876-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406001514.19876-1-parri.andrea@gmail.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A Linux guest have to pick a "connect CPU" to communicate with the
Hyper-V host.  This CPU can not be taken offline because Hyper-V does
not provide a way to change that CPU assignment.

Current code sets the connect CPU to whatever CPU ends up running the
function vmbus_negotiate_version(), and this will generate problems if
that CPU is taken offine.

Establish CPU0 as the connect CPU, and add logics to prevents the
connect CPU from being taken offline.   We could pick some other CPU,
and we could pick that "other CPU" dynamically if there was a reason to
do so at some point in the future.  But for now, #defining the connect
CPU to 0 is the most straightforward and least complex solution.

While on this, add inline comments explaining "why" offer and rescind
messages should not be handled by a same serialized work queue.

Suggested-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/connection.c   | 20 +-------------------
 drivers/hv/hv.c           |  7 +++++++
 drivers/hv/hyperv_vmbus.h | 11 ++++++-----
 drivers/hv/vmbus_drv.c    | 20 +++++++++++++++++---
 4 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 74e77de89b4f3..f4bd306d2cef9 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -69,7 +69,6 @@ MODULE_PARM_DESC(max_version,
 int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 {
 	int ret = 0;
-	unsigned int cur_cpu;
 	struct vmbus_channel_initiate_contact *msg;
 	unsigned long flags;
 
@@ -102,24 +101,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 
 	msg->monitor_page1 = virt_to_phys(vmbus_connection.monitor_pages[0]);
 	msg->monitor_page2 = virt_to_phys(vmbus_connection.monitor_pages[1]);
-	/*
-	 * We want all channel messages to be delivered on CPU 0.
-	 * This has been the behavior pre-win8. This is not
-	 * perf issue and having all channel messages delivered on CPU 0
-	 * would be ok.
-	 * For post win8 hosts, we support receiving channel messagges on
-	 * all the CPUs. This is needed for kexec to work correctly where
-	 * the CPU attempting to connect may not be CPU 0.
-	 */
-	if (version >= VERSION_WIN8_1) {
-		cur_cpu = get_cpu();
-		msg->target_vcpu = hv_cpu_number_to_vp_number(cur_cpu);
-		vmbus_connection.connect_cpu = cur_cpu;
-		put_cpu();
-	} else {
-		msg->target_vcpu = 0;
-		vmbus_connection.connect_cpu = 0;
-	}
+	msg->target_vcpu = hv_cpu_number_to_vp_number(VMBUS_CONNECT_CPU);
 
 	/*
 	 * Add to list before we send the request since we may
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 6098e0cbdb4b0..e2b3310454640 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -249,6 +249,13 @@ int hv_synic_cleanup(unsigned int cpu)
 	bool channel_found = false;
 	unsigned long flags;
 
+	/*
+	 * Hyper-V does not provide a way to change the connect CPU once
+	 * it is set; we must prevent the connect CPU from going offline.
+	 */
+	if (cpu == VMBUS_CONNECT_CPU)
+		return -EBUSY;
+
 	/*
 	 * Search for channels which are bound to the CPU we're about to
 	 * cleanup. In case we find one and vmbus is still connected we need to
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index f5fa3b3c9baf7..ce19a4c583884 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -212,12 +212,13 @@ enum vmbus_connect_state {
 
 #define MAX_SIZE_CHANNEL_MESSAGE	HV_MESSAGE_PAYLOAD_BYTE_COUNT
 
-struct vmbus_connection {
-	/*
-	 * CPU on which the initial host contact was made.
-	 */
-	int connect_cpu;
+/*
+ * The CPU that Hyper-V will interrupt for VMBUS messages, such as
+ * CHANNELMSG_OFFERCHANNEL and CHANNELMSG_RESCIND_CHANNELOFFER.
+ */
+#define VMBUS_CONNECT_CPU	0
 
+struct vmbus_connection {
 	u32 msg_conn_id;
 
 	atomic_t offer_in_progress;
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 172ceae69abb7..a491d44362f9f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1083,14 +1083,28 @@ void vmbus_on_msg_dpc(unsigned long data)
 			/*
 			 * If we are handling the rescind message;
 			 * schedule the work on the global work queue.
+			 *
+			 * The OFFER message and the RESCIND message should
+			 * not be handled by the same serialized work queue,
+			 * because the OFFER handler may call vmbus_open(),
+			 * which tries to open the channel by sending an
+			 * OPEN_CHANNEL message to the host and waits for
+			 * the host's response; however, if the host has
+			 * rescinded the channel before it receives the
+			 * OPEN_CHANNEL message, the host just silently
+			 * ignores the OPEN_CHANNEL message; as a result,
+			 * the guest's OFFER handler hangs for ever, if we
+			 * handle the RESCIND message in the same serialized
+			 * work queue: the RESCIND handler can not start to
+			 * run before the OFFER handler finishes.
 			 */
-			schedule_work_on(vmbus_connection.connect_cpu,
+			schedule_work_on(VMBUS_CONNECT_CPU,
 					 &ctx->work);
 			break;
 
 		case CHANNELMSG_OFFERCHANNEL:
 			atomic_inc(&vmbus_connection.offer_in_progress);
-			queue_work_on(vmbus_connection.connect_cpu,
+			queue_work_on(VMBUS_CONNECT_CPU,
 				      vmbus_connection.work_queue,
 				      &ctx->work);
 			break;
@@ -1137,7 +1151,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 
 	INIT_WORK(&ctx->work, vmbus_onmessage_work);
 
-	queue_work_on(vmbus_connection.connect_cpu,
+	queue_work_on(VMBUS_CONNECT_CPU,
 		      vmbus_connection.work_queue,
 		      &ctx->work);
 }
-- 
2.24.0

