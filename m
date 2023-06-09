Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B597729F0E
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jun 2023 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjFIPsU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jun 2023 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241884AbjFIPsT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jun 2023 11:48:19 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021024.outbound.protection.outlook.com [52.101.57.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7844358C;
        Fri,  9 Jun 2023 08:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBSodRiLwRGWdsBsVRe+sd2gCcVVyAy7vJFaA86PMIK2ZA8Rok01ARukhiI0V8D3+KGUKu3aiQaW6M58Sz4BJodKlu+8JfBOgH6uKWQWepxrRSi2kNtxqWLabJP+yW4KJL9M6l38qOF0oXkyCrRPe8xvNL6VbrWh2ZDV9vZ+dh9rrZmhadjnx8U1Dz+qQS+VXOunZ56b/ugJeaCJOZ1veEigjbtCWMy00TO6oujUzusSCg+qxiuepJyH4pGhlCE8PdoFJZ8gEZQWwulUz5/TOZmtCO4ludo3w8XSSS3WcLvtAbCbHRYkkhK6BxvvxlKPQCIQxuHLExuWFUQLykZI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBEiMFHE7Fvlt+D+RdQX4mNFM3RdWHk515ySSjrqpkY=;
 b=Db9zvBg6e8JClDLu4YCtvpUfH69O2vOjycecPIxSvpxuvJULZfpy19nZnX/FMco4yaqJEDhqFv8hngA1ulWxTMJ2PJ2kkYBQWei03O5JOg2vSfE4S8Y/Is/eLph3HsvL0ZL/jio3c1qEIyr9rWT9MiiqETlzie5HsKP7/2O0zXDXzoE3rUX2kljH7yMAHCv7FZnxFQl8igkWZpuPJxz889GpK5m5i5tBLZ8WiF3OQ5xrHs6v+brvDxow34nUgpiEyXXY4EMpCUZaZX3uLXSUXpI4rMYJHajC73TybVrzWFppx8zg6QGdNF9GcLBoGpUb+hxhsXKhG54tSXAWKpEMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBEiMFHE7Fvlt+D+RdQX4mNFM3RdWHk515ySSjrqpkY=;
 b=SZCHYRxS4akAM1QWeJahMk58r72lR3baTODDOpxsGqYT8LLNRB8kXYmOX3aRmQZWvBUv7IEqYKGU5sh5dqCym7saC7L4DDo42lL2ToP4nYnTvgB0NJl/MjgGirPzFkBY1SGd0xiJEAm77ufWvxbcB629qXCOk0GsVRamBJiW9+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MN0PR21MB3559.namprd21.prod.outlook.com (2603:10b6:208:3d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.2; Fri, 9 Jun
 2023 15:48:11 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%5]) with mapi id 15.20.6500.016; Fri, 9 Jun 2023
 15:48:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] clocksource: hyper-v: Rework clocksource and sched clock setup
