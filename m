Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F175B8C7
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jul 2023 22:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjGTUeg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Jul 2023 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGTUef (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Jul 2023 16:34:35 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020021.outbound.protection.outlook.com [52.101.61.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862121731;
        Thu, 20 Jul 2023 13:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzrXYMqNNi+rwUP0uG/yvkom2TBl1aIAQcWqCDmPM2oabPimSnsnyMQNcZ1qvnw1p7rVcSs8BIWn4arr7Azb3MX/Ui58pr9YMMD+qIU7meHwuQkFTKX1QwPx6WhEIcrykmU1/kMc0U6Lv09aNcDS2ZpXLFK6Utt6G71WsLsC73iIKXuli3Z3CLfr9aSagKcLC+hQcH1rYAOtPP6Zv9lO7KO/iDaRkP485hX/uZzPoe9cEH30KjbbvpegNTmgBSlqEcVgsNcu0BYg4Zip+qwph/fJpv5q1Ws9Gh4mIEqFjG4Y65qGh6XFwECQWIIHUsaOsKucisriZ1MMArrST8KpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsErRc8q7g4PRs57iAEj54hLYOnhzglg+Hh42DSFbZQ=;
 b=JD5IHxOinx3ESTjKjwNMzZ3j4vmoXplExUQZF6999nfPQDHQahV2G93XQFHGWNEeJkZSazvfC44eZ3l63dW7D39h0fJxite9yPRyROwNFHxE+ZkiwKssy1zn62ZyZWM6QSTU+FkojUbBBnkkSwH9/AVfusQkN1PnsIBx4Q/pcHR0tpexL0ApF6R7yl8qnMe+jB5FtRmq6GljfO8EPGLszh6CgKws3vCs08Z1PmBovTa5z6p8dvDNW2VDZfsTfVyGqxLB5yBdGtPpMcYfom8BbeeOKpqn0NXlTHFp3OfggmghEbsSzK2VfJY0L1lUJcZyJyZc73dulKxC1OGkY5lU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsErRc8q7g4PRs57iAEj54hLYOnhzglg+Hh42DSFbZQ=;
 b=IfeAXTQ2Z4LJamWMaDueK7v1dOPS5yTPvVOiYx/VYry8e/5LxEH+J0blygysY3Qa1YjW19MdaYZYDeSoyHnkEOUKbL4fJe4KWrQEKgF8ukVOJEppZREvAoetcnSMZd3Jrl2FUl/4Zt8bJjphW02gAuDfLSH6aSWmys94i5XZzu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by LV2PR21MB3372.namprd21.prod.outlook.com (2603:10b6:408:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.8; Thu, 20 Jul
 2023 20:34:31 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::58ed:9fb:47a9:13df]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::58ed:9fb:47a9:13df%7]) with mapi id 15.20.6631.011; Thu, 20 Jul 2023
 20:34:31 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, stable@vger.kernel.org
