Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7E788DBE
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Aug 2023 19:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243352AbjHYRWw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Aug 2023 13:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbjHYRW3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Aug 2023 13:22:29 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020021.outbound.protection.outlook.com [52.101.61.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C521211B;
        Fri, 25 Aug 2023 10:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdFcEG4aWYxP9+RPLwyE1Te2Ts1AlfN/won15p+RYPY4XtZi12VkM1qUEyN/ue0OtK8SoM1+JsP/0Glo6e962cY+6I9uHtisl1+O+yusjDkrhwjihlL6LCiKj2psekQJEAo5lX7COoOclRos08ZRxG26OTyTT/gD4vG/FDFW+oQ+tRijo55YThtDHjEImoJq5aEt5DucgBs24Di5dCRDBDBYuz5GUj5mIv48DP5JtMWXZ0LWgYcd9hrT7C+ogx6Mcwn5mDzey1Yp0Zv1t1UdoOmRVGccoqy//Op0WJCLmcz4pfYxWSj7CiEi3jbbXDKGpbH0JMN819oG7Kw1jOp7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZVfnhaS5Oh70SY+X3b9YB/OXDgSwdUlw0LzqJHczSM=;
 b=hhyoD+EJasZBKS9fhU28LA3x3/vLO3gBgjISUB0M/x7IQTy0NghRBvcJe+eQdBwd6QGO6FzNZBO9hNTAH7BfGcscBXJgb3c7Gr4whzHvx9z4kZv0DbdW7edAUmSIb27JCUze9iPh/hvushR5oj218cwEzciVypncCd/t6V+GkAX9O5vlSOmFzLcEDIchX+2gLXHiJkvJJAbv/V0Trhv15CShW0rk180wdEw9UDgUm/W9tGElXZBDK2EDkNZH5i+wOCZJAED60T6uFakphTWTuMYyI3SJ2/8vkNrBEfxPF0JdmQ81Zl2b2IvNngKPQK4iS270xYTlUXXNSigro1UNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZVfnhaS5Oh70SY+X3b9YB/OXDgSwdUlw0LzqJHczSM=;
 b=Nn2tZ+wTYZl1e5IrlD7ctGT+7Q9MY/LS6tOlbY69eXQa1f4HCyLfxCa/XwcDcK3PHMZUSPF5zeY5szPP2Q+Dj8bUc2rIOenH2RzLuktHgyC//Cj900Y5yDBiDi5hIE5TmAxVvhPU4jE7mEjtawU+BW4flFgBndiRzWsiZ4Qyh+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MW4PR21MB2074.namprd21.prod.outlook.com (2603:10b6:303:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.9; Fri, 25 Aug
 2023 17:22:24 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::e42b:9288:e798:a524]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::e42b:9288:e798:a524%3]) with mapi id 15.20.6745.008; Fri, 25 Aug 2023
 17:22:24 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] scsi: storvsc: Handle additional SRB status values
