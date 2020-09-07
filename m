Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE725FEA1
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Sep 2020 18:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgIGQUC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Sep 2020 12:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730459AbgIGQTx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Sep 2020 12:19:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E8CC061573;
        Mon,  7 Sep 2020 09:19:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so14712031wmm.2;
        Mon, 07 Sep 2020 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JHVEIvxmQiaLDh2t/ONIBl5sPEp1HfYu08y70Dz5Kk=;
        b=rXfqe3hqcWU4E4Ytp1NsouAgh1AUBqIj1yz2MwOavGW1qGjFjYtuoOwqcep8dtagN8
         SMsp0Y69jcEw61j5o6IWkP1ympscxvrPk1QfT3zQ4RXmIvQzs5Kq2ZDNE3XjckgmWT4n
         woWj71DLKcbCbyyqpHsBCaL2sXLWPMB2PFv7sohTFjOJ8nZvxOwQGGZMrql3CxmEIVHA
         TUW6nM15VDRJpTl5hEHSZZnr9onnhuX9qA18KeZUjzUe1DIqyioWoJ17G+jAQu8IZAF4
         MxzfTRRgkQezVU/psW2mIKEGzkUi1aNsHU9ZIOZ6kSsoMFxQQc4D9WZlmVSRqQ0CaSiL
         Q5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JHVEIvxmQiaLDh2t/ONIBl5sPEp1HfYu08y70Dz5Kk=;
        b=k6d3Fou8ZMvpMlV3R4x/e0R4KI6PqnoLsHytRrhvvxPwoZy/fMDiWSVnT61x1dG/fv
         VVaQHm9G7HugpSzmETM1c5WRSXHQb2OTFlLiXndPSZGvBSm62lYC9rukMgdOc2d9PAd6
         ehx69hU13NG70Gt59AcKNrX0dz3eCpC2nmOJ9FE22riQOTjFKADS3xHtOH4EmwibZvfw
         iH4ZeOhm6ZRnunUsnKtlkRIC2PNMZyQNYxEgj+OdTAJjvpLlQjpaZUrrmrmOM06Y69TK
         h6VY6r+A4QaBa5o4kg1oJf51z7lspUWpex5MgXP3bhrXAgpc77VbzPp29AQXnxbURIWk
         1BBg==
X-Gm-Message-State: AOAM532nbT2fZbU3aFgJLxZsMl1g4C6SCqrB08HJc05lO6SkkJ6ntTUA
        Q+jTeZ7c0ak7NomdVwgmgqgTvx5gdyR/8Ljw
X-Google-Smtp-Source: ABdhPJyp0aWCv/Lr17duVei/TekF8hLsUpogGVmtCMRDYh/7KAckFd4Z/wG69YGjenfOmVnd44pxyg==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr131306wmg.0.1599495590567;
        Mon, 07 Sep 2020 09:19:50 -0700 (PDT)
Received: from localhost.localdomain (userh713.uk.uudial.com. [194.69.103.86])
        by smtp.gmail.com with ESMTPSA id y5sm19313717wrh.6.2020.09.07.09.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 09:19:49 -0700 (PDT)
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
Subject: [PATCH v7 1/3] Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening
Date:   Mon,  7 Sep 2020 18:19:18 +0200
Message-Id: <20200907161920.71460-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907161920.71460-1-parri.andrea@gmail.com>
References: <20200907161920.71460-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
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
---
Changes in v7:
	- Move the allocation of the request ID after the data has been
	  copied into the ring buffer.
Changes in v6:
        - Offset request IDs by 1 keeping the original initialization
          code.
Changes in v5:
        - Add support for unsolicited messages sent by the host with a
          request ID of 0.
Changes in v4:
        - Use channel->rqstor_size to check if rqstor has been
          initialized.
Changes in v3:
        - Check that requestor has been initialized in
          vmbus_next_request_id() and vmbus_request_addr().
Changes in v2:
        - Get rid of "rqstor" variable in __vmbus_open().

 drivers/hv/channel.c      | 174 ++++++++++++++++++++++++++++++++++++--
 drivers/hv/hyperv_vmbus.h |   3 +-
 drivers/hv/ring_buffer.c  |  28 +++++-
 include/linux/hyperv.h    |  22 +++++
 4 files changed, 218 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 3ebda7707e46a..7f9e43f846fc0 100644
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
 
@@ -783,7 +857,7 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 	/* in 8-bytes granularity */
 	desc.offset8 = sizeof(struct vmpacket_descriptor) >> 3;
 	desc.len8 = (u16)(packetlen_aligned >> 3);
-	desc.trans_id = requestid;
+	desc.trans_id = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 
 	bufferlist[0].iov_base = &desc;
 	bufferlist[0].iov_len = sizeof(struct vmpacket_descriptor);
@@ -792,7 +866,7 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, num_vecs);
+	return hv_ringbuffer_write(channel, bufferlist, num_vecs, requestid);
 }
 EXPORT_SYMBOL(vmbus_sendpacket);
 
@@ -834,7 +908,7 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 	desc.flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
 	desc.dataoffset8 = descsize >> 3; /* in 8-bytes granularity */
 	desc.length8 = (u16)(packetlen_aligned >> 3);
-	desc.transactionid = requestid;
+	desc.transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 	desc.reserved = 0;
 	desc.rangecount = pagecount;
 
@@ -851,7 +925,7 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3);
+	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
 
@@ -878,7 +952,7 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	desc->flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
 	desc->dataoffset8 = desc_size >> 3; /* in 8-bytes granularity */
 	desc->length8 = (u16)(packetlen_aligned >> 3);
-	desc->transactionid = requestid;
+	desc->transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 	desc->reserved = 0;
 	desc->rangecount = 1;
 
@@ -889,7 +963,7 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3);
+	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_mpb_desc);
 
@@ -937,3 +1011,91 @@ int vmbus_recvpacket_raw(struct vmbus_channel *channel, void *buffer,
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
index 38100e80360ac..45c7831ba0ef1 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -716,6 +716,22 @@ enum vmbus_device_type {
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
@@ -940,8 +956,14 @@ struct vmbus_channel {
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

