Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99242D3C03
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 08:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgLIHKa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 02:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgLIHKV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 02:10:21 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B7C0617A7;
        Tue,  8 Dec 2020 23:09:31 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so503276wrr.12;
        Tue, 08 Dec 2020 23:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bx5zsXWq2TsLd1av5cUuK12+/TfvUph8JxWJR1Ftl9c=;
        b=B1ZPSOnvzc3vi5Oza+xt41d7q5Pjb0QbFoflEqhnn5fngkm+kSyQNGRZLSic5IHUSd
         4NTmTwz4yg0YbGZ5iB2NZWdnYNDGP2WdxEkzTDOIWioUHEfTOkI4n6NKmtewB+0uScfv
         c2SPoUMYn/4kbm8ghoaKVPH6GXowcyd48hfRNany/2vkYvLTiKK08ziUdHY6e8ItwyII
         mfwVbxz66U58Sc3ir4iVXFbPHX8uVGSBaR3Poxa+J+a80XPYQ9mdwE1sr0blvbqrMDPN
         Pgu+ZsSKRVOparLSTz/PTpRkrfxTCy0Yfv62m8acYTUUAslPwKD434dhbP1qdeTIRSdN
         vbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bx5zsXWq2TsLd1av5cUuK12+/TfvUph8JxWJR1Ftl9c=;
        b=a9yK1ziMeV8lK08ne/iJFzQkc1UCD3KQbCI3EN0gCgqueuA9S6iiutWxliGB/3Yftn
         lSUClvVVHkn7SbbhNbyQLZRT+lQq/xqcd+LIRP/F4bBPiW//A0jCbmj+Md7/BnCE/EEJ
         JSzI0jfn0dOFsUQV5CQ+xVWWp05782mr1+scVlwyMND8PDZ75ZCV16hlbYp2+Hr4zmEU
         WRuhnfWM9H1OZ7mrbemnl435khsh/DBv/QYCAhWUTi7phaWa6Tz8opTsmwwxXDeVli9o
         fhYGqt/uyAm/+pAwiZ5uY18AUHaz7L+dTrGV9hTzDAg1UqK7YEei0UbEwDAc3vrIrpiv
         nmRA==
X-Gm-Message-State: AOAM533ofHLkglmpNP9U26pLs9hb8QflEiYi7yj08YU/hlt0Nyau1fym
        TKZnP+wZU4leDvG42WGlPwy6USQ+lPzckw==
X-Google-Smtp-Source: ABdhPJw0hkgqKETPcvYNSUHOX8eYBtVQ4Koxw++mUsqW/GG3L4pvteWFHt9FUhGA/l3xU4fbpmVLjg==
X-Received: by 2002:adf:e801:: with SMTP id o1mr982221wrm.3.1607497769450;
        Tue, 08 Dec 2020 23:09:29 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id p3sm1449122wrs.50.2020.12.08.23.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 23:09:29 -0800 (PST)
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
Subject: [PATCH v3 6/6] Drivers: hv: vmbus: Do not allow overwriting vmbus_connection.channels[]
Date:   Wed,  9 Dec 2020 08:08:27 +0100
Message-Id: <20201209070827.29335-7-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209070827.29335-1-parri.andrea@gmail.com>
References: <20201209070827.29335-1-parri.andrea@gmail.com>
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
Changes since v2:
  - Release channel_mutex before 'return' in vmbus_onoffer() error path

 drivers/hv/channel_mgmt.c | 40 +++++++++++++++++++++++++--------------
 drivers/hv/hyperv_vmbus.h |  2 +-
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 68950a1e4b638..2c15693b86f1e 100644
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
@@ -954,8 +962,12 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 		atomic_dec(&vmbus_connection.offer_in_progress);
 
 		WARN_ON(oldchannel->offermsg.child_relid != INVALID_RELID);
+		if (WARN_ON(vmbus_connection.channels[relid] != NULL)) {
+			mutex_unlock(&vmbus_connection.channel_mutex);
+			return;
+		}
 		/* Fix up the relid. */
-		oldchannel->offermsg.child_relid = offer->child_relid;
+		oldchannel->offermsg.child_relid = relid;
 
 		offer_sz = sizeof(*offer);
 		if (memcmp(offer, &oldchannel->offermsg, offer_sz) != 0) {
@@ -967,7 +979,7 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 			 * reoffers the device upon resume.
 			 */
 			pr_debug("vmbus offer changed: relid=%d\n",
-				 offer->child_relid);
+				 relid);
 
 			print_hex_dump_debug("Old vmbus offer: ",
 					     DUMP_PREFIX_OFFSET, 16, 4,
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 42f3d9d123a12..3222fbf2a21c6 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -337,7 +337,7 @@ int vmbus_add_channel_kobj(struct hv_device *device_obj,
 
 void vmbus_remove_channel_attr_group(struct vmbus_channel *channel);
 
-void vmbus_channel_map_relid(struct vmbus_channel *channel);
+int vmbus_channel_map_relid(struct vmbus_channel *channel);
 void vmbus_channel_unmap_relid(struct vmbus_channel *channel);
 
 struct vmbus_channel *relid2channel(u32 relid);
-- 
2.25.1