Date:   Fri, 25 Aug 2023 10:21:24 -0700
Message-Id: <1692984084-95105-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0222.namprd04.prod.outlook.com
 (2603:10b6:303:87::17) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|MW4PR21MB2074:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a248d7-4a3a-441c-d93f-08dba58fd8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGozXuUrJjba0EhGBpfH6k323DOXZVjH6o7FRh72ROuOIoWJhcoHyNfRU5uysMyNtvUrR2LaDcb2vwCKCdMbIjQVvlxy+g5caLzahZyKIci/efBGXTrS/YpHEr3ujPauO4FduztiIVstXa9Xd7VMFIuDq2ZNqAHaRAV4eEEMDVgt+QEXGfYyhug3IpL5N7jaPPV62PL3Vd9g7BbxXjpBCfhgxnmhQiN3EiKxmFgo5lu8MoR/482SAWdzBl+ymgaWSiMPjJ57LiM8jdKW5nCgKXQ2WPt5netcmOEgaGRQC0QlUoKj1MwbbC/eRBaYwTjxHzIhMMNpmJPkA5cSi3h9Ct/4d/Gf0xSeDiNtdADeHs4G2uUzaK8TgqGksRNRUsDKvk97CqzZrAyrhkWtpn74WURF1W5dcpnP8nQRErSdBLfZLJ5iAgItZjsi0kupRp52ySiUHOE0PtvazESukwMiEbrRXD4kJrZIxbnQ5LrzO6sqMIUn1nsHII0xaRTsxer9ja6JimWz6i/Gb1Tn8Y9LEHSnB8taoIjU5Bmmzm50Y6iHiJRhqksASqBFWibLhhTFbXY+rn9Z5+f5MtG9iDs22y4XBVMgytslAfGzSNakZMdfs6OoxUHY+3GaxrETprOKHgoU8yUjIWs0YdZYpUQEUMqsdPYhux1/qRIATxJbfZqEEAr5pdTfuhhOCv14gz9E/nTCgJk03ItNzJAoAFW1Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(66476007)(66556008)(66946007)(41300700001)(316002)(36756003)(478600001)(10290500003)(83380400001)(2906002)(12101799020)(2616005)(8676002)(8936002)(82950400001)(5660300002)(82960400001)(38100700002)(38350700002)(4326008)(86362001)(26005)(107886003)(6512007)(52116002)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y6R8pRPLtACHrPfGGj0rtswgPwy/RWXwRUABfzSPPLzZSTpgpmhAerS7mHHn?=
 =?us-ascii?Q?9r4VZUXAurwBywBpQo2DxjlAqp6X1+TBmr9ofy9ZjobJ00hvBvjReW4GAYSo?=
 =?us-ascii?Q?9pyLwnMRGEb/OECdzJJXOkrQc9drLmjewQ+INObNrK380dhxZQ1F0zKYwGXt?=
 =?us-ascii?Q?EBMJ6wM2boSMT3D3ImPh49omNYHlI560ZvnKJmaFXfeEzk0tFLbdFjGHtgD/?=
 =?us-ascii?Q?HQ96ptUOrW88Z5rijBb9z4Ab4W9ciBsR1wYqD/9QueZLAdBjuet7LLOv5iWC?=
 =?us-ascii?Q?Rtjr1FgJ4LNgInDHGFfc3vR5V4Aq/oe0Vlc+YzK0gG37o2onIlwt87o9mvyW?=
 =?us-ascii?Q?hZGsyk25uZDDnitj/TfTBfq/iLFZZ0jPVLl1uruOk56BtzqB+6n4X6+orIj3?=
 =?us-ascii?Q?QwYh/d7d35jN61XjfKfTY1VCNW4ccNn8BaG9K54OWeogLqjkfspievWdu+lt?=
 =?us-ascii?Q?cMakEj73ivPHHX3hxtuTA8pG4AFCUdsG/syUa6m0xMfPtnGIvcNUqEEJzQox?=
 =?us-ascii?Q?7PwN9OKFkvxKjDDcgTgg17V4FfC8wvf1qz7g0nHwCxizn/DvRGiDW9+Y1wc6?=
 =?us-ascii?Q?rpPLNXF1RYHCIPp5QheBUZY7QGLapRiX7b7eTTYl/N/KZXmcm0rH3wVvjPED?=
 =?us-ascii?Q?OW7IJUhlMWlM7uusfe1FruOEScln1NqWAkzbJB2xNO2QXdKIWYKnfnCPtO8V?=
 =?us-ascii?Q?R8ySWcJdDaEZlHqSClafPv5cdWUN8nHW+Y2EiW9UuzDqFM4KDdd5S929fgYR?=
 =?us-ascii?Q?ZfP8Mj6mnP7Zpeo59nq6kUQvdXJ7QBEBufC6Kb06OPZpJEDm1Qxry8J0guK3?=
 =?us-ascii?Q?buupUkmP/j6RgEsTI4LYFlAcYCga4LfZkk3qM/FmMWPnJbHnHvNtZFB4Pm/C?=
 =?us-ascii?Q?eQLsEbFWlUdYN4LxanpUs0+Uw0ASo+awQi5OdRFq6orE+f2uIL0BZwwoMKRS?=
 =?us-ascii?Q?5fcz5DSKzEDNpzcjtFEwrVkTiP3r5pIRDLjdWDOdjamUJYLr+MoULnM5iZwM?=
 =?us-ascii?Q?5hz6mtZFxzPP9/PMvyTxuLo7vwCHAtJ2/E7mea0tChonV0YtEchHnpVYfSuj?=
 =?us-ascii?Q?5BtGj1+T+7ew96v/ZqdMIWYiKxKKcOh6zvpzBSV2HGPBCBBFIAMYEv9ikOa6?=
 =?us-ascii?Q?AmqqLnoqavJfDmfcR3CW7B3Zj4x8b1Lwz/YZekRQH3WdsclvON9O7jeFhg+/?=
 =?us-ascii?Q?9pQXX+XXo0K33nYDI2Wvj6Xn/C42Cf7TIbYDv4y9OEfvFPAFlhi6zXiVjrYG?=
 =?us-ascii?Q?3Z3cMz0SNHa7Jr4TNnVtJE4U1e+dUD2rv/uyTTbTT/1iQuHmkEgC4iw3fxTO?=
 =?us-ascii?Q?qma88LNmVGT8jzh8InBVP/iCinNN0TAVXhLi+zzi0MGjWPlJF8CDwjBwPOuu?=
 =?us-ascii?Q?6f/Jg8Jgmrzf8lQPAa8CMDOqUPw5ZlZuW+3OZGGZBxESHxRKbdY2IRi5KggY?=
 =?us-ascii?Q?63e4wPhV3wHEUTU10CxsJP8HD/RFs48yFrt31t6XlbHhi+8Cwsn4ZzGdhNQn?=
 =?us-ascii?Q?Ml9DQYHrEfm2hOFEzlfBE5RaOSXbsjX4mDzcAHvSWbHAZeaR1CBo73Jhpuyu?=
 =?us-ascii?Q?NRqtc0A1qhzSywHJhi0zP7wKPyFXyX4/tV+YUupK?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a248d7-4a3a-441c-d93f-08dba58fd8b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 17:22:23.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QkSvlElez/KW/QNDg4KSE2kfxpQ3C4HpVzrCPcXPnJ0IDkgjkXzlhUQRWHeEyz92IO98E2IBK6dXABPIP4CCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2074
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Testing of virtual fibre channel devices under Hyper-V has
shown additional SRB status values being returned for various
error cases.  Because these SRB status values are not
recognized by storvsc, the I/O operations are not flagged as
an error. Request are treated as if they completed normally
but with zero data transferred, which can cause a flood of
retries.

