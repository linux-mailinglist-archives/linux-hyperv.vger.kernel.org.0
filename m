Return-Path: <linux-hyperv+bounces-2469-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7E911B5B
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 08:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5282B255FA
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 06:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83013C811;
	Fri, 21 Jun 2024 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AofTDbVG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2099.outbound.protection.outlook.com [40.107.223.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3E83CD7;
	Fri, 21 Jun 2024 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950640; cv=fail; b=VZiw8pUw/ckUlGY022VGl09Q/jcBd2n3RxfKTQlGbtq8VyOO36Q/XDv734fsONvd9ygLb+M3ZYXmtx5tz8H/v6LGpVL88GBTEhrHuM0QgZmNK0kqjxQQZvdpwOqpjN65G996UnTlLeOrSNkls7pROSHeQj6QG7Q2QRSwH7e9MFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950640; c=relaxed/simple;
	bh=MAasnuOYuCGi8MfrAp6zKZL3eJwgmQdzZ2eUDQJ7Niw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z9A+jKoVG7Y1oROr98lIdxfIi2KPefGq1ya0SwPO4hOJsTdpWhIir1e3Dz/XrufKltKA9dUWjSh5k6ES4IbyS7YBgokdBFjgUPaOXA4DRX+EozSbedqZdTvhOp9042SV2jqpsgrAkLHk7Qrv4ZSi7XNaJOrRNTCbOfFfORZyw9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=AofTDbVG; arc=fail smtp.client-ip=40.107.223.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYT7zocHQlpIF4bNOiWDPH9Dcy0VkT0WLEdC14AZghm2rcgoBs8qfQRKQcKbr2uyVKo6iMRi2sk1PH9U+1C9zxdiBEVp8M3+9mWExMrqYkMEy2t42rY6g41sMoawqCrtDOP+Z2dNRz28bPVaDttfGoX3d+rOh1wX/3bYgp5YuNkR1Zqo6EVV+ElC8NoEqtBxf3ZVsoDpQE/mEjhh3uk6BV5KJbfsEaYkvT8Mr1/W1DQvWAtHD9JezzbXsrOdO3b5bkTCe9ivsvuNhyva7uxIvD0zkdWrp4bGD4ddf9B9xXM3lBQIEWGfOyGssCyAlyFaoJlLPVeLKkX35kHiQwCwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzPKfKs8zivVujdPC5HIctZB7dvkFIGPHhJWkvAz4uk=;
 b=CLYeqcDpySCFTOhbrMphtOCkh8zXa2cBHEFg8SuMBWxiQlKqe0i3n/VHVolx0Im9tmMLMFdMs2RkDvr1yFxoNfagJJWE/IJ3KHRAr3k+yZCqqoV3W0KxOMoy8LUYAuPIuqlyXZY47HywDd4cL1V2s+lFByV44/Ph4BmlK9qCp8cxuKg+MPhML3DK+Aznm0eN5u7e6fxTxNO+pm4JtTCe4E0R9+rtIPzqGedbdt8e/9poy3GjGJfvEbVUBEI+W7fmnZMAw9iLOG0Mm0JMm3gRoEICiJXPz+DEybI+wALbuoSZKOiyCD8D5QXZ+MmaxZo45waj6hqZ6m5Kp/8SppSE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzPKfKs8zivVujdPC5HIctZB7dvkFIGPHhJWkvAz4uk=;
 b=AofTDbVGCNfPMm2B0nzM2Obxrx84ZZjUxWH/6YC4Dsekz0FBPLwmh9WnhXvh3rC1a+7S1F5FCEsmxbpRobEIM9icUFdtS5RyFhz11RsqPCRwQACJKEP9C65YmaJwpAJQfDwSAn1TibLIya01EtFMUX7rhEMqXoXDJPNE52etaYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SA3PR21MB3915.namprd21.prod.outlook.com (2603:10b6:806:300::22)
 by DS7PR21MB3404.namprd21.prod.outlook.com (2603:10b6:8:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.9; Fri, 21 Jun
 2024 06:17:08 +0000
Received: from SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::d498:7336:91d0:7372]) by SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::d498:7336:91d0:7372%3]) with mapi id 15.20.7719.014; Fri, 21 Jun 2024
 06:17:08 +0000
