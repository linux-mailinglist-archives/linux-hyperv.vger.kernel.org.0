Return-Path: <linux-hyperv+bounces-349-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4DF7B39F1
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 20:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 56490281242
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E545F66693;
	Fri, 29 Sep 2023 18:20:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294E6666A
	for <linux-hyperv@vger.kernel.org>; Fri, 29 Sep 2023 18:20:36 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020024.outbound.protection.outlook.com [52.101.61.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852561B6;
	Fri, 29 Sep 2023 11:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+68mP4K5AlfZAcx4OLfdGPfBJhD4vqYR7BcGGptnuk2gTKIxHMF41Xol72Z59yHGfXaZbfa+einXd7Qe5BsVP/NvExgJWu9tmqzUISPuOUGbsrwNvFQk9anPXJoPpxKA+0y6WDlPoT33GRvyFyRTu1k2QAFFgbrQD27Htd1TZJEe3TP9c95j/qMlT/UHUtPbKLQsc9KglGaa36O2wFmut6NX1ikmfLyuEvg3Hbqicw+3dYAsa4XPXdY1SzuPh/8x44gbr7xIjl60G9o2dvDFTyj4Crzs3HLvNB4hQHyIUqfEY3QI+mB1jGOa2BKGIwjmnwSVJ/yoEjPg6XFnYL18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVtMPBDElysEOjbegf4nL2dYZfzxFly9Up4BTuDtAyo=;
 b=FG/pIe+y/a3BbzyJ60nuI/fYGVnB/ccrFGTg3n519bLDDxQg+CQxmGrY3kJ75jQLblB5gM0B4d88qUS1SyM3PKdE92PNE9kRZkg5IVdT9kfUysUJWeOcOIOzwUFfy9hWbt6BgfSrJx2qTpjmw0L7L9xfLGbWLz/bPg1uKQxwfGHseUIhwbSI+/W/IyWCCea1GKUGHVk/CtLD5MN6R/GMC2HuCLNq4Pwf1wsgySwHdKlKUBd9eBWrtObrWtwo80a/7tpKYwzH/WSt0V6X/5NLT8b532EPEY4Njae5NuQvORSHPoJy67wD78ZxTmQA6UydO3Y29Nz/mUUHiX+UQ6YOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVtMPBDElysEOjbegf4nL2dYZfzxFly9Up4BTuDtAyo=;
 b=d9MRSlPQHcSMP72CycbFZecKCHZCiiO21mozluRZPm17Pd5acDTFGmRr8RnNUCAifEBVZuX3vBFVSBFauqqKdi6sdN+9Tqv+Ih59zXmlf93He/Y5F2UGCE17Hv5M/hY40H13rAZs5bPcyIIkHP2bhcfLC5qQwtmRFAb2R7Nbd7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BL1PR21MB3377.namprd21.prod.outlook.com (2603:10b6:208:39d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.14; Fri, 29 Sep
 2023 18:20:26 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44%4]) with mapi id 15.20.6863.013; Fri, 29 Sep 2023
 18:20:26 +0000
