Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C022A67E9
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Nov 2020 16:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgKDPlN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Nov 2020 10:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbgKDPlM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Nov 2020 10:41:12 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048AAC0613D4;
        Wed,  4 Nov 2020 07:41:11 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id k9so22930325edo.5;
        Wed, 04 Nov 2020 07:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7t2NOfVfZvzgoJoQoK8++Sax97Ve9IUMnUx5WCE/h/g=;
        b=W4bKh2n0fdTsBeyeU9tV7cqffQpfj2zWzSOVfw3vLUJf7Dq+hO0DizkD05cqGgLlKv
         ti3+E1fhRm1whrj+zs0n6sQYC3AOyj+fvtS+q5GtH6plJsg+gs4fy7pXEZrGyYHHlsQ4
         4DMB0sr6QzlzWltDm48D2OUzhcGrBZXNUtEK6Zrqin0ilVJBJKZg1lVUeiorN5KD4oaZ
         fgp5dM3GXalpuTrZfa69FMMs07xZBgrUdZCtgcVC7KCRT3hEvWaNrmwfqex1t28/DhQh
         oYNQzhXnk2dS/EasFCeyko5wOwdkn6s8QYr752/EKArfqku6Inh8YSTZVAUaW3tu3IhO
         DFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7t2NOfVfZvzgoJoQoK8++Sax97Ve9IUMnUx5WCE/h/g=;
        b=S7yhym66VETvqzpFKivabLpuRCOijKIKXbck/hk+OaLZHYfUg1Hnz6XvHG2kLSDrPb
         F0FzWwuuFdvtd6wISFtOkrCr2u/wAhNXta/X6RyTpGMSMTLezALvmhOvyuqtZonCtCaW
         GjdrSzt6v+GI6nBlAhKYqs7jPLAGKlKG/TZsbPC2rCvpgP+9E6f8yQTr7aiQnze2zEb2
         Y67SnELss9/c8R8wdNQ9B72k+YDd+BnsDv2RJI+EUZmT6z7v1yZOMRwtAEapMV0lsy5Z
         W+ptldGjJNFC3Xl7IGD00MszLJcW5sKUnbl4p00MHD/e9v6wbiMVBeOVDRgSnjb/uhl0
         AtZg==
X-Gm-Message-State: AOAM533B+TB6hw89NZIQ9FwUds/v/fH9lyam0uDnhVQK7T0AkAzbk3uL
        N1n/8Et2G9cgYn9pKH30JsCJZ3DUqmLlVQ==
X-Google-Smtp-Source: ABdhPJxFutpqliMvFuEwwlFOQZYH1DNwe1YZCOjqly2yT9NuBIWVGM4nu6LrPRZJl7wH/1iHvnuFCg==
X-Received: by 2002:a50:c01e:: with SMTP id r30mr26774974edb.176.1604504470081;
        Wed, 04 Nov 2020 07:41:10 -0800 (PST)
Received: from localhost.localdomain (host-87-7-71-164.retail.telecomitalia.it. [87.7.71.164])
        by smtp.gmail.com with ESMTPSA id y14sm1218548edo.69.2020.11.04.07.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:41:09 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Andres Beltran <lkmlabelt@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v8 1/3] Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening
Date:   Wed,  4 Nov 2020 16:40:25 +0100
Message-Id: <20201104154027.319432-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104154027.319432-1-parri.andrea@gmail.com>
References: <20201104154027.319432-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andres Beltran <lkmlabelt@gmail.com>