From: Dexuan Cui <decui@microsoft.com>
To: mhklinux@outlook.com,
	"K. Y. Srinivasan" <kys@microsoft.com>,
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
Cc: stable@vger.kernel.org,
	Roman Kisel <romank@linux.microsoft.com>
Subject: [PATCH v2] clocksource: hyper-v: Use lapic timer in a TDX VM without paravisor
Date: Thu, 20 Jun 2024 23:16:14 -0700
Message-Id: <20240621061614.8339-1-decui@microsoft.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::32) To SA3PR21MB3915.namprd21.prod.outlook.com
 (2603:10b6:806:300::22)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR21MB3915:EE_|DS7PR21MB3404:EE_
X-MS-Office365-Filtering-Correlation-Id: 40629a18-d4ce-4a81-b412-08dc91b9c732
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|1800799021|52116011|366013|7416011|376011|921017;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?+EP3SbyR+/9xqMCpq+lYwSDxPe3p1v8cvkbsjqvoLFgi0dGh+h1pG830a/+7?=
 =?us-ascii?Q?rp2KOWEWdUfnIVj1De36M2m8duWG7IdNivclsA0EdK9MXBtMZqE33eklN45o?=
 =?us-ascii?Q?cDubOnts3IBdHjc5xDDTEO7dhOfz8WabxyobrKW/Uhq8Uau6iFYybM5yZdtC?=
 =?us-ascii?Q?nRua+Z8zEEnoUIt59s3k4hTPoQfMkhrX/n0maeUaEFUiQGKh5Kqaj/GHzv/q?=
 =?us-ascii?Q?k7Zhjm6cgK76a83f7jy1u486XKfOkPh4q7EycdwkdWF1rxfiU4FfYl8JCEPu?=
 =?us-ascii?Q?geraVl+ohjxmqAvgXQS9JMQO0EaKUk3jU9juO+DZghcI3TCjFAKMJQgmJy2c?=
 =?us-ascii?Q?oVapphVO7ao4cNTwCBDiHTm1/qAG3NuCGvU8kCJv9qnbK5mBb9+/MTyqG6nc?=
 =?us-ascii?Q?olAHJ0qx0gDA5DqvXR6StykhAWBzkf4aryhvlj1XI4StAX6bAamubhYFaZ7k?=
 =?us-ascii?Q?WG5H7disJ44drFE+A1p9NhmNqKtiphBfMvKNELHyMzrVuEqc/lTfqsCA2y1A?=
 =?us-ascii?Q?4xjt/+8v5MCmvfWIjyCAW8nU1gVJL9yM5TU29r8nIGy5wgB5GoFSrn8mG3uo?=
 =?us-ascii?Q?LY2lMBUwupZG1LHIwEgZAz9i0J3DhkX88fq4661vLNDW9dT6MTPYnpluDwhr?=
 =?us-ascii?Q?qyQv+5i+7ABbkyutRFur5o/D2j3EZlcNltlYUb8Gr6qGFRBi+HiU/p7vS5P1?=
 =?us-ascii?Q?NKVf/DX7k1oTWuld3AaBdhBqd/ciI4baKw0l1CbdcwpiivkVxN3lkXvzpQDP?=
 =?us-ascii?Q?07ImR+csVo4vCYxhMgpxmFO8KsJpGYwxkcSQ7vpaJW4Q3JO55caps+bFsGVD?=
 =?us-ascii?Q?ouioTA/v8xxWg3/m97ZPoX7uu2JgPmzAUUNCr+bL4+xCi7FikDAyemhLqedt?=
 =?us-ascii?Q?v/bkCfuUSnaETuog9tFa60Lw++5oYTY6WLRWaAhsKBzuKOCkgfDunPfBWFWA?=
 =?us-ascii?Q?QTokBScLtDRz51AeTXJRGa0817swcXeoizWqd8a7tUUAb4iItIlzXdIT/7Bg?=
 =?us-ascii?Q?F6asbW199T7RWGfI801xPIwI1eVI9rKno8lfPOM869F/r182NfYW5qaNRC4z?=
 =?us-ascii?Q?HPPU0QpfzQKvUoful9H6wi4aiQOoVJfP7iZ4/qF9xiBzgjINHcw/sy3m5ypc?=
 =?us-ascii?Q?zJ7cUt1vWp4TM3tFYvxGS1CIV64TSQsoYp+lJzleXnb5s5oigBxRGF/2aW6N?=
 =?us-ascii?Q?Lq0+xAUFVarMIEOCt6hIjQzl6vJ6XvVC77cXmDwXzS9U/fpWdECHJP0tLp7p?=
 =?us-ascii?Q?u6Blv8IkPlUpwKWfxJjko+ky6f+ebEVmUqWXoI0BCpzs530xTkws1kccSLL3?=
 =?us-ascii?Q?KIQTuPuvLlHJq6TRNMrQJaKtI88sqYKrJhJe/iqCTu5O/lDsOMhHdxHLNBEX?=
 =?us-ascii?Q?2C5IlE1r5RFVLVTrKHBwjZYxSoIc?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3915.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(366013)(7416011)(376011)(921017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?doG9gJrPEY/QV3o+r9tLF9Q0GgzY8IqeFokjUcaI2CcYsnxze/lVQVh8G472?=
 =?us-ascii?Q?jFki2+uiKravnl8YEuI12ngY4i/K42tyn3Bq/MgaRKrnjCpsEzdVHVkmm6IX?=
 =?us-ascii?Q?NpUWWpehCsiK9wevZGCi2DMjJVFVxPzz23kHKpjmoN8ywkuCuLOrQ6CuxhGr?=
 =?us-ascii?Q?BQI9ttJSAE3M5fsMSqfRKiTUACdmKXYyKKjlERDGxeLu0QmYGhG5C8x4nrmz?=
 =?us-ascii?Q?OCpXaYRh2GeoDKMXEfDxjJfjHiFi7EMnFOvL53mzd0Mw7LAxm+5OMWTll/qn?=
 =?us-ascii?Q?aHbrZMFl8tKoTugVlYY3gzxGnnMh4B7SVqWfEo257rdts5ME14wQqYTdIAgg?=
 =?us-ascii?Q?Imq9UHx3rUXauOaXPRjTmN08ietzQGqyEoy2+tx30D6DzDBSaoCAaQIeU9Vm?=
 =?us-ascii?Q?mbIxSCutzGVoCx4MwBKgk7p1X88a1aZZosfbQcPzFJy1dDzszW7owSsHkOyI?=
 =?us-ascii?Q?zg86Bg9S5eJjtUr6QLu2RbEqHT4K2toq+SDJN/wNSVvLaoMGPOm5aQnCz/so?=
 =?us-ascii?Q?qb7+SmCn9qpbB5zG+Zhb0vmgj4npVU9Q2/QCusDfvbxZ+qlnHwbf46+NatGl?=
 =?us-ascii?Q?pEylhVd2WDhbZXR0+cQmf9Cak2YHxz4f4hcdwTJSjVIM9XpfvcPXl8W+pWKy?=
 =?us-ascii?Q?b1Z2OazxgACwF/CVk/s/uXcVF7k0PCF8LJxUimftU30G4u7zeczj1JphVUco?=
 =?us-ascii?Q?McVWHJfLlnk5skVHmtcW2T91TvcqviOpw3bm4nDtP2jIS3lNXD5kWaX7VL0E?=
 =?us-ascii?Q?tF8TQcuX8C/WVLjnYVAvzL1RjMVmcH7VNTiSoBqD8rVcDAItrfHFVVRngCSe?=
 =?us-ascii?Q?ruKoruB94TJmPhrtX8rzkTCSBFjOMI2FZycKlH/EzQIGgcxilBD6MhS0bg5K?=
 =?us-ascii?Q?JCnMJEeYyNh5T1s8hBeZveZSduGei12ymS1Td5rLTUUjLUtHLDgJd3nLKkaE?=
 =?us-ascii?Q?msOwho5VGKq1yj0c3EKs0gX3tfoPNPLNsvGxRvOj1Y95yDO19md8nIVFVhQO?=
 =?us-ascii?Q?3gC9d3ugXAmwxZSaRZsX0upgB6H1tZ5MEzJXi0gZ6z/Toua19oodkICr/hrq?=
 =?us-ascii?Q?z7Tz2oPx/jf6zL4AGWkfc59/DCm4n6yYxQveVorGIyFmwjmyXNsey0+Qg3xf?=
 =?us-ascii?Q?9Ni4ifpfPIIxrA5T5tVGcaE2MA2fuNhwxXkEUojzVaUw/uqUTP8GiZ46to1f?=
 =?us-ascii?Q?4FOB08SD7MmLrhh/zUsMQe/s2/FBK9bk/Ir0lBTVOUbhvJAz/4uWYYPzyO+M?=
 =?us-ascii?Q?NUtfE+GVyXAg3BLW6WKFZLZHDmSHeQd6oi3xcWYA8lCa4SIPkPa7Jvz+pqp7?=
 =?us-ascii?Q?EgXvDjvAYR+WaBCFodwIfqC5AGSVujvHtEX4azHTHt2YngiHx2jvVRBva74h?=
 =?us-ascii?Q?bPAUkBPUEG7PU73U9z+xRs0ZjoQzXD2DQ6Jpzm1SJl5YTslE/lzEfvRKQWxJ?=
 =?us-ascii?Q?ipuGeFWCSkWkDu+kCf5F5YoVNqJqJPEbg/ukRJ0YzyaTeDvtlKUzJtZ0fZCe?=
 =?us-ascii?Q?sRrEbhY07R38ELlz8bNmpdgaCXkRjGjiAdlJBBXEBMPczdTar/AT2iXg7L+4?=
 =?us-ascii?Q?j+DiL2C4B2OSgr3YMwbXiHSqzO/L+udOUHW1OygeOHgi8gTcWpRuha4zsAB1?=
 =?us-ascii?Q?tMqLTphM5ZwkmJ8Eqp03Wg4sZHZZQ4y122n0CAC6doAs?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40629a18-d4ce-4a81-b412-08dc91b9c732
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3915.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 06:17:08.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Pmttx548ojmCOWXULP75TGfB4/+HYZrFqTDtHqW+UHKShCNdVWrTqIEUu2f4MvhyiExfTWbCiCC5dpVhtmM3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3404

In a TDX VM without paravisor, currently the default timer is the Hyper-V
timer, which depends on the slow VM Reference Counter MSR: the Hyper-V TSC
page is not enabled in such a VM because the VM uses Invariant TSC as a
better clocksource and it's challenging to mark the Hyper-V TSC page shared
in very early boot.

Lower the rating of the Hyper-V timer so the local APIC timer becomes the
the default timer in such a VM, and print a warning in case Invariant TSC
is unavailable in such a VM. This change should cause no perceivable
performance difference.

Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
    Improved the comments in ms_hyperv_init_platform() [Michael Kelley]
    Added "print a warning in case Invariant TSC  unavailable" in the changelog.
    Added Roman's Reviewed-by.

 arch/x86/kernel/cpu/mshyperv.c     | 16 +++++++++++++++-
 drivers/clocksource/hyperv_timer.c | 16 +++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba840..954b7cbfa2f02 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -449,9 +449,23 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
 
 			if (!ms_hyperv.paravisor_present) {
-				/* To be supported: more work is required.  */
+				/*
+				 * Mark the Hyper-V TSC page feature as disabled
+				 * in a TDX VM without paravisor so that the
+				 * Invariant TSC, which is a better clocksource
+				 * anyway, is used instead.
+				 */
 				ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
 
+				/*
+				 * The Invariant TSC is expected to be available
+				 * in a TDX VM without paravisor, but if not,
+				 * print a warning message. The slower Hyper-V MSR-based
+				 * Ref Counter should end up being the clocksource.
+				 */
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


