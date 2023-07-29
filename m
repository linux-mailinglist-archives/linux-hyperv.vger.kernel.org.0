Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F4D767C41
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 Jul 2023 07:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjG2FAj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 29 Jul 2023 01:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjG2FAi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 29 Jul 2023 01:00:38 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85898198A;
        Fri, 28 Jul 2023 22:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vqm+PzbjuAGK4ck5Ndcn1K6555Z4euXotEOMaLvSOHl9DO1edHzm+941yf5PvLiwU+ZM6qIfREGAbfWlLoMuCcYc2FKNT8cqp/yNRfyLWel+vH86FvSjHchm7avlXDBs48WAk59FnZArXTSpwSYvbVQu7F/Px21rQ1bzab4PxzSrAP5b6n34fZCaWEIgTu5tTy+056/TXNbmDvtrNGopT1zUKHV7FMbY2jNN4GtMw6+TwCFzGmX2Mp2uxlPVUL6lQDo5eOr8IK5rZYFXq9zO/c2jRcRH7kHmaT6HjAHihNLcmbYqD0S5omBvaS0z2GP5z4abHOxkfQ+SJlmBrNffbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsGC5ioudJZY3t6dlLpp0W0SIeWGXgiUScOgrgAzX/8=;
 b=UMBsbaX3eyQ0KeK032+tmzMN93bzGfLfv99A9628/PjiWGxBFgi6DGhVsWwPQh4Q4RbhcgKdp7Y+5YeCfhdB0YfpSHHHNc3uIUg9EKSVanXS0TiRyfnrOa/sFtd9G42O+JPMbUKWoMii2j7LkUO+ugedNpqOhXo5B4VWtjbU5fpIN0MyQazu2fJafKbmBQhKe7nxa1GPGH37r3Lt0aP7zsb05HP1ank9HP9Y/y8NwseahRRGGVx9fslmV5hlBh/x2/z3BEZxi2q63262bUE/dM2MMOwP45AHW+OcdWMNBJU4AyvTktxaHymh6IPGVEH6kfnTe6E1Oy4UhF6ShN4hUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsGC5ioudJZY3t6dlLpp0W0SIeWGXgiUScOgrgAzX/8=;
 b=cYfCBIQKSKwoPLGPKk/0CX2qE0dagqPqj/jwIvUbWcuA0WpfVyHUXPoVjiZECsRT7BuFWJ7c7gabT4uXX8rMGQEO/ruwEc2UFdZMC8kdxEvbbEeFmBXwwq/en6ZDxeTqsS/YCKeYfchND92PcvgEuUYo/7p5NDnZBmY+VF0jvSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MW4PR21MB2041.namprd21.prod.outlook.com (2603:10b6:303:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Sat, 29 Jul
 2023 05:00:33 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::58ed:9fb:47a9:13df]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::58ed:9fb:47a9:13df%7]) with mapi id 15.20.6652.004; Sat, 29 Jul 2023
 05:00:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com, stable@vger.kernel.org