Add definitions for these SRB status values and handle them
like other error statuses from the Hyper-V host.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7e92a48..ab286c1 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -316,6 +316,9 @@ enum storvsc_request_type {
 #define SRB_STATUS_ABORTED		0x02
 #define SRB_STATUS_ERROR		0x04
 #define SRB_STATUS_INVALID_REQUEST	0x06
+#define SRB_STATUS_TIMEOUT		0x09
+#define SRB_STATUS_SELECTION_TIMEOUT	0x0A
+#define SRB_STATUS_BUS_RESET		0x0E
 #define SRB_STATUS_DATA_OVERRUN		0x12
 #define SRB_STATUS_INVALID_LUN		0x20
 #define SRB_STATUS_INTERNAL_ERROR	0x30
@@ -980,6 +983,10 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 	case SRB_STATUS_ABORTED:
 	case SRB_STATUS_INVALID_REQUEST:
 	case SRB_STATUS_INTERNAL_ERROR:
+	case SRB_STATUS_TIMEOUT:
+	case SRB_STATUS_SELECTION_TIMEOUT:
+	case SRB_STATUS_BUS_RESET:
+	case SRB_STATUS_DATA_OVERRUN:
 		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID) {
 			/* Check for capacity change */
 			if ((asc == 0x2a) && (ascq == 0x9)) {
-- 
1.8.3.1

