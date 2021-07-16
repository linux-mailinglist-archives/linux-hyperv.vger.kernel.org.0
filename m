Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2C3CB082
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 03:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhGPBkq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 21:40:46 -0400
Received: from mail-bn7nam10on2123.outbound.protection.outlook.com ([40.107.92.123]:62240
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230388AbhGPBkn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 21:40:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJE9r+yYvoCVnVZpdpKziYtV1Vr5mQXZMylLolNB6iUeaPx1mfDPUs5H4E7EB2HJyvCXYVFHh1YgC2/2yj8rpRxRl0Ty/jZ5Z5wdq7+imKjXk50JHm+pIx+T2LaEM6amKGkewo76tK5tWtk8hLR1/90FR/W8NfibrEOO9K+rUVHWhFyOmNjUI22vW1/QAqoA/Jqa2fN2dfCzzpI0tzPe6HbhqDdMCQqoP+DSJDHOx6toZuU/T94pWgzTNt2I2h7yfkAXAFWwfWVLbMGWf4/DLFEEMTWdXrUi46m/7++UPSryyT5/kcl9FXXGVmOAYAUY/7sT3I4K0PgslaIzeAZiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPka710Q6MYRSP7biJtP3y/uYPGtDqKxJb2VPOD4Yj4=;
 b=C7xg6LWXdZaUbGWBZkpN198uB1KEgy8Qz3nWx80cLnK50TpFgkWFo2DWcFceFTwVL4MTllflm+I3zZZCC7+7xtzcb/S2auCS1BXUqVGrKCzElK748wv7F8o6cEr4JpYIkaDbmb9U7JTF55T8zOvGX3CQ4eafZkR8u3PifRc5FSrNaGHEchOoZD9v4qE7JePXCbiENHLR+QwADQYJ1xmjg8aWJQadC6rpXSw3OsKD2pFnQsQkuge9fgJc5bkEXmK5Mwmvz81aE3FYzbTP8zizRZjRKjJFlgI8CwoqCrfyTK/Fa8079N/g2Ky0opFPJB2oU5rg1FbRFTNn380O5iBEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPka710Q6MYRSP7biJtP3y/uYPGtDqKxJb2VPOD4Yj4=;
 b=XCLrqIFw4fQpMhtC4FJ8K1shfWnKNsUAjz2l/tpbSO7XTq2exlhcXytWqIBNtRZBw9tLPaJC8IiAzjYwpLqj8AfSSYw4Iv7wLDfUNoRNfciX6uEsMLwzq4c75N0Kq8ZzjOMG3Gwq1pDGocTDXC9zDj9DBcCW0eCj/7KIrd33z7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1340.namprd21.prod.outlook.com (2603:10b6:5:175::19)
 by DM5PR21MB0748.namprd21.prod.outlook.com (2603:10b6:3:a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8; Fri, 16 Jul
 2021 01:37:46 +0000
Received: from DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::7840:718a:c75:9760]) by DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::7840:718a:c75:9760%8]) with mapi id 15.20.4352.012; Fri, 16 Jul 2021
 01:37:46 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2,hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU assignments within a device