Currently, VMbus drivers use pointers into guest memory as request IDs
for interactions with Hyper-V. To be more robust in the face of errors
or malicious behavior from a compromised Hyper-V, avoid exposing
guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
bad request ID that is then treated as the address of a guest data
structure with no validation. Instead, encapsulate these memory
addresses and provide small integers as request IDs.

Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
Co-developed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel.c      | 174 ++++++++++++++++++++++++++++++++++++--
 drivers/hv/hyperv_vmbus.h |   3 +-
 drivers/hv/ring_buffer.c  |  28 +++++-
 include/linux/hyperv.h    |  22 +++++
 4 files changed, 218 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index fbdda9938039a..6fb0c76bfbf81 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -503,6 +503,70 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 }
 EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
 
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
+ * Index 0 is the first free slot
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
@@ -523,6 +587,12 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
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
@@ -626,6 +696,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 error_clean_ring:
 	hv_ringbuffer_cleanup(&newchannel->outbound);
 	hv_ringbuffer_cleanup(&newchannel->inbound);
+	vmbus_free_requestor(&newchannel->requestor);
 	newchannel->state = CHANNEL_OPEN_STATE;
 	return err;
 }
@@ -808,6 +879,9 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 		channel->ringbuffer_gpadlhandle = 0;
 	}
 
+	if (!ret)
+		vmbus_free_requestor(&channel->requestor);
+
 	return ret;
 }
 
@@ -888,7 +962,7 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 	/* in 8-bytes granularity */
 	desc.offset8 = sizeof(struct vmpacket_descriptor) >> 3;
 	desc.len8 = (u16)(packetlen_aligned >> 3);
-	desc.trans_id = requestid;
+	desc.trans_id = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 
 	bufferlist[0].iov_base = &desc;
 	bufferlist[0].iov_len = sizeof(struct vmpacket_descriptor);
@@ -897,7 +971,7 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, num_vecs);
+	return hv_ringbuffer_write(channel, bufferlist, num_vecs, requestid);
 }
 EXPORT_SYMBOL(vmbus_sendpacket);
 
@@ -939,7 +1013,7 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 	desc.flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
 	desc.dataoffset8 = descsize >> 3; /* in 8-bytes granularity */
 	desc.length8 = (u16)(packetlen_aligned >> 3);
-	desc.transactionid = requestid;
+	desc.transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 	desc.reserved = 0;
 	desc.rangecount = pagecount;
 
@@ -956,7 +1030,7 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3);
+	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
 
@@ -983,7 +1057,7 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	desc->flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
 	desc->dataoffset8 = desc_size >> 3; /* in 8-bytes granularity */
 	desc->length8 = (u16)(packetlen_aligned >> 3);
-	desc->transactionid = requestid;
+	desc->transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 	desc->reserved = 0;
 	desc->rangecount = 1;
 
@@ -994,7 +1068,7 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3);
+	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_mpb_desc);
 
