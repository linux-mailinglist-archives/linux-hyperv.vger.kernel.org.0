Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9129F735DAB
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jun 2023 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjFSTDM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jun 2023 15:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSTDL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jun 2023 15:03:11 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388D99C;
        Mon, 19 Jun 2023 12:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwmtcLy9p3RK3Zl8ElJ5iXlLDF4Lyarruk4MEQBeaLT2QWH5Nkdu2On2QhwEbEHxG+pB6jT8YH92rE0Gc9mmLoGGX/mIPlzAnHaGIYptEO1LlHHU0itL72V2DDa1P9/Rcfa0MMAtQCkiYBYHatZotaXVq/64e+i5Crdxdva2fJbTc8U7bRTti5+uB/7XcvviSnMPZM1PvHHp0H2H3ApuIN2eQb7PjY3Bx/Jf2FhKAh9wUW0jikncDqT3DSrkettrJDPcminYf/OV+dpMnjSjtNmTq2BAxKGQc/U67zXAR6kXpWckJjC0IXLPmMk6b+tPkvvooQufwQ9sRqnHdgqA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xmreg1Ep5alRt66IHWQ2B1ILJyQeOlSh2yOxxflPmkQ=;
 b=kV7pkEJpnMi/RM33/Y57QX0n7vjGjOJjshHmdsgUSoWDgBiUh4AfVTQY9+pQ4Wcb6bQPbe94vnLw6Efb04GGrmVo8ELLAdiIvBxzipimsIjv71NOvr8rXg32NKoKRgmbXQ9r/9yUgMC+3TuDnrUiFqHYIsAumIhb7GK1KHnFU2BQR9gnsGg3iHXv88h6BBvWvZUXpCGZGDapq2PSeElg6bcX+GISztYUU3V22JSFFK2XIWdNyPZ+EQWQFG8wO1OhdTVygDOdpKZUEMnOZUZrxdL4VD8p1NTx7J6deBmQAiDOIyyE8OivYYxg/5bkEs7FK7v45cb6NWdQhiMa/9bPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xmreg1Ep5alRt66IHWQ2B1ILJyQeOlSh2yOxxflPmkQ=;
 b=dzDRQOWn7MgoNLRuwkqMFWmIuYHewA29+TafG0BA5T7Vy/HPyHK6enbDIDGL33LAO1ry4IOnjMlsRbieYykf46g/6AesYHR4APOfa0YB29p9vcTLKQ1l460cfCn99LU6FY3SslmHftWmZxOvVMmt4N6Tol/MphfBDyyIgn+3WqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by PH0PR21MB1861.namprd21.prod.outlook.com (2603:10b6:510:17::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.19; Mon, 19 Jun
 2023 19:03:06 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::5faf:ae1c:ae43:68f5]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::5faf:ae1c:ae43:68f5%6]) with mapi id 15.20.6544.002; Mon, 19 Jun 2023
 19:03:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 1/1] clocksource: hyper-v: Rework clocksource and sched clock setup
