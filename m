Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AB619F3B5
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgDFKmG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Apr 2020 06:42:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26993 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727081AbgDFKmG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Apr 2020 06:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586169724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4zpfxaqb0ccFa0yBKaxqDnNFpT31vP53ONi1El8rscc=;
        b=gfd5GM8XAoBkqTsKFXnJRINE4/vRcFNgiu3c8KMwhJayQ2HvIQ+qQIrjxz/2LOoj1AncbS
        BWzYaKqj3zKETZ8m26mHr6+rKmP55WRmn07kHs9Euopmghh3kvkeLXFjsGC6heQGaZAwCc
        c16a6FLPmviqqhF8NAXfM9xHVsJ3UR0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-ekTt8z8XOeCDgFTQAkia9w-1; Mon, 06 Apr 2020 06:42:03 -0400
X-MC-Unique: ekTt8z8XOeCDgFTQAkia9w-1
Received: by mail-wm1-f69.google.com with SMTP id s9so4760403wmh.2
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Apr 2020 03:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4zpfxaqb0ccFa0yBKaxqDnNFpT31vP53ONi1El8rscc=;
        b=ulfKnaDbXrPVRiFQtuB2oxMhS8UmNTUz8E7oL2ZVXkoZ2f2AVr/mLNK/nYy/iGYepk
         5XEt9Dn8Ontar+JJRxnFiHOAnbgacf23G0mbT0mAPBdFVaNlpmuDNGCmPDWsC5k++d6T
         p726pRgD3+r6hx8/MG/uzPS0PERJgXMJk/BAXQKhwong0jEwyLmWpZbYPfioULokWqza
         ESqk0e4MifCoj3bqIC+/nbvSqSFagBP26lIexiNH7+y3JAvOqbZXo9l4jqjIWutRhlcH
         SQEDJes2SxpJTIVHvA71T0rpzo9SYMpGhcmBv+gatiIFX3yhiBhXt9/MkON9eExbaPZq
         S96Q==
X-Gm-Message-State: AGi0PuaFLmzO6HLWtOsUDNmbR5G/5h0MwyAatW2Zv3JcnnWxDwjq/l3G
        sDy0vnWJF8EjdFKrajR8U1wlZkipiyeibBTV6or4/HADHO5bLqH1dvgZeI9ris4ukd7+AiGA8//
        pi9lzVJf3CNOCMyYuHwmwCyTI
X-Received: by 2002:a1c:ed18:: with SMTP id l24mr14825724wmh.122.1586169721599;
        Mon, 06 Apr 2020 03:42:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypI1nM9tk1MDjQ788b8Qefr1ElToMYsfjXmapNT4bDFxpXcKeT+Kkypyy+XDjssU2Hb5gJePfw==
X-Received: by 2002:a1c:ed18:: with SMTP id l24mr14825709wmh.122.1586169721401;
        Mon, 06 Apr 2020 03:42:01 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a2sm17305337wra.71.2020.04.06.03.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:42:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 3/5] Drivers: hv: avoid passing opaque pointer to vmbus_onmessage()
Date:   Mon,  6 Apr 2020 12:41:52 +0200
Message-Id: <20200406104154.45010-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406104154.45010-1-vkuznets@redhat.com>
References: <20200406104154.45010-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

vmbus_onmessage() doesn't need the header of the message, it only
uses it to get to the payload, we can pass the pointer to the
payload directly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 7 +------
 drivers/hv/vmbus_drv.c    | 3 ++-
 include/linux/hyperv.h    | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 0370364169c4..c6bcfee6ac99 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1360,13 +1360,8 @@ channel_message_table[CHANNELMSG_COUNT] = {
  *
  * This is invoked in the vmbus worker thread context.
  */
-void vmbus_onmessage(void *context)
+void vmbus_onmessage(struct vmbus_channel_message_header *hdr)
 {
-	struct hv_message *msg = context;
-	struct vmbus_channel_message_header *hdr;
-
-	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
-
 	trace_vmbus_on_message(hdr);
 
 	/*
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b114bb411d7e..4ab2f1511dcb 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1007,7 +1007,8 @@ static void vmbus_onmessage_work(struct work_struct *work)
 
 	ctx = container_of(work, struct onmessage_work_context,
 			   work);
-	vmbus_onmessage(&ctx->msg);
+	vmbus_onmessage((struct vmbus_channel_message_header *)
+			&ctx->msg.payload);
 	kfree(ctx);
 }
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 692c89ccf5df..cbd24f4e68d1 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1017,7 +1017,7 @@ static inline void clear_low_latency_mode(struct vmbus_channel *c)
 	c->low_latency = false;
 }
 
-void vmbus_onmessage(void *context);
+void vmbus_onmessage(struct vmbus_channel_message_header *hdr);
 
 int vmbus_request_offers(void);
 
-- 
2.25.1

