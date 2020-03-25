Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34EFD193402
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 23:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCYW4v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 18:56:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52718 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgCYW4u (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 18:56:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id z18so4637462wmk.2;
        Wed, 25 Mar 2020 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfzJYp8dyLFLrZ3XzFRK9XhdmNJPESSVFFNeh4Nvs1A=;
        b=ez0ax3TTWeRuQvdBbUtCRmo3wToAMvAsB0qskjccs8t6ETkdkskkPjkwG9xRK6i0fi
         oPG+mU+Z0F9wmMde3Ptuxo+/BffFp7Soo/vExiSx2wjsOHTAWJ1wncTbBHSuRP+1R8mV
         +MOBjq3kKkYvDcENrMimuHJCMpYt3gv+fYcsLc1ok7aJ5QSaCllfP4LH0TWr8KvC1prk
         FsClNEkqeyg+6S9zNAT/06CX5+9Dmdzw87WOJFmAEhQxQwydbwSOeh6QhCPPPNAUQG5u
         DR4pwBBSGSTEvS4q+h29fit8fYUZaOOhaGKlzMx2ggEx6Obdw0OVA3xZdykH01knMlhg
         QUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfzJYp8dyLFLrZ3XzFRK9XhdmNJPESSVFFNeh4Nvs1A=;
        b=jGh0Uq84TjPQitjAM432YtkAjNelRGMEIZJnt40/g4Dkj8HeCCEvIRSKsP7w95mriP
         y3wDrixeAwcUeAkw0gO1Jtp6ZwlLe797gfSpETJEBSwZRBRM/2fgaPsZ3NQ6IIWo9Ocy
         vC+/nHHNvzhFR4shRnlfmbHjs3QTVGihSnqIpRmMmnuoTPFfbSvpSWuBlUd+SDhGnsuP
         5GunmmNn/4YVdKBNnO9OBNdAILfulOpCXZFRej03HfQ8DYnH2vEqkWraTWK/3vVXN00p
         l8EpjvzjpnwpIX9O7lyYHczSRhw+pryMw8d9aZmveYYs9srN+CnXDhvlmBJMGnlvqzGK
         SRwA==
X-Gm-Message-State: ANhLgQ0/w3Ap1OaKvP5mJaw3GLAUQCVK2+4kO9loHYxuEZqNhuQIjme9
        GlXSCib/5eZRYXg2yoIZvfWYyhzzGRwan+ji
X-Google-Smtp-Source: ADFU+vsrL4j347gh/Zhd83oQhqt+MKlbUbuhydvsCah+bRewftTJ5V0TREdOrMRrdwPbBNziUVzczg==
X-Received: by 2002:a1c:b446:: with SMTP id d67mr5642505wmf.103.1585177007619;
        Wed, 25 Mar 2020 15:56:47 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id q72sm790278wme.31.2020.03.25.15.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:56:47 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [RFC PATCH 11/11] scsi: storvsc: Re-init stor_chns when a channel interrupt is re-assigned
Date:   Wed, 25 Mar 2020 23:55:05 +0100
Message-Id: <20200325225505.23998-12-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200325225505.23998-1-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For each storvsc_device, storvsc keeps track of the channel target CPUs
associated to the device (alloced_cpus) and it uses this information to
fill a "cache" (stor_chns) mapping CPU->channel according to a certain
heuristic.  Update the alloced_cpus mask and the stor_chns array when a
channel of the storvsc device is re-assigned to a different CPU.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: <linux-scsi@vger.kernel.org>
---
 drivers/hv/vmbus_drv.c     |  4 ++
 drivers/scsi/storvsc_drv.c | 95 ++++++++++++++++++++++++++++++++++----
 include/linux/hyperv.h     |  3 ++
 3 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 84d2f22c569aa..7199fee2b5869 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1721,6 +1721,10 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	 * in on a CPU that is different from the channel target_cpu value.
 	 */
 
+	if (channel->change_target_cpu_callback)
+		(*channel->change_target_cpu_callback)(channel,
+				channel->target_cpu, target_cpu);
+
 	channel->target_cpu = target_cpu;
 	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
 	channel->numa_node = cpu_to_node(target_cpu);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index fb41636519ee8..a680592b9d32a 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -621,6 +621,63 @@ static inline struct storvsc_device *get_in_stor_device(
 
 }
 
+void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old, u32 new)
+{
+	struct storvsc_device *stor_device;
+	struct vmbus_channel *cur_chn;
+	bool old_is_alloced = false;
+	struct hv_device *device;
+	unsigned long flags;
+	int cpu;
+
+	device = channel->primary_channel ?
+			channel->primary_channel->device_obj
+				: channel->device_obj;
+	stor_device = get_out_stor_device(device);
+	if (!stor_device)
+		return;
+
+	/* See storvsc_do_io() -> get_og_chn(). */
+	spin_lock_irqsave(&device->channel->lock, flags);
+
+	/*
+	 * Determines if the storvsc device has other channels assigned to
+	 * the "old" CPU to update the alloced_cpus mask and the stor_chns
+	 * array.
+	 */
+	if (device->channel != channel && device->channel->target_cpu == old) {
+		cur_chn = device->channel;
+		old_is_alloced = true;
+		goto old_is_alloced;
+	}
+	list_for_each_entry(cur_chn, &device->channel->sc_list, sc_list) {
+		if (cur_chn == channel)
+			continue;
+		if (cur_chn->target_cpu == old) {
+			old_is_alloced = true;
+			goto old_is_alloced;
+		}
+	}
+
+old_is_alloced:
+	if (old_is_alloced)
+		WRITE_ONCE(stor_device->stor_chns[old], cur_chn);
+	else
+		cpumask_clear_cpu(old, &stor_device->alloced_cpus);
+
+	/* "Flush" the stor_chns array. */
+	for_each_possible_cpu(cpu) {
+		if (stor_device->stor_chns[cpu] && !cpumask_test_cpu(
+					cpu, &stor_device->alloced_cpus))
+			WRITE_ONCE(stor_device->stor_chns[cpu], NULL);
+	}
+
+	WRITE_ONCE(stor_device->stor_chns[new], channel);
+	cpumask_set_cpu(new, &stor_device->alloced_cpus);
+
+	spin_unlock_irqrestore(&device->channel->lock, flags);
+}
+
 static void handle_sc_creation(struct vmbus_channel *new_sc)
 {
 	struct hv_device *device = new_sc->primary_channel->device_obj;
@@ -648,6 +705,8 @@ static void handle_sc_creation(struct vmbus_channel *new_sc)
 		return;
 	}
 