Subject: [PATCH 1/1] scsi: storvsc: Fix handling of virtual Fibre Channel timeouts
Date:   Fri, 28 Jul 2023 21:59:24 -0700
Message-Id: <1690606764-79669-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:930:16::26) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|MW4PR21MB2041:EE_
X-MS-Office365-Filtering-Correlation-Id: de57aaf7-218a-4700-426e-08db8ff0bc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24GRtCUboLZImHuTnn//KcBoGatQfrLeXiX0NSaE2sUs46jcEyjEyPdYAz+Po5DA3iZKrfmRFdhgV76OkAusNwL4IFyF5LN1ETACaz0SlCoDFdjzgsJTAPL6t4CrEdeeq6c5+yoDKn6AQmxSoS8HkckdHPAWM+RYfcUkeuBl2G8tvMRijsOYRBjNjoweAOnpFi6g/WlysHnIP8QAfdfnIstsxtrqIdm+S6oM4qnT8iJS/7dik1kaOKl2DGu2IKh0FZs0ChE33xpf2MWZl4eIUo99poT9KFBK/zwCyvCVV6YE7NXchGMtqW92fXdYQaegogRoBhclV3URRMo4tiAOwnd+KgxNQZ836SXJsK84fP6G8T56kzSRg8yKUUUkL+WHC5TwGfINU5g73I2Mkx6n5a192rBygKpVQSEN4CSHfLztEiLBCtWUbVO6iYJ6xZ2sHxxk8shVShNMZvZQwcnGP22A6rQzGFWU0xTMkSO7adTPB7x9re6yPjujI2xvz1iN5wW4EyZuZnWajxejgSHcG2mm/4IDaU3+h07QnewwdE3l3XJmriSNGdGZe548dMsAVcLeuaEO5zuN4ztdthdN+i73HF7/l14EUx3kFERYGktLOXJh01FeTvs9nXiBWvbXOPPLbtaUH8MJCNrY+/+0g4kKnIkSFOI7FpfnW2SiRRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199021)(36756003)(86362001)(6666004)(10290500003)(478600001)(6506007)(4326008)(6512007)(66946007)(52116002)(66556008)(66476007)(26005)(6486002)(82950400001)(316002)(41300700001)(8676002)(8936002)(2906002)(186003)(82960400001)(38350700002)(38100700002)(5660300002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YBs2oK9lF3+HxW0qb5FHNdn/1qj3rpZNCNRFza3syH7RtS/SffFvLLJv49kU?=
 =?us-ascii?Q?dI4D7knLy14ycrEsn0Cenm1QUkNan/8QTqFM/osYw+nk9Q3dGIfwHgJtsVc/?=
 =?us-ascii?Q?gFWp6V/FnoOAUPAlg1T8Ox2LCICiBM4ovydJrSJ8vfx54WOSwl3jgsbQmLoF?=
 =?us-ascii?Q?T4p0syza8Ff0EZl2h2beGou+HEXu+fyLZbeGJA92ZyiAzOBWfcVKS9+PwemT?=
 =?us-ascii?Q?purDaHah6M/luJKls1nNWI73tev8c00G20paAash3aL6riX3GUUUlUUHMegf?=
 =?us-ascii?Q?ClEm8Agv44M/EU62uMlGyAud6/EVFT3SMZv/gWV1Y1acoBuzpWOPPBB0qqX8?=
 =?us-ascii?Q?WrXmq0JNDLO5c/jRrrCQgNKGl1WDENTjmKFDhJAa4pmluG68rZbD2XIPQfM6?=
 =?us-ascii?Q?08WJaINGJeExXTyQCGiLw1TmsBcoIf7CK+C3f84vbZolVITdLV9LWXzwSVoA?=
 =?us-ascii?Q?A6rDd9D452I9q9dD0GGkN7SkiRoSmfHnVzUlpFZ0oX/hCpH4Egd8vJr8/T4W?=
 =?us-ascii?Q?Ct/UpW919LjhmDr2XMWzGs6D0r3qAxts1z+hpmwSc5zX7FWWNyzbNii0dl1D?=
 =?us-ascii?Q?1QI3X5cQGgQC+8HBb4TCVOE8x7ito+amAv5O1KFdJslnucrXrK3rF1rhaMKy?=
 =?us-ascii?Q?OIDCsH+T/wdMO2/MxaB43vNwejQ6YUZrHP+IjX0Z5LIZ9ykMbQNOIDb/zNLe?=
 =?us-ascii?Q?p6kjWMtG+XK9MEt8ZjH4YZTFGt8ed/ladFhz0TVEVUVGYl7fU6/P1G87OVJs?=
 =?us-ascii?Q?bZ98es+29N8/tp/8FUHdy3eKFFep03y9qwjazcoCEh/7orlX3jZIMTx1Tc9C?=
 =?us-ascii?Q?2jD3dykweIyzYgoFz6UOf7s/WUrCGMuQqIp401zq6JX2wZBETiUEC/xAyvBy?=
 =?us-ascii?Q?8eZvmDJe7+8k9IdBJ9+/zaABUBVZpfxn+rTkNi6bHlRmSuM0kdOcm0ldDVnc?=
 =?us-ascii?Q?U8vjoE/dFgvk20Pro7pNAxuKCwj1qiMxzlnRzv6NmOr0oukUDXgRqeFjXMe+?=
 =?us-ascii?Q?XscHUXvDevFbl4sPN3nEWurIbH02qB/CrgxSw6Qhe5A2ud12sduIY7Kfa9c0?=
 =?us-ascii?Q?p2vX3iBzvifYHUhrCweyunSkCHPb6Psc6vwoqfC0fG556vDefELJ6OlMFgyd?=
 =?us-ascii?Q?JYPU+wb2QCvUff0h8vupT44+IotpbXjipgOIyffRuE5N7CslFtFOuwTNuiGz?=
 =?us-ascii?Q?deYhcml1VSIDMYltCr6N05mo/ICPK/nHv7g0f52TMfQHbWkICbgd0Qjjoo5P?=
 =?us-ascii?Q?VvSBrZYJP7F/COHaLbuUKRibOBTFGCNMPJs1GRFn01EMtTK+4jbyDjpexhFA?=
 =?us-ascii?Q?p29Xr4YRR5MKQHGEUQaP2j2b1EpAYmakWhkFWZnP67RNbZboj+vCu2vjysSL?=
 =?us-ascii?Q?um6OE3qriRXr+lIpqiicSyQNDAggNd83yyobfHEONL1ET+sAyi3OagLaotlB?=
 =?us-ascii?Q?3zvCeJi7/8RNOxj7IxaKB/PwVK/5/2ZnKfZd9UL22Z+203zsFUNaQ+Jo7RPe?=
 =?us-ascii?Q?/jwcSK3VlH8/1E6QaX9zuix/96sQ09VQasBWOVcWR/a68An3PJz+wmu/BLHJ?=
 =?us-ascii?Q?38e1L9DgnU8KRr7jlVlduYLRYgD6ldUEIRih/Umo?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de57aaf7-218a-4700-426e-08db8ff0bc3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 05:00:31.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbSgqMYcETrJYqC1xryeyoJipo+5LkhdN6bKmFW/hrBQHd4E/8Ybr33rSzz5fmZuVAqdwOV6kGw1lK+Za4vOoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V provides the ability to connect Fibre Channel LUNs to the host
