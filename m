Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B111919EEE5
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 02:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgDFAQz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Apr 2020 20:16:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50663 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgDFAQx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Apr 2020 20:16:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id x25so1883270wmc.0;
        Sun, 05 Apr 2020 17:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJixrAHmLSm9JlvLk/tktanq5R41sY9S5RTPPKZAKz8=;
        b=ded1bEXSxJWca6rs1Ko/HJU44z6eWyPmJS57HBR9qKW8IdAb2papE+k21BIMXkBspt
         9ueEmL8WxHwUjiCvzTc4/pNhsi+0tIkFUkd4w05m1Y4TO5QmapTcGAgmukyo5vk0gol2
         vA1vhehom4n7ti9VJ5K+D8CCx1ZRWJsKIZ6DN982eqSpmm7ikMG28VqgNDnzU3h4mLnJ
         nS1Pq8lMWW10hVl1m2UyaNtVIozUZudR8ysACNiYHh3hK8zoTjQl5grQGB9G69CTMKeg
         eIIJmDNNz5SzHvXCzewmXlpCGA2OwDX3CMohbk+FyGOW/aM7VWt7VEBLjiR3zRNy+Vlq
         R5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJixrAHmLSm9JlvLk/tktanq5R41sY9S5RTPPKZAKz8=;
        b=OtR1rE8oemUCKL9eq1VbVG2PxpK9hbeV4dhLHGS31fHtBAVNCIUjAJWFSO0hwJ5qlr
         wnLCq0KgFBD2m+TeQ88+j3jvtX+2V/9NpfiFQv4XG4sQqufZEEFJ5dK7rr6haWEPJ88G
         mUZmTzoBeFaMBxp0Ic7TJlNhLh7pH4arfthbuceEih1fKRjMIbCwQKsOHX+TzIsMPb/3
         2kb0LplwI7V5TdU2JBvcio/KBuBh8Mw4C/wR7wHU0CoqobuWr3Th53Q/sTYPnTTxN3kg
         QJBWHoyFFDRJvNiAz7c6n52ThKslSgJdynv4fCLJY/+G/BPzGPsuvrOk7Oel+NN5E5y5
         BhuA==
X-Gm-Message-State: AGi0PuZLiAquTBXe8kpiK5l8KwOPldn1vDqGfYATAQ8cBpqmDqcQQtFw
        pcB0yUGhILskGMrsSftyp44FmkJMx+QLiA==
X-Google-Smtp-Source: APiQypL+SC4YUWZAqxOGZsor7oNjVgG7hYdxPPj7yjthsvzbVSYYbgd+rKyzevtgiBwRlmIdg+1mdA==
X-Received: by 2002:a05:600c:2c50:: with SMTP id r16mr20467271wmg.6.1586132211060;
        Sun, 05 Apr 2020 17:16:51 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j9sm817432wrn.59.2020.04.05.17.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:16:50 -0700 (PDT)
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
Subject: [PATCH 06/11] Drivers: hv: vmbus: Use a spin lock for synchronizing channel scheduling vs. channel removal
Date:   Mon,  6 Apr 2020 02:15:09 +0200
Message-Id: <20200406001514.19876-7-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406001514.19876-1-parri.andrea@gmail.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since vmbus_chan_sched() dereferences the ring buffer pointer, we have
to make sure that the ring buffer data structures don't get freed while
such dereferencing is happening.  Current code does this by sending an
IPI to the CPU that is allowed to access that ring buffer from interrupt
level, cf., vmbus_reset_channel_cb().  But with the new functionality
to allow changing the CPU that a channel will interrupt, we can't be
sure what CPU will be running the vmbus_chan_sched() function for a
particular channel, so the current IPI mechanism is infeasible.

Instead synchronize vmbus_chan_sched() and vmbus_reset_channel_cb() by
using the (newly introduced) per-channel spin lock "sched_lock".  Move
the test for onchannel_callback being NULL before the "switch" control
statement in vmbus_chan_sched(), in order to not access the ring buffer
if the vmbus_reset_channel_cb() has been completed on the channel.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c      | 24 +++++++-----------------
 drivers/hv/channel_mgmt.c |  1 +
 drivers/hv/vmbus_drv.c    | 30 +++++++++++++++++-------------
 include/linux/hyperv.h    |  6 ++++++
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 256ee90c74460..132e476f87b2e 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -594,15 +594,10 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 }
 EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
 