Date:   Thu, 15 Jul 2021 18:37:38 -0700
Message-Id: <1626399458-23990-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:300:6c::15) To DM6PR21MB1340.namprd21.prod.outlook.com
 (2603:10b6:5:175::19)
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR04CA0053.namprd04.prod.outlook.com (2603:10b6:300:6c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 01:37:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 442696de-7fa1-4921-9da9-08d947fa501a
X-MS-TrafficTypeDiagnostic: DM5PR21MB0748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB074858550074260A40A11C65AC119@DM5PR21MB0748.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYSaPQgujms9HfAHdnYPnfZ7aP65E9UieeGOncLFMjZmpIED/yem2PowScgobWdWT/VN5IdE3gsbfqx0iEEhEtiNjP8zoR+OxRzws3ySsNTSo0GJtdpeL/4zAdNxzk/14qDSC7hZqMbTJFeaesaz4hR02ezwzmE4WlYLGczTnjTiWN/vHsBAKErFSsYS5F1BG7SoGqUuDIOdiRrPaJRgmX4kohtlJ0obuLSZT8Imkoc4SDLMSHU+h6YnOgk7UNAlQMQWxDrJS+UcpO/YQepp+OT1ajeiuHWYS2r6mXJGMWdVRIlck6XSyhC3G6NGLj9ttaDACzEy8KrIXxWuXyI9aHNcSqC2zNrEqrNxAa5zWSXhx4T4pTmSttFKSPNGh1bpTwHHyMByrZ5LWrunxxHhbVTj2iFkH6YmE/YSl3WprKabQltNDYuwdVWGSdQR0qzP5CUYHT0MvP9yxJQ9BHsCg+ju8jR1J7IBTShVJ/Rgl8RGuerWdBJ4atTi5cPEsvdw9SuvDwSBmSnuH+cMVUnpT8XQFF6y7Iry8gM1vEAu7QZfCcGpo0dzWR/V7LwJZb3sNkS+mABajB8hycm27Jxq9sUlKZpJA8ZrDaMMejzxzTv0QwZLX2PwxDojG4sbuGHOM2DF7z260f5zZ+rabFRH3RjYK21rJOj+AEZu2pOPmwEZxV1rNLKTyIYzTAYtnKaG/wgE5hN/tBsanfkDHCla4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1340.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6512007)(2906002)(6506007)(5660300002)(2616005)(450100002)(83380400001)(26005)(186003)(956004)(478600001)(8936002)(8676002)(66946007)(38100700002)(7846003)(6666004)(36756003)(10290500003)(6486002)(38350700002)(82960400001)(82950400001)(52116002)(6916009)(66476007)(4326008)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KvCR4XdIoWIQEaj4zFmxQ8cMZpfUVT/lOP1b1Z7r1NgY9NGrVMlWL8Uk03hH?=
 =?us-ascii?Q?zssNupjBNZ3l0xDx3c6hLwoChfPR6GCyTdA4fqU3XBEsjyEnXRuvrvgh3wwj?=
 =?us-ascii?Q?3rFDEqgair/YB5xXIXtaQwgnUpkLilnQzuMsYMU4018EYCvEaSl5yFog1RXZ?=
 =?us-ascii?Q?VH20rq1+xn6P6MqvsvHfXixV4+2IqKbyIk/gWeysHPFhbB55DiQxUa8FTjcF?=
 =?us-ascii?Q?O8d/pxln4cCcnQ6F3AfDpOLijPlPffiqR2Zd6QyFmNKHcGqLOrd7d9Jo4rpY?=
 =?us-ascii?Q?vRIBuJPA+PQie9/uWH8Z10zXcBrsour7Saunx9XXR5JYvZfOZOl14RtPyw5r?=
 =?us-ascii?Q?XRimMJhpFB249kb0wYQJxI0NdR6lLeWhTvzaKRCBm/QTrRyh3MlVxEs+6Ar0?=
 =?us-ascii?Q?UdpYkFSnMhq5pQR0wSnX9euQfgRGghkrF5SeR2seISU7v/YrayVKwVZ53zmh?=
 =?us-ascii?Q?tjAbh5xAPIfDHCq3bGBjQN3LP2ladQ4m5dRNFW765pGWV0ODlKJKF/csay3L?=
 =?us-ascii?Q?jqGDiBPCU52JH1oxf/0/CaIz/+j/RRmlxvDmwpci1CvOxJ12ieGIKPCZFBQU?=
 =?us-ascii?Q?sl/94Q/uB7hOC3L+kummVjI54ieZWsLNdqvlR33GTlk7brn6YZVfWHPFpdT2?=
 =?us-ascii?Q?M9oDyM+5+nsccF/0JKzUKPgAlz+qWp+gViAiuq6WLRSRPKTZDl+ODooB7f2S?=
 =?us-ascii?Q?os60dg3jtmFZ02tl0lvYmJ5AtanM4Bswjp6jWcQftnNdjFOkCIkOiZEr9vSl?=
 =?us-ascii?Q?q9WDghoz61IfWECXri3UuMWe21tJvr7ruT05AaX3GNX+B+F09b6hR82Y1C6Y?=
 =?us-ascii?Q?6z1/DZB5oFa9+BoEC/oxRzQNVAiMYv8moC4ZurxPIFhTm8tvRGT/9494zLEG?=
 =?us-ascii?Q?NuRyn5o7/ttGbnYFSv/HZgOjsDmlSJ0eYdly1S8DyVMWspGCYz8odR6IKNG7?=
 =?us-ascii?Q?75st2g/RIDX0cY1qDWK6Qw/44sQW4cHTwmYWYPBg7iIN+eF7yEfEUpfLOEJm?=
 =?us-ascii?Q?bu3hupIoqxc27jjwdIkJeDT+ViXmKmf5JuzSDAym/kaASRlJrflJJ+L8nbT6?=
 =?us-ascii?Q?66eiwHq70s3+Sl1u7rsJUD7YUg4l0WI/0sGmAkzilEY2nu5RZZvxLKS/TId0?=
 =?us-ascii?Q?MKIx4N8G2TqpeZ6qHSHsgGUcoWPdCV906CHP/dDtct+B+IM/3K4lFuXv5HW4?=
 =?us-ascii?Q?38FWwxLdE/Dq9HY1bOqGUt/8yp/p2JCjUTAA0s/H7H0+Ktp5OCtQiTZNAvX5?=
 =?us-ascii?Q?RiDA/l3KBFWWJ2Xp+kvNB120jiyG0UPPxCqZPc/PN6+1EdBI7ccDJ44ZZgVl?=
 =?us-ascii?Q?XlYi+KKeIyANMdf2RMPTF2Ki?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442696de-7fa1-4921-9da9-08d947fa501a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1340.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 01:37:46.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTxNdUh95C896wZDUUey5+IYVZLvssOdOqpbJUqqadzMKPLGD91dTcry9zHKSKJftqy61HO0f9yujMCGmjrsGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0748
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The vmbus module uses a rotational algorithm to assign target CPUs to
device's channels. Depends on the timing of different device's channel
offers, different channels of a device may be assigned to the same CPU.