+	new_sc->change_target_cpu_callback = storvsc_change_target_cpu;
+
 	/* Add the sub-channel to the array of available channels. */
 	stor_device->stor_chns[new_sc->target_cpu] = new_sc;
 	cpumask_set_cpu(new_sc->target_cpu, &stor_device->alloced_cpus);
@@ -876,6 +935,8 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 	if (stor_device->stor_chns == NULL)
 		return -ENOMEM;
 
+	device->channel->change_target_cpu_callback = storvsc_change_target_cpu;
+
 	stor_device->stor_chns[device->channel->target_cpu] = device->channel;
 	cpumask_set_cpu(device->channel->target_cpu,
 			&stor_device->alloced_cpus);
@@ -1248,8 +1309,10 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device *stor_device,
 	const struct cpumask *node_mask;
 	int num_channels, tgt_cpu;
 
-	if (stor_device->num_sc == 0)
+	if (stor_device->num_sc == 0) {
+		stor_device->stor_chns[q_num] = stor_device->device->channel;
 		return stor_device->device->channel;
+	}
 
 	/*
 	 * Our channel array is sparsley populated and we
@@ -1258,7 +1321,6 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device *stor_device,
 	 * The strategy is simple:
 	 * I. Ensure NUMA locality
 	 * II. Distribute evenly (best effort)
-	 * III. Mapping is persistent.
 	 */
 
 	node_mask = cpumask_of_node(cpu_to_node(q_num));
