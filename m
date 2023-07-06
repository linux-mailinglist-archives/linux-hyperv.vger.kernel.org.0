Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434D74A261
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jul 2023 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjGFQnS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jul 2023 12:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFQnR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jul 2023 12:43:17 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFD91730;
        Thu,  6 Jul 2023 09:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPEj0fsUpECYWYq/x+w4Gxi32veJHGp3rEzwGU54fPJEeCEnHlim0h8q7oMaHptMMS3qShbINtenMdFWhrY2y+R9kkNgyH71xwihfB+zcc3yKtaeu4BFP31zd1OJUz4bwG1gtlS/o/B7UtrdBYSom2aNP4/N/egXmW2JCeoDdu+tSUUPYAaHuIkv+tgPE4MJkO/ql6GrsXJyKwICohLfcVn6ntoR+OvaJPJ8wlLHqhmMS0fRAsgNeX4i69lVNu/y/jTEITFdrTm8ZdR5WyGqW284IilQKwa9oFP9GE4M9qZsKGGnD64fzpu4TV1/uuHS4RAJV5tKUrHkn725iFMtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk55deMuYMXwixChSW2guF9Pomb7HY0h1CG+ROjwO1U=;
 b=Jf5ygpaIEAEKCp7Ilx1tGC0BtlPzRttt/UUpNz3wovJs2cvVOGIfPDA0L+PAFmoJGH5hUtlJ18jWfrpH5MJYzokNfThpP0XP2Lq6ds2SniXMep/dGNly9xEFxvIF2mOs4ZmzW7culh9ibO/gOzMYrNDHExLWRQATLxPonquN/YBCYqnreLc1PsaYG7IG4mluo+XDvo073/xc2a57rqCify2/VkeW3VuX/aNxATM3kKRKeBjzTB6wWX+cHxYZkjTYwbWubqHsS/XjDE3xVJzSaNU9j4uNS+ioABUS6oI1FIXyKtM7xWpEosQdSuTEobJAEUkuvOz2E+5px7QHYmDFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk55deMuYMXwixChSW2guF9Pomb7HY0h1CG+ROjwO1U=;
 b=ABnK8lqCETMLJZFzvvEfZBXB+vv5KX9ewcdH8AenIIaxy6116XbTulnccVX7U1UsOLrW+7dj4eW6dU6r/2jc2B04bMwbF0MxyvELYqQEQn5Mw0KYCA6hFq7/CDFJ/ulcXe0RSQRhuxSwzo7WQjDUypF9lQfnHcuXOKLENhoP9EM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SJ0PR21MB2055.namprd21.prod.outlook.com (2603:10b6:a03:399::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.12; Thu, 6 Jul
 2023 16:43:12 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::5576:62f2:72d5:7cb]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::5576:62f2:72d5:7cb%2]) with mapi id 15.20.6588.010; Thu, 6 Jul 2023
 16:43:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, thomas.lendacky@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, seanjc@google.com,
        rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, x86@kernel.org
