Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D420DB08
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2020 22:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbgF2UC6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Jun 2020 16:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733003AbgF2UC5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Jun 2020 16:02:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C8C061755;
        Mon, 29 Jun 2020 13:02:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l6so5404041pjq.1;
        Mon, 29 Jun 2020 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:content-transfer-encoding;
        bh=r10WE7UqqS8rVTLqlPGGsi5K0qZOzL7RMPGT27MMrPg=;
        b=Chu5MVoPJPFR9GcGxbu4zBkoRQz0MY/DGIIVNoz2npdq35xOx9Y5Ph08e/WBirB+Sc
         0gRA2PySfAPPZjLq9ZNxchuur9NCmdfKiqzqwJOeMrFqlteBVP+4aeEWOXPjYFhrG6ML
         XTE7zNdHP2CqVNYV+Znu9FFBVrebsoCx9Bt3i4IkN2ozapN/Ts5M/nUxQupxjmIyQVXr
         TNdxZxLd1JFaLRjRrH0laMv440kE8MH9/SD6OTcCBeyIR6mpP/4LfQ0VrfY2XYiuRAEI
         gko9/oIEH+mcg+Ro1cjEcS2ON4K3ZBCwJCC/6s57loZKpuSyYQAErSi2mls4baqap2E6
         781Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:reply-to:content-transfer-encoding;
        bh=r10WE7UqqS8rVTLqlPGGsi5K0qZOzL7RMPGT27MMrPg=;
        b=q2Qrxu2W7VXI7ixfqGbhWKHgAqM2B6GJbEDZhm4ulAoVEREbL194xIZM1fNF8+MGcc
         m+uWzz1EUhqY6xLCb8xnx+MG+gujWT3avWd8yVuxwpcdUOUQyLXe52f8iZ3NerA8yS+v
         v+7y4gN5T2ZJ61lk6qZrPHFdE6aj21HKReQ+/dOmq/M6LKaLDhBebfpuMmBCjH+yaLLE
         Jh/h+kPRaMF7W1ZQz8ToqVkmjlu7pWaV4Qky4KBoDAkNOgSrvWDGGCf0e1h4aAVjdEpT
         /zih5tx1r1Wzf8TzwJMs45LNcIDJmzsi9Wj4ovvsWZJ8l4nbp+Mj1hc3ULajrTlCd1vS
         8rLg==
X-Gm-Message-State: AOAM532/gkX9E2wRxhhrXVwj5RmXlUt0VnuuhGvgU5zWbqPqlCu6UzaC
        zpXVG0aDKTOI5GapOi+MizyrPBV5
X-Google-Smtp-Source: ABdhPJxYmml+A+tqucMoLK82ARSaT2qIv5CztkfU6fDQwfepcuE2EMemN8lZfRutxkGPoxpn2Qd9yg==
X-Received: by 2002:a17:90b:1c12:: with SMTP id oc18mr17778199pjb.160.1593460976645;
        Mon, 29 Jun 2020 13:02:56 -0700 (PDT)
Received: from localhost.localdomain ([131.107.160.194])
        by smtp.gmail.com with ESMTPSA id j10sm531558pgh.28.2020.06.29.13.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:02:56 -0700 (PDT)
