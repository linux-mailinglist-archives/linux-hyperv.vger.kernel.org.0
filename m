Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD39075D9DB
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Jul 2023 06:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGVExc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 22 Jul 2023 00:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGVExR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 22 Jul 2023 00:53:17 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021014.outbound.protection.outlook.com [52.101.57.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CE94681;
        Fri, 21 Jul 2023 21:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo9lthHa9LaSHq5rLKL35h3do0qZGg7wM7CRSWLrfht42KIizNnic7/MWPbznwwnHDzBwNgDvSR06pqxRRxAL/GRmDbZKaDpODGCVEkhX1Ch5jPw32SWqYMlIr36huqcxyYE63A4hB/6KuaaeHr7pIbDxWLl7qLkwdbNIQ5M1HoaT1duYVlR1QorRjjV/AtNGj4261skkn2DCRxV1ivCz9xUXU6SoPuK/n2PjUj9j7WTpe6LVeqw7+xoxf5gWLc7jpkeRYlFP8uQ//efjg4LxtnyfOr58GSHq126LCiwDjrb1u7wnWQwnqch21g8SkWcfknws0cFPXtLKhpYNnAA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCKTySSFMZnk9HDozdvtLUHwrBvy/tfwM/1wBsXPV74=;
 b=BdCEfRQHqjgQ5oQh19Z3IljfsC5TZpeD5betzWYNk2rEl0Rz5Y23C4ci8MD7BbvNxFEo86RjYRMSoNf2+/LLpJ+fd1ZjqQS2SKrJx7WLR8D3SpJB+oomWby7Pl9tI919xbE7dU3CbCZpPU/uYvLh1TK9GTNnQZstOkhVuvgLUrnQt51lpoA5n+W3/2ik9drKgAw8HLiHBo/gwf3sccfPt3qI1pvQNtHRDoAgjFfc4LKH85DtZDf3J2JK9Glv6ACHG/xGAl2pdrdPho1/F7teLjKHc4DQcpNAkXPZCG+vxr7RzIUW8Xs6PTb1IMQ261eyO+QlTuK1ptgWaocOM10nSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCKTySSFMZnk9HDozdvtLUHwrBvy/tfwM/1wBsXPV74=;
 b=ZrWaum5iebJM7tUm6Ue2wtZmT4s7Rm2VScuykOHozn6IuCMVOkwO+6IK09LIurFmBVZAihtMh2BFnZu1LxqvhuPHX5DD8EB9oey62PKsGRLdHPYwwvwrGNva8+1ABOkZB3Yr5S1DnNqN+OFxTAGQXagdpndXe6UTcH4+BlbD9iA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM4PR21MB3416.namprd21.prod.outlook.com (2603:10b6:8:b3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.16; Sat, 22 Jul 2023 04:51:41 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::58ed:9fb:47a9:13df]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::58ed:9fb:47a9:13df%7]) with mapi id 15.20.6631.014; Sat, 22 Jul 2023
 04:51:40 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, stable@vger.kernel.org
