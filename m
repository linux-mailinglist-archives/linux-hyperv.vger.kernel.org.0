Return-Path: <linux-hyperv+bounces-2450-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8F490E0D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jun 2024 02:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80717B21503
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jun 2024 00:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A77617F6;
	Wed, 19 Jun 2024 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ias1sBQA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2129.outbound.protection.outlook.com [40.107.93.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60117CD;
	Wed, 19 Jun 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718756765; cv=fail; b=s/FZxUE2LQNgUsMFcnsxMU1dPaL5jtkqUvCeMVuE4a1nUuAyoHZKMzmt5HbgRdphygkadP3ofyvaMcruK1TBp1a3BVG0GMHi5u4STLIwlZKpB+XdG2t8ATJG5j7Cv6l2BQt5b67YEDccu3HGWLtyPN8e0A5ADI++qnFtBPiH3UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718756765; c=relaxed/simple;
	bh=azKzGJl+6BUgaWL8UR81/awlLEG3znSA8o83Qy+jPgM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d4llPp/CIIwFe3OMO2YO3tvPFz73pqSaB6Q589niv7iw9EjCmpJH6CO5cF3OMntotAL0Nnw1MuEKCFLp4SB74y1gcC09U+TaMLSPtl22IK/u6+ij66f3K84n8aQBaBxLJLpjsZ+H+rB8HFB0uYgakLf0KZ/TSpbL6PoTx5pMYhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ias1sBQA; arc=fail smtp.client-ip=40.107.93.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4vdwQ6403ZNlCGYNSZbPK0XZC6KPuF+eEzssUXtXDED76RJSr3cwihkxWPs9ZjHd2z/O8F18SZK0DboeMRh+e51ocGq8CYVXT7RxUewA/YA07LF2sOIwikM28jhUv3dDXCK+ivTRzw4briE5QMzN2zREKVsvI5k75OZd5ZVEtd9urBvqCyXvUpJfrpsIF5nDMR7mWZKW0nOU1hlf/T9foKlqY5V/gb0RUNKPkfaxOdovRCOIvRYwuF49YOdrBq7/Z01KEfjQnatf/ygJmkmZKgE9uCuta9vNRiL0iGPARkiaAhLKBU9OhSKtYMVnaM5kDWah5MyxgI1pM77o7Vo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhDBH9WsDHGpqQy/CqIwmIEou0/7SBZaG5eYwL4eXl8=;
 b=aSWmJ7J2yu8DEXZB1DkBSn1sC1yBRu1VmtaA2h4UszMEnxZOiqdKrMg7GC7t+bzm4mNlGjUgn/sRs1iLPKIw4wHpwapAf1A9qqEjxl1ZmMSY2o4QrK9PCWSjGdG6IRD5ahWKt8xvEyNdXelMT2bf0peNgQ6AFRwLr/B65qDT+uzp0JU5VTVhzItsEw936/zfnhbHzfZG9U83hNM6bc8wD+84aCNo4eG/X++cf6mvuy5lKjL/avFUDMmXvV/cr0TrZ3AUoiBLBUC5eBMIqHUEImVkFE/fewtBlEBy8pIvQNtmgZzzF58lQ+DlPMcly4xisZGb5LYaz9Z9foEzvR5DhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhDBH9WsDHGpqQy/CqIwmIEou0/7SBZaG5eYwL4eXl8=;
 b=ias1sBQAouOVSVjXo2cN+0Y3FeuRZ08Q/Z99YRYrKZOLALSqduOIEPNNg6gXsW707HIa86sQ8LOIrPruMGcebfcYKPo0xUXEVPD5rfjwwVrRbKx4MmPkx7xEN8zGOBD4rGuqhJ14xvOCcGn9Eq5UjBK+fopXj8+Z289V38pDWdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from PH8PR21MB3902.namprd21.prod.outlook.com (2603:10b6:510:250::11)
 by LV3PR21MB4254.namprd21.prod.outlook.com (2603:10b6:408:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.4; Wed, 19 Jun
 2024 00:25:56 +0000
Received: from PH8PR21MB3902.namprd21.prod.outlook.com
 ([fe80::8644:73c:8e9d:29b6]) by PH8PR21MB3902.namprd21.prod.outlook.com
 ([fe80::8644:73c:8e9d:29b6%7]) with mapi id 15.20.7677.014; Wed, 19 Jun 2024
 00:25:55 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: stable@vger.kernel.org
Subject: [PATCH] clocksource: hyper-v: Use lapic timer in a TDX VM without paravisor
Date: Tue, 18 Jun 2024 17:25:04 -0700
Message-Id: <20240619002504.3652-1-decui@microsoft.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To PH8PR21MB3902.namprd21.prod.outlook.com
 (2603:10b6:510:250::11)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR21MB3902:EE_|LV3PR21MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd5bd55-a03a-45c0-66fe-08dc8ff6625e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|7416011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S7VoyQI4HdSy+1lULrmkWE1WyhnLU2USFLlhpqoi6N99YsjDP/ZpRn3vLhF3?=
 =?us-ascii?Q?tXJU2BSugKPyZaj/PNhoFWwfiDZGv/eT5dbQ6njvOdAgTtYimomUh3/wJ2Cg?=
 =?us-ascii?Q?49g435QZUnBGAOY6dCI+LHqI6BHVGdt6WUIJDxHX937kEs3pWrdL3ZI8kEyS?=
 =?us-ascii?Q?T5q9+mlbH5pDB37w0Z8JBBJp82wKn4CgglfquYEWMUdeMExU/6ZkfpUgAjLV?=
 =?us-ascii?Q?yopthbOmRobc5zi6J5kCqhlf63LC3aM0W0kYmZfohujmNlbcicJsPCHcwDsM?=
 =?us-ascii?Q?yLlFUBW5M1P1JmDYTKkdpHDbVZzvHbx3G9AJOrH6tvJuHCiuMduZaCHNrdQj?=
 =?us-ascii?Q?hf0kxV69uB77mqugLtPFcyHGaK0o4N0O7Z7AccMutiFJS9sBH3dRFcOFr8nj?=
 =?us-ascii?Q?uL6qspMUpGE0bLUgxfUOkd0iVB7of1cI/b3cn6YtVGVoVn1TQw2CNyr/BYC7?=
 =?us-ascii?Q?cd7RbIfDqEvF82VYkVC1mwO3+ZxJaqo/bqodnIi+DujQpwy17ddqtxcXdgPP?=
 =?us-ascii?Q?7pj2dliwF/+6rSJM0XZXVK/3E672VGUF9sQ6oQpXIBF/oRV2sflKXxlkpmXs?=
 =?us-ascii?Q?GuL8W1an0/ll1NAOGA9IZ6lf7+vJyvpFgGQoC1iCLUlNld+FKphquspHyK6B?=
 =?us-ascii?Q?Spo3gdXQaQgX680qmzSbWqUBlWFB9nAnQkyJkKYTFzImYP+rB0wobcFPnAJc?=
 =?us-ascii?Q?1guhjv1gZTm4il+WZJM7SpnxF1TEg1Yst/ijdvcX19DvtJin3/oTaQHNGvz4?=
 =?us-ascii?Q?81K3JWze0Z0SK5XuVM4etjPCEtntOz2XT+xCRQplZnnoPk3+aW/OwnoYlHj5?=
 =?us-ascii?Q?DNtJrHJSCw9nfYTXsjT2Z33Ni0D8sCfBmKo44OunXnWfjgzBcWPM6Uxa8zGO?=
 =?us-ascii?Q?AJ+pis/VvX29DrZTrApvRwG7XxygAXz1dx5c1U2ARWN28vi7PAFpnnWItV2q?=
 =?us-ascii?Q?DW4vcZVwXwc6pWlbyXsyysUpFaMKtgawLas7G4bnOGU/Kg2arytUAES0zTa9?=
 =?us-ascii?Q?g0+Z/ZG2bqpM9aTqjDKQ9jG5LGi1DZ/P8PSa6Z+Jr6D0aW2TR3IB1VS8MFjc?=
 =?us-ascii?Q?gnehRzKKEUSfxTX7HCykz/FXZcHfUDO7nmMgCZzMhXT9HA4jNgmCGO1KFWIH?=
 =?us-ascii?Q?Ao8AcutvUkhlpb09p+RtPq8k2QXRMHsDfJ4gORl0nZSXbKZKx+mv00anjyEa?=
 =?us-ascii?Q?KnGd09YZeW91n+p6s2NqXKIbbVu+ET68I52W51ORvoTPLxmDClR1LqxLQgCj?=
 =?us-ascii?Q?Dxw436+LLbme8HUx6QpSpsDbSFeFkSnytLtvzYJuGx0TrYqJrBstIIfP+dee?=
 =?us-ascii?Q?24HPREEtvFQzzh3VFG564M69PGwlJfjbDDclWH9UOprVOjWzLwKtbRooeeQw?=
 =?us-ascii?Q?k7bWG04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR21MB3902.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(7416011)(921017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bYmIQ0IljbSNcdXrQF3HR720SQ7azW07jOAvSS3Uh4mDhv6GClokjEeAefln?=
 =?us-ascii?Q?SmqrzGJTv8HfyB9TMTzAtEdIepC8Qp9GHQk2Anhep3YHVDkSw0SoDD3StQwu?=
 =?us-ascii?Q?aG57jHCww9wKZb6Yt9R9Ce1SFJg+vRYv2mjQa/QDOx4xdZBbR9w5OAxlXczr?=
 =?us-ascii?Q?Pp5KfJ8Y+lSqgPUoeTEmUJEgob+JashQKo73vsfRah+HuQYzqIypXVPVqhoz?=
 =?us-ascii?Q?E1kieJ9+Art1FpilM7RGwKDNWPA7XbNFwLYF4I4XlLIpWQhyvSjXMJD9ZEs8?=
 =?us-ascii?Q?nYvXzckawU4CpQpzbUBwHUAEHqgOG/5tsGoqSy2GOUDjstVuQSXA6rQIZGoE?=
 =?us-ascii?Q?fQfDzUBFwDD9KSQxDHOm3g0iQxdqfyA19FiP9AwFbmCTvyBNFGSgaNKQr06C?=
 =?us-ascii?Q?GcgE0MrkVaiPAsbPywn8KrYM0Dquu9YqzyhT4ffwKjC46tcAX+HF/o/7taOB?=
 =?us-ascii?Q?5iC6OD7evKO2HopwOJ1OhzM2Z4S+QN8G/qZvBT3w3pAnHy722cbfaxT4encu?=
 =?us-ascii?Q?f/MAE8lCeNO4/E2s4Pv0JNslwd5uwjFbdb6GVWbXX1JvYTFprTDbH8DyVIyX?=
 =?us-ascii?Q?G8rjvlHOLDteQZsOPQEeQSynwjW9fkCJAYMXQ0ruK7SFmVLm0kk6Ys2Y/53w?=
 =?us-ascii?Q?K4xZt1idPgOdnv4szkBm879KyUo8ecyMKFfbHKPsgZ4jNAwYbkg1AMYRYgMC?=
 =?us-ascii?Q?czWQmfuxePEWdQhS+gJkzKJ0CDLc+4lrOAI289b08IMN4BFEob5DNAohWhQZ?=
 =?us-ascii?Q?sEcFPCCSFH1LR1HfL/1azx1UMvGlhRz9Lz31lnGSvHt0ThbBlMZYiUO10M9q?=
 =?us-ascii?Q?+t5LGzmEGSI3l7fxg4VIywLxLaAin+a01OAq3TvRXTWiriFSbyMpNXIjqjfG?=
 =?us-ascii?Q?sKd2suBgjrYWol7nvCwb7bkCFmP0cRQwHKwrC1l4MH+Fql+p17zi24+xvAZz?=
 =?us-ascii?Q?Vkt5CXTWTuHVV6ozyGJM79N0JrWWikz2Xl6QHKOihARShUhrkNRMdDyx0Puo?=
 =?us-ascii?Q?9ED5x4fhO1j5J42VScIxMSPvtY8GlLyuLyrZdOezpdIAL5G0g175tpwzDbND?=
 =?us-ascii?Q?q+wXsTWh8J7esSJbobSgVGGGtzNCMB5bBw4U5qXf/vPTBbRt4r+DRf2mS3Pk?=
 =?us-ascii?Q?/DYktvPxeVSvpkcaIxq7g96dmfT1aCyuwTxJFRFyO6UqbIkpgFNkYmorZPDp?=
 =?us-ascii?Q?O3JD4VXP4UkUvbM8qmU3vwcdjwVR43q2LbSL70JzEXe5xfK0Qpftl0BItXgx?=
 =?us-ascii?Q?dkgb1PtAC4MzBKJWErX+/u0whhOxGxbzjYRPikiX+ohJqz2HwBBKk5MfpEyd?=
 =?us-ascii?Q?hHtPwd1GLVhH5A4bnFpbh4aAdFnPPJnv2B8te3VrpdaAIHTeaQ5OD0PZK836?=
 =?us-ascii?Q?duKtSF3YtoI4EtIQm6f8QB2TTOkqCHydZGi8bvPMvWTPIKZI/wEjhTFMM/wc?=
 =?us-ascii?Q?zBc8j05lFsO1P4olveXB+27f3qS8nCSGn678xzrGdE3VT1LG7fouV0IquEzI?=
 =?us-ascii?Q?45ZoixsIMnpaoepz+tFap1qmCiVr6FB95a9bhdmAqXEqx1fFw52p+1SmCrmr?=
 =?us-ascii?Q?78d6cas5dqlDwgHJ1aTpP8k0d6cw0NcWDQv1k1Z3/jBzgjZSU1X4akvb1dvH?=
 =?us-ascii?Q?OypZDT2IWPCg4mGI9i39VB//CcYS+b84i1lpYB1EvW1a?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd5bd55-a03a-45c0-66fe-08dc8ff6625e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR21MB3902.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:25:55.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5KtsAVxJQmvVQlmFpVdEDVT/AEluS9S0BoAWpVBmn68WJk2q12guMPSpN4kzNY1f76O32MftwjIW94IOgDzEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR21MB4254

In a TDX VM without paravisor, currently the default timer is the Hyper-V
timer, which depends on the slow VM Reference Counter MSR: the Hyper-V TSC
page is not enabled in such a VM because the VM uses Invariant TSC as a
better clocksource and it's challenging to mark the Hyper-V TSC page shared
in very early boot.

Lower the rating of the Hyper-V timer so the local APIC timer becomes the
the default timer in such a VM. This change should cause no perceivable
performance difference.

Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c     |  6 +++++-
 drivers/clocksource/hyperv_timer.c | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba840..745af47ca0459 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -449,9 +449,13 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
 
 			if (!ms_hyperv.paravisor_present) {
-				/* To be supported: more work is required.  */
+				/* Use Invariant TSC as a better clocksource. */
 				ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
 
+				/* Use the Ref Counter in case Invariant TSC is unavailable. */
+				if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
+					pr_warn("Hyper-V: Invariant TSC is unavailable\n");
+
 				/* HV_MSR_CRASH_CTL is unsupported. */
 				ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
 
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index b2a080647e413..99177835cadec 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -137,7 +137,21 @@ static int hv_stimer_init(unsigned int cpu)
 	ce->name = "Hyper-V clockevent";
 	ce->features = CLOCK_EVT_FEAT_ONESHOT;
 	ce->cpumask = cpumask_of(cpu);
-	ce->rating = 1000;
+
+	/*
+	 * Lower the rating of the Hyper-V timer in a TDX VM without paravisor,
+	 * so the local APIC timer (lapic_clockevent) is the default timer in
+	 * such a VM. The Hyper-V timer is not preferred in such a VM because
+	 * it depends on the slow VM Reference Counter MSR (the Hyper-V TSC
+	 * page is not enbled in such a VM because the VM uses Invariant TSC
+	 * as a better clocksource and it's challenging to mark the Hyper-V
+	 * TSC page shared in very early boot).
+	 */
+	if (!ms_hyperv.paravisor_present && hv_isolation_type_tdx())
+		ce->rating = 90;
+	else
+		ce->rating = 1000;
+
 	ce->set_state_shutdown = hv_ce_shutdown;
 	ce->set_state_oneshot = hv_ce_set_oneshot;
 	ce->set_next_event = hv_ce_set_next_event;
-- 
2.25.1


