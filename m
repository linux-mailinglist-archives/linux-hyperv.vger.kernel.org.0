Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1F02400B4
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Aug 2020 03:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHJBaf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 9 Aug 2020 21:30:35 -0400
Received: from mail-co1nam11on2094.outbound.protection.outlook.com ([40.107.220.94]:36346
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbgHJBaf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 9 Aug 2020 21:30:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQslh08o5umuHJKtTvb2RAoujCYIPe7L3I0yRkTEd0SbUYQZ6Tl0TKbEpmEVYqePBgAItzOgULspPY4gU4616ypmMJMse+vk1fsZx0lNz9h/iKgqY5DV/cB0aMPvvefnGVen6IG29Dz7Eh3sObgQO/UWe7uOw4R4NC9mChrPgH4ajYClCXJToAqQUemFs4kHkvfMBQ92VIy/IIK7l101QOOk8EtY/i9mccGzBKV5zxQghWiM/JSPk9qClOuFjn/NjvvnV3mwqY1qRU84WxiHExMnhkjIyFih6CIqzRCxo2xOIbU8oVZyzAlNs++bYsAzpILe2Wc337If/jLm1eZEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3O2kjEC7z4ZY/s56bEVyMwsdMVYIL6hf7CMP1awDdw=;
 b=lyX6Cxh33nxDnHzFhYquNZyAYrt7isFvOO5UPR+2Xn28wywyovatFCSDVXhMKyFwnJLUmqH/WxGYrjm6fYlsAfz4aqMPXUNnJJJGOPRsSp0Lxrkzzp2hwpS3R7YQoz29saY3VyzsIa0cIkCOAN4sD38ypqxMNL/ApL1W9ThcFYxZXWtK1vG38TP4DetvNVrwLDSBDtOLPiHES1+E9WTArH2qWzLdSjrmpeqzaD/lpvkKDmqtIBoBdeA+u210H/kVw9aPskTd+cCJ7RW/QlpjUi0oDpE2fChcRr/nIILjdjMD/fLiVWHWMLjU6Rw3tbAGfpZapw2NDuW8vlvK5W8OdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3O2kjEC7z4ZY/s56bEVyMwsdMVYIL6hf7CMP1awDdw=;
 b=Z1ARqW4y/ttAp2OhRK9CAxczCdxI+FklymBFVC0Yu5YKMzB5IMLu3CTnsCZBevtRs+kowzVTDy7qniZ6gS+lqeMA0eHNYjENBUuPJEWDKzn+vBVOKq+tsIegrr56Mwtw9xtgoQSCkaJth0uimzGDw220h+B/gUzuQ6MhNC+j7zk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN7PR21MB1636.namprd21.prod.outlook.com (2603:10b6:406:b8::32)
 by BN7PR21MB1652.namprd21.prod.outlook.com (2603:10b6:406:b8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.1; Mon, 10 Aug
 2020 01:30:31 +0000
Received: from BN7PR21MB1636.namprd21.prod.outlook.com
 ([fe80::60bd:f5dc:fdc4:1600]) by BN7PR21MB1636.namprd21.prod.outlook.com
 ([fe80::60bd:f5dc:fdc4:1600%2]) with mapi id 15.20.3283.004; Mon, 10 Aug 2020
 01:30:31 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, kys@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] x86/hyperv: Make hv_setup_sched_clock inline
Date:   Sun,  9 Aug 2020 18:29:51 -0700
Message-Id: <1597022991-24088-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:300:16::20) To BN7PR21MB1636.namprd21.prod.outlook.com
 (2603:10b6:406:b8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.16) by MWHPR13CA0010.namprd13.prod.outlook.com (2603:10b6:300:16::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.7 via Frontend Transport; Mon, 10 Aug 2020 01:30:30 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.174.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b73aee1a-92c6-4bb2-1e8e-08d83cccf878
X-MS-TrafficTypeDiagnostic: BN7PR21MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR21MB16526E14EB7FDF12FCC971A2D7440@BN7PR21MB1652.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTWO7UCsVpJdm/XsaC7GVltXCJKOHxu8QNDjZv8kNmFNEIRqCQkNzU4/YL1zDw430pXdJdKnweOGCZ81rPiwtTEQQrPT8dqxq5eEf9sYmMhrO40tYqHiJR7XqPBWpyK0QSD0OC6qbv82kBRwSBcR11y5gH15gBTLBH3ZfyLDAlEaTzmrHLbP5FxFXXPNSZKMVmt8qeUGBFB9jiOnDtFPStw8fqQpFyP0P0FPcXVcT50wXlwwn0nHcDdjq7RBzwGjSx2H4EA9hSvgSwVCvGl0Je3y0IFj84rpxf3lib9tnu6q2WUdsgK3xVgho2L4pvBlnBnk6HVc82WAqfPkvhuoqQFlOwzsPP88WOn974HF3DF14ZHjl7pyLQg+HKzsCU+Ufs2VFQNikmga0HxxNELp3eXZFbR8V3OHIBus76IZ8YSqlP5dotwHhPYKz1+MsX6w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR21MB1636.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(6486002)(66556008)(2906002)(66946007)(4326008)(8936002)(6666004)(52116002)(26005)(956004)(86362001)(36756003)(7696005)(2616005)(107886003)(316002)(83380400001)(8676002)(5660300002)(10290500003)(66476007)(478600001)(82960400001)(82950400001)(186003)(16526019)(966005)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fLv/sF4MZFbm5HwYOUyrBjKg8+yZbEdJbBkW5XkQee3n+cN7SzStCr6cGQW4J8TWMA8wEVTr8giNttUNh5LOKwgs+yBuavixRDOMz1SsLlc92W4cmPcZ0pf1Jrhajj9Qgksav2VkjaixxrnvMIRV1lpO+3H6NPAzR4rbZjRFHuDuw5k8gbvSq9fTb6TLKft0hTDJM/P8oFub45fpjfWwTqqbI1BK0z0deT/JtHCNoLLhFvNQMABhT8bUI+Npm5preEyvCfO9JRTfLpvvlyjkQJGtYHukSfoTSBHnn79Bt3XIDXMncdq3HFzsDNG2JGjOOt45sNPjMfcIvpvUxdJZzJWNV+LFd+X6Ev2z6qtRtuSG+ZQ8Jvha1oA1PXicN8tS7mhJAubDvuVtBbVoe7/agcwWddNUjpd/7d5aiIDsjWWdNVSHL0VJO/y+P3DfKb0U7fZEZO7FDxz6AEVyRoMRkjziS7jw6aCpB2lonPmn9lJmRXabXAx3qjMpc//Cj/MlsalEcVF3SBQbmQCFrD6/hNG+axCYkzOmrL0FfH0XiVSOSryudeNDJfe5DRVP0XEYcdmjaT59bBNm8eekQnd3THp/ZZKDq0d9EqKvPLYVWlf0ZrjYFHVfLfMfkjLB6fq7KxFNZgqbv7s3WSKbYBJkDw==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73aee1a-92c6-4bb2-1e8e-08d83cccf878
X-MS-Exchange-CrossTenant-AuthSource: BN7PR21MB1636.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 01:30:31.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhlOzWBBact3/4TRC22Ce9+Nlsp3XdbH4kELcH6znSn/UjgrAuW2ZSNxl3GjoreNaekXcel1xSgX3dl7WMzBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR21MB1652
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Make hv_setup_sched_clock inline so the reference to pv_ops works
correctly with objtool updates to detect noinstr violations.
See https://lore.kernel.org/patchwork/patch/1283635/

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 12 ++++++++++++
 arch/x86/kernel/cpu/mshyperv.c  |  7 -------
 include/asm-generic/mshyperv.h  |  1 -
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 60b944d..4f77b8f 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
+#include <asm/paravirt.h>
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -54,6 +55,17 @@ typedef int (*hyperv_fill_flush_list_func)(
 	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
 #define hv_get_raw_timer() rdtsc_ordered()
 
+/*
+ * Reference to pv_ops must be inline so objtool
+ * detection of noinstr violations can work correctly.
+ */
+static __always_inline void hv_setup_sched_clock(void *sched_clock)
+{
+#ifdef CONFIG_PARAVIRT
+	pv_ops.time.sched_clock = sched_clock;
+#endif
+}
+
 void hyperv_vector_handler(struct pt_regs *regs);
 
 static inline void hv_enable_stimer0_percpu_irq(int irq) {}
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index af94f05..3112544 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -361,13 +361,6 @@ static void __init ms_hyperv_init_platform(void)
 #endif
 }
 
-void hv_setup_sched_clock(void *sched_clock)
-{
-#ifdef CONFIG_PARAVIRT
-	pv_ops.time.sched_clock = sched_clock;
-#endif
-}
-
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 1c4fd95..c5edc5e 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -168,7 +168,6 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 void hyperv_cleanup(void);
-void hv_setup_sched_clock(void *sched_clock);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
-- 
1.8.3.1

