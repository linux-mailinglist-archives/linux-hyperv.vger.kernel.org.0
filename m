Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62492DF705
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Dec 2020 23:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgLTWbS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 20 Dec 2020 17:31:18 -0500
Received: from mail-bn8nam12on2139.outbound.protection.outlook.com ([40.107.237.139]:15488
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbgLTWbR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 20 Dec 2020 17:31:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHrWUDp5m4Z1i49t1Xk2esblvzTCySaRn5v8YMRnQvxpUJye4RKqfCdP8arFnDMxYJO1Aa0K7z90x0WQtmmqOECalrzogILov41zRG6bVStRXkW9kRFxkleVMkHIwl0h3KRK/FdRaJDVSL6q0ax4QvklPMK98eNub+4ywI4iXzCaYxhFqpDU6FP8O4W43iiYsDL95UTHBSQU8S6KuniCU9jutJ+33XIusAHFT7/0twNcGu0fKEIX3SVhSQHHlWu5roMANcORVS52D1v76U46ByKRTF7xtYM/tVuQOD2S+1Qqw5ex6f/oPR7mRKv1l7+Ct9DCJd4Ea8xTRMFb7QjJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XgjGFjPgVcZ+77gfOfoMGuQq5/Lv7KqPYXbej+4X1Q=;
 b=dezMjUrN5co/ygO5HUPzzejUnoDC0n279ylILQLZRXvh/hPAIjcuDGfV8D8qrlCQyRiHwFnNn7InPCcBxTz3zCe2g4QWOJt6npNchWNZ7c75ZxFcUOXL7uMBah4bFpNi19y2Fbt3e/arXBpIBxzfsebaS8XR53ucUkFL8FG1DN4AGB4ioqPa7X6/y2Qdz3Fxo1cLT/y6jvtNT67xiO/NKm0DKI0wLS+VglMKZQnDBrs8JjBx2elSe3TdbQJYuAv9L7bcYRkthpD2Kxy6SmVgxdvXmqeiI0CoblnyKtXjTsEOutPcDn7A7AjBdUqPXrEPHmQdj0+c4S3tGMI4HX9Npw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XgjGFjPgVcZ+77gfOfoMGuQq5/Lv7KqPYXbej+4X1Q=;
 b=SlpGI4/+mE/CWmsILOJMTJ5nIxkJANImXLhM+eNgiYijwWEWVe4Sgv7ZAmWA/+K9/EpHcxdz4M4FeMpyXni3DIkFYJZUq+9sYpWDgSZy3Yi9GakEXsmbjv/iEtinLaWdshkaEIVS8hhbCtKcej7C7m6Flg3gfTV0oQ541AvkCU0=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:207:37::26) by
 BL0PR2101MB1060.namprd21.prod.outlook.com (2603:10b6:207:37::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.4; Sun, 20 Dec
 2020 22:30:29 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369%7]) with mapi id 15.20.3721.008; Sun, 20 Dec 2020
 22:30:29 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com, wei.liu@kernel.org, vkuznets@redhat.com,
        jwiesner@suse.com, ohering@suse.com
