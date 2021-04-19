Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF5A3649BF
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Apr 2021 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhDSSYm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Apr 2021 14:24:42 -0400
Received: from mail-dm6nam10on2126.outbound.protection.outlook.com ([40.107.93.126]:52161
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230488AbhDSSYl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Apr 2021 14:24:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZUSyFF/pVKu0opMCQDmXUddfZeFgrT3os3+bxJaQBGnE22EjRZcKfsJhGljPFEJ5gPyHebEPn8vm5D2KrsEIXmXIhkcV7nxmzbaZReCHrmBPUatPC+fLCP5cg/FReXVUZ+UKR34vUaUNUaNMYbsu7ptg3v9s47uaWUDs1elQw8/2IPoIVH2mM9ixsFw05+2ES4POHfGpYzTme9BLjjE/nOZGSTO+8n+PYB4bESdRAAZW8fHzTguVORpn93wcnjEm+0HVZ8Jp5t5o8VBlJULAg7eZDxnY0jlPheN6jgbGvdvQj9OJynqXfLCE+aoJwEYG5FGpbYE5weGriEnOjRDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1OcaXdoZ+ZB9vbtczVRSDBfCsGA9XIqGmVzEtq87bY=;
 b=Ei/BwaubFmv1RnKCSCQCxBPvPQbXvgbNE5bWwYrgIBckV6BuN99hAdyvbWXbxPpaI7xPnvmmLf5MwtieQzKdAyFlW5WHwzkw7Pdd8+Q75sVdW2eg6rpYwtgIc+WadVBm3GTUeVBP7O7e6rE9kVxykikmeFQnhyfQr0Ft5fhIwNDsbBTKN+CQYB7UsnR3sNLjFoUOR+Pf9dq/fEMOLEb6iVRMh5vfI+R81AmaY7CMbea5E16kdrd0icNa9Pgf5pUKtSDg5SOuPuKYwwLyTUJKriZtaEQA49p/BY8dc2m4w5ItDiYoc4/WMXB2aeQGs3AeFVP5iscOmIMzHCM8GTrQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1OcaXdoZ+ZB9vbtczVRSDBfCsGA9XIqGmVzEtq87bY=;
 b=URwEVPKxqPc8BlbdZNMk03waVWZFeg9Ti2tBHd/FHRuNQJ6APYkBd48YoIUC1SnxvKE04QbiQONNBrGTSvnnC+lwQ02aR7FFOBsx8fPNK71N0EA8WALpRLOljxmlsfEflLORNeUXx2ZVJjkiTS8qK6sIV9sYJmg2e0mwFcSPUiY=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0885.namprd21.prod.outlook.com (2603:10b6:4:a7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.3; Mon, 19 Apr
 2021 18:24:10 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::7903:384:ac51:1769]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::7903:384:ac51:1769%7]) with mapi id 15.20.4087.013; Mon, 19 Apr 2021
 18:24:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com,
        decui@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] Drivers: hv: vmbus: Increase wait time for VMbus unload
