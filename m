Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9384E20F85D
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2020 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbgF3PcJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jun 2020 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389464AbgF3PcJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jun 2020 11:32:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8E4C03E979;
        Tue, 30 Jun 2020 08:32:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so4714865pfq.11;
        Tue, 30 Jun 2020 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:content-transfer-encoding;
        bh=yl8ZGVMnIZScPJ5u5Qoi3cLlP9EpCyr8JjM1uqQWie4=;
        b=O0XFknHWvQNmRFJg5ant2MW2WXTj4bQqfR81LlhH4l7xWwMBiQBErRCBI0jGTmBgH9
         hsblCmF2Gv49vZRccbIO+Pc/HyCfU9TOT8HQCJaIQOsdQ2eflYdcn3PvfDztu3Jo72P/
         rcMrvtMlS0KCpWEGZ/QRC8n74FpV97Q0o6mr5z+jCR2vEltlL/e1hrTX9XtMXCZgM6x3
         e6+8SkzjudCDleTr+tCInO4t5kiCn3Tv9QJ/fFBVxgig89WSN61XOyeg5naAtW0bXshx
         sG4+r0gO8k97sAP2qoZWTRSEgwTHyNo/bSssSFzl9BLivcQJsSVzqWLD/t3vm7brqpow
         i0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:reply-to:content-transfer-encoding;
        bh=yl8ZGVMnIZScPJ5u5Qoi3cLlP9EpCyr8JjM1uqQWie4=;
        b=qIVWs1liu6tguAHXVCXOgie5OJh92lOUxYdHqQzkdpDiUixCUOXkClax1NZNpS0ZYz
         HAHmytTdRCEwkZfEyipckVZt8pDJbeHwYSsN53k5lycYTrxxQRAe4Qm82Z1vDK9VE1KY
         7VElrwmmlyEHejvnrRWQcoz7YjEKmfaHPIl0Ii9hieuWiCndVV0kUVFCIHIQyYzLFJbA
         7VQm/AtVi7s9IxKpwcz05EqemgJlCUtQfA3Ccc8J2/mqHJ5Of6lIBrMh1AwihSTTaTgR
         9x1hn1e0llcNmOGwQmKV60zYZf6VT1ao/+zU9yb5eq41i6gBi7xR6zADgD6SizQgSSel
         ozpw==
X-Gm-Message-State: AOAM531XGc81YxaScUJoBRZWRe3BYNkqZLSGJTQPOOkGZwbnk43Ds9t1
        38PxG77I9cEKsUDAv87suyY=
X-Google-Smtp-Source: ABdhPJwwHjRhOKw7PKKgb6S2A1KyT4BJi9gpg5hUCvoXzOLxn4zxaVuK6TEGJd0Lumq97aftyRDMKg==
X-Received: by 2002:aa7:91d9:: with SMTP id z25mr5488703pfa.111.1593531128229;
        Tue, 30 Jun 2020 08:32:08 -0700 (PDT)
Received: from localhost.localdomain ([131.107.174.194])
        by smtp.gmail.com with ESMTPSA id 140sm3067433pfz.154.2020.06.30.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:32:07 -0700 (PDT)
From:   Andres Beltran <lkmlabelt@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        skarade@microsoft.com, Andres Beltran <lkmlabelt@gmail.com>
Subject: [PATCH v3 1/3] Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening
Date:   Tue, 30 Jun 2020 11:31:58 -0400
Message-Id: <20200630153200.1537105-2-lkmlabelt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630153200.1537105-1-lkmlabelt@gmail.com>
References: <20200630153200.1537105-1-lkmlabelt@gmail.com>
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
Changes in v3:
	- Check that requestor has been initialized in
	  vmbus_next_request_id() and vmbus_request_addr().
Changes in v2:
        - Get rid of "rqstor" variable in __vmbus_open().

 drivers/hv/channel.c   | 154 +++++++++++++++++++++++++++++++++++++++++
 include/linux/hyperv.h |  21 ++++++
 2 files changed, 175 insertions(+)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 3ebda7707e46..e89a4a2e1b5e 100644
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
 
@@ -937,3 +1011,83 @@ int vmbus_recvpacket_raw(struct vmbus_channel *channel, void *buffer,
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
+	/* Check rqstor has been initialized */
+	if (!rqstor->size)
+		return VMBUS_RQST_ERROR;
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
+	/* Check rqstor has been initialized */
+	if (!rqstor->size)
+		return VMBUS_RQST_ERROR;
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

