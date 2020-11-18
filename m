Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8D2B7F8E
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Nov 2020 15:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgKROhw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Nov 2020 09:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKROhv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Nov 2020 09:37:51 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCFBC0613D4;
        Wed, 18 Nov 2020 06:37:51 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so2944980wme.1;
        Wed, 18 Nov 2020 06:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5UGrrxWNeFPLv13XKwUU3ssBp0qXc5p+wXdf+FhSA4=;
        b=KloB2f0Hc7EYlnItLF/KBGb6Bnx1JT20NNgU2zvZFa0vFX3+XbR84kEwilzIpyLQs+
         jM/QJSluPIA1Z1Bd4jNZlk5aLoWlHwwsj+U4YzYi3OdInRSsX0VYCL5gXO44LJ8MyetL
         P+ismXUnTPl3iNktzwHUUivQcRrIyRG7rWyVWsF9X0LsaJGx+HdPL/VNk+ZkeW8Q8u+k
         /lN18AOE5+13k0dSZNBS1LWQJA25McTvd6jdmXbUJJGlzcWgef5nndjxW7a6LjGjmI8x
         vaxIAKtr9iAwIwbL5IBo1qoQzvokEBB4EyACjTyOFyXntR93TNpFnXKE0wiT2fCTxl9a
         ohOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5UGrrxWNeFPLv13XKwUU3ssBp0qXc5p+wXdf+FhSA4=;
        b=BDfMf9uzLWJEkatDls79ag4unxA51+++kgah0GguKfEQrmwr4QEEm6VZ7s4OwHj6sz
         vyy+NSooi5uFwEzgDpEmg4j7vg1Cj7DADzZ6gpLizSKjjqmBtgH2pv0vka9R3Yx5f3vU
         YqzcPE/KalhnenO/4xMoix6ikHrG1/XO8pND1p6thF789BgTxpeaw+chG5Z+MnVHfGz2
         XFMDFkLVykc3eluytZFds3h51M6AYZcgSikrQ2VlDkTE5xqs6vRH9brsQXbxCdSZwdvm
         rtVgsL1h8ELgZP9OPz8lR7hEL4zEK0vRWfmU+ZxASlxhf1pv4UFaeRqUKQxvkxtcE3lZ
         uToQ==
X-Gm-Message-State: AOAM532lm00f+jzk8jocwPFnDjoCXsOi4RIFHnNuGkMTRYxmACac7WN8
        0WJZLaRXVi69Z9wNbyP7/q3qZxcODrbErA==
X-Google-Smtp-Source: ABdhPJz4sn1QbcdE7LX7NMs1SYHlcDB+pjdkChCo5pVd2wp8kycrAlmC4NlCVMM43gw768pbVixEcQ==
X-Received: by 2002:a1c:61c2:: with SMTP id v185mr348631wmb.152.1605710269826;
        Wed, 18 Nov 2020 06:37:49 -0800 (PST)
Received: from localhost.localdomain (host-82-51-6-75.retail.telecomitalia.it. [82.51.6.75])
        by smtp.gmail.com with ESMTPSA id w10sm34795307wra.34.2020.11.18.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:37:49 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 6/6] Drivers: hv: vmbus: Do not allow overwriting vmbus_connection.channels[]
Date:   Wed, 18 Nov 2020 15:36:49 +0100
Message-Id: <20201118143649.108465-7-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118143649.108465-1-parri.andrea@gmail.com>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, vmbus_onoffer() and vmbus_process_offer() are not validating
whether a given entry in the vmbus_connection.channels[] array is empty
before filling the entry with a call of vmbus_channel_map_relid().  An
erroneous or malicious host could rely on this to leak channel objects.
Do not allow overwriting an entry vmbus_connection.channels[].

Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 30 ++++++++++++++++++------------
 drivers/hv/hyperv_vmbus.h |  2 +-
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 68950a1e4b638..841c0d4e101bd 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -354,10 +354,12 @@ static void free_channel(struct vmbus_channel *channel)
 	kobject_put(&channel->kobj);
 }
 
-void vmbus_channel_map_relid(struct vmbus_channel *channel)
+int vmbus_channel_map_relid(struct vmbus_channel *channel)
 {
-	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
-		return;
+	u32 relid = channel->offermsg.child_relid;
+
+	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS || vmbus_connection.channels[relid] != NULL))
+		return -EINVAL;
 	/*
 	 * The mapping of the channel's relid is visible from the CPUs that
 	 * execute vmbus_chan_sched() by the time that vmbus_chan_sched() will
@@ -383,18 +385,17 @@ void vmbus_channel_map_relid(struct vmbus_channel *channel)
 	 *      of the VMBus driver and vmbus_chan_sched() can not run before
 	 *      vmbus_bus_resume() has completed execution (cf. resume_noirq).
 	 */
-	smp_store_mb(
-		vmbus_connection.channels[channel->offermsg.child_relid],
-		channel);
+	smp_store_mb(vmbus_connection.channels[relid], channel);
+	return 0;
 }
 
 void vmbus_channel_unmap_relid(struct vmbus_channel *channel)
 {
-	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
+	u32 relid = channel->offermsg.child_relid;
+
+	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS))
 		return;
-	WRITE_ONCE(
-		vmbus_connection.channels[channel->offermsg.child_relid],
-		NULL);
+	WRITE_ONCE(vmbus_connection.channels[relid], NULL);
 }
 
 static void vmbus_release_relid(u32 relid)
@@ -601,6 +602,12 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	 */
 	atomic_dec(&vmbus_connection.offer_in_progress);
 
+	if (vmbus_channel_map_relid(newchannel)) {
+		mutex_unlock(&vmbus_connection.channel_mutex);
+		kfree(newchannel);
+		return;
+	}
+
 	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
 		if (guid_equal(&channel->offermsg.offer.if_type,
 			       &newchannel->offermsg.offer.if_type) &&
@@ -619,6 +626,7 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 		 * Check to see if this is a valid sub-channel.
 		 */
 		if (newchannel->offermsg.offer.sub_channel_index == 0) {
+			vmbus_channel_unmap_relid(newchannel);
 			mutex_unlock(&vmbus_connection.channel_mutex);
 			/*
 			 * Don't call free_channel(), because newchannel->kobj
@@ -635,8 +643,6 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 		list_add_tail(&newchannel->sc_list, &channel->sc_list);
 	}
 
-	vmbus_channel_map_relid(newchannel);
-
 	mutex_unlock(&vmbus_connection.channel_mutex);
 	cpus_read_unlock();
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index e2064bf2b557d..89d7b95b3bdad 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -338,7 +338,7 @@ int vmbus_add_channel_kobj(struct hv_device *device_obj,
 
 void vmbus_remove_channel_attr_group(struct vmbus_channel *channel);
 
-void vmbus_channel_map_relid(struct vmbus_channel *channel);
+int vmbus_channel_map_relid(struct vmbus_channel *channel);
 void vmbus_channel_unmap_relid(struct vmbus_channel *channel);
 
 struct vmbus_channel *relid2channel(u32 relid);
-- 
2.25.1

