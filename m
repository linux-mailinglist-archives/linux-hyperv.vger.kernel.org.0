Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D3F1E32B3
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2020 00:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392206AbgEZWdJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 May 2020 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390326AbgEZWdH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 May 2020 18:33:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D7C061A0F;
        Tue, 26 May 2020 15:33:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d24so18984754eds.11;
        Tue, 26 May 2020 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAGhh9qpO2r+MaEW6n2c5yWjNFmDJ2ymqsmwJcSeYfY=;
        b=iZ46kmCCmJH+VRPRm4ABKeo/QjCHL7zJgkZlU8H4nqER5TV9JeQ/BG3mB0HBXFVoIM
         EJrb2O7aYGXPeq1IeSQPpcCDVbtqA1/LrEo9YTpRXdRKtCHuVnpsD4kILsi3mDzdnvIO
         7E94P6FgzSkdw1avnMxSAQzlRId5v+Oo0iyMZbI332ARvQoyan55hCxJWO9eBcmnAPqG
         1DKt3XEfycWytDaofNUDxyuwN70q31L/u0uHwVK7vWIPL9yDD8hjvVypUA2yZnP8Ioha
         hzEgjjTGsAPrNKxKw92vykY/YMML6PBxYEFNY+GfdJcpuc9pdTAN1PTSs0EtyPOPKaXK
         Egbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAGhh9qpO2r+MaEW6n2c5yWjNFmDJ2ymqsmwJcSeYfY=;
        b=f9rV/+a9GsE5/SfsC5tPgnHV/Qe0nHRLONqbJh162lMCexRztTp6yjGb7s3VFZEFiG
         zqmacHY5OdL5I/Lt/M4VpFIrkhKzyG2spA3D6YWWQ8hLVTeacRtTJZjZGqugH2NEzBDD
         z5BK6IjYKckVKR8X03TOChU127woDwAOOyDd9giowNtNuHgW2jUC3yYN6j09ZLjj2vWn
         u9ifxZyKHKBtm9OVSbjLXbQ09j1Y53PoaWZUQMwa+aux9eeoNIvfxBUUF3CbxS6oPw50
         w0CY1u7cUKMgciMDpoQSgy3lji6sNuVs2uWI19KqSpdLoXg36UGlnIj2w2WjI6ONVgUJ
         XS3A==
X-Gm-Message-State: AOAM532fID1E1Yk3n5LQJp8ykogspg/SGfrx806cDcOLTTPcu91YLy6L
        6eIIWe6TS5yImIHDqAZskeCC5mksqIXvLQ==
X-Google-Smtp-Source: ABdhPJxeV/oYbnv137RsKR7rDnucMp1NzuoDCCN1MiuDI8j1RXUqVUDC0eoiI9qGArpnJNOdiX+dtw==
X-Received: by 2002:a50:f40e:: with SMTP id r14mr21453078edm.241.1590532384731;
        Tue, 26 May 2020 15:33:04 -0700 (PDT)
Received: from localhost.localdomain (ip-62-245-103-65.net.upcbroadband.cz. [62.245.103.65])
        by smtp.gmail.com with ESMTPSA id cd17sm68288ejb.115.2020.05.26.15.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:33:04 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Nuno Das Neves <nuno.das@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [RFC PATCH 2/2] Drivers: hv: vmbus: Re-balance channel interrupts across CPUs at device hotplug
Date:   Wed, 27 May 2020 00:32:18 +0200
Message-Id: <20200526223218.184057-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200526223218.184057-1-parri.andrea@gmail.com>
References: <20200526223218.184057-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Device hot removals and additions (closure and opening) also present a
valid opportunity for (re-)balancing the channel interrupts across the
available CPUs.  Current code balances interrupts as they are offered,
but it does not modify the interrupts-to-CPUs assignment if interrupts
are "rescinded"/removed from the system.  Moreover, in case of channel
/device offers, the interrupt assignments are performed *one at a time*
and without full visibility into other channels/devices; the result is
that, globally, interrupts are sometimes not evenly spread across CPUs.

Introduce the vmbus_balance_vp_indexes_at_devhp() primitive to balance
the channel interrupts across online CPUs at device hotplug operations.
The primitive triggers a "full" balancing of the interrupts across the
online CPUs and NUMA nodes.  The balancing process at device addition/
opening is deferred to a delayed work, to give channels of such device
more chances to be opened.  As in vmbus_balance_vp_indexes_at_cpuhp(),
the balancing is applied to "performance" channels only, and it relies
on the (new) capability to re-assign a channel interrupt.

