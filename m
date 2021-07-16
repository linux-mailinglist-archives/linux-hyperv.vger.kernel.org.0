Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A123F3CBBC5
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 20:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhGPSYU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 14:24:20 -0400
Received: from mail-dm6nam11on2102.outbound.protection.outlook.com ([40.107.223.102]:53797
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229462AbhGPSYU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 14:24:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCscsAWq7vIh+GDVVEYW2a3DVaSycZW7iOce3p25uwiQNMx3D4cm9jO8DXO4HKI9b6ZlkEIuv2IU5bixsYj2Lp31nKQWljXpntUuTYpCtAPIJOJ3IqT+cP7mXtnJPPVuWN4deA9AA0FpxJVKu3q31jUwhUCiwes3hVsHgDzIn74InfIfSqgjGFu2dbmIqR4qlgGi0zJ2Kw2GIyEYRYYdH+y877hmsE62VCeARwUPsLzQpyBHvPMnVk5lRk1AnvvqCkX8avYwkDhOz/x2czLO85zN5aQ5m7xHsHTrLZ2kizQflIUnfhrVYN8eV3grWQgu8ZkLStrN7LCWDUAjgdvwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ5crf5P4jHlhd3NScKScdEVdn0M7HoOnA8qVRDIE1Y=;
 b=CYxLRVjVdA9ItppWUeoxprkpq1HYYIKKKU/1An6pKIybralcGfZhoxonf5sP/aQKjwa9hVyujtKoC3LxVJO7Oh0/mZctIOg7LmQ1DpWd52bCimKQlitcJFn5Ai3dFVFSjjQfKU8xBpVihS1QME/tbGV9Ll7B/Po1gsjq2TXxDIhYwmvSKcXAOGRPjEmxXxMYnptX/c+8qyU//1fS6B2OwLYnk2mRcLubseKp7f9bwUZiaIghwPEagUjRNsfTeP2MsED6IfzK3BRWO+w+w11D84+HamNO4wWUaDRU8C2G3/sxt6vMpObuVDmpUA3qwRray+V/V+xBn32N+eDaPOTcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ5crf5P4jHlhd3NScKScdEVdn0M7HoOnA8qVRDIE1Y=;
 b=RwQ8nNZAD3YZPZKph4o+LxZJ96/7kN1ItX/Bdmr6SXsugYIMxDshS1cbOOcS0+bYh5NAsc0HGcniSH/o0g9uHFVJSy2ZCk8im52yBkf3MdbB86n5HlBZ4jVxSuzLB2m5RkamL9bwUUd8HE5LlBKXCozkKhMI/DsJEA8vTfmcFeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1340.namprd21.prod.outlook.com (2603:10b6:5:175::19)
 by DM5PR21MB0828.namprd21.prod.outlook.com (2603:10b6:3:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.6; Fri, 16 Jul
 2021 18:21:22 +0000
Received: from DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::7840:718a:c75:9760]) by DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::7840:718a:c75:9760%8]) with mapi id 15.20.4352.015; Fri, 16 Jul 2021
 18:21:22 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3,hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU assignments within a device
