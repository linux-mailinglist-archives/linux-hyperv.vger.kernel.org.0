Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC42D3BFC
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 08:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgLIHKJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 02:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLIHKC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 02:10:02 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9F3C061793;
        Tue,  8 Dec 2020 23:09:21 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id y17so509644wrr.10;
        Tue, 08 Dec 2020 23:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=blsnxXOVnHLdAsm66A1tMDliKFSsnzIumiEyErS1pXY=;
        b=YhJOtLk9RsFCqUwduLAw73DRJACD/Oi5Z/UiaL8Akco6BiDngi+b3et3hmzh09QM0M
         GqnX6DkigeudBCtCNi/nZgE5DRvUophofGrBPPTqQAqxHoQv9EnNigoQDyOZUq1kGYOO
         eO3SORJUQRIcd40SBMwKT3wuH9NQYAfMtPoXihAy1QpjN4avYo3+Pf20UpejuTLj/7si
         hBv22JjigMWPUWjXioVdmJ8olStcitepaiOMqiFOYKUOFQPM7M/gdd8N4Ivt7aE9L5i9
         DbDp1Oi3eHqnQ8yLHx0Tz/RmS4i97/7IYXaOHaRXGR44QUT6wGvKfWcIRjVrtn9Jf0AO
         /nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=blsnxXOVnHLdAsm66A1tMDliKFSsnzIumiEyErS1pXY=;
        b=Irkssf70+gayB5Kba4Ul+zEFhR40jrdgRN8swiS6b6yn5F5eSGQkW2h90rAoULZJN2
         Jkxc/drAXkLGtXLCTjTQ5/voBVXImHISc/s2vvPpbwSLnf5cbNJGn0D+HDfKMsmMHc+w
         pOALv3gJ6q+lvR1fQWrnNX58LPffo/2Kn5QW/Ruxe15qNAQvStPFijWnTRYzIsy00ukH
         CmugpL9Q9fUkEcw9EH0O+f58qX3rEXB32IzmExaJBEufPnq1c0VvOA95pHu9KrdWd3Mi
         abcBaEAl41Qm+1ExIj/CeysFi97pBXVctuJOYiRSPfG83X8PvDB6RJn8HZyWNwUT9Of8
         tsKA==
X-Gm-Message-State: AOAM531PCBgh3UvrxUH3Rr9fVw4fgxLha+PU6YvnK4BFMQfjLdoz6Yam
        9q2i0Cn/DucirfQoRPcLIlMYxhGeMnnXRQ==
X-Google-Smtp-Source: ABdhPJyabJ/ej9FbHAdg83yft6Rce7sPAKAmLcxZDlw7EKnzlmdYDeYXF7jdUBH3STga5YAdqy4tdw==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr958580wrv.397.1607497759796;
        Tue, 08 Dec 2020 23:09:19 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id p3sm1449122wrs.50.2020.12.08.23.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 23:09:19 -0800 (PST)
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
Subject: [PATCH v3 2/6] Drivers: hv: vmbus: Reduce number of references to message in vmbus_on_msg_dpc()
Date:   Wed,  9 Dec 2020 08:08:23 +0100
Message-Id: <20201209070827.29335-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209070827.29335-1-parri.andrea@gmail.com>
References: <20201209070827.29335-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Simplify the function by removing various references to the hv_message
'msg', introduce local variables 'msgtype' and 'payload_size'.

Suggested-by: Juan Vazquez <juvazq@microsoft.com>
Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
Changes since v2:
  - Squash patches #2 and #3
  - Revisit commit message

 drivers/hv/vmbus_drv.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 502f8cd95f6d4..44bcf9ccdaf5f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1057,9 +1057,11 @@ void vmbus_on_msg_dpc(unsigned long data)
 	struct hv_message *msg = (struct hv_message *)page_addr +
 				  VMBUS_MESSAGE_SINT;
 	struct vmbus_channel_message_header *hdr;
+	enum vmbus_channel_message_type msgtype;
 	const struct vmbus_channel_message_table_entry *entry;
 	struct onmessage_work_context *ctx;
 	u32 message_type = msg->header.message_type;
+	__u8 payload_size;
 
 	/*
 	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
@@ -1073,40 +1075,38 @@ void vmbus_on_msg_dpc(unsigned long data)
 		return;
 
 	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
+	msgtype = hdr->msgtype;
 
 	trace_vmbus_on_msg_dpc(hdr);
 
-	if (hdr->msgtype >= CHANNELMSG_COUNT) {
-		WARN_ONCE(1, "unknown msgtype=%d\n", hdr->msgtype);
+	if (msgtype >= CHANNELMSG_COUNT) {
+		WARN_ONCE(1, "unknown msgtype=%d\n", msgtype);
 		goto msg_handled;
 	}
 
-	if (msg->header.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
-		WARN_ONCE(1, "payload size is too large (%d)\n",
-			  msg->header.payload_size);
+	payload_size = msg->header.payload_size;
+	if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
+		WARN_ONCE(1, "payload size is too large (%d)\n", payload_size);
 		goto msg_handled;
 	}
 
-	entry = &channel_message_table[hdr->msgtype];
+	entry = &channel_message_table[msgtype];
 
 	if (!entry->message_handler)
 		goto msg_handled;
 
-	if (msg->header.payload_size < entry->min_payload_len) {
-		WARN_ONCE(1, "message too short: msgtype=%d len=%d\n",
-			  hdr->msgtype, msg->header.payload_size);
+	if (payload_size < entry->min_payload_len) {
+		WARN_ONCE(1, "message too short: msgtype=%d len=%d\n", msgtype, payload_size);
 		goto msg_handled;
 	}
 
 	if (entry->handler_type	== VMHT_BLOCKING) {
-		ctx = kmalloc(sizeof(*ctx) + msg->header.payload_size,
-			      GFP_ATOMIC);
+		ctx = kmalloc(sizeof(*ctx) + payload_size, GFP_ATOMIC);
 		if (ctx == NULL)
 			return;
 
 		INIT_WORK(&ctx->work, vmbus_onmessage_work);
-		memcpy(&ctx->msg, msg, sizeof(msg->header) +
-		       msg->header.payload_size);
+		memcpy(&ctx->msg, msg, sizeof(msg->header) + payload_size);
 
 		/*
 		 * The host can generate a rescind message while we
@@ -1115,7 +1115,7 @@ void vmbus_on_msg_dpc(unsigned long data)
 		 * by offer_in_progress and by channel_mutex.  See also the
 		 * inline comments in vmbus_onoffer_rescind().
 		 */
-		switch (hdr->msgtype) {
+		switch (msgtype) {
 		case CHANNELMSG_RESCIND_CHANNELOFFER:
 			/*
 			 * If we are handling the rescind message;
-- 
2.25.1

