Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E27570972
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jul 2022 19:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiGKRs7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jul 2022 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiGKRs5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jul 2022 13:48:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2090.outbound.protection.outlook.com [40.107.244.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55313F1E;
        Mon, 11 Jul 2022 10:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIywPVsFO5pUsknAwerEEpwN4V4Dh7zjSGmoQVVdrIzc1pzpmrAszg0LnrxO1e/EqI4PbFhBPu54W4SeBa/qDVuwVULJnykKR7QkIAHASgTpeympEQ5qQcuY7kS66t6N4t5LC/YC4t8+DltyCKZA54irvFEoXJcemC2tFFzn0Rt226iBO5oPxawdiCMmuU94OHj16PRGmh7xWkznqGLPYzbNZDe8h4SYnC8whMAkrkOd8N4ZDxuGBMyKD9v2PWn/dy+immDw+H+B75KJuU5Z2Xbi4cUhL/o3ajJt/yvo9iPkuoY6cGAau5iZDwot/srHt2uiyw5rgRtnhsBPZvSpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFtmH13/jDA3heSMON/hN8D0/8/ZJBChjjes3eOKhvA=;
 b=PyNOjvjnKQlPH4Pbpik7V6grZMYtLTUnKHvBhmz9SLNL26ZUU8Zh51Zh0WyVyrgzDDL8Ojgr2+k6QeWOWrrEZFeDZOgqP5PBYXwgDiAk5ijj0etBcvlJL5SjuiA0oRga3W8/WvLcDluLENqQ2nyIQhQ8eEm9AOhJvHOA89AkCEQlZyaI1UGnNi+nqGqiuYbLjEc3b1IovWyl9li2w//jGZZBeITgcap4c2hIWvI+WQT6n+C3NvqUElWGSDRfW5xxLCDslchpDcmLVYSD3+vFIe9KxVaeJTB8RDVcc9uIHhAUyeKaVXBsdx+tMZVOrVuLZg/gJ53+4iFAg4l6FJfgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFtmH13/jDA3heSMON/hN8D0/8/ZJBChjjes3eOKhvA=;
 b=JYM41o0AGLj1ytMZAxGORV2UKppIgctVYifnLGppzbAODkBNHyRN4G8WOOp+lDgUlhHq9TFNJMAX5dVT9SR/4KE7gy2SmaPu7LDm1/WIVDwZmCBo/Xfxbvh7z4qsAST5RisH4PhkGNTF5HpyAzL6lsmfmu5gTfgtZ44JYcTTBi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM6PR21MB1321.namprd21.prod.outlook.com (2603:10b6:5:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.7; Mon, 11 Jul
 2022 17:48:53 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6%4]) with mapi id 15.20.5417.010; Mon, 11 Jul 2022
 17:48:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 3/3] Documentation: hyperv: Add overview of clocks and timers
