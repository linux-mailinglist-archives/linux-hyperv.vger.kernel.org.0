Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80A03622F8
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245144AbhDPOlS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 10:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244999AbhDPOkU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 10:40:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCB3C06138D;
        Fri, 16 Apr 2021 07:39:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w23so26681014ejb.9;
        Fri, 16 Apr 2021 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EsOOWDuOVz6bSUNWjCicdY117Ox1geSWS3kizzOfJ0=;
        b=mnGMNEcwWDMUkUrIpby6q8qTvjsPNMmA42Rvk16npC8CI8To22uM+k0NYs2G3A+tge
         oi4CgvQxhar6m2O2IKP8GF+ePSIQRFrzMxP/G27VTmYTB2aY4i8S/3dtrCP2kxLmMDFn
         uB0I/xSXovKBgxMr6aDrofaHBYoNdkeb2QWDTpobDI2YjAbjXFLRE7Tixe/JD5ZyYuUA
         YmP+pVr22Po16CgqrJnP96jP77OIkBR1c4SJ0jtzO+vM6qxJBdf5Iy5pRCEoSPfwlEg7
         4ry/2rcl3p581CEne2XsDmQTEJyXTJkflmuRcqsdL4gwi7/qHw8PPTjdAs6+qiqNuv7V
         rQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EsOOWDuOVz6bSUNWjCicdY117Ox1geSWS3kizzOfJ0=;
        b=RpRpTcU0s0Cln1NUAwsRu/84KPLH2J5t6yVY0DAP1bsEhUaacVzV8QAkX15AqO+4BJ
         UwL+q3YggjVvrjDQBi+r1XhF7OgOFTYxk6QZIQAS5hC5GqDxWNMUV3OAGf6VFoU9kTx7
         29bsZkLnuhvxkfJ+zqhdvz54raQzfXVbgjfFvLoCX9C57aEyRphQYmoZIWrFrLq9TQcj
         yL6Cpzo5HlsNxh7t0no7ZtKwjSFRpqbUZSGweo5LFulC5YwW6FRZornaiybSFedQ+XSN
         r8YY4r0G3k9SkpR+EvBU1Zy0zZlZ82lvI0kkaHWLv6Zra74j2VYdYdH18dGFPnB8gstV
         JnpA==
X-Gm-Message-State: AOAM532KAMOBs0jhY1VCPjI6GI05FktoNvB/Kvxxyc9/cVAWTVGO+DEm
        kkcidmlN8QdbaTDAXGUJOBIuLDvF/sIscg==
X-Google-Smtp-Source: ABdhPJxnegexV2PuXxQL1J6/R5ENECn6qZo70NrG8ti3vkW8ExsaB4gJAQcrPf7sJda1E93FBx0N9A==
X-Received: by 2002:a17:906:d8cb:: with SMTP id re11mr8417411ejb.204.1618583994383;
        Fri, 16 Apr 2021 07:39:54 -0700 (PDT)
Received: from anparri.mshome.net (mob-176-243-167-64.net.vodafone.it. [176.243.167.64])
        by smtp.gmail.com with ESMTPSA id hd8sm4337478ejc.92.2021.04.16.07.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:39:54 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH] Drivers: hv: vmbus: Initialize unload_event statically
Date:   Fri, 16 Apr 2021 16:39:32 +0200
Message-Id: <20210416143932.16512-1-parri.andrea@gmail.com>
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
 drivers/hv/channel_mgmt.c | 2 +-
 drivers/hv/connection.c   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index f3cf4af01e102..1efb616480a64 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -841,7 +841,7 @@ void vmbus_initiate_unload(bool crash)
 	if (vmbus_proto_version < VERSION_WIN8_1)
 		return;
 
-	init_completion(&vmbus_connection.unload_event);
+	reinit_completion(&vmbus_connection.unload_event);
 	memset(&hdr, 0, sizeof(struct vmbus_channel_message_header));
 	hdr.msgtype = CHANNELMSG_UNLOAD;
 	vmbus_post_msg(&hdr, sizeof(struct vmbus_channel_message_header),
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 350e8c5cafa8c..529dcc47f3e11 100644
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

