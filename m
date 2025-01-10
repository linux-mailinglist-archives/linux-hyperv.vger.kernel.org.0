Return-Path: <linux-hyperv+bounces-3667-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1FDA09D83
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 23:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2803A4B49
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 22:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB34020ADC0;
	Fri, 10 Jan 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="genfpSnS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4246C2165F4;
	Fri, 10 Jan 2025 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546422; cv=none; b=jRxT7npkWk4aFMjsMtHhFNyNHgqV9nGL1WwwMPdunHrlVrOcXw4a+EfhWdwyUt4deMhC8d2oze3DMcTi9LAyRidm83r2GkPBA4Xys4e66uN5mzFNxQm1wog9G6TjpH6CclPAQvOlqn2ro68j2YRXJQkeK/WALReZiQO1Yok/iso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546422; c=relaxed/simple;
	bh=zDpRSoUyN2YNMkZPx6+RYERp3wqOIuLp9y+QcRF182U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cMuf7pzx5EYO1sPSSWmAR5QjQHvkBlLcmnzXV5+EETSL86o2C0JDBbCW9QGjJKpvj1sOLLzRmMR5fR+s4XVl0AFs2O4L/eJOIfTz7Y/6r3hFRtwZZXOFzNfl+wZLC60e3/YO4+4PkHnIicUctjI9KEBBiEZfcFSD/555eUv9Rxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=genfpSnS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.lan (unknown [174.88.132.51])
	by linux.microsoft.com (Postfix) with ESMTPSA id 38EBB203D5F2;
	Fri, 10 Jan 2025 14:00:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38EBB203D5F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736546420;
	bh=0mR0lZh80PVF+gyooDNXN2cVEde6IB+B67RDCqMxnpc=;
	h=From:To:Cc:Subject:Date:From;
	b=genfpSnSRMS/Adjgjiq1aSnVCTqxvYLToHYFq2UNDzidDLasKpTTFklJvLE+XpmWM
	 OE2q0AgOMIM0M2wv79EFTSSrtvOXTb8hDmbo0d8qYBZifkOlPJgelZgFHfTlTx8HOW
	 FtmMKj94aSVhMQhdpERalJwZ580PGApgREsiME6Q=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drivers/hv: introduce vmbus_channel_set_cpu()
Date: Fri, 10 Jan 2025 16:59:49 -0500
Message-ID: <20250110215951.175514-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I would like to reuse target_cpu_store() within the driver. So, move
most of it's body into vmbus_channel_set_cpu().

Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v2: separate vmbus_channel_set_cpu() changes from
    cpu offlining changes.
---
 drivers/hv/vmbus_drv.c | 52 +++++++++++++++++++++++++-----------------
 include/linux/hyperv.h |  1 +
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2892b8da20a5..001e64fb8d43 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1611,16 +1611,16 @@ static ssize_t target_cpu_show(struct vmbus_channel *channel, char *buf)
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
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
 
-	if (sscanf(buf, "%uu", &target_cpu) != 1)
+	if (vmbus_proto_version < VERSION_WIN10_V4_1)
 		return -EIO;
 
 	/* Validate target_cpu for the cpumask_test_cpu() operation below. */
@@ -1630,22 +1630,17 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
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
@@ -1660,7 +1655,6 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	 * Note.  The host processes the channel messages "sequentially", in
 	 * the order in which they are received on a per-partition basis.
 	 */
-	mutex_lock(&vmbus_connection.channel_mutex);
 
 	/*
 	 * Hyper-V will ignore MODIFYCHANNEL messages for "non-open" channels;
@@ -1668,17 +1662,17 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
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
@@ -1708,9 +1702,25 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
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


