Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3B6A4A24
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Feb 2023 19:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjB0Sqh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Feb 2023 13:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjB0Sqe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Feb 2023 13:46:34 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1631EBC0;
        Mon, 27 Feb 2023 10:46:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5XuLijVF5ZSV7OT0E2lSVeW7aU+Dy1h4R13NDpUS5FrH7Fqz6ZQn5l1uqE0TgyShf0adsVtqIE9+DnSpBw5nQpqLGKqp60QkekaM64hRTnfqgNCsiE1CpjlRpG2pPELmft0TKTERsbwP69mUQ7m5VuvcII0U6CnmfwyHF/YSWxoyMSgVPSnPjHVJ+A10ZjNkbRfTyAPP7fpeD7go6zu5nYn580accAwdi9WfLkxWgieBFL2Ax3wE5JZKzrGxrs0S1O/agF+lhiKSJ/Wg6QJCPZCgbMXAGAY6Tr3P4R2FRFoWFd+bszfqHzrI2XJpVswZShYgYRb1wrdXpaU8WM3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcw81akklfYnX/J83j6kxaFzg64Jzpfb9oRpgJVFFpg=;
 b=kpYZNp56wuBhG6j2cBrhR3IBIwEAOO2OtOpXjRUOKvFhV6+cdedyFWfrjRBi1RfTxwXYuQLpqFK3O0a8TdNyTApwZIARkXE+DYpSguvh/NXT6cTaQWlUh7URzakko4LuxnzNS5EZazP+Y08fDmCLhL4qSialG6/qaBOLBlm9S2xWGzGw8i19EhQrx+7JqI+7idsEcEd7kWTarO6rST2ha/4zspnloGOboPI/krc8QYlQ8o8wNLNONV/LZ3mIiORQS3xycwpzsr2OFBXZQa+yyEQltSm4zFX2tue59YKkpQ1JDAv36fJdnx4YLf7FG341o+lfG8mO5/7Zj3ONUOEadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SJ1PR21MB3506.namprd21.prod.outlook.com (2603:10b6:a03:452::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.3; Mon, 27 Feb
 2023 18:46:29 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::caf1:81fb:4297:bf17]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::caf1:81fb:4297:bf17%7]) with mapi id 15.20.6178.004; Mon, 27 Feb 2023
 18:46:29 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to /proc/stat
