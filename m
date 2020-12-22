Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C4E2E0642
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Dec 2020 07:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgLVG5C (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Dec 2020 01:57:02 -0500
Received: from mail-dm6nam10on2127.outbound.protection.outlook.com ([40.107.93.127]:49057
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbgLVG5B (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Dec 2020 01:57:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDoYLp1s9TNtSkoJT1wGymi3oQRjusL57sjVKj7a9MVkCrJIqMkvO91ZE2YEsWQeYAd6mEa0nQ3+0hfwe7/0uKsu+HvQu2rID4TjuC3y/GcD9KNdZnLwL0Se3QlSRg4M+GWjKerjLP9hS1KvuP7a70dX7pWc+5Vu1kjKvJ2/ZIOnP96vA4MvHPJFRcsTB7Optw7K8WlEOtghsAna4gC5YDAa0vSmIm2Lr0xd8qdr5zg95NkKOYDgWAa8L5S/ZB8NegG0TlZnpxO4T/30SI4E9YQlnvppjQcKkqh4dQ63D7F43V+PmlTdk6LReBtavqYA9+Z5n4kyiGeRWq8aH69zmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkaWUUiBlYSNuL5XIsQ9ZIOtJzZYMoAjJguYglYgjd8=;
 b=lCzY/ejId4M3a0YDYIdj3uqD+LhAeh6wqSti9pWrSfar8LmaBHzEMERu2+nuoaQzCb1bsg2Q0HOVCy8s4un/wQbWjbzqyx/mjxEnQthaLULked12hfcMKXCdxxyK4e/ralLA6pUQf3kBQ3M428enrxdWYxdCcMyGYOqVbNEPSvLzXYF6RbcT4Yg01DUUnMMd12+VsbJo8DwzrxTZ9OyoEnlvRfBrqSuOUavWzfCQQJgkw/XPl+G+sHHS2KEUR/WgXIA7UqThNDyloFCds8UCR/SdK6KgYObszxnf37vC1e00HOVHjzBlFnZBxg2i98y9VTl1DO27mhwkxAs+4GcM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkaWUUiBlYSNuL5XIsQ9ZIOtJzZYMoAjJguYglYgjd8=;
 b=ErGUWkbkkp75dEZhDwt2TUeKdxDXpy3yVdRIe0+wHMzVXtofMH048MExxwLERRXqdfCq7lMb/i6CWTMV9+PH4aTt50OIR5VEIeJIPLv0HQvJULq5rppFCE5xwDgNMn41N6BpmPCAqucHj599GWHTQNtBqX6aWJXgBd1Ij3yFVpk=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:207:37::26) by
 BL0PR2101MB1329.namprd21.prod.outlook.com (2603:10b6:208:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.6; Tue, 22 Dec
 2020 06:56:13 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369%7]) with mapi id 15.20.3721.008; Tue, 22 Dec 2020
 06:56:13 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com, wei.liu@kernel.org, vkuznets@redhat.com,
        jwiesner@suse.com, ohering@suse.com
Cc:     linux-kernel@vger.kernel.org, sthemmin@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] x86/hyperv: Fix kexec panic/hang issues
Date:   Mon, 21 Dec 2020 22:55:41 -0800
Message-Id: <20201222065541.24312-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:0:6211:7fb4:4337:2292]
X-ClientProxiedBy: MWHPR19CA0017.namprd19.prod.outlook.com
 (2603:10b6:300:d4::27) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:0:6211:7fb4:4337:2292) by MWHPR19CA0017.namprd19.prod.outlook.com (2603:10b6:300:d4::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.30 via Frontend Transport; Tue, 22 Dec 2020 06:56:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34b64d1a-18dd-4084-8dfb-08d8a646abc5
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1329:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1329BF07FCB34E4305CC40F9BFDF9@BL0PR2101MB1329.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbU1l5PaB4qeOsnAehDOwPNMDsEZDwX5OqKxIJGY9dWD/a68+mKde4Jp9zZaiWgTOStcz8kVnZ3gIjeo7truRVWRnVy9ag0YmRpMlmcy40FElhLvvbCloOazsB2DKRcynvIRtK2cbRB5KfRdt+1GerLg2EllWuqjKUJ9NtB+N1p8B8r4m53ZNt8rfcYvVLAs8kVJlQonETwB3rNQmAmuA5l8aA7bXg3BCvzmkcaxzCmu08OtT7FlCLTsUflK7r642QqwIJ0VBDARFxyf4BZ4LJyO9mfxwnq72fh9kN0BSWBxQn07in5dF3FNgql2BcXHcBUs/Wzcsm+S7wT7hri+b0d1twNtBWafbekoJt94M9X9FmntVKem54wkWD/MW5Av0ByZFrT0xFHa2B2rOuWNlBYbDOkX8ETswPC0p2uEj/ZbaxJvK2nnLgnCgs+pelhA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(3450700001)(921005)(83380400001)(82950400001)(52116002)(82960400001)(2616005)(8676002)(107886003)(4326008)(86362001)(1076003)(186003)(16526019)(7416002)(36756003)(2906002)(7696005)(5660300002)(478600001)(66476007)(6486002)(8936002)(66556008)(6666004)(10290500003)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uv2Kh3nP62JxXolJhjbhvV+hrV6/+hBF/xBspD2e+2YrXMcaVxB2wOUeejvP?=
 =?us-ascii?Q?tE/SG/+LxrGFku1X2A19nDQf/+qL80DO5VcApl/sCTo2355j6cwbGvMptbhC?=
 =?us-ascii?Q?xxWxDQA/rqbyzw4JBYdT3LWw+a31LaWEh22nujiVwKuVSnRdFspRU+NWs232?=
 =?us-ascii?Q?4hQLjbip2pBk/v0/bMWzijZQKgRZvajqX4TDO52D8HIpfXwcg1qYJpLEgLY7?=
 =?us-ascii?Q?6dVUPsRwzv/+rPN30/J6Jl6Dcbexd3SHL/uM9nhK3NILNO1E1+WFlb4UGFNu?=
 =?us-ascii?Q?R3tMzl9TK3OWY22WhYgWNxWPXbk2ucmxMb9dn6Q4mBaSYnVgY6sJ+R8l+2Tl?=
 =?us-ascii?Q?v3b8l3mvR5Me1mfhpFzETIQ9SCaf3wMVWaF+GFuVAAwJCVSFejk6SlA1FnRE?=
 =?us-ascii?Q?J0szJF5fsuy3Ge5bBkThnoJBSM2QC+SWOBtWIpOULdkC18srX2zm5iVGvBkk?=
 =?us-ascii?Q?uw2iCgHCyOhSea8g2BK5mz1z56Zvzk/6iyKxw12Jaoron3ndnRno0pGkP9j4?=
 =?us-ascii?Q?kdxWnGhrIPjrW1baDe/RjZdFVP3M21xKVGNMwYmcpV6NppL6wha7LBvEAL1G?=
 =?us-ascii?Q?vdr112Wnt4btBP6PzhzUQSNYHR+ma6/bN6YCEWEf32Na9pvkvujvc5uSSfLx?=
 =?us-ascii?Q?GU1iXTdBTY15YymrpFp6GOVUJhfO2vMFJ8wH7FCkSq5epIxmfxi8s4NDyCTz?=
 =?us-ascii?Q?ygUR9ff2Mk9PbeJ7holwR8o4kbTBD/q+soXUCkOrTiEb5GNaKS5eaFbeY4v/?=
 =?us-ascii?Q?Vyti7HvVQyppa3l0mS/UaCH/G2x6G9180u1pMmmAcX2zf1wdoQusDyTu/ecN?=
 =?us-ascii?Q?++pHIbL6hrSFXUKTeMJz4xBUDecmBp3o3VagjbMoREsN4H7o6OFScBiLh9MO?=
 =?us-ascii?Q?uK/IYtGqguYv4PEHaRANI8sk0UikkOfBBfJQQVx3BJ6nvvAjjgx3x+h9DqMd?=
 =?us-ascii?Q?OJboA1e8xPY7W+d7AZ4rioEObdM8zLRxFXKPoEFqVyPf77pg+gBXv4IY1AZ1?=
 =?us-ascii?Q?Qrv/CyZCsTfSuZAg29pgP00VQRWwUL9JC5jINg5/lBD8tAw=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 06:56:13.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b64d1a-18dd-4084-8dfb-08d8a646abc5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFfUL008xodQSpUyK1LdcxDhiI35HKdVtgG9Ir7vwvru58vGyKhS3t7VpNbzweplvrDSFvduVcsWSokl8X7ZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1329
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently the kexec kernel can panic or hang due to 2 causes:

1) hv_cpu_die() is not called upon kexec, so the hypervisor corrupts the
old VP Assist Pages when the kexec kernel runs. The same issue is fixed
for hibernation in commit 421f090c819d ("x86/hyperv: Suspend/resume the
VP assist page for hibernation"). Now fix it for kexec.

2) hyperv_cleanup() is called too early. In the kexec path, the other CPUs
are stopped in hv_machine_shutdown() -> native_machine_shutdown(), so
between hv_kexec_handler() and native_machine_shutdown(), the other CPUs
can still try to access the hypercall page and cause panic. The workaround
"hv_hypercall_pg = NULL;" in hyperv_cleanup() is unreliabe. Move
hyperv_cleanup() to a better place.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
	Improved the commit log as Michael Kelley suggested.
	No change to v1 otherwise.

 arch/x86/hyperv/hv_init.c       |  4 ++++
 arch/x86/include/asm/mshyperv.h |  2 ++
 arch/x86/kernel/cpu/mshyperv.c  | 18 ++++++++++++++++++
 drivers/hv/vmbus_drv.c          |  2 --
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e04d90af4c27..4638a52d8eae 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -16,6 +16,7 @@
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 #include <asm/idtentry.h>
+#include <linux/kexec.h>
 #include <linux/version.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
