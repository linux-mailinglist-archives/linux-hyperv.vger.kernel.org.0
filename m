Return-Path: <linux-hyperv+bounces-3664-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FDCA09C28
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 21:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5483AA837
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11218207DF7;
	Fri, 10 Jan 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nd5Uf3v/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F63D207A18;
	Fri, 10 Jan 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736539562; cv=none; b=aBnj9xNrVRiqG6iNWi1NxQi5PkTFozQcTo2+4/0NGWTTHXHDKOcc9GKo9ekhvk+e7kjgEgk2/ha4z1O+OQ3P4I8rgcwXZqbmXGrndN81sVp6Px3dBigzberf5I73z+ohYevSBlKay+h2iCnHSGdmyzp3ofmiL2h1kFlxiymlWzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736539562; c=relaxed/simple;
	bh=4o4S/WxDk58PQ2SrIuV7KJ3ysxELaTEkSCX8slmhnK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M6f1a664MfNRzSYlbrxBPtkBZdLRBZS7LtRy7Kf0kNKAjDLyhH58HPvJZaLQVhNkof/iDEX4q71E0gKb0vS2JUezOj9YMZ+pi2DTxKx2Zh5cffWfpgqYrrHFIwNMy+FoWbw+54/K4yey3sm7q/KZ+7Pps/vjtoU6mOSEPYIlK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nd5Uf3v/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.lan (unknown [174.88.132.51])
	by linux.microsoft.com (Postfix) with ESMTPSA id 59439203D5F1;
	Fri, 10 Jan 2025 12:05:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59439203D5F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736539553;
	bh=jSnVugJtQPK7joSD4Pq4GIClLOZFayGQUE7jYdPsP6o=;
	h=From:To:Cc:Subject:Date:From;
	b=nd5Uf3v/9Vp99FfVBGvmqOSM91fiE/JiyZIDThmulTiICDJ3cqIqe/PhyN6QykTLe
	 Al7+u+/MUMhf33yNyCw3TS39syrkiqVAP+Kvg9MSJzsFxrP98Ff1dpSMkTul4rWnBH
	 h43nroR1+cpOgs3AMsIrD+2GwqCRIwpB7X30cWgs=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/hv: add CPU offlining support
Date: Fri, 10 Jan 2025 15:05:06 -0500
Message-ID: <20250110200507.120452-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it is effectively impossible to offline CPUs. Since, most
CPUs will have vmbus channels attached to them. So, as made mention of
in commit d570aec0f2154 ("Drivers: hv: vmbus: Synchronize
init_vp_index() vs. CPU hotplug"), rebind channels associated with CPUs
that a user is trying to offline to a new "randomly" selected CPU.

Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/hv/hv.c        | 57 +++++++++++++++++++++++++++++++-----------
 drivers/hv/vmbus_drv.c | 51 +++++++++++++++++++++----------------
 include/linux/hyperv.h |  1 +
 3 files changed, 73 insertions(+), 36 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 36d9ba097ff5..42270a7a7a19 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -433,13 +433,40 @@ static bool hv_synic_event_pending(void)
 	return pending;
 }
 
+static int hv_pick_new_cpu(struct vmbus_channel *channel,
+			   unsigned int current_cpu)
+{
+	int ret = 0;
+	int cpu;
+
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
+
+	/*
+	 * We can't assume that the relevant interrupts will be sent before
+	 * the cpu is offlined on older versions of hyperv.
+	 */
+	if (vmbus_proto_version < VERSION_WIN10_V5_3)
+		return -EBUSY;
+
+	cpus_read_lock();
+	cpu = cpumask_next(get_random_u32_below(nr_cpu_ids), cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids || cpu == current_cpu)
+		cpu = VMBUS_CONNECT_CPU;
+
+	ret = vmbus_channel_set_cpu(channel, cpu);
+	cpus_read_unlock();
+
+	return ret;
+}
+
 /*
  * hv_synic_cleanup - Cleanup routine for hv_synic_init().
  */
 int hv_synic_cleanup(unsigned int cpu)
 {
 	struct vmbus_channel *channel, *sc;
-	bool channel_found = false;
+	int ret = 0;
 
 	if (vmbus_connection.conn_state != CONNECTED)
 		goto always_cleanup;
@@ -456,31 +483,31 @@ int hv_synic_cleanup(unsigned int cpu)
 
 	/*
 	 * Search for channels which are bound to the CPU we're about to
-	 * cleanup.  In case we find one and vmbus is still connected, we
-	 * fail; this will effectively prevent CPU offlining.
-	 *
-	 * TODO: Re-bind the channels to different CPUs.
+	 * cleanup.
 	 */
 	mutex_lock(&vmbus_connection.channel_mutex);
 	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
 		if (channel->target_cpu == cpu) {
-			channel_found = true;
-			break;
+			ret = hv_pick_new_cpu(channel, cpu);
+
+			if (ret) {
+				mutex_unlock(&vmbus_connection.channel_mutex);
+				return ret;
+			}
 		}
 		list_for_each_entry(sc, &channel->sc_list, sc_list) {
 			if (sc->target_cpu == cpu) {
-				channel_found = true;
-				break;
+				ret = hv_pick_new_cpu(channel, cpu);
+
+				if (ret) {
+					mutex_unlock(&vmbus_connection.channel_mutex);
+					return ret;
+				}
 			}
 		}
-		if (channel_found)
-			break;
 	}
 	mutex_unlock(&vmbus_connection.channel_mutex);
 
