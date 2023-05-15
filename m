Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09237703939
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 May 2023 19:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbjEORkZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 May 2023 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbjEORkA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 May 2023 13:40:00 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020022.outbound.protection.outlook.com [52.101.56.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D1217949;
        Mon, 15 May 2023 10:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbYQSxd9kQu97xiP88PEJVSaH8jl9ftE1J7P5SYAoy4L7lbB2XKiKZNcl65r/93gpZE6d0iJNLHBnt34I2azNDFto31Hm4KQjNMf7mpL41lUDDdDU+EgedOifq1XXSYNbRZDgddPlfzwx/av+DLmKbMAOB8e+b8hAwFh+WgRAByYm+TmKQaMU1sqSBPJdpevZlV2aW3MAfoiPeXPeRGerVGytyrIJDpyEU9cUPM94UGJEPZNfxD1cb0K5gDYCp70XsozlkbnQcgxmXvdXUNKcYsu7gwbXL4qByshfKrPmZRR3WMXCsaQxNN0Tz0/TSounH0m/tM4V5OBAv3KHy48jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWanXxub6PVOdWcTgaj2bViU9c6HBFRKr2kMxERQeeA=;
 b=gj3p29MboES0pNUGRKcDJj5To2DAmLTr/obynOEIoxexrK1l4/FzmQNH9qKSVYcuaHHkYL9GZpdN9EDzjKMwjOG97oK6T2n8BVEEtDUF78TUFjVBK6DFVnZIQSdfm9Ha8UUaQkN2tr72ei8CNiZG11aOtBrnC8im33DjvlnqjpFx9SQmCSCeDov60OSuQThOqlDmE3oeRZK/D2Z+AhWFxIr97yI9mYS7erBw21zpF4Kx+hvqJGlF4OD0/HCh4EuTDoFCBnpwJl409JQNoFCHKRGdnumjpj9IPMwSe3uQyjDTqia3OlzR3tgYw7cpKEtrTD0qIDSa0qPypKqgo0TM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWanXxub6PVOdWcTgaj2bViU9c6HBFRKr2kMxERQeeA=;
 b=FIYwOUSXgAvxXda6tfNjRXpsYKTUFCkYi8ZyNMX4oIIzR/a7wKW7LkjO1sFD14XsUi96zDp+3k508igq5Jca0Yhhb+NEiU59EjVXnYEA0RqteYCfSoa1SYixkAHH+G2rCU9zaPGLguuq5xrr6ZMWBizFhIEyqeX1KHxuVzZiuyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DS7PR21MB3597.namprd21.prod.outlook.com (2603:10b6:8:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.3; Mon, 15 May
 2023 17:36:58 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%6]) with mapi id 15.20.6433.001; Mon, 15 May 2023
 17:36:58 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        vkuznets@redhat.com, decui@microsoft.com
