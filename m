Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F148592A
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jan 2022 20:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbiAET2P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jan 2022 14:28:15 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59052 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243475AbiAET2P (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jan 2022 14:28:15 -0500
Received: from surface.. (unknown [174.127.243.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2DC7820B7179;
        Wed,  5 Jan 2022 11:28:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DC7820B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641410895;
        bh=ZCu7dlFJInq/hCFCs9wArfWGKwpFZDQPOHre34xvGcs=;
        h=From:To:Cc:Subject:Date:From;
        b=OBpNL3wq7Z3ApsVb+PbwdR03kDyJtQbgRw9l6UJKA769s9/ZJhBVOQX1mddfJc7g+
         n3qV6QJngA5xT/OLEw+1LVFEU/ImWXSpXC3yWf9tdOKeroBFchbhVnL534hYPBklEl
         RILk+2YwCotDodZhdqtzCVr8b79e5nNSXrn7f7co=
From:   Juan Vazquez <juvazq@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, mikelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Initialize request offers message for Isolation VM
Date:   Wed,  5 Jan 2022 11:27:46 -0800
Message-Id: <20220105192746.23046-1-juvazq@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Initialize memory of request offers message to be sent to the host so
padding or uninitialized fields do not leak guest memory contents.

Signed-off-by: Juan Vazquez <juvazq@linux.microsoft.com>
---
 drivers/hv/channel_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 2829575fd9b7..60375879612f 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1554,7 +1554,7 @@ int vmbus_request_offers(void)
 	struct vmbus_channel_msginfo *msginfo;
 	int ret;
 
-	msginfo = kmalloc(sizeof(*msginfo) +
+	msginfo = kzalloc(sizeof(*msginfo) +
 			  sizeof(struct vmbus_channel_message_header),
 			  GFP_KERNEL);
 	if (!msginfo)
-- 
2.32.0

