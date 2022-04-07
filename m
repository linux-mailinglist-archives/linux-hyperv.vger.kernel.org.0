Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7559C4F74D2
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 06:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbiDGEeY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 00:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbiDGEeS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 00:34:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BFC1E816B;
        Wed,  6 Apr 2022 21:32:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n6so8233344ejc.13;
        Wed, 06 Apr 2022 21:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YeGL7lzBfsKJziEcGc06vjizc2vur51ZL5S8EuTAwZw=;
        b=F54Lu3n41OZgyScu9We50U8ODKJ+j4XTgJi5+ISj8520Kevyg8EhNJFxqlcTxWMwjM
         zQxrXX8xCqjlj9y84u8+DXqPK0mytpDmRZAP24zEM1D2nHAraSocombPlalItxS7kvgI
         +loq4sazD48S3UgrvloGuAB2y/J+AeupGJQItOMObywN/pdI5qmi/Mna92v84XCKzuDw
         PxxzBqa2z4QIFHjmRZYrGCdZfsfnRCoCrZzhr8pMFl3plkoBFnsx74rD1al8rEAOcOy0
         PnACIX/pGkSKd60zprf7eCF6tmDYFbqvorPtQLLq47sqWbVek2eEVJNaiWIdIID6dKfE
         AqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YeGL7lzBfsKJziEcGc06vjizc2vur51ZL5S8EuTAwZw=;
        b=0yhuuq3S0Qj4jBG3VlTZ+U8NVReV9PAe5fEHo+IY5euS62RsieuWX9jRZXrqwF8xqw
         +DVkBabJOTjadbpQqBdbKV/OA35gzDj1E/+5R8EYaTVXz8zEw7RLyr2MKOcB4rZnVNOe
         sTEPkYSbXtX8m510nj7/ou51X6ve4Esc5Xp7/FPQvFm6iItahffczxf0plvajo3kLAyh
         VdxgSLVhWLiho3u14eAeC+QmkIvzLLYXUxtf+Yq3RBcr40mODf5PPugPv2El0tqpsoyp
         43PTocuYM9cexI07L1y3f9jNvVOr0AEC9h3f6v03YTse6KcIJFgH+AgCc0anZNX0KE6e
         OSMg==
X-Gm-Message-State: AOAM5301mBt/14VaVnSIbAVtEjKCZS5SLzLK0d8h+rNfSJNKmcbje1LS
        3WhFBXUfHgIopUs5rU7JuHI=
X-Google-Smtp-Source: ABdhPJxzAw6z+Kr7CeDU3lk5MWo4uT91DzsFchXuq/QeynrICu0+t8Y62KmD4gcCStkUJ1T7V4cXBg==
X-Received: by 2002:a17:907:a088:b0:6e4:dad7:1b1f with SMTP id hu8-20020a170907a08800b006e4dad71b1fmr11236607ejc.84.1649305938504;
        Wed, 06 Apr 2022 21:32:18 -0700 (PDT)
Received: from anparri.mshome.net (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id ke11-20020a17090798eb00b006e7fbf53398sm3531341ejc.129.2022.04.06.21.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 21:32:18 -0700 (PDT)
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
Subject: [PATCH 5/6] Drivers: hv: vmbus: Introduce {lock,unlock}_requestor()
Date:   Thu,  7 Apr 2022 06:30:27 +0200
Message-Id: <20220407043028.379534-6-parri.andrea@gmail.com>
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

To abtract the lock and unlock operations on the requestor spin lock.
The helpers will come in handy in hv_pci.

No functional change.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c   | 11 +++++------
 include/linux/hyperv.h | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 49f10a603a091..56f7e06c673e4 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1252,12 +1252,12 @@ u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr)
 	if (!channel->rqstor_size)
 		return VMBUS_NO_RQSTOR;
 
-	spin_lock_irqsave(&rqstor->req_lock, flags);
+	lock_requestor(channel, flags);
 	current_id = rqstor->next_request_id;
 
 	/* Requestor array is full */
 	if (current_id >= rqstor->size) {
-		spin_unlock_irqrestore(&rqstor->req_lock, flags);
+		unlock_requestor(channel, flags);
 		return VMBUS_RQST_ERROR;
 	}
 
@@ -1267,7 +1267,7 @@ u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr)
 	/* The already held spin lock provides atomicity */
 	bitmap_set(rqstor->req_bitmap, current_id, 1);
 
-	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+	unlock_requestor(channel, flags);
 
 	/*
 	 * Cannot return an ID of 0, which is reserved for an unsolicited
@@ -1327,13 +1327,12 @@ EXPORT_SYMBOL_GPL(__vmbus_request_addr_match);
 u64 vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
 			     u64 rqst_addr)
 {
-	struct vmbus_requestor *rqstor = &channel->requestor;
 	unsigned long flags;
 	u64 req_addr;
 
-	spin_lock_irqsave(&rqstor->req_lock, flags);
+	lock_requestor(channel, flags);
 	req_addr = __vmbus_request_addr_match(channel, trans_id, rqst_addr);
-	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+	unlock_requestor(channel, flags);
 
 	return req_addr;
 }
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index c77d78f34b96a..015e4ceb43029 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1042,6 +1042,21 @@ struct vmbus_channel {
 	u32 max_pkt_size;
 };
 
+#define lock_requestor(channel, flags)					\
+do {									\
+	struct vmbus_requestor *rqstor = &(channel)->requestor;		\
+									\
+	spin_lock_irqsave(&rqstor->req_lock, flags);			\
+} while (0)
+
+static __always_inline void unlock_requestor(struct vmbus_channel *channel,
+					     unsigned long flags)
+{
+	struct vmbus_requestor *rqstor = &channel->requestor;
+
+	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+}
+
 u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr);
 u64 __vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id,
 			       u64 rqst_addr);
-- 
2.25.1