Subject: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks ENDBR instruction
Date:   Thu, 20 Jul 2023 13:33:57 -0700
Message-Id: <1689885237-32662-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::14) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|LV2PR21MB3372:EE_
X-MS-Office365-Filtering-Correlation-Id: f0676b1c-2d56-49f0-b2a1-08db8960b86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J82f3JfiRciJEAz6GB7qcUZ5TKCxe565KVitsiyHWgf4zjC0eTwB6qeQwpJGmCMB0e+HKjtt0wosr0mCxqLxTpEBDwiyhOWW/dlwhDt+VSZd+P8GXePNH+gm6iDTNdZ+p9S3Wy6zRjCkPiEp9nhaSQFoxm23t1wMt4xVYpAPKZQryIfhLuz7UUXdcJdh4g6iVNhCG/xvrHYus/YKr2Ku04FD7Wt6Xng77KwLHSfBJay19/3ECvfTHFpgoLeV0d3Du3J66EnHWrPnNHB5NCaMpCXTVVzQezjaPvaiXBtM9KXZ+B9jmHmJI2DwjjCqi4UlItxeTM7aYoE6Pjcf6KephSITwnP38MlJI3U0x3BupTgfbczEHQejXY4k10t5GCHeTlqvef7I+oaT9ZWrjaVUyXxBO/JPMp4/Xvhs0fB0X2jHURpPjmAjBSFtkMUlHQTrUxquDoCEKEQncnG00r7CMf2m73C/MnDd/X2XVGNXYQ0XJ9H3LOInr6V9v2NtiMN1DGELZ4RmCy4HbcuUDRKLjrQs/e8K9QOafWgAN+MYvVmWCap6oIsVKNMwR23A5mmCHEvUQEy7FBAN4zhJtAJlWPD+WDKHYm2/Fsnzik0Pduxf3kUnKaRvsm5ALr+tfvZDz5njP6Q6werKGUL6rLI9ILglxJKkgmDH7jKKCJELDJF7KCQp8W4kktdr5aHr8Qb0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(66556008)(4326008)(66946007)(316002)(38350700002)(38100700002)(5660300002)(7416002)(36756003)(8676002)(41300700001)(8936002)(82960400001)(82950400001)(86362001)(921005)(66476007)(6512007)(6506007)(26005)(2906002)(186003)(10290500003)(478600001)(6666004)(6486002)(52116002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NuG83c40c2HCcrQhiS/EmkYyntXSr+fAFSoM0YUWxUch/if3VA3XTZlrdDzK?=
 =?us-ascii?Q?CDGJUyKzsPJTWisA6u609o7g6I4odk7OGIF1UEKqtfX9kGk2YFPeZ3BaiaGw?=
 =?us-ascii?Q?SOOokv9eqIxHZ+Dj4n6HtVgj3nCepSkRXzbCYNrOFYqiL2gjNzXQ1E6URclB?=
 =?us-ascii?Q?MtxK5EYMORRkIYJZWlJKTciv24CXeHN3FiYyJ/shhs29w+XvzaWnZRfXCifH?=
 =?us-ascii?Q?mwRUhG+5q4H3gS+NzLKMft6HuH8FuO5R5Isk620WvjOeREynOYjinhD9qr+d?=
 =?us-ascii?Q?3cArWWDy67G5BeltgiZ9OZmHfWJJuNaE1DCARN47Zj9PTFQPKq5d/fwuNSRi?=
 =?us-ascii?Q?2JJJBtCBI1WlL6pNiOGbqSQRLIP/k0Pttsx8sP8+Ql7PB1hTUNDm65ZJHTQ3?=
 =?us-ascii?Q?KULB3AbBuqMLmA5ifeBID0cWoEPIGO9ITU1W23Uynj2XmbpIX5fa8pdqrwP4?=
 =?us-ascii?Q?aNE21C8ygmdiVuNAsja2lhLQ/gOViQkm7u2ite7Lt6iMpMmpHDImh6sfTLow?=
 =?us-ascii?Q?vHGKda8jg+SOsqlsJRbuhmhADVh88iwTE2rNiUj5uN0ta1pJa0hbAbR33DrL?=
 =?us-ascii?Q?TpxD4etY/s2zA+4dG6z19iXElj06U6iJ6ehi7Of1bFlObnzemPh6uUNsTiFx?=
 =?us-ascii?Q?047sNO9uC51ZoSHX0RxY+/R2Jt+OcJbN7Ri4ycjy/sc4pVC0p2wFgEj5bgrt?=
 =?us-ascii?Q?AzlkGrAVaV4N7lsX9jefU4iDydqAVagUKVfqJqYEpY8akVXDtKBvmOWNt+52?=
 =?us-ascii?Q?V4JQiKnM4LUOz0ZsJCLznrkb4BucqN7+TM3naFuVHN29ShVJvwgh06LbjoCd?=
 =?us-ascii?Q?09Wq75Jn61R2YfK3q936yombG5KWNhRVkis2RPeTp2RVoRNPKqHR9/96UiNv?=
 =?us-ascii?Q?Tn+w5AUuGMiXc+Ro0HcwellV7QFMbZrblDlSBRetKNWgLpdLn9pzPJ16+Qdq?=
 =?us-ascii?Q?wQYXbqK9UcGisWi6j8fKMXN7DeY4U8Fz6PD4KpSCMdN8pMoXQpkN4JmveCwA?=
 =?us-ascii?Q?N5ejeqgTr393uIrj9hOTNsW4W5Ja7a7zpdEo3nTojZ9yAK9VRtDk+NCPZvC8?=
 =?us-ascii?Q?wPOSvKNYgUOh+JIYPwK42L9A8wjLdUjHykwUZ2q6Mj0sah4GiOh6hipPEEr2?=
 =?us-ascii?Q?uqTjuUBFv66sCiqYlCc0AHLyOg+rBOuRxx2SBWdp04yX4MNzgRCokYWWB7Jt?=
 =?us-ascii?Q?LmKhMHkdid8NcoMF/YZok2jJByAva0fB1k9G7BeGwtyovrrN8DnHJFt1v7Pd?=
 =?us-ascii?Q?lhfHrFT1tA0V/tKBUWyd32N8pY3q8hyjjxClEKfgFja3exy1NXjoQE2wiNOx?=
 =?us-ascii?Q?ceomkEajLu1NtK+frp9xu86wducP4EP0d1BOuFkmLI2SXILesaftPUkMTfue?=
 =?us-ascii?Q?NOBEp5UtMNEDhPN4iwjKZxg16r5uuWeY+xIscBG2BQeGvkTqN4tOacdnAL+1?=
 =?us-ascii?Q?n8ycwgGvuBf+GXbNuz6YhyUhCuJaWoWbOvya5H1YVzcX7dOO2McC07W0M+df?=
 =?us-ascii?Q?+3sK7Brr7QxEGLgNmZnxR8dYiv+RigqPOumDroN3BCXTOvXiaPRKxRP68qpN?=
 =?us-ascii?Q?7/OJMhDuw7XK193EIuDgNdsXWPwVt7Pf+sPeHp0W?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0676b1c-2d56-49f0-b2a1-08db8960b86e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:34:30.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+RHfffXSZyvzSLyusr0lOqGj5OnmoGoAAwtQff//vUhmmV6DClL8vHdJoHJKTlW6nLIGA9pFp6zVbVryq4iYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3372
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On hardware that supports Indirect Branch Tracking (IBT), Hyper-V VMs
with ConfigVersion 9.3 or later support IBT in the guest. However,
current versions of Hyper-V have a bug in that there's not an ENDBR64
instruction at the beginning of the hypercall page. Since hypercalls are
made with an indirect call to the hypercall page, all hypercall attempts
fail with an exception and Linux panics.

A Hyper-V fix is in progress to add ENDBR64. But guard against the Linux
panic by clearing X86_FEATURE_IBT if the hypercall page doesn't start
with ENDBR. The VM will boot and run without IBT.

If future Linux 32-bit kernels were to support IBT, additional hypercall
page hackery would be needed to make IBT work for such kernels in a
Hyper-V VM.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6c04b52..5cbee24 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -14,6 +14,7 @@
 #include <asm/apic.h>
 #include <asm/desc.h>
 #include <asm/sev.h>
+#include <asm/ibt.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
@@ -472,6 +473,26 @@ void __init hyperv_init(void)
 	}
 
 	/*
+	 * Some versions of Hyper-V that provide IBT in guest VMs have a bug
+	 * in that there's no ENDBR64 instruction at the entry to the
+	 * hypercall page. Because hypercalls are invoked via an indirect call
+	 * to the hypercall page, all hypercall attempts fail when IBT is
+	 * enabled, and Linux panics. For such buggy versions, disable IBT.
+	 *
+	 * Fixed versions of Hyper-V always provide ENDBR64 on the hypercall
+	 * page, so if future Linux kernel versions enable IBT for 32-bit
+	 * builds, additional hypercall page hackery will be required here
+	 * to provide an ENDBR32.
+	 */
+#ifdef CONFIG_X86_KERNEL_IBT
+	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
+	    *(u32 *)hv_hypercall_pg != gen_endbr()) {
+		setup_clear_cpu_cap(X86_FEATURE_IBT);
+		pr_info("Hyper-V: Disabling IBT because of Hyper-V bug\n");
+	}
+#endif
+
+	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
 	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
 	 * apic_bsp_setup() -> setup_local_APIC(). The direct-mode STIMER
-- 
1.8.3.1

