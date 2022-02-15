Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809434B600B
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Feb 2022 02:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiBOBhz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Feb 2022 20:37:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiBOBhy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Feb 2022 20:37:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D77512D203;
        Mon, 14 Feb 2022 17:37:45 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21F0padx032130;
        Tue, 15 Feb 2022 01:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5RTb2dBN+qNthdU2HNPd5GQhpWiFcGg9xn9JjonCMSM=;
 b=SQfp56m3dEkIKM4Wi2NqVgZK9sQ6th/WFSMjbEJvL3y1hwEzCfKs1T7buWvEj9VKeojj
 I66X8w2xP5pojBWBCDNbNHie2Rczd6IOYgO++xuCv4uQ5NPIjkt/Nm3781pPAZdCPXey
 NK6GpmbpfahssnkpHeiUcmjvbJ85bCMBH708A0M5PeeS0OgrR/YjEgAltCeMX2gIP2/8
 +r8dzoxjTMGwjoAEG/TNuYzwBxp3Pj6TnBQlTCdK0LRNzPwnZiduNYDb2jh8nn9r1UZP
 m2aVeaNf/phKtAhamT6xhZmwG83X8rzpgwdMB/XRM7zfA1omzASELSyGmNlk6OBZOJNJ pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e820ng1n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 01:37:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21F1GR9w194973;
        Tue, 15 Feb 2022 01:37:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 3e62xdx3r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 01:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY+DCoZEo1wSycAik4NtMhU2LJyY/Vd1RqXaY6fyOFGrciihBvUsSnD+iCVORtwZz4nDinedyaQcmJxNQl1UNXXAfifv7+RRa82jqPp2jxHCR+BYKjwt1zP9dw+auwXdVW0hWqL0tz+dsGvlOW5OtemKoJvQSMGrNBZgPHUj+wj43QtcBZ8pVy+I99iuN2ACcdLJlddhA8Z+lGqMiy8Ld11A27DZQUvB9fj+7D/3ogrRpJIk9eW5e6KhvfO4zNBTJGHedAXQDw9KJFQwWM2Z8/prWqQOFDcfkLmbfw8ubN0Qk6nBWHJ6SxdsPun0EFMUZxoDjDHi4jpNnDqjh5DeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RTb2dBN+qNthdU2HNPd5GQhpWiFcGg9xn9JjonCMSM=;
 b=S5c3hHmedPaWbxDdA0g5JeROK7e4/7HNssDQHW29kv6Zmmcr8NXFvfejiQs9KE+QgtoT2cnSMOcbspValGUEz8mz7a8MGxjzKhih8Og87kFuvKg5EB9hhE4Q/2bxzvT+MjsEDBa60oHJZA4caIN1dArwG+ZqnH3PBHBClnIRMQSphpmwWbpXzdchGj73UI0iiB9QYC64h2Bafrv/cS2yIU5n/g9dq3R2sAeJaH9qX9iTFehKoeycn2fu13mqXFj9ya9iSkInO6vlBRO4vr3IptF+jeosNqfSMhznXPKUYEI1JXeGtYo74Zdpy7NidKl83D8Okg/jLSaKUJ+VbIDYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RTb2dBN+qNthdU2HNPd5GQhpWiFcGg9xn9JjonCMSM=;
 b=i7yo7xj4cEgM+2ov8/QSUa2zGWhdW88/H8LsgcBR6t3UCstt0VBSsTEot0lhQIHt3XZQDHMTBLOx8EZAeujNUp4yn44a9eQjPCJQTdm9E8zJCDJIZembenOpcedHT18Frdemy5SKeWeomByQwu0CskszRA99pQcQVoWyJTmXq/8=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BN6PR1001MB2385.namprd10.prod.outlook.com (2603:10b6:405:32::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 01:37:38 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::a1f3:1518:4e2e:b69b]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::a1f3:1518:4e2e:b69b%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 01:37:38 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: hv: log when enabling crash_kexec_post_notifiers