system and present them in a guest VM as a SCSI device. I/O to the vFC
device is handled by the storvsc driver. The storvsc driver includes
a partial integration with the FC transport implemented in the generic
portion of the Linux SCSI subsystem so that FC attributes can be
displayed in /sys.  However, the partial integration means that some
aspects of vFC don't work properly. Unfortunately, a full and correct
integration isn't practical because of limitations in what Hyper-V
provides to the guest.

In particular, in the context of Hyper-V storvsc, the FC transport
timeout function fc_eh_timed_out() causes a kernel panic because it
can't find the rport and dereferences a NULL pointer. The original
patch that added the call from storvsc_eh_timed_out() to
fc_eh_timed_out() is faulty in this regard.

In many cases a timeout is due to a transient condition, so the
situation can be improved by just continuing to wait like with other
I/O requests issued by storvsc, and avoiding the guaranteed panic. For
a permanent failure, continuing to wait may result in a hung thread
instead of a panic, which again may be better.

So fix the panic by removing the storvsc call to fc_eh_timed_out().
This allows storvsc to keep waiting for a response.  The change has
been tested by users who experienced a panic in fc_eh_timed_out() due
to transient timeouts, and it solves their problem.

In the future we may want to deprecate the vFC functionality in storvsc
since it can't be fully fixed. But it has current users for whom it is
working well enough, so it should probably stay for a while longer.

Fixes: 3930d7309807 ("scsi: storvsc: use default I/O timeout handler for FC devices")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 659196a..6014200 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1671,10 +1671,6 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
  */
 static enum scsi_timeout_action storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 {
-#if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
-	if (scmnd->device->host->transportt == fc_transport_template)
-		return fc_eh_timed_out(scmnd);
-#endif
 	return SCSI_EH_RESET_TIMER;
 }
 
-- 
1.8.3.1