From: Michael Kelley <mikelley@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	thomas.lendacky@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	kirill.shutemov@linux.intel.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	x86@kernel.org
Cc: mikelley@microsoft.com
Subject: [PATCH 3/5] x86/mm: Mark CoCo VM pages not present while changing encrypted state
Date: Fri, 29 Sep 2023 11:19:07 -0700
Message-Id: <1696011549-28036-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696011549-28036-1-git-send-email-mikelley@microsoft.com>
References: <1696011549-28036-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR22CA0048.namprd22.prod.outlook.com
 (2603:10b6:930:1d::29) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|BL1PR21MB3377:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a16ca76-b309-46be-6291-08dbc118c0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QfCyQXzBLif9q3mrD4aro364Ker/qXf/g/+GzRbSpZbigwIzBiBxaexYQk985Fe0FRluu/598+zCs1GDR41CCnNGvwKrOwiwZfVngIKH7xvzmEbMzhhqcY6Gva5qwGnkNhi1Z9mSJFGTwuR5kuBQoY9TRkIwp0eCj4tyQ6Uu0QNAhrFjKafLXbtnO43uAIDZ6VmZAGdoxF4fBjsOjFPcCT6UjZWP/iDfi+Am0Qv564gsvTmBm3G4Y30PwonjoU/+5kM+FNwHkwdWOxuEqIKLNo+ojXXdOsZTynwaW++GGEJJECTez5XZrIXGoqerCLNnXEdJy9/Z4qRG5UGSMIk6nWDoYLnUYw7wnaWVc1duUOgJmy7KSvqIHb8L4qVwF0SKfl0ubqb18RBe0rmKS2wY1HiCJiB/NiU8O65wT9gG7sulVuCvhwSBKUIr6r2xxGknPBlWVCPH0nJmfcff7tYGiwYQHPNKDm/FN+n4RR6u66uDH6jgDAnSjdwNoiZ9v9nYFHpWdJhalv2Bo3vBcvJrY342ixK4JATWynTYctsvca3K047Q7PVt/nyZoTwZIUC87d0G73753vR8zjLJBnil+9ODXm9lhlmSuV7vyjWGqHw1J3Hzp16s7uRpZDLutNHhM4dBoWy+3VxQxKI7iShCDVG28UvZkVk6HDg6dfXIvl8xwz+MeSAb6WeMlf8bSqe2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(41300700001)(6506007)(6512007)(6486002)(52116002)(478600001)(6666004)(2616005)(2906002)(316002)(66946007)(66556008)(66476007)(5660300002)(107886003)(10290500003)(8676002)(8936002)(4326008)(26005)(30864003)(7416002)(921005)(82950400001)(82960400001)(36756003)(86362001)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nEkBE0ET302MVTzYfRMOgyEaKMh7dwjgaL5k5iVUnUnPSARCcJyM4rce5Sj+?=
 =?us-ascii?Q?HWtY2fJU+Fqb9ZpE+eu2RxmmyLHRiPSM0bdZ0vUU7EtnA0GOrwmGvYCFyhYM?=
 =?us-ascii?Q?UiFqaSxlczcUJrUCm+TqBOhYIkUIHn5tsr/HV8s5gNQS7hbS4xgxdyL6vZ1y?=
 =?us-ascii?Q?55cov4yp0hYvMkfMh9X12/lafa4QQccPmQhSw6HbMWD+ORxTGG5QHp/73G+k?=
 =?us-ascii?Q?zgEnbHvoGN1wugQHj1q7GZjlBfu/IwQbhNxqmnrCp497Nn6Q5u1Nf0+0xb9R?=
 =?us-ascii?Q?NkQEH0biBRWikO6G44WuY5s+DEXnYoyHll3pDSkyp83SYNzhEeLM8RXbdLQJ?=
 =?us-ascii?Q?hsDn5VHP9G2hoycQxh/Ktym7zXY8q6FdNtxAlHSm9/mQfRl3CZhywSnZ/FVC?=
 =?us-ascii?Q?9NL5jkEuQuTH9LrLVXMAZuX3h9Tl1d0MSNdHV+/MdZsemVjD04PiuPkZpkGU?=
 =?us-ascii?Q?v1lYuK3nOehdtp+pf3bUVF+7rHbR4g49mVV0gj19LSfJsbQn9VSxIUZQQ1yP?=
 =?us-ascii?Q?5Ji/68mhDHgcuNVHy2fRdyTLsyArXEGb7+AcjV3fzeJHz0rblrMaRBh462R4?=
 =?us-ascii?Q?uiPMGnkCuLlpNXXczD9WVlt4JRXPccNwaw+o2tRHEsnvtHVrAR71258vKhBv?=
 =?us-ascii?Q?l2LNpuVryR4fZ9onf4V0iVh7eZ88fBDkLHvfKAIeY+IQMRAaVppq4ZW29Bee?=
 =?us-ascii?Q?/FYoMYz/cBbZIJlgH4tqXVMp/YQxzyr2sPEegOMi3wHkTZvVAjtLj8Weg6/N?=
 =?us-ascii?Q?I90S1Xnl+CMYcFJ2m0h8bjUvpfWNolXlOPMOqVE+7uJ7zI8M1Aup0ZXBGkxH?=
 =?us-ascii?Q?nHTz1o+8p5gfFzFx+4yYlMNz2TCTyrHc3OKp1rj7MC8y74UokFKR7X5ioRQl?=
 =?us-ascii?Q?j979fg9noEoBQpDccpGmEOty9MMT2BIGD7a7Da195G5PMmtT5sFUSU3Ed3/8?=
 =?us-ascii?Q?E2xvEMAKPfN7nvIzmlUPhknG7joycyqtSA8kiACIuvvZklhbWxUgfT/ugjx6?=
 =?us-ascii?Q?+5PwXw5Kl968hv5wd93rUiDEE/7dRws7OVB8H7YZkR4yffsgi2oNCs+rV16c?=
 =?us-ascii?Q?FOCB6cTesVWRAWsizWWN6psU2NGJxd+5GQA4qwj+dPpGYDKuPwvrPuMhowOq?=
 =?us-ascii?Q?3cJVRM40kJTT+8b05weDsNnCYl8poMLrm2tISim16Fh91czJpi5LDAYsODXY?=
 =?us-ascii?Q?iMsgHyaOVqoLjLOavvzjMBMNv9KOBkNH/HsiZpKMQuyp/S0285A6tkvf+dc8?=
 =?us-ascii?Q?UaSkRcaOgkyAxGVGqovtthSw7W9b2nNCVk3bA2aLVVYCTHok5PjJMxCbj+Vg?=
 =?us-ascii?Q?meR7JzCLT0L52ihVk4yOueMcWbV67KsWgShRp4wRlxWDTFG0rFBz/6h94P8J?=
 =?us-ascii?Q?ffFwpT8ruVypgtFJ5a/q1dgB2aH1mKfSu1idJCKK2El54bS1I/N8FeeUgbnm?=
 =?us-ascii?Q?SLOLyQ+5JObTIQBNmPHOKw+40Z4vo6mAc/4feagbmLRbgmTiV3rwPvcF1OgB?=
 =?us-ascii?Q?XNfk+fBLpcPU95NeUfLWbsJpbwGnjEwwPjuD88qWpy0UWv69igMpYTaeN/Ft?=
 =?us-ascii?Q?n15X5ZYw/sRzJV3gQN5MA+EPewY6UkRRnUC8CJE0qaSHSAwGaHUZQe5U0REC?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a16ca76-b309-46be-6291-08dbc118c0d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:20:26.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJuXp4PzvWMsL1PlchP/ZWqkxFIvDVHtT8GeLLjtsDXFQMRSi/d1kvT0yFg8XBme0xstNlDYXiagjQHXtJTVEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3377
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In a CoCo VM when a page transitions from encrypted to decrypted, or vice
versa, attributes in the PTE must be updated *and* the hypervisor must
be notified of the change. Because there are two separate steps, there's
a window where the settings are inconsistent.  Normally the code that
initiates the transition (via set_memory_decrypted() or
set_memory_encrypted()) ensures that the memory is not being accessed
during a transition, so the window of inconsistency is not a problem.
However, the load_unaligned_zeropad() function can read arbitrary memory
pages at arbitrary times, which could access a transitioning page during
the window.  In such a case, CoCo VM specific exceptions are taken
(depending on the CoCo architecture in use).  Current code in those
exception handlers recovers and does "fixup" on the result returned by
load_unaligned_zeropad().  Unfortunately, this exception handling can't
work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode).
The exceptions need to be forwarded from the paravisor to the Linux
guest, but there are no architectural specs for how to do that.

