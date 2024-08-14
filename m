Return-Path: <linux-hyperv+bounces-2770-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0028952098
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2024 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894731F26B2E
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2024 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECB81BA89F;
	Wed, 14 Aug 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SAJAWG7R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EBF1BA89E;
	Wed, 14 Aug 2024 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654769; cv=none; b=UqUqTE1cn+P4tABi+RjGtoeGymTqz43ZQIJJY3zKKvVay2BaueKXwVf2VOLoot9HqcwQT/WUMg3/q2p8UP5Mthwh+2xwaSpcY6y/dywAmNAmQ7El/1czQwkNN7k/xfX3ITQV8vW+4eDdkC6tzRGdnWPoCIw/P404v0tS9igPoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654769; c=relaxed/simple;
	bh=3tixV3WjGgp87ZeMb9WjMapZ505Q91KHJwVRt/00kcM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=m0Qs7I0mgmaAEKQy1oYFQO7yuzq+UhJxJNaVuRR978ujlALJsbKDoX3NFHnSqDk7KPyyfUBt8Cutljcu0huakEaORgtIYCyGgMeMF+5blLO7gqEc+zp1BShXUUMuBKLD2OsXaDBid/aDuNFl7ZIF4xAvdvfQdoO9bRco7cZi1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SAJAWG7R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 0ED5920B7165; Wed, 14 Aug 2024 09:59:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0ED5920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723654768;
	bh=9JfNdR6IgOiyBx2j6AdoRucmLgCCle9cw5s2e9ZyDs4=;
	h=From:To:Cc:Subject:Date:From;
	b=SAJAWG7Regm7Nc44e+uZTwi3mPGH9zfpo5PCFK4B7RnLLbY6CczXvIeD1pzK/EmNQ
	 W0kq9uYB9plcuM6xkL9F5ggFLIzY+cAPihRX/jpjuA6/sVWjGY2a8vg59rgX+ZqK7c
	 54ODQY0TT/KI3cUYWPwJC9KtUVbD06Q5l7G6abqU=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH v2] net: netvsc: Update default VMBus channels
Date: Wed, 14 Aug 2024 09:59:13 -0700
Message-Id: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
Linux netvsc from 8 to 16 to align with Azure Windows VM
and improve networking throughput.

For VMs having less than 16 vCPUS, the channels depend
on number of vCPUs. Between 16 to 32 vCPUs, the channels
default to VRSS_CHANNEL_DEFAULT. For greater than 32 vCPUs,
set the channels to number of physical cores / 2 as a way
to optimize CPU resource utilization and scale for high-end
processors with many cores.
Maximum number of channels are by default set to 64.

Based on this change the subchannel creation would change as follows:

-------------------------------------------------------------
|No. of vCPU	|dev_info->num_chn	|subchannel created |
-------------------------------------------------------------
|  0-16		|	16		|	vCPU	    |
| >16 & <=32	|	16		|	16          |
| >32 & <=128	|	vCPU/2		|	vCPU/2      |
| >128		|	vCPU/2		|	64          |
-------------------------------------------------------------

Performance tests showed significant improvement in throughput:
- 0.54% for 16 vCPUs
- 0.83% for 32 vCPUs
- 1.76% for 48 vCPUs
- 10.35% for 64 vCPUs
- 13.47% for 96 vCPUs

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v2:
* Set dev_info->num_chn based on vCPU count
---
 drivers/net/hyperv/hyperv_net.h | 2 +-
 drivers/net/hyperv/netvsc_drv.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 810977952f95..e690b95b1bbb 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -882,7 +882,7 @@ struct nvsp_message {
 
 #define VRSS_SEND_TAB_SIZE 16  /* must be power of 2 */
 #define VRSS_CHANNEL_MAX 64
-#define VRSS_CHANNEL_DEFAULT 8
+#define VRSS_CHANNEL_DEFAULT 16
 
 #define RNDIS_MAX_PKT_DEFAULT 8
 #define RNDIS_PKT_ALIGN_DEFAULT 8
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 44142245343d..e32eb2997bf7 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -27,6 +27,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/netpoll.h>
 #include <linux/bpf.h>
+#include <linux/cpumask.h>
 
 #include <net/arp.h>
 #include <net/route.h>
@@ -987,7 +988,9 @@ struct netvsc_device_info *netvsc_devinfo_get(struct netvsc_device *nvdev)
 			dev_info->bprog = prog;
 		}
 	} else {
-		dev_info->num_chn = VRSS_CHANNEL_DEFAULT;
+		int count = num_online_cpus();
+
+		dev_info->num_chn = (count < 32) ? VRSS_CHANNEL_DEFAULT : DIV_ROUND_UP(count, 2);
 		dev_info->send_sections = NETVSC_DEFAULT_TX;
 		dev_info->send_section_size = NETVSC_SEND_SECTION_SIZE;
 		dev_info->recv_sections = NETVSC_DEFAULT_RX;
-- 
2.34.1


