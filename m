Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685546BB7F0
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Mar 2023 16:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjCOPez (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Mar 2023 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjCOPeu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Mar 2023 11:34:50 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021015.outbound.protection.outlook.com [52.101.57.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F8646085;
        Wed, 15 Mar 2023 08:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C38wHomTncQxRepBq5+u1Kps7seX7KK7xlIMHRXhC9aaYxK1+0VOM4hAgeadQQYnnPuFe7sBblQmaiLgKSM5YvmmtSP6oNexvr/DxWnHVaIlRN580b1JqjV2l47eyTDNQWpZUx++9wuBVIV15y7di1ZQbujEA56TAsoeU45uyqHj7p0ipVgjT2h2NAndDUfe6FV2aLLzEzlD3VCSJjkcJZ0mPY/4S8+gC1m52tsteVLSuwfFvJ91srAni2hbSwtg0Hyg8bKF5e475IUBpjOF0tFDTrM9QUS/QC2ATN5nOyunQ4wUJlIpmDhgEgDPj3JbNF/29vyyTTG7pJgVuyHSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEvTwbSm+SYNjj3V6awTABgkLvLLqCZ5NqjuTGIdrs8=;
 b=HlGcGUtuL8RWgPqlSoC1AsRL107FuiLKJWNPjFMidgIae/4tUPOjETxwIfzdrES1ppnaVgHR7eZMSpkTzj7u1B/VaLXlG6i5A4k5te9s+fxFG+zBTkJB2Q1x193vgN4g0v/OL4BykmFFDNKa+Z/as7TyEavCWGlYPZXutN3JdurWVF0cIr6YHub32LTz3sncT6lZCyIpZElYhAY5QhDY8d9MLBfzub052VGld1gjf4TRo/CUWwsj0ONkI7O3F+STqlbBVsHfJgoyJkpdLtAvOE4Dbs8qHph2uU8EhRiCLXgH+pp0/mvw5dpCaHlPWigNGwYVDn98OzGd26bm2Zn9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEvTwbSm+SYNjj3V6awTABgkLvLLqCZ5NqjuTGIdrs8=;
 b=FmpjfXlbf2H3RG6pXqSq7W0+yHDxL9mGxEFPkns8mUJjt0CJ5lbDkoUCdUB7bktyNeJSW5g9Dm/kUTBBbfyLNJLWxU2wMJMqDDrskM/+OubQSGaD7hRfve0pJV0tRgrEo0l9epeJ3zCiZkTL/OvkXnMb0n6roOalp+su8pThGFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by CO1PR21MB1316.namprd21.prod.outlook.com (2603:10b6:303:153::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.3; Wed, 15 Mar
 2023 15:34:38 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::caf1:81fb:4297:bf17]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::caf1:81fb:4297:bf17%5]) with mapi id 15.20.6222.007; Wed, 15 Mar 2023
 15:34:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] x86/hyperv: Block root partition functionality in a Confidential VM