Cc:     mikelley@microsoft.com, stable@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs
Date:   Mon, 15 May 2023 10:36:31 -0700
Message-Id: <1684172191-17100-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:303:84::12) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|DS7PR21MB3597:EE_
X-MS-Office365-Filtering-Correlation-Id: 70865899-3c26-4255-2a98-08db556afb94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mF9D/nsv7R8FG+OAqpwQdTrm8Jnv7f7LwUy2cPelPSq+O0d4phWveh8I/eHfP0UkdfSoRgFfpv5MXRc0cIxMk0uxedeIwM6eAc9jT4fBt7v5klkTxKZpRYiYuZYEMmYG8tdWO2gtsgj3xiT4hrFmw9DVkZ2k8YU8WOEt7lM/XLE8n92s5sC9edI+YfB4bOCoNs2c2tZuOwQzwsN6MM4wUjiP1SwSfOVdpxo4ZAzZh5SVt3vM9dQcyxgxA+y5RT3X6OwhfqKw9M85ik0VqJLtQWz6i2zrK7E1FwAXPoheIjYp293qwlSgwgXpZsZ0lh/PCDHl0OgleG5lrfopzQNCmvc3ZXBSbwbw3gfHRcczykgmF7J87JnonxGKwJrjGmgLqSMRoTMrCPN7jsUxECMzjY22cR9BIe6qN6BAy+kl2tTzgN0i4MjvL0NiaFqIso1h9fbWRKkChMgOOmd2/b/D3UueAUyOypjsiMi0zzJ8ePWVP1L35yDEYj6CAK19nxv2OfpdGhYb6o+h0o0YbCGXVnOE0o0ec7FERrcCIZjme7Xtihtvk6gqTl7Vd2D9xjUJKglpHWt18xv7PTUShY5ouP94c7MMahI+tpa3nQvDfgu9CfXTsAeEDTl9Mcge4eVkBYg3M0vW8RaFngnjicHozb6NWBmMaApU523KDaCFA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(786003)(2616005)(2906002)(6666004)(83380400001)(6486002)(66556008)(66946007)(66476007)(478600001)(10290500003)(52116002)(8936002)(8676002)(6512007)(26005)(186003)(6506007)(5660300002)(316002)(41300700001)(4326008)(6636002)(82960400001)(82950400001)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gakDbq4vEPLi14pO5nZeauzbIrzSOKEEmqvsbq4HPE4EE3aZnQVT5RXpn31s?=
 =?us-ascii?Q?XRIyxh3fPOpuD0ZeFksobDYO/APfiFzXNtf6WX3At1rN8ypVjm9q9qOvSYi7?=
 =?us-ascii?Q?aG6ia0Gl0a+afHTp6djyvT1PxECCIAVLPk4T/24Ozbz5TCinqi14RA5ecX+r?=
 =?us-ascii?Q?QmhXnNy/MrVeZ/nm1AaSKzoO5Y+60zELhS5Mq4OoZ4P6YW9qNl2A/XehJLik?=
 =?us-ascii?Q?E2c3mbZfuPyaBM3xLoTG1mZXl6Tp8n4F6CuH9KZ0ZeJ2sU6/m87c6rCIBfZh?=
 =?us-ascii?Q?LMHO5TKoq6EaXK+bxt2oDA8bHoHoMpUm7KZBT4IKRqr/ksc5JOZ2p9Lfv30+?=
 =?us-ascii?Q?L8kgFyJyLtuF/anQEiQ4MXaJDAZq2GLEl/I7bmfYfzkWznnEHEPJnoFng/NX?=
 =?us-ascii?Q?NZDiId+7viYSjvpPxkiyk1kRB5W4Ok2b5F3/HlsVtFIdCbonHSjeoo2fUiHL?=
 =?us-ascii?Q?ihLgdSjSyR3UtW2gPGYN8UOf7HlHQ8Ywfre5t2H8U0sQQm/paaH2I5ODToVG?=
 =?us-ascii?Q?jALy3i/aMoLvUzvFJPDQpTnhYNnP0FtBGMC3xKOxulNRz8PZN/0y+5F0mQqH?=
 =?us-ascii?Q?k5Y+GcM8D6E+dA6iZX5Pq0N5ukaaP7TtqHAaAQ+kaNeqOl4xJa5I43BvU8ne?=
 =?us-ascii?Q?/zoNLYKMBWCIENpELtu+wYFmWa0UU+s5dfg+NQ9hlo4eVk08/kp+4FdgRFE2?=
 =?us-ascii?Q?OAdAVSmkFjLVi2Pla1pqnXWUVnbRCrMKMlSlhnScR6Msq50vkyFXTLQOllpa?=
 =?us-ascii?Q?jSb1ROyKxEL5qK5qI6l++6Uwm9lu631yDYWwLZ5VQqIBY0tzxOF3SeLDgecQ?=
 =?us-ascii?Q?0m8dxFBkAwuKY03fOvwR6HIBU5+7RpNGuch+Rz8RVJaeAx3ldCdaAIw3Gi21?=
 =?us-ascii?Q?gdkR2ElWGqlaj0ND8hSPEvmM6GGeI7Q3y8h+DPvnVLMlbm7EPlA7HRVe/2xc?=
 =?us-ascii?Q?9hV1AsKzTBHQLx0NIt3stkBadlzFeey/82nS55j+cnQw5pwbJVd8orSaPm6W?=
 =?us-ascii?Q?vfWqO7nJy2EI9ep7W9Tc1S2joWn8RKyKXGR9+cDXFZSG2+nhRXJ/BIJ6OQJW?=
 =?us-ascii?Q?aF+8sMTJone5y7QDbB8W5nJvIp/vlTC4O7DUdQEART06ijDi8ixU8VwYOZvP?=
 =?us-ascii?Q?1Fmvdv0+Wf4CBsqvzvGx/kUXNp05AeZpJpN2p+iovexYGBb+55iQcMHF/srY?=
 =?us-ascii?Q?z9M2uAA7SHtqckZx/yvf0jsxGh+BgWLeuY56n0HrHb76GG1Zsni1zxWzZzQI?=
 =?us-ascii?Q?2cu0YHPg5AG5m4/W5aPHu5xyYtiggoQiJ4HYt9wHaXs3xT7aBpBTYxXEtz9Q?=
 =?us-ascii?Q?eDAUlxHpSP/dK+vSxalFOH9DyRBT7ve8qcYuwOK7AWl4pXpU88BZydT5L1YL?=
 =?us-ascii?Q?GOMRZHvvsdgz+sRcrSjdm6WIYQ+yvPWEZ12mTV4Pr6zc9adQJtaYf2JZYRh4?=
 =?us-ascii?Q?uDHx3gpWqktfwTXx6r8sEIwXvSiNo+IfC5X3ANrCDhVihXY/aUkmNoLOpibo?=
 =?us-ascii?Q?Wq9xOxHT/m2u9n3Af0XJNkluoZRv3aklDJlnTkpSrjpfGUcw7FxHbune3hbd?=
 =?us-ascii?Q?ca6+pFt4S/AJc29UAzxnUxbmoyYc4+rhk5g6gfgp2SAVqQFVEtQvAPjJqh1H?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70865899-3c26-4255-2a98-08db556afb94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 17:36:57.9735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uU9yU4N+0QPe7W64eI345tt8TXP2knOgwMir+nwmXK+f1pMnoRsn3qXgBBYJPiIfXkfugL+zLhm+5gPid9FGqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3597
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

