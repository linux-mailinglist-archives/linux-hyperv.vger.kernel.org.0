Return-Path: <linux-hyperv+bounces-3691-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B790A12DE1
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 22:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9B83A55D7
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B41DB54C;
	Wed, 15 Jan 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d1XjhYql"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1D1D90DF;
	Wed, 15 Jan 2025 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977396; cv=none; b=RHfRAg/7FqMxsaE4AQXyrAEPfvv17lPaEpe40JxN7+dW9TDjAFVEn+z8+kypJZ95UO4VrUeb70S1ypn0Nu+KqJ52RNjRmDpqfQMJUcFgax/8AlMne3XZ5/ErM/xJyRf0IAsycrQBngz3S1Q7SyYu7NtCh422yr5FwDWGTY3+Bdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977396; c=relaxed/simple;
	bh=zliBYaX1+SJV3ejOtE7WUmLI9TXmkGVwCuzsY2XmqXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW4rUXmLkB2PCyzR44o/vsE7ozUIzDEwgY67KRmxFj6PgrTWtg8lBhxwzBCYq/CCdZVWwJqAKVEynwXdMxJG9E6gA5woG7/DXOqSunC/XQI1+y7RqNiPdHdAWK+GNhWS0aDBvAoO6dw2XAXEtaojnVqSTG7dmcHQVWP810DKrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d1XjhYql; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.corp.microsoft.com (bras-base-toroon4332w-grc-60-142-114-100-59.dsl.bell.ca [142.114.100.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A29C2043F3A;
	Wed, 15 Jan 2025 13:43:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A29C2043F3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736977394;
	bh=7W6g0D7EEwQGVQYv1brgiZfx1SuP02CAVaq9EcBMw9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1XjhYqlhKpL2/Av8ajFsx+/R0GrLrSNKr8q+Jhht5otgSBv4X15hSTqktDkYAsnx
	 dxdJuJ18mFqlqX9Lkr+cbRXfSz4LWqBWQJE1zOB0sywRmsYpUu7ZV6QaXeW+sFOI1v
	 aj5PpanlL2zOqBCWG3MyMWGiFA0/FurRLKFpERNY=
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
Subject: [PATCH v3 2/2] drivers/hv: add CPU offlining support
Date: Wed, 15 Jan 2025 16:43:05 -0500
Message-ID: <20250115214306.154853-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115214306.154853-1-hamzamahfooz@linux.microsoft.com>
References: <20250115214306.154853-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it is tedious to offline CPUs. Since, most CPUs will have
vmbus channels attached to them that a user would have to manually
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
---
 drivers/hv/hv.c | 63 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 36d9ba097ff5..f120b808258f 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -433,13 +433,46 @@ static bool hv_synic_event_pending(void)
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
+	for_each_cpu_wrap(cpu, cpu_online_mask,
+			  get_random_u32_below(nr_cpu_ids)) {
+		if (cpu == current_cpu || cpu == VMBUS_CONNECT_CPU)
+			continue;
+
+		ret = vmbus_channel_set_cpu(channel, cpu);
+
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
@@ -456,31 +489,31 @@ int hv_synic_cleanup(unsigned int cpu)
 
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
@@ -497,5 +530,5 @@ int hv_synic_cleanup(unsigned int cpu)
 
 	hv_synic_disable_regs(cpu);
 
-	return 0;
+	return ret;
 }
-- 
2.47.1