@@ -26,6 +27,8 @@
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 
+int hyperv_init_cpuhp;
+
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
@@ -401,6 +404,7 @@ void __init hyperv_init(void)
 
 	register_syscore_ops(&hv_syscore_ops);
 
+	hyperv_init_cpuhp = cpuhp;
 	return;
 
 remove_cpuhp_state:
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ffc289992d1b..30f76b966857 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -74,6 +74,8 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
 
 
 #if IS_ENABLED(CONFIG_HYPERV)
+extern int hyperv_init_cpuhp;
+
 extern void *hv_hypercall_pg;
 extern void  __percpu  **hyperv_pcpu_input_arg;
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f628e3dc150f..43b54bef5448 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -135,14 +135,32 @@ static void hv_machine_shutdown(void)
 {
 	if (kexec_in_progress && hv_kexec_handler)
 		hv_kexec_handler();
+
+	/*
+	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
+	 * corrupts the old VP Assist Pages and can crash the kexec kernel.
+	 */
+	if (kexec_in_progress && hyperv_init_cpuhp > 0)
+		cpuhp_remove_state(hyperv_init_cpuhp);
+
+	/* The function calls stop_other_cpus(). */
 	native_machine_shutdown();
+
+	/* Disable the hypercall page when there is only 1 active CPU. */
+	if (kexec_in_progress)
+		hyperv_cleanup();
 }
 
 static void hv_machine_crash_shutdown(struct pt_regs *regs)
 {
 	if (hv_crash_handler)
 		hv_crash_handler(regs);
+
+	/* The function calls crash_smp_send_stop(). */
 	native_machine_crash_shutdown(regs);
+
+	/* Disable the hypercall page when there is only 1 active CPU. */
+	hyperv_cleanup();
 }
 #endif /* CONFIG_KEXEC_CORE */
 #endif /* CONFIG_HYPERV */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 502f8cd95f6d..d491fdcee61f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2550,7 +2550,6 @@ static void hv_kexec_handler(void)
 	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
 	mb();
 	cpuhp_remove_state(hyperv_cpuhp_online);
-	hyperv_cleanup();
 };
 
 static void hv_crash_handler(struct pt_regs *regs)
@@ -2566,7 +2565,6 @@ static void hv_crash_handler(struct pt_regs *regs)
 	cpu = smp_processor_id();
 	hv_stimer_cleanup(cpu);
 	hv_synic_disable_regs(cpu);
-	hyperv_cleanup();
 };
 
 static int hv_synic_suspend(void)
-- 
2.19.1

