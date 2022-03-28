Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB84E9A01
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Mar 2022 16:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbiC1OpJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Mar 2022 10:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbiC1Oo6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Mar 2022 10:44:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC695DE56;
        Mon, 28 Mar 2022 07:43:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bq8so15198731ejb.10;
        Mon, 28 Mar 2022 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMTqeBE3FIxp8HTVbYedcaXO9nqf4rXvpBaCDQ8h5rQ=;
        b=CP+jLK3XyRPt1s6LHqva5mG7v49WF71cPG7ErelvKANJ2MvpGpqbPTU3JJyZ+wMuYg
         roi1o0Kafl4dUQBQ95pGBSA94E4xl8L4gBvGcOFEF7dkPPtAnhz9e4T6OCA9VFw6sN+l
         FRhoTVfmpzWq9F79aiCqQBak2WPCwzEthUcAZPFmoyOgUCXhLewkvfgaKl65lmUUbiwN
         BmVukxngnR4hdrzP6pr7OuszH0G56FvJG0hsMDylPA4shj/HeGhpyBVwr0h5eDdYXDfA
         egcA2l7VBsL+OXjatrquWYZJYLRviuWILY6wS9k9HgBVh2g/pbcyTsR8TcmX0nZCz5Kh
         vPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMTqeBE3FIxp8HTVbYedcaXO9nqf4rXvpBaCDQ8h5rQ=;
        b=8GkgeOOCg+cFdsqZgcJp60HDXgIqrmiNJedODvxVXBxkNJfHefhKSWhZfUK/jAC6db
         HPOxAl5wKn9PMS3mJzGOkUIoumFg9phnQAg9c4d8jioEk28c7GLo0ir5cvbNEeVlJTEw
         rgPCcYb1mdn4yZMSESpGaHpG6Uz8farP8LToAKtJzeWsV+pfoX0BTS4oHFXN3PBof0NL
         pDMJaGz+j/1tEyFMiYDAn6FdXSYfr1MmYiJ3f5/92dzcaPgeo1g2ICMgaPv+Ckt7TMYz
         HY/rZ/9kGwr1XuRevObwo3kFVFVykwDYfsoloNIMvYQ4TskWEh3CW2J8Ivz36KofAiV4
         QWqg==
X-Gm-Message-State: AOAM533/TYW4YI8g8QDJt/hh/3OvTlCTlmxgzLWZafeGdybuo3iu2D9Y
        IlypUnNhN/blzfbvxM0FE8I=
X-Google-Smtp-Source: ABdhPJw7+9S0v7Xhf9hyaSMHMFA0ERycLJFI8Zejti6gd8HlXDWNirXQ/nL4Vr/YSz2PIjP+SVGURg==
X-Received: by 2002:a17:907:6089:b0:6db:a3d7:3fa9 with SMTP id ht9-20020a170907608900b006dba3d73fa9mr29289697ejc.593.1648478594893;
        Mon, 28 Mar 2022 07:43:14 -0700 (PDT)
Received: from anparri.mshome.net (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7c842000000b0041314b98872sm7008983edt.22.2022.03.28.07.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:43:14 -0700 (PDT)
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
Subject: [RFC PATCH 3/4] Drivers: hv: vmbus: Introduce vmbus_sendpacket_getid()
Date:   Mon, 28 Mar 2022 16:42:43 +0200
Message-Id: <20220328144244.100228-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328144244.100228-1-parri.andrea@gmail.com>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
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
 drivers/hv/ring_buffer.c  |  4 +++-
 include/linux/hyperv.h    |  7 +++++++
 4 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index a253eee3aeb1a..3eaa41c7ce15f 100644
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
index 71efacb909659..c8561c80c460c 100644
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
@@ -354,6 +354,8 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	}
 	desc = hv_get_ring_buffer(outring_info) + old_write;
 	desc->trans_id = (rqst_id == VMBUS_NO_RQSTOR) ? requestid : rqst_id;
+	if (trans_id)
+		*trans_id = desc->trans_id;
 
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