-static void reset_channel_cb(void *arg)
-{
-	struct vmbus_channel *channel = arg;
-
-	channel->onchannel_callback = NULL;
-}
-
 void vmbus_reset_channel_cb(struct vmbus_channel *channel)
 {
+	unsigned long flags;
+
 	/*
 	 * vmbus_on_event(), running in the per-channel tasklet, can race
 	 * with vmbus_close_internal() in the case of SMP guest, e.g., when
@@ -618,17 +613,12 @@ void vmbus_reset_channel_cb(struct vmbus_channel *channel)
 	 */
 	tasklet_disable(&channel->callback_event);
 
-	channel->sc_creation_callback = NULL;
+	/* See the inline comments in vmbus_chan_sched(). */
+	spin_lock_irqsave(&channel->sched_lock, flags);
+	channel->onchannel_callback = NULL;
+	spin_unlock_irqrestore(&channel->sched_lock, flags);
 
-	/* Stop the callback asap */
-	if (channel->target_cpu != get_cpu()) {
-		put_cpu();
-		smp_call_function_single(channel->target_cpu, reset_channel_cb,
-					 channel, true);
-	} else {
-		reset_channel_cb(channel);
-		put_cpu();
-	}
+	channel->sc_creation_callback = NULL;
 
 	/* Re-enable tasklet for use on re-open */
 	tasklet_enable(&channel->callback_event);
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 8c179f6866ef7..46ea978e4222a 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -315,6 +315,7 @@ static struct vmbus_channel *alloc_channel(void)
 	if (!channel)
 		return NULL;
 
+	spin_lock_init(&channel->sched_lock);
 	spin_lock_init(&channel->lock);
 	init_completion(&channel->rescind_event);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0e5a98ebe23b1..18bd1c0e09a83 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1174,18 +1174,6 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-/*
- * Direct callback for channels using other deferred processing
- */
-static void vmbus_channel_isr(struct vmbus_channel *channel)
-{
-	void (*callback_fn)(void *);
-
-	callback_fn = READ_ONCE(channel->onchannel_callback);
-	if (likely(callback_fn != NULL))
-		(*callback_fn)(channel->channel_callback_context);
-}
-
 /*
  * Schedule all channels with events pending
  */
@@ -1216,6 +1204,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 		return;
 
 	for_each_set_bit(relid, recv_int_page, maxbits) {
+		void (*callback_fn)(void *context);
 		struct vmbus_channel *channel;
 
 		if (!sync_test_and_clear_bit(relid, recv_int_page))
@@ -1241,13 +1230,26 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 		if (channel->rescind)
 			goto sched_unlock_rcu;
 
+		/*
+		 * Make sure that the ring buffer data structure doesn't get
+		 * freed while we dereference the ring buffer pointer.  Test
+		 * for the channel's onchannel_callback being NULL within a
+		 * sched_lock critical section.  See also the inline comments
+		 * in vmbus_reset_channel_cb().
+		 */
+		spin_lock(&channel->sched_lock);
+
+		callback_fn = channel->onchannel_callback;
+		if (unlikely(callback_fn == NULL))
+			goto sched_unlock;
+
 		trace_vmbus_chan_sched(channel);
 
 		++channel->interrupts;
 
 		switch (channel->callback_mode) {
 		case HV_CALL_ISR:
-			vmbus_channel_isr(channel);
+			(*callback_fn)(channel->channel_callback_context);
 			break;
 
 		case HV_CALL_BATCHED:
@@ -1257,6 +1259,8 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 			tasklet_schedule(&channel->callback_event);
 		}
 
+sched_unlock:
+		spin_unlock(&channel->sched_lock);
 sched_unlock_rcu:
 		rcu_read_unlock();
 	}
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 6c794fd5c903e..ce32ab186192f 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -771,6 +771,12 @@ struct vmbus_channel {
 	void (*onchannel_callback)(void *context);
 	void *channel_callback_context;
 
+	/*
+	 * Synchronize channel scheduling and channel removal; see the inline
+	 * comments in vmbus_chan_sched() and vmbus_reset_channel_cb().
+	 */
+	spinlock_t sched_lock;
+
 	/*
 	 * A channel can be marked for one of three modes of reading:
 	 *   BATCHED - callback called from taslket and should read
-- 
2.24.0