Date:   Fri,  9 Jun 2023 08:47:01 -0700
Message-Id: <1686325621-16382-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:303:b5::15) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|MN0PR21MB3559:EE_
X-MS-Office365-Filtering-Correlation-Id: 47497ca7-97e7-414e-a4c6-08db6900ed5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ri/2k3YJ7NG7OzbYvlXD0h9kcm5gMNKf4iNED5Jk81EEqzHRMzYyxzwO5/97NoKhy0bGrlkv8HpoJ5tZkUoSuOGsZjv1H7U6BWF14cxIa83CqU9OSNTHD/KjBXcnTpuLhgrkWEC9wawzaJPOTpgZEybpNdpUh8WZycB74UP6U4M5YIhP8C5mAn+7rJnOVQXVbJ3t7uNJdUKRnuUQhefvVJmHf9snYxqJdvvHt9pDNk/1noD3SQa4+RXW7XxRN+W756mfr5BXWKGGCLOVxNZFIdVg7M760tS2jpDv+ZOTJLjT4BPpjmI/mgaf0OgseoLfiyVzZnyhi6kn+lBtOWYND6YI1Pp4uEJ971DF4tZardt8EiPVrBGhXkMRdz+X71YY4xn6JPgobmEWlv9TiZHRhzzR7gjJVZc+Vpu1ZXTfZ+feQMPl/39a0VxX/IK0ecfLUob+aHZNF4PXmecHOUWXcbyvGFug9Ay0j4TtL9Na31YDZx6xWY6rq9gubkAa5Lp3u+RMyqg0gxwWXO8YbuDLvFywVFrhxisAmi+HjoDbAbeyvK3p/xRKVKUlGBGV+1FHjjTN6WM8pV+93wl25oSEdPaJulxcwjOpzIRB+lWJ6//iSdGkW4gSSu6Bz/UaosbWeOeprT0V7BKle4nLnK3aZRLRuj8kc50zeDXWlF2ZE0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(2906002)(52116002)(10290500003)(6486002)(478600001)(6666004)(86362001)(36756003)(6512007)(6506007)(26005)(107886003)(82960400001)(38350700002)(82950400001)(186003)(38100700002)(5660300002)(66476007)(66556008)(316002)(2616005)(66946007)(8936002)(8676002)(83380400001)(4326008)(66899021)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OB//da6h1y4II5utzVdCkX3SseCMMkyEUrc88P7uGKjoxOpPiR+5QbGek8WH?=
 =?us-ascii?Q?RlY7obOviNzXxCixBTygDepcsw+wBzIV1hIeOzhdbs6eVJsN4slO0UdCS2Wv?=
 =?us-ascii?Q?vLL91uDZFybZOAIHLHBtQRaGGyqP0DF9uCRG4IGV0cw/sBMo/RCYtEJ4XCst?=
 =?us-ascii?Q?LETQcB9soGgL2/WoWhp7LNCWHUb41naZ6APdTySau2RMXF13lj0Vw58oSHaT?=
 =?us-ascii?Q?a2W7/r7G9+o0VCUWlZ0UMEagpufdE/jdA3jdyTcBI0+/CHYbMtNyXl7VSse1?=
 =?us-ascii?Q?FARTaqECqWaaq8aLC7+sZVs/cYZOhr6fixMrudmkki9lqS8VFv1qpipLpLLF?=
 =?us-ascii?Q?+6J9iMfgbXpFK5l2m+RlmJ90rKRe7EsqxVAbTre3p/1JOlyFYmrnzvRgLaX5?=
 =?us-ascii?Q?PiOCJURFWamx47BM7FMhqX+axVmBhxfRFT5IBFIGLr44HKRQ6m7frnmN5cTr?=
 =?us-ascii?Q?bttSSMjenZweMRLZ3zXrKKo/wywMj/zJ32Q23UKBG7BrxDT3L7EioMGWb0qn?=
 =?us-ascii?Q?xC8SdxAS9CsAtreNSjnmdCFcsohAVRI3cbKN7kB/Mq3ZcteaKYk1PrtBAFqs?=
 =?us-ascii?Q?HYXe2zckxit7A3kIyknD7NP2muDZ3iFoaxU4J6wjncDNK5Z/k37k8mc/vfBh?=
 =?us-ascii?Q?Sf3CTgyxHP72wgL+BLkNDD5Np59878mt87gh463woaqN5Cz2D2JcfiI8vhNM?=
 =?us-ascii?Q?DNjOkrD63FUSeTdSvM6vFHC6Rwq5lGY//HIWowBT1bmt58NDdJfsAMNxVxql?=
 =?us-ascii?Q?QpnSUEXDcLknrGuuAbp+bJF9fM0wDzBPm8UlimthLg1/bX04kNMG+BpRcGzE?=
 =?us-ascii?Q?AV9OyIxjJWH2MiTVgGivFeBcW6oXlCyjSoEreqijnej4jVL6VGde3kOQksX5?=
 =?us-ascii?Q?ccq68jsMU8x1qPMjGbWtKOAyI3kJ+AjLhhDr1Zc0CAYhTzWiN3hy2ZpXiTPd?=
 =?us-ascii?Q?N+WeSEdZRk8YlNbZbe3Kl2YchQf2qhhWcLdSjW1VUPQOpc5VEobaAeOb8BXL?=
 =?us-ascii?Q?3FcTY260MIFqk3CrueHHDG2C5vYANbZ3ATLKIrSn0u/QgxnuJ/dhGIvfAnc2?=
 =?us-ascii?Q?lYSSg8rLUcH/W4g1Gs3IoVBePAUMaCzMHcuomcnvIf9EMpHUFS7FRmxT25CY?=
 =?us-ascii?Q?islHxVhNPzuUBl7abGay07PDLpdSWnVtM2r8D80MJgiY6iCwnQDUaqPd66O6?=
 =?us-ascii?Q?p/jL96pmrHzUNiMcdw3DDuNO39f917KNTa58oZ1Ibz9OdXopZcEGZnpmYU2R?=
 =?us-ascii?Q?w0L+7tdzonu4J7RJED72hFpOr+rNHFjcW7RJ5paCOouvj+H6ZDrguosVIj9Z?=
 =?us-ascii?Q?gtB/983VN6PH+fjgJ1j/37MqHsGmqo6oc5d/OaiCfNMTdV7KMoPH/NWQxmVv?=
 =?us-ascii?Q?Y+JgFKXGm3A7RFPjT2CJmD7us9SsmZwSGdkMpXvKcPcufZqNkbf6fbUkww3u?=
 =?us-ascii?Q?VP5N5CW1R7opYmBKttPfdHcwbGTnBkHb5NAVa3ivJpDahQKZGBH0Xz+wp/Yp?=
 =?us-ascii?Q?qVqng0GuMcQyiSjdLDy4RsVk5yR9Bt687aOQHfNRF2JJLbA8UkC56eRDgYeV?=
 =?us-ascii?Q?tnx4m3w2mFkS+zfFruGJdWi7IgEXpfcMQ4baaCpJ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47497ca7-97e7-414e-a4c6-08db6900ed5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 15:48:10.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLnrwNl0MW6cIg7yX/plk9yX9/NLX1PkSML5Qvajg99Y6QhH3Q+bQOjFnVIVKMMVWqms9OjDp2l4sfv3SXZx5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3559
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Current code assigns either the Hyper-V TSC page or MSR-based ref counter
as the sched clock. This may be sub-optimal in two cases. First, if there
is hardware support to ensure consistent TSC frequency across live
migrations and Hyper-V is using that support, the raw TSC is a faster
source of time than the Hyper-V TSC page.  Second, the MSR-based ref
counter is relatively slow because reads require a trap to the hypervisor.
As such, it should never be used as the sched clock. The native sched
clock based on the raw TSC or jiffies is much better.