Date:   Wed, 15 Mar 2023 08:34:13 -0700
Message-Id: <1678894453-95392-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0322.namprd04.prod.outlook.com
 (2603:10b6:303:82::27) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|CO1PR21MB1316:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d98690-7a9f-46bd-a482-08db256ac800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWTXH9isjdgMrXDEnR2t5tVyswFDJQELpCsFpCyjImI98V3/QCn/rFj62fJIMbJ8LDd2woVtlf0LTrA7ZQxOFHXd8hTpb/saHvdT+212DkWPOvUXxdW7NMlv5rlaWrEYb4WksmRxrKgn8sgD9dwTbYqvEXtFpPon0ggDWf4ZxsSJvfpPlOjyp2v4qmpG05y45cb1u/kNITt5dNTnpVID4TiWJbspFbc0jXV1McujfhJyEiArfLnhw/zB2rv9XXbDN/lhdO2cF/m8+Nq7MhZFCeObjSXuoaqjeRxa93CFcynhy4gobXjRJ6tM6uvghfZ+LLRpYMTsL1OTK4c0y2NjldfenzTXjQGOa5BTfaxCUKb+iu2PAkjdOt5YjFp5dqt9w8ol/ff6TsdOfq91Ctpr0CsrRYD9cUq6qROp2qNFz6okr3yP4iFPgfy5m3uBIbwlhuGp0Vcx/XMaTtiYimLCpoHj2MkwtveWCCMB/A8bPNbRdIFQGhn1PhSmKZB4zkSWN9qSxS1X01ftl6wtbU3fCLl/qkxQUPF+ap0+cbtvurGsywXYEchvAqxpE8O8ZGVi4j5s7/lO9EDLw91IuoA1onTGeDF01cLn78vBXw2mlLsGTuDVtmGpiguPDpobxlcKkc10IJqTrf4GLLUcPmA80twu4x7GeqP7I01ks7eg+FWPEVmuDOhsr/9tNCf0Hq3C3kKXOsbICUAU2dJY54fRByt0lviExiPC/4f7R1NNDX2MWZZZ9/Vry14V7tu3j7qhdoSGsIXczVJ9oehTHTLZdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(36756003)(5660300002)(83380400001)(8676002)(66476007)(6512007)(478600001)(2616005)(26005)(10290500003)(107886003)(6666004)(52116002)(6506007)(6486002)(66946007)(66556008)(316002)(4326008)(41300700001)(38100700002)(921005)(86362001)(38350700002)(82960400001)(82950400001)(186003)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HpBp7+PYZShHAnemmfcJGr9MpOSCI5eGSuR8rAWiTTsddZ8jxo5iFnIQ3oB1?=
 =?us-ascii?Q?20q3cZEbXDPtAHdhOjIbQ1wrjPec7oHwUEiVGyIN92x/QqAq0R+a8QJVtSQW?=
 =?us-ascii?Q?VriuH9STb5TUPgvGbSmAQ9ZTZaCfod8l7Zmh88sRuA71kq7TXgoNK+y2VE0s?=
 =?us-ascii?Q?nXgb7YOFrY27K9RrhusoigDwF7KkCyS7sIJaDgzTCU8nluNbEbvfVD7OQGAR?=
 =?us-ascii?Q?ZAets9FA+u7XKslYVjf0Q5ZBJRQ8S0knnbANEFthl/VlXYGr7LZbDBfDeaDJ?=
 =?us-ascii?Q?+xUQqRMm/uoLfdsUWZQte3qWhAdeR4N8U6amD1doqFmbzLzbHOuDHqT7Bur2?=
 =?us-ascii?Q?cMRfmzHuanEXC5CwWfGs85j8LvzfMVeTqrEGOQtSgnENFYL1u+GuWRPFeboz?=
 =?us-ascii?Q?Xhrf1Q1m92oD6ZyfvllKChR3AjMBgKYN2MMufvK74ssWPdNqqwttLoM1PxM5?=
 =?us-ascii?Q?6ZtzkWi7IAmQa46NzrbAfzhtuaCr1jl+yMNJXzyHMxFuEtHJ9sASQrFuLC9W?=
 =?us-ascii?Q?siuI0VFBfsVwnJm3n+IoSlEbqe1fgSeMdjITUuWA96CpfLXy9xfT5vdHN/oi?=
 =?us-ascii?Q?TPL8USTNfCH0sZao6U+7smm7srvsDp+RtYyaXYnqw2BG5MHs7lhW8x2nluie?=
 =?us-ascii?Q?Rc42FnZrEh2iFdH7eLL6bxdG6OT/1x2hczQJDO2WGyvStXCbTsfXNas695XK?=
 =?us-ascii?Q?Gq13Bnsyj30HBMahO+icFRPjRrqNvsGoowQSNe3NeXeM1pllIgHkSTiLW536?=
 =?us-ascii?Q?FI35FtIwJ54lrRjievg9L1igQilwDxsgMARyU1oODUpBVApNJZYkoUvSS/oD?=
 =?us-ascii?Q?q2xCDUxfMsXVHCVRAb3kPMgiiwxXYpMZzLMsqOyc/ncfvnJ7W2fOPF8ds14z?=
 =?us-ascii?Q?GlatAifg+m9GOF4BLIOzFOf7eZ66Fak940JuCW2KnIpSjTMFd5nkhIeRorPR?=
 =?us-ascii?Q?eFm24Y6Mvdl7xL4c6BRtDUdCa1w50PCI9/xF+VEHtH0fOIJV+ONVVg+JvkJY?=
 =?us-ascii?Q?SjoYs2oDnnNlSqfwx3Jl90c+NozebUKneEvM8Kvl49272OzUs1bcYMgocBPs?=
 =?us-ascii?Q?+Idg7wN/8qHD/I9v23tIWv2ufqgYdljhZlFbDhN61ZELHNi1vfw7iLHods9e?=
 =?us-ascii?Q?0tO/jY1spHn6Bwaoe2hVE0+p/bD0/IRHHktYYFbIyKVQW5aHi1gHzgqqVq79?=
 =?us-ascii?Q?M9/+RfOmnXhTnXw42oHqOGFmrRHpWC6uu4CYqqHSuCl/MtNHEzhoY3J8Gm/d?=
 =?us-ascii?Q?Yv6T7wepwRQxLIC0SI2wpUvKTgs40eGi3TDU6Hd89R23khOjOFzvQ3rwrTQe?=
 =?us-ascii?Q?7o80VfbKCxmL41coJui/A9b5jEZRrGi+WD2droNMYr/ap2CSRdP0kk3nZK0n?=
 =?us-ascii?Q?fChJkOD0m+EVPiAL4/5oSdxivBRW/6ap1rfCc5WM1I/r+Cc+7KzYkjpH0Zn7?=
 =?us-ascii?Q?aj1eOMYhecG0TSSYmCnowSICAeCOteNTOQxlpJ1VwVA3K9Am/1m1+h3Konuf?=
 =?us-ascii?Q?6K684kYwlsC/g1jCOmjx859Cye7BSTrWJ1mvUdkwHTYJG0S65xEFuXeWYJ6O?=
 =?us-ascii?Q?F0x/is9DZSZ4v0BfhfouaXkJwOP8UQI1mIiIhF4kmvahqgxEBnH6ZAxbcVaZ?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d98690-7a9f-46bd-a482-08db256ac800
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 15:34:35.6854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6jFNnBtsG8GM8BmaV4VG9t04MvC26ZtdiDa7Ij4naOrgbnbYYgxRFpsP4ZZJcFM7Ujxur5KjiNa7jTqhegesQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1316
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V should never specify a VM that is a Confidential VM and also
running in the root partition.  Nonetheless, explicitly block such a
combination to guard against a compromised Hyper-V maliciously trying to
exploit root partition functionality in a Confidential VM to expose
Confidential VM secrets. No known bug is being fixed, but the attack
surface for Confidential VMs on Hyper-V is reduced.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index ff348eb..ac630ec 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -356,12 +356,16 @@ static void __init ms_hyperv_init_platform(void)
 	 * To mirror what Windows does we should extract CPU management
 	 * features and use the ReservedIdentityBit to detect if Linux is the
 	 * root partition. But that requires negotiating CPU management
-	 * interface (a process to be finalized).
+	 * interface (a process to be finalized). For now, use the privilege
+	 * flag as the indicator for running as root.
 	 *
-	 * For now, use the privilege flag as the indicator for running as
-	 * root.
+	 * Hyper-V should never specify running as root and as a Confidential
+	 * VM. But to protect against a compromised/malicious Hyper-V trying
+	 * to exploit root behavior to expose Confidential VM memory, ignore
+	 * the root partition setting if also a Confidential VM.
 	 */
-	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
+	if ((ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
+	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
 		hv_root_partition = true;
 		pr_info("Hyper-V: running as root partition\n");
 	}
-- 
1.8.3.1

