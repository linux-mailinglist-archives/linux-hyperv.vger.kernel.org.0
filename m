Return-Path: <linux-hyperv+bounces-555-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5067CF00B
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Oct 2023 08:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2691C20826
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Oct 2023 06:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6B4611A;
	Thu, 19 Oct 2023 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hMyh9KIs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92072186C
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Oct 2023 06:21:44 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0400BE;
	Wed, 18 Oct 2023 23:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQRxoSVuoImzcCwcMByn/+lNnMYKmDFNImBotiCN4PNpYrXtjRmYrxG0pIW1qQt9e+rONjjWxbpWYfcqCcV//bUYzmxTjFBlefn2lmbsHyNYs+ysBJ/2A14su9UGeWYjaItQbdfDNBwyG1hcSbaAKzClEgfpl3rVgjVNSVoNMKz6752Gz2p6455nWEBa8udXP2Y/ifX3ajxBtcZZMQ36edLDt9wqWy6DU+GYff1TwC+CjBtH1zRiFGxU42PwuisBLxCLwlqfCqPq6qSjLVOyqL1BAiuEyWDyw9j0VJdsSeDU3Y9EVaoSa6iTfehzoFQz7oJsl7+sqWxGWDg/s1lUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpzY42v5Gx1+WSR8S0vCPRCDKHw2V2lwiJ+WjgqhPnw=;
 b=iRSVH3LR8oQPTLUeStCX15QTNcstCoOC5fAQhNwEoN2d8CjWjpPPCdQIAS47975kNOPPMFd8C15nJjj7N7kf79RhtQA35YJMMnLOj9dEasZKQ0n+nb6PFD5443kds1+9B8BABOuDKU9j4y7/u9XNu529CkTi6j9551Lj3/Fbs6Hja/OF3aY9kq/Z7w+j4kab8OFHhdDPQNXdiJnVWz+QNji9kp+GFh/D12rSqH55R6kDqmXKJSeUPq15gJ1xy2ZupGKas4KrVWMGMJQF3DbMPL7S4eeMQYKGkXQkXvCprrrW1+vpv9QnEzI89OOC3P+25FFlCg5k9UTcPCmKhSMzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpzY42v5Gx1+WSR8S0vCPRCDKHw2V2lwiJ+WjgqhPnw=;
 b=hMyh9KIs3mGi7Sd5fVKnYACob08HfWZifbt9UY8QFBDs/XoGvH+fcCjwwGwyiITjP/2WQroPkH5+bxjW8XHEIRFCoIZNqXgRkzf4xmvWg8dDxCDHhA/zXJ3QVj9jGd6C6hMWLpsW2T1yAxFVDGJ9oQE9TuAQdZ8Asy5A50fTO6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SA3PR21MB3915.namprd21.prod.outlook.com (2603:10b6:806:300::22)
 by PH7PR21MB3118.namprd21.prod.outlook.com (2603:10b6:510:1d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.4; Thu, 19 Oct
 2023 06:21:39 +0000
Received: from SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::f02:b965:d44e:40d]) by SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::f02:b965:d44e:40d%6]) with mapi id 15.20.6933.003; Thu, 19 Oct 2023
 06:21:39 +0000
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	stefan.bader@canonical.com,
	tim.gardner@canonical.com,
	roxana.nicolescu@canonical.com,
	cascardo@canonical.com,
	mikelley@microsoft.com,
	jgross@suse.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	kirill.shutemov@linux.intel.com,
	sashal@kernel.org,
	matija.glavinic-pecotic.ext@nokia.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] x86/mm: Print the encryption features correctly when a paravisor is present
