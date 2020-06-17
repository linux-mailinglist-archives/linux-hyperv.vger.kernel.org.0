Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2979C1FD2C1
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2020 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgFQQtX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jun 2020 12:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgFQQsJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B91C0613ED;
        Wed, 17 Jun 2020 09:48:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so3088678wrt.5;
        Wed, 17 Jun 2020 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jO6YYKLcVc4zVnNFJ3vwcO4SaIx1I79j4ycIlYEFriM=;
        b=dGPuDDIvXNEAfIMnvc6hzhIro0ysybgDo0L+ZYIyozSv6xaJx9m7uAQkGe1x+2DC0+
         eiAABPwv27e67/k3fYv9ibRHiBjborGi+5GkyFUFaXD9CAKOmgGXw5nNMjtoRd2Scqkr
         LBGoYPjTRBntsJCj9OmNIRRAeAwfpAMT8nxp+G4O3zp4hNCEexTbdsbhSIq1ymKpDYBN
         VPv7d84x2hO/SBcBMgj+kiI1Ik7HSo0Km4HOuNiUHd9V24IAUT3Vp1qgTRAXdQZrEO6k
         Uq6ceySpT6bIhxV36j3uk9imhs0UJDBjrWkqXGFeV5m2zK5A3Ygu0o/sxMTpGAVq9TI0
         2YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jO6YYKLcVc4zVnNFJ3vwcO4SaIx1I79j4ycIlYEFriM=;
        b=ISP7Vm+l0GNDPazJaoc6OpR1KZk8cz8YgqaN3loS6SNwPLkDACjlCPql1b7B93xaYG
         86aOhxxAE5GALQqhJNkUenDMTC5Zx0Gd+F5tqn5J1SGEVd20aoXXSxzkiV1Rp5tJat+g
         lvRSVMVeUl0eSTLRyxbxeTBiZkHSP4P8Ui0mh8aWWpazRRr1BXf3UVD3WpRs6T5YVjXq
         /8JF1oGLlNi4zjOGAncdurMai7q/7xjmPcRQvhTII/Or1ZXj2r+CboArZWw9TXCsBq5m
         oeXuRF3csKDLdc9nHK+q1fI5/yJasTeC8yrgxO86NVRGaB53TVXqAWrZcmNJzvpbPBix
         vQOg==
X-Gm-Message-State: AOAM530JSMrrOP0mvfz18dsZwin1fiCWdJW89Z3fskhHX88grKrFQpj/
        OAQnEOAQ+5kNGj4sdvFIMfxe41l7Z2BZhw==
X-Google-Smtp-Source: ABdhPJx9FS5yJVTtenmTcnSfeuEKkEeHMt/a8Qf3ZsJoYR/a/YC2asbMiQpE/WXs3evNgivi1BbVoA==
X-Received: by 2002:a5d:468d:: with SMTP id u13mr150370wrq.73.1592412487715;
        Wed, 17 Jun 2020 09:48:07 -0700 (PDT)
Received: from localhost.localdomain (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id g3sm199165wrb.46.2020.06.17.09.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:07 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 8/8] Drivers: hv: vmbus: Remove the lock field from the vmbus_channel struct
Date:   Wed, 17 Jun 2020 18:46:42 +0200
Message-Id: <20200617164642.37393-9-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617164642.37393-1-parri.andrea@gmail.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The spinlock is (now) *not used to protect test-and-set accesses
to attributes of the structure or sc_list operations.

There is, AFAICT, a distinct lack of {WRITE,READ}_ONCE()s in the
handling of channel->state, but the changes below do not seem to
make things "worse".  ;-)

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c      | 6 +-----
 drivers/hv/channel_mgmt.c | 1 -
 include/linux/hyperv.h    | 6 ------
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 8848d1548b3f2..3ebda7707e46a 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -129,12 +129,8 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	send_pages = newchannel->ringbuffer_send_offset;
 	recv_pages = newchannel->ringbuffer_pagecount - send_pages;
 
-	spin_lock_irqsave(&newchannel->lock, flags);
-	if (newchannel->state != CHANNEL_OPEN_STATE) {
-		spin_unlock_irqrestore(&newchannel->lock, flags);
+	if (newchannel->state != CHANNEL_OPEN_STATE)
 		return -EINVAL;
-	}
-	spin_unlock_irqrestore(&newchannel->lock, flags);
 
 	newchannel->state = CHANNEL_OPENING_STATE;
 	newchannel->onchannel_callback = onchannelcallback;
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 92f8bb2077a94..591106cf58fc0 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -317,7 +317,6 @@ static struct vmbus_channel *alloc_channel(void)
 		return NULL;
 
 	spin_lock_init(&channel->sched_lock);
-	spin_lock_init(&channel->lock);
 	init_completion(&channel->rescind_event);
 
 	INIT_LIST_HEAD(&channel->sc_list);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 690394b79d727..38100e80360ac 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -840,12 +840,6 @@ struct vmbus_channel {
 	 */
 	void (*chn_rescind_callback)(struct vmbus_channel *channel);
 
-	/*
-	 * The spinlock to protect the structure. It is being used to protect
-	 * test-and-set access to various attributes of the structure as well
-	 * as all sc_list operations.
-	 */
-	spinlock_t lock;
 	/*
 	 * All Sub-channels of a primary channel are linked here.
 	 */
-- 
2.25.1