Date:   Mon, 11 Jul 2022 10:48:24 -0700
Message-Id: <1657561704-12631-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657561704-12631-1-git-send-email-mikelley@microsoft.com>
References: <1657561704-12631-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05373536-fd54-4737-47c6-08da63659f05
X-MS-TrafficTypeDiagnostic: DM6PR21MB1321:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBamVFkqnbUHYNjVgAyZMcZfcvpxtPV69ErwbgKGshBcldpGP1bP8wWcoWISRapzJmInddQ+L8+084EcENIEsskKLKWJGToJY+rpiddLyCV1GSIhZ7y7bIqyLXzbXeqXeMPm5dTCwheqorJQQXmr95hnyr3wj6WVSkAYh/0pitEsytvwkaPdDN8QgOHRX6a0nwlWUzaGdsYoFpusBlPV7R08+vCn/uvwFIfXHoz3iMzoWys+syLt+nTl6NCBJnYc8RqUKXSjANE6bq1zOzzVyWUjbYu7peZNbZ3vGTEvKfGnR9IviUB6RqJidxdHDU9KL6eSeR4g3xCdqQh3Q6gPqfaWKcUmZLH82l7/QQ41CDGxn3eq61RhKAmtJaMj28vFq9pgoOTGwpZ1bEyDHuFr6eaccWHAvONTvkh1d3PI9HajiJwbmmxq3AbDiQ6kz0b37DJX5znadQCSvyW02RGQXs5ri3zaC7PLsOooUX9Ik0v+BrF+g0elvu/pX45Iw+YHuS7pSXXjyHzuHozAUXM7GdbHlgy+l6VpRevv+njta54pivE9/evKuh4fRn4OXSZ9mvzmkHQWbXprpkIB6O78k7NYdEjHlu/icDUM1CpYsl+wFVG9ezZgvyVsjZMOCeQbmxOEUmoWYn5M+0TIFZWHMLIo/58HoLXKG0YDBfuTc3L7v2Rl8bcqc9GZ+Acm0S2GUe8TMfaLveeY5iVe+4WuElyC4D3quSvhAg6KBANvsn9mQJv8QclHqXl5djxWDEQ2YUIqKqpok4d5FYCk65ULz4Qo0fNablQvADW2RMcNw7w/PgQZWlUHgdDbQS2rpjthXYJCH7d7SBM7957+kn6LcszWXl0YWnzk3eGVeZb4MRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199009)(26005)(82950400001)(8936002)(5660300002)(2906002)(36756003)(6506007)(82960400001)(66476007)(10290500003)(478600001)(86362001)(4326008)(66946007)(8676002)(6486002)(66556008)(41300700001)(2616005)(38100700002)(83380400001)(107886003)(6512007)(186003)(38350700002)(6666004)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ffaIQhFF6llqRwumtkRn1qhBTCfTkuS4gVADjmX1WmFtJMZwHuuhU7RbPgh?=
 =?us-ascii?Q?uUy/FMRKMIwPtA1MTjjqY8slqKWfFsnSkou4U/aQKqFxgekwce7v46KvtYrC?=
 =?us-ascii?Q?Q9br35DTwZ1c5HUFgcFuNaEqGCvLdaDsY/WmX7ZcWENgBw8HbEw/T2Qx2KKs?=
 =?us-ascii?Q?59ZW8Rn71HyDvX9KrFJf7OpTnieg8b2+AAwce/Ul3NyOeelEMMQw6xNH1DOT?=
 =?us-ascii?Q?6X3QkV0PdtCS7YCUATmKEuOvGX4diej0cRVBzDp0SnWghpNPxC3SgbzY9AHb?=
 =?us-ascii?Q?VeuteUz1iISK1DqBPkveTEE2xTtz7Op3uaX9pW/Fzj8+HOqhBucZKI0yk1jb?=
 =?us-ascii?Q?gQUF3/xPz9GDOsk5V4x4wXA9yEMKd2z2SxLcqBcko6XI+GiQfwB762yGiDzL?=
 =?us-ascii?Q?NLsUVqTshSIF6SOHnm//+WJz4jz60rmP0ot9BMvNjwyfS2y3oVAGRBoU6dOQ?=
 =?us-ascii?Q?/LGaCu6LSJcHZbcXyL5pauig7/APbApQAFw2AulKt8zjsuDhFmUTJP4zPMAl?=
 =?us-ascii?Q?lXbA7bjTzrO+a2joxwICc4IWocQgLEE0XxBcrMbCa69uq+yBU5d5I43Uhss/?=
 =?us-ascii?Q?x+8CEi1UR6DCsZpS39pg9KLFGZ/IQxH4PMDJR9NZ7c3H+hzygFFfh6D9SaJn?=
 =?us-ascii?Q?iFKqcTiiHGlSoNSYcvjvEyzVspBdUMCp0pQV1npSeQYQx8dBTi5r2r2oHRmd?=
 =?us-ascii?Q?/CmqjqlRaLyORFamS7eNHr1k9UMxuClrR3XqZfMXB+avHAAd5svM6+LbddmA?=
 =?us-ascii?Q?WZiNaCuRKXmNSvegYHWQZj0U5bLaBrbl3VpyR76yILqtpenpteAaMgKGCKjv?=
 =?us-ascii?Q?Vaw3dosi6c/14jDYLrZLNqCFFiSO8+uc7UwgHDLv1tJLJC5rFkHRpNyPGcin?=
 =?us-ascii?Q?pGViBIQDTl02KB6TKzFxz9dt55YBjwxmFSHPy3/t2DON6Cdj/SBOsdZwVvFV?=
 =?us-ascii?Q?H+hnuI2P5wiGVsq6DtZfaYwpo5iazdSWmcHrm94YAziA0d8nSoo9MAd6No7J?=
 =?us-ascii?Q?4vEvfYhuOFBoRzdF/lldHIKQ7GYxgj+DiB5+NzrXbtYK/vY3YoD05TVu78mV?=
 =?us-ascii?Q?/+CG3C/A4gPEClf8iC8a9f/HRLe4B9hUOKy9euQ/N0aT5sj6NyrtBcuCuv+e?=
 =?us-ascii?Q?krRDFj24XtOofv0v5EVmnZhaPc9XuV8MpT1DTIskZKAp5Ecnu5daRBg4UJ4F?=
 =?us-ascii?Q?V54Ny7JCk03FdR7CMoNzg1+c44L8anxqRxLwsdauYMSCICHEOHNOcXlQ8oy5?=
 =?us-ascii?Q?pPmEm2Qa5h3RzsIOb9wC7/AnPMMq/WJB+uyoUInDQ8UF89k87zD3plxMcWHL?=
 =?us-ascii?Q?MNVKTy0h0uCmAJ5m4GwEaa0or+fmSIV0ZmqKO8MkAxMsAGojeqYeNbHm0xuT?=
 =?us-ascii?Q?Pcpi9Qaqx61qQrJlLqfiq0WUtf0Ut7EY5mlIETmX5UjNefuAvVRBOhc5AQox?=
 =?us-ascii?Q?NLDK2aYMROEarv3Sf9p/rHs/2yLF8SLpzA64g2O7JCFp8cX6lDXnL8yw3PP0?=
 =?us-ascii?Q?mrVnsnls5FTSVXL0Eix7Lz7kztCpxgt4QcplhZskITMoqbS5dHYYeHA+bxaa?=
 =?us-ascii?Q?Xj5y1UDWh85IzWWyNFi6DRSGICP27jKZxJXT2czq?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05373536-fd54-4737-47c6-08da63659f05
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 17:48:53.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxpNBuaQPdanFdY4dhEdtQDoTVqb7Xs8QcaEfD3bpbM/NrobBYuy8iPB3VytC/GdIjCyc5nvVVeD913cqHhNPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1321
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add documentation topic for clocks and timers when running as a
guest on Hyper-V.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 Documentation/virt/hyperv/clocks.rst | 73 ++++++++++++++++++++++++++++++++++++
 Documentation/virt/hyperv/index.rst  |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/virt/hyperv/clocks.rst