Date:   Fri, 16 Jul 2021 11:21:13 -0700
Message-Id: <1626459673-17420-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:300:115::14) To DM6PR21MB1340.namprd21.prod.outlook.com
 (2603:10b6:5:175::19)
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR11CA0028.namprd11.prod.outlook.com (2603:10b6:300:115::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 18:21:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d137ceeb-0138-4d52-e46d-08d948868381
X-MS-TrafficTypeDiagnostic: DM5PR21MB0828:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB0828FEB049F48B1D48741DDFAC119@DM5PR21MB0828.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJYley8IL12JYaRPtSpuTKtwjnz8JC+Oz0FTpCYsIalWyzmeLlERhW7Rytp2CgKPYLT+rn/y7Yeyh7M0uMEWDBhAAf45FdETI9VuzU4gwzezoLb8+MxkREwEKCV1x8AW5T3ngOiSBnPdZ5UjxvdhRydlexx4kQPv8mlcdW9S1K6ebV42lDeF6BZdq5QiufLjUfubKy4r7xECdUqX7pTJpUWog7jtcIBU60/I3Iai0cuDragwLPCeRMrNd5A0UZn86TcLM/unr7LPl2RwWcJf31PL7Viifw00pAT5URgSEcD6sywWJYAgpYTx7T3R7khpwgyIQhINECsruZn1vJ1KivKLp/cE0JgwG+TCPNl3wPUJwr3Ojky8OKP7b+Jnj/Dm6JO4kbbxSvkUTfPRWeMW9dCPZ9zmOXgX35GUj5qiCGRdR1GVFXLfqnAtbbX/w6sY+2ID3RSCCjiR2fWg4R2eKzDJtvMhx+Hr6fvACtc8LD6lhblP+0WbJEVO7BjkPh+Amq2uUPg2Yp7VsOT0ojV1lopHTWUeEYbzGdOXK7LVE5EjBzhum0dIUJQF8Q5DdNZ2IQHPyfKEiYc38wLjQu5n44lJ5stXlZQMch2Z6jRAnc87DyJRuTJw0HJDYBTY5gzh/Y3gSqqU1f4rJFBhybPCqcZ+XnOpAn84yLV1decYUWxaeByzNzypSn/eH2JqveHuFRwyWBqBEn5K8M1X7Vir9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1340.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6486002)(36756003)(7846003)(8676002)(508600001)(82960400001)(956004)(4326008)(450100002)(82950400001)(6512007)(8936002)(6506007)(10290500003)(38350700002)(186003)(66476007)(66946007)(2616005)(52116002)(66556008)(316002)(26005)(38100700002)(5660300002)(6666004)(83380400001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0wMVOy3uy6xCIH23gxWwEXwIUymmhSqSzSMgFQeybuwJzujwGmCoE1iug3I?=
 =?us-ascii?Q?tQ6V66NyA9hpTaTBweMwAQ0OfiGhnVRifedMOulJP52aB37B88A36UySNjHz?=
 =?us-ascii?Q?5ThHdne7VccuqYsBcO0N0bASDcvdEAc4UE1IAnXOWvQBF4qAXNAqymx4w0jN?=
 =?us-ascii?Q?tabb9xLVUz3W9Ec7lJ9NANYvrhcazW2oIwQok09ptpup71V0gt7aInueJjmp?=
 =?us-ascii?Q?6mdJgiv1sczJhxvJfb/x93c1y7ZAfKiJ4E91OFKy0lAgMh3Rtz/7mA6VmXNU?=
 =?us-ascii?Q?8jl3G9wtOymS0BDxaLhV8MwIZb0rMRQE6AJNyJDN73rso8kQ217UaRFoVaGG?=
 =?us-ascii?Q?6lsQwCKj7ZWK5g9bVWOeH2rRZMWh4wDRqZDE5b+1dnLkn6tSZpWIhsaaqXc2?=
 =?us-ascii?Q?YZgy19baBlfcAWs5WJ/1YgGbVLDvuu5UG3VI6G2k9o/CkMAfRWQEiizqkUt2?=
 =?us-ascii?Q?ZwL5VdwuE6WRMaM1hEA/OxTQhwWQ2xs5WAORqtl05S3qWpJNbAwb8h4sYRg+?=
 =?us-ascii?Q?pCwZcmMdrejNQVORxfN+186PyOYsNU7m6R+ELDuUp/K1qERO/B2MYc+EqSRw?=
 =?us-ascii?Q?yU0N0rfgdCAbiDqRC3BZPP0xH4jyJzbUDy6Q/RfIjQeFbEOkKvj+/Rj77aXm?=
 =?us-ascii?Q?FSbI7H/99YA/xnhP4BNwXwJSbh28DFabvMeDglo7rd7jPb6/P+oqB75mPvKQ?=
 =?us-ascii?Q?qu4tfVRgDDK46RPN7Zj+DZTqLWZB7jNbifrfWLV83MXI2jrUCT311G1J3qXE?=
 =?us-ascii?Q?6D2jTEuL2HUwk69adwoE+UYi02NUhnWi5qkuo8F8EP3e5bDDNshvovWWr/Px?=
 =?us-ascii?Q?pz2i75YOucyLwtR4ILB28+cDjBfzMAHY32jCdhWW6kCFuXhrRIGHd2scLja7?=
 =?us-ascii?Q?P2vyLp80juoC30o7Fzx0ARgu+wwPCxwjy43DreAEgXa9JdKD/qtFRSw9GtIw?=
 =?us-ascii?Q?eRji02ER1xcgStkSQnkidv6Qqnrp43oRNIAMXokfjwKFAKCcgN1WzHAKH6Mw?=
 =?us-ascii?Q?g19xOIDCYEWCtZKH9s3nYVFva+V7StWrXM+2ywx5cdhsVsLRZpy3NeSCKFJ2?=
 =?us-ascii?Q?9t1koqIY84Wg3pnL509z7SzjW0KmWmTdh48GCxDsZh31rSnPsVEjJlXlkm67?=
 =?us-ascii?Q?K43uac5c8OSecYE9GYVsSpS7qgtg0ynrOztWW6hz7c9AHASRbNaD5IcKQa+4?=
 =?us-ascii?Q?L713rbbLbza4i9+3Yf/tynvtiqlIvBwaCAJ33tzfNSNrn2J7zOKRQDUSCXww?=
 =?us-ascii?Q?Oh8qIJkoyhRvjsYGSb6/8G4tEYxFbuzmSm/82i2gfm8QMJ1v8mOSoVLRr5sX?=
 =?us-ascii?Q?2gNjzRCo//ssKusyS1vIMtJ1?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d137ceeb-0138-4d52-e46d-08d948868381
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1340.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 18:21:22.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJNFgNVhN7rI0O5jqH2ZAHKr0+9R55Kda0mpb1EVNINbQAPhneNidpSIupY/Y/ufiZoVkmVSk59ff2zjccVNKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0828
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The vmbus module uses a rotational algorithm to assign target CPUs to
a device's channels. Depending on the timing of different device's channel
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 96 ++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 32 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index caf6d0c4bc1b..142308526ec6 100644
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
+ * It should only be called by init_vp_index().
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

