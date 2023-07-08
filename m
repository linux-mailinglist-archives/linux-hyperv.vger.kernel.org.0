Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266B174BBA6
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Jul 2023 06:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjGHECl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 8 Jul 2023 00:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjGHECj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 8 Jul 2023 00:02:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24AB2117;
        Fri,  7 Jul 2023 21:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq9Eoa9SXGxB5OZHmEUISlSz5tHO9CQCnPrIdhqsTCc09ZkwYeRJOMv4a9l5K+PIkMLk63A+MGTbKyYfIXqn05OWbB+oo4/u7U1DgrwBOaNABW3no8HL8kxdJs/ZWziAxXpNw23Owkup/U1+J77u2NWJYJZVoHXkXcTnudSAAl54MTjs1uglDus3IeVl9Ioev+XwKlCaCAK1IfACBuhFS/tWrAplBz9vCDxYqiknTlqy1xp8hN9YzTURzhh9oMkNSpYyVS3I+uoaIJ0cgZ0BUyJODEKOn5Ihbu28lChzjeY2n1DHOwAtRz/iqZrsUign5FGc2BEcZDloAzHlzo9+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BztoiYIdhqrXviWBWhuoZn0Yxu1OmL+D3mymQOyStHg=;
 b=EwaN9BTc1TYCED4iLNxFO9zTU/A4oQg+G3nOXXHSLeoouk2mGufShtpOtAHFG1jtVZf8QBYrYbwH7aT/8gGK4ocVw28L7io1ZsTwxNXOIsIzw7jlcM8THSokc+3K7+M0WXgfaXssbqGNQqQiNxK2oz7PTn8e/h7Az7NQ79/aBdF4bnqaIYEaqEVA46lYdIMia7PUUtCeeiTv0oke5k3K3Z3UKWj+55wr3aQoGJ1PGqxtzUbjIpsjUBYOclHqpMcpk6pfltmsMHt+F6+tAQTM3eqeZfbvCwX8Zy1canv/n6Yiq4X53eC32906btefCcdoJYyan+4VUbVPUIDjpkYdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BztoiYIdhqrXviWBWhuoZn0Yxu1OmL+D3mymQOyStHg=;
 b=D9dPAxNMzu36Y4Fw31X/FEvEfQXbClZ5Mw5yU3X5Yw5FOjUkZCQ3oS0n02Z3wQKDYy6ROGUAsPazubJhqbJrIqCao7g2CxKEPAQPhGhmSR6QvqgZDhbvVNOB98q291Ekn3iW02NJZMKCRld9EbzWLLsadNHXtMbYHJ4Nh8jeKgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM4PR21MB3419.namprd21.prod.outlook.com (2603:10b6:8:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.5; Sat, 8 Jul
 2023 04:02:32 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::332a:4b2d:9972:caad]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::332a:4b2d:9972:caad%4]) with mapi id 15.20.6588.013; Sat, 8 Jul 2023
 04:02:31 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] scsi: storvsc: Handle SRB status value 0x30
