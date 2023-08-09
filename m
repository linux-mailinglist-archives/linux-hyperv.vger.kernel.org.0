Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08167776C3D
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Aug 2023 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjHIWgo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Aug 2023 18:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHIWgo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Aug 2023 18:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BFFA;
        Wed,  9 Aug 2023 15:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D30C364B6C;
        Wed,  9 Aug 2023 22:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3875CC433D9;
        Wed,  9 Aug 2023 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691620602;
        bh=ysIEP6zY8WtRMOQCWbjyNvF+lCV4WvfxmcWrrcabJF4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=ETJPr+VuvWHyeqatMDuHBVA8v3zqHwaoVxFDUj65t4wVI/iLc1b+xCZHhMG/wT6D3
         w/cloq0jFdNCXOj7MW9nfZhuKnlgS1h3t6wIzyXz0Rpmuke3RPH2UAsFWoMVToFA2z
         HkqtYEFxhPKU7meW/ushrqRp1dbbhyzcSqrtsjyKNReSuHmGJ0eFfEC9YqoO9u3ToJ
         7xLBlMU7L92bRMI4Jo2nV0X6oB9fXIOaOcHxCpG5OPB6/Vjub6lf3uDLQhLh502P+B
         aFb/MnnwTK+mwsJPHdcoo20ejV+EBN9F/iRDQom9OYHj3N3b8ExzLGPEgvPuBCgsY4
         O2XjnSrMHFBNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 14B82C04A6A;
        Wed,  9 Aug 2023 22:36:42 +0000 (UTC)
From:   Mitchell Levy via B4 Relay 
        <devnull+levymitchell0.gmail.com@kernel.org>
Date:   Wed, 09 Aug 2023 22:36:33 +0000
Subject: [PATCH RFC 2/2] Use raw_spinlock_t in vmbus_requestor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-b4-rt_preempt-fix-v1-2-7283bbdc8b14@gmail.com>
References: <20230809-b4-rt_preempt-fix-v1-0-7283bbdc8b14@gmail.com>
In-Reply-To: <20230809-b4-rt_preempt-fix-v1-0-7283bbdc8b14@gmail.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691620601; l=1927;
 i=levymitchell0@gmail.com; s=20230725; h=from:subject:message-id;
 bh=EMJGmT0DQG0esS7skhyoOPlaFdOdEE5n0AicQTDKFKM=;
 b=nzyA2dEaoaRd4dZs3CNTlzbUnk4r4uOA/q8ghaPpY2ha0OZ1ImmjjWga6I4G6m2Hl99JhZWmY
 cM1WxeA70J1BmGVE6hve2u+KEmeyyz+vYgRNGnObBN7PP3wTJz4DXbT
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=o3BLKQtTK7QMnUiW3/7p5JcITesvc3qL/w+Tz19oYeE=
X-Endpoint-Received: by B4 Relay for levymitchell0@gmail.com/20230725 with auth_id=69
X-Original-From: Mitchell Levy <levymitchell0@gmail.com>
Reply-To: <levymitchell0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Mitchell Levy <levymitchell0@gmail.com>

Because hv_pci_onchannelcallback is called with irq disabled in
hv_compose_msi_msg, any locks held in that function must not be
sleepable. Therefore, change vmbus_requestor to use raw_spinlock_t.
---
 drivers/hv/channel.c   | 2 +-
 include/linux/hyperv.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 00d73ec060ed..08e6bd4a056d 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -635,7 +635,7 @@ static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
 	rqstor->req_bitmap = bitmap;
 	rqstor->size = size;
 	rqstor->next_request_id = 0;
-	spin_lock_init(&rqstor->req_lock);
+	raw_spin_lock_init(&rqstor->req_lock);
 
 	return 0;
 }
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 56a1fb1647a4..664c03a78e11 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -787,7 +787,7 @@ struct vmbus_requestor {
 	unsigned long *req_bitmap; /* is a given slot available? */
 	u32 size;
 	u64 next_request_id;
-	spinlock_t req_lock; /* provides atomicity */
+	raw_spinlock_t req_lock; /* provides atomicity */
 };
 
 #define VMBUS_NO_RQSTOR U64_MAX
@@ -1050,7 +1050,7 @@ struct vmbus_channel {
 do {									\
 	struct vmbus_requestor *rqstor = &(channel)->requestor;		\
 									\
-	spin_lock_irqsave(&rqstor->req_lock, flags);			\
+	raw_spin_lock_irqsave(&rqstor->req_lock, flags);		\
 } while (0)
 
 static __always_inline void unlock_requestor(struct vmbus_channel *channel,
@@ -1058,7 +1058,7 @@ static __always_inline void unlock_requestor(struct vmbus_channel *channel,
 {
 	struct vmbus_requestor *rqstor = &channel->requestor;
 
-	spin_unlock_irqrestore(&rqstor->req_lock, flags);
+	raw_spin_unlock_irqrestore(&rqstor->req_lock, flags);
 }
 
 u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr);

-- 
2.25.1