Date:   Mon, 14 Feb 2022 17:37:35 -0800
Message-Id: <20220215013735.358327-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::21) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bcf8dcd-dcee-4596-b04e-08d9f023bf9a
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2385:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2385653A9996A3266F83AF37DB349@BN6PR1001MB2385.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdgAtHhCB+L82/SeyNwX96H0Afvzon2M+t5T6pewZNUfVBMT1hsXCIHrfmeOGcWW5CmCoqCmxHUzIm63U8AtMINabEUQ2QXkPk0f9teZN3DTpL4W7Mvun0bs4+lPFf1RKlzGPFFrQb/jnePYEw2c5Rgp2qrF5+yJIKUdrffkMnqsgz+j6H/1nE8OQcOEsA363vxgN20IVGTpcWASQh0l+ehMc34SfGECrrtAech95Vfq9WFRwQq0qu+Z5fYC4/cPZniaJRCrZnjPr2mebzGU5D0JgEzHdr5LbCapRwa1mPskBjQpXxaylfbZljA9iZVErUQq//q1rsys8DVbFSKV5gyb1Nol2Eltqy0+mcmZePzuirI8ID4Ut6Ccrih2qWRhFyc4cCpS9Fqo1hAadvHN6oCzUPkSAD3IFJP1eFrNdk164QPhn48iBe0hZMT14xtIgXbLPDj/uYDneTnI9+/9mV4MAEgEtj65tAI5nAVSrQk06qz+hDx2auWc2sKIASqQGb9b5+TZYlCiZbQqf3kxaot5PU4VQg4FQDR4sgV6Rkp5ETMLfYAK2UyMHQAnjWTVWBE3bFG5usLUtc+q/8dULi4KqV5Ole1V5nhbb7nflcuRcJ0hnhjVglc9gcD0JwQntDmk+fsFAFUWLf+EjiGI7bQ9rQCRjnZsDpF15UJs6hm3LMhEHbpD/Biq93oMRBbTCygxwK1ULzZgBZ8LgCliYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66946007)(508600001)(6486002)(66476007)(36756003)(86362001)(8676002)(66556008)(4326008)(316002)(26005)(186003)(38100700002)(110136005)(1076003)(38350700002)(2906002)(2616005)(6666004)(6512007)(52116002)(8936002)(5660300002)(6506007)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ye5PdqRWHP+cmMFyGbA7GA66jd6uuyC3OQALOMOL3b6QnAfFD8WVO6gvjaP9?=
 =?us-ascii?Q?EWvQK9c6mY48vB/yVt6BD6x250cwUfOhn3lE4STkvj9QVgG/bsg+N/4AW1gc?=
 =?us-ascii?Q?1OQY++g5o+WFSh9ahbwWP+Dxix6SZ45jDR7jvK6PX+WOcKvrCUyg1GAz76qD?=
 =?us-ascii?Q?Flf9v6Y9vBH7lYzELv2hbcqrNjG1FaHmKJBYmtyaPsWAnBrJVPRtE1+DZrwi?=
 =?us-ascii?Q?blbYNg8BLNB3WMCZmvydrD2nPHP0sxW90qtqVkl0ZR5WTTlsgw0j83GwIT+1?=
 =?us-ascii?Q?G/RfK6gyludci7UaO++Ig3t/sFB1D0Q5paVB6nlVGpi4jYzl80Tou/O0c368?=
 =?us-ascii?Q?ndOtb0KCiOtFB/NResw5lNLw+B1JZ2/My9PPO82yIJjrlksbDeGwWCr4BWEc?=
 =?us-ascii?Q?6A9z5vpMheIgaKZMyZbywj+pdIkq8dMZ/2Rr4LQTJOgYzdGTJDDdn68c3vbt?=
 =?us-ascii?Q?qf3mD2BAJqz1c0CCTgHXrs/VD5VniDiJUt8IV7lH+hoxN/3oVyXF8qzupgAv?=
 =?us-ascii?Q?zgHNE2RHXjA0FAtZgJn43BapERX/kfCXRP1CzWNvpgc1IOIyF4WypegY9IfW?=
 =?us-ascii?Q?FiJobzQJM2m+y4QmTr222/Capl1BW/hQyYtC4ylzI2ysX2LrtOBaIBeuF7kj?=
 =?us-ascii?Q?n0xiDUc4QQLGrdO8lsQClmDtWGaCiOC8MUNHY6Wksp7iOmJIbF5bF9oxVv5c?=
 =?us-ascii?Q?xnPrd64q1+fhSx4ABCQxlL6YQsztybasVVj59q59aJmqodIlF1KmqouQPZFT?=
 =?us-ascii?Q?C/Ci0+KZH/XxNz5zR0YCRqqoZVRB4NoqkyNqR/ZtFZK2wS7a5ZW2TGR76BRS?=
 =?us-ascii?Q?WiW9pvjwySwr2Fgoczh2Dn+CJPDc4qzslMnSdSsYhDY/weOZOsKazM1QvqFj?=
 =?us-ascii?Q?akPYi/uperpX2t7XMsJEZ7e1rSQPzw8TMqf9H/LUJAqNV/+y8cykAqVFqQFY?=
 =?us-ascii?Q?9p8aovQNHxCa+x+RpMm8QJXX3M6J8vmIkxpg/si6ZOxrpNL1RzpNxm8HJ4f9?=
 =?us-ascii?Q?IZd8nvlrUvxLBIHwrMU/GHHEDEziVWkaCukKBJiJG1qvOGEJgvF3QXhJMeXa?=
 =?us-ascii?Q?RpRFQjRs2NzAMWviF6VTVY77yewJIssPMkEb9sM8kXiRekEBvKgEt/iWE2xG?=
 =?us-ascii?Q?hod6HbXjjFhRnccd0SuF9vNdgluElUcgJW79P0UzyAiVDePoGErtgFQejQwT?=
 =?us-ascii?Q?wUfullyMNq0j8Kvtb8bgbTYnpDEKP9ZTr3zlkHK69Z04Y4aLk9EQVo7XfGmj?=
 =?us-ascii?Q?LMCu/P2uf+klk4Ouhq0t3m5JbZwojdMX7xwipHv4nl43Debwto+mx3RzrMpD?=
 =?us-ascii?Q?FdE3VM5KCUUuzPik1v4T2RMpjshiJJOo3nagMcDF2qEZny6ME4mYxOU+hUOu?=
 =?us-ascii?Q?9qhlpWla9BUOBSc2jSzouGa/JL8iz0v7VOdwX+Zj5h6fjjmyztwNRknN7mDt?=
 =?us-ascii?Q?QZYlTS6GZaeOmgo65zJjFcqY735OsebTiPsLrIHAHsVodNiYucoYXibWX7AI?=
 =?us-ascii?Q?eitn/U4GK2mweMniM8eiG5SKvdvxaFm/XPxoIF/Kls1uz3cRDB6BjCxn+Iey?=
 =?us-ascii?Q?58LqzCOIbhhAbPmTB+r3D4ekPaB9wFCoMdrLH7LmqHZKKjOFMmsS1Yd58QKF?=
 =?us-ascii?Q?05MFU5YNG3OdSHUm2Eum8uFAd1CD9QE4J/suh0oiuhoUc3TcDEMKRFYrIh5w?=
 =?us-ascii?Q?tMUoWQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcf8dcd-dcee-4596-b04e-08d9f023bf9a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 01:37:38.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkPPPGF4LaN2nKJiJZz+VcTHKGM4sFIYbuGC8UgB0coPtyznwlsL2+snqg7DA7h3f9mZxupJSjck/4BXMTYmu9R5GywQgVOIFFNn29red5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2385
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150006
X-Proofpoint-ORIG-GUID: lMDDD_brBe_jvsrT2D1--4Vek84qa_3C
X-Proofpoint-GUID: lMDDD_brBe_jvsrT2D1--4Vek84qa_3C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Recently I went down a rabbit hole looking at a race condition in
panic() on a Hyper-V guest. I assumed, since it was missing from the
command line, that crash_kexec_post_notifiers was disabled. Only after
a rather long reproduction and analysis process did I learn that Hyper-V
actually enables this setting unconditionally.

Users and debuggers alike would like to know when these things happen. I
think it would be good to print a message to the kernel log when this
happens, so that a grep for "crash_kexec_post_notifiers" shows relevant
results.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 drivers/hv/hv_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 181d16bbf49d..c1dd21d0d7ef 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -79,8 +79,10 @@ int __init hv_common_init(void)
 	 * calling crash enlightment interface before running kdump
 	 * kernel.
 	 */
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
 		crash_kexec_post_notifiers = true;
+		pr_info("Hyper-V: enabling crash_kexec_post_notifiers\n");
+	}
 
 	/*
 	 * Allocate the per-CPU state for the hypercall input arg.
-- 
2.30.2

