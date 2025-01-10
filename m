Return-Path: <linux-hyperv+bounces-3668-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C57A09D85
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 23:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611C916B82C
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E0217645;
	Fri, 10 Jan 2025 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EmMv65Q9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3387B20A5FC;
	Fri, 10 Jan 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546423; cv=none; b=G5jHCKbZIO9VqWnLmV7UwDEj4017xDy3qkHcRa6A93nQgqFdSmj8R/tCaxgICMOrqPhtJYZWko6YrnafXbRuVdWPBsU2yJ91P4LBI92j4fgH/liS5J6wuEQ5bxYmjUbPNgiIKwJr4j0SfQmT9sjTlHz/jiWmYtrfUIT7UIEE2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546423; c=relaxed/simple;
	bh=v+87oWw0Kf1K4lIaRZz9+j44OT1IvaNXYSuiOO4pxSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAJKebChEoEJmyhpiMOR7B2LhOedpx1K5rOoW/Vxao/nIQUnWnH2zPceNKiA8Srs32EIY7NdPmbstP4Dt5im7W2H7RSO/+9H0E2e9r0DMMKCAGr81rQ558N24nLaDzG3I6wcpQ9O/9+vEV56jJLpxbLlRBdZ7Yx707Iv7fgLbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EmMv65Q9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.lan (unknown [174.88.132.51])
	by linux.microsoft.com (Postfix) with ESMTPSA id 43FEF203D5F4;
	Fri, 10 Jan 2025 14:00:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43FEF203D5F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736546421;
	bh=pYCy6YL6mypQ6gQcZhMfiCbqGJlvNiDrOl88NQZ5Jyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmMv65Q9jHGDMqevRm4520eRMY10pCo/eiHwrTpkDnLJlp/i26qmvcYUuI1LHIWuQ
	 c8vyg3BsK7wFVOazbj74a3AebcEapnNZRzZ2Glochv4YqJa6Qij80Rc73FfsbNZbe8
	 SJbWmzWlTZDWpr9yTbPHBwltzL9fB9KWwFFcbmGI=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drivers/hv: add CPU offlining support
Date: Fri, 10 Jan 2025 16:59:50 -0500
Message-ID: <20250110215951.175514-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110215951.175514-1-hamzamahfooz@linux.microsoft.com>
References: <20250110215951.175514-1-hamzamahfooz@linux.microsoft.com>
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
v2: remove cpus_read_{un,}lock() from hv_pick_new_cpu() and add
    lockdep_assert_cpus_held().
---
 drivers/hv/hv.c | 56 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 36d9ba097ff5..9fef71403c86 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -433,13 +433,39 @@ static bool hv_synic_event_pending(void)
 	return pending;
 }
 
+static int hv_pick_new_cpu(struct vmbus_channel *channel,
+			   unsigned int current_cpu)
+{
+	int ret = 0;
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
+	cpu = cpumask_next(get_random_u32_below(nr_cpu_ids), cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids || cpu == current_cpu)
+		cpu = VMBUS_CONNECT_CPU;
+
+	ret = vmbus_channel_set_cpu(channel, cpu);
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
@@ -456,31 +482,31 @@ int hv_synic_cleanup(unsigned int cpu)
 
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
@@ -497,5 +523,5 @@ int hv_synic_cleanup(unsigned int cpu)
 
 	hv_synic_disable_regs(cpu);
 
-	return 0;
+	return ret;
 }
-- 
2.47.1


