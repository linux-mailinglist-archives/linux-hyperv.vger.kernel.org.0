Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F7C1933F6
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 23:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgCYW4g (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 18:56:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56154 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgCYW4f (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 18:56:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id z5so4614199wml.5;
        Wed, 25 Mar 2020 15:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ohAWFBJQsgkoA1nFpeh6U+WJa1ZEf4/+VDN1X50qyIM=;
        b=oVbQTDqTgZY2HGawhmaH1+TiMveSbwgOVwkxKpq/04rig9hVLUrBksr6kHeDkuvQtV
         EOof3lFD7j67Aid+jw1LLYgCBoeBwl0E17cOnKlwKAEyJ2bFuxffskWwDVTK6BYkw+XH
         dHJUo4jKmLAg+OUWabf0ONig8kruE6AuhVoB+h7HrarLgdJb/RUVvpi40d4ayJiyGRqT
         ZKHDFtvq8njmk2kC74Ub2bflo8fLjxwRIaNkoTRTrXzbLnj9OolpUCzVh4/qTPXCM/Qy
         bZ34g/7Sgr8GWATaaXiYHMKDfmRA1AaMuggQUIUJhb9m7PZO1uOx/0j35eoe9c45aheE
         CX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohAWFBJQsgkoA1nFpeh6U+WJa1ZEf4/+VDN1X50qyIM=;
        b=qUzbXnfuMegK68DNEr+U6NQpR39VV8zD9Z3IRf7Mw/vkHGgxG7UfdvZmVCzvi2lJ4b
         WCWZg9AmHRE5Z3e1N5/VGzfbq/nuQ8lpaRod87in9fFAVZ5ZwhU0QR4Y4wT+NxGzw+ga
         o1OCEilCHZ8+rvhVHJVK8DbGoQqqauvkl5G9Zq18U+kSLNhI6NSrZ39O0OswCXPmV1Hm
         l6MYkD+RmCJ+DOTZsjDNxPQZSHYf86On6QfyyPGDHo8ynqP244DPYQCQ4ydyCcaL+nOe
         kZpriOOLmacul7tgP5e934ZpPppEHCtATUVEep/4y6co6oAzDsnwqI8Q/Fd8KM/ue1qc
         3bNQ==
X-Gm-Message-State: ANhLgQ2RfshJexs0kmFKRFi6r5ZeBD7IhAaAFGeqrAsUYZ/9zdPrKtDV
        AZ4tQAcadvn7/BKpDEEoUsIg6WSPL4ebMW9k
X-Google-Smtp-Source: ADFU+vudwAqUs7wYNGydB7CgfxRB2fT5ujoFDhG1I6FHb7TW1PrKOv+UJrt7necVm6QgGZMmz4JZTg==
X-Received: by 2002:a1c:721a:: with SMTP id n26mr5788219wmc.25.1585176993094;
        Wed, 25 Mar 2020 15:56:33 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id q72sm790278wme.31.2020.03.25.15.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:56:32 -0700 (PDT)
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
Subject: [RFC PATCH 06/11] Drivers: hv: vmbus: Use a spin lock for synchronizing channel scheduling vs. channel removal
Date:   Wed, 25 Mar 2020 23:55:00 +0100
Message-Id: <20200325225505.23998-7-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200325225505.23998-1-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
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
index 9b1449c839575..c53f58ba06dcf 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -315,6 +315,7 @@ static struct vmbus_channel *alloc_channel(void)
 	if (!channel)
 		return NULL;
 
+	spin_lock_init(&channel->sched_lock);
 	spin_lock_init(&channel->lock);
 	init_completion(&channel->rescind_event);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 301e3f484bb1a..ebe2716f583d2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1147,18 +1147,6 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
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
@@ -1189,6 +1177,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 		return;
 
 	for_each_set_bit(relid, recv_int_page, maxbits) {
+		void (*callback_fn)(void *context);
 		struct vmbus_channel *channel;
 
 		if (!sync_test_and_clear_bit(relid, recv_int_page))
@@ -1214,13 +1203,26 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
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
@@ -1230,6 +1232,8 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
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

