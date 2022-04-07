Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3B14F74C6
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 06:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbiDGEeX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 00:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbiDGEeR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 00:34:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB28A1E6F80;
        Wed,  6 Apr 2022 21:32:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r10so5000580eda.1;
        Wed, 06 Apr 2022 21:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzsO0OH64I9oYEuJ3bY1ziODzwl46OGR5ery+8e6tc4=;
        b=Kqciknive9KvGUbs71Z+2JUtJqRbxHRIRvk+3wCe2zKZjAe2FuZN5Iw9V+bM4ShVas
         zrCB6gvQQzXb0V5n1G3OUBkHlbuTZ2y7v7/IfbgCC9yKDBDkBafTuz9SdYdFrc1fFxZq
         5JDHnt+nXlL1JrgYi0qtmAiexcbooenX81b5mTWw+ZxLUwCOD3aXy/0OdZFYnuIdROf4
         YOkCPhWIj45uea7nw5GwQV7RyelvZKYDKrYcT0VYzDYYj7isyL3QCtZWK4YKSLae5H2w
         E2hP7/cKNk6OtoTnAawWd8wiZ/V0hV6GJohSCq9tDuLJRpESMbP1T9/yMPfQ4oftGxff
         nVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzsO0OH64I9oYEuJ3bY1ziODzwl46OGR5ery+8e6tc4=;
        b=x1YSwQuxsfCFlDJ179K7zNzL/Eea2pTr9GGuierg7cczoJpwXrC81mbC7hpFEZvDxB
         72Lo99D8N+3g5SC6WkxgI0NDCryYKAa2PYQ8P9HQJj0B/9HeXMMu/Ik9PlEwxJMZUBaT
         iyD80OSc/95MXsZyjdzJuOe+H/2TMSQhGZgMU8W5Aaaje34JNnH7LbbE+Zab+8MThNHu
         713dPUvUKh7eVlxhpO2e7vlH/nsWXlEefZ+BWl8IVRH1YKrTvHvnHWB/O08lpXuF50lV
         KZJWMh6LWzLG2eZkFovajXtyvqOzIKb7TEoimgDL+DvSGzTUWGCJhQ7h4GlEMCYXyLHR
         D+AA==
X-Gm-Message-State: AOAM530ZwPRKkHSLfR3sUAug23V9muHJkXlaoVZDxeW4UgUbPbyX+Ff+
        R1qtBpMOGp+s4ggM0zL4h0s=
X-Google-Smtp-Source: ABdhPJxvbHS6Z5yrJL4QnjMLuMR2ia6OQV2phjaGSlfbQ5cEiI6213i9pD6/nJTh40E7oiTIYXjsVQ==
X-Received: by 2002:a05:6402:190d:b0:41b:a70d:1367 with SMTP id e13-20020a056402190d00b0041ba70d1367mr12116188edz.155.1649305936485;
        Wed, 06 Apr 2022 21:32:16 -0700 (PDT)
Received: from anparri.mshome.net (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id ke11-20020a17090798eb00b006e7fbf53398sm3531341ejc.129.2022.04.06.21.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 21:32:16 -0700 (PDT)
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
Subject: [PATCH 4/6] Drivers: hv: vmbus: Introduce vmbus_request_addr_match()
Date:   Thu,  7 Apr 2022 06:30:26 +0200
Message-Id: <20220407043028.379534-5-parri.andrea@gmail.com>
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

The function can be used to retrieve and clear/remove a transation ID
from a channel requestor, provided the memory address corresponding to
the ID equals a specified address.  The function, and its 'lockless'
variant __vmbus_request_addr_match(), will be used by hv_pci.

Refactor vmbus_request_addr() to reuse the 'newly' introduced code.

No functional change.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c   | 65 ++++++++++++++++++++++++++++++------------
 include/linux/hyperv.h |  5 ++++
 2 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 585a8084848bf..49f10a603a091 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1279,17 +1279,11 @@ u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr)
 }
 EXPORT_SYMBOL_GPL(vmbus_next_request_id);
 
