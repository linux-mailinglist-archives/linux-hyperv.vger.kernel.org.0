Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F26506C57
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 14:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352313AbiDSM0t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 08:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352314AbiDSM0o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 08:26:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9C536B57;
        Tue, 19 Apr 2022 05:24:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y10so15120038ejw.8;
        Tue, 19 Apr 2022 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxecrYkqOB+wwyCqEfJ4q2uxWyj+awvYfcsp/PM49uA=;
        b=EKCvGdsiVhAgchWBgLjyl9Avsjs10WuZKsrA7EFvq4Q1LRjNDnC53/AZrTaAEEjW3b
         BlLUOIcnaRbKGvEf/PVBVcHnhGQltB+iIFyTB76ROQkmqZkH6IGJzWImRv0Q5zMh4SD1
         94SzlqY1wk4385sdnwWuWHb+e6jJQli50DvFkIAFYOq96yk1nJEN3PqR0acgKp9MbzSg
         UHiQ7yc2/5oQmQtnXSSr7CDd+uf926c5uJ/0+NIepA/9uIfHpKBlI445mRjRAZ4fL5tO
         elBz/BrSfXdyZk348w2LQ95srEmApkfRCS2IkjJzqEo4YeYK9hl9HPgOKy7Ls0KZUQ7t
         epdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxecrYkqOB+wwyCqEfJ4q2uxWyj+awvYfcsp/PM49uA=;
        b=AOpuZaoYXaOHwF6MGoHHg3wD2kfFkEyQwd7UPrOSA6vLnR7wRjafr7XPkJ1cYnLgyR
         z7SupwA96d84+MGdMQPgWRd91bU8zb/WxZGU0pw91dzD5lEvBWR2VhSDTWScpdEInW2V
         RNdR6HWuTLdtAvdfg7Piz0299J8bSHQBzxB6u17FvwZCxU3H8pkzlMMN/xRlOPAK9TuF
         fFG8A8nQrjV07/fUHJV8CypHt5D1BsNfA1wJR9XQm7c3JaXk5QO909oDaB5UdCnQ0u8B
         ESVMYnw165HzIDJhLvl1abQKGV9cEZYDVJdVCFqegL7FYquY91bhi0O+xFRSslQzTeTn
         T0pQ==
X-Gm-Message-State: AOAM531py/llv2hzXIIMmkJmwOkXU+LFBpDDt0g9quUoEWz8BG7wG6uO
        LKtbHFMtGu0vZL3gb6RN0Wo=
X-Google-Smtp-Source: ABdhPJznUaYGukNheFGdwIHIFMjeeOhCmDSDChULh7YRgfp2UTcI3NNQsRhjFgCbKWAOXesK7W93Jw==
X-Received: by 2002:a17:906:7316:b0:6d7:16be:b584 with SMTP id di22-20020a170906731600b006d716beb584mr13125576ejc.759.1650371038624;
        Tue, 19 Apr 2022 05:23:58 -0700 (PDT)
Received: from anparri.mshome.net (host-82-53-3-95.retail.telecomitalia.it. [82.53.3.95])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm5644685ejm.189.2022.04.19.05.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:23:58 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 3/6] Drivers: hv: vmbus: Introduce vmbus_sendpacket_getid()
Date:   Tue, 19 Apr 2022 14:23:22 +0200
Message-Id: <20220419122325.10078-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419122325.10078-1-parri.andrea@gmail.com>
References: <20220419122325.10078-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The function can be used to send a VMbus packet and retrieve the
corresponding transaction ID.  It will be used by hv_pci.

No functional change.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel.c      | 38 ++++++++++++++++++++++++++++++++------
 drivers/hv/hyperv_vmbus.h |  2 +-
 drivers/hv/ring_buffer.c  | 14 +++++++++++---
 include/linux/hyperv.h    |  7 +++++++
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 20fc8d50a0398..585a8084848bf 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1022,11 +1022,13 @@ void vmbus_close(struct vmbus_channel *channel)
 EXPORT_SYMBOL_GPL(vmbus_close);
 
 /**
- * vmbus_sendpacket() - Send the specified buffer on the given channel
+ * vmbus_sendpacket_getid() - Send the specified buffer on the given channel
  * @channel: Pointer to vmbus_channel structure
  * @buffer: Pointer to the buffer you want to send the data from.
  * @bufferlen: Maximum size of what the buffer holds.
  * @requestid: Identifier of the request
+ * @trans_id: Identifier of the transaction associated to this request, if
+ *            the send is successful; undefined, otherwise.
  * @type: Type of packet that is being sent e.g. negotiate, time
  *	  packet etc.
  * @flags: 0 or VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED
@@ -1036,8 +1038,8 @@ EXPORT_SYMBOL_GPL(vmbus_close);
  *
  * Mainly used by Hyper-V drivers.
  */