diff --git a/Documentation/virt/hyperv/clocks.rst b/Documentation/virt/hyperv/clocks.rst
new file mode 100644
index 0000000..2da2879
--- /dev/null
+++ b/Documentation/virt/hyperv/clocks.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Clocks and Timers
+=================
+
+arm64
+-----
+On arm64, Hyper-V virtualizes the ARMv8 architectural system counter
+and timer. Guest VMs use this virtualized hardware as the Linux
+clocksource and clockevents via the standard arm_arch_timer.c
+driver, just as they would on bare metal. Linux vDSO support for the
+architectural system counter is functional in guest VMs on Hyper-V.
+While Hyper-V also provides a synthetic system clock and four synthetic
+per-CPU timers as described in the TLFS, they are not used by the
+Linux kernel in a Hyper-V guest on arm64.  However, older versions
+of Hyper-V for arm64 only partially virtualize the ARMv8
+architectural timer, such that the timer does not generate
+interrupts in the VM. Because of this limitation, running current
+Linux kernel versions on these older Hyper-V versions requires an
+out-of-tree patch to use the Hyper-V synthetic clocks/timers instead.
+
+x86/x64
+-------
+On x86/x64, Hyper-V provides guest VMs with a synthetic system clock
+and four synthetic per-CPU timers as described in the TLFS. Hyper-V
+also provides access to the virtualized TSC via the RDTSC and
+related instructions. These TSC instructions do not trap to
+the hypervisor and so provide excellent performance in a VM.
+Hyper-V performs TSC calibration, and provides the TSC frequency
+to the guest VM via a synthetic MSR.  Hyper-V initialization code
+in Linux reads this MSR to get the frequency, so it skips TSC
+calibration and sets tsc_reliable. Hyper-V provides virtualized
+versions of the PIT (in Hyper-V  Generation 1 VMs only), local
+APIC timer, and RTC. Hyper-V does not provide a virtualized HPET in
+guest VMs.
+
+The Hyper-V synthetic system clock can be read via a synthetic MSR,
+but this access traps to the hypervisor. As a faster alternative,
+the guest can configure a memory page to be shared between the guest
+and the hypervisor.  Hyper-V populates this memory page with a
+64-bit scale value and offset value. To read the synthetic clock
+value, the guest reads the TSC and then applies the scale and offset
+as described in the Hyper-V TLFS. The resulting value advances
+at a constant 10 MHz frequency. In the case of a live migration
+to a host with a different TSC frequency, Hyper-V adjusts the
+scale and offset values in the shared page so that the 10 MHz
+frequency is maintained.
+
+Starting with Windows Server 2022 Hyper-V, Hyper-V uses hardware
+support for TSC frequency scaling to enable live migration of VMs
+across Hyper-V hosts where the TSC frequency may be different.
+When a Linux guest detects that this Hyper-V functionality is
+available, it prefers to use Linux's standard TSC-based clocksource.
+Otherwise, it uses the clocksource for the Hyper-V synthetic system
+clock implemented via the shared page (identified as
+"hyperv_clocksource_tsc_page").
+
+The Hyper-V synthetic system clock is available to user space via
+vDSO, and gettimeofday() and related system calls can execute
+entirely in user space.  The vDSO is implemented by mapping the
+shared page with scale and offset values into user space.  User
+space code performs the same algorithm of reading the TSC and
+appying the scale and offset to get the constant 10 MHz clock.
+
+Linux clockevents are based on Hyper-V synthetic timer 0. While
+Hyper-V offers 4 synthetic timers for each CPU, Linux only uses
+timer 0. Interrupts from stimer0 are recorded on the "HVS" line in
+/proc/interrupts.  Clockevents based on the virtualized PIT and
+local APIC timer also work, but the Hyper-V synthetic timer is
+preferred.
+
+The driver for the Hyper-V synthetic system clock and timers is
+drivers/clocksource/hyperv_timer.c.
diff --git a/Documentation/virt/hyperv/index.rst b/Documentation/virt/hyperv/index.rst
index caa43ab..4a7a1b7 100644
--- a/Documentation/virt/hyperv/index.rst
+++ b/Documentation/virt/hyperv/index.rst
@@ -9,3 +9,4 @@ Hyper-V Enlightenments
 
    overview
    vmbus
+   clocks
-- 
1.8.3.1

