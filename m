Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF095672F4
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jul 2022 17:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiGEPpE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jul 2022 11:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiGEPpD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jul 2022 11:45:03 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E352D15FF6;
        Tue,  5 Jul 2022 08:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGcW1iZjci/xkw/8vjy3lPc//sEoyb4fx4AANjCUe3djUX6sln7W9Y16oKWLW4xasBakOkejc10Nzyguz8Zw5vLjStZGVVkC68hCD0UT0O4X7D59FxU7gr6J1PH9eHucE4WQdVXluxcTt48wwnr0gRlku322a9xE6sQN1IckVc8Wyy2mdrQKqYqJZhgzkFyhVtgb8oLWc4MhkZx04oFABW4wPPL/zLix3WYwAXxjUS45VYF3rpyxV+YjT63+Z5iY26w/xKGg4Cm1GcBJU5cUylmPT5ROdSLWEh7f+I9zwa87fznCxOCxx0UEUNFLocRU/Ud5xcnnxYpBjze+raJ6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRGms1+lb5F45Tnp5jmqex2n50PDIorw+aTDag81nWo=;
 b=hM6YtkXkbKLyczQyEjtz9+JyjIgqrr6rJZf0bhN+jrma6czK0lnDjzKZB1EAVQi7JgTfJK5ZpGmNQgrg8hnBefNpzCa/VxP17QUEHd+oI5H9mHB7fQdGvYRVKAfnv+GcOUu/6akmZK+89Eyp8GwwpmSX44uAgvOIocTAA/1YFRTZJFxdbin0ATtP7DcKRsuBDnb7/8WbyuAQcPOGfyqRxnF2Drp6gaG1+M26LLajjEshDvT2Agd/gd8C6Tn9z/9zu2QDbJuW0o3dqtbw0Sv0TKeNrsAkQOBOh/zqjefCXTAncaXpKl/pgJpxpOBUMANe7MLSyVgCl22cIsgs4ZnFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRGms1+lb5F45Tnp5jmqex2n50PDIorw+aTDag81nWo=;
 b=e+Hkqyxpwce7Sz6kjR1F1thHkU3DRhJNOoeVG9vmX7gJlyONJeUojO93JMVut9MiU9pCUtJW9Vh5gdzppqN9kIImVkesutz+/xheF0iOOoUiI7c2DVh6cW/OAG8MI+FiIcvg6b697862DF3QXfsTGXDeNYNeciqk1jlpOAU+0Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM6PR21MB1322.namprd21.prod.outlook.com (2603:10b6:5:175::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.3; Tue, 5 Jul
 2022 15:44:58 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6%4]) with mapi id 15.20.5417.010; Tue, 5 Jul 2022
 15:44:58 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 3/3] Documentation: hyperv: Add overview of clocks and timers
