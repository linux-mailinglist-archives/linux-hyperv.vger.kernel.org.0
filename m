Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AACA2CB8B2
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 10:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388023AbgLBJX2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 04:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbgLBJX0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 04:23:26 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C378C061A04;
        Wed,  2 Dec 2020 01:22:46 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 64so2668230wra.11;
        Wed, 02 Dec 2020 01:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yrld+XmN/vbv+jk5N92rDHV5UMeqf6ebpPofy4kreH8=;
        b=Xij5mvjEW9ohN++bWOTjcsYKucoj0U0E6mk7SMjR29KGMRijdKmz7d1bms37cAVmdK
         XCpM8vgOx8csEqU7HGg03P2QqsGGjSTwuC4tly0N7GHAW/HrRhTnehAaiL0/RmJfz3kE
         DzBYHSJQebZwE3WzBD/ZFZ7SuMZfRXPX3W2ofK2lCuclDkrRrrIGfIKndVi+e4vnsZdo
         pqpdkkb7CcYKhxp0rGbQH6Wt30xt9lg3dFn064hNCNupyW//Rmd6yEuEeVrfMCp3UGML
         sUGMIpR+4uakjMJkydQH5JJj0haIBORmbjxmb8Nj52eLurP6e/naRS7nT4y9EXe/0E23
         tUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrld+XmN/vbv+jk5N92rDHV5UMeqf6ebpPofy4kreH8=;
        b=hQ0EeTuceb7AS/JUddqosem/2VEXCR5dqAYH4QOmEJKkQa4+XJWii2VLBHLfhx7xFJ
         RRDotfIgku3Ew67Z50B1KM8364l7BZ3MfTY8zrsGk7EQ7j9iqiewZzH8TDSpp8679WPy
         N/WYP9yU0GBmGmncfuCr0PqTfUPolIU8S7cLehXHsrQnD3FYiwbyv/DAL2xFkxZW7LJs
         pzMp74CBQH8gXd49HlHgPZN609MGKL7qHze5p9PQLBJl1I4NL1t4a9Otow12Mx7IJG6m
         dD23jdezgnuMwbG6OwklFbnnuuNs7k5XaJfgjixmtXt5feqR2JB7c6BHi0QLclJ0c+r3
         s6Nw==
X-Gm-Message-State: AOAM530nG1lrv1p4bWsywNQuHw/fuwoX325JlcNNwk51IDVcuiSx+ryc
        VqA/UkFyWhKw4nYeZy+dy53401Bc7YxaTw==
X-Google-Smtp-Source: ABdhPJwEaVPnXWiTtJlNy9Xa6P6KviiLe1bjk4kMdq3EFYaloRNzA6kcYdGJdvnS9CtPZUSu5XdNqA==
X-Received: by 2002:a05:6000:347:: with SMTP id e7mr2176832wre.35.1606900964652;
        Wed, 02 Dec 2020 01:22:44 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id e27sm1535936wrc.9.2020.12.02.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:22:44 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 4/7] Drivers: hv: vmbus: Copy the hv_message object in vmbus_on_msg_dpc()
Date:   Wed,  2 Dec 2020 10:22:11 +0100
Message-Id: <20201202092214.13520-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202092214.13520-1-parri.andrea@gmail.com>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The hv_message object is in memory shared with the host.  To prevent
an erroneous or a malicious host from 'corrupting' such object, copy
the object into private memory.

Suggested-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/vmbus_drv.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0e39f1d6182e9..796202aa7f9b4 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1054,14 +1054,24 @@ void vmbus_on_msg_dpc(unsigned long data)
 {
 	struct hv_per_cpu_context *hv_cpu = (void *)data;
 	void *page_addr = hv_cpu->synic_message_page;
-	struct hv_message *msg = (struct hv_message *)page_addr +
+	struct hv_message msg_copy, *msg = (struct hv_message *)page_addr +
 				  VMBUS_MESSAGE_SINT;
-	__u8 payload_size = msg->header.payload_size;
 	struct vmbus_channel_message_header *hdr;
 	enum vmbus_channel_message_type msgtype;
 	const struct vmbus_channel_message_table_entry *entry;
 	struct onmessage_work_context *ctx;
-	u32 message_type = msg->header.message_type;
+	__u8 payload_size;
+	u32 message_type;
+
+	/*
+	 * The hv_message object is in memory shared with the host.  Prevent an
+	 * erroneous or malicious host from 'corrupting' such object by copying
+	 * the object to private memory.
+	 */
+	memcpy(&msg_copy, msg, sizeof(struct hv_message));
+
+	payload_size = msg_copy.header.payload_size;
+	message_type = msg_copy.header.message_type;
 
 	/*
 	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
@@ -1074,13 +1084,7 @@ void vmbus_on_msg_dpc(unsigned long data)
 		/* no msg */
 		return;
 
-	/*
-	 * The hv_message object is in memory shared with the host.  The host
-	 * could erroneously or maliciously modify such object.  Make sure to
-	 * validate its fields and avoid double fetches whenever feasible.
-	 */
-
-	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
+	hdr = (struct vmbus_channel_message_header *)msg_copy.u.payload;
 	msgtype = hdr->msgtype;
 
 	trace_vmbus_on_msg_dpc(hdr);
@@ -1111,7 +1115,7 @@ void vmbus_on_msg_dpc(unsigned long data)
 			return;
 
 		INIT_WORK(&ctx->work, vmbus_onmessage_work);
-		memcpy(&ctx->msg, msg, sizeof(msg->header) + payload_size);
+		memcpy(&ctx->msg, &msg_copy, sizeof(msg_copy.header) + payload_size);
 
 		/*
 		 * The host can generate a rescind message while we
-- 
2.25.1

