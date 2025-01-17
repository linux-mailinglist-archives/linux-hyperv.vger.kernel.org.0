Return-Path: <linux-hyperv+bounces-3715-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0892A158A9
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 21:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9C4162C44
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 20:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568E51ACEB5;
	Fri, 17 Jan 2025 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EF9DmaFw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D91AA786;
	Fri, 17 Jan 2025 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146018; cv=none; b=Bf+liW66iRVVu/SEAHsEBIgJFf3/Xydb3+UzSmfWnZLhPY8RmhU/iTO7eW+K73jB0hCNlac3OvfYLwI3BrZ9PcGn06CKSKYBZ3m88qkCPSU2FNfGpYw9djIvKXeRxTUKww554RuVRmankd+qSukSaJB8gCI2OGnU024jrSjzrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146018; c=relaxed/simple;
	bh=U5Kf/ympl+smnpRLNyuWvJZnbFjuNH7YNuo24866jKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dez/08K1/arvjIu4vDOxPSftE8ieFSMYgaoYjYoeIJyTR77eyeZ8j+f+gEirplf9ONyYeCqSrrlENdeSck+Zb9Iyn3oI2T57NW2o3YBveAyD/15bCdOdEjtAUQTfp+COV8KSR+CUVSsrWGHB12jTivRd/hi4J31/j/mCiAGx96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EF9DmaFw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.lan (bras-base-toroon4332w-grc-51-184-146-177-43.dsl.bell.ca [184.146.177.43])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95FA620591BD;
	Fri, 17 Jan 2025 12:33:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95FA620591BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737146016;
	bh=yTF/82LIvWuCYFP53TAPjjrfrUi9Orx7uAVK1s6EEmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EF9DmaFwBK15Y7WaL5rUBDKdCpLcgL3t4gh50FZiMpxV7UGTezC3HcZXNttkWLM+Z
	 gG/5ZfienCXN1NtNw76aL7As0VC17nS4H0Btjcej/RZWjXg6MZKLlGRjedr6qDkx4X
	 K/I08r9C8LSqhvlaLnINClJEZJbWcoEXy6R0Lo88=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] drivers/hv: add CPU offlining support
Date: Fri, 17 Jan 2025 15:33:08 -0500
Message-ID: <20250117203309.192072-3-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
References: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it is tedious to offline CPUs in a Hyper-V VM since CPUs may
have VMBus channels attached to them that a user would have to manually
rebind elsewhere. So, as made mention of in
commit d570aec0f2154 ("Drivers: hv: vmbus: Synchronize init_vp_index()
vs. CPU hotplug"), rebind channels associated with CPUs that a user is
trying to offline to a new "randomly" selected CPU.

Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Michael Kelley <mhklinux@outlook.com>
Cc: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v2: remove cpus_read_{un,}lock() from hv_pick_new_cpu() and add
    lockdep_assert_cpus_held().

v3: use for_each_cpu_wrap() in hv_pick_new_cpu().

v4: store get_random_u32_below() in start.

v5: style fixes, use target_cpu and set ret to -EBUSY by default.
---
 drivers/hv/hv.c | 72 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 36d9ba097ff5..fab0690b5c41 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -433,13 +433,47 @@ static bool hv_synic_event_pending(void)
 	return pending;
 }
 
+static int hv_pick_new_cpu(struct vmbus_channel *channel)
+{
+	int ret = -EBUSY;
+	int start;
+	int cpu;
+
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
+
+	/*
+	 * We can't assume that the relevant interrupts will be sent before
+	 * the cpu is offlined on older versions of hyperv.
+	 */
+	if (vmbus_proto_version < VERSION_WIN10_V5_3)
+		return -EBUSY;
+
+	start = get_random_u32_below(nr_cpu_ids);
+
+	for_each_cpu_wrap(cpu, cpu_online_mask, start) {
+		if (channel->target_cpu == cpu ||
+		    channel->target_cpu == VMBUS_CONNECT_CPU)
+			continue;
+
+		ret = vmbus_channel_set_cpu(channel, cpu);
+		if (!ret)
+			break;
+	}
+
+	if (ret)
+		ret = vmbus_channel_set_cpu(channel, VMBUS_CONNECT_CPU);
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
@@ -456,38 +490,34 @@ int hv_synic_cleanup(unsigned int cpu)
 
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
+			ret = hv_pick_new_cpu(channel);
+			if (ret) {
+				mutex_unlock(&vmbus_connection.channel_mutex);
+				return ret;
+			}
 		}
 		list_for_each_entry(sc, &channel->sc_list, sc_list) {
 			if (sc->target_cpu == cpu) {
-				channel_found = true;
-				break;
+				ret = hv_pick_new_cpu(sc);
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
-	 * channel_found == false means that any channels that were previously
-	 * assigned to the CPU have been reassigned elsewhere with a call of
-	 * vmbus_send_modifychannel().  Scan the event flags page looking for
-	 * bits that are set and waiting with a timeout for vmbus_chan_sched()
-	 * to process such bits.  If bits are still set after this operation
-	 * and VMBus is connected, fail the CPU offlining operation.
+	 * Scan the event flags page looking for bits that are set and waiting
+	 * with a timeout for vmbus_chan_sched() to process such bits. If bits
+	 * are still set after this operation and VMBus is connected, fail the
+	 * CPU offlining operation.
 	 */
 	if (vmbus_proto_version >= VERSION_WIN10_V4_1 && hv_synic_event_pending())
 		return -EBUSY;
@@ -497,5 +527,5 @@ int hv_synic_cleanup(unsigned int cpu)
 
 	hv_synic_disable_regs(cpu);
 
-	return 0;
+	return ret;
 }
-- 
2.47.1


