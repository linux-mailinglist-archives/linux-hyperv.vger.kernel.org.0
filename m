Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC1506C53
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 14:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352281AbiDSM0r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 08:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbiDSM0h (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 08:26:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9B636333;
        Tue, 19 Apr 2022 05:23:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id t11so32485395eju.13;
        Tue, 19 Apr 2022 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njoqsjCkwXkJtdNecMo/g2MUiVV2iM+3H9WZkjrom64=;
        b=T+BJ0CoPzwTVz0sJC7p3ea6aiM3LNaQJG681SWvIk7KbBiMEOpk6LTy6OgUfJiIsGk
         SJ2LrcJ2aGDX9wiDURXhAUlW3SV/A9LjBuTwPn9kKaXMdsy/aEH30FAFi2P7ORSnhbNr
         4V8cjeUGHCNbJiQhgOPzqhWnMkNt2g5e+TSiISQnHdR3AkOO6VYw5QJAblWQpatU4vyy
         p5D3ZNImcjcwqs7ScP+X+goiFXDtQkKAyOUya1gKhKgSS6RAQ5kqHr75lGr4o/WBjqk5
         xK72APTXGbPMEyGZgGJRboF9WGw98XtINBp4FiWierkyld0pEk4Yh3QMKJaCEyie/Z4z
         s6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njoqsjCkwXkJtdNecMo/g2MUiVV2iM+3H9WZkjrom64=;
        b=OqMa3M+8xkY0kzegiGGunJ69KcgzATWshRq7QhqoblpC+9VCbCckPvS45ANzxe8ME5
         gJctd9Z/MwXMDCoSzmE5vOkBsuECEw9URPUjI9TI8HP73SBF6R6KAMDl6n8lyo/KDs+p
         CB+yHNj6qROo7eTv9S/sbjv3r8V/zg9HOfay2S4A6VPgx1psxZXeFZaSIBOR4biLVhUp
         444Po0DnLkJhprB7C/PgtLr8QnsowYPKFOjTBkrG7MaYReizeaoVXxORjhFxKp7foaMT
         s8JThZevJWGj22E8JVsuqKxScDSvUPikQ21anNludLwkR9Zu7NRebkxVGAchVuR17Fmm
         12lA==
X-Gm-Message-State: AOAM5317E9OaCxqNvLr/CkHjvWUgiU6JaoSENoWb6i4dzXEyXTgUIvXl
        Ufm7VU/oZp4Yp1bnEel8nxU=
X-Google-Smtp-Source: ABdhPJxEcmNyjH29mq3GbIquHL3s/bZTQcAzcZjXsFf+i9EmpdzE/eWAI3rFHj0Rhx3nZaW7SeP8qQ==
X-Received: by 2002:a17:907:3f0f:b0:6ef:e43f:f3e7 with SMTP id hq15-20020a1709073f0f00b006efe43ff3e7mr2054068ejc.758.1650371034030;
        Tue, 19 Apr 2022 05:23:54 -0700 (PDT)
Received: from anparri.mshome.net (host-82-53-3-95.retail.telecomitalia.it. [82.53.3.95])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm5644685ejm.189.2022.04.19.05.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:23:53 -0700 (PDT)
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
Subject: [PATCH v2 1/6] Drivers: hv: vmbus: Fix handling of messages with transaction ID of zero
Date:   Tue, 19 Apr 2022 14:23:20 +0200
Message-Id: <20220419122325.10078-2-parri.andrea@gmail.com>
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
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

