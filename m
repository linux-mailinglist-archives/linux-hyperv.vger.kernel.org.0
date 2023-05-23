Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A9370E3B3
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 May 2023 19:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbjEWRbw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 May 2023 13:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbjEWRbr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 May 2023 13:31:47 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A5510D9;
        Tue, 23 May 2023 10:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFTEK1ppAPF4g4F6qc7LbuuCDYnwhNExj1KzhG2/xzoXMpYM/RRm819Rre0yE9GbhZ+UanMwkENDanfQ0o8jSbZMprOfiJdTPRGkBEK/16jgYsheGLxLei2XVt7huZsynzv9CMdiEnFSaxzDzluzjVQJUZg+3ort8xLjDweKKoYgMEvlReEpgsOKDUsqIbLthmQBlZt/4f1r4ADyD/4BnP/Gg8GZM+v0q+HfaaqwAnGt2YXckcmAVbxsTDJ9aWWs3Iy2oBK5BuSG5TTVvspcdQUGEg2OezjP6W185VitgduNyub2wpCFYjH0pW37c34+tO6hXcbGbphoQyZAlaHddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWkCBjMumEVdnOiFUDuUb7Y96m9hR7cTb6hMrFPOr3E=;
 b=aHBXwy+xDkDsWgXPPy1iWYOE3mmrddK0VQVfWlXlKI4P7SYhxx8rvH+Weh7Xe+cQdcQcawnzyRXwWbSuXDgK/AOXrRyP1J2m0lGK6OUlvC7wQjEme9faoeDtO2RmFrSmSjBQugQvBZ8MFS9CMYAcPWfeegAUCaxV3JnAlb2aHzGjgIxaQNhlQnc3PjTr4EeatScKjEg8DhU5AKJRBkKFr/I7hcufspuNNYZk63bhFBhazT9CzFWWm1DcNb3NH6NwidMYP3JIviIHpuHThk3AMcjnF1FQDgg/QprntqUWDXre7VE+zJ1mDq1+d06gMDNdPTMgNOQvB0dxSE56JOKkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWkCBjMumEVdnOiFUDuUb7Y96m9hR7cTb6hMrFPOr3E=;
 b=iMkbuy1PVhs5sR2KE03fhDdBXXFGgKHXhgBYpnGWAUTUAhwM7hcnjNT+x5qYMu2D+YiFcggioemXAIVOyK8oDLgYZgDSxnrVq4+k3aNlXhiD0qrueJmT4AyG/Y2UiYuQVPNIOKqa8PbM116jc9zsNrUTk/hkb4uSgTVEwGOTo/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SA3PR21MB3866.namprd21.prod.outlook.com (2603:10b6:806:2fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.6; Tue, 23 May
 2023 17:14:59 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%6]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 17:14:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline
Date:   Tue, 23 May 2023 10:14:21 -0700
Message-Id: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:930:d1::7) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|SA3PR21MB3866:EE_
X-MS-Office365-Filtering-Correlation-Id: 822a898c-5334-4b58-85a3-08db5bb13d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxX5MV5mWgOqWIf/0YUmcuUUrJ8dYI/3+ZkyOKOXcGUG/D1KruFGl94lwjNP7K0fH2rHVkXFeI91eOCimSP759ak9HoBetVqNHIpqDyRbSqeevDFmRvquW6e0WOM/X1/LzFQiTV76m69yrSxJsjFsALnBQy96zosTuIGXetaPNCQ+AdaUSvpdFNflJ8/jI1e+Rn0pj/5K3kc1G5yktKBRztkxMVmsu2L/EOGg91zfbImUkLoOKHGMaUez2dkokwdcWs7heaDoEBx+SdgNA4zhsRujV6bAFwoG8Ixj+YTSbhMKyK+tDxPBL2LcBqRXY0iv7fP9YL6dMj311Yjy0iwD1hNg5JdnoOE6YLcAnu1uKfaZt0ABHyjEFL+onADAfyHFMin1rpM0Mtp043yJUWygLPDmhicIvlKzzHgsJkib0kzhTxDyRGjO8jz2/1kj7SDwdV9IXLtD9YRyqxEsdoZ7qf4nvouUXPhWsIV7DC8dMI+EInIFm58rr4jNdyOeworDzjXpS0RSnTSCFHLEDh8bFMIYCQqP1u7lDiZI0jRBmcm2Cv0TW7DbSZOKGytJ0h6tDbyuvS8L1psS1LZsHKWN0Kr5XOKb2R+qkdF7DqxgpQgxZjKFWDr6DbQprFgGaCgO+47DC3t0JNdTvPKYTeQSUdjYu5lu3kIrnvUF6GBzSY9sbs/LkUGZqxcZ4NdKJKz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(6486002)(6666004)(66946007)(8936002)(786003)(52116002)(316002)(41300700001)(8676002)(10290500003)(107886003)(478600001)(7416002)(4326008)(66556008)(66476007)(2906002)(186003)(6506007)(6512007)(26005)(82950400001)(2616005)(83380400001)(82960400001)(36756003)(86362001)(38350700002)(921005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WAErviylwowS1miCbzfZdElFWB2GTy1nC1cUZviSSBkZaJEt3QH2eSrxxlT9?=
 =?us-ascii?Q?UL0pSM+mHm/1ZpoIAc+HfjbBHLDMvgM/LXyHQyVK+f99WJ2IRTo6wNUJqnYn?=
 =?us-ascii?Q?oNQHhAKGSTXnVr5jb5v/3zuLTZsIpyz2wXv5y3EctLUkMMnxcyYU2O5naZ7W?=
 =?us-ascii?Q?N5f4xP4VtC0D/HPsVkPI1QT+kbS4z6ADPXysqYlLpA7CZlczTFpPJf748fH5?=
 =?us-ascii?Q?EQjCyqoZvJjUIvnrDqdGZvEHio0S1LZa2ndPUPJ06vd9ajaBm317DikHp5He?=
 =?us-ascii?Q?s7TOrm0mCyLiy/MrmhYYSbbtQ1Vts9MG+dmK6KxwHPfV1okJznWu4Tn7blR2?=
 =?us-ascii?Q?9mAv3yzjOCKPFxSWN6+LaTcR/9YYLvRyowcmwiQzcfUSbKevn2kiDruaXgwl?=
 =?us-ascii?Q?i4CvbED/iu2URdZ0urhz9J0gpfD6pfUZUCx2hZUm6eXoZA8Uy2yXcinTaP5N?=
 =?us-ascii?Q?QkcVwOumKJjDd0Q4C7SkNkfoNBeUY4070BzaScfcRW16H1OqkJQq4ldv0jDH?=
 =?us-ascii?Q?71LVRML+TuMp8pQlyHJVR+QSHYLJLTWLDZqFwHV2SZ19C9e5sljlqGkGlgZi?=
 =?us-ascii?Q?UnGMwf945UBRd3xO1u3OQln2Orv60AZU3Y/xmduNYnDVi26sEl36Q2qmudBU?=
 =?us-ascii?Q?Df3Yd+wNPkZcKVaudzrX0fyHzpz3AX0OAX2hyhlTQH1llfcIuRdVy3wxk29t?=
 =?us-ascii?Q?pkVN/8D2AOdM7fOYwnvuPg1p2Kz7e6snqkWd4oIJgwjASU5DgvmlFLrUcHYE?=
 =?us-ascii?Q?YObUfOVfwfiCwzWyL+H8xsGU41JOtOSOjzUH+kvR35ChieC51nzm7dZClV4f?=
 =?us-ascii?Q?lMwYXa64PlhlK+xCVfmrg6xZxNsJvFS3b+IB+L0Pi6b5JxcPC+hvN4Wi/XNm?=
 =?us-ascii?Q?IxlmkonLZ9KAzqi2THkkKGPt1SyF8TXO70/UEbB/4rMFsmiixCczBCljztW0?=
 =?us-ascii?Q?/hBpdB+2nJFxkJ2HKHiGXzdwlnBO5OhOlpDcO/w4+2Q5fDilZOvpY0qeIoOR?=
 =?us-ascii?Q?fPNNVboInQnxE+13+ErWbZd6g522bDrNt2w/TKHSGiojRu8AwsAp0+m9zj8m?=
 =?us-ascii?Q?AHXf2pYxBj3d97cfqHWOOM7W6U2nbSZ8FmLVf/xVyPAVplDqDXuaBPqxNgV9?=
 =?us-ascii?Q?TtuOB+mKFduF2PbY6WtQttvbiPlIDC1AZdgrQjF6KYR6iC0JjuaWj91gR75X?=
 =?us-ascii?Q?6wZuYCEPU0xU9yKHIm4VkNmBisZKmZxEIXlRmi+d0WlTZreLaNyKMm5ayopY?=
 =?us-ascii?Q?W0ndfoFpyY6naSRyVyEvvbnPgUe9mPp8VDDJHtgzGZBWKQCbLV8f8RD888j6?=
 =?us-ascii?Q?xTQNP+3UivoL6xeg55BIzbXFEIvHTJvkpXwncJhk7evwM3cfbbbGgssCbFq7?=
 =?us-ascii?Q?2VHyXepgrvLiweCPfRs2faad9XcDZMEArgH+MkwJHV/ubTxDZWLHD3prO5Gb?=
 =?us-ascii?Q?ydff7NuIz0c/glTMEenI7PFrg5SIIPUTMt/fHSNDG2oauGvoPO2234g17vEx?=
 =?us-ascii?Q?OQUVVfGSTHkDrt+ZA3L2q8NBF7x+/789OgcWROwrFg5ZXrO2Z6zfADRJWPPY?=
 =?us-ascii?Q?Nnt8ENq7ZJbgAQm5g+Y3qC/SU3iMNmA3yl9zvMa2?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822a898c-5334-4b58-85a3-08db5bb13d07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:14:59.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW2PJaBegIgR9tAGkeTO6J4kbsOa8qB10biWnzNxnqv1OI0cQGloi1RtZclMxBRX9ooP+HXUYGkyDDbDUyRqcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3866
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

These commits

a494aef23dfc ("PCI: hv: Replace retarget_msi_interrupt_params with hyperv_pcpu_input_arg")
2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in Confidential VMs")

update the Hyper-V virtual PCI driver to use the hyperv_pcpu_input_arg
because that memory will be correctly marked as decrypted or encrypted
for all VM types (CoCo or normal). But problems ensue when CPUs in the
VM go online or offline after virtual PCI devices have been configured.

When a CPU is brought online, the hyperv_pcpu_input_arg for that CPU is
initialized by hv_cpu_init() running under state CPUHP_AP_ONLINE_DYN.
But this state occurs after state CPUHP_AP_IRQ_AFFINITY_ONLINE, which
may call the virtual PCI driver and fault trying to use the as yet
uninitialized hyperv_pcpu_input_arg. A similar problem occurs in a CoCo
VM if the MMIO read and write hypercalls are used from state
CPUHP_AP_IRQ_AFFINITY_ONLINE.

When a CPU is taken offline, IRQs may be reassigned in state
CPUHP_TEARDOWN_CPU. Again, the virtual PCI driver may fault trying to
use the hyperv_pcpu_input_arg that has already been freed by a
higher state.

Fix the onlining problem by adding state CPUHP_AP_HYPERV_ONLINE
immediately after CPUHP_AP_ONLINE_IDLE (similar to CPUHP_AP_KVM_ONLINE)
and before CPUHP_AP_IRQ_AFFINITY_ONLINE. Use this new state for
Hyper-V initialization so that hyperv_pcpu_input_arg is allocated
early enough.

Fix the offlining problem by not freeing hyperv_pcpu_input_arg when
a CPU goes offline. Retain the allocated memory, and reuse it if
the CPU comes back online later.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---

Changes in v2:
* Put CPUHP_AP_HYPERV_ONLINE before CPUHP_AP_KVM_ONLINE [Vitaly
  Kuznetsov]

 arch/x86/hyperv/hv_init.c  |  2 +-
 drivers/hv/hv_common.c     | 48 +++++++++++++++++++++++-----------------------
 include/linux/cpuhotplug.h |  1 +
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a5f9474..6c04b52 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -416,7 +416,7 @@ void __init hyperv_init(void)
 			goto free_vp_assist_page;
 	}
 