Fortunately, there's a simpler way to solve the problem by changing
the core transition code in __set_memory_enc_pgtable() to do the
following:

1.  Remove aliasing mappings
2.  Flush the data cache if needed
3.  Remove the PRESENT bit from the PTEs of all transitioning pages
4.  Set/clear the encryption attribute as appropriate
5.  Flush the TLB so the changed encryption attribute isn't visible
6.  Notify the hypervisor of the encryption status change
7.  Add back the PRESENT bit, making the changed attribute visible

With this approach, load_unaligned_zeropad() just takes its normal
page-fault-based fixup path if it touches a page that is transitioning.
As a result, load_unaligned_zeropad() and CoCo VM page transitioning
are completely decoupled.  CoCo VM page transitions can proceed
without needing to handle architecture-specific exceptions and fix
things up. This decoupling reduces the complexity due to separate
TDX and SEV-SNP fixup paths, and gives more freedom to revise and
introduce new capabilities in future versions of the TDX and SEV-SNP
architectures. Paravisor scenarios work properly without needing
to forward exceptions.

With this approach, the order of updating the guest PTEs and
notifying the hypervisor doesn't matter. As such, only a single
hypervisor callback is needed, rather one before and one after
the PTE update. Simplify the code by eliminating the extra
hypervisor callback along with the TDX and SEV-SNP code that
handles the before and after cases. The TLB flush callback is
also no longer required and is removed.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/coco/tdx/tdx.c       | 66 +------------------------------------------
 arch/x86/hyperv/ivm.c         |  6 ----
 arch/x86/kernel/x86_init.c    |  4 ---
 arch/x86/mm/mem_encrypt_amd.c | 27 ++++--------------
 arch/x86/mm/pat/set_memory.c  | 55 +++++++++++++++++++++++-------------
 5 files changed, 43 insertions(+), 115 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3e6dbd2..1bb2fff 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -676,24 +676,6 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 	return true;
 }
 