For example on a VM with 2 CPUs, if NIC A and B's channels are offered
in the following order, NIC A will have both channels on CPU0, and
NIC B will have both channels on CPU1 -- see below. This kind of
assignment causes RSS load that is spreading across different channels
to end up on the same CPU.

Timing of channel offers:
NIC A channel 0
NIC B channel 0
NIC A channel 1
NIC B channel 1

VMBUS ID 14: Class_ID = {f8615163-df3e-46c5-913f-f2d2f965ed0e} - Synthetic network adapter
        Device_ID = {cab064cd-1f31-47d5-a8b4-9d57e320cccd}
        Sysfs path: /sys/bus/vmbus/devices/cab064cd-1f31-47d5-a8b4-9d57e320cccd
        Rel_ID=14, target_cpu=0
        Rel_ID=17, target_cpu=0

VMBUS ID 16: Class_ID = {f8615163-df3e-46c5-913f-f2d2f965ed0e} - Synthetic network adapter
        Device_ID = {244225ca-743e-4020-a17d-d7baa13d6cea}
        Sysfs path: /sys/bus/vmbus/devices/244225ca-743e-4020-a17d-d7baa13d6cea
        Rel_ID=16, target_cpu=1
        Rel_ID=18, target_cpu=1

Update the vmbus CPU assignment algorithm to avoid duplicate CPU
assignments within a device.

The new algorithm iterates num_online_cpus + 1 times.
The existing rotational algorithm to find "next NUMA & CPU" is still here.
But if the resulting CPU is already used by the same device, it will try
the next CPU.
In the last iteration, it assigns the channel to the next available CPU
like the existing algorithm. This is not normally expected, because
during device probe, we limit the number of channels of a device to
be <= number of online CPUs.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 96 ++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 32 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index caf6d0c4bc1b..8584914291e7 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -605,6 +605,17 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	 */
 	mutex_lock(&vmbus_connection.channel_mutex);
 
+	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
+		if (guid_equal(&channel->offermsg.offer.if_type,
+			       &newchannel->offermsg.offer.if_type) &&
+		    guid_equal(&channel->offermsg.offer.if_instance,
+			       &newchannel->offermsg.offer.if_instance)) {
+			fnew = false;
+			newchannel->primary_channel = channel;
+			break;
+		}
+	}
+
 	init_vp_index(newchannel);
 
 	/* Remember the channels that should be cleaned up upon suspend. */
