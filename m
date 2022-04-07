Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00204F74C0
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 06:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbiDGEeR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 00:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbiDGEeJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 00:34:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EFA1E6E89;
        Wed,  6 Apr 2022 21:32:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ot30so8231895ejb.12;
        Wed, 06 Apr 2022 21:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ZT/IdIg9UVN/KaRkbp2Q3ZH8GXUNvhUw+iGlhxbQRk=;
        b=juqfs5ewbM4T3/5g+BA73v8c0k5OHlqFDrH68lFXcOxmcNCs5OmgZll2YSGf3z0vzE
         fHICTdF/I8eJCGuPfGF8e941WQrDX2CDBGC+a7375TZo7D0S2rPxAP2yhxUVFv2YNESw
         stW3mkW2IQ9jX9cDj3e6UuufUeJdsA5qIzUsXSj8ya13qvmjs1I/ybtOgRB/zDJsTC4Y
         Z9j2akF2PaOtFrdKHWlgRBCQ2xNaeQTy0hPMqOGp3B3IhUxuvXV8W1RKsjtGvgqJ0SWR
         jqXRrbKfQ1UFHlhDdX43D2Q02PhlxcUbGa3irnWD6nMKwoxgJupu+Bt1n0y0vmY+ZI/Z
         R/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZT/IdIg9UVN/KaRkbp2Q3ZH8GXUNvhUw+iGlhxbQRk=;
        b=Iq54N0uWm/QBTqwSGOM8MKuRo0Rbsqb0BAfV5SY/xgB/RVO6PrTeK7XrF7WDhULEjV
         L6+nSiMC0o88dsu4lGm21bR31Zo5YQXIMTZoIPZy5ivTuO+K1rbwfB5/M1tylHoPGOjd
         JlXUOl1JbM46CR6WC30LeLWkO2arBIAUj6HUVHyRSt0TViI1ELL0fAC9yXHiE0UlI7HC
         a9WGbsw0HnTKQ+wdZ1rUL1Ze4bE4H23GJpU0inDTJLy9OdKz8XtzcMgAsttLyPo18Dkb
         iWThDGgAIJfTBnLroJ6ikanV1KBEZMYjSWgbZKgw0yvZ9pS1GWFwMPQHJxh9/lya55oD
         7JrQ==
X-Gm-Message-State: AOAM5338d0fGtKWMwekbkYqrzpEOfyhMpWuUqPKN1FTfOK3cno15wccK
        nORmZJinhkYf2mp41mK6ElM=
X-Google-Smtp-Source: ABdhPJxV10ybNQjOqtJCfnmVB3wxkUsdMt9kWR2ssh8IHswe4BN8WrQZqCzzWKXMXUOdn2t2eJYE2A==
X-Received: by 2002:a17:907:1c82:b0:6e0:acef:d238 with SMTP id nb2-20020a1709071c8200b006e0acefd238mr11815589ejc.96.1649305928456;
        Wed, 06 Apr 2022 21:32:08 -0700 (PDT)
Received: from anparri.mshome.net (host-87-11-75-174.retail.telecomitalia.it. [87.11.75.174])
        by smtp.gmail.com with ESMTPSA id ke11-20020a17090798eb00b006e7fbf53398sm3531341ejc.129.2022.04.06.21.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 21:32:08 -0700 (PDT)
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
Subject: [PATCH 1/6] Drivers: hv: vmbus: Fix handling of messages with transaction ID of zero
Date:   Thu,  7 Apr 2022 06:30:23 +0200
Message-Id: <20220407043028.379534-2-parri.andrea@gmail.com>
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

vmbus_request_addr() returns 0 (zero) if the transaction ID passed
to as argument is 0.  This is unfortunate for two reasons: first,
netvsc_send_completion() does not check for a NULL cmd_rqst (before
dereferencing the corresponding NVSP message); second, 0 is a *valid*
value of cmd_rqst in netvsc_send_tx_complete(), cf. the call of
vmbus_sendpacket() in netvsc_send_pkt().

vmbus_request_addr() has included the code in question since its
introduction with commit e8b7db38449ac ("Drivers: hv: vmbus: Add
vmbus_requestor data structure for VMBus hardening"); such code was
motivated by the early use of vmbus_requestor by hv_storvsc.  Since
hv_storvsc moved to a tag-based mechanism to generate and retrieve
transaction IDs with commit bf5fd8cae3c8f ("scsi: storvsc: Use
blk_mq_unique_tag() to generate requestIDs"), vmbus_request_addr()
can be modified to return VMBUS_RQST_ERROR if the ID is 0.  This
change solves the issues in hv_netvsc (and makes the handling of
messages with transaction ID of 0 consistent with the semantics
"the ID is not contained in the requestor/invalid ID").

vmbus_next_request_id(), vmbus_request_addr() should still reserve
the ID of 0 for Hyper-V, because Hyper-V will "ignore" (not respond
to) VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED packets/requests with
transaction ID of 0 from the guest.

Fixes: bf5fd8cae3c8f ("scsi: storvsc: Use blk_mq_unique_tag() to generate requestIDs")
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
The above hv_netvsc issues precede bf5fd8cae3c8f; however, these
changes should not be backported to earlier commits since such a
back-port would 'break' hv_storvsc.

 drivers/hv/channel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index dc5c35210c16a..20fc8d50a0398 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1245,7 +1245,9 @@ u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr)
 
 	/*
 	 * Cannot return an ID of 0, which is reserved for an unsolicited
-	 * message from Hyper-V.
+	 * message from Hyper-V; Hyper-V does not acknowledge (respond to)
+	 * VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED requests with ID of
+	 * 0 sent by the guest.
 	 */
 	return current_id + 1;
 }
@@ -1270,7 +1272,7 @@ u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
 
 	/* Hyper-V can send an unsolicited message with ID of 0 */
 	if (!trans_id)
-		return trans_id;
+		return VMBUS_RQST_ERROR;
 
 	spin_lock_irqsave(&rqstor->req_lock, flags);
 
-- 
2.25.1