From:   Andres Beltran <lkmlabelt@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        Andres Beltran <lkmlabelt@gmail.com>
Subject: [PATCH v2 1/3] Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening
Date:   Mon, 29 Jun 2020 16:02:25 -0400
Message-Id: <20200629200227.1518784-2-lkmlabelt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629200227.1518784-1-lkmlabelt@gmail.com>
References: <20200629200227.1518784-1-lkmlabelt@gmail.com>
MIME-Version: 1.0
Reply-To: t-mabelt@microsoft.com
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, VMbus drivers use pointers into guest memory as request IDs
for interactions with Hyper-V. To be more robust in the face of errors
or malicious behavior from a compromised Hyper-V, avoid exposing
guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
bad request ID that is then treated as the address of a guest data
structure with no validation. Instead, encapsulate these memory
addresses and provide small integers as request IDs.

Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
---
Changes in v2:
	- Get rid of "rqstor" variable in __vmbus_open().

 drivers/hv/channel.c   | 146 +++++++++++++++++++++++++++++++++++++++++
 include/linux/hyperv.h |  21 ++++++
 2 files changed, 167 insertions(+)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 3ebda7707e46..c89d57d0c2d2 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -112,6 +112,70 @@ int vmbus_alloc_ring(struct vmbus_channel *newchannel,
 }
 EXPORT_SYMBOL_GPL(vmbus_alloc_ring);
 
+/**
+ * request_arr_init - Allocates memory for the requestor array. Each slot
+ * keeps track of the next available slot in the array. Initially, each
+ * slot points to the next one (as in a Linked List). The last slot
+ * does not point to anything, so its value is U64_MAX by default.
+ * @size The size of the array
+ */
+static u64 *request_arr_init(u32 size)
+{
+	int i;
+	u64 *req_arr;
+
+	req_arr = kcalloc(size, sizeof(u64), GFP_KERNEL);
+	if (!req_arr)
+		return NULL;
+
+	for (i = 0; i < size - 1; i++)
+		req_arr[i] = i + 1;
+
+	/* Last slot (no more available slots) */
+	req_arr[i] = U64_MAX;
+
+	return req_arr;
+}
+
+/*
+ * vmbus_alloc_requestor - Initializes @rqstor's fields.
+ * Slot at index 0 is the first free slot.
+ * @size: Size of the requestor array
+ */
+static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
+{
+	u64 *rqst_arr;
+	unsigned long *bitmap;
+
+	rqst_arr = request_arr_init(size);
+	if (!rqst_arr)
+		return -ENOMEM;
+
+	bitmap = bitmap_zalloc(size, GFP_KERNEL);
+	if (!bitmap) {
+		kfree(rqst_arr);
+		return -ENOMEM;
+	}
+
+	rqstor->req_arr = rqst_arr;
+	rqstor->req_bitmap = bitmap;
+	rqstor->size = size;
+	rqstor->next_request_id = 0;
+	spin_lock_init(&rqstor->req_lock);
+
+	return 0;
+}
+
+/*
+ * vmbus_free_requestor - Frees memory allocated for @rqstor
+ * @rqstor: Pointer to the requestor struct
+ */
+static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
+{
+	kfree(rqstor->req_arr);
+	bitmap_free(rqstor->req_bitmap);
+}
+
 static int __vmbus_open(struct vmbus_channel *newchannel,
 		       void *userdata, u32 userdatalen,
 		       void (*onchannelcallback)(void *context), void *context)
@@ -132,6 +196,12 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	if (newchannel->state != CHANNEL_OPEN_STATE)
 		return -EINVAL;
 
+	/* Create and init requestor */
+	if (newchannel->rqstor_size) {
+		if (vmbus_alloc_requestor(&newchannel->requestor, newchannel->rqstor_size))
+			return -ENOMEM;
+	}
+
 	newchannel->state = CHANNEL_OPENING_STATE;
 	newchannel->onchannel_callback = onchannelcallback;
 	newchannel->channel_callback_context = context;
@@ -228,6 +298,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 error_clean_ring:
 	hv_ringbuffer_cleanup(&newchannel->outbound);
 	hv_ringbuffer_cleanup(&newchannel->inbound);
+	vmbus_free_requestor(&newchannel->requestor);
 	newchannel->state = CHANNEL_OPEN_STATE;
 	return err;
 }
@@ -703,6 +774,9 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 		channel->ringbuffer_gpadlhandle = 0;
 	}
 
+	if (!ret)
+		vmbus_free_requestor(&channel->requestor);
+
 	return ret;
 }
 