Cc:     mikelley@microsoft.com
Subject: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving between private and shared
Date:   Thu,  6 Jul 2023 09:41:59 -0700
Message-Id: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0247.namprd15.prod.outlook.com
 (2603:10b6:930:66::22) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|SJ0PR21MB2055:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cea04e1-7d8b-45cb-7fd0-08db7e401632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMBj2ccQCeFsXXlIBCKtZy27NqXSNs9uNgbQln/LnTJHL6hTxR1UUcTvaXJULe1UZ+Knc5JgFnlT38PwS0ZjNoKazmYPsWX3ma51IUBPDOJfhFgk/z2R3R03QKCVmbAMnBdQZDc/CuQuoQec8xaqu8s8mgmpFlWpQGYsj04G59OH+ao4+GjKDWyYPIPS8tYC7/QRtS+khLU7zJA8J8qh4Jbyh50XTqfgeso7M+Um+h42SWYxYTu7Pr/Y6sN/kG8Vp9n1ECg5cPdqKoP5P8DQb+KDTbqiq+tFqHNmeteh+DLj/3PXvoZBOokCuL2PreZZxlFZaRkoUvhMOpss70Xfu4K0XU3OHc5nW5TL6ykhkSvZwsAC8EWczBVoDbspROGqqw5W4ELM7CyTny4noai33CHzpoqqhc5hlZbW7Xb5q1rqBvZZSqQXw7anVx/TY6eonRstGP63MMmCYmLSNcq0kISQbwxRs5dtyEMY1Uz4W65pm6v6CaROPz1sE2G0D0Zb+iDKYT7D8REIEJQEtbq3cyNUZZ2DeXaqiyOG3VAlFIDXizQKR9bpQrlVpyqJ0F+NW3+1OkYWkZTShZoE4juaNFVZ7D4tiq2FCnJOlDg8AxN6QWXgVhfKkGV+wzlz8+hWeFzWq2j34zFzHxwnnRlKhu+MHW7RiK/nX9wDgd74cPmmYTsY7y7DqvAR7qPVta5R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(52116002)(6486002)(6666004)(10290500003)(478600001)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(6506007)(26005)(6512007)(107886003)(921005)(38350700002)(38100700002)(82960400001)(82950400001)(4326008)(66946007)(66476007)(66556008)(41300700001)(316002)(8936002)(8676002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mnbm/HNWsOGr6FLCGlTQP7UwffcxWffY5dvQetr8hXjScR/4AZU4o2AtFyeD?=
 =?us-ascii?Q?mduEV/hfpkS6GV38zztBvFMvNcscrfkjPOO054lSfJbGHwI+i6wEL/usIJHT?=
 =?us-ascii?Q?ROjQZzfStyBUCUrmlrcoeyBc28Th4G/6MF24XEjFjKU1cbBPGweHQwqpt6bs?=
 =?us-ascii?Q?wrk8Tx8LjW9D48ZVAQUyapnO42HgUKrLCkoxKbJYOGfPiEyzdrs0spY2zGsX?=
 =?us-ascii?Q?B1vvv2FDtCJ0TeKL+c+iOztA/9JHdNZUTMH8eu2iPXL+j6sadZuEdPTT5DlS?=
 =?us-ascii?Q?yOo6blOm2/r1PM6LD/63GXdQOtGy+dSIiB0SdOrKl+26hw8A5SHuMWhFBCMR?=
 =?us-ascii?Q?AduTylumAvoWavfIstaaGo0Cg2MvTAJbSfOb5zfT/iWOtBY1sTxBJRF29FvE?=
 =?us-ascii?Q?SLJdMekgqMchFAOotAkDrIppYDAhyqUX7POkNwb1cuho8eKLZqnRxgA3mWVo?=
 =?us-ascii?Q?7t1U367obCSOkyUIkZ7Dnnyry1BkLSCZuqiPqXkXfhmlPgOLNF+duLURmjD2?=
 =?us-ascii?Q?ywnA0YPdplP1O3SJvwGq9R8zP6tM//Cf+P0c33G+TYraOiSMQEi83rNVViDV?=
 =?us-ascii?Q?tfJRH/vIflA+j6zbPOgQe4wr15FmoBHeOv+wy+EkX+ukjFLMpwnPc4VVzwTk?=
 =?us-ascii?Q?/fGBu2h0Ufwmi4awtOMepKOJbXGjztnMx4DoGOtZRqLxr1V5/X/9tQgPG55d?=
 =?us-ascii?Q?2SOhTR+9IMrmOlcs4orXhYe2EiV6coNZzrY9bbtMxe0+O76xf5R04jREh6Hp?=
 =?us-ascii?Q?9m09lioA6mTTETssQQ39EIMRGfzSwcaD8BHfsNXFT3CTcg1uG6mfbMkg8uAq?=
 =?us-ascii?Q?0i/XwTE2MNS2wtL234FfCrNNfWS1pnII/gcYHiD8DbdPQ260Ku41eJK2RKV9?=
 =?us-ascii?Q?Is2QAHXToGBYcNno8GVNDDO3I5oGKmkDJu7UOAgqmFolLfQMZaCuy51yzLuX?=
 =?us-ascii?Q?TyWSwvYKJtJ7OJfFApwC1xFWeKBaHCPkoz1UIfzNWobu/xDq58xIQFb4RokW?=
 =?us-ascii?Q?NKZ63HVrSdXbvlTA6WF/mxExtxOFntAAk4K0GymUcIb3NEUWaORxNflYtU7i?=
 =?us-ascii?Q?05Uyv/boBFxoF4bdv335KVYv3A6eqNmMQBOc6jYTRWDOgCG9+dAMp6cS9spl?=
 =?us-ascii?Q?XHwVjzP3PGQ7BLDfDQ/KUVF+T/KQm2bETcscVOfyc4sb5tcWMCUtK2BxpDjw?=
 =?us-ascii?Q?AUqXNu5fmkqGKoFbop7fXASquempvD47Aqj+ij0fwekIXE+lEL+6q6wVy/g4?=
 =?us-ascii?Q?4epCPXeluum61LKGCSScsZ+LsEMLwPaRuBayqbJeI9aO0Q0nSQcCNfVDNEg0?=
 =?us-ascii?Q?x0Q3/e1d/sQ607XdWdiMruRIgkfm6ajC+E8HOMDy/97M4nNnEPPr+QsUJyT4?=
 =?us-ascii?Q?C9iY6/AVAM9NMkYoK3DgmWR0uKMmeqUepa20heRdu+LhVlHSEEAnMQ1wNzAz?=
 =?us-ascii?Q?0bQOshHJnbJMVTrFnuelcZSnaAeE6zRHyX40HAeEzK4zlaEZc67FZH2RbU2U?=
 =?us-ascii?Q?QJQr7L7OYSTx1XB4Pr4CweCltOOGZCKz40gXOl3fnsRIyBQr2TTzIRiOvvzB?=
 =?us-ascii?Q?KEBZrDVPoqFGfz55AGbMTUKW3hviQ6FKoZq3mnle?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cea04e1-7d8b-45cb-7fd0-08db7e401632
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:43:11.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/TzrMC6sEuil+f97mGYL1gEm+v+DDj4+czavrVwhkAOkuthLCu4mBbY1Bl3unntpfeORJzlaa2AJpEej2R1MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In a CoCo VM when a page transitions from private to shared, or vice
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
load_unaligned_zeropad().  Unfortunately, this exception handling and
fixup code is tricky and somewhat fragile.  At the moment, it is
broken for both TDX and SEV-SNP.

There's also a problem with the current code in paravisor scenarios:
TDX Partitioning and SEV-SNP in vTOM mode. The exceptions need
to be forwarded from the paravisor to the Linux guest, but there
are no architectural specs for how to do that.

To avoid these complexities of the CoCo exception handlers, change
the core transition code in __set_memory_enc_pgtable() to do the
following:

1.  Remove aliasing mappings
2.  Remove the PRESENT bit from the PTEs of all transitioning pages
3.  Flush the TLB globally
4.  Flush the data cache if needed
5.  Set/clear the encryption attribute as appropriate
6.  Notify the hypervisor of the page status change
7.  Add back the PRESENT bit

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

This approach may make __set_memory_enc_pgtable() slightly slower
because of touching the PTEs three times instead of just once. But
the run time of this function is already dominated by the hypercall
and the need to flush the TLB at least once and maybe twice. In any
case, this function is only used for CoCo VM page transitions, and
is already unsuitable for hot paths.

The architecture specific callback function for notifying the
hypervisor typically must translate guest kernel virtual addresses
into guest physical addresses to pass to the hypervisor.  Because
the PTEs are invalid at the time of callback, the code for doing the
translation needs updating.  virt_to_phys() or equivalent continues
to work for direct map addresses.  But vmalloc addresses cannot use
vmalloc_to_page() because that function requires the leaf PTE to be
valid. Instead, slow_virt_to_phys() must be used. Both functions
manually walk the page table hierarchy, so performance is the same.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---

I'm assuming the TDX handling of the data cache flushing is the
same with this new approach, and that it doesn't need to be paired
with a TLB flush as in the current code.  If that's not a correct
assumption, let me know.

I've left the two hypervisor callbacks, before and after Step 5
above. If the PTEs are invalid, it seems like the order of Step 5
and Step 6 shouldn't matter, so perhaps one of the callback could
be dropped.  Let me know if there are reasons to do otherwise.

It may well be possible to optimize the new implementation of
__set_memory_enc_pgtable(). The existing set_memory_np() and
set_memory_p() functions do all the right things in a very clear
fashion, but perhaps not as optimally as having all three PTE
manipulations directly in the same function. It doesn't appear
that optimizing the performance really matters here, but I'm open
to suggestions.

I've tested this on TDX VMs and SEV-SNP + vTOM VMs.  I can also
test on SEV-SNP VMs without vTOM. But I'll probably need help
covering SEV and SEV-ES VMs.

This RFC patch does *not* remove code that would no longer be
needed. If there's agreement to take this new approach, I'll
add patches to remove the unneeded code.

This patch is built against linux-next20230704.

 arch/x86/hyperv/ivm.c        |  3 ++-
 arch/x86/kernel/sev.c        |  2 +-
 arch/x86/mm/pat/set_memory.c | 32 ++++++++++++--------------------
 3 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 28be6df..2859ec3 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -308,7 +308,8 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 		return false;
 
 	for (i = 0, pfn = 0; i < pagecount; i++) {
-		pfn_array[pfn] = virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_SIZE);
+		pfn_array[pfn] = slow_virt_to_phys((void *)kbuffer +
+					i * HV_HYP_PAGE_SIZE) >> HV_HYP_PAGE_SHIFT;
 		pfn++;
 
 		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ee7bed..59db55e 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -784,7 +784,7 @@ static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long
 		hdr->end_entry = i;
 
 		if (is_vmalloc_addr((void *)vaddr)) {
-			pfn = vmalloc_to_pfn((void *)vaddr);
+			pfn = slow_virt_to_phys((void *)vaddr) >> PAGE_SHIFT;
 			use_large_entry = false;
 		} else {
 			pfn = __pa(vaddr) >> PAGE_SHIFT;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f12..8a194c7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2136,6 +2136,11 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
 		addr &= PAGE_MASK;
 
+	/* set_memory_np() removes aliasing mappings and flushes the TLB */
+	ret = set_memory_np(addr, numpages);
+	if (ret)
+		return ret;
+
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
@@ -2143,36 +2148,23 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	cpa.mask_clr = enc ? pgprot_decrypted(empty) : pgprot_encrypted(empty);
 	cpa.pgd = init_mm.pgd;
 
-	/* Must avoid aliasing mappings in the highmem code */
-	kmap_flush_unused();
-	vm_unmap_aliases();
-
 	/* Flush the caches as needed before changing the encryption attribute. */
-	if (x86_platform.guest.enc_tlb_flush_required(enc))
-		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
+	if (x86_platform.guest.enc_cache_flush_required())
+		cpa_flush(&cpa, 1);
 
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
 	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
 		return -EIO;
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
-
-	/*
-	 * After changing the encryption attribute, we need to flush TLBs again
-	 * in case any speculative TLB caching occurred (but no need to flush
-	 * caches again).  We could just use cpa_flush_all(), but in case TLB
-	 * flushing gets optimized in the cpa_flush() path use the same logic
-	 * as above.
-	 */
-	cpa_flush(&cpa, 0);
+	if (ret)
+		return ret;
 
 	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
-	if (!ret) {
-		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
-			ret = -EIO;
-	}
+	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
+		return -EIO;
 
-	return ret;
+	return set_memory_p(&addr, numpages);
 }
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
-- 
1.8.3.1

