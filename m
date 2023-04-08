Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5886DBD1F
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Apr 2023 23:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjDHVES (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 8 Apr 2023 17:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDHVER (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 8 Apr 2023 17:04:17 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021024.outbound.protection.outlook.com [52.101.57.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C49758;
        Sat,  8 Apr 2023 14:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+yLu9cEbSL/v4/VKhtTA7D67wzO7kvvjivT5d2T3Pk7stFSaB1s3FggVcjZlrXaCiHZvURG2VGNcXQUTCZXxRCN+A5vVR9u9kMCZl4Nm5oVCL3ntPq6XDcNce0B471F/SvADsB5np2G8FRxF+G8oytE0/ClJXlHQIwOB9xXAkEuOwb5PUljNUfxYEyMCkw3JBLTh3ZcNXEKgj4fZ5I8D4VrklFZ9b2xCes2uipRbHGFA72BQUtrhMfJ86yoaret97CJSmvnbowqA/qskndGNsv0ECxkwVc0p5zj/ov5JN0z4zQLlxvOyMqC0nZz2pMewtzXMrKNwSOoFEZoIQUAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqFrzmZJD1YsHtTBjw3KnMW6cANlrpncaAp338SlGx4=;
 b=ISZRaybDJ/yx/5vWtlXqmoe5xTENcUxSJVqsgL9vveZB7vCQ883au9uD4y3gZ+yUnPnPdIBCnAhqrPvIpUh2l1ZutjfwojMwITsU7vmyF8+9YiC7G5xlH261QDwoPgT1l2zrG+ygh0SbhplYMfuuDqsKGWcO2QXAaxLdgj4UE3OMmshQgA7Q3SykUUggadfjC2JUokYerdljZUMIBXmvYtmryr1+nK/uZyzen3ewlsqBkve4UPs8jMx5dIa0MKwjnVBBqtntNNh4k5n+XBpX58UsNs2tGxLI+EBfIybdXHebOlJ/pI1zMvzpeLMeBIhOsLq9cV37Uw/pXVWQLdC7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqFrzmZJD1YsHtTBjw3KnMW6cANlrpncaAp338SlGx4=;
 b=JlghanVHVmhjt6gXhCM9Y1oePQMqrhb4ZC0Z1sOHlf8e4AuApzUrPnbZAPpBeSQKvgNjqGD5/rbkSXSfupYGlpMSv6CFqgs8fvN7FY4XPyC4H6a0xfa/OPKb2CLHnyFByTFVPdYvYmV27u7K3r9msJmlqQuZUU3Xv0TFqidIYYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by CH3PR21MB4016.namprd21.prod.outlook.com
 (2603:10b6:610:178::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.1; Sat, 8 Apr
 2023 21:04:13 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7%6]) with mapi id 15.20.6298.017; Sat, 8 Apr 2023
 21:04:13 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: hyper-v: make sure Invariant-TSC is used if it is available
Date:   Sat,  8 Apr 2023 14:03:39 -0700
Message-Id: <20230408210339.15085-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|CH3PR21MB4016:EE_
X-MS-Office365-Filtering-Correlation-Id: bf045407-3bdc-4378-53ab-08db3874cded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gA/CFN05bgatktS5OF2LQ9KZn2mpBvLclcuPVLWdpmyC0PEGrcc9H70dDdi/luvBrWD0SndbGtT7e1jHurUrinsl4CwKmbD+SnJ9QG1rsV93+3+d1L81IIn//N9Du+KluZNHGDcvQI/7j6dfGZmzXtQyWqQMO7k2MUkv7e17AEMYlMJNUB5NURTrZyMJAthgDDwAtKJnOA42SJuYF9rJXvbt4OKqGzl6ksIUj5uXt5k1IIZZoXMeClDNmIx5x3NjZPl7flDEpxCjmJe6+hyB5spkF/ynOGE17NhJCyHyaQL9UbYENVdkok244kTrn8hpaLTXt6jhqbfkLdRhCEjCqe1Wgn/NK1dAIFSzIXrf60Iz+/DHECJok+i0TXMb/PswIo/BRxDLqx9zhcliNuEfoTEgCrhtvKcqlhasktXxZtzW6lf+pw00BAEwOLkU3xsGgLqsgGxOKKMAP+fe7lL026o2qVPWe1i4Dt899ya3+YYJCiu+QwWV8+K2PFoTuhenbcfq2TtV7ZCQUXmPaQMtNofS6qdpBTdcvU876zVXCjyBd+aXfR5YZO5KyMEwuIDOQNIj9/NP7QjZ2k4Xs06KqbVVqiZK0qvmj/u/kahkxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(786003)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(6636002)(5660300002)(38100700002)(41300700001)(82950400001)(82960400001)(8936002)(8676002)(186003)(83380400001)(2616005)(6486002)(6666004)(52116002)(10290500003)(6512007)(6506007)(1076003)(86362001)(36756003)(2906002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOBg/fxFenTRpl18WGGF27qSddNdxSuFcMmDsmsKt3OWEhn8a82Rd+RPuxqa?=
 =?us-ascii?Q?AuQIFKRqA4eZNX8p50UGHmQdiUTdh/g+m3bcait6iczPnItDwilovCOhpUB6?=
 =?us-ascii?Q?OeQgc+qiBB5hlDXQfgZ/Ar0A9NSXswW4y8lvv8+8Y8bqRy8M4hKoEQHW1tPx?=
 =?us-ascii?Q?SRE7ahWSmczKOG3aRID6ekArASL2XcjPZxeIp4HTC+tVy+PB1B0sVZ8i1kDR?=
 =?us-ascii?Q?SaNeLpTYfA5b8GpPKaccC5ba0/TSszIvcMysKm57NR/3adt6bgmMKMZct2Re?=
 =?us-ascii?Q?6vwO3STz9GjKptqhFH/ORQfjfaNVOhMmdKZTbPimUAvorlXzMHAMqYR4QqXL?=
 =?us-ascii?Q?G+VIggL6EfQet82N8wJLKINaM2bU13MOItuAvQpskRgWYZ41SQzDiau2CE4f?=
 =?us-ascii?Q?W8LqjvjlRgq+nx97J0PROG5i5oWL964FOJwcAQzQTBgPENNZosOrnv9k6XFQ?=
 =?us-ascii?Q?sjF7HrPU9bsUnYjIJYsxr0bUdV7dHQtc89ZsCOWpac+nE+iBKBXMAnEBIJLK?=
 =?us-ascii?Q?czmkQDwKv9WHdbS+IH3k1vgbEXGPIjXLjUPmc86hoq/nz0tQ3W6pZee82pq0?=
 =?us-ascii?Q?0cGEFsmIpGFfr/C8i6zZ0KjcjXOjB5xedlF9dN3+88+cX6wszgOXpgqx00z3?=
 =?us-ascii?Q?JwXBRQSIjGsb7NmqI3Ftzj7OWG4qZ+QgISKczy2LLZuAxnNE+X+EPI1uXP10?=
 =?us-ascii?Q?4B3g9JOz6R7Gx6MlrU4vrjvLLhFZY0SeusoKzftJZzQXVFBxWPwoPfc4bQ64?=
 =?us-ascii?Q?10U4DaYng77A9SIxUovQRZz68JhVUY2Nk/t1MoQVxZ5mvVSObT+j3eHk1FXu?=
 =?us-ascii?Q?00ll8nP2iRMakLB2+XP/cWE1ZuSRNzJW/V8FFBz2NIY9DF3TdVuNlDsDE1JJ?=
 =?us-ascii?Q?8IQI8rEAnquaIfZ6v/8ovVzLcOQY0jjxOReg1G0qvMjukB0M1Py9/x8b2Tqn?=
 =?us-ascii?Q?h8oNAZhL4QJ/cHx4yEnsFp6suy7SHIHI5Q6viuQtQNyPgorjFfL9AxVmewPV?=
 =?us-ascii?Q?6zIFwS+gDSQrsRWnnbjXLLIT0hw3eLOYx7gwTcRXHSRzbdGwSUusQ63Le1FL?=
 =?us-ascii?Q?TlCmMbNQWIzbX/Q1uCT9lKFeKscG4nNOm4HumfwCdqRifrr8mN1M8utLPs3m?=
 =?us-ascii?Q?ew1wkqL3KDZPsdmcuf/793JWzZhx3n/hpGZM8bJcg2yWx7V30fHUXhufL0Rh?=
 =?us-ascii?Q?BUHIJYq64cYt576u+Tj4Cyahs+PCQ0e1/7LF6UHVtEmLm0n+sNEIrHVoss9/?=
 =?us-ascii?Q?2d6bA+kcAXMkTI2eSzvRRtrhkVEn8cz7cxNqoSdms7y5BeIFw64kIowJF6m9?=
 =?us-ascii?Q?J3Y7tCQ5JPF13RUQDcWonC5HM1pCxr4U9FINc34xygsMxglR4SvWsp2mNqzy?=
 =?us-ascii?Q?ZNTTZV3X2Env2TYJc59C2YNPN7GvSXQiJfojY5MEteODCqFrZ9lwajXH6C/X?=
 =?us-ascii?Q?tJBG68723tAA4TOBtWe6qYHoLr3/wMB0b103eCw/hLcpiKi4HOKg59wP1Fxk?=
 =?us-ascii?Q?EIHTWAJVPq5qLEriKRfZHuXiYFsdOlU1ig9LiPEgo9DaoAUNEL26xbZnEPbZ?=
 =?us-ascii?Q?itX0n+oLRTuDa4fcI2am9kYjPysplWyWWPLtr7/arJCojmv3ltvytqmJkRDj?=
 =?us-ascii?Q?BsAIpmzCRv3o3NmtXF2JaHoeoeFgKBg8tskLdbcSLBar?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf045407-3bdc-4378-53ab-08db3874cded
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 21:04:12.7623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdFD9NEOuIV0PvlbuhejoZ8R0xwSvzuSp7m9zaA9XHcy6VVC9hLN4Ao4FzeexHGWfb8iXOCIWQscgMJkmf4EOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4016
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

If Hyper-V TSC page is unavailable and Invariant-TSC is available,
currently hyperv_cs_msr (rather than Invariant-TSC) is used by default.

Use Invariant-TSC by default by downgrading hyperv_cs_msr.rating in
hv_init_tsc_clocksource(), if Invariant-TSC is available.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index c0cef92b12b82..7901a88ad9188 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -506,9 +506,6 @@ static bool __init hv_init_tsc_clocksource(void)
 {
 	union hv_reference_tsc_msr tsc_msr;
 
-	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
-		return false;
-
 	/*
 	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
 	 * handles frequency and offset changes due to live migration,
@@ -525,6 +522,9 @@ static bool __init hv_init_tsc_clocksource(void)
 		hyperv_cs_msr.rating = 250;
 	}
 
+	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
+		return false;
+
 	hv_read_reference_counter = read_hv_clock_tsc;
 
 	/*
-- 
2.25.1

