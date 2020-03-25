Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C831B1933EC
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 23:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCYW4Q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 18:56:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36830 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYW4Q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 18:56:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so5604357wrs.3;
        Wed, 25 Mar 2020 15:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8673C/Xd7giGPqCGmeT6xQ1XCNHB0bw+TgkKTIuIFy4=;
        b=D94VTZGtoQUXSzq4mN6CIjs2CPm4OqqXF9dBUHGMgRb6iphhZ7pqhcsPDwL8jRFlFJ
         LNrb2rbY8EnKIATObMQZ5LvzDssmrEtMgwwv0jA1U4LzMw4VOrPueXSIkj1bEkjCZMJd
         Qz93knBYpJnOQKHYOQwLshdiGqqHqlgBT1I45xIWD2Ohnj6foCw40lYIFIFqzxHWdMlq
         wxmLTwQRDiqh5ekRFK0ikbQQiBfQoH5vFuPJSQDgnotRCOZ7idz+PmHcJ1oe1iPuHxRa
         /DbRzxWk+DB8zdB5fR1IFmqEkvXFqVX1f8eygmFxZRTC/viOzKdob+vel/2KABVzAGsl
         bijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8673C/Xd7giGPqCGmeT6xQ1XCNHB0bw+TgkKTIuIFy4=;
        b=DZkKT96hr4/9GdRVRmUCGfeXlpvbkWFDHbGRiThEDmaV3gDXvXeXxT5sxw91wlfUKY
         5X/as3EarEED5mMe1cMBTPVKgEL3a+fTVgF82lqzjfaw/qKwp/Wv1OqBDfy/y8kKM3+c
         /6oNlDIrAIvdH+1Z/oTlO7ovvxAcsqG+fnbJDVV1t8IJsCYG4kVjMepzmiN+XtaSIjyW
         tfqJUIAFkME/NAmIrqgnsbtoCFWmPE/ID+S2DeMf6gxN5bKxCKHkhVbjyI1xx/yJBwWn
         whosZwunMQw+F+e3uKo6Wk1xlZo6O0x8Xi+ejCgw0MaAhj33Dw+rqonAVkdxfPXnfiJr
         6xlw==
X-Gm-Message-State: ANhLgQ10OlwWkvjdSlkzhjhjEuV4/0SBpQri9Mi7FYHZF3DgeJjyhZSp
        xzy84WIMOZXmqsfiF8XfezMcRllskIENjVwx
X-Google-Smtp-Source: ADFU+vsVeGi+I2knRVfxPfTaCmwIEkcnOXT3iaojPadNf/upSIDQFOJGHQxQ9lhG/CumhkbD6fB3bg==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr6117284wro.115.1585176972755;
        Wed, 25 Mar 2020 15:56:12 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id q72sm790278wme.31.2020.03.25.15.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:56:12 -0700 (PDT)
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
Subject: [RFC PATCH 01/11] Drivers: hv: vmbus: Always handle the VMBus messages on CPU0
Date:   Wed, 25 Mar 2020 23:54:55 +0100
Message-Id: <20200325225505.23998-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200325225505.23998-1-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
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
index 70b30e223a578..67fb1edcbf527 100644
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
index 029378c27421d..7600615e13754 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1056,14 +1056,28 @@ void vmbus_on_msg_dpc(unsigned long data)
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
@@ -1110,7 +1124,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 
 	INIT_WORK(&ctx->work, vmbus_onmessage_work);
 
-	queue_work_on(vmbus_connection.connect_cpu,
+	queue_work_on(VMBUS_CONNECT_CPU,
 		      vmbus_connection.work_queue,
 		      &ctx->work);
 }
-- 
2.24.0

