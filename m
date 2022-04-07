Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277C04F74C4
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 06:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiDGEeW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 00:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240668AbiDGEeP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 00:34:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB81E7477;
        Wed,  6 Apr 2022 21:32:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ot30so8232253ejb.12;
        Wed, 06 Apr 2022 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iq7An3zFyBeCpeIq4u05/jP/2nSd8ol7Y0CCrrlrlJg=;
        b=D3Wqlt0qjBhc8coIHUt9hckX7eJc8xt11zAjZLmh77d+rvAwVScZtDf6iE79dBfX81
         2LMlrOua9j0GzkPsDcS6P1aGZ7xjDAY9Il2/CeHWj/hMbLofgGRK8v2NlTvGvxQeoVef
         CK05QBMjdsV1dNhIOhfS/trcnsyS9r8Ssdw2uAStO/CVfuuGw6SEIeco+nPJU+5O41bG
         5qWtfIdUXWV6ZH8OJjzII7sV6nBW6kd0Npvi2oplTctMr0Q8e9151LhEhTvGnFmSjKXV
         X3P3V1gIsFz9oexZUd5Rpdg/1292sHysUHj+sxDGvIAmwWKLL0gBnHs4lXz9/L767LFp
         D/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iq7An3zFyBeCpeIq4u05/jP/2nSd8ol7Y0CCrrlrlJg=;
        b=d+YAT5XvP1+EdlXmUv+pNIcZsoerVbthFQBNouB2fYvniYgvgM6VFNQ6SuM5sGJ5tk
         T9ooZUBfklOdR0Civm0qQvvu24481igSGV0liDJhVZijgLtEzJ6prrQyIO+xwdUzRuw6
         MZlRKfsKBZ3oCpGsxY3F8r6xSX+dIXIqhIBxyjcvpJeOlwK94z8YcR4rYD3OPTcl7qBA
         u0o8q+H+0EBWYjn8CCSw7U+VxhfWqIYaBFvn3mg/48Jd5ug11q8xa77Mfi2DzdJAEsyS
         WRiqXSAvYnpFHMt//Pm98kQ+XKK7G/lbYGrLS44LII73wayWbnRIEwVyjIJSoRL7P44+
         LjeA==
X-Gm-Message-State: AOAM530Aaux6vDgRK0jnjjQbgZQrrLyINhhFaRcle8yIths/bH8+2spj
        Vb1JhCsfdzje1chgNn0/qeM=
X-Google-Smtp-Source: ABdhPJxsy/jIuf6iPkPoCW0oaCroTHFOQ9d0eGmRA8H/VZqearcPata1OQgad+gD9zAOk9zaaDfoug==
X-Received: by 2002:a17:906:19c6:b0:6ce:98a4:5ee6 with SMTP id h6-20020a17090619c600b006ce98a45ee6mr11186596ejd.567.1649305934325;
        Wed, 06 Apr 2022 21:32:14 -0700 (PDT)
Received: from anparri.mshome.net (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id ke11-20020a17090798eb00b006e7fbf53398sm3531341ejc.129.2022.04.06.21.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 21:32:13 -0700 (PDT)
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
Subject: [PATCH 3/6] Drivers: hv: vmbus: Introduce vmbus_sendpacket_getid()
Date:   Thu,  7 Apr 2022 06:30:25 +0200
Message-Id: <20220407043028.379534-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407043028.379534-1-parri.andrea@gmail.com>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
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

