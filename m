Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1242CB8B6
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 10:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbgLBJXe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 04:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbgLBJXe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 04:23:34 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FC0C061A48;
        Wed,  2 Dec 2020 01:22:53 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so2730517wrn.1;
        Wed, 02 Dec 2020 01:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tGTKpRtEDgTWjjR0ZDasoiR9oQMKeKQBkQsRzcL3XPY=;
        b=L3cAB0l/DmuJ2nD1KkeIY0TyjgmWOgYo95waNaQ29HbAeEzBGFElLnsgJZeYxcs8eL
         DiyJ1r96WlqSTCarCkFz5W66wKdhbr/kl5nLwVBubJaXrtJ/jTgN/DwnM/u7jtpGSip3
         ursRedaABghf70vYqFjKkMgKxrdAndtXsQ6yeYLNpRa5+A/WpIoFkg5+vQhN59CSPgfY
         i93gqDdp6LzAM2KzJ5ob1vTC0LMpoT5KwxBEnGnSy7kmMcZMhs75SCHwjqkWl+dWNxBk
         tk7jJ/JEyNmcdhfdVw0MlWY0TSPo0LTiFCegM5znOtVvEyT+ZmejP8dpPM0DgP7bteF3
         60vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGTKpRtEDgTWjjR0ZDasoiR9oQMKeKQBkQsRzcL3XPY=;
        b=DciYFp46t7srn3m5OqTdtUYSWarGLa9JwkEOsF3BEvet9TIzZrllewFECIaaOzHD+p
         D+zTznsrzARucoNKWX/AA+TVqILVD4ljYzULRTGZ5BBVKFqH41tIUnZ6hxTnYbk3maTj
         z6SNIYF8k97a6AhMoNV8NHegV9315abevwebIrCPY+N7mdfEGi3MhmA3MJNn/8+K4Fjr
         8FNyIRTp95gpIo0ZTCp2fN2BbYIoW3QDOALsFoDZU4snAiUCI+5JB0rs9GN6ayhEOwhE
         o9yZrNLZSBqaNiaPL8TmYlD/ltHegFoKjwNXwVeVpe0agZ60MekaCmnedtRUFQ+Vhqjy
         uiSg==
X-Gm-Message-State: AOAM531Gr6Rdj1BzQ2rgM5VxoJcAvv5FP7SZaYXDlHX+iVA3rQcbE6Ws
        7FSAprLaZn3Z/mVr1f4QF40d/lKr2/+ZJA==
X-Google-Smtp-Source: ABdhPJzKXNZZrdMhtDG2FqZMp4mGgavL3L+5tkWwuSzm5NeZTuSLPEhxgRgExPpyDS+3euo3Xcbwcw==
X-Received: by 2002:a05:6000:120c:: with SMTP id e12mr2160654wrx.59.1606900971896;
        Wed, 02 Dec 2020 01:22:51 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id e27sm1535936wrc.9.2020.12.02.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:22:51 -0800 (PST)
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
Subject: [PATCH v2 7/7] Drivers: hv: vmbus: Do not allow overwriting vmbus_connection.channels[]
Date:   Wed,  2 Dec 2020 10:22:14 +0100
Message-Id: <20201202092214.13520-8-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202092214.13520-1-parri.andrea@gmail.com>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
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
Changes since v1:
  - Don't corrupt oldchannel if offer->child_relid is invalid

 drivers/hv/channel_mgmt.c | 38 ++++++++++++++++++++++++--------------
 drivers/hv/hyperv_vmbus.h |  2 +-
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 68950a1e4b638..f91d476dfe381 100644
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
 
@@ -920,6 +926,8 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 	oldchannel = find_primary_channel_by_offer(offer);
 
 	if (oldchannel != NULL) {
+		u32 relid = offer->child_relid;
+
 		/*
 		 * We're resuming from hibernation: all the sub-channel and
 		 * hv_sock channels we had before the hibernation should have
@@ -954,8 +962,10 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 		atomic_dec(&vmbus_connection.offer_in_progress);
 
 		WARN_ON(oldchannel->offermsg.child_relid != INVALID_RELID);
+		if (WARN_ON(vmbus_connection.channels[relid] != NULL))
+			return;
 		/* Fix up the relid. */
-		oldchannel->offermsg.child_relid = offer->child_relid;
+		oldchannel->offermsg.child_relid = relid;
 
 		offer_sz = sizeof(*offer);
 		if (memcmp(offer, &oldchannel->offermsg, offer_sz) != 0) {
@@ -967,7 +977,7 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 			 * reoffers the device upon resume.
 			 */
 			pr_debug("vmbus offer changed: relid=%d\n",
-				 offer->child_relid);
+				 relid);
 
 			print_hex_dump_debug("Old vmbus offer: ",
 					     DUMP_PREFIX_OFFSET, 16, 4,
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

