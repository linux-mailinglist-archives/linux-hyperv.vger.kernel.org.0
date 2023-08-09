Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA92776C40
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Aug 2023 00:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjHIWgp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Aug 2023 18:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjHIWgo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Aug 2023 18:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA5FE2;
        Wed,  9 Aug 2023 15:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA5ED64B96;
        Wed,  9 Aug 2023 22:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F09DC433CA;
        Wed,  9 Aug 2023 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691620602;
        bh=Zka/QnD0rGOvRXnWW9pnyWBIh7P18Wfh52IEhJoGe60=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=g/jpOCAel3rQuTwgmg7KHttFB+s+NjDh5mvMfhp6yuayWCfWDVKPf0sauZFn9i3y/
         jsQApNfzRGEl6x6aU26nemeyFXMB2dEc8fX2q7uf7ZAuh7HnZo1SOuDCO3GvhBtNpn
         p697u3lk2VpuyAhYPtJPvBJerC1mtIV7xBucAzsfgdsohjM2SN1VYFgiCnFljfTbAI
         O7eit5T5zfgqYRWp7wA0zWJ3R1mDj1aBr+jUyKdxCwL3hkqjE4t+Wtwp4yuSpL5+Lu
         aWZGXctqQ0ZB9PFfw9HJ9b+T0FKHI3+Lw14Md+vjUOv1349LPjG0kCzwgRsly7UYqV
         a1Pbwm23NzGzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id F287CC001DE;
        Wed,  9 Aug 2023 22:36:41 +0000 (UTC)
From:   Mitchell Levy via B4 Relay 
        <devnull+levymitchell0.gmail.com@kernel.org>
Date:   Wed, 09 Aug 2023 22:36:32 +0000
Subject: [PATCH RFC 1/2] Use raw_spinlock_t for vmbus_channel.sched_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-b4-rt_preempt-fix-v1-1-7283bbdc8b14@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691620601; l=3796;
 i=levymitchell0@gmail.com; s=20230725; h=from:subject:message-id;
 bh=MXKwcPdPNpNQjvDklfvWhlfwTjUab5KPdkrPZk47txU=;
 b=wdfrWNbRXsMM9EumP3dRgNzJuINYMo3MbziR2UksM2kiJhn7sAVrf7im68Gb50u/0BTwnCRqZ
 gDxSAje7IG6Ap0WGs10iMj5JRme6QsYXqXdtrrG7ygzMZbhSIAciK5T
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=o3BLKQtTK7QMnUiW3/7p5JcITesvc3qL/w+Tz19oYeE=
X-Endpoint-Received: by B4 Relay for levymitchell0@gmail.com/20230725 with auth_id=69
X-Original-From: Mitchell Levy <levymitchell0@gmail.com>
Reply-To: <levymitchell0@gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Mitchell Levy <levymitchell0@gmail.com>

In vmbus_drv.c, vmbus_channel.sched_lock is acquired while holding an
rcu_read_lock. Since this is not a sleepable context, change sched_lock
to be a raw_spinlock_t to avoid sleeping when PREEMPT_RT is enabled.
---
 drivers/hv/channel.c                | 4 ++--
 drivers/hv/channel_mgmt.c           | 2 +-
 drivers/hv/vmbus_drv.c              | 4 ++--
 drivers/pci/controller/pci-hyperv.c | 6 +++---
 include/linux/hyperv.h              | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 56f7e06c673e..00d73ec060ed 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -910,9 +910,9 @@ void vmbus_reset_channel_cb(struct vmbus_channel *channel)
 	tasklet_disable(&channel->callback_event);
 
 	/* See the inline comments in vmbus_chan_sched(). */
-	spin_lock_irqsave(&channel->sched_lock, flags);
+	raw_spin_lock_irqsave(&channel->sched_lock, flags);
 	channel->onchannel_callback = NULL;
-	spin_unlock_irqrestore(&channel->sched_lock, flags);
+	raw_spin_unlock_irqrestore(&channel->sched_lock, flags);
 
 	channel->sc_creation_callback = NULL;
 
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 2f4d09ce027a..7679e6a3a645 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -348,7 +348,7 @@ static struct vmbus_channel *alloc_channel(void)
 	if (!channel)
 		return NULL;
 
-	spin_lock_init(&channel->sched_lock);
+	raw_spin_lock_init(&channel->sched_lock);
 	init_completion(&channel->rescind_event);
 
 	INIT_LIST_HEAD(&channel->sc_list);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 67f95a29aeca..b865d00c46dc 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1257,7 +1257,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 		 * sched_lock critical section.  See also the inline comments
 		 * in vmbus_reset_channel_cb().
 		 */
-		spin_lock(&channel->sched_lock);
+		raw_spin_lock(&channel->sched_lock);
 
 		callback_fn = channel->onchannel_callback;
 		if (unlikely(callback_fn == NULL))
@@ -1280,7 +1280,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 		}
 
 sched_unlock:
-		spin_unlock(&channel->sched_lock);
+		raw_spin_unlock(&channel->sched_lock);
 sched_unlock_rcu:
 		rcu_read_unlock();
 	}
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 2d93d0c4f10d..9ede3be05782 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1995,13 +1995,13 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		 * sched_lock critical section.  See also the inline comments
 		 * in vmbus_reset_channel_cb().
 		 */
-		spin_lock_irqsave(&channel->sched_lock, flags);
+		raw_spin_lock_irqsave(&channel->sched_lock, flags);
 		if (unlikely(channel->onchannel_callback == NULL)) {
-			spin_unlock_irqrestore(&channel->sched_lock, flags);
+			raw_spin_unlock_irqrestore(&channel->sched_lock, flags);
 			goto enable_tasklet;
 		}
 		hv_pci_onchannelcallback(hbus);
-		spin_unlock_irqrestore(&channel->sched_lock, flags);
+		raw_spin_unlock_irqrestore(&channel->sched_lock, flags);
 
 		udelay(100);
 	}
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 3ac3974b3c78..56a1fb1647a4 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -873,7 +873,7 @@ struct vmbus_channel {
 	 * Synchronize channel scheduling and channel removal; see the inline
 	 * comments in vmbus_chan_sched() and vmbus_reset_channel_cb().
 	 */
-	spinlock_t sched_lock;
+	raw_spinlock_t sched_lock;
 
 	/*
 	 * A channel can be marked for one of three modes of reading:

-- 
2.25.1

