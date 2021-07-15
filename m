Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745BE3CA203
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 18:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGOQOH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 12:14:07 -0400
Received: from mail-bn8nam08on2123.outbound.protection.outlook.com ([40.107.100.123]:49568
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229516AbhGOQOH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 12:14:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUdg5MtUehNkdWKO/4R6p1PhScWEK+oD+jFa0VT5b5NzqQ03fvew26pAi6pIeq+5FYItaU3tmDBWxyhbPCF6xbE6ziBgHr5azU1/TlpEEKsl29z0OopcadBcyzh/vXiStN6poHVHshOTTl5IJAAYf3Otv0pPt++HddFVw/uPlbGCmjOe18/8xjKpVDPbnxdfdZFvGbShwCpHs2zD6elrd675s1kfOA2XoLKACXvaLl3fXFy7Hv94E92zISow3KDm7jARji5CRMH1MhroMRK/47krG3+KP8zdwa/fxb4OvWQCyJQPflYaBKcFHgBDUlmVdC+C1yUzf6mH6iVMNN1+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+gERb1rI1vVCDfgcls/bdODMTqJ8io0gTsoyrGl7Os=;
 b=GRpsb91GfX1ZzNohRWYRZ1SUWoWx7XF25On24RxNWeYHnLeaD0CzDS4zrrD8lgP4w6M2Xpbebn39ewoIf2yeCB2QC45GrvUiok6jGGdBqDX/hGRJCnAdhnLKK+mjtv2Rikp+Ubaih6l91Z7qZmQlGW5d9vovLVL38YhCtJcqnk3Bet0ZevjK9NeJZFfDJCK3ymGNa0LPjrwxA8kJr5HDOdXUCL6CShSoywu1Vb/wt5ZDc7DgqCBQzqCQ+AqZE7faGvHevY+e16xiE/i4NT9mrZhZsTvv1QeuQ2sjpiJdF3GPFwhVBbJysX6QGdCS1fC8leY3dimlD9ctuNVj9gIuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+gERb1rI1vVCDfgcls/bdODMTqJ8io0gTsoyrGl7Os=;
 b=hEUgEWlo0BJKbXm1d6h7DR54ArHcXHSlmEmtOmgrrm/IS1WkSBR4Q8ptggoVfd7xSbNEiHD/8XRIGGRdbWNr0tNbbghCUB+T29iNHMH3NlAhL23A3tANWrPEq1eF3gwe33T6rV1HrquCQ6vElAxhg1/jf1uzRIKIaxwPUIgUR+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1340.namprd21.prod.outlook.com (2603:10b6:5:175::19)
 by DM5PR2101MB1029.namprd21.prod.outlook.com (2603:10b6:4:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8; Thu, 15 Jul
 2021 16:11:11 +0000
Received: from DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::7840:718a:c75:9760]) by DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::7840:718a:c75:9760%8]) with mapi id 15.20.4352.012; Thu, 15 Jul 2021
 16:11:11 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU assignments within a device