Suggested-by: Nuno Das Neves <nuno.das@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c      | 43 ++++++++++++++++++++++++++++++++
 drivers/hv/channel_mgmt.c | 52 ++++++++++++++++++++++++++++++++++++---
 drivers/hv/connection.c   |  9 +++++++
 drivers/hv/hyperv_vmbus.h |  6 +++++
 include/linux/hyperv.h    |  6 +++++
 5 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 2974aa9dc956c..076f2d68a1efe 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/cpu.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -112,6 +113,19 @@ int vmbus_alloc_ring(struct vmbus_channel *newchannel,
 }
 EXPORT_SYMBOL_GPL(vmbus_alloc_ring);
 
+static void vmbus_add_device_work(struct work_struct *work)
+{
+	struct hv_device *hv_dev =
+		container_of((struct delayed_work *)work, struct hv_device,
+			     add_device_work);
+
+	cpus_read_lock();
+	mutex_lock(&vmbus_connection.channel_mutex);
+	vmbus_balance_vp_indexes_at_devhp(hv_dev, true);
+	mutex_unlock(&vmbus_connection.channel_mutex);
+	cpus_read_unlock();
+}
+
 static int __vmbus_open(struct vmbus_channel *newchannel,
 		       void *userdata, u32 userdatalen,
 		       void (*onchannelcallback)(void *context), void *context)
@@ -217,6 +231,24 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	}
 
 	newchannel->state = CHANNEL_OPENED_STATE;
+	/*
+	 * If this is a primary channel and a "perf" channel, queue the
+	 * add_device_work to balance the channels of the device across
+	 * the online CPUs; the queueing delay should be greater than
+	 * the "typical" time required to open such channels, since the
+	 * balancing will only apply to *open* channels.  The closure
+	 * path will wait for our work to complete and start a new re-
+	 * balancing, cf. vmbus_disconnect_ring().
+	 */
+	if (newchannel->primary_channel == NULL &&
+			hv_is_perf_channel(newchannel)) {
+		struct delayed_work *dwork =
+			&newchannel->device_obj->add_device_work;
+
+		INIT_DELAYED_WORK(dwork, vmbus_add_device_work);
+		queue_delayed_work(vmbus_connection.handle_dev_wq, dwork,
+				   8 * HZ);
+	}
 	kfree(open_info);
 	return 0;
 
@@ -750,6 +782,8 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 /* disconnect ring - close all channels */
 int vmbus_disconnect_ring(struct vmbus_channel *channel)
 {
+	struct hv_device *hv_dev = channel->device_obj;
+	bool perf_chn = hv_is_perf_channel(channel);
 	struct vmbus_channel *cur_channel, *tmp;
 	int ret;
 
@@ -773,9 +807,18 @@ int vmbus_disconnect_ring(struct vmbus_channel *channel)
 	/*
 	 * Now close the primary.
 	 */
+
+	/* See inline comment in __vmbus_open(). */
+	if (perf_chn)
+		cancel_delayed_work_sync(&hv_dev->add_device_work);
+
+	cpus_read_lock();
 	mutex_lock(&vmbus_connection.channel_mutex);
+	if (perf_chn)
+		vmbus_balance_vp_indexes_at_devhp(hv_dev, false);
 	ret = vmbus_close_internal(channel);
 	mutex_unlock(&vmbus_connection.channel_mutex);
+	cpus_read_unlock();
 
 	return ret;
 }
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index c158f86787940..91b1bd2914d79 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -815,6 +815,49 @@ static void balance_vp_index(struct vmbus_channel *chn,
 	inc_chn_counts(&vmbus_connection.chn_cnt, tgt_cpu);
 }
 