Date:   Mon, 19 Apr 2021 11:23:45 -0700
Message-Id: <1618856625-98287-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.160.144]
X-ClientProxiedBy: MW4PR04CA0309.namprd04.prod.outlook.com
 (2603:10b6:303:82::14) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.160.144) by MW4PR04CA0309.namprd04.prod.outlook.com (2603:10b6:303:82::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 18:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4e97c2d-bfd4-40eb-65da-08d903605375
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0885:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0885991E2D340FE14896BC85D7499@DM5PR2101MB0885.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvgDARbucR4TI7I1awvKMIdCbILdC8juwqEa6U9FjsFNLnTXrjS0/a37670TMbTLj7H/O1RMdb6rxxpO3iABBT+gNNHqlqRxK1MmmIFptTD1uQWIZyf0PBVMhcpSnvusSG62ebm79YQA1GldqSVcJjgbcdkK4Y4VaEYiwDJh3bwHM6lnTJZoFGcDf61px8kjR/2rj/diaouGkTFABoP7czzj6jNHipVfiMdQW7Xp9RERBlOHT91cDWaGDcNdezNQfnKsGsj9gfvKB7hSBZpymkbyOddKaGLrKABNbfTcGGgF4Ha50bvnsjkzVdskoaIrZuZjwQ6gDvcU61FYz97D7/rJC8a8bRhLhIHXpj9phBVJJ5ayhorxpRq6m9cQ2MD1uH1cSuloawFbRBFt7agcWQ0KK7RYcZPhAcTG8Opkqywnbk6yCX/biE5gm96pmrLfrT3wM52zZlpgQ2vo2Sgo2vYXGFo2M5BORMTzk/WhcDWscnNctZLjLeHqCGXq35KHb6kgODfxyobAcjcyFzGM7ImKZwGnQ/6uOSn/byRT288nDV7mIM5ZlmPZbiEL17JbdA3yeGrWPIxwyOKZni061mVxChO7Qyx3VXZNWrF2glfaYffHAIuwGXxXp9677igShF661NkGABeGawjqeA5NVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(4326008)(956004)(2616005)(82950400001)(66556008)(66476007)(82960400001)(16526019)(86362001)(6666004)(5660300002)(2906002)(186003)(83380400001)(52116002)(7696005)(6486002)(8676002)(316002)(36756003)(8936002)(10290500003)(478600001)(26005)(107886003)(38350700002)(38100700002)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FgD0Nf+yiL1mcLN2YqtJyTBMExUqshmAZLiT8KYGZ/4jpCHFXHhTlxAqpe2+?=
 =?us-ascii?Q?R8+459Ybgxrf1mIMdQzFLbkLo5LxHonImbRCiNqGqYbj4u1Kqb3ru4Fso4U/?=
 =?us-ascii?Q?4M46EJcXxWNnAd5LaAlu8TQYw+VPxsZ0fD3FSfrAIroVR2jns9JdxPbyZtXS?=
 =?us-ascii?Q?AlaPf01oAO7Hx+887lT81ysX10m3sXMpnzL5lGGIGqg7GQ+oSd0kkd3hhOqt?=
 =?us-ascii?Q?7VaHfTEhuYlsxIM594mKV9CQpFmZ/fz0cdx9x1ZUMsQ/v9vzBe/aShYCm9MQ?=
 =?us-ascii?Q?wfSpW1tLOHkswsWgBP/3MqcLRPzLj30w3qnzKleKo9bzkt8LtCwq3dSUFkTu?=
 =?us-ascii?Q?L0snktrAB0OMo3tJ5OtFBUgeKximSoBopwjYevqnkFFACAaOd7EGghTDRwQ3?=
 =?us-ascii?Q?1G9gLT/4E0j79FOTurJIkRnobZwglAuQOSkvZRUrAwuj80kE3D33u1LJALnK?=
 =?us-ascii?Q?HbAekCSn/FaoNI+rby2mIyHhpY9KOdFVn6uU63eC+yZdA+ZhSWIZhkvhNwKf?=
 =?us-ascii?Q?OJ5oKKbi6ZHqKVjU/1YMMQMMbPWA8D32mwAtyE8XDM/1/otMelG9QHWRWrrR?=
 =?us-ascii?Q?D4TXQ4bWX8PSxlGzDKKQu8RzYMIrStbLX1GVtlxDHC0BYrFcAPcwKZJeXBPc?=
 =?us-ascii?Q?tW9MGXS7eK1Ic1bMjwESAjBXAGiX4e0IqGxJcfnuBtRpJFFdj50GMJBjTsog?=
 =?us-ascii?Q?+9Ua4X1auh+qBjvPTZ5AWHhs6dbYxSgCnqV76IFJoj9GBPknaiNzFyWF/aNd?=
 =?us-ascii?Q?Vl4tkVFq9/tXfBNLgzG1bVRTPI+ijv1EH7bzFS6DoN5b1jZiQCroHAvJL2t8?=
 =?us-ascii?Q?YlI7uV1CBgWco0v4TzA6JPyQS/QIQZud6Y/1sEeMLgf0in2186Am1xePkZc4?=
 =?us-ascii?Q?xiX8Fi7arK96TW4LX5mDUVYCL6CryC9fcsHZwL78ZXMpZ9rat6IOaVpFpSq7?=
 =?us-ascii?Q?cmwHnkkHelc9CxxinfCEuVcXlIc+hu7HTJ7gu74vsMsWhx3PtcbWLgfHEw7x?=
 =?us-ascii?Q?ppmO2GJYkeyTOyJPb/FuibUtZkteVJFqIy1TWOBgtY81Yofdt07fVrx4xfIC?=
 =?us-ascii?Q?qGxnh8eF2ZhFv/s7IbzWcFxOzhJJPIeX9/79c5VKmcgl1DE5idM7xjriXH7h?=
 =?us-ascii?Q?EvX09gm7g6g/l5Y1fTjMlAKbi7k8CtClxAgP/5Cfhr5nVaAWuy1/j5aIzmlQ?=
 =?us-ascii?Q?NciUfET2yXhazk4Qj9juv03zDfVD4gkj2g3hJHJnVxnUByckqMOSdLVQ4GQa?=
 =?us-ascii?Q?YnAiXkItBgnWdjj7CclZu+cHpdiPj4jgnmkzRlNBeTJMhkFZaggkxSoIEbuW?=
 =?us-ascii?Q?9O4p4Xfihs3rnyIKFinJecAV?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e97c2d-bfd4-40eb-65da-08d903605375
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 18:24:10.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9hvmaQJSMZn6ZXcis1vXqCpeXZNicPoMgWNQ+62rAwEjLpqL63NMuL0CO85Da29HeMsGct/d6Mc7PUNBatV5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When running in Azure, disks may be connected to a Linux VM with
read/write caching enabled. If a VM panics and issues a VMbus
UNLOAD request to Hyper-V, the response is delayed until all dirty
data in the disk cache is flushed.  In extreme cases, this flushing
can take 10's of seconds, depending on the disk speed and the amount
of dirty data. If kdump is configured for the VM, the current 10 second
timeout in vmbus_wait_for_unload() may be exceeded, and the UNLOAD
complete message may arrive well after the kdump kernel is already
running, causing problems.  Note that no problem occurs if kdump is
not enabled because Hyper-V waits for the cache flush before doing
a reboot through the BIOS/UEFI code.

Fix this problem by increasing the timeout in vmbus_wait_for_unload()
to 100 seconds. Also output periodic messages so that if anyone is
watching the serial console, they won't think the VM is completely
hung.

Fixes: 911e1987efc8 ("Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index f3cf4af..285292c 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -755,6 +755,12 @@ static void init_vp_index(struct vmbus_channel *channel)
 	free_cpumask_var(available_mask);
 }
 
+#define UNLOAD_DELAY_UNIT_MS	10		/* 10 milliseconds */
+#define UNLOAD_WAIT_MS		(100*1000)	/* 100 seconds */
+#define UNLOAD_WAIT_LOOPS	(UNLOAD_WAIT_MS/UNLOAD_DELAY_UNIT_MS)
+#define UNLOAD_MSG_MS		(5*1000)	/* Every 5 seconds */
+#define UNLOAD_MSG_LOOPS	(UNLOAD_MSG_MS/UNLOAD_DELAY_UNIT_MS)
+
 static void vmbus_wait_for_unload(void)
 {
 	int cpu;
@@ -772,12 +778,17 @@ static void vmbus_wait_for_unload(void)
 	 * vmbus_connection.unload_event. If not, the last thing we can do is
 	 * read message pages for all CPUs directly.
 	 *
-	 * Wait no more than 10 seconds so that the panic path can't get
-	 * hung forever in case the response message isn't seen.
+	 * Wait up to 100 seconds since an Azure host must writeback any dirty
+	 * data in its disk cache before the VMbus UNLOAD request will
+	 * complete. This flushing has been empirically observed to take up
+	 * to 50 seconds in cases with a lot of dirty data, so allow additional
+	 * leeway and for inaccuracies in mdelay(). But eventually time out so
+	 * that the panic path can't get hung forever in case the response
+	 * message isn't seen.
 	 */
-	for (i = 0; i < 1000; i++) {
+	for (i = 1; i <= UNLOAD_WAIT_LOOPS; i++) {
 		if (completion_done(&vmbus_connection.unload_event))
-			break;
+			goto completed;
 
 		for_each_online_cpu(cpu) {
 			struct hv_per_cpu_context *hv_cpu
@@ -800,9 +811,18 @@ static void vmbus_wait_for_unload(void)
 			vmbus_signal_eom(msg, message_type);
 		}
 
-		mdelay(10);
+		/*
+		 * Give a notice periodically so someone watching the
+		 * serial output won't think it is completely hung.
+		 */
+		if (!(i % UNLOAD_MSG_LOOPS))
+			pr_notice("Waiting for VMBus UNLOAD to complete\n");
+
+		mdelay(UNLOAD_WAIT_MS);
 	}
+	pr_err("Continuing even though VMBus UNLOAD did not complete\n");
 
+completed:
 	/*
 	 * We're crashing and already got the UNLOAD_RESPONSE, cleanup all
 	 * maybe-pending messages on all CPUs to be able to receive new
-- 
1.8.3.1

