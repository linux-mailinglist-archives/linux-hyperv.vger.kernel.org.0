Return-Path: <linux-hyperv+bounces-2875-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0FE9600F5
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 07:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A157B22A8C
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 05:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F2A54648;
	Tue, 27 Aug 2024 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oXzKgh7X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09F49450;
	Tue, 27 Aug 2024 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735800; cv=none; b=Qx3VsuBLTHgKPfj7ADAxcjfSBe9gD8LbDi8kzNZ04s5SX2lAV102klN0N0r0fi30nys69LqtbGvBX1IHYkusJ+FQ+vHbFyecoqY8kca7n0tFatvPML8tS/Ga+etJz/p5pg1vlQHV8mkLiLOVdiI+XVPuXq5Ru1VxdlyopmGeKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735800; c=relaxed/simple;
	bh=K+GmY4gdcn7uAYZPeaBQygIXA8pVBbxuLeRLl3Cz9HA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gN2CfvzFoap/1byLKJb1CyLa/dKHxk4icNeoAf7jFwTo/7YYALjYGrwZqM3RVZK0xkuUoQTT9e1RdPOmOWRvY/Y9xctdwAIQs5f92bedy66IvR+byDiSXg9HciV5nSwiV+BMAD17h83XPoi1HzqI4O2MwAbOQazEzCIZXJI/c7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oXzKgh7X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 86F7C20B7165; Mon, 26 Aug 2024 22:16:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86F7C20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724735798;
	bh=KhV9yigjdRhu5Msq5dP4Yrc+yBo/M/rjxpLcEAj8cSQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oXzKgh7XwbflA9IbBEd9Tm8Nux2CDIdM6Xtt7N3GNbA4J8AUz5tom6VoZsaSh2zAs
	 PzDhd/3DCTYW+3aLihuFtCH5fKUU1HIZ42Gp+kJHuGMAa4Sa2O/r2dN6Jbi5DXoInH
	 PQ+8+Xu4hZlEonQovM/auCrm/sxDHE5souIDjNdE=
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
Subject: [PATCH v4] net: netvsc: Update default VMBus channels
Date: Mon, 26 Aug 2024 22:16:31 -0700
Message-Id: <1724735791-22815-1-git-send-email-ernis@linux.microsoft.com>
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
on number of vCPUs. For greater than 16 vCPUs,
set the channels to maximum of VRSS_CHANNEL_DEFAULT and
number of physical cores / 2 which is returned by
netif_get_num_default_rss_queues() as a way to optimize CPU
resource utilization and scale for high-end processors with
many cores.
Maximum number of channels are by default set to 64.

Based on this change the channel creation would change as follows:

-----------------------------------------------------------------
| No. of vCPU |  dev_info->num_chn |    channels created        |
-----------------------------------------------------------------
|    1-16     |        16	   |          vCPU              |
|    >16      |  max(16,#cores/2)  | min(64 , max(16,#cores/2)) |
-----------------------------------------------------------------

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
Changes in v4:
* Update commit message for channels created
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