+void vmbus_balance_vp_indexes_at_devhp(struct hv_device *hv_dev, bool add)
+{
+	struct vmbus_channel *chn, *sc;
+	cpumask_var_t cpu_msk;
+
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
+
+	WARN_ON(!hv_is_perf_channel(hv_dev->channel));
+
+	/* See the header comment for vmbus_send_modifychannel(). */
+	if (vmbus_proto_version < VERSION_WIN10_V4_1)
+		return;
+
+	if (!alloc_cpumask_var(&cpu_msk, GFP_KERNEL))
+		return;
+
+	reset_chn_counts(&vmbus_connection.chn_cnt);
+
+	list_for_each_entry(chn, &vmbus_connection.chn_list, listentry) {
+		struct hv_device *dev = chn->device_obj;
+
+		/* See comment in vmbus_balance_vp_indexes_at_cpuhp(). */
+		if (!hv_is_perf_channel(chn) || dev == NULL)
+			continue;
+
+		if (dev == hv_dev && !add)
+			continue;
+
+		reset_chn_counts(&dev->chn_cnt);
+
+		cpumask_copy(cpu_msk, cpu_online_mask);
+		balance_vp_index(chn, dev, cpu_msk);
+
+		list_for_each_entry(sc, &chn->sc_list, sc_list) {
+			cpumask_copy(cpu_msk, cpu_online_mask);
+			balance_vp_index(sc, dev, cpu_msk);
+		}
+	}
+
+	free_cpumask_var(cpu_msk);
+}
+
 void vmbus_balance_vp_indexes_at_cpuhp(unsigned int cpu, bool add)
 {
 	struct vmbus_channel *chn, *sc;
@@ -840,10 +883,11 @@ void vmbus_balance_vp_indexes_at_cpuhp(unsigned int cpu, bool add)
 		/*
 		 * The device may not have been allocated/assigned to
 		 * the primary channel yet; if so, do not balance the
-		 * channels associated to this device.  If dev != NULL,
-		 * the synchronization on channel_mutex ensures that
-		 * the device's chn_cnt has been (properly) allocated
-		 * *and* initialized, cf. vmbus_add_channel_work().
+		 * channels associated to the device and "defer" this
+		 * to vmbus_balance_vp_indexes_at_devhp().  If dev !=
+		 * NULL, the synchronization on channel_mutex ensures
+		 * that the device's chn_cnt has been allocated *and*
+		 * initialized, cf. vmbus_add_channel_work().
 		 */
 		if (dev == NULL)
 			continue;
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 7ec562fac8e58..f93060babd9a4 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -179,6 +179,12 @@ int vmbus_connect(void)
 		goto cleanup;
 	}
 
+	vmbus_connection.handle_dev_wq = create_workqueue("hv_device");
+	if (!vmbus_connection.handle_dev_wq) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
 	INIT_LIST_HEAD(&vmbus_connection.chn_msg_list);
 	spin_lock_init(&vmbus_connection.channelmsg_lock);
 
@@ -281,6 +287,9 @@ void vmbus_disconnect(void)
 	 */
 	vmbus_initiate_unload(false);
 
+	if (vmbus_connection.handle_dev_wq)
+		destroy_workqueue(vmbus_connection.handle_dev_wq);
+
 	if (vmbus_connection.handle_sub_chan_wq)
 		destroy_workqueue(vmbus_connection.handle_sub_chan_wq);
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index b6d194caf69ed..b461cf7efd91c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -272,6 +272,11 @@ struct vmbus_connection {
 	struct workqueue_struct *work_queue;
 	struct workqueue_struct *handle_primary_chan_wq;
 	struct workqueue_struct *handle_sub_chan_wq;
+	/*
+	 * Handling device hotplug/addition work, cf. add_device_work from
+	 * struct hv_device.
+	 */
+	struct workqueue_struct *handle_dev_wq;
 
 	/*
 	 * The number of sub-channels and hv_sock channels that should be
@@ -358,6 +363,7 @@ struct vmbus_channel *relid2channel(u32 relid);
 
 void vmbus_free_channels(void);
 
+void vmbus_balance_vp_indexes_at_devhp(struct hv_device *hv_dev, bool add);
 void vmbus_balance_vp_indexes_at_cpuhp(unsigned int cpu, bool add);
 
 /* Connection interface */
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 0e9f695ea8f87..ce0bf3001792f 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1212,6 +1212,12 @@ struct hv_device {
 
 	/* place holder to keep track of the dir for hv device in debugfs */
 	struct dentry *debug_dir;
+
+	/*
+	 * Balance the channel interrupts across the online CPUs at device
+	 * hotplug/addition.
+	 */
+	struct delayed_work add_device_work;
 };
 
 
-- 
2.25.1