Date:   Mon, 19 Jun 2023 12:02:40 -0700
Message-Id: <1687201360-16003-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:303:8c::7) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|PH0PR21MB1861:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0d77c5-6744-43c6-bc20-08db70f7d06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZ9Lp+JwzMakEGrBpvry1GukJWJoIV+vroOia5Depwu5H/FeSzJfgyS08XZcwf5ZnC4/j3f3HXmzj5HeXt24YJvBls/Fpqle/hfHjanmxFiO+l2djo2pmCXDiqIW8iz04TsFKyz+byzDG7Vwp2j9pDSJ8GYr36GXFgsxw9S17W00C5mHgLpelYTIc8+YPDuyofb2P52H4sSXQ6zuMW60aixJTxUeMQXl10TCo3fYeJMACIhiSqDZ2gty3bH5JicEDcwl5q259N5Ma+eOROPjc649SqEEySR86GvWKxyQBAniKxCC2S/uoT2vVKSZBWIhXWoInGlIeffDJWKwa91pcVUPT69ECWyBKYdE2dMue/qJgJs/Lj/OvOmyKCyHS3Z8i2P7P36+Orl1mRJLp0JtWYaDdj2L23Lp0kdbxCVf7UL/ecilqsH04FB6L43UIq8GTlwsAgQ4iSw4jmi+DsBq4lkPDGZLTXYA+u/laDraFGFwMbLBE7uirrRkNwnsuHGedJ9bqHoZVN5lGa0fL+nIdtAM6Agy+y/nTImsvN8oGd8eqJpVq5KqmBI44eQxJgJ4961PgmhjqZSGSBkogvi73/CyMwifAozgby0vC9j6vWyGveIGkAI1drMIs7GahQRLWrxI+7US5nPrrte2DKejAGK9Lma38rcbud/buZXwIvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(38350700002)(82960400001)(38100700002)(82950400001)(86362001)(36756003)(6666004)(52116002)(6486002)(10290500003)(186003)(107886003)(6512007)(6506007)(8676002)(26005)(8936002)(5660300002)(478600001)(2906002)(41300700001)(66476007)(66556008)(66946007)(316002)(4326008)(66899021)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qHbpvNbeWffImz6FQSP0JcaFYSJDh4SNPE9Km7xTZCjl9RzweefroNHLdSqi?=
 =?us-ascii?Q?PyNdvXY9rwd1iXiPoc8AfC97aegEZcC4uxtT904opZFWBcK8eKwSLzkMj0Sd?=
 =?us-ascii?Q?APWe80CHZY1xKvAfbfy6igQw0n8YULrDAkVms5lNwsznKA9csbO53fOqEyX9?=
 =?us-ascii?Q?yQSmWi6ocTn8mTii1JhUmHq1KrWXfCGfNNXwddldSqyxxaxGhDPfvlYqNcm5?=
 =?us-ascii?Q?JGeP8oWPRQERzELzZhlI+XM9kX2pJMnFPQjcyt+VLWsDgk9z1ft6f5tqjwhF?=
 =?us-ascii?Q?bk0gnQHBWZhP+FSJLCD1AhkOc3dtlDe0/DTdpTo4sH4XCYTLwz4k6391FIMW?=
 =?us-ascii?Q?LHxACO11lKxijWyYHIKw9o8FfcP3RyuTdFuJjwq4ym8Fhm06lJqYXeZeayrC?=
 =?us-ascii?Q?FUiVZRCwluyNujXZevk528DcILmjoXmynRmGQwl/EhnynUcuoUC0jwnnxRTO?=
 =?us-ascii?Q?/0nB6WoVVnZI+fcxIRrdkdWRgCg3CJlo4NzgC97dwtixLQuS34DjsKAGOYSt?=
 =?us-ascii?Q?yB8syZaLS50c6D17osSOEvRXIlUuRHHSDkI0hAJ89SCJDHQs3iQ+Q1eLNIWU?=
 =?us-ascii?Q?LGtpvLHVS8HDuUEw96NRweZKpRj2fD7wHgB6+fNL+E+nPkoiEM2h5ywxS296?=
 =?us-ascii?Q?g8abbJIASwttJnpunVAz1q7Ez+ofOdgX7FmQFfj5k/1de4FjPZJpRwWEafll?=
 =?us-ascii?Q?zf3mSauufhb9pmkCZs+v6rNfNWEwlnDs15GHNzkBtHWJ0blllmht3blLrtyM?=
 =?us-ascii?Q?lUx3YBi4gdBHfAR3IMZPgU+GRyezsXJTkFTcnaGIUtekfUXDG6ewa3yFmHC8?=
 =?us-ascii?Q?egBmrDTJH+iXLJDKkGxEY3p/PLKzLV99tqGX7ysDtCUHM2LMmgtk8FC26umZ?=
 =?us-ascii?Q?G9xCtRzqra23nyCFO6ztEadtjND9Qcp656f5q9BvS3owRYvXfPEI1hRCdn25?=
 =?us-ascii?Q?RfKKvlNt1yjIaqL2WHUIdH7dB6h+DBMuFgSXWDf5JstpnHOKdTYuxllMH8In?=
 =?us-ascii?Q?vYSPRwsJKH+UupprQsgJm2cOWSDfd5JcKrj2kMyz09jgTBvoTwop822QyrHy?=
 =?us-ascii?Q?u3Do4fMhOKp7E8caDyki0n8qt2Gk1Oa+mM88iP72RFBX8r+1dRZSGnBdp7eL?=
 =?us-ascii?Q?bAs9Up+ZXOoZsLRij+CrKsZyepN9tb6a61sVKToO5WxErTFU3KrtBpE+VcWx?=
 =?us-ascii?Q?MuJ1LCtCY+Lg7A4wj88K5BLPOY1jdcm8a+mZaec/3Xd32Y+pfsGpZZwIBCBl?=
 =?us-ascii?Q?hm48XverIH9x2HlOH+jUxlWfN2muKfjKiRy+ZfDE9h86YHQWYI4oguctOpbv?=
 =?us-ascii?Q?/NfKUj45DFUA5JJCWNccCog+xe+jV+SgZBXwQu8vxyYuDQhIKD3o4KHPVRwp?=
 =?us-ascii?Q?3Kkxr6xVF7tupWAdMc9oDNUagDP3cGwlC5I9KRNWkknYAlQQwNcM/kV8u7KS?=
 =?us-ascii?Q?W8CIs4i4DtK+z91oivx8SmWpQ7UNcD+wf79/+6TPWzma3WF8OTUaZ5xFNYOs?=
 =?us-ascii?Q?iNxboOYO4inJNHUZ/D4VUpHJ80t56o41hXLRmYAT0NflOXniYZiK4CDagz9c?=
 =?us-ascii?Q?O2BpDVM7FYk60hGYdSzI6cfZ/6h3g7A94E3VemZD?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0d77c5-6744-43c6-bc20-08db70f7d06b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:03:06.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OW67x0rLs8PEDkM48/ZlP/CzjwhlflsJ2XMOS+L6F5RC++mOJbYvOr+l75rNrix05baW2ic1OL3WtM23cHsMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
* Rebased to tip/timers/core branch [Daniel Lezcano]

 drivers/clocksource/hyperv_timer.c | 54 ++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index bcd9042..9fc008c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -475,15 +475,9 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
 	return read_hv_clock_msr();
 }
 
-static u64 notrace read_hv_sched_clock_msr(void)
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
@@ -513,7 +507,7 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
 #endif /* CONFIG_GENERIC_SCHED_CLOCK */
 
-static bool __init hv_init_tsc_clocksource(void)
+static void __init hv_init_tsc_clocksource(void)
 {
 	union hv_reference_tsc_msr tsc_msr;
 
@@ -524,17 +518,14 @@ static bool __init hv_init_tsc_clocksource(void)
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
 
@@ -565,33 +556,34 @@ static bool __init hv_init_tsc_clocksource(void)
 
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

