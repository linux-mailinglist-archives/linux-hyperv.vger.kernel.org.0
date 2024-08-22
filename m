Return-Path: <linux-hyperv+bounces-2797-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830895B949
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 17:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF112842EB
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983CC1CBE94;
	Thu, 22 Aug 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fEhz7fCP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4A21CB31B;
	Thu, 22 Aug 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339182; cv=none; b=qRd8ipXYcPIKnEcAJljpGaOeQX9jRizQ8kivvih3IpZkq3uAVY9l8hzEjXNCiHEncBk9KCVXLwB/QIS6OuXrpCMRxbZaO/yD8IPJPqrhxqcIjZqRsUDjT2Zd32AS5HFag3tnO9jU9OjE9XxZCekyRoNYNoLHEm00quqI/lrbvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339182; c=relaxed/simple;
	bh=w1WMQAnyWSzskX4164UJpPQqWq1VBFOrPzKkXmke+zQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Q740wfHk9pb5ay21XAcyMzw4+VyrLHGzM1zIkfdJJLMtyMz3qlV+JH7efawuUZyeKzBeSFv4Gu2TG7mX/wXXZbfWnuuSHEnbpCngFtlPAX6Uwv6LxDriT+GLsuc8xqB3ReSCP818lh4e2GOd4LTU3IECOQAXWJsG+eg2uMrkLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fEhz7fCP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id AC4E120B7165; Thu, 22 Aug 2024 08:06:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC4E120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724339180;
	bh=rd7R630toxj6aIKFFnZEA9j1f3Unx/sdBFKbopGVCek=;
	h=From:To:Cc:Subject:Date:From;
	b=fEhz7fCP2j5Gc9JGK8Dn9aiz9aKFz6DKnoy7VBmhXp1WkacarqJX540jBN9L3o16d
	 pGw9SEZw8m3JcQuo2PN5q4ygpjcn+J92UvQswlLDkWMovP04GjMVsbo6Ic2g6ctIDV
	 r4mPJIanrGpFQxXWAEDgBlIOQUEnXoF8xaYJJ3mM=
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
Subject: [PATCH v3] net: netvsc: Update default VMBus channels
Date: Thu, 22 Aug 2024 08:06:08 -0700
Message-Id: <1724339168-20913-1-git-send-email-ernis@linux.microsoft.com>
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
on number of vCPUs. Between 16 to 64 vCPUs, the channels
default to VRSS_CHANNEL_DEFAULT. For greater than 64 vCPUs,
set the channels to number of physical cores / 2 returned by
netif_get_num_default_rss_queues() as a way to optimize CPU
resource utilization and scale for high-end processors with
many cores. Due to hyper-threading, the number of
physical cores = vCPUs/2.
Maximum number of channels are by default set to 64.

Based on this change the channel creation would change as follows:

-------------------------------------------------------------
| No. of vCPU	|  dev_info->num_chn	| channels created  |
-------------------------------------------------------------
|  0-16		|       16		|       vCPU        |
| >16 & <=64	|       16		|       16          |
| >64 & <=256	|       vCPU/4		|       vCPU/4      |
| >256		|       vCPU/4		|       64          |
-------------------------------------------------------------

Performance tests showed significant improvement in throughput:
- 0.54% for 16 vCPUs
- 0.83% for 32 vCPUs
- 0.86% for 48 vCPUs
- 9.72% for 64 vCPUs
- 13.57% for 96 vCPUs

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
Changes in v3:
* Use netif_get_num_default_rss_queues() to set channels
* Change terminology for channels in commit message
---
Changes in v2:
* Set dev_info->num_chn based on vCPU count.
---
 drivers/net/hyperv/hyperv_net.h | 2 +-
 drivers/net/hyperv/netvsc_drv.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
index 44142245343d..a6482afe4217 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -987,7 +987,8 @@ struct netvsc_device_info *netvsc_devinfo_get(struct netvsc_device *nvdev)
 			dev_info->bprog = prog;
 		}
 	} else {
-		dev_info->num_chn = VRSS_CHANNEL_DEFAULT;
+		dev_info->num_chn = max(VRSS_CHANNEL_DEFAULT,
+					netif_get_num_default_rss_queues());
 		dev_info->send_sections = NETVSC_DEFAULT_TX;
 		dev_info->send_section_size = NETVSC_SEND_SECTION_SIZE;
 		dev_info->recv_sections = NETVSC_DEFAULT_RX;
-- 
2.34.1