Date:   Mon, 27 Feb 2023 10:46:08 -0800
Message-Id: <1677523568-50263-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::16) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|SJ1PR21MB3506:EE_
X-MS-Office365-Filtering-Correlation-Id: abd16a85-d0db-45bf-3854-08db18f2f04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VImuKJym3NOy1JnCfl+b/zfcMvzB/V4xx8r3FbNnhzTJ0lwDwzX4qI/8dqGMRjAnP7HeI7ABwNI10aq2Z2xLRzJIPvaYRVHcPUl7PIX8HaAsYllWw89on3jUjIz4/TJ32PDHId67dWgiQD4RYInNRIJbiWdjztew6F6sJy2m/46E2tuD2ITreFwP3KMfQo432s2JhPJNdoIJh2XVdY1YP+ko4KPkl+OEuTKWquMmf9dR7AQ3Bli9rUGFJOiIQ1HYhWmqkVGnI3+S4g0/Qw8d/Da0mW4UN/YGz++HHHvl8oeGRRN8f/L7EUGxrRGzQ/Tm3ePMlPX7wHD2ojSF52kf2jr3GHEnIkV4Xfpl9VtH1N6x6NskKyNUCVKClbY9ib8soZn3rrcIj6jPrjBTJRYLVZpsBN/irsyXzqYifDRqhG39ZT9b1rBCFUwTSbgh5YG/PvMbITXQ0aZ1DNo6OfWs0afsuLfyD/SaZ3Z9SC2tETXqD1ywGdgYfeHc38jtxfzfq3ipRpLEnXhX7MhVZjkOdztNTM+Lgt/P8DTwi+s31QjnSl2KWFtWqLfH8jooZROOUbOkte5qndc12mjdeA+zMHyhdTm5lqdqr+PmsDuWDW54SzXNoMNd/BQtdNBA487ihvP8/eBjZ6FDP39cxmo+R8I4BRiTCgqBN1QCg8Ynyole0Qakik4j03BmGabPoYRVs0BOq90lOl+xLXwhzBgNuy0ZLD/RyAifIAMJmQrydMwo/QN3HoQei5LlZ4yDN9xk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199018)(36756003)(41300700001)(5660300002)(107886003)(8676002)(6512007)(38100700002)(6666004)(82960400001)(38350700002)(82950400001)(6506007)(26005)(2616005)(86362001)(186003)(316002)(66556008)(66946007)(66476007)(4326008)(52116002)(10290500003)(6486002)(478600001)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6UDJd/yAY5dDWZmUjimNk/KXbvWlGoZ7V/kM4aVYwF+7AYW6YY9LGntGGp4?=
 =?us-ascii?Q?UakqJljmhXwAehmRHNZVv5EjjBUoYk3wunasksXbtJ2p9XR3Tm4goqpr1myF?=
 =?us-ascii?Q?EbFCMXkVUEDCRdJKlv1sI4251AFnR9WLGyPkQdC5iV1lYrlaEwkPWIJvLlNz?=
 =?us-ascii?Q?7H/bjNZzCLIHxFtKRdM+K27na/dTKn93DIRnmnw3etC1WrXGYbFBTJeIO0QL?=
 =?us-ascii?Q?xMKHKGBT8FtsFGRYLLcrN1VtYfM0fjR3xlLi7FOVL6JUjZgHyCZSRknAWTIE?=
 =?us-ascii?Q?dPXFcd01SpnLQw4s7EX8iXdXaXg5Z8BR+mijLxTQNNXmnaXZKRGJPDhLCQPB?=
 =?us-ascii?Q?UZNxM1pGuGR49irMot/PAxsmiWISEhV76WoJTviympUMm+52TtLRZC/d09UR?=
 =?us-ascii?Q?WcJTJEPqHX5vdTpd9lp6BbQ/gbkkCSv/FLfYdaTqiI67gdMrf1ieYcx4d37w?=
 =?us-ascii?Q?j685B0x+hWvlsfy0qSwsLW5TvmaQACQG7Y8/G5OpMWcz0OziLL223ltvOxxc?=
 =?us-ascii?Q?ZxkVeicslNMQwCz6b7pw2NTt47hFlrskBjava+KK44m+3ZxY7fugubgIh/D9?=
 =?us-ascii?Q?wsQObrqMBZe+bDO9a4JWsD3nQ5MDXm9s7VqL0ZSrE/zCZIm44P4eBPCM3DUV?=
 =?us-ascii?Q?nLeNgWLxEpz9+hWJ4L7cyjMN/jaMiFNlW53mjy2t9UNxqityQnuFDoXboOW7?=
 =?us-ascii?Q?o5Rh6QRjRLgBS3ViNivEHUEnCU/EyiPS/JiPlTrDr24a/nSFgXKMmeG2Ltzm?=
 =?us-ascii?Q?8I/7TH9Pj+fr0VXJb1XjB4CupBpMVAgCLEjukWaa3qW3Tna8b/JJSfim4fgg?=
 =?us-ascii?Q?wzFJlxdqUkKjR0IbgodNKHU1rbIngk3V/2za7pCoguQmGuDqbgEbsWMxerHN?=
 =?us-ascii?Q?XQBBc/j+Wa8J2BtA0We5dbGvHQmArId71CheJjL+55IZH7BaXKtvtd/Z+VNO?=
 =?us-ascii?Q?vn28q5pRuor8ak/K0z+EAj9WTZJNsvKBeGyeF23YUG+7lUFPv8/U1SJsuHsv?=
 =?us-ascii?Q?z8nfYvi3V+OPpfdeDo6p6McW5tLtWYknrDzal5gODatXKWWDBmHpM+N1tgiS?=
 =?us-ascii?Q?oDkUmx99DOlroLHQ4xk2+F0hBwtH/ZLexrDG3Nkps4ysMQLv/xdUcWMS5Of3?=
 =?us-ascii?Q?qrpoWVD3dqc4+9wblrxfvvTBuEf06f2VKWA8MAW2oED9oOgvA6TGD8m6vdbW?=
 =?us-ascii?Q?hcLYZOQG8o55hXiR45HnxiHIxEjStKzTmGRHMMltZkDixJpmS9TKKUXfeLWI?=
 =?us-ascii?Q?YFUA4AD8qZee7PcMQJebquE2oGF8rD2hvP3T0W0fVTRVwxu1jEw58O5mT8rt?=
 =?us-ascii?Q?HrXbKBTKbNnr+X5SDLNKdoli4A3A8Safao+n3UdvZrCxP+8DhSk/lqe1gKRa?=
 =?us-ascii?Q?vVy1qQtjaH9Jkr/aqfPq6E6lq7sIcaxe95cweik8Cd7xKMaEIXxQxqnPfEFA?=
 =?us-ascii?Q?PZhbUsJzJuhr6t8i9ZOfCRbOzTP88GqT2YT/Sfm+nlc9OVyGN95MW7a4Os16?=
 =?us-ascii?Q?+bq9Wt9fdjL2VCZNjsAEnUPeTMOXngyt0UIhPCe8mqgFS+yj3XvItEbARNLP?=
 =?us-ascii?Q?WuNcxT7fHhLoWUV78U12QDAsz03hXLA80b7/Q4+QiODccWQM3X96AYJKUi0E?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd16a85-d0db-45bf-3854-08db18f2f04d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 18:46:29.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfDag4LBqrrPZvxHsHTF18PZ9hvN1A8uf7WFVc2gms7/Zdr4g/MvyIWUS9ggb98WA8C0rXPHfTlQFWuhpVHVhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3506
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Some hypervisor interrupts (such as for Hyper-V VMbus and Hyper-V timers)
have hardcoded interrupt vectors on x86 and don't have Linux IRQs assigned.
These interrupts are shown in /proc/interrupts, but are not reported in
the first field of the "intr" line in /proc/stat because the x86 version
of arch_irq_stat_cpu() doesn't include them.

Fix this by adding code to arch_irq_stat_cpu() to include these interrupts,
similar to existing interrupts that don't have Linux IRQs.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/kernel/irq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 766ffe3..9f668d2 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -211,6 +211,13 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 #ifdef CONFIG_X86_MCE_THRESHOLD
 	sum += irq_stats(cpu)->irq_threshold_count;
 #endif
+#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
+	sum += irq_stats(cpu)->irq_hv_callback_count;
+#endif
+#if IS_ENABLED(CONFIG_HYPERV)
+	sum += irq_stats(cpu)->irq_hv_reenlightenment_count;
+	sum += irq_stats(cpu)->hyperv_stimer0_count;
+#endif
 #ifdef CONFIG_X86_MCE
 	sum += per_cpu(mce_exception_count, cpu);
 	sum += per_cpu(mce_poll_count, cpu);
-- 
1.8.3.1