Date:   Tue,  5 Jul 2022 08:43:42 -0700
Message-Id: <1657035822-47950-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657035822-47950-1-git-send-email-mikelley@microsoft.com>
References: <1657035822-47950-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:300:ae::24) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e5fbbb0-2f61-4899-7a52-08da5e9d5089
X-MS-TrafficTypeDiagnostic: DM6PR21MB1322:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujwNx1WL8IoISK8nRXY3W+qNElLMJIbdJklwbYWllR+dqXr2blaTCseaUnmKKltxHonXRyvhuZIFUwTgWp2Kvxbkx7djyP+XJycy63/g2L+5ZDbyAuo4VTuegxSjC7PNVRhZvINHrrUZi0koNwk3fDp+M/bU3ql3BTWhPzliJwBzW7ngQpkVPb5XzUhk9gV5EZdryNpUdtsum/ndRJainx5Z/T8aial4bnrLs/mlHpe7uOXKi+7GCKp4zJf5PF31MYeIKOshVwNByydxGi7muh0hDQwl+22WQ18v14QBGHIV0i2YZYcvqOZr8PUxzXAZ6xs20hpPT54pGz6NQ91Z30zNTMzRsMfsqQTOsbiXMmhmjUt+3vDupCXrODVwuRzVA7FsCjLdKXSmxlY4MUK8GHNLqmwIoSv33o2j1KKzYntEtpWfsn6be1BnhNAB5vUcDELa/fKounqI5dUaj3HpyhGBbgwHKKkHIlFlrudFIUmS6wjcYhEa0AP757eYFYBRl3OcE3uGBA5vQEW8sBv2kK0JSTp+DqZEJBaONOCLVfqMZxAmcFyKKDutlK8jbc4srEbGPgBEJdKpnoJPrcsqhaB4K7SQcq6EseDhHP4SJiMVtlMzxEowN/LgqkygqSoM3px0/DegHpRxqn50FpnSrDjgjOHTw+97DMjfyacPLgO264oeSWDk4FeGrXH4Q6sTJ72uDYEAQenkYevCdbibcbE3XfaP/1o4GfW2urZB9dsI2J88gR3i7BnOPpYwXA/8Oadz+wDvv+7eLVb2Pq2q6XUFr2W3061czkFs3PFczBgBrDnvSysuSvP+x2vvjSpytcYa34FCyhu9b9AisK6f9cKRdvDoirb75FJ++GRJAI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199009)(26005)(41300700001)(6506007)(2616005)(2906002)(6666004)(107886003)(66476007)(186003)(52116002)(83380400001)(6512007)(478600001)(6486002)(86362001)(5660300002)(8936002)(4326008)(36756003)(38100700002)(38350700002)(82960400001)(66556008)(316002)(82950400001)(10290500003)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YhS23irVvOu9Q1ayWhzIN4OsGhSVimvGtOXFWoBTF0lV/eXTrvf4TYzTAPvn?=
 =?us-ascii?Q?In64R3aFoTEncO17mXeDNvZhVuUYwdmK59Ug5/NWxH+zpGV21KeI6HrwqSKL?=
 =?us-ascii?Q?Jca+KX32DAJNSL8TqUOw3A7XAaMUenAK5uYj7lqpj/mRAYV1rM85DL0ZDuyb?=
 =?us-ascii?Q?WZfoxfoI7phprDI3wUudIVA1EfQw9Naplu3myjjYT1lozgvVxInDHpHLucXn?=
 =?us-ascii?Q?sW9f9v6sTQbxqe3dZ2usAkyOu5yMuBXpr5v7OUnuqgiqfcunzy1qQcDL78XF?=
 =?us-ascii?Q?bruNl1pTC9bQYscmZVjRTM0bSt2gbNRnrOCsGXhyZbJi8mW1BoRjI8hbSriN?=
 =?us-ascii?Q?xfmeecRj/gOKoX+lYC+dhjbc8FwGOr9Wdkfq4gE4CzG0NtoTbpu92PmRyASz?=
 =?us-ascii?Q?VXWFEzF7wlfCMvNuAQD/fM81FKXCq6NzqX8mFjF/nV3Zf5NJDuG4+t8qZKH+?=
 =?us-ascii?Q?C02kmn0vbO3hPizB59yjZ43UiU6bHtZ5l5v16XCw0SuimmyvRW5AYwRcF7iC?=
 =?us-ascii?Q?x1tZcye8ICMckkYiA8LZU4cjN3prJOHkiEliWB2ypIIr1THP2IOn6DH2Bax8?=
 =?us-ascii?Q?USVpzpjVakuv/VinN8uXp50606k+sAB7qsymmB79Np3exP5aocuZuOdFw5V0?=
 =?us-ascii?Q?2DUB5V4470iy2CD275y9XIPW7cPHmo6vDfLAVHYZDC4XJc/uFvMKFB7DoQPb?=
 =?us-ascii?Q?9SSlhEBM6iABksIY1K6D8u2pbcrfxON7hhRSqswui31Y3cJeTGnUI12dOGkk?=
 =?us-ascii?Q?1ZccCbRLPkzh2kp55ar/guEUf9EcPo82uKRMgaRDFPzvXMiWzZj9Wdtbne4g?=
 =?us-ascii?Q?WCJT7WHaapb2ou0V6WTGETZIWEDEjYz0O5C5zPqbxcQ1kSVIClDW5/AXIiz7?=
 =?us-ascii?Q?//4BXZ0pe+2ZKp4EOobafG3SEjFlNYCeA6LRmkWxM+Qnp/ENQwff4QTYizQJ?=
 =?us-ascii?Q?LrA0a9jiuRYz8A1T9rI1KRJFS0dQeXEXhnkxdyg9gsKs6GFcm5bwQ1+GFG0w?=
 =?us-ascii?Q?wpBbjH2j8ILmyRl39PvvhAiSchxPrcHbdAEKdJsRcGMVopqRF/Ns8JtQu1R6?=
 =?us-ascii?Q?yymNGaadvxHwv+jOam8F7GAT+GD/f/HkEPMd5UYIphf953vh5ZlBtitc4zNq?=
 =?us-ascii?Q?lkr2c3hY3JInDCuC/VxtnpMF3yhynQkT8ZZV0Q2CF4OkSvU4zjEuFHu1GcEl?=
 =?us-ascii?Q?jpeaMClliUxI6oKRYl46Eq/Sm9Y8Enh2D1kxYI7lGpjez1EWtwwXbdVAKwE/?=
 =?us-ascii?Q?IfHYGj1cnlRTbhSJYRpAt+sd4kf+qpcHC2/UA00sf8SRqMEVyqNIC2kywggx?=
 =?us-ascii?Q?t05rdsEzBIZeGOBtOMgHsHWKi12Aervgmh5f+0HCfLmbhNVsC9Yw05HgMqdn?=
 =?us-ascii?Q?Sg/zZG6tYmCkbLAEUdm+D8UPsy9E64hWOpbwRY5TlgbUilSLzVO7bxV+fcWj?=
 =?us-ascii?Q?RxVQNZzw/2sBpB4HKNd91J20DNjk+4cdcUWn68FfsqVDxzrgOUKRDknLeF5/?=
 =?us-ascii?Q?ix7C7DEZJavfgsvptj1KICojWGPdC7lu9MOeLfmNsGejEI9MRa+iTc6VK8EW?=
 =?us-ascii?Q?rdnNYNmMl3k0K4RnxhZcCE8qV/f040UH0y+nycSxeuRxa957Ezec8ZhgD2Xo?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5fbbb0-2f61-4899-7a52-08da5e9d5089
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 15:44:58.1972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnwjcRDxlx5539Re+Sth64DgMuqzk7eIGYx817B/nG37EKrbbgk0upXRUDOCq21BYybw5bftVGchovinX8uUlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1322
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 0000000..e4ba2890
--- /dev/null
+++ b/Documentation/virt/hyperv/clocks.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Clocks and Timers
+-----------------
+
+arm64
+~~~~~
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
+~~~~~~~
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

