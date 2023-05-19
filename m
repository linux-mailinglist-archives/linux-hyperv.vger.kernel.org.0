Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E699B7099E8
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 May 2023 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjESOed (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 May 2023 10:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjESOeb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 May 2023 10:34:31 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020018.outbound.protection.outlook.com [52.101.56.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C8B116;
        Fri, 19 May 2023 07:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMAjxdvqAZT+JVYdmDitrik+fgAEh6XPt87DiOd1KzoNym5M3otpg1qcFOZFoaOvpv4bldeZ4irwcEguPQPHwvhuEniWSf9vLg4SgOzDJrlWDDXp54bRiuMcOc6PgmQwqmDXAcPW+UlqbJZharPHu30KF1oGodZPdBYIAzi3fsFsdHoAglvFnmga4g6iruyFP+6cfdIVs9m9pzRxTcPcUzTJPO/UdEOo4qIPiIkYgx2Kncx7ZrW1Ry/z4HGK2Nxof8bcaQzFdY9ZZYjRTV49av/2mAFMpdVvWT17U1e/pm+jCjloDPLUSiALCLrn4EdbiK0iQ0FN2qV74Joq5P+jFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqgElMciVeDds/LAccDEg4sclJTzWSIWS5TnClgbc4I=;
 b=DK9Mn6uzS5ZJP4tlNIN4sQYsTWvLbz1uF7IefASz0gGKfEamKhL6yrIs9Npd4COGh3snqzMDZ1Y/fqFmxFchnse7wuQRVYddOSOWVkSonPTKBWIz0v1IkVm4BrYsll2n6aUZ12KbuJ08Qf9IZBY3Jzhh7j8mRHPEfx72qjBuaNl39dARPiERhTSndGzxoQhjFwuMJYo3bHaEJGrfW6RIka57mqxScacN9RKdfSFGpcBcgO3Kl10oFMUVGMigXxzxHUB+OrpAdWDKjdsGCzxZaxTgonZY9lQwEo9jMewdOTJqgvAozyutrUVIoFH1XPJr/Jg5f9c/WgtmBMdIy+RQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqgElMciVeDds/LAccDEg4sclJTzWSIWS5TnClgbc4I=;
 b=N3/8H3Bbl7J6yTjYPvLKc+1FtpCoiRSxhqjN/swEEFFBvZ4HCvskGq9GTSiVroIAIVcpI03VWr7Bh9Qpxk5oWTXwIxZ3h1t1USs2BO7HkGS0M/GRF0XUySVPIH+m50f04zv4hQRjxtYNlp8u2FNhNG4wzquhsQxXPC0UsU3KfMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DS7PR21MB3391.namprd21.prod.outlook.com (2603:10b6:8:83::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.7; Fri, 19 May
 2023 14:34:27 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%6]) with mapi id 15.20.6433.007; Fri, 19 May 2023
 14:34:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline
Date:   Fri, 19 May 2023 07:33:51 -0700
Message-Id: <1684506832-41392-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0166.namprd15.prod.outlook.com
 (2603:10b6:930:81::14) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|DS7PR21MB3391:EE_
X-MS-Office365-Filtering-Correlation-Id: 085c8534-0c9a-4331-e08b-08db587625fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJ81nDTqTeU+TjNiAf5qT8YE7mtV9vxYGhsMLCOlwxHf7exoTwOf/8I2HMC0FZs407RrK8KBZm5DbnXi6B2kviTUE2DB1npqQrpiF7KOG+hAmRdU0WnBfPDYVjLaW3zlBv9+K4f1XPN+SgjzLFSLLJ3k7h3/w/EN3X84/o5JX3ysU6cp2mFAHzSjF+k4p4zIvEvkAPP5NmtYTWhzbYnkmaaowwuE6oji3mPMz8C52Lnu9Bzmr6IqgUc1J4ortQt9WTpAA/4lKlcmEBY/ucNmAcIG4oxwsyE6pPDsCqD9wMluks/ttAjwUeE69r7egf1cBWQlWVtPxSjzZCZ0GejuZz1t2egxuP4g2anbmaAjtfYShUyrais9/OSUD7SqOtAGqS5M49U9d8LYlJSP3VUcsmn+CQBfb+QAmJfmie4o11Pe5rhaA7KxJhhKa2wApRqVpsLvosBDRhuNqKr7MvxjMcd3rzk+iabnqd6obS1ezlNbr5i2F3IeMEn+4fp/RlHzbZ2dPmJRa9/ma/XteNBuQpzqcaCqu++FfEkXged/o5LGDkeJptljVyCYII+hJtz3X+bmurh1rLLiaZekEmNCboPZ3d0TbMOXwKZEgBVyJYO//qomQauighq1XJd23UrS/pQlJr+HpB4mZEG2lLD2H/bm8TY7RYnY8Nje+giLqzcAq7jx/Hr55O51go4c6hxv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(2616005)(6506007)(2906002)(66476007)(6512007)(8936002)(7416002)(8676002)(83380400001)(107886003)(6666004)(26005)(186003)(41300700001)(5660300002)(66946007)(66556008)(316002)(786003)(4326008)(52116002)(6486002)(921005)(82960400001)(82950400001)(86362001)(38100700002)(478600001)(10290500003)(38350700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQ2MoIbYFPBXcoLY6sUEsgwebA6vDwY0Az0LOmLVpyEkKRIIDHW8YE9ch0eT?=
 =?us-ascii?Q?jODwlg5q3kzUXFbH4FCyWW0GtgYtv5xLXI3wH+wjqDNVkMXiWGW0dstquLfw?=
 =?us-ascii?Q?CiRzanMfKEUaO1zoUaU9PUwCh0zJG+Cuq2JRXwrMqXNhHEqppr7mwehhRbwY?=
 =?us-ascii?Q?s+X5sU1WX+gBTijasJfvyQSpDYrAyDPhvIXMqeA5G2kHS2+YKwKIxgJK/1Dg?=
 =?us-ascii?Q?7VAuauNNyNQKmb2fBtxdjZTz22MNGINWAJ+Q69+cBNyWapdsIieRqAy3iVi+?=
 =?us-ascii?Q?VJFMMExW2qggCk7C+qjhLTJsYnATdz0k8OgqhHXtmmDtVR1g+3zukDHFnYY0?=
 =?us-ascii?Q?FzKoEnVZz/oXuhq+sdrhHatG91LAtCEvfFbcjwBkbcN7JcDEW2DpyWNGPdjK?=
 =?us-ascii?Q?LEt+JinyT89ye6LJkXf+hbLm3UYevaXKcUSuE2qkRGxMUA8YsYeIlJf/Sw7v?=
 =?us-ascii?Q?sMea0S1rkcoVXmNLbA0KcPPffQpvu8g9HLmvlWyepVy/hcA7O68U7P6cpOGq?=
 =?us-ascii?Q?gA2KkP/KTqsAFyOIyT259c1Gm8OUrLnYsqCEb2WPG3qQtu+TNM0bzHJAm30P?=
 =?us-ascii?Q?w+LXuKMZNGqXjA23qDaAUfprC21yc6UfU1mZRSxwgFI/pS+5xLlGe/sIhKrv?=
 =?us-ascii?Q?AwYW0GRcNhZoUaxl+2AgZKtcGNTSqb6QOiepGtyTqxqGDLL7AztNeYOgiumd?=
 =?us-ascii?Q?25wYMcad7Fs3JGkrgea2ZUJuKVubz2ryKZzbHyeKD6Ay6bHr5HA4Qq3x6nBH?=
 =?us-ascii?Q?X4WPPpyHheJJh61N0gcp/pSzYi7GJASQlChQ7xxwFxsoD89rwBAEn52kdf/U?=
 =?us-ascii?Q?s5YZOQ3nLo5N654JtlA12twaFw0I5b0FFhhbYk57eJvoXgcYH4K4H4+ol0GF?=
 =?us-ascii?Q?7kCjjuBzQN/yYgzEwuNknqAUkau7nQW3+VVD3l1Qy/f+OUCL2awmK8aIDta0?=
 =?us-ascii?Q?bXjwBPFFeP2Y0X1BslmrWEvsHXjFi5QyeuHoCxoK3iYCIkG5uoT1uftwtUnX?=
 =?us-ascii?Q?cfStogZCFhBb7Kx7H5I3XdsnaeQcY5HbghHpYfad1ZJiui9c9tXu7iOnWrwl?=
 =?us-ascii?Q?Fw31X7CB4ZcFClr92dL0lAyY8s0MJq1+ndShfBJTrCEroBteMaqrxGtV1YB4?=
 =?us-ascii?Q?y94Dxn4Ld78bfTxLUOt1p5Xes0dxZvB70dlp1gIS35OSa50sLSf8MSRMQAJG?=
 =?us-ascii?Q?u3Wt3GNsITHYAFZBM6G3BLmqeUQQSOK9CND7UOowyuar8zZmQKT7I66EhT2i?=
 =?us-ascii?Q?MzGRl6PO0r70Ko651X/yCpcYhoYOFdwLTDnzmAlma4B4nxdm66XfcJrmxyCx?=
 =?us-ascii?Q?B0gIeIgRJZdeLw7F87aT9oHPyoyPSfrO8NBcMHvwD7313P3mVTaS3yBQ56Aa?=
 =?us-ascii?Q?jr4gh+PrZ8mo2wfGX3RHdFwAcel+lRj5TfQ9SjYNNBaf5FlwE1hOzUzRAWAK?=
 =?us-ascii?Q?X5924CrTY5jaJdsOhzRXye3gGNodzj8v309iUTAurCjBwoD4HO/x25doZkPG?=
 =?us-ascii?Q?Q35xWMRvjS8aoljar6iAHqPVVsr1jj3DUSfyovgBdj6CDPR0pObnh1ew0vTT?=
 =?us-ascii?Q?nuHxh+uwHyuToq8htYTTck2mZhJl/fnC00Wrh/VE?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085c8534-0c9a-4331-e08b-08db587625fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 14:34:27.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ARP6crs7+ytVRZkkshRoHz+nmAsOO17YVFbxl+swajPOIdeVIAnX/CjHePu0PaaKWiwin8KgsMSMPWtSIEdEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3391
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
index 64f9cec..4c5cee4 100644
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
index 0f1001d..696004a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -201,6 +201,7 @@ enum cpuhp_state {
 	/* Online section invoked on the hotplugged CPU from the hotplug thread */
 	CPUHP_AP_ONLINE_IDLE,
 	CPUHP_AP_KVM_ONLINE,
+	CPUHP_AP_HYPERV_ONLINE,
 	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
-- 
1.8.3.1