@@ -937,3 +1011,75 @@ int vmbus_recvpacket_raw(struct vmbus_channel *channel, void *buffer,
 				  buffer_actual_len, requestid, true);
 }
 EXPORT_SYMBOL_GPL(vmbus_recvpacket_raw);
+
+/*
+ * vmbus_next_request_id - Returns a new request id. It is also
+ * the index at which the guest memory address is stored.
+ * Uses a spin lock to avoid race conditions.
+ * @rqstor: Pointer to the requestor struct
+ * @rqst_add: Guest memory address to be stored in the array
+ */
+u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_addr)
+{
+	unsigned long flags;
+	u64 current_id;
+
+	spin_lock_irqsave(&rqstor->req_lock, flags);
+	current_id = rqstor->next_request_id;
+
+	/* Requestor array is full */
+	if (current_id >= rqstor->size) {
+		current_id = VMBUS_RQST_ERROR;
+		goto exit;
+	}
+
+	rqstor->next_request_id = rqstor->req_arr[current_id];
+	rqstor->req_arr[current_id] = rqst_addr;
+
+	/* The already held spin lock provides atomicity */
+	bitmap_set(rqstor->req_bitmap, current_id, 1);
+
+exit:
+	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+	return current_id;
+}
+EXPORT_SYMBOL_GPL(vmbus_next_request_id);
+
+/*
+ * vmbus_request_addr - Returns the memory address stored at @trans_id
+ * in @rqstor. Uses a spin lock to avoid race conditions.
+ * @rqstor: Pointer to the requestor struct
+ * @trans_id: Request id sent back from Hyper-V. Becomes the requestor's
+ * next request id.
+ */
+u64 vmbus_request_addr(struct vmbus_requestor *rqstor, u64 trans_id)
+{
+	unsigned long flags;
+	u64 req_addr;
+
+	spin_lock_irqsave(&rqstor->req_lock, flags);
+
+	/* Invalid trans_id */
+	if (trans_id >= rqstor->size) {
+		req_addr = VMBUS_RQST_ERROR;
+		goto exit;
+	}
+
+	/* Invalid trans_id: empty slot */
+	if (!test_bit(trans_id, rqstor->req_bitmap)) {
+		req_addr = VMBUS_RQST_ERROR;
+		goto exit;
+	}
+
+	req_addr = rqstor->req_arr[trans_id];
+	rqstor->req_arr[trans_id] = rqstor->next_request_id;
+	rqstor->next_request_id = trans_id;
+
+	/* The already held spin lock provides atomicity */
+	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
+
+exit:
+	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+	return req_addr;
+}
+EXPORT_SYMBOL_GPL(vmbus_request_addr);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 38100e80360a..c509d20ab7db 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -716,6 +716,21 @@ enum vmbus_device_type {
 	HV_UNKNOWN,
 };
 
+/*
+ * Provides request ids for VMBus. Encapsulates guest memory
+ * addresses and stores the next available slot in req_arr
+ * to generate new ids in constant time.
+ */
+struct vmbus_requestor {
+	u64 *req_arr;
+	unsigned long *req_bitmap; /* is a given slot available? */
+	u32 size;
+	u64 next_request_id;
+	spinlock_t req_lock; /* provides atomicity */
+};
+
+#define VMBUS_RQST_ERROR U64_MAX
+
 struct vmbus_device {
 	u16  dev_type;
 	guid_t guid;
@@ -940,8 +955,14 @@ struct vmbus_channel {
 	u32 fuzz_testing_interrupt_delay;
 	u32 fuzz_testing_message_delay;
 
+	/* request/transaction ids for VMBus */
+	struct vmbus_requestor requestor;
+	u32 rqstor_size;
 };
 
+u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_addr);
+u64 vmbus_request_addr(struct vmbus_requestor *rqstor, u64 trans_id);
+
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
 {
 	return !!(c->offermsg.offer.chn_flags &
-- 
2.25.1