Cc:     linux-kernel@vger.kernel.org, sthemmin@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] x86/hyperv: Fix kexec panic/hang issues
Date:   Sun, 20 Dec 2020 14:30:14 -0800
Message-Id: <20201220223014.14602-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:1:a99c:1934:b3c2:d37e]
X-ClientProxiedBy: CO2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:102:2::24) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:1:a99c:1934:b3c2:d37e) by CO2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:102:2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.13 via Frontend Transport; Sun, 20 Dec 2020 22:30:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01c4f155-fef5-497b-394c-08d8a536dad0
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1060:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR2101MB106019A022590AB585CDEFEABFC19@BL0PR2101MB1060.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9A1SPHdGD0ReIqBZTK1qkMKy7azvcT85/vKm44C835JOSQg2xF4Od/7AooevtPQgFfGLfTE7npyPG9QHHlGEYg9pz5ggmUxyZihQtfFflMgdVYfSAjsL37xFfrDIw0FI4ujhObeFEYu9M/L6gv4TWg2E53WScN/HIkTMJW99KZ/yZz5wURfuVGSk4D6CfCZ3vRwib4AZXEQ55HFh59ZhLixFndE6x2rfCDquZQmXAo6izMYN5Ox3IOFR9p2neuEexwIZAWut0VHeX453W+zOW0+zR6VDisob5xKqF22mkhBgs+jEW885tbcdYCB/6tYUNt+ndmWSX4Diyfy+aqGf07vsTtJwytWoANHHl35e07zJRDUeRwaPOMJL9W2IZ6Q5bx8zjTX5GyxO2PVWPxIss6Pp3pZKxBRDGh57kHsbDTZzANktcxVNvde3t1HVjSM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(478600001)(316002)(66476007)(66556008)(186003)(36756003)(8936002)(10290500003)(83380400001)(16526019)(7696005)(107886003)(6486002)(7416002)(66946007)(8676002)(6666004)(82960400001)(2616005)(1076003)(2906002)(86362001)(52116002)(5660300002)(4326008)(921005)(82950400001)(3450700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?91Rq7G1nvUgqbHpCB0W7il355I6G78ADTjUhHqMTgPkFWEuOhr9yhEVbVxgu?=
 =?us-ascii?Q?aujW+c9q7mVowwVPrINuL8i8+KaA9Kp90aVmAm/QcK/QvY17WEHJBVRBeOnT?=
 =?us-ascii?Q?sQJ27NINxLVoJkNcyKIqYOXGIx4bSnWgVW8TgtcsdCCqrrCQrNH+kWw7vrDW?=
 =?us-ascii?Q?mSJY+M8n+BJ84ScA0PovBk3EGtbfITPULr0OPhV+TXoqiS+M1CaLpysazZ4v?=
 =?us-ascii?Q?BvpgM/Tr4yDAcIsuoERQeBtI72rN3MqcUfCdcomObUjptSw5VZJVXKjHEWSb?=
 =?us-ascii?Q?hAitZOQKVg/Lz13nCLT8PRUttpIJ6GuN+Yesv49JWwv/Zr+YYaKZJjOghCcm?=
 =?us-ascii?Q?aPM7MQ110SL3aHRWFqHLfu21Q+nBzgYcRsGSVF/0MD9VPS/aYnQn74EdMmuN?=
 =?us-ascii?Q?7hhf6MFC8JO/I47YHfuUkREj7up4xHIAW1iA+LKkVFWXD0fcQF69/mJPijYR?=
 =?us-ascii?Q?AE09KnRGXlgOkfj6kvUkRxKQDsCHXtfULsv05LX0ZWg7S2IiiowKXdQONgQa?=
 =?us-ascii?Q?qPSQ1lGYG2PtwQ9tgX61IKbRHfcr/w1QyFkRfGtS6wq64ae4gv9iAygEpLib?=
 =?us-ascii?Q?3X9jnkKz4P4tFm3jREzVtmO1idkTnJJm4uKygj2p73qSJ7mLx07EK5V/CEw2?=
 =?us-ascii?Q?HJFGGVeDwZg+LWt/7V3EAsbOHi1xplgan6akxzKisFTqYry2s3Jv19KsMbmL?=
 =?us-ascii?Q?C68HPv0VKaw4rverYEbWZrZfxcowyXOX8gHsQHOFUV+mcNIEFoqcTkWarKYZ?=
 =?us-ascii?Q?P4kzydRMLE4bgOzPPeoYyigDTbzhpqsEBknreoMFq3vbt3GfW2xDyqzpmzK5?=
 =?us-ascii?Q?XmHC5Dv3gs7D/cqHrsaXVcXq1z2Qpyj76cM54TSeVvSZF2xTldWzYaELd4Lp?=
 =?us-ascii?Q?6TblcvxcAeWJUc1aAXeo1e3fKxS28A6Gfj7cLzbOO2+2p0AK9V2bCKcfs1ub?=
 =?us-ascii?Q?qe+XKCWvEf/qBjzjQjyLXuy32YHh0jFWd3Xdzhlz2ue9y6W3sbnVb96+pOv4?=
 =?us-ascii?Q?I1JhWsGl1g9s6SiwmilexBcycNV7HEY+Jube/T9ZdiZfxcI=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2020 22:30:28.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c4f155-fef5-497b-394c-08d8a536dad0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eyhy0+s1f7N17dg6jXN4VeYd8rhqC8SuI521gpcH+O0hc02e5tyKP5dET4AFSedoxXNB2msNDjdXJa56w+k2RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1060
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently the kexec kernel can panic or hang due to 2 causes:

1) hv_cpu_die() is not called upon kexec, so the hypervisor corrupts the
VP Assist Pages when the kexec kernel runs. We ever fixed the same issue
for hibernation in
commit 421f090c819d ("x86/hyperv: Suspend/resume the VP assist page for hibernation")
and now let's fix it for kexec.

2) hyperv_cleanup() is called too early. In the kexec path, the other CPUs
are stopped in hv_machine_shutdown() -> native_machine_shutdown(), so
between hv_kexec_handler() and native_machine_shutdown(), the other CPUs
can still try to access the hypercall page and cause panic. The workaround
"hv_hypercall_pg = NULL;" in hyperv_cleanup() can't work reliably.
Move hyperv_cleanup() to the right place.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
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