Subject: [PATCH v2 1/1] x86/hyperv: Disable IBT when hypercall page lacks ENDBR instruction
Date:   Fri, 21 Jul 2023 21:51:16 -0700
Message-Id: <1690001476-98594-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|DM4PR21MB3416:EE_
X-MS-Office365-Filtering-Correlation-Id: 5070e73b-f46a-4c03-b1e1-08db8a6f568b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhZ3FXgE0lEaw3msm4DhqcnUBA/mq67iQfxSqEpcoZGf9+CvOZtU4f1YxvajiSNg/EUVL9CGPOBIfJQTpglJxXsxiAJ4xEerI4ZHbN4DS52w4pl612T9VR/ycXpYD+bkcwuDwhXyHB6QBxbPgAcomz03Q5I+zXzC+wEIQe0BtSXRemrN+M8acxR7raCGuq1GggRnSk9+zbHw+gQEhSTwGZJa6lwesy/A0lA/B7g+Nt7dWS+P4qPBBVbrlUjOMzwtnynRT8Q5oaZJRZo5yBvrn8nqjQmE7ulTV64QVQ82+oDIXm/nq80DBSKvmSB/XKzJnFfF5JtFw18emc6KEaBstVPqQQJxNGsfW+VIiu/tcg/SokMw5OMEsGgsSao3+SF1rW3/i9CN76cKEuNEiPwcD7iF9kSArQHJIapPEHD8sD5yZHN7F9d94VI92T35uVC3xI1Yl8qYagUjdPdtnSxaOngOmjvFSJ6ujBxlBNjIKTpRz0DyML+s/1IRvbVMHtoOysVY2mlNasN7P9yX/t+6k47FCNKaZiHZEXBuPG1T03BJe0habm4A/01Mkq6X5SngroXWywl7YIz2iwqX8axQskmQEAiivL/gD9FGEQpMyzV+aHX4EWiJ4kyoPpGjrEhiqirc6aoYOYLUVS4sROS/p8h/0+jetxGEjKDL3mJSjW2Tv0zEV2S7p/rjps8ozcWo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(66556008)(66946007)(4326008)(66476007)(7416002)(5660300002)(41300700001)(2906002)(316002)(6486002)(52116002)(2616005)(6506007)(8676002)(8936002)(186003)(26005)(82950400001)(82960400001)(38100700002)(38350700002)(921005)(86362001)(6512007)(10290500003)(478600001)(6666004)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbZWIdROjWxoC94r86d+Gic2yPAS0W3VE0jaHSm8fkfq9pp5gHeLeqGqg/Ad?=
 =?us-ascii?Q?hz5l7rxFPXGPfCb0igKn5xvQlxcLbLOYssx9LrpfVd4qPcONVbf573lX6tZX?=
 =?us-ascii?Q?peOAfX6QLCWQs4R7ktrCRJH/9glPWhPrUEVNn7HNBr/sbpe2An5yrgEFZPpa?=
 =?us-ascii?Q?q5MeXm5tTHMfc1ZPphOYzZzxtkTpkKu+CEax/Tj4/l1bcY2BhdQyVkIZknv9?=
 =?us-ascii?Q?JI7mxuOuuHBoBKFYM3f7kcp+Rp8dxIZEhAgTKEfp5JojfXBMkMiFTURH5CvS?=
 =?us-ascii?Q?pTKMUvn0fsFGm2T/WCXKOAxmOQEOxlP57+yMY0+pHn8bVkUawWYSl+yqeeTo?=
 =?us-ascii?Q?Xx0GDHgWIfUz8hHuC0LjhwSeAHxE9N8pRX7l/vJpHG/AEyRQlNEcrR+MRQ+J?=
 =?us-ascii?Q?jPYPZ7kBYN0wVWI+TakiRvZwnj0BUdD5pwPqBfO5hVnmzJtQUr/p5qGfnCXY?=
 =?us-ascii?Q?EnimBmzBTNuWZKhHEePyqibpaTMt5j8HioU4PF1rbNWZL9ubNpaBeBW8wOd8?=
 =?us-ascii?Q?K91b031FpqKRFsWauXYSZlKJXEbNoOu8tMTx90tXXYG0AkGkeY9cSpGmlA4/?=
 =?us-ascii?Q?U70A8mDNxyiNMkCG1uTKyqBzdMeOGrgh/1CtKGYZxLIiAG38XH8G6UQk4q7s?=
 =?us-ascii?Q?7udu+dJCVrRYgefV8pGejXzG58dhA7XvfsQrxrg8Z5W1+yEd71i5WkdVEaoS?=
 =?us-ascii?Q?KUT5IzwJoWUaXQuwGkFWx38VjYceWryAQFNBHD2bzMee/1HJ2Y07TU/Y32Ti?=
 =?us-ascii?Q?JjKyjxg3pbs2pQq8MzU7jR79dJvjsYk4T9Rid1ZSUzkW3hCiF5aN+GbIB96S?=
 =?us-ascii?Q?3wSSU6ERRWlwHW7l20WKD/wwl0+BSgbkzzFTTnEslZEev85w0OGLZnUAGPLx?=
 =?us-ascii?Q?KgSZQZOdkEetAB8BmpiK4mOHZolqGNGUgjFYIw6Ps60YoEKV5VJk7DJSW8Fd?=
 =?us-ascii?Q?hkxpAHaZOQ5MxT5e+Cr2tuGqGDgF6vYfzVrHdF/h+rNMu+vT3L+8omML9YAp?=
 =?us-ascii?Q?AmLQzTiqNYa88WZxD1/mLQN2247CJHJaPfUy8xam27EzmLC85de8OcEdFlK7?=
 =?us-ascii?Q?/d095QyFD8KQRPzaYoOOHPunLTTamY2SW2XkgOGKWeiw98wYjKJKEshSLA69?=
 =?us-ascii?Q?Dwg49/aChK/g/LC+2gNvGGghqk+v9BD4UYZWVvWsuuhSo+kbYhRRE6H/bRcX?=
 =?us-ascii?Q?/Dx27VQgQMIFkx+ZOjthrRdg9E7VVVpNQNHBvYBZ2ouYIPEWv7Mg8U0xt61w?=
 =?us-ascii?Q?VuQGO7F2SLl6YNtod5ZLHIHqpMsJ3Ad8ZjS35GEIt3LaSf3Ugp8ho+GmoOjV?=
 =?us-ascii?Q?lsq61S7HEV2lYc7D/gPAyOU4xAAXNpEoPIO21lQcLjia8jrw9EgRJOha2pyS?=
 =?us-ascii?Q?J9xJ4voi2/NZx9kmL0pDg+Cj8BiDXuBQ3JtdimAYbScFudTsjZHjTwCmxMsR?=
 =?us-ascii?Q?uUTTwkJXMIQnGvluYYEvJurOtLFCnpYuvSJUi9e5ChsJKK8d38g3cGBwj/FB?=
 =?us-ascii?Q?ztSGdwqRpbe8gRbqDkkV+0b1t+IRq/rbjQt7XmZdZO0IhqWmZmYDmEU2kAOV?=
 =?us-ascii?Q?mSRyDjAZLpmzckayTE+QvVGnf70W8e4YyeV9rhN8?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5070e73b-f46a-4c03-b1e1-08db8a6f568b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 04:51:40.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGQ8Loj0foU59Ol2ERTxvhNjuha/NJuV6nClBtx9tWcgDjDh5YC2ykt+2JNoDaAqS1OVls88aXe9beY/n7PxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3416
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

Changes in v2:
* Use pr_warn() instead of pr_info() [Peter Zijlstra]

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
+		pr_warn("Hyper-V: Disabling IBT because of Hyper-V bug\n");
+	}
+#endif
+
+	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
 	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
 	 * apic_bsp_setup() -> setup_local_APIC(). The direct-mode STIMER
-- 
1.8.3.1

