Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A0A19A9AB
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2020 12:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgDAKgy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Apr 2020 06:36:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31777 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727421AbgDAKgu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Apr 2020 06:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+RJMlg5CK8Xf3dXFmPzqcBa4d+f+ZwsjXoAvCEpkVM=;
        b=iVbifz4LZHMKkwAa+gnAFe/fFfXAB2IRk/iQ89R1WBUd2E7Bj4b2bA8v5dljIc0CWHaLJS
        xy5WL/6zVzZPR3HWOavXagLu6bqyQ4lGpGzNUb3nqDoT5sx4Lg+V8mJa8BR6ev5NpcspJm
        rLNjfyteYY3RXaKNuAkZkq5B54mmQ5g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-YzwAZzikNfCo6eOP4bSUrw-1; Wed, 01 Apr 2020 06:36:48 -0400
X-MC-Unique: YzwAZzikNfCo6eOP4bSUrw-1
Received: by mail-wm1-f69.google.com with SMTP id j18so1649787wmi.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Apr 2020 03:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+RJMlg5CK8Xf3dXFmPzqcBa4d+f+ZwsjXoAvCEpkVM=;
        b=Y4HGvBw2D921D+LxJ1p6UhmtnfTvl2ziF4eHEJcA0WhLdv6xl1u3j7drUcNK1SiXx+
         0EZy2HJmqx74USWWKH6e4YjSdd+JT14O7et56koOqrMHBsf1RC56yg5nPmX988w+57VR
         S7vueBCxISQKIRZpUkNAV4jFP6k1oaaQ5mcg2EFlJq4Ve8LhYMJ/l1zYHuL5x6j4h1Bf
         Mt5RhgojqmlXV71JMHjHJLp5N3EHX6t5jMz1GmIqjDLOQV4dR4S9s++kjk7apSJDU4fq
         Lh9IFGizliv/ViBIeQvk5M7V+JoLWTVkMC2TwP/L1wZ0yIrjtgyyKdHI2HHCmsst0DdY
         Pg8g==
X-Gm-Message-State: AGi0PuZUPuKakNbmp96kvSbTqC2mSifShVMsga5Z5A6ctUQb8suIbrez
        pjCc4IfuUIi7m8aCZ+X81/F/vNCQ2XCEh4BuXdsFQrfI+uOCC/3HnkSGRVkAXppvskwjyi5f8al
        BJzAU6DzqR09xK4cSr4BnkIGw
X-Received: by 2002:a1c:e203:: with SMTP id z3mr3719396wmg.71.1585737406038;
        Wed, 01 Apr 2020 03:36:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ1GRqYSB9mCxSqLV2KYOT5PI7lUFwv7VuBW5jCqPEGUyfyFKyo1jXzc+EY6I41a9uzyNxVOw==
X-Received: by 2002:a1c:e203:: with SMTP id z3mr3719372wmg.71.1585737405795;
        Wed, 01 Apr 2020 03:36:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b187sm2247522wmc.14.2020.04.01.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:36:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 3/5] Drivers: hv: avoid passing opaque pointer to vmbus_onmessage()
Date:   Wed,  1 Apr 2020 12:36:36 +0200
Message-Id: <20200401103638.1406431-4-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401103638.1406431-1-vkuznets@redhat.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
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
index 642782bef863..0f7bbf952d89 100644
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

