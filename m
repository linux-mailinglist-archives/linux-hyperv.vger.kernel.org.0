Return-Path: <linux-hyperv+bounces-3695-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93918A13B08
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 14:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D94164286
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B831F3D22;
	Thu, 16 Jan 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jYPn2l7N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225816DCE1;
	Thu, 16 Jan 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034912; cv=none; b=iWHCX3Q2Nnce4XwYtL9SM80Yyr81hPZs2YFkQYSBW3js1/JAm9bi7sHWqJ8Jdhs2rhkrrJuhP7E0Dy4SBn4kURRFVUAh71duKOSgcJP1X4OGjR4XEXaQtyBMPMnoc/H/BFAD1pXIyt1KlmJVmq8NSTeNC+p03mPkDA+IoWSr3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034912; c=relaxed/simple;
	bh=dZSQ4sM6EjdQbV0B/bB4NHAPrinVGMw3NkiqLUx0yQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQxijnslqwdFHDWGh+9Qc+U3XDo1YnPVJza0D8EKJHOmEKwZceseUkaYZPtBJ8ZUysYO1NEfzQKr8qXNY47+xgDm9p8J9nt5WCMLUxU8jVSpCBYVAl2TfNZQDJd6bmW1ivoQSx/h6ofgNkloM0nKsCgmr/OM9WE2e6UNCNroiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jYPn2l7N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.lan (bras-base-toroon4332w-grc-51-184-146-177-43.dsl.bell.ca [184.146.177.43])
	by linux.microsoft.com (Postfix) with ESMTPSA id D243B203E393;
	Thu, 16 Jan 2025 05:41:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D243B203E393
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737034910;
	bh=9H7HPLjLJvXQjg3wqMJ0Tj4+R9QjGLbBsj8ckraGB7M=;
	h=From:To:Cc:Subject:Date:From;
	b=jYPn2l7Ny7Ng2SU2DcqqFGbZfDmvN2L3bF2UG7bKR4Wa2E7B775z7KwqMkmz0lD0j
	 8Nf2FUH53KXEMOI7YegrzIrsT/EmE71RcLyu4K+8YTSIWsnE3S0FFjv2sQMfga2oMP
	 IgqVKReVhn3/jL2YDXRDVZUHmkk/ScI0HHCp4AXc=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] drivers/hv: introduce vmbus_channel_set_cpu()
Date: Thu, 16 Jan 2025 08:41:34 -0500
Message-ID: <20250116134136.66749-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core functionality in target_cpu_store() is also needed in a
subsequent patch for automatically changing the CPU when taking
a CPU offline. As such, factor out the body of target_cpu_store()
into new function vmbus_channel_set_cpu() that can also be used
elsewhere.

No functional change is intended.

Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Michael Kelley <mhklinux@outlook.com>
Cc: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v2: separate vmbus_channel_set_cpu() changes from
    cpu offlining changes.

v3: address comments from Michael.
---
 drivers/hv/vmbus_drv.c | 50 +++++++++++++++++++++++++-----------------
 include/linux/hyperv.h |  1 +
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2892b8da20a5..0ca0e85e6edd 100644
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
+	cpus_read_lock();
+	mutex_lock(&vmbus_connection.channel_mutex);
+	ret = vmbus_channel_set_cpu(channel, target_cpu);
 	mutex_unlock(&vmbus_connection.channel_mutex);
 	cpus_read_unlock();
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