Date: Wed, 18 Oct 2023 23:20:30 -0700
Message-Id: <20231019062030.3206-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:303:b7::14) To SA3PR21MB3915.namprd21.prod.outlook.com
 (2603:10b6:806:300::22)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR21MB3915:EE_|PH7PR21MB3118:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bfb691-0717-4ec6-22ec-08dbd06ba73b
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 XoDJSNrIzBEFcDv9m8MoseEmr0xL067uj/l3pvLZWUfeniHUSQp2kxYtc60Yc5Uo/9AWP40WN/q19UJ9gFt1KOF8Z+TcBFjN/OaCbOfiOSQsD/7X9pt7LoxzhP1RY0qGqESjOHoI8ZbzJHq6Kt5DvZDfiqWYcsFHVtxwf4H/QeyLQJCbCG/7zZ4C7Gtm0O5/r9YVyE4IGpvoD87dkq/6b4zzNt3Q0Avttrzw8cPAyD1zFV3aUZ47894PmwbHCvppWKapFRg9uoO1CvrGufQREpRmWY9FBgQMXFU/lEGRrnAlNyc28359wTowUGade4Zd8Mt1EDg8+VKkhFgYLolLSpZOANHDVTHppIGCZ0qVHHFdA8Iq19l4cYL5IlKRBjN4NAmdtwFAMjjLriiAqO1zB4SsuXuzdM6Ed+GGtWT0RtS3JWhl7vV9CcbeMucw/VBnHl3UVc4BMvxPAQVSAaBtfkDCMs7vYob9nMQDYCfWXSEKZ0xVHREvp0ToiUHYGBcVn07IZxn3hMu2jYfFgiORqPfclFnAmEDp7DoAJBLvhFUocAZt0+7NOH6gD5quUcuu9ec6wIjSf40wu7Ik5YzRrZLdhy+l/Sk4UaAyP5HQ4Z1+uFhmmsDX9UMITQywkETMnZBhyTaTIxFr5xtLdjEHmw==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3915.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(1700900044)(7416002)(6506007)(52116002)(2906002)(6666004)(10290500003)(6486002)(478600001)(4326008)(8676002)(5660300002)(8936002)(66556008)(316002)(66946007)(66476007)(41300700001)(36756003)(83380400001)(82950400001)(82960400001)(921005)(107886003)(2616005)(6512007)(86362001)(38100700002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?B9+DS0QLttk3OjBKgWMlO8gTh66WcYePKRq/H2lrslMRWI04zq4339IhbJsO?=
 =?us-ascii?Q?Y12jmf86hTPXpC/GinCh/3l+UshOlfWgxWiN/OM7CneCfIivNlbYv7M2qXXC?=
 =?us-ascii?Q?XuPXzjMN1rbiSp0mP58ofETRkNNeUzvyowaqGpQpRQM5XJa156R3DOTGGoAt?=
 =?us-ascii?Q?6pMzQ9QsdXJ2x0DwZw9wPKMTWDrFTl3LVTge+VtFISXF9OvSIdTJObdrNDqT?=
 =?us-ascii?Q?Va927bvjjZrt/91e2eJLLLWcbrH7N+P54qSW/Qo8S3EVVDkyavHj9FKtnrzS?=
 =?us-ascii?Q?xGmTFt7Dhp0xaUAKiddi8KIWoMiULKxOHoWnmGK93dEYFJAF95DbMrWIL8rP?=
 =?us-ascii?Q?unvppeKpW/Bm5NCaE26Xy3Hv9GZ5Ttsg/PoVWnQXVuFs8V4H9QOup8dhwKev?=
 =?us-ascii?Q?R0HfXcmChB3PknxRiEnTgl5ld44CSib/VqBCO2UXR7TXmw0Eiiq30YxygeIa?=
 =?us-ascii?Q?PZI1ukIxfKiYQUHGj0e5iX5R7nicJMqvP/zDsLCa8jzOChHkfPOs/8pfYpMc?=
 =?us-ascii?Q?MGTxgY9TzZI2tFac2xu7V5uaP/n24zLnFufxPs+ZxofmeM00pNVafx1/pw0E?=
 =?us-ascii?Q?YwqOoa2yFd7IxmjqiEsfM4XwJh/ROd5Q7i8y4t4G7+Ys6OX1BZmVCCaoX61X?=
 =?us-ascii?Q?ua9IQ0GDWvVZF6ssxePhqB2UE3wOzNh0QT62aOmdS5bdrxxN05Guycx2bX6s?=
 =?us-ascii?Q?PVFuRIUob6b//mXStY1YYCjY96DBSrjRg943olTVTpP/XOGI8eyfXMKKV5x6?=
 =?us-ascii?Q?juqjFqphTGxGz7iyDVzy4hUZ75WbpAfAQaYOwdcSLJmrPznrEBLGGOoyFJuh?=
 =?us-ascii?Q?AA/bnGHaoVOR4wt1pho/PhKPJ0pSRqRJZI2Zi1I4dL5LGXfnJDT+VO2pGX7l?=
 =?us-ascii?Q?lD7BAMUsWI2bCOs0WXCMyOxIOJbpLpQjw5RH/aJ8vtQjrYl6foQv0JZBbW3O?=
 =?us-ascii?Q?NLDzL+Z+b6tAdwCB2ynVBPmHkpn7OC2bRdvVfaCpFw2KGN9O7LFvQDe8/2zr?=
 =?us-ascii?Q?IT6hYleFP2QUv/JfjVzYpM6eoyo5nIzoqVZEKZwVKIz3c1sDMscxnkQY8Uw2?=
 =?us-ascii?Q?ktfhv61V3trByfyrRfQWNjKlzxbgfjuJIzY+UsNHGYpEWCO6qf+N2d3DS//a?=
 =?us-ascii?Q?4FDbwAEf4sE33SOsCmjPuwRaftxrynyrP3IQhq+89VtGvYqe5Y+djXtZ4FuK?=
 =?us-ascii?Q?7yntp223jw1WTHXogWgzYRkaIYoz/oHN+mgIMpCh+6x/Kvc/u7ZtWDLXQJcv?=
 =?us-ascii?Q?dMmvkuqypXlgYL5H8NPvNVXym2NmKut8thh9/HkmTcecyJHLAzfGnflbT0nv?=
 =?us-ascii?Q?Rue3+CbB9H0Lj0HPdwafsQId9lhvdqexMkuYdluZVVBOHIXW0wnSO1SwA9gp?=
 =?us-ascii?Q?4zOvZah9vzXJFLikCg4Ln9CVttwyEmceeMdKG4pMM4aNxZfFBhUlCObmtntX?=
 =?us-ascii?Q?oevXHsroa2XIqm8sITteuv6gux9jGlzunRxBaYHDXd40cYEmcZyGa6WCk1MD?=
 =?us-ascii?Q?5dqeF41FttWwfHst78UgHXGeutdSMvVQZ8JcMqaUhcD9MichnDlnykunM0Ux?=
 =?us-ascii?Q?8vyax/l7KjscxiKgmRl67ex103m9jJHHnhkkXEDdQu9ZJmipD5RJbn4TT2VB?=
 =?us-ascii?Q?JOBmTuUo3MjsoDFkLv8zB8KR1wOIJ9d/5rpJZ+7tH6k6?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bfb691-0717-4ec6-22ec-08dbd06ba73b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3915.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:21:39.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPjYe38Wh8AhxCrjwA7VOUo5AWYf6J8qkH6ymGpYZO/yF4dN6u63kkfK+3Ij7TUQE1Lo5bhMohHq5ezZLFj5Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3118

Hyper-V provides two modes for running a TDX/SNP VM:

1) In TD Partitioning mode (TDX) or vTOM mode (SNP) with a paravisor;
2) In "fully enlightened" mode with the normal TDX shared bit or SNP C-bit
   control over page encryption, and no paravisor.