Date:   Fri,  7 Jul 2023 21:01:26 -0700
Message-Id: <1688788886-94279-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|DM4PR21MB3419:EE_
X-MS-Office365-Filtering-Correlation-Id: a1132923-5a4e-4225-6504-08db7f682758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7rctVIGq1QS80o9QVyTpIxOm+Jim1OsZPBTFTIrwtdhMkl+I4EJPKrGOTCcDTMaVxkjgjpX6bmHnciCzfd8pzI7M5ccD9Y4UznMXF0K9bfRsGMlf5072kAlHKp5XBZXujLmnuc+q9OFvuFhhvdrol1XdrJyxnHa3eNxHPsAaMtM/E2oEqvtI0lHCrqDLuAXhUmCacDr4NAPuXhCmnU66aMaGyes2IEANrId6Ma/qZ5bfx3hg5og/I1xgUyJyKap0HZ88Y/MnJqSmg/6kIqe6pE4XY2fNrdLJjZZiof1lOYWmzVd1ODR9arDe8/AiLtSN5OLNsgSYr+qNQgzXGUgdhQC81vmXe1o9qlal/KrZC+7Qcyh2gn1cwe0380/3IQWzkVBRduj50leaLYHT6iVvQ4BHh7bR7KfNYW7TZmxJG+0Sebhk8AQDl4w0ItsoEsHFA9qVcDbo1ntnkE4S6f3d5tinXGNd/obThv/rd79ImKeJyvmHLbqiq1jP8rRLi0IeK01l5UwGYX9M9DDPXNIP3e3jUaEgUWwZ+rVvjLpqom46NBSDsaPlQ4WOUWOYSKiR1UlJ0NWR2a6kATPiGw4dZLRLaTmqFjcr8DCbHyhlQQHoXkrD+scOtYr4NAkusboGQ6aCVJp8iKlghrtOoZcC78zy/J5p7FVjmjDCP8bE9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(6512007)(186003)(6506007)(83380400001)(52116002)(2616005)(107886003)(5660300002)(26005)(8936002)(82960400001)(8676002)(82950400001)(38100700002)(6486002)(6666004)(38350700002)(478600001)(86362001)(66556008)(10290500003)(41300700001)(316002)(36756003)(2906002)(4326008)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VRHmdrsvvH3gpBkS0w6BgECDcwh2F46aXNmQwGP1I+V6WLDi+VTw1kArt7Qz?=
 =?us-ascii?Q?HQvY1ZYMd8Wp2pWFxtefopb7VPM8Oyik9MuZCj7a6khM7V5C4mNhtD9UP3gJ?=
 =?us-ascii?Q?9cng3+8kIyKwCEVolsX9Lue4S6pTnWXwGzUiaFYqo1h69pnyPiCJgJ0WxA55?=
 =?us-ascii?Q?C35bGjVg16XiSdyi79Mu+PzWWQGTG3o1LJkdO6D+QnX2ooG6JSEwtBIJgaCO?=
 =?us-ascii?Q?XuErCp0eSdMY9jklyXBPcuK021uDNBU7YSds5VdiZ2T9GfXU9He4xGlP/OmR?=
 =?us-ascii?Q?CmUwDgXe8aDxgxhdvkl0VkLH3FlBI33dZ27C6BKQh+YUX4HDVTBcG7Pw5udO?=
 =?us-ascii?Q?8Oo0R/0p/Vo5wRM6MOE43pNErO+wz7jV80sRxpVz2ZTCTOolYMm4jb4uVLXY?=
 =?us-ascii?Q?egeWBu23+sr5dQ5pvqFhkWbhPrPt/HPa3FPzjWA89H830kvwKZUu3xhz/EDF?=
 =?us-ascii?Q?YnMKooNiG3Pj8QV0TiXoXL6JkltAgDd1rjgWa5gbRCny5L6zuNxBkl+AN4i1?=
 =?us-ascii?Q?bQWFAhuUNwOqHaXmcWIGnD545+Ffw3i6zCDCc/s/5Vg3JnL9tDynIFbswAu5?=
 =?us-ascii?Q?N7o4Mau5hAbg7DvGmAW58DhKvnsz5e2YPR2zNfM2yttSV0kuAZ5q1ZJRHdGj?=
 =?us-ascii?Q?GiG8kBa0ei9jlitvVaDHN9hqtWTauLzr+kvVvPmh/5zB/lUzeyYc/m7r16MK?=
 =?us-ascii?Q?AhgGOTeJ/93vKshiUPOgEco2OhVTJ1s1q9bOb7xRW/Hxz8omsZ3JuZGeU8Nz?=
 =?us-ascii?Q?q950ymzmeAsk1N09n6oW2WlkqjS7rlJxSDp/fXvWoM++76ceqbN7qeORl9Dx?=
 =?us-ascii?Q?9vddRERGTb6ErmYgOyfv43NBBzowXGsDfo4pZt4pzNfGJaobGxuJF1cFp7oD?=
 =?us-ascii?Q?3i/gKjbNPAUvIwg4mEgZzzAN4Hq7UXrT+5JnJLTQPeu56omRlmzNqEQMiBlM?=
 =?us-ascii?Q?kmuOvHqIJMd46Mi1CyGv7Qv/mhJJawcDZGMvnQDFuhpT5O1DRL8mo4K8RFi7?=
 =?us-ascii?Q?4QhJt25lWvrhGHrdaVEb5qlvdvVrZ3W+lmwueolDT1wyRK4Tn4Oio79mkyU9?=
 =?us-ascii?Q?VKYGbAD1t8XXy7KDY2Ea54iH2Q0p7uScL+9pZLxsCwX79G0rft/qsGDegSoO?=
 =?us-ascii?Q?7q7QrNsN6om1iliBOEVrkvccs5x9dYq2439O047k+2aCiiChXFRmzzJCBbJ6?=
 =?us-ascii?Q?98a2wC3pqjuY036UecpZPvPAz0PerUnqm4ZUtKDen6DAhzevwg2BeynL0v57?=
 =?us-ascii?Q?cwXXgX9l8+a+K5AWke7jbDQWqyhkm0sKNjqNpcKyIv6trPBLE3LCZx9kLJPV?=
 =?us-ascii?Q?rTguwInLewL7shGD0Ot0eS/cykPpsIZ66YPJ9z+FjoP8WvobGqU5SaFizU/f?=
 =?us-ascii?Q?He2v2R0LSuLlY6/1CCprDrOTuwtzMsrQe8IWCGQsnSc3gLAPe+iAUe7+GIzg?=
 =?us-ascii?Q?753K0v1oiN7mG4jWbKC/4dN5mWYvXsFisR4Gmpmh4Uyj24ImuavkZAJ39yl6?=
 =?us-ascii?Q?Vg6ApCq1utj1uXherPbh1UB7R2sLgYEfJkxzIRyKD9xzACJdpB/3s9X1ddJ8?=
 =?us-ascii?Q?eI8TR5eNQssRwq6Gr2W5x0ge6wdI6iSuZxVnl7uO?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1132923-5a4e-4225-6504-08db7f682758
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 04:02:31.7944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Gn7PyVs68vcAZEIpv80yaTsNuKcoNbLOWTQFgMTPwpEsz/OYx0NyW0Cx3VOHjnOpKPCFCWJb/YNlCDjB0ARhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3419
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In response to a disk I/O request, Hyper-V has been observed to return
SRB status value 0x30.  This indicates the request was not processed
by Hyper-V because low memory conditions on the host caused an internal
error.  The 0x30 status is not recognized by storvsc, so the I/O operation
is not flagged as an error. The request is treated as if it completed
normally but with zero data transferred, causing a flood of retries.

Add a definition for this SRB status value and handle it like
other error statuses from the Hyper-V host.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 659196a..7f12d93 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -318,6 +318,7 @@ enum storvsc_request_type {
 #define SRB_STATUS_INVALID_REQUEST	0x06
 #define SRB_STATUS_DATA_OVERRUN		0x12
 #define SRB_STATUS_INVALID_LUN		0x20
+#define SRB_STATUS_INTERNAL_ERROR	0x30
 
 #define SRB_STATUS(status) \
 	(status & ~(SRB_STATUS_AUTOSENSE_VALID | SRB_STATUS_QUEUE_FROZEN))
@@ -978,6 +979,7 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 	case SRB_STATUS_ERROR:
 	case SRB_STATUS_ABORTED:
 	case SRB_STATUS_INVALID_REQUEST:
+	case SRB_STATUS_INTERNAL_ERROR:
 		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID) {
 			/* Check for capacity change */
 			if ((asc == 0x2a) && (ascq == 0x9)) {
-- 
1.8.3.1

