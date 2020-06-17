Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B061FD29B
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jun 2020 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgFQQsE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jun 2020 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgFQQsD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18AFC061755;
        Wed, 17 Jun 2020 09:48:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q2so640506wrv.8;
        Wed, 17 Jun 2020 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Go2fiYakbW2vKFMOGcvytm/DxMDEAhQetDDWkR8rDU=;
        b=dbwR1PLkSWkWkt85auklGLPY/7P6hUmrCUojRQE5zFLBJ6G62U/AOp84vfA4kF/H8C
         iFRXFavfXgjiWDo9F8UB4+w2Tw3fL7AWewIt2HokENO9+WIPDCASJ3J6dOqKf9mwt67/
         FkKyPLANxrW3QeH1mhsRV2Z79Vo8iqcQSowwF06dVxr1s+4hrYzoo2/N8RBFloMJZGhu
         rFPKdZJ6Q1n7s/kIL/tTH7y2vrRmeFX19Dg93M0EcM6ZyRPzuyB/bdbjfCr6SvfUIw5l
         TpoiF5kLdd/FfXAu1Sj7g0nwIMDhrkR0DwLzMpMEPrFU7yE4l0+JTJigV0/OKM3S5CD3
         mFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Go2fiYakbW2vKFMOGcvytm/DxMDEAhQetDDWkR8rDU=;
        b=erziG1rkSmH8rSYSGPmsTZd9I9oMZwrizd+BEtAofFcABRHF/UaKgLntknJlu+NjKH
         FSWDKgzndi4cXQle0amKIEEtDx4yWHV/wKfhhhzE7sJf+MSYA8R9lS/M90EBA2d+zKwB
         vlcKEgHuhaf2dJZBCL4JZW+Glk5JyBCzm3eaNkYpjXWjoLo81l/EG6Ny6kT7emZFgyVX
         5Xr40Qby2YDGopEXJJus/0CYGturEYKCN3OTqx423llMrO+Vooq6nbEd8SFWVvNPv4hs
         m1raseN96zhUKHyxwUZpqQz/xBMkHXRGvrwan6K+m3kxVTeEoQgGAoABysLHF71D/QaC
         KGRg==
X-Gm-Message-State: AOAM531AmiET+WTgvoudRZjXQW2+g016h7AetVoVxGbaNNY12UNrFJps
        JgLO63woQgo4meiFgYqXf6A=
X-Google-Smtp-Source: ABdhPJyJa6QPIhEHFNIx6R6oJR+SKgnDVilangJ0krd0/xDtjeqKzrUJngtK2cIRTq4DnPwG6Xzd1g==
X-Received: by 2002:adf:c707:: with SMTP id k7mr146549wrg.382.1592412481502;
        Wed, 17 Jun 2020 09:48:01 -0700 (PDT)
Received: from localhost.localdomain (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id g3sm199165wrb.46.2020.06.17.09.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:01 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 6/8] Drivers: hv: vmbus: Remove unnecessary channel->lock critical sections (sc_list updaters)
Date:   Wed, 17 Jun 2020 18:46:40 +0200
Message-Id: <20200617164642.37393-7-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617164642.37393-1-parri.andrea@gmail.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

None of the readers/updaters of sc_list rely on channel->lock for
synchronization.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 36dd8b6c544a4..92f8bb2077a94 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -400,8 +400,6 @@ static void vmbus_release_relid(u32 relid)
 
 void hv_process_channel_removal(struct vmbus_channel *channel)
 {
-	unsigned long flags;
-
 	lockdep_assert_held(&vmbus_connection.channel_mutex);
 	BUG_ON(!channel->rescind);
 
@@ -422,14 +420,10 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
 	if (channel->offermsg.child_relid != INVALID_RELID)
 		vmbus_channel_unmap_relid(channel);
 
-	if (channel->primary_channel == NULL) {
+	if (channel->primary_channel == NULL)
 		list_del(&channel->listentry);
-	} else {
-		struct vmbus_channel *primary_channel = channel->primary_channel;
-		spin_lock_irqsave(&primary_channel->lock, flags);
+	else
 		list_del(&channel->sc_list);
-		spin_unlock_irqrestore(&primary_channel->lock, flags);
-	}
 
 	/*
 	 * If this is a "perf" channel, updates the hv_numa_map[] masks so that
@@ -470,7 +464,6 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	struct vmbus_channel *newchannel =
 		container_of(work, struct vmbus_channel, add_channel_work);
 	struct vmbus_channel *primary_channel = newchannel->primary_channel;
-	unsigned long flags;
 	int ret;
 
 	/*
@@ -531,13 +524,10 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	 */
 	newchannel->probe_done = true;
 
-	if (primary_channel == NULL) {
+	if (primary_channel == NULL)
 		list_del(&newchannel->listentry);
-	} else {
-		spin_lock_irqsave(&primary_channel->lock, flags);
+	else
 		list_del(&newchannel->sc_list);
-		spin_unlock_irqrestore(&primary_channel->lock, flags);
-	}
 
 	/* vmbus_process_offer() has mapped the channel. */
 	vmbus_channel_unmap_relid(newchannel);
@@ -557,7 +547,6 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 {
 	struct vmbus_channel *channel;
 	struct workqueue_struct *wq;
-	unsigned long flags;
 	bool fnew = true;
 
 	/*
@@ -609,10 +598,10 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 		}
 	}
 
-	if (fnew)
+	if (fnew) {
 		list_add_tail(&newchannel->listentry,
 			      &vmbus_connection.chn_list);
-	else {
+	} else {
 		/*
 		 * Check to see if this is a valid sub-channel.
 		 */
@@ -630,9 +619,7 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 		 * Process the sub-channel.
 		 */
 		newchannel->primary_channel = channel;
-		spin_lock_irqsave(&channel->lock, flags);
 		list_add_tail(&newchannel->sc_list, &channel->sc_list);
-		spin_unlock_irqrestore(&channel->lock, flags);
 	}
 
 	vmbus_channel_map_relid(newchannel);
-- 
2.25.1