In the first mode (i.e. paravisor mode), the native TDX/SNP CPUID
capability is hidden from the VM, but cc_platform_has(CC_ATTR_MEM_ENCRYPT)
and cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) are true; as a result,
mem_encrypt_init() incorrectly prints the below message when an Intel TDX
VM with a paravisor runs on Hyper-V:
"Memory Encryption Features active: AMD SEV".

Introduce x86_platform.print_mem_enc_feature_info and allow hv_vtom_init()
to override the function pointer so that the correct message is printed.

BTW, when a VBS (Virtualization-based Security) VM running on Hyper-V
(the physical CPU can be an AMD CPU or an Intel CPU), the VM's memory is
not encrypted, but mem_encrypt_init() also prints the same incorrect
message. The introduction of x86_platform.print_mem_enc_feature_info can
also fix the issue.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Some open questions:

1. Should we refactor the existing print_memory_encrypt_feature_info()
into a TDX-specific function and an SEV-specific function?  The
function pointer in x86_platform_ops would be initialized to a no-op
function, and then early_tdx_init(), sme_enable() and hv_vtom_init()
would fill it in accordingly.

2. Should we rename "print_mem_enc_feature_info()" to
"print_coco_feature_info()"?  CC_ATTR_GUEST_STATE_ENCRYPT (and
CC_ATTR_GUEST_SEV_SNP?) may not look like *memory* encryption to me?

 arch/x86/hyperv/ivm.c              | 11 +++++++++++
 arch/x86/include/asm/mem_encrypt.h |  1 +
 arch/x86/include/asm/x86_init.h    |  2 ++
 arch/x86/kernel/x86_init.c         |  1 +
 arch/x86/mm/mem_encrypt.c          |  4 ++--
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index e68051eba25a..fdc2fab0415e 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -450,6 +450,16 @@ static bool hv_is_private_mmio(u64 addr)
 	return false;
 }
 