-static bool tdx_tlb_flush_required(bool private)
-{
-	/*
-	 * TDX guest is responsible for flushing TLB on private->shared
-	 * transition. VMM is responsible for flushing on shared->private.
-	 *
-	 * The VMM _can't_ flush private addresses as it can't generate PAs
-	 * with the guest's HKID.  Shared memory isn't subject to integrity
-	 * checking, i.e. the VMM doesn't need to flush for its own protection.
-	 *
-	 * There's no need to flush when converting from shared to private,
-	 * as flushing is the VMM's responsibility in this case, e.g. it must
-	 * flush to avoid integrity failures in the face of a buggy or
-	 * malicious guest.
-	 */
-	return !private;
-}
-
 static bool tdx_cache_flush_required(void)
 {
 	/*
@@ -776,30 +758,6 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
-static bool tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
-					  bool enc)
-{
-	/*
-	 * Only handle shared->private conversion here.
-	 * See the comment in tdx_early_init().
-	 */
-	if (enc)
-		return tdx_enc_status_changed(vaddr, numpages, enc);
-	return true;
-}
-
-static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
-					 bool enc)
-{
-	/*
-	 * Only handle private->shared conversion here.
-	 * See the comment in tdx_early_init().
-	 */
-	if (!enc)
-		return tdx_enc_status_changed(vaddr, numpages, enc);
-	return true;
-}
-
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -831,30 +789,8 @@ void __init tdx_early_init(void)
 	 */
 	physical_mask &= cc_mask - 1;
 
-	/*
-	 * The kernel mapping should match the TDX metadata for the page.
-	 * load_unaligned_zeropad() can touch memory *adjacent* to that which is
-	 * owned by the caller and can catch even _momentary_ mismatches.  Bad
-	 * things happen on mismatch:
-	 *
-	 *   - Private mapping => Shared Page  == Guest shutdown
-         *   - Shared mapping  => Private Page == Recoverable #VE
-	 *
-	 * guest.enc_status_change_prepare() converts the page from
-	 * shared=>private before the mapping becomes private.
-	 *
-	 * guest.enc_status_change_finish() converts the page from
-	 * private=>shared after the mapping becomes private.
-	 *
-	 * In both cases there is a temporary shared mapping to a private page,
-	 * which can result in a #VE.  But, there is never a private mapping to
-	 * a shared page.
-	 */
-	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
-	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
-
+	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_changed;
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
-	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 084fab6..fbe2585 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -550,11 +550,6 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 	return result;
 }
 
-static bool hv_vtom_tlb_flush_required(bool private)
-{
-	return true;
-}
-
 static bool hv_vtom_cache_flush_required(void)
 {
 	return false;
@@ -614,7 +609,6 @@ void __init hv_vtom_init(void)
 
 	x86_platform.hyper.is_private_mmio = hv_is_private_mmio;
 	x86_platform.guest.enc_cache_flush_required = hv_vtom_cache_flush_required;
-	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
 	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
 
 	/* Set WB as the default cache mode. */
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a37ebd3..cf5179b 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -131,9 +131,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
 
 static void default_nmi_init(void) { };
 
-static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
 static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
-static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
@@ -154,9 +152,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 	.hyper.is_private_mmio		= is_private_mmio_noop,
 
 	.guest = {
-		.enc_status_change_prepare = enc_status_change_prepare_noop,
 		.enc_status_change_finish  = enc_status_change_finish_noop,
-		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
 	},
 };
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 6faea41..06960ba 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -278,11 +278,6 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 	return pfn;
 }
 
-static bool amd_enc_tlb_flush_required(bool enc)
-{
-	return true;
-}
-
 static bool amd_enc_cache_flush_required(void)
 {
 	return !cpu_feature_enabled(X86_FEATURE_SME_COHERENT);
@@ -318,18 +313,6 @@ static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
 #endif
 }
 
