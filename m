Return-Path: <linux-hyperv+bounces-3690-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7D1A12DDF
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 22:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1C13A4D1C
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74341DAC9C;
	Wed, 15 Jan 2025 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KkZ0jl2y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4967C1D61B7;
	Wed, 15 Jan 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977395; cv=none; b=ZAOEBfCegrMuqa0imzJg4pwc5sF1kpXYkMm15CYBlwQ2ajywEQIKtUUag7Bemg2jqpKaTl5QEV6B782QkzRuqbftN37uABiNrOsT3e3v14/6bJW+s+o4NTo6GrlBNLQFhw5OlbiG+gKUBcBMuWvXiLexB9oZtjmunFQd7rASCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977395; c=relaxed/simple;
	bh=dZSQ4sM6EjdQbV0B/bB4NHAPrinVGMw3NkiqLUx0yQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPer7i8DRRY794lzVkAOkR+mRz9WgSQ1mAiCGAoxLTXzZ2WHnhWVRzswlvI3dC2TDMwwOcMFS0hZf93kSKrVR7Qx8gYjN2U2GS91v1Geu9Tm0gf7ocjiw7fUQMcKLs744kUgr0w3I7dAr4U5koaaco97H/oQmtEhX2xOIUO5zeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KkZ0jl2y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.corp.microsoft.com (bras-base-toroon4332w-grc-60-142-114-100-59.dsl.bell.ca [142.114.100.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2AAF42043F21;
	Wed, 15 Jan 2025 13:43:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2AAF42043F21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736977393;
	bh=9H7HPLjLJvXQjg3wqMJ0Tj4+R9QjGLbBsj8ckraGB7M=;
	h=From:To:Cc:Subject:Date:From;
	b=KkZ0jl2yvPAd2N5i3Gt734pbKodLlEj86q0NJ0K66BS6dSU+mE3Qqz8ZwG3E2d8eG
	 OK5T2GvL6eVZc59XLkby9slCtoxiaXlHVhZXFm5IGXiNsH3uVVUIQC+91Yij4f8vrU
	 zW0Lsknbi8FmZiYNjXS6rOzWCV78oKRemoY3iUPo=
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
Subject: [PATCH v3 1/2] drivers/hv: introduce vmbus_channel_set_cpu()
Date: Wed, 15 Jan 2025 16:43:04 -0500
Message-ID: <20250115214306.154853-1-hamzamahfooz@linux.microsoft.com>
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