-int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
-			   u32 bufferlen, u64 requestid,
+int vmbus_sendpacket_getid(struct vmbus_channel *channel, void *buffer,
+			   u32 bufferlen, u64 requestid, u64 *trans_id,
 			   enum vmbus_packet_type type, u32 flags)
 {
 	struct vmpacket_descriptor desc;
@@ -1063,7 +1065,31 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, num_vecs, requestid);
+	return hv_ringbuffer_write(channel, bufferlist, num_vecs, requestid, trans_id);
+}
+EXPORT_SYMBOL(vmbus_sendpacket_getid);
+
+/**
+ * vmbus_sendpacket() - Send the specified buffer on the given channel
+ * @channel: Pointer to vmbus_channel structure
+ * @buffer: Pointer to the buffer you want to send the data from.
+ * @bufferlen: Maximum size of what the buffer holds.
+ * @requestid: Identifier of the request
+ * @type: Type of packet that is being sent e.g. negotiate, time
+ *	  packet etc.
+ * @flags: 0 or VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED
+ *
+ * Sends data in @buffer directly to Hyper-V via the vmbus.
+ * This will send the data unparsed to Hyper-V.
+ *
+ * Mainly used by Hyper-V drivers.
+ */
+int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
+		     u32 bufferlen, u64 requestid,
+		     enum vmbus_packet_type type, u32 flags)
+{
+	return vmbus_sendpacket_getid(channel, buffer, bufferlen,
+				      requestid, NULL, type, flags);
 }
 EXPORT_SYMBOL(vmbus_sendpacket);
 
@@ -1122,7 +1148,7 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
+	return hv_ringbuffer_write(channel, bufferlist, 3, requestid, NULL);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
 
@@ -1160,7 +1186,7 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
+	return hv_ringbuffer_write(channel, bufferlist, 3, requestid, NULL);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_mpb_desc);
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 3a1f007b678a0..64c0b9cbe183b 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -181,7 +181,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
 
 int hv_ringbuffer_write(struct vmbus_channel *channel,
 			const struct kvec *kv_list, u32 kv_count,
-			u64 requestid);
+			u64 requestid, u64 *trans_id);
 
 int hv_ringbuffer_read(struct vmbus_channel *channel,
 		       void *buffer, u32 buflen, u32 *buffer_actual_len,
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 3d215d9dec433..e101b11f95e5d 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -283,7 +283,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
 /* Write to the ring buffer. */
 int hv_ringbuffer_write(struct vmbus_channel *channel,
 			const struct kvec *kv_list, u32 kv_count,
-			u64 requestid)
+			u64 requestid, u64 *trans_id)
 {
 	int i;
 	u32 bytes_avail_towrite;
@@ -294,7 +294,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	unsigned long flags;
 	struct hv_ring_buffer_info *outring_info = &channel->outbound;
 	struct vmpacket_descriptor *desc = kv_list[0].iov_base;
-	u64 rqst_id = VMBUS_NO_RQSTOR;
+	u64 __trans_id, rqst_id = VMBUS_NO_RQSTOR;
 
 	if (channel->rescind)
 		return -ENODEV;
@@ -353,7 +353,15 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 		}
 	}
 	desc = hv_get_ring_buffer(outring_info) + old_write;
-	desc->trans_id = (rqst_id == VMBUS_NO_RQSTOR) ? requestid : rqst_id;
+	__trans_id = (rqst_id == VMBUS_NO_RQSTOR) ? requestid : rqst_id;
+	/*
+	 * Ensure the compiler doesn't generate code that reads the value of
+	 * the transaction ID from the ring buffer, which is shared with the
+	 * Hyper-V host and subject to being changed at any time.
+	 */
+	WRITE_ONCE(desc->trans_id, __trans_id);
+	if (trans_id)
+		*trans_id = __trans_id;
 
 	/* Set previous packet start */
 	prev_indices = hv_get_ring_bufferindices(outring_info);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index fe2e0179ed51e..a7cb596d893b1 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1161,6 +1161,13 @@ extern int vmbus_open(struct vmbus_channel *channel,
 
 extern void vmbus_close(struct vmbus_channel *channel);
 
+extern int vmbus_sendpacket_getid(struct vmbus_channel *channel,
+				  void *buffer,
+				  u32 bufferLen,
+				  u64 requestid,
+				  u64 *trans_id,
+				  enum vmbus_packet_type type,
+				  u32 flags);
 extern int vmbus_sendpacket(struct vmbus_channel *channel,
 				  void *buffer,
 				  u32 bufferLen,
-- 
2.25.1