-static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
-{
-	/*
-	 * To maintain the security guarantees of SEV-SNP guests, make sure
-	 * to invalidate the memory before encryption attribute is cleared.
-	 */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
-		snp_set_memory_shared(vaddr, npages);
-
-	return true;
-}
-
 /* Return true unconditionally: return value doesn't matter for the SEV side */
 static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool enc)
 {
@@ -337,8 +320,12 @@ static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool e
 	 * After memory is mapped encrypted in the page table, validate it
 	 * so that it is consistent with the page table updates.
 	 */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && enc)
-		snp_set_memory_private(vaddr, npages);
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		if (enc)
+			snp_set_memory_private(vaddr, npages);
+		else
+			snp_set_memory_shared(vaddr, npages);
+	}
 
 	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
@@ -498,9 +485,7 @@ void __init sme_early_init(void)
 	/* Update the protection map with memory encryption mask */
 	add_encrypt_protection_map();
 
-	x86_platform.guest.enc_status_change_prepare = amd_enc_status_change_prepare;
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
-	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
 
 	/*
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d7ef8d3..d062e01 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2147,40 +2147,57 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
+
+	/*
+	 * The caller must ensure that the memory being transitioned between
+	 * encrypted and decrypted is not being accessed.  But if
+	 * load_unaligned_zeropad() touches the "next" page, it may generate a
+	 * read access the caller has no control over. To ensure such accesses
+	 * cause a normal page fault for the load_unaligned_zeropad() handler,
+	 * mark the pages not present until the transition is complete.  We
+	 * don't want a #VE or #VC fault due to a mismatch in the memory
+	 * encryption status, since paravisor configurations can't cleanly do
+	 * the load_unaligned_zeropad() handling in the paravisor.
+	 *
+	 * There's no requirement to do so, but for efficiency we can clear
+	 * _PAGE_PRESENT and set/clr encryption attr as a single operation.
+	 */
 	cpa.mask_set = enc ? pgprot_encrypted(empty) : pgprot_decrypted(empty);
-	cpa.mask_clr = enc ? pgprot_decrypted(empty) : pgprot_encrypted(empty);
+	cpa.mask_clr = enc ? pgprot_decrypted(__pgprot(_PAGE_PRESENT)) :
+				pgprot_encrypted(__pgprot(_PAGE_PRESENT));
 	cpa.pgd = init_mm.pgd;
 
 	/* Must avoid aliasing mappings in the highmem code */
 	kmap_flush_unused();
 	vm_unmap_aliases();
 
-	/* Flush the caches as needed before changing the encryption attribute. */
-	if (x86_platform.guest.enc_tlb_flush_required(enc))
-		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
-
-	/* Notify hypervisor that we are about to set/clr encryption attribute. */
-	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
-		return -EIO;
+	/* Flush the caches as needed before changing the encryption attr. */
+	if (x86_platform.guest.enc_cache_flush_required())
+		cpa_flush(&cpa, 1);
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
+	if (ret)
+		return ret;
 
 	/*
-	 * After changing the encryption attribute, we need to flush TLBs again
-	 * in case any speculative TLB caching occurred (but no need to flush
-	 * caches again).  We could just use cpa_flush_all(), but in case TLB
-	 * flushing gets optimized in the cpa_flush() path use the same logic
-	 * as above.
+	 * After clearing _PAGE_PRESENT and changing the encryption attribute,
+	 * we need to flush TLBs to ensure no further accesses to the memory can
+	 * be made with the old encryption attribute (but no need to flush caches
+	 * again).  We could just use cpa_flush_all(), but in case TLB flushing
+	 * gets optimized in the cpa_flush() path use the same logic as above.
 	 */
 	cpa_flush(&cpa, 0);
 
-	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
-	if (!ret) {
-		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
-			ret = -EIO;
-	}
+	/* Notify hypervisor that we have successfully set/clr encryption attr. */
+	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+		return -EIO;
 
-	return ret;
+	/*
+	 * Now that the hypervisor is sync'ed with the page table changes
+	 * made here, add back _PAGE_PRESENT. set_memory_p() does not flush
+	 * the TLB.
+	 */
+	return set_memory_p(&addr, numpages);
 }
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
-- 
1.8.3.1