@@ -1042,3 +1116,91 @@ int vmbus_recvpacket_raw(struct vmbus_channel *channel, void *buffer,
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
+	const struct vmbus_channel *channel =
+		container_of(rqstor, const struct vmbus_channel, requestor);
+
+	/* Check rqstor has been initialized */
+	if (!channel->rqstor_size)
+		return VMBUS_NO_RQSTOR;
+
+	spin_lock_irqsave(&rqstor->req_lock, flags);
+	current_id = rqstor->next_request_id;
+
+	/* Requestor array is full */
+	if (current_id >= rqstor->size) {
+		spin_unlock_irqrestore(&rqstor->req_lock, flags);
+		return VMBUS_RQST_ERROR;
+	}
+
+	rqstor->next_request_id = rqstor->req_arr[current_id];
+	rqstor->req_arr[current_id] = rqst_addr;
+
+	/* The already held spin lock provides atomicity */
+	bitmap_set(rqstor->req_bitmap, current_id, 1);
+
+	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+
+	/*
+	 * Cannot return an ID of 0, which is reserved for an unsolicited
+	 * message from Hyper-V.
+	 */
+	return current_id + 1;
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
+	const struct vmbus_channel *channel =
+		container_of(rqstor, const struct vmbus_channel, requestor);
+
+	/* Check rqstor has been initialized */
+	if (!channel->rqstor_size)
+		return VMBUS_NO_RQSTOR;
+
+	/* Hyper-V can send an unsolicited message with ID of 0 */
+	if (!trans_id)
+		return trans_id;
+
+	spin_lock_irqsave(&rqstor->req_lock, flags);
+
+	/* Data corresponding to trans_id is stored at trans_id - 1 */
+	trans_id--;
+
+	/* Invalid trans_id */
+	if (trans_id >= rqstor->size || !test_bit(trans_id, rqstor->req_bitmap)) {
+		spin_unlock_irqrestore(&rqstor->req_lock, flags);
+		return VMBUS_RQST_ERROR;
+	}
+
+	req_addr = rqstor->req_arr[trans_id];
+	rqstor->req_arr[trans_id] = rqstor->next_request_id;
+	rqstor->next_request_id = trans_id;
+
+	/* The already held spin lock provides atomicity */
+	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
+
+	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+	return req_addr;
+}
+EXPORT_SYMBOL_GPL(vmbus_request_addr);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 40e2b9f91163c..02f3e89888366 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -179,7 +179,8 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
 
 int hv_ringbuffer_write(struct vmbus_channel *channel,
-			const struct kvec *kv_list, u32 kv_count);
+			const struct kvec *kv_list, u32 kv_count,
+			u64 requestid);
 
 int hv_ringbuffer_read(struct vmbus_channel *channel,
 		       void *buffer, u32 buflen, u32 *buffer_actual_len,
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 356e22159e834..e55d3c75e148c 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -248,7 +248,8 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
 
 /* Write to the ring buffer. */
 int hv_ringbuffer_write(struct vmbus_channel *channel,
-			const struct kvec *kv_list, u32 kv_count)
+			const struct kvec *kv_list, u32 kv_count,
+			u64 requestid)
 {
 	int i;
 	u32 bytes_avail_towrite;
@@ -258,6 +259,8 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	u64 prev_indices;
 	unsigned long flags;
 	struct hv_ring_buffer_info *outring_info = &channel->outbound;
+	struct vmpacket_descriptor *desc = kv_list[0].iov_base;
+	u64 rqst_id = VMBUS_NO_RQSTOR;
 
 	if (channel->rescind)
 		return -ENODEV;
@@ -300,6 +303,22 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 						     kv_list[i].iov_len);
 	}
 
+	/*
+	 * Allocate the request ID after the data has been copied into the
+	 * ring buffer.  Once this request ID is allocated, the completion
+	 * path could find the data and free it.
+	 */
+
+	if (desc->flags == VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED) {
+		rqst_id = vmbus_next_request_id(&channel->requestor, requestid);
+		if (rqst_id == VMBUS_RQST_ERROR) {
+			pr_err("No request id available\n");
+			return -EAGAIN;
+		}
+	}
+	desc = hv_get_ring_buffer(outring_info) + old_write;
+	desc->trans_id = (rqst_id == VMBUS_NO_RQSTOR) ? requestid : rqst_id;
+
 	/* Set previous packet start */
 	prev_indices = hv_get_ring_bufferindices(outring_info);
 
@@ -319,8 +338,13 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 
 	hv_signal_on_write(old_write, channel);
 
-	if (channel->rescind)
+	if (channel->rescind) {
+		if (rqst_id != VMBUS_NO_RQSTOR) {
+			/* Reclaim request ID to avoid leak of IDs */
+			vmbus_request_addr(&channel->requestor, rqst_id);
+		}
 		return -ENODEV;
+	}
 
 	return 0;
 }
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 1ce131f29f3b4..5b6d5c4e37110 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -764,6 +764,22 @@ enum vmbus_device_type {
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
+#define VMBUS_NO_RQSTOR U64_MAX
+#define VMBUS_RQST_ERROR (U64_MAX - 1)
+
 struct vmbus_device {
 	u16  dev_type;
 	guid_t guid;
@@ -988,8 +1004,14 @@ struct vmbus_channel {
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