@@ -1268,8 +1330,10 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device *stor_device,
 		if (cpumask_test_cpu(tgt_cpu, node_mask))
 			num_channels++;
 	}
-	if (num_channels == 0)
+	if (num_channels == 0) {
+		stor_device->stor_chns[q_num] = stor_device->device->channel;
 		return stor_device->device->channel;
+	}
 
 	hash_qnum = q_num;
 	while (hash_qnum >= num_channels)
@@ -1295,6 +1359,7 @@ static int storvsc_do_io(struct hv_device *device,
 	struct storvsc_device *stor_device;
 	struct vstor_packet *vstor_packet;
 	struct vmbus_channel *outgoing_channel, *channel;
+	unsigned long flags;
 	int ret = 0;
 	const struct cpumask *node_mask;
 	int tgt_cpu;
@@ -1308,10 +1373,11 @@ static int storvsc_do_io(struct hv_device *device,
 
 	request->device  = device;
 	/*
-	 * Select an an appropriate channel to send the request out.
+	 * Select an appropriate channel to send the request out.
 	 */
-	if (stor_device->stor_chns[q_num] != NULL) {
-		outgoing_channel = stor_device->stor_chns[q_num];
+	/* See storvsc_change_target_cpu(). */
+	outgoing_channel = READ_ONCE(stor_device->stor_chns[q_num]);
+	if (outgoing_channel != NULL) {
 		if (outgoing_channel->target_cpu == q_num) {
 			/*
 			 * Ideally, we want to pick a different channel if
@@ -1324,7 +1390,10 @@ static int storvsc_do_io(struct hv_device *device,
 					continue;
 				if (tgt_cpu == q_num)
 					continue;
-				channel = stor_device->stor_chns[tgt_cpu];
+				channel = READ_ONCE(
+					stor_device->stor_chns[tgt_cpu]);
+				if (channel == NULL)
+					continue;
 				if (hv_get_avail_to_write_percent(
 							&channel->outbound)
 						> ring_avail_percent_lowater) {
@@ -1350,7 +1419,10 @@ static int storvsc_do_io(struct hv_device *device,
 			for_each_cpu(tgt_cpu, &stor_device->alloced_cpus) {
 				if (cpumask_test_cpu(tgt_cpu, node_mask))
 					continue;
-				channel = stor_device->stor_chns[tgt_cpu];
+				channel = READ_ONCE(
+					stor_device->stor_chns[tgt_cpu]);
+				if (channel == NULL)
+					continue;
 				if (hv_get_avail_to_write_percent(
 							&channel->outbound)
 						> ring_avail_percent_lowater) {
@@ -1360,7 +1432,14 @@ static int storvsc_do_io(struct hv_device *device,
 			}
 		}
 	} else {
+		spin_lock_irqsave(&device->channel->lock, flags);
+		outgoing_channel = stor_device->stor_chns[q_num];
+		if (outgoing_channel != NULL) {
+			spin_unlock_irqrestore(&device->channel->lock, flags);
+			goto found_channel;
+		}
 		outgoing_channel = get_og_chn(stor_device, q_num);
+		spin_unlock_irqrestore(&device->channel->lock, flags);
 	}
 
 found_channel:
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index edfcd42319ef3..9018b89614b78 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -773,6 +773,9 @@ struct vmbus_channel {
 	void (*onchannel_callback)(void *context);
 	void *channel_callback_context;
 
+	void (*change_target_cpu_callback)(struct vmbus_channel *channel,
+			u32 old, u32 new);
+
 	/*
 	 * Synchronize channel scheduling and channel removal; see the inline
 	 * comments in vmbus_chan_sched() and vmbus_reset_channel_cb().
-- 
2.24.0

