Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A2506C59
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 14:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352344AbiDSM0v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 08:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352278AbiDSM0r (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 08:26:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235FE35DD1;
        Tue, 19 Apr 2022 05:24:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y10so15120510ejw.8;
        Tue, 19 Apr 2022 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLXDzVerODqjWrpxJN150dJbPrLA4MMxEyURTH9iZIw=;
        b=ixssyE0e1NSQzM8V4ItPkvoWP3+kd+cKLBMFX46uaWFKV5MN3y7N8tQ+lvyzkR7C20
         5cH18JDdu4/gXB+D0FgU+I6xSgAdWqV2eJ/+nw7lyBetOKTZxP+FnhAoIMIGXhxZJP4a
         DtCzQgE+xNGqrvSSmfKw9s4IfKamVElq/dug0vXHB76rG2iQk7s94eCMmzX/GEY2N5mN
         CKouZt/kTbzh+QMRBMtKph2Mvid01sKk2wFxJwfdVbFgcD06hxfwDjTJqQTU7rPqgT1u
         NsqbHLTsQfjidtMfQApj2Vid5ReWGaCoH8TbNfBak7Z+JlVUyMGDzVNI+d8c9iMccHi5
         NPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLXDzVerODqjWrpxJN150dJbPrLA4MMxEyURTH9iZIw=;
        b=xlAAZoY0k+WKp81Gu4gklR8Fm3gfJ4fJuzFHfUYs3NBejGfUH1T8mzGecZX0ekGgqw
         4cHC0efSunPl3zeEBgkc48LUKrScCwDzE88pLTMnpgaYIqHtWwO06d/pX+x7bPKjZjwX
         YEIA3UcxqsVRpEGyAmMk5T7cN4KFGVgkeJzTFc1UMKRmW7tukZkX67Ic/bdGT5J30Y5G
         VnjvemhANJPCwPfAeylMMzjrFtMAdxshN9r/30Hq5DA4u01LWOXhwueEpQ6uQO3esTjy
         3Xd5qaGRDDJTCqXo01bvzFHmAVvgUk/iC9dRFN0YUsmJIKQINsWsYOTX2vqMF+X8AMkZ
         4G/w==
X-Gm-Message-State: AOAM532/FX5g/wqBDRbK4oNKTX4po0XzpQVvvA3yc/5vQTlJ5hVbsEDP
        DtO8rDPFn+1wvFCzQ3H1Iao=
X-Google-Smtp-Source: ABdhPJxz6sR359lL8G2Ya4IjU1dnKIxh3TEkgsJyNwUMPa7JIkaFa32MQAnXTcTCZNiGcKMMKiz3Ew==
X-Received: by 2002:a17:907:7b9d:b0:6df:fb8f:fe82 with SMTP id ne29-20020a1709077b9d00b006dffb8ffe82mr13127241ejc.652.1650371043683;
        Tue, 19 Apr 2022 05:24:03 -0700 (PDT)
Received: from anparri.mshome.net (host-82-53-3-95.retail.telecomitalia.it. [82.53.3.95])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm5644685ejm.189.2022.04.19.05.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:24:03 -0700 (PDT)
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
Subject: [PATCH v2 5/6] Drivers: hv: vmbus: Introduce {lock,unlock}_requestor()
Date:   Tue, 19 Apr 2022 14:23:24 +0200
Message-Id: <20220419122325.10078-6-parri.andrea@gmail.com>
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

To abtract the lock and unlock operations on the requestor spin lock.
The helpers will come in handy in hv_pci.

No functional change.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
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