+static void hv_print_mem_enc_feature_info(void)
+{
+	enum hv_isolation_type type = hv_get_isolation_type();
+
+	if (type == HV_ISOLATION_TYPE_SNP)
+		pr_info("Memory Encryption Features active: AMD SEV\n");
+	else if (type == HV_ISOLATION_TYPE_TDX)
+		pr_info("Memory Encryption Features active: Intel TDX\n");
+}
+
 void __init hv_vtom_init(void)
 {
 	enum hv_isolation_type type = hv_get_isolation_type();
@@ -479,6 +489,7 @@ void __init hv_vtom_init(void)
 	cc_set_mask(ms_hyperv.shared_gpa_boundary);
 	physical_mask &= ms_hyperv.shared_gpa_boundary - 1;
 
+	x86_platform.print_mem_enc_feature_info = hv_print_mem_enc_feature_info;
 	x86_platform.hyper.is_private_mmio = hv_is_private_mmio;
 	x86_platform.guest.enc_cache_flush_required = hv_vtom_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 7f97a8a97e24..6e8050a9138e 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -19,6 +19,7 @@
 
 #ifdef CONFIG_X86_MEM_ENCRYPT
 void __init mem_encrypt_init(void);
+void print_mem_encrypt_feature_info(void);
 #else
 static inline void mem_encrypt_init(void) { }
 #endif
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 14b0562c1d8b..7798174d4b8d 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -291,6 +291,7 @@ struct x86_hyper_runtime {
  * 				semantics.
  * @realmode_reserve:		reserve memory for realmode trampoline
  * @realmode_init:		initialize realmode trampoline
+ * @print_mem_enc_feature_info:	print the supported memory encryption features
  * @hyper:			x86 hypervisor specific runtime callbacks
  */
 struct x86_platform_ops {
@@ -309,6 +310,7 @@ struct x86_platform_ops {
 	void (*set_legacy_features)(void);
 	void (*realmode_reserve)(void);
 	void (*realmode_init)(void);
+	void (*print_mem_enc_feature_info)(void);
 	struct x86_hyper_runtime hyper;
 	struct x86_guest guest;
 };
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 6117662ae4e6..ccb53db1b51e 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -149,6 +149,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 	.restore_sched_clock_state	= tsc_restore_sched_clock_state,
 	.realmode_reserve		= reserve_real_mode,
 	.realmode_init			= init_real_mode,
+	.print_mem_enc_feature_info	= print_mem_encrypt_feature_info,
 	.hyper.pin_vcpu			= x86_op_int_noop,
 	.hyper.is_private_mmio		= is_private_mmio_noop,
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9f27e14e185f..8d37048bc1df 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -39,7 +39,7 @@ bool force_dma_unencrypted(struct device *dev)
 	return false;
 }
 
-static void print_mem_encrypt_feature_info(void)
+void print_mem_encrypt_feature_info(void)
 {
 	pr_info("Memory Encryption Features active:");
 
@@ -84,5 +84,5 @@ void __init mem_encrypt_init(void)
 	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
 	swiotlb_update_mem_attributes();
 
-	print_mem_encrypt_feature_info();
+	x86_platform.print_mem_enc_feature_info();
 }
-- 
2.25.1