Rework the sched clock setup so it is set to the TSC page only if
Hyper-V indicates that the TSC may have inconsistent frequency across
live migrations. Also, remove the code that sets the sched clock to
the MSR-based ref counter. In the cases where it is not set, the sched
clock will then be the native sched clock.

As part of the rework, always enable both the TSC page clocksource and
the MSR-based ref counter clocksource. Set the ratings so the TSC page
clocksource is preferred. While the MSR-based ref counter clocksource
is unlikely to ever be the default, having it available for manual
selection is convenient for development purposes.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 54 ++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index d851970..e56307a 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -485,15 +485,9 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
 	return read_hv_clock_msr();
 }
 
-static u64 noinstr read_hv_sched_clock_msr(void)
-{
-	return (read_hv_clock_msr() - hv_sched_clock_offset) *
-		(NSEC_PER_SEC / HV_CLOCK_HZ);
-}
-
 static struct clocksource hyperv_cs_msr = {
 	.name	= "hyperv_clocksource_msr",
-	.rating	= 500,
+	.rating	= 495,
 	.read	= read_hv_clock_msr_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -523,7 +517,7 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
 #endif /* CONFIG_GENERIC_SCHED_CLOCK */
 
-static bool __init hv_init_tsc_clocksource(void)
+static void __init hv_init_tsc_clocksource(void)
 {
 	union hv_reference_tsc_msr tsc_msr;
 
@@ -534,17 +528,14 @@ static bool __init hv_init_tsc_clocksource(void)
 	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
 	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
 	 * TSC will be preferred over the virtualized ARM64 arch counter.
-	 * While the Hyper-V MSR clocksource won't be used since the
-	 * Reference TSC clocksource is present, change its rating as
-	 * well for consistency.
 	 */
 	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
 		hyperv_cs_tsc.rating = 250;
-		hyperv_cs_msr.rating = 250;
+		hyperv_cs_msr.rating = 245;
 	}
 
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
-		return false;
+		return;
 
 	hv_read_reference_counter = read_hv_clock_tsc;
 
@@ -575,33 +566,34 @@ static bool __init hv_init_tsc_clocksource(void)
 
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
-	hv_sched_clock_offset = hv_read_reference_counter();
-	hv_setup_sched_clock(read_hv_sched_clock_tsc);
-
-	return true;
+	/*
+	 * If TSC is invariant, then let it stay as the sched clock since it
+	 * will be faster than reading the TSC page. But if not invariant, use
+	 * the TSC page so that live migrations across hosts with different
+	 * frequencies is handled correctly.
+	 */
+	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)) {
+		hv_sched_clock_offset = hv_read_reference_counter();
+		hv_setup_sched_clock(read_hv_sched_clock_tsc);
+	}
 }
 
 void __init hv_init_clocksource(void)
 {
 	/*
-	 * Try to set up the TSC page clocksource. If it succeeds, we're
-	 * done. Otherwise, set up the MSR clocksource.  At least one of
-	 * these will always be available except on very old versions of
-	 * Hyper-V on x86.  In that case we won't have a Hyper-V
+	 * Try to set up the TSC page clocksource, then the MSR clocksource.
+	 * At least one of these will always be available except on very old
+	 * versions of Hyper-V on x86.  In that case we won't have a Hyper-V
 	 * clocksource, but Linux will still run with a clocksource based
 	 * on the emulated PIT or LAPIC timer.
+	 *
+	 * Never use the MSR clocksource as sched clock.  It's too slow.
+	 * Better to use the native sched clock as the fallback.
 	 */
-	if (hv_init_tsc_clocksource())
-		return;
-
-	if (!(ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE))
-		return;
-
-	hv_read_reference_counter = read_hv_clock_msr;
-	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
+	hv_init_tsc_clocksource();
 
-	hv_sched_clock_offset = hv_read_reference_counter();
-	hv_setup_sched_clock(read_hv_sched_clock_msr);
+	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)
+		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 }
 
 void __init hv_remap_tsc_clocksource(void)
-- 
1.8.3.1

