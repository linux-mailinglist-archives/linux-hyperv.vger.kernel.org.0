Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B2364FF5
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 03:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhDTBos (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Apr 2021 21:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhDTBos (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Apr 2021 21:44:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A397C06174A;
        Mon, 19 Apr 2021 18:44:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w3so55866849ejc.4;
        Mon, 19 Apr 2021 18:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GG3AMLwW94KT5mM9V06bUHeizVVCnRQZ6QXetNPR3KA=;
        b=GxRli68U2EHb5GjgleYcN4PW/4VgVhahrEbye12uoKi0BDuMQbjcq9I9rmiADpyDxb
         G4uopTYtvNuoSItvuL/ENt+D4qa8VQPZ+oRHnGsx1xyyuODlre9qb9kVsb7mxVOFW3yM
         SHjm+Dnsrot5yj0CkdHlDqie6zoh+kuuWrjwBxX+gV3wTy64jt7QueXtj8a1/3wqBWW7
         Lru4wecO2/0aPX8IALErX+m8EiIedl82+chKWajH/gyuTaSyDqLTIu09HWRPFrPYT4QU
         busBQKWvqvtWlN3A98Xatw27HRE+vRaC+9zpiTYQ9vWZ4rj8XcKRhDNCR2qIBLHSIsJg
         69iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GG3AMLwW94KT5mM9V06bUHeizVVCnRQZ6QXetNPR3KA=;
        b=jHwBMIuHw/XWDHan7L4o9/L7F6bpzJGefvIkn5LiaGbrEHO06IHRlIO3uRFUj3Fvja
         ZbsgPZSoHpwD0tdEBhnfMtsngHKVsNSQ2eSo9XlzMnHOgYg4BNRnF7Ou24GWQnV0Ip+t
         0Z4whlolUPRwXzuivxZgve2jNiYWxpLEx7TJv3HkslHEc0IlZRA5AfuhD8yrUiOqIFhc
         7kzVUxgNNBv2DOeMg23WC4TMvpcjeXlBNLAVg3nh+EtJ13sXfA6s9K92+0/pudVG6y1c
         sueC+ZlUGWP87uRBH2/ycgMqfI97QX3mjrueNTU19OmYDTNEe46LpiL72meOq+LYHSX5
         x9Yg==
X-Gm-Message-State: AOAM530RX2q6U/5gV+jOPPxySUHv+ROf5fb5OuLtd9oUUc1mr+HxR5Am
        bdjSiaX//gp24U+0nBm3LYd5+Puf4hiTZg==
X-Google-Smtp-Source: ABdhPJzcX3ZPsLdifrkBw6SMEl6ypGtf6u3LN2r5IwyAlNyecQBfTZRNG0qznOYFBF936OeVGJ81Uw==
X-Received: by 2002:a17:906:c419:: with SMTP id u25mr25466022ejz.332.1618883055902;
        Mon, 19 Apr 2021 18:44:15 -0700 (PDT)
Received: from anparri.mshome.net ([151.76.104.230])
        by smtp.gmail.com with ESMTPSA id t1sm11495321eju.88.2021.04.19.18.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 18:44:15 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2] Drivers: hv: vmbus: Initialize unload_event statically
Date:   Tue, 20 Apr 2021 03:43:50 +0200
Message-Id: <20210420014350.2002-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

If a malicious or compromised Hyper-V sends a spurious message of type
CHANNELMSG_UNLOAD_RESPONSE, the function vmbus_unload_response() will
call complete() on an uninitialized event, and cause an oops.

Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
Changes since v1[1]:
  - add inline comment in vmbus_unload_response()

[1] https://lkml.kernel.org/r/20210416143932.16512-1-parri.andrea@gmail.com

 drivers/hv/channel_mgmt.c | 7 ++++++-
 drivers/hv/connection.c   | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 4c9e45d1f462c..335a10ee03a5e 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -826,6 +826,11 @@ static void vmbus_unload_response(struct vmbus_channel_message_header *hdr)
 	/*
 	 * This is a global event; just wakeup the waiting thread.
 	 * Once we successfully unload, we can cleanup the monitor state.
+	 *
+	 * NB.  A malicious or compromised Hyper-V could send a spurious
+	 * message of type CHANNELMSG_UNLOAD_RESPONSE, and trigger a call
+	 * of the complete() below.  Make sure that unload_event has been
+	 * initialized by the time this complete() is executed.
 	 */
 	complete(&vmbus_connection.unload_event);
 }
@@ -841,7 +846,7 @@ void vmbus_initiate_unload(bool crash)
 	if (vmbus_proto_version < VERSION_WIN8_1)
 		return;
 
-	init_completion(&vmbus_connection.unload_event);
+	reinit_completion(&vmbus_connection.unload_event);
 	memset(&hdr, 0, sizeof(struct vmbus_channel_message_header));
 	hdr.msgtype = CHANNELMSG_UNLOAD;
 	vmbus_post_msg(&hdr, sizeof(struct vmbus_channel_message_header),
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index dc19d5ae4373c..311cd005b3be6 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -26,6 +26,8 @@
 
 struct vmbus_connection vmbus_connection = {
 	.conn_state		= DISCONNECTED,
+	.unload_event		= COMPLETION_INITIALIZER(
+				  vmbus_connection.unload_event),
 	.next_gpadl_handle	= ATOMIC_INIT(0xE1E10),
 
 	.ready_for_suspend_event = COMPLETION_INITIALIZER(
-- 
2.25.1