@@ -617,16 +628,6 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	 */
 	atomic_dec(&vmbus_connection.offer_in_progress);
 
-	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
-		if (guid_equal(&channel->offermsg.offer.if_type,
-			       &newchannel->offermsg.offer.if_type) &&
-		    guid_equal(&channel->offermsg.offer.if_instance,
-			       &newchannel->offermsg.offer.if_instance)) {
-			fnew = false;
-			break;
-		}
-	}
-
 	if (fnew) {
 		list_add_tail(&newchannel->listentry,
 			      &vmbus_connection.chn_list);
@@ -647,7 +648,6 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 		/*
 		 * Process the sub-channel.
 		 */
-		newchannel->primary_channel = channel;
 		list_add_tail(&newchannel->sc_list, &channel->sc_list);
 	}
 
@@ -683,6 +683,30 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	queue_work(wq, &newchannel->add_channel_work);
 }
 
+/*
+ * Check if CPUs used by other channels of the same device.
+ * It's should only be called by init_vp_index().
+ */
+static bool hv_cpuself_used(u32 cpu, struct vmbus_channel *chn)
+{
+	struct vmbus_channel *primary = chn->primary_channel;
+	struct vmbus_channel *sc;
+
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
+
+	if (!primary)
+		return false;
+
+	if (primary->target_cpu == cpu)
+		return true;
+
+	list_for_each_entry(sc, &primary->sc_list, sc_list)
+		if (sc != chn && sc->target_cpu == cpu)
+			return true;
+
+	return false;
+}
+
 /*
  * We use this state to statically distribute the channel interrupt load.
  */
@@ -702,6 +726,7 @@ static int next_numa_node_id;
 static void init_vp_index(struct vmbus_channel *channel)
 {
 	bool perf_chn = hv_is_perf_channel(channel);
+	u32 i, ncpu = num_online_cpus();
 	cpumask_var_t available_mask;
 	struct cpumask *alloced_mask;
 	u32 target_cpu;
@@ -724,31 +749,38 @@ static void init_vp_index(struct vmbus_channel *channel)
 		return;
 	}
 
-	while (true) {
-		numa_node = next_numa_node_id++;
-		if (numa_node == nr_node_ids) {
-			next_numa_node_id = 0;
-			continue;
+	for (i = 1; i <= ncpu + 1; i++) {
+		while (true) {
+			numa_node = next_numa_node_id++;
+			if (numa_node == nr_node_ids) {
+				next_numa_node_id = 0;
+				continue;
+			}
+			if (cpumask_empty(cpumask_of_node(numa_node)))
+				continue;
+			break;
+		}
+		alloced_mask = &hv_context.hv_numa_map[numa_node];
+
+		if (cpumask_weight(alloced_mask) ==
+		    cpumask_weight(cpumask_of_node(numa_node))) {
+			/*
+			 * We have cycled through all the CPUs in the node;
+			 * reset the alloced map.
+			 */
+			cpumask_clear(alloced_mask);
 		}
-		if (cpumask_empty(cpumask_of_node(numa_node)))
-			continue;
-		break;
-	}
-	alloced_mask = &hv_context.hv_numa_map[numa_node];
 
-	if (cpumask_weight(alloced_mask) ==
-	    cpumask_weight(cpumask_of_node(numa_node))) {
-		/*
-		 * We have cycled through all the CPUs in the node;
-		 * reset the alloced map.
-		 */
-		cpumask_clear(alloced_mask);
-	}
+		cpumask_xor(available_mask, alloced_mask,
+			    cpumask_of_node(numa_node));
 
-	cpumask_xor(available_mask, alloced_mask, cpumask_of_node(numa_node));
+		target_cpu = cpumask_first(available_mask);
+		cpumask_set_cpu(target_cpu, alloced_mask);
 
-	target_cpu = cpumask_first(available_mask);
-	cpumask_set_cpu(target_cpu, alloced_mask);
+		if (channel->offermsg.offer.sub_channel_index >= ncpu ||
+		    i > ncpu || !hv_cpuself_used(target_cpu, channel))
+			break;
+	}
 
 	channel->target_cpu = target_cpu;
 
-- 
2.25.1