-	if (channel_found)
-		return -EBUSY;
-
 	/*
 	 * channel_found == false means that any channels that were previously
 	 * assigned to the CPU have been reassigned elsewhere with a call of
@@ -497,5 +524,5 @@ int hv_synic_cleanup(unsigned int cpu)
 
 	hv_synic_disable_regs(cpu);
 
-	return 0;
+	return ret;
 }
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2892b8da20a5..c256e02fa66b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1611,16 +1611,15 @@ static ssize_t target_cpu_show(struct vmbus_channel *channel, char *buf)
 {
 	return sprintf(buf, "%u\n", channel->target_cpu);
 }
-static ssize_t target_cpu_store(struct vmbus_channel *channel,
-				const char *buf, size_t count)
+
+int vmbus_channel_set_cpu(struct vmbus_channel *channel, u32 target_cpu)
 {
-	u32 target_cpu, origin_cpu;
-	ssize_t ret = count;
+	u32 origin_cpu;
+	int ret = 0;
 
-	if (vmbus_proto_version < VERSION_WIN10_V4_1)
-		return -EIO;
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
 
-	if (sscanf(buf, "%uu", &target_cpu) != 1)
+	if (vmbus_proto_version < VERSION_WIN10_V4_1)
 		return -EIO;
 
 	/* Validate target_cpu for the cpumask_test_cpu() operation below. */
@@ -1630,22 +1629,17 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	if (!cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
 		return -EINVAL;
 
-	/* No CPUs should come up or down during this. */
-	cpus_read_lock();
-
-	if (!cpu_online(target_cpu)) {
-		cpus_read_unlock();
+	if (!cpu_online(target_cpu))
 		return -EINVAL;
-	}
 
 	/*
-	 * Synchronizes target_cpu_store() and channel closure:
+	 * Synchronizes vmbus_channel_set_cpu() and channel closure:
 	 *
 	 * { Initially: state = CHANNEL_OPENED }
 	 *
 	 * CPU1				CPU2
 	 *
-	 * [target_cpu_store()]		[vmbus_disconnect_ring()]
+	 * [vmbus_channel_set_cpu()]	[vmbus_disconnect_ring()]
 	 *
 	 * LOCK channel_mutex		LOCK channel_mutex
 	 * LOAD r1 = state		LOAD r2 = state
@@ -1660,7 +1654,6 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	 * Note.  The host processes the channel messages "sequentially", in
 	 * the order in which they are received on a per-partition basis.
 	 */
-	mutex_lock(&vmbus_connection.channel_mutex);
 
 	/*
 	 * Hyper-V will ignore MODIFYCHANNEL messages for "non-open" channels;
@@ -1668,17 +1661,17 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	 */
 	if (channel->state != CHANNEL_OPENED_STATE) {
 		ret = -EIO;
-		goto cpu_store_unlock;
+		goto end;
 	}
 
 	origin_cpu = channel->target_cpu;
 	if (target_cpu == origin_cpu)
-		goto cpu_store_unlock;
+		goto end;
 
 	if (vmbus_send_modifychannel(channel,
 				     hv_cpu_number_to_vp_number(target_cpu))) {
 		ret = -EIO;
-		goto cpu_store_unlock;
+		goto end;
 	}
 
 	/*
@@ -1708,9 +1701,25 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 				origin_cpu, target_cpu);
 	}
 
-cpu_store_unlock:
-	mutex_unlock(&vmbus_connection.channel_mutex);
+end:
+	return ret;
+}
+
+static ssize_t target_cpu_store(struct vmbus_channel *channel,
+				const char *buf, size_t count)
+{
+	ssize_t ret = count;
+	u32 target_cpu;
+
+	if (sscanf(buf, "%uu", &target_cpu) != 1)
+		return -EIO;
+
+	mutex_lock(&vmbus_connection.channel_mutex);
+	cpus_read_lock();
+	ret = vmbus_channel_set_cpu(channel, target_cpu);
 	cpus_read_unlock();
+	mutex_unlock(&vmbus_connection.channel_mutex);
+
 	return ret;
 }
 static VMBUS_CHAN_ATTR(cpu, 0644, target_cpu_show, target_cpu_store);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 02a226bcf0ed..25e9e982f1b0 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1670,6 +1670,7 @@ int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
 				  const guid_t *shv_host_servie_id);
 int vmbus_send_modifychannel(struct vmbus_channel *channel, u32 target_vp);
 void vmbus_set_event(struct vmbus_channel *channel);
+int vmbus_channel_set_cpu(struct vmbus_channel *channel, u32 target_cpu);
 
 /* Get the start of the ring buffer. */
 static inline void *
-- 
2.47.1