-	cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
+	cpuhp = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "x86/hyperv_init:online",
 				  hv_cpu_init, hv_cpu_die);
 	if (cpuhp < 0)
 		goto free_ghcb_page;
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 64f9cec..542a1d5 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -364,13 +364,20 @@ int hv_common_cpu_init(unsigned int cpu)
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
 
 	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
-	if (!(*inputarg))
-		return -ENOMEM;
 
-	if (hv_root_partition) {
-		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+	/*
+	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
+	 * allocated if this CPU was previously online and then taken offline
+	 */
+	if (!*inputarg) {
+		*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
+		if (!(*inputarg))
+			return -ENOMEM;
+
+		if (hv_root_partition) {
+			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+		}
 	}
 
 	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
@@ -385,24 +392,17 @@ int hv_common_cpu_init(unsigned int cpu)
 
 int hv_common_cpu_die(unsigned int cpu)
 {
-	unsigned long flags;
-	void **inputarg, **outputarg;
-	void *mem;
-
-	local_irq_save(flags);
-
-	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	mem = *inputarg;
-	*inputarg = NULL;
-
-	if (hv_root_partition) {
-		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-		*outputarg = NULL;
-	}
-
-	local_irq_restore(flags);
-
-	kfree(mem);
+	/*
+	 * The hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory
+	 * is not freed when the CPU goes offline as the hyperv_pcpu_input_arg
+	 * may be used by the Hyper-V vPCI driver in reassigning interrupts
+	 * as part of the offlining process.  The interrupt reassignment
+	 * happens *after* the CPUHP_AP_HYPERV_ONLINE state has run and
+	 * called this function.
+	 *
+	 * If a previously offlined CPU is brought back online again, the
+	 * originally allocated memory is reused in hv_common_cpu_init().
+	 */
 
 	return 0;
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0f1001d..3ceb9df 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -200,6 +200,7 @@ enum cpuhp_state {
 
 	/* Online section invoked on the hotplugged CPU from the hotplug thread */
 	CPUHP_AP_ONLINE_IDLE,
+	CPUHP_AP_HYPERV_ONLINE,
 	CPUHP_AP_KVM_ONLINE,
 	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
-- 
1.8.3.1