Date:   Thu, 15 Jul 2021 09:10:42 -0700
Message-Id: <1626365442-28869-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:300:ef::17) To DM6PR21MB1340.namprd21.prod.outlook.com
 (2603:10b6:5:175::19)
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR22CA0007.namprd22.prod.outlook.com (2603:10b6:300:ef::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 16:11:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87d7bd80-4c2c-4cd3-e67d-08d947ab2959
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB10290398890A76C43C6850EFAC129@DM5PR2101MB1029.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xjrtoV9OV7VuSdal20sO48uXbKMFEhDbhaEfMLqbFtXtRgemPkYYVeS6EAoVInCWvmy1lLmhKHB78l4+tzbEn94FUqFEwx8WzUAaVwtwXNQs2wjPDGnbVD3wLkzvuRUPoSmFuDYZcOpXcs7ctmNBG8GxGI0Q988BUsyw6+c4tmhyhVocEuSZk3KbX9ifYjlGHEfhU8ldjVOx31iUZbhyr3WCyVn6qxnOQqH6pwVFUzsr9DUV6h4uW5gsMku1jyC3Oy59d3wpyi5JjFuwIubm4EAEvECKIhY4Ja5RGSP128z/J9CueGM28XEE1xZG2meP0J27ajjcJF8MqteIIDNg4+LQ2J3OypGByoDlh4fjVIGmgrLYwLqHqrJ3oJ0BqrrhLW4CQFraIemkKuuKwhd7ZPrh7dQiqHB8Xn0/GaJSTEM6NCMfgMC7xDOg5cJdGhu1qA5LFCdI77ZtXbXRpe9mSwIEMQJ8CQNeINPjj97OYx1+kwhdTlb2fkoosUNFHnJmpJZuIvnm/+bIzU1E9Q44aYS8aspqT0cbB2flWJ+bPtS2ReWVs4zNFkTKTnQIY0ZyDmWwmJKQQFfxvBSQq127I4Uzp8GaX/CHJ6ek92W5outaQ609CB6Y0QI3GaCxBrWU5oFTo99szDGKhWfK6XaMW836WJc4dM/sb2OewopG48ebW2yf6rqSAtzWGb300UVWQkcE/1Rhv4J/RPKxT5Lmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1340.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(478600001)(82950400001)(316002)(10290500003)(82960400001)(36756003)(83380400001)(6916009)(8676002)(5660300002)(26005)(186003)(38350700002)(7846003)(6506007)(38100700002)(8936002)(450100002)(52116002)(4326008)(66946007)(6486002)(2616005)(66476007)(66556008)(6512007)(2906002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CXL2lAGcddE53MrkY8R79RWjKySR+RxufiWWo9qQh0fpbYe3n/gbQstrIlhB?=
 =?us-ascii?Q?5ADA3Aqx1G7KDlOXZS60ZvmQsAT0KNRJw8relr2cRJ4lJpLCV98EqzigWf5t?=
 =?us-ascii?Q?2AuqLJBx1VyWMMZPP2d5oDHS2H7I38NnrhDefcTz5QuR6p4IysgAysKrRI43?=
 =?us-ascii?Q?e5GDWBVntXj+ZKLA2q0+E/udQNiin/4RATQs1jCJheQUDv2IKUJzilk+IXF3?=
 =?us-ascii?Q?9m0zFWq219Kd37hSKHNdBKl8p/ZieK9mFXBqHP7B4DqRCXkeHEym7uiX7fOC?=
 =?us-ascii?Q?/VvjuQtcqCWJqmZNd+gnVlNUIBzCSsKSDVxhC99FBVOlRpsrZrnMChiD6u5p?=
 =?us-ascii?Q?SWgeWEUrQd3G6jnuTuDZcEyrbS5eK0Lk6CRJaBJcQS9YMIJA5mWxaUKoCEiD?=
 =?us-ascii?Q?cef9ly/3bMTIkNcly0TYkkMRrNX487ek9OJHThJrlJc/L9FWzHy194Ui2qXJ?=
 =?us-ascii?Q?OzHJwLAahLujH7Uvn41mTCj7FmNZEOTGOAwSQ7sAJGIG9kpIU/Mmx1Q/NLzW?=
 =?us-ascii?Q?gUvByd8OsM6RdNfMDe4xsT+srK5CJ9NGKdPNfyYIZYE0d9QB7CQ3lq4tWMly?=
 =?us-ascii?Q?4vvFmof3ZY93qG1MSbY8igjccRY3nrHTD6pJldD3eMcE7o53piVLNoJtFHLW?=
 =?us-ascii?Q?M+xw7IRsT02YFfuwPF+3TJxJWFW4eVYGAT13BVlIkfnI1ym2oDeOJP6VYweR?=
 =?us-ascii?Q?1eRmhnvBb0N//A/tpk/2vPhcpH6x3OJuwFE++rvpaZduf8bZ1rv71i+p2t4u?=
 =?us-ascii?Q?RRYA63hkY17DuXcnGvpNo57nNbpKzjZQPdXo8IeHCLrf3PCB2QMGuuGtAdvZ?=
 =?us-ascii?Q?P+rQ6s2jY/B0mz3XRMXj5yGA8seWmO8lx4dzSAfgMwvwQH26uTtCRAUKzH+9?=
 =?us-ascii?Q?e8LVTdMkQWys3c2Eo5YJ0qxj1N18YyE21k/GEV2LuMgkAsEU7HCKEnmfjF1Z?=
 =?us-ascii?Q?gIvjQRrlB3KYy8mXyI2ChQ4wh/rR6jNkrdzQ6vdi/aKhLyVAb4OKwx/X4V9C?=
 =?us-ascii?Q?IRoTVdVnEAWotx4dWaV/8ax/+4pbkTfD5NddPfRB0bsXvAkCHXY7iV2W0yFa?=
 =?us-ascii?Q?wuqDZdmbLjw+Ht7B1emLWZy+0+CbaSC8wVMdMEkCr+6OssB9P4PAKclVJeko?=
 =?us-ascii?Q?cELvWn562W/5BcZMO8cG/3bVUjg3RSuqBbTgWECx9NtEsZ11yEqa7zQTjFJw?=
 =?us-ascii?Q?VrWmjZKwbwSz535nXsd5nDGqf6FeooUzREhMkluTEXqacseME0aIVGI6na7o?=
 =?us-ascii?Q?xh/6xmlkNW50aChrIpunNST7mcvbjkAo1zMr5CvyR31944g87p+1U/kBFdOL?=
 =?us-ascii?Q?fkJg3I6wY8JNJZjcsJnhBS8c?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d7bd80-4c2c-4cd3-e67d-08d947ab2959
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1340.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:11:11.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ax+LREacQ3LGG7OVcwvMd3N1LJy8r/hrg6v/nbt7c3h/33LoOmCe6CCp0W5PRBDKzEgQ3Rsa5pqViMrMKfjd0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1029
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The vmbus module uses a rotational algorithm to assign target CPUs to
device's channels. Depends on the timing of different device's channel
offers, different channels of a device may be assigned to the same CPU.

For example on a VM with 2 CPUs, if the NIC A and B's channels offered
in the following order, the NIC A will have both channels on CPU0, and
NIC B will have both channels on CPU1 -- see below. This kind of
assignments cause RSS spreading loads among different channels ends up
on the same CPU.

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


Update the vmbus' CPU assignment algorithm to avoid duplicate CPU
assignments within a device.

The new algorithm iterates 2 * #NUMA_Node + 1 times. In the first
round of checking all NUMA nodes, it tries to find previously unassigned
CPUs by this and other devices. If not available, it clears the
allocated CPU mask.
In the second round, it tries to find unassigned CPUs by the same
device.
In the last iteration, it assigns the channel to the first available CPU.
This is not normally expected, because during device probe, we limit the
number of channels of a device to be <= number of online CPUs.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

---
 drivers/hv/channel_mgmt.c | 95 ++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 30 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index caf6d0c4bc1b..fbddc4954f57 100644
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
 
@@ -683,6 +683,29 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	queue_work(wq, &newchannel->add_channel_work);
 }
 
+/*
+ * Clear CPUs used by other channels of the same device.
+ * It's should only be called by init_vp_index().
+ */
+static bool hv_clear_usedcpu(struct cpumask *cmask, struct vmbus_channel *chn)
+{
+	struct vmbus_channel *primary = chn->primary_channel;
+	struct vmbus_channel *sc;
+
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
+
+	if (!primary)
+		return !cpumask_empty(cmask);
+
+	cpumask_clear_cpu(primary->target_cpu, cmask);
+
+	list_for_each_entry(sc, &primary->sc_list, sc_list)
+		if (sc != chn)
+			cpumask_clear_cpu(sc->target_cpu, cmask);
+
+	return !cpumask_empty(cmask);
+}
+
 /*
  * We use this state to statically distribute the channel interrupt load.
  */
@@ -705,7 +728,7 @@ static void init_vp_index(struct vmbus_channel *channel)
 	cpumask_var_t available_mask;
 	struct cpumask *alloced_mask;
 	u32 target_cpu;
-	int numa_node;
+	int numa_node, i;
 
 	if ((vmbus_proto_version == VERSION_WS2008) ||
 	    (vmbus_proto_version == VERSION_WIN7) || (!perf_chn) ||
@@ -724,29 +747,41 @@ static void init_vp_index(struct vmbus_channel *channel)
 		return;
 	}
 
-	while (true) {
-		numa_node = next_numa_node_id++;
-		if (numa_node == nr_node_ids) {
-			next_numa_node_id = 0;
-			continue;
+	for (i = 1; i <= nr_node_ids * 2 + 1; i++) {
+		while (true) {
+			numa_node = next_numa_node_id++;
+			if (numa_node == nr_node_ids) {
+				next_numa_node_id = 0;
+				continue;
+			}
+			if (cpumask_empty(cpumask_of_node(numa_node)))
+				continue;
+			break;
 		}
-		if (cpumask_empty(cpumask_of_node(numa_node)))
-			continue;
-		break;
-	}
-	alloced_mask = &hv_context.hv_numa_map[numa_node];
+		alloced_mask = &hv_context.hv_numa_map[numa_node];
+
+		if (cpumask_weight(alloced_mask) ==
+		    cpumask_weight(cpumask_of_node(numa_node))) {
+			/*
+			 * We have cycled through all the CPUs in the node;
+			 * reset the alloced map.
+			 */
+			cpumask_clear(alloced_mask);
+		}
+
+		cpumask_xor(available_mask, alloced_mask,
+			    cpumask_of_node(numa_node));
+
+		/* Try to avoid duplicate cpus within a device */
+		if (channel->offermsg.offer.sub_channel_index >=
+		    num_online_cpus() ||
+		    i > nr_node_ids * 2 ||
+		    hv_clear_usedcpu(available_mask, channel))
+			break;
 
-	if (cpumask_weight(alloced_mask) ==
-	    cpumask_weight(cpumask_of_node(numa_node))) {
-		/*
-		 * We have cycled through all the CPUs in the node;
-		 * reset the alloced map.
-		 */
 		cpumask_clear(alloced_mask);
 	}
 
-	cpumask_xor(available_mask, alloced_mask, cpumask_of_node(numa_node));
-
 	target_cpu = cpumask_first(available_mask);
 	cpumask_set_cpu(target_cpu, alloced_mask);
 
-- 
2.25.1