-/*
- * vmbus_request_addr - Returns the memory address stored at @trans_id
- * in @rqstor. Uses a spin lock to avoid race conditions.
- * @channel: Pointer to the VMbus channel struct
- * @trans_id: Request id sent back from Hyper-V. Becomes the requestor's
- * next request id.
- */
-u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
+/* As in vmbus_request_addr_match() but without the requestor lock */
+u64 __vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
+			       u64 rqst_addr)
 {
 	struct vmbus_requestor *rqstor = &channel->requestor;
-	unsigned long flags;
 	u64 req_addr;
 
 	/* Check rqstor has been initialized */
@@ -1300,25 +1294,60 @@ u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
 	if (!trans_id)
 		return VMBUS_RQST_ERROR;
 
-	spin_lock_irqsave(&rqstor->req_lock, flags);
-
 	/* Data corresponding to trans_id is stored at trans_id - 1 */
 	trans_id--;
 
 	/* Invalid trans_id */
-	if (trans_id >= rqstor->size || !test_bit(trans_id, rqstor->req_bitmap)) {
-		spin_unlock_irqrestore(&rqstor->req_lock, flags);
+	if (trans_id >= rqstor->size || !test_bit(trans_id, rqstor->req_bitmap))
 		return VMBUS_RQST_ERROR;
-	}
 
 	req_addr = rqstor->req_arr[trans_id];
-	rqstor->req_arr[trans_id] = rqstor->next_request_id;
-	rqstor->next_request_id = trans_id;
+	if (rqst_addr == VMBUS_RQST_ADDR_ANY || req_addr == rqst_addr) {
+		rqstor->req_arr[trans_id] = rqstor->next_request_id;
+		rqstor->next_request_id = trans_id;
 
-	/* The already held spin lock provides atomicity */
-	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
+		/* The already held spin lock provides atomicity */
+		bitmap_clear(rqstor->req_bitmap, trans_id, 1);
+	}
+
+	return req_addr;
+}
+EXPORT_SYMBOL_GPL(__vmbus_request_addr_match);
+
+/*
+ * vmbus_request_addr_match - Clears/removes @trans_id from the @channel's
+ * requestor, provided the memory address stored at @trans_id equals @rqst_addr
+ * (or provided @rqst_addr matches the sentinel value VMBUS_RQST_ADDR_ANY).
+ *
+ * Returns the memory address stored at @trans_id, or VMBUS_RQST_ERROR if
+ * @trans_id is not contained in the requestor.
+ *
+ * Acquires and releases the requestor spin lock.
+ */
+u64 vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
+			     u64 rqst_addr)
+{
+	struct vmbus_requestor *rqstor = &channel->requestor;
+	unsigned long flags;
+	u64 req_addr;
 
+	spin_lock_irqsave(&rqstor->req_lock, flags);
+	req_addr = __vmbus_request_addr_match(channel, trans_id, rqst_addr);
 	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+
 	return req_addr;
 }
+EXPORT_SYMBOL_GPL(vmbus_request_addr_match);
+
+/*
+ * vmbus_request_addr - Returns the memory address stored at @trans_id
+ * in @rqstor. Uses a spin lock to avoid race conditions.
+ * @channel: Pointer to the VMbus channel struct
+ * @trans_id: Request id sent back from Hyper-V. Becomes the requestor's
+ * next request id.
+ */
+u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
+{
+	return vmbus_request_addr_match(channel, trans_id, VMBUS_RQST_ADDR_ANY);
+}
 EXPORT_SYMBOL_GPL(vmbus_request_addr);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index a7cb596d893b1..c77d78f34b96a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -788,6 +788,7 @@ struct vmbus_requestor {
 
 #define VMBUS_NO_RQSTOR U64_MAX
 #define VMBUS_RQST_ERROR (U64_MAX - 1)
+#define VMBUS_RQST_ADDR_ANY U64_MAX
 /* NetVSC-specific */
 #define VMBUS_RQST_ID_NO_RESPONSE (U64_MAX - 2)
 /* StorVSC-specific */
@@ -1042,6 +1043,10 @@ struct vmbus_channel {
 };
 
 u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr);
+u64 __vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
+			       u64 rqst_addr);
+u64 vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
+			     u64 rqst_addr);
 u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id);
 
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
-- 
2.25.1

