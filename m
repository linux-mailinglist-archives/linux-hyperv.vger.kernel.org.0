Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400A41B134D
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2020 19:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDTRjl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Apr 2020 13:39:41 -0400
Received: from mail-mw2nam12on2124.outbound.protection.outlook.com ([40.107.244.124]:36000
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbgDTRjk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Apr 2020 13:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KotZl/WcXif2JKEHvBLJnaq8fkt7G6K5iwg+v0lFYs/BpDG0MrKHGhio+6MkJZ78xlVgxdTXsdpJwiMGgbvSZdoRyjrS5He5racQgWYXW5wXSzKgPu439hIE+L1yNZPB+IydOpSpyhMC0lHefAHZMVm9MABezzwV4OI+NfQTQbntevH86oGzwrHe6QYiX/Wyw/9sy9MGIo37+phPG1iVHeUFWENzZMXD3T1kFsgi6Rl/LI5bPL7CF6tU0Rjd0ItbgYc8A2EsO01GZMjGZhmi5ml6NYY+CmnGPNsPOuAXJHkzjoI6injYdEWbpeEUgPmalBM5AeBjqxZqEwnaPjRWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKYp6EbWcGwPJAS/9krVvkW46R/RGvPR9RZ6Uh/etLE=;
 b=SBKpRW+0yvTfCLXJ1aO2PDWia/puE7hUhkGf7bS/KBdOH7Exr44K0fQp+PniYi/od5YKIZwNp5zyB57rgr/18KUceJ5bpHs0WijyS+PW+X7SQYtL+GU4Q36uDRwL3zekbvMI5fadlL219P19qBXCewb1SwzW6CoM1UNq1sibl8gnn+8yXVtH94N8Ycz3cMQAE6nUEc/k9glYZoueGhfTKPHqEdel2LPClAICr69/ZOqzJxPIVF+M1q2Q6J7FIW10W6qzR8hKtxTnjYh3VEGWmXzU/M/heucFzEI4c0X+v70U90KwYmGahwAwA2grqYcd04nLO8qiJ6ze6uU3EqCcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKYp6EbWcGwPJAS/9krVvkW46R/RGvPR9RZ6Uh/etLE=;
 b=XxxxxpmBpg99Nq0Dqz0ORkWpoRJVbnY5aOTwXHH6izMdr94raienyQHD0bp3tj+2A6sR2ZP1yT8N/Fgvuv3VtONQVehvujrHy/I0KVXIkgJvHKbQ/U+oBXd3XxM8EDxcF1uLw6W0OkECcMf/dD25E2n678O52bhdHt2sDq6CZlc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from BN6PR21MB0178.namprd21.prod.outlook.com (2603:10b6:404:94::12)
 by BN6PR21MB0691.namprd21.prod.outlook.com (2603:10b6:404:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2; Mon, 20 Apr
 2020 17:39:32 +0000
Received: from BN6PR21MB0178.namprd21.prod.outlook.com
 ([fe80::a97c:360c:9ed2:12ec]) by BN6PR21MB0178.namprd21.prod.outlook.com
 ([fe80::a97c:360c:9ed2:12ec%11]) with mapi id 15.20.2958.001; Mon, 20 Apr
 2020 17:39:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 3/4] x86/hyperv: Split hyperv-tlfs.h into arch dependent and independent files
Date:   Mon, 20 Apr 2020 10:38:37 -0700
Message-Id: <20200420173838.24672-4-mikelley@microsoft.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200420173838.24672-1-mikelley@microsoft.com>
References: <20200420173838.24672-1-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:300:c0::21) To BN6PR21MB0178.namprd21.prod.outlook.com
 (2603:10b6:404:94::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MHKdev.corp.microsoft.com (131.107.160.236) by MWHPR08CA0047.namprd08.prod.outlook.com (2603:10b6:300:c0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 17:39:30 +0000
X-Mailer: git-send-email 2.18.2
X-Originating-IP: [131.107.160.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 21af90e3-ba25-4ba3-d086-08d7e551c8b9
X-MS-TrafficTypeDiagnostic: BN6PR21MB0691:|BN6PR21MB0691:|BN6PR21MB0691:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB0691A2C8C11ED6C4F7F7D017D7D40@BN6PR21MB0691.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0178.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(7416002)(30864003)(66556008)(66946007)(66476007)(6486002)(16526019)(36756003)(1076003)(186003)(7696005)(52116002)(86362001)(26005)(5660300002)(4326008)(2616005)(10290500003)(8676002)(956004)(316002)(478600001)(966005)(2906002)(82960400001)(82950400001)(81156014)(8936002)(107886003)(921003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/DGZqQZARQXqbWP0JBq2JD220+ZsPZec6TTEx27LctyKmuOKSTz22mP3MWIc2Yc0Aj1PB6ipd0oLkAV0jwt/kFb11yDRLOuyKIrdHgrkcfv5miv+B+wPg9uoiMHIsBuRbeSNYpSLkaJuvtHuti9S7fqTYC9joEZp+Q5Ee4reA500VEgy5c9+gukIrrzrvy0+lLKJYOZY5wAuFzfB+gpV4xvUQpj1eeIK75lEA6lDKaH9sB/LeY0BEeSNBU1saGSy+m74rN0jMwx/T/ASMSSdDugO3SOkmoWEXWAVJB18TzwO2bqP/PcIv++1o2cs9A3UwcSF99BzsrhIMd47HxPjkWrYhKDDz7v4BgV1GvMMjFPS6JoKNGLapg+HyKgJKX2IjMjhOAlFuxTlSvDyzH+bOKQ0O0R3wPl/1xSmbGq9EWI9ugtclRKxzJOkDYfxhed3cWflFomTsn7W76nVrpa1EMPwBIRQXRCeHR0jBUt1fmUJmcZIIIevPMLtDexMNR47Fz5v4vySMSYoaafxhK+xqWYBK6wn4KH8icQO5PS5rl42rpXbAI6GA8w+q9b6pe/
X-MS-Exchange-AntiSpam-MessageData: qPncdS1+1nYQTe0B+o5jIrB1YmOuDb1niszzMl2eRDPREAnt13MiRj0qCe6p36q52ihsBSxPrXiz9cg5aFSzhgGgJM3dwYuic08yF6K0yPG7M+eR8R7SQZbALIXpPkk6mCQLZ5BlDuB8gZm77OWXEPUv37uz+0+bvps48C6YNJXhKlwwrPf0G71Sm/qRK4rQch6oAzAVZq5M4RMkBNFMRioJOWjlbBoBpiN0fp9mIbikWp5moNP4+5guGYQGm3RBASi29pW8bwGtGBtMB27l2Pp4c0+S0WcMOwSJ4Lj3V3jYh0IWEsXtHjqup/8gYa2bA3lOiwVct2LcgAbbg3M9B3lYT+dtdatL3+3RXwbhl2cpwryo5Pp8SkDuSJ+qVeNcBFPdqFRGV94vMgzELslsrs3mVmo58NeF5qdXMxgS51d3GWkwxu8u/YVIJpJKf3RhvQv2b0qp2dJR8bOjg6cf/D41Z62OdmlE0jks7wtZ/fq04/uYO7yHU6oa4RnTshcetK1JL2yfpYZz+Y/f5mkpCJdlyomOot1777vV9YZjHQtRLuHIkEEVBWKefhpuQ1M6gVoyM0E0k3vlty4KXJBbVu/Zc7jgMbxhpGFgUcomefWR6S45aD85BEUZPM7C/M6bsPqxtUOqJo8NXFfaznyHg+Zq2mBiGri0C91q72sSXSbszzqsv4Uc88vyfyntke2cZfs4JloEtodnm5GRvI9rHHnh/FO7181ygWmt4oSplqlTykizNNgW7S86ui5outtupUPz9MBeTQXjGKIwaUfUeWsvprhfhlxHiMoI0H27RBd9IBAu4yBpgRTg5hpTAPhm
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21af90e3-ba25-4ba3-d086-08d7e551c8b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 17:39:32.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eursI7h0j7ygDoyqKu5i1Tj4wp9LZGShXLfWTKfJNSxE5onzrdzEdcQjWAKWxPS0vVW5UGnsRbQEpSEKkYl0WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0691
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In preparation for adding ARM64 support, split hyperv-tlfs.h into
architecture dependent and architecture independent files, similar
to what has been done with mshyperv.h. Move architecture independent
definitions into include/asm-generic/hyperv-tlfs.h.  The split will
avoid duplicating significant lines of code in the ARM64 version of
hyperv-tlfs.h.  The split has no functional impact.

Some of the common definitions have "X64" in the symbol name.  Change
these to remove the "X64" in the architecture independent version of
hyperv-tlfs.h, but add aliases with the "X64" in the x86 version so
that x86 code will continue to compile.  A later patch set will
change all the references and allow removal of the aliases.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 459 +++--------------------------
 include/asm-generic/hyperv-tlfs.h  | 442 +++++++++++++++++++++++++++
 2 files changed, 478 insertions(+), 423 deletions(-)
 create mode 100644 include/asm-generic/hyperv-tlfs.h

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 2dd1ceb2bcf8..4e91f6118d5d 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -11,17 +11,6 @@
 
 #include <linux/types.h>
 #include <asm/page.h>
-
-/*
- * While not explicitly listed in the TLFS, Hyper-V always runs with a page size
- * of 4096. These definitions are used when communicating with Hyper-V using
- * guest physical pages and guest physical page addresses, since the guest page
- * size may not be 4096 on all architectures.
- */
-#define HV_HYP_PAGE_SHIFT      12
-#define HV_HYP_PAGE_SIZE       BIT(HV_HYP_PAGE_SHIFT)
-#define HV_HYP_PAGE_MASK       (~(HV_HYP_PAGE_SIZE - 1))
-
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
  * is set by CPUID(HvCpuIdFunctionVersionAndFeatures).
@@ -39,78 +28,41 @@
 #define HYPERV_CPUID_MAX			0x4000ffff
 
 /*
- * Feature identification. EAX indicates which features are available
- * to the partition based upon the current partition privileges.
- * These are HYPERV_CPUID_FEATURES.EAX bits.
+ * Aliases for Group A features that have X64 in the name.
+ * On x86/x64 these are HYPERV_CPUID_FEATURES.EAX bits.
  */
 
-/* VP Runtime (HV_X64_MSR_VP_RUNTIME) available */
-#define HV_X64_MSR_VP_RUNTIME_AVAILABLE		BIT(0)
-/* Partition Reference Counter (HV_X64_MSR_TIME_REF_COUNT) available*/
-#define HV_MSR_TIME_REF_COUNT_AVAILABLE		BIT(1)
-/*
- * Basic SynIC MSRs (HV_X64_MSR_SCONTROL through HV_X64_MSR_EOM
- * and HV_X64_MSR_SINT0 through HV_X64_MSR_SINT15) available
- */
-#define HV_X64_MSR_SYNIC_AVAILABLE		BIT(2)
-/*
- * Synthetic Timer MSRs (HV_X64_MSR_STIMER0_CONFIG through
- * HV_X64_MSR_STIMER3_COUNT) available
- */
-#define HV_MSR_SYNTIMER_AVAILABLE		BIT(3)
-/*
- * APIC access MSRs (HV_X64_MSR_EOI, HV_X64_MSR_ICR and HV_X64_MSR_TPR)
- * are available
- */
-#define HV_X64_MSR_APIC_ACCESS_AVAILABLE	BIT(4)
-/* Hypercall MSRs (HV_X64_MSR_GUEST_OS_ID and HV_X64_MSR_HYPERCALL) available*/
-#define HV_X64_MSR_HYPERCALL_AVAILABLE		BIT(5)
-/* Access virtual processor index MSR (HV_X64_MSR_VP_INDEX) available*/
-#define HV_X64_MSR_VP_INDEX_AVAILABLE		BIT(6)
-/* Virtual system reset MSR (HV_X64_MSR_RESET) is available*/
-#define HV_X64_MSR_RESET_AVAILABLE		BIT(7)
-/*
- * Access statistics pages MSRs (HV_X64_MSR_STATS_PARTITION_RETAIL_PAGE,
- * HV_X64_MSR_STATS_PARTITION_INTERNAL_PAGE, HV_X64_MSR_STATS_VP_RETAIL_PAGE,
- * HV_X64_MSR_STATS_VP_INTERNAL_PAGE) available
- */
-#define HV_X64_MSR_STAT_PAGES_AVAILABLE		BIT(8)
-/* Partition reference TSC MSR is available */
-#define HV_MSR_REFERENCE_TSC_AVAILABLE		BIT(9)
-/* Partition Guest IDLE MSR is available */
-#define HV_X64_MSR_GUEST_IDLE_AVAILABLE		BIT(10)
-/*
- * There is a single feature flag that signifies if the partition has access
- * to MSRs with local APIC and TSC frequencies.
- */
-#define HV_X64_ACCESS_FREQUENCY_MSRS		BIT(11)
-/* AccessReenlightenmentControls privilege */
-#define HV_X64_ACCESS_REENLIGHTENMENT		BIT(13)
-/* AccessTscInvariantControls privilege */
-#define HV_X64_ACCESS_TSC_INVARIANT		BIT(15)
+#define HV_X64_MSR_VP_RUNTIME_AVAILABLE		\
+		HV_MSR_VP_RUNTIME_AVAILABLE
+#define HV_X64_MSR_SYNIC_AVAILABLE		\
+		HV_MSR_SYNIC_AVAILABLE
+#define HV_X64_MSR_APIC_ACCESS_AVAILABLE	\
+		HV_MSR_APIC_ACCESS_AVAILABLE
+#define HV_X64_MSR_HYPERCALL_AVAILABLE		\
+		HV_MSR_HYPERCALL_AVAILABLE
+#define HV_X64_MSR_VP_INDEX_AVAILABLE		\
+		HV_MSR_VP_INDEX_AVAILABLE
+#define HV_X64_MSR_RESET_AVAILABLE		\
+		HV_MSR_RESET_AVAILABLE
+#define HV_X64_MSR_GUEST_IDLE_AVAILABLE		\
+		HV_MSR_GUEST_IDLE_AVAILABLE
+#define HV_X64_ACCESS_FREQUENCY_MSRS		\
+		HV_ACCESS_FREQUENCY_MSRS
+#define HV_X64_ACCESS_REENLIGHTENMENT		\
+		HV_ACCESS_REENLIGHTENMENT
+#define HV_X64_ACCESS_TSC_INVARIANT		\
+		HV_ACCESS_TSC_INVARIANT
 
 /*
- * Feature identification: indicates which flags were specified at partition
- * creation. The format is the same as the partition creation flag structure
- * defined in section Partition Creation Flags.
- * These are HYPERV_CPUID_FEATURES.EBX bits.
+ * Aliases for Group B features that have X64 in the name.
+ * On x86/x64 these are HYPERV_CPUID_FEATURES.EBX bits.
  */
-#define HV_X64_CREATE_PARTITIONS		BIT(0)
-#define HV_X64_ACCESS_PARTITION_ID		BIT(1)
-#define HV_X64_ACCESS_MEMORY_POOL		BIT(2)
-#define HV_X64_ADJUST_MESSAGE_BUFFERS		BIT(3)
-#define HV_X64_POST_MESSAGES			BIT(4)
-#define HV_X64_SIGNAL_EVENTS			BIT(5)
-#define HV_X64_CREATE_PORT			BIT(6)
-#define HV_X64_CONNECT_PORT			BIT(7)
-#define HV_X64_ACCESS_STATS			BIT(8)
-#define HV_X64_DEBUGGING			BIT(11)
-#define HV_X64_CPU_POWER_MANAGEMENT		BIT(12)
+#define HV_X64_POST_MESSAGES		HV_POST_MESSAGES
+#define HV_X64_SIGNAL_EVENTS		HV_SIGNAL_EVENTS
 
 /*
- * Feature identification. EDX indicates which miscellaneous features
- * are available to the partition.
- * These are HYPERV_CPUID_FEATURES.EDX bits.
+ * Group D Features.  The bit assignments are custom to each architecture.
+ * On x86/x64 these are HYPERV_CPUID_FEATURES.EDX bits.
  */
 /* The MWAIT instruction is available (per section MONITOR / MWAIT) */
 #define HV_X64_MWAIT_AVAILABLE				BIT(0)
@@ -187,7 +139,7 @@
  * processor, except for virtual processors that are reported as sibling SMT
  * threads.
  */
-#define HV_X64_NO_NONARCH_CORESHARING                  BIT(18)
+#define HV_X64_NO_NONARCH_CORESHARING			BIT(18)
 
 /* Nested features. These are HYPERV_CPUID_NESTED_FEATURES.EAX bits. */
 #define HV_X64_NESTED_DIRECT_FLUSH			BIT(17)
@@ -295,42 +247,6 @@ union hv_x64_msr_hypercall_contents {
 	} __packed;
 };
 
-/*
- * TSC page layout.
- */
-struct ms_hyperv_tsc_page {
-	volatile u32 tsc_sequence;
-	u32 reserved1;
-	volatile u64 tsc_scale;
-	volatile s64 tsc_offset;
-}  __packed;
-
-/*
- * The guest OS needs to register the guest ID with the hypervisor.
- * The guest ID is a 64 bit entity and the structure of this ID is
- * specified in the Hyper-V specification:
- *
- * msdn.microsoft.com/en-us/library/windows/hardware/ff542653%28v=vs.85%29.aspx
- *
- * While the current guideline does not specify how Linux guest ID(s)
- * need to be generated, our plan is to publish the guidelines for
- * Linux and other guest operating systems that currently are hosted
- * on Hyper-V. The implementation here conforms to this yet
- * unpublished guidelines.
- *
- *
- * Bit(s)
- * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
- * 62:56 - Os Type; Linux is 0x100
- * 55:48 - Distro specific identification
- * 47:16 - Linux kernel version number
- * 15:0  - Distro specific identification
- *
- *
- */
-
-#define HV_LINUX_VENDOR_ID              0x8100
-
 struct hv_reenlightenment_control {
 	__u64 vector:8;
 	__u64 reserved1:8;
@@ -354,31 +270,12 @@ struct hv_tsc_emulation_status {
 #define HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_MASK	\
 		(~((1ull << HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_SHIFT) - 1))
 
-/*
- * Crash notification (HV_X64_MSR_CRASH_CTL) flags.
- */
-#define HV_CRASH_CTL_CRASH_NOTIFY_MSG		BIT_ULL(62)
-#define HV_CRASH_CTL_CRASH_NOTIFY		BIT_ULL(63)
 #define HV_X64_MSR_CRASH_PARAMS		\
 		(1 + (HV_X64_MSR_CRASH_P4 - HV_X64_MSR_CRASH_P0))
 
 #define HV_IPI_LOW_VECTOR	0x10
 #define HV_IPI_HIGH_VECTOR	0xff
 
-/* Declare the various hypercall operations. */
-#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
-#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
-#define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
-#define HVCALL_SEND_IPI				0x000b
-#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX  0x0013
-#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX   0x0014
-#define HVCALL_SEND_IPI_EX			0x0015
-#define HVCALL_POST_MESSAGE			0x005c
-#define HVCALL_SIGNAL_EVENT			0x005d
-#define HVCALL_RETARGET_INTERRUPT		0x007e
-#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
-#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
-
 #define HV_X64_MSR_VP_ASSIST_PAGE_ENABLE	0x00000001
 #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
 #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
@@ -390,63 +287,6 @@ struct hv_tsc_emulation_status {
 #define HV_X64_MSR_TSC_REFERENCE_ENABLE		0x00000001
 #define HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT	12
 
-#define HV_FLUSH_ALL_PROCESSORS			BIT(0)
-#define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
-#define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
-#define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
-
-enum HV_GENERIC_SET_FORMAT {
-	HV_GENERIC_SET_SPARSE_4K,
-	HV_GENERIC_SET_ALL,
-};
-
-#define HV_PARTITION_ID_SELF                    ((u64)-1)
-
-#define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
-#define HV_HYPERCALL_FAST_BIT		BIT(16)
-#define HV_HYPERCALL_VARHEAD_OFFSET	17
-#define HV_HYPERCALL_REP_COMP_OFFSET	32
-#define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
-#define HV_HYPERCALL_REP_START_OFFSET	48
-#define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
-
-/* hypercall status code */
-#define HV_STATUS_SUCCESS			0
-#define HV_STATUS_INVALID_HYPERCALL_CODE	2
-#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
-#define HV_STATUS_INVALID_ALIGNMENT		4
-#define HV_STATUS_INVALID_PARAMETER		5
-#define HV_STATUS_INSUFFICIENT_MEMORY		11
-#define HV_STATUS_INVALID_PORT_ID		17
-#define HV_STATUS_INVALID_CONNECTION_ID		18
-#define HV_STATUS_INSUFFICIENT_BUFFERS		19
-
-/*
- * The Hyper-V TimeRefCount register and the TSC
- * page provide a guest VM clock with 100ns tick rate
- */
-#define HV_CLOCK_HZ (NSEC_PER_SEC/100)
-
-/* Define the number of synthetic interrupt sources. */
-#define HV_SYNIC_SINT_COUNT		(16)
-/* Define the expected SynIC version. */
-#define HV_SYNIC_VERSION_1		(0x1)
-/* Valid SynIC vectors are 16-255. */
-#define HV_SYNIC_FIRST_VALID_VECTOR	(16)
-
-#define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
-#define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
-#define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
-#define HV_SYNIC_SINT_MASKED		(1ULL << 16)
-#define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
-#define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
-
-#define HV_SYNIC_STIMER_COUNT		(4)
-
-/* Define synthetic interrupt controller message constants. */
-#define HV_MESSAGE_SIZE			(256)
-#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
-#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
 
 /* Define hypervisor message types. */
 enum hv_message_type {
@@ -457,76 +297,25 @@ enum hv_message_type {
 	HVMSG_GPA_INTERCEPT		= 0x80000001,
 
 	/* Timer notification messages. */
-	HVMSG_TIMER_EXPIRED			= 0x80000010,
+	HVMSG_TIMER_EXPIRED		= 0x80000010,
 
 	/* Error messages. */
 	HVMSG_INVALID_VP_REGISTER_VALUE	= 0x80000020,
 	HVMSG_UNRECOVERABLE_EXCEPTION	= 0x80000021,
-	HVMSG_UNSUPPORTED_FEATURE		= 0x80000022,
+	HVMSG_UNSUPPORTED_FEATURE	= 0x80000022,
 
 	/* Trace buffer complete messages. */
 	HVMSG_EVENTLOG_BUFFERCOMPLETE	= 0x80000040,
 
 	/* Platform-specific processor intercept messages. */
-	HVMSG_X64_IOPORT_INTERCEPT		= 0x80010000,
+	HVMSG_X64_IOPORT_INTERCEPT	= 0x80010000,
 	HVMSG_X64_MSR_INTERCEPT		= 0x80010001,
-	HVMSG_X64_CPUID_INTERCEPT		= 0x80010002,
+	HVMSG_X64_CPUID_INTERCEPT	= 0x80010002,
 	HVMSG_X64_EXCEPTION_INTERCEPT	= 0x80010003,
-	HVMSG_X64_APIC_EOI			= 0x80010004,
-	HVMSG_X64_LEGACY_FP_ERROR		= 0x80010005
+	HVMSG_X64_APIC_EOI		= 0x80010004,
+	HVMSG_X64_LEGACY_FP_ERROR	= 0x80010005
 };
 
-/* Define synthetic interrupt controller message flags. */
-union hv_message_flags {
-	__u8 asu8;
-	struct {
-		__u8 msg_pending:1;
-		__u8 reserved:7;
-	} __packed;
-};
-
-/* Define port identifier type. */
-union hv_port_id {
-	__u32 asu32;
-	struct {
-		__u32 id:24;
-		__u32 reserved:8;
-	} __packed u;
-};
-
-/* Define synthetic interrupt controller message header. */
-struct hv_message_header {
-	__u32 message_type;
-	__u8 payload_size;
-	union hv_message_flags message_flags;
-	__u8 reserved[2];
-	union {
-		__u64 sender;
-		union hv_port_id port;
-	};
-} __packed;
-
-/* Define synthetic interrupt controller message format. */
-struct hv_message {
-	struct hv_message_header header;
-	union {
-		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
-	} u;
-} __packed;
-
-/* Define the synthetic interrupt message page layout. */
-struct hv_message_page {
-	struct hv_message sint_message[HV_SYNIC_SINT_COUNT];
-} __packed;
-
-/* Define timer message payload structure. */
-struct hv_timer_message_payload {
-	__u32 timer_index;
-	__u32 reserved;
-	__u64 expiration_time;	/* When the timer expired */
-	__u64 delivery_time;	/* When the message was delivered */
-} __packed;
-
 struct hv_nested_enlightenments_control {
 	struct {
 		__u32 directhypercall:1;
@@ -754,187 +543,11 @@ struct hv_enlightened_vmcs {
 
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL			0xFFFF
 
-/* Define synthetic interrupt controller flag constants. */
-#define HV_EVENT_FLAGS_COUNT		(256 * 8)
-#define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
-
-/*
- * Synthetic timer configuration.
- */
-union hv_stimer_config {
-	u64 as_uint64;
-	struct {
-		u64 enable:1;
-		u64 periodic:1;
-		u64 lazy:1;
-		u64 auto_enable:1;
-		u64 apic_vector:8;
-		u64 direct_mode:1;
-		u64 reserved_z0:3;
-		u64 sintx:4;
-		u64 reserved_z1:44;
-	} __packed;
-};
-
-
-/* Define the synthetic interrupt controller event flags format. */
-union hv_synic_event_flags {
-	unsigned long flags[HV_EVENT_FLAGS_LONG_COUNT];
-};
-
-/* Define SynIC control register. */
-union hv_synic_scontrol {
-	u64 as_uint64;
-	struct {
-		u64 enable:1;
-		u64 reserved:63;
-	} __packed;
-};
-
-/* Define synthetic interrupt source. */
-union hv_synic_sint {
-	u64 as_uint64;
-	struct {
-		u64 vector:8;
-		u64 reserved1:8;
-		u64 masked:1;
-		u64 auto_eoi:1;
-		u64 polling:1;
-		u64 reserved2:45;
-	} __packed;
-};
-
-/* Define the format of the SIMP register */
-union hv_synic_simp {
-	u64 as_uint64;
-	struct {
-		u64 simp_enabled:1;
-		u64 preserved:11;
-		u64 base_simp_gpa:52;
-	} __packed;
-};
-
-/* Define the format of the SIEFP register */
-union hv_synic_siefp {
-	u64 as_uint64;
-	struct {
-		u64 siefp_enabled:1;
-		u64 preserved:11;
-		u64 base_siefp_gpa:52;
-	} __packed;
-};
-
-struct hv_vpset {
-	u64 format;
-	u64 valid_bank_mask;
-	u64 bank_contents[];
-} __packed;
-
-/* HvCallSendSyntheticClusterIpi hypercall */
-struct hv_send_ipi {
-	u32 vector;
-	u32 reserved;
-	u64 cpu_mask;
-} __packed;
-
-/* HvCallSendSyntheticClusterIpiEx hypercall */
-struct hv_send_ipi_ex {
-	u32 vector;
-	u32 reserved;
-	struct hv_vpset vp_set;
-} __packed;
-
-/* HvFlushGuestPhysicalAddressSpace hypercalls */
-struct hv_guest_mapping_flush {
-	u64 address_space;
-	u64 flags;
-} __packed;
-
-/*
- *  HV_MAX_FLUSH_PAGES = "additional_pages" + 1. It's limited
- *  by the bitwidth of "additional_pages" in union hv_gpa_page_range.
- */
-#define HV_MAX_FLUSH_PAGES (2048)
-
-/* HvFlushGuestPhysicalAddressList hypercall */
-union hv_gpa_page_range {
-	u64 address_space;
-	struct {
-		u64 additional_pages:11;
-		u64 largepage:1;
-		u64 basepfn:52;
-	} page;
-};
-
-/*
- * All input flush parameters should be in single page. The max flush
- * count is equal with how many entries of union hv_gpa_page_range can
- * be populated into the input parameter page.
- */
-#define HV_MAX_FLUSH_REP_COUNT ((HV_HYP_PAGE_SIZE - 2 * sizeof(u64)) /	\
-				sizeof(union hv_gpa_page_range))
-
-struct hv_guest_mapping_flush_list {
-	u64 address_space;
-	u64 flags;
-	union hv_gpa_page_range gpa_list[HV_MAX_FLUSH_REP_COUNT];
-};
-
-/* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
-struct hv_tlb_flush {
-	u64 address_space;
-	u64 flags;
-	u64 processor_mask;
-	u64 gva_list[];
-} __packed;
-
-/* HvFlushVirtualAddressSpaceEx, HvFlushVirtualAddressListEx hypercalls */
-struct hv_tlb_flush_ex {
-	u64 address_space;
-	u64 flags;
-	struct hv_vpset hv_vp_set;
-	u64 gva_list[];
-} __packed;
-
 struct hv_partition_assist_pg {
 	u32 tlb_lock_count;
 };
 
-union hv_msi_entry {
-	u64 as_uint64;
-	struct {
-		u32 address;
-		u32 data;
-	} __packed;
-};
-
-struct hv_interrupt_entry {
-	u32 source;			/* 1 for MSI(-X) */
-	u32 reserved1;
-	union hv_msi_entry msi_entry;
-} __packed;
 
-/*
- * flags for hv_device_interrupt_target.flags
- */
-#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
-#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
-
-struct hv_device_interrupt_target {
-	u32 vector;
-	u32 flags;
-	union {
-		u64 vp_mask;
-		struct hv_vpset vp_set;
-	};
-} __packed;
+#include <asm-generic/hyperv-tlfs.h>
 
-/* HvRetargetDeviceInterrupt hypercall */
-struct hv_retarget_device_interrupt {
-	u64 partition_id;		/* use "self" */
-	u64 device_id;
-	struct hv_interrupt_entry int_entry;
-	u64 reserved2;
-	struct hv_device_interrupt_target int_target;
-} __packed __aligned(8);
 #endif
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
new file mode 100644
index 000000000000..1f92ef92eb56
--- /dev/null
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -0,0 +1,442 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This file contains definitions from Hyper-V Hypervisor Top-Level Functional
+ * Specification (TLFS):
+ * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
+ */
+
+#ifndef _ASM_GENERIC_HYPERV_TLFS_H
+#define _ASM_GENERIC_HYPERV_TLFS_H
+
+#include <linux/types.h>
+#include <linux/bits.h>
+#include <linux/time64.h>
+
+/*
+ * While not explicitly listed in the TLFS, Hyper-V always runs with a page size
+ * of 4096. These definitions are used when communicating with Hyper-V using
+ * guest physical pages and guest physical page addresses, since the guest page
+ * size may not be 4096 on all architectures.
+ */
+#define HV_HYP_PAGE_SHIFT      12
+#define HV_HYP_PAGE_SIZE       BIT(HV_HYP_PAGE_SHIFT)
+#define HV_HYP_PAGE_MASK       (~(HV_HYP_PAGE_SIZE - 1))
+
+/*
+ * Hyper-V provides two categories of flags relevant to guest VMs.  The
+ * "Features" category indicates specific functionality that is available
+ * to guests on this particular instance of Hyper-V. The "Features"
+ * are presented in four groups, each of which is 32 bits. The group A
+ * and B definitions are common across architectures and are listed here.
+ * However, not all flags are relevant on all architectures.
+ *
+ * Groups C and D vary across architectures and are listed in the
+ * architecture specific portion of hyperv-tlfs.h. Some of these flags exist
+ * on multiple architectures, but the bit positions are different so they
+ * cannot appear in the generic portion of hyperv-tlfs.h.
+ *
+ * The "Enlightenments" category provides recommendations on whether to use
+ * specific enlightenments that are available. The Enlighenments are a single
+ * group of 32 bits, but they vary across architectures and are listed in
+ * the architecture specific portion of hyperv-tlfs.h.
+ */
+
+/*
+ * Group A Features.
+ */
+
+/* VP Runtime register available */
+#define HV_MSR_VP_RUNTIME_AVAILABLE		BIT(0)
+/* Partition Reference Counter available*/
+#define HV_MSR_TIME_REF_COUNT_AVAILABLE		BIT(1)
+/* Basic SynIC register available */
+#define HV_MSR_SYNIC_AVAILABLE			BIT(2)
+/* Synthetic Timer registers available */
+#define HV_MSR_SYNTIMER_AVAILABLE		BIT(3)
+/* Virtual APIC assist and VP assist page registers available */
+#define HV_MSR_APIC_ACCESS_AVAILABLE		BIT(4)
+/* Hypercall and Guest OS ID registers available*/
+#define HV_MSR_HYPERCALL_AVAILABLE		BIT(5)
+/* Access virtual processor index register available*/
+#define HV_MSR_VP_INDEX_AVAILABLE		BIT(6)
+/* Virtual system reset register available*/
+#define HV_MSR_RESET_AVAILABLE			BIT(7)
+/* Access statistics page registers available */
+#define HV_MSR_STAT_PAGES_AVAILABLE		BIT(8)
+/* Partition reference TSC register is available */
+#define HV_MSR_REFERENCE_TSC_AVAILABLE		BIT(9)
+/* Partition Guest IDLE register is available */
+#define HV_MSR_GUEST_IDLE_AVAILABLE		BIT(10)
+/* Partition local APIC and TSC frequency registers available */
+#define HV_ACCESS_FREQUENCY_MSRS		BIT(11)
+/* AccessReenlightenmentControls privilege */
+#define HV_ACCESS_REENLIGHTENMENT		BIT(13)
+/* AccessTscInvariantControls privilege */
+#define HV_ACCESS_TSC_INVARIANT			BIT(15)
+
+/*
+ * Group B features.
+ */
+#define HV_CREATE_PARTITIONS			BIT(0)
+#define HV_ACCESS_PARTITION_ID			BIT(1)
+#define HV_ACCESS_MEMORY_POOL			BIT(2)
+#define HV_ADJUST_MESSAGE_BUFFERS		BIT(3)
+#define HV_POST_MESSAGES			BIT(4)
+#define HV_SIGNAL_EVENTS			BIT(5)
+#define HV_CREATE_PORT				BIT(6)
+#define HV_CONNECT_PORT				BIT(7)
+#define HV_ACCESS_STATS				BIT(8)
+#define HV_DEBUGGING				BIT(11)
+#define HV_CPU_POWER_MANAGEMENT			BIT(12)
+
+
+/*
+ * TSC page layout.
+ */
+struct ms_hyperv_tsc_page {
+	volatile u32 tsc_sequence;
+	u32 reserved1;
+	volatile u64 tsc_scale;
+	volatile s64 tsc_offset;
+} __packed;
+
+/*
+ * The guest OS needs to register the guest ID with the hypervisor.
+ * The guest ID is a 64 bit entity and the structure of this ID is
+ * specified in the Hyper-V specification:
+ *
+ * msdn.microsoft.com/en-us/library/windows/hardware/ff542653%28v=vs.85%29.aspx
+ *
+ * While the current guideline does not specify how Linux guest ID(s)
+ * need to be generated, our plan is to publish the guidelines for
+ * Linux and other guest operating systems that currently are hosted
+ * on Hyper-V. The implementation here conforms to this yet
+ * unpublished guidelines.
+ *
+ *
+ * Bit(s)
+ * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
+ * 62:56 - Os Type; Linux is 0x100
+ * 55:48 - Distro specific identification
+ * 47:16 - Linux kernel version number
+ * 15:0  - Distro specific identification
+ *
+ *
+ */
+
+#define HV_LINUX_VENDOR_ID              0x8100
+
+/*
+ * Crash notification flags.
+ */
+#define HV_CRASH_CTL_CRASH_NOTIFY_MSG		BIT_ULL(62)
+#define HV_CRASH_CTL_CRASH_NOTIFY		BIT_ULL(63)
+
+/* Declare the various hypercall operations. */
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
+#define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
+#define HVCALL_SEND_IPI				0x000b
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
+#define HVCALL_SEND_IPI_EX			0x0015
+#define HVCALL_POST_MESSAGE			0x005c
+#define HVCALL_SIGNAL_EVENT			0x005d
+#define HVCALL_RETARGET_INTERRUPT		0x007e
+#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
+#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
+
+#define HV_FLUSH_ALL_PROCESSORS			BIT(0)
+#define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
+#define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
+#define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
+
+enum HV_GENERIC_SET_FORMAT {
+	HV_GENERIC_SET_SPARSE_4K,
+	HV_GENERIC_SET_ALL,
+};
+
+#define HV_PARTITION_ID_SELF		((u64)-1)
+#define HV_VP_INDEX_SELF		((u32)-2)
+
+#define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
+#define HV_HYPERCALL_FAST_BIT		BIT(16)
+#define HV_HYPERCALL_VARHEAD_OFFSET	17
+#define HV_HYPERCALL_REP_COMP_OFFSET	32
+#define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
+#define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
+#define HV_HYPERCALL_REP_START_OFFSET	48
+#define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
+
+/* hypercall status code */
+#define HV_STATUS_SUCCESS			0
+#define HV_STATUS_INVALID_HYPERCALL_CODE	2
+#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
+#define HV_STATUS_INVALID_ALIGNMENT		4
+#define HV_STATUS_INVALID_PARAMETER		5
+#define HV_STATUS_INSUFFICIENT_MEMORY		11
+#define HV_STATUS_INVALID_PORT_ID		17
+#define HV_STATUS_INVALID_CONNECTION_ID		18
+#define HV_STATUS_INSUFFICIENT_BUFFERS		19
+
+/*
+ * The Hyper-V TimeRefCount register and the TSC
+ * page provide a guest VM clock with 100ns tick rate
+ */
+#define HV_CLOCK_HZ (NSEC_PER_SEC/100)
+
+/* Define the number of synthetic interrupt sources. */
+#define HV_SYNIC_SINT_COUNT		(16)
+/* Define the expected SynIC version. */
+#define HV_SYNIC_VERSION_1		(0x1)
+/* Valid SynIC vectors are 16-255. */
+#define HV_SYNIC_FIRST_VALID_VECTOR	(16)
+
+#define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SINT_MASKED		(1ULL << 16)
+#define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
+#define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
+
+#define HV_SYNIC_STIMER_COUNT		(4)
+
+/* Define synthetic interrupt controller message constants. */
+#define HV_MESSAGE_SIZE			(256)
+#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
+#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
+
+/* Define synthetic interrupt controller message flags. */
+union hv_message_flags {
+	__u8 asu8;
+	struct {
+		__u8 msg_pending:1;
+		__u8 reserved:7;
+	} __packed;
+};
+
+/* Define port identifier type. */
+union hv_port_id {
+	__u32 asu32;
+	struct {
+		__u32 id:24;
+		__u32 reserved:8;
+	} __packed u;
+};
+
+/* Define synthetic interrupt controller message header. */
+struct hv_message_header {
+	__u32 message_type;
+	__u8 payload_size;
+	union hv_message_flags message_flags;
+	__u8 reserved[2];
+	union {
+		__u64 sender;
+		union hv_port_id port;
+	};
+} __packed;
+
+/* Define synthetic interrupt controller message format. */
+struct hv_message {
+	struct hv_message_header header;
+	union {
+		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
+	} u;
+} __packed;
+
+/* Define the synthetic interrupt message page layout. */
+struct hv_message_page {
+	struct hv_message sint_message[HV_SYNIC_SINT_COUNT];
+} __packed;
+
+/* Define timer message payload structure. */
+struct hv_timer_message_payload {
+	__u32 timer_index;
+	__u32 reserved;
+	__u64 expiration_time;	/* When the timer expired */
+	__u64 delivery_time;	/* When the message was delivered */
+} __packed;
+
+
+/* Define synthetic interrupt controller flag constants. */
+#define HV_EVENT_FLAGS_COUNT		(256 * 8)
+#define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
+
+/*
+ * Synthetic timer configuration.
+ */
+union hv_stimer_config {
+	u64 as_uint64;
+	struct {
+		u64 enable:1;
+		u64 periodic:1;
+		u64 lazy:1;
+		u64 auto_enable:1;
+		u64 apic_vector:8;
+		u64 direct_mode:1;
+		u64 reserved_z0:3;
+		u64 sintx:4;
+		u64 reserved_z1:44;
+	} __packed;
+};
+
+
+/* Define the synthetic interrupt controller event flags format. */
+union hv_synic_event_flags {
+	unsigned long flags[HV_EVENT_FLAGS_LONG_COUNT];
+};
+
+/* Define SynIC control register. */
+union hv_synic_scontrol {
+	u64 as_uint64;
+	struct {
+		u64 enable:1;
+		u64 reserved:63;
+	} __packed;
+};
+
+/* Define synthetic interrupt source. */
+union hv_synic_sint {
+	u64 as_uint64;
+	struct {
+		u64 vector:8;
+		u64 reserved1:8;
+		u64 masked:1;
+		u64 auto_eoi:1;
+		u64 polling:1;
+		u64 reserved2:45;
+	} __packed;
+};
+
+/* Define the format of the SIMP register */
+union hv_synic_simp {
+	u64 as_uint64;
+	struct {
+		u64 simp_enabled:1;
+		u64 preserved:11;
+		u64 base_simp_gpa:52;
+	} __packed;
+};
+
+/* Define the format of the SIEFP register */
+union hv_synic_siefp {
+	u64 as_uint64;
+	struct {
+		u64 siefp_enabled:1;
+		u64 preserved:11;
+		u64 base_siefp_gpa:52;
+	} __packed;
+};
+
+struct hv_vpset {
+	u64 format;
+	u64 valid_bank_mask;
+	u64 bank_contents[];
+} __packed;
+
+/* HvCallSendSyntheticClusterIpi hypercall */
+struct hv_send_ipi {
+	u32 vector;
+	u32 reserved;
+	u64 cpu_mask;
+} __packed;
+
+/* HvCallSendSyntheticClusterIpiEx hypercall */
+struct hv_send_ipi_ex {
+	u32 vector;
+	u32 reserved;
+	struct hv_vpset vp_set;
+} __packed;
+
+/* HvFlushGuestPhysicalAddressSpace hypercalls */
+struct hv_guest_mapping_flush {
+	u64 address_space;
+	u64 flags;
+} __packed;
+
+/*
+ *  HV_MAX_FLUSH_PAGES = "additional_pages" + 1. It's limited
+ *  by the bitwidth of "additional_pages" in union hv_gpa_page_range.
+ */
+#define HV_MAX_FLUSH_PAGES (2048)
+
+/* HvFlushGuestPhysicalAddressList hypercall */
+union hv_gpa_page_range {
+	u64 address_space;
+	struct {
+		u64 additional_pages:11;
+		u64 largepage:1;
+		u64 basepfn:52;
+	} page;
+};
+
+/*
+ * All input flush parameters should be in single page. The max flush
+ * count is equal with how many entries of union hv_gpa_page_range can
+ * be populated into the input parameter page.
+ */
+#define HV_MAX_FLUSH_REP_COUNT ((HV_HYP_PAGE_SIZE - 2 * sizeof(u64)) /	\
+				sizeof(union hv_gpa_page_range))
+
+struct hv_guest_mapping_flush_list {
+	u64 address_space;
+	u64 flags;
+	union hv_gpa_page_range gpa_list[HV_MAX_FLUSH_REP_COUNT];
+};
+
+/* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
+struct hv_tlb_flush {
+	u64 address_space;
+	u64 flags;
+	u64 processor_mask;
+	u64 gva_list[];
+} __packed;
+
+/* HvFlushVirtualAddressSpaceEx, HvFlushVirtualAddressListEx hypercalls */
+struct hv_tlb_flush_ex {
+	u64 address_space;
+	u64 flags;
+	struct hv_vpset hv_vp_set;
+	u64 gva_list[];
+} __packed;
+
+/* HvRetargetDeviceInterrupt hypercall */
+union hv_msi_entry {
+	u64 as_uint64;
+	struct {
+		u32 address;
+		u32 data;
+	} __packed;
+};
+
+struct hv_interrupt_entry {
+	u32 source;			/* 1 for MSI(-X) */
+	u32 reserved1;
+	union hv_msi_entry msi_entry;
+} __packed;
+
+/*
+ * flags for hv_device_interrupt_target.flags
+ */
+#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
+#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
+
+struct hv_device_interrupt_target {
+	u32 vector;
+	u32 flags;
+	union {
+		u64 vp_mask;
+		struct hv_vpset vp_set;
+	};
+} __packed;
+
+struct hv_retarget_device_interrupt {
+	u64 partition_id;		/* use "self" */
+	u64 device_id;
+	struct hv_interrupt_entry int_entry;
+	u64 reserved2;
+	struct hv_device_interrupt_target int_target;
+} __packed __aligned(8);
+
+#endif
-- 
2.18.2