vmbus_wait_for_unload() may be called in the panic path after other
CPUs are stopped. vmbus_wait_for_unload() currently loops through
online CPUs looking for the UNLOAD response message. But the values of
CONFIG_KEXEC_CORE and crash_kexec_post_notifiers affect the path used
to stop the other CPUs, and in one of the paths the stopped CPUs
are removed from cpu_online_mask. This removal happens in both
x86/x64 and arm64 architectures. In such a case, vmbus_wait_for_unload()
only checks the panic'ing CPU, and misses the UNLOAD response message
except when the panic'ing CPU is CPU 0. vmbus_wait_for_unload()
eventually times out, but only after waiting 100 seconds.

Fix this by looping through *present* CPUs in vmbus_wait_for_unload().
The cpu_present_mask is not modified by stopping the other CPUs in the
panic path, nor should it be.  Furthermore, the synic_message_page
being checked in vmbus_wait_for_unload() is allocated in
hv_synic_alloc() for all present CPUs. So looping through the
present CPUs is more consistent.

For additional safety, also add a check for the message_page being
NULL before looking for the UNLOAD response message.

Reported-by: John Starks <jostarks@microsoft.com>
Fixes: cd95aad55793 ("Drivers: hv: vmbus: handle various crash scenarios")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 007f26d..df2ba20 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -829,11 +829,14 @@ static void vmbus_wait_for_unload(void)
 		if (completion_done(&vmbus_connection.unload_event))
 			goto completed;
 
-		for_each_online_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			struct hv_per_cpu_context *hv_cpu
 				= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 			page_addr = hv_cpu->synic_message_page;
+			if (!page_addr)
+				continue;
+
 			msg = (struct hv_message *)page_addr
 				+ VMBUS_MESSAGE_SINT;
 
@@ -867,11 +870,14 @@ static void vmbus_wait_for_unload(void)
 	 * maybe-pending messages on all CPUs to be able to receive new
 	 * messages after we reconnect.
 	 */
-	for_each_online_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		page_addr = hv_cpu->synic_message_page;
+		if (!page_addr)
+			continue;
+
 		msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 		msg->header.message_type = HVMSG_NONE;
 	}
-- 
1.8.3.1

