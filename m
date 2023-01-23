Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D9067823C
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jan 2023 17:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjAWQwA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Jan 2023 11:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjAWQv6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Jan 2023 11:51:58 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 041072DE6B;
        Mon, 23 Jan 2023 08:51:54 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 109DD20E1ABC;
        Mon, 23 Jan 2023 08:51:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 109DD20E1ABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674492714;
        bh=6PsJh8C0ku05+rJM5oIvpOU0bn9fPSKNSD8fD5LVGCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3LcL/Xm5jLD2PrZBmB6TpJwAatXq61skO3THxpP6zzvSsZxyQ7BOBsg92nZS59G1
         fZOmIxaUH1zSU+JFV20+Q4iNjQMjm3TrWBvrCRd1ipDIRdoEhYvMi4VFoqntXRVtGs
         0slJnC8pbtxiwY7SEP2TCllbRz4eKHq1CFNWeVKk=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v1 3/6] x86/sev: Maintain shadow rmptable on Hyper-V
Date:   Mon, 23 Jan 2023 16:51:25 +0000
Message-Id: <20230123165128.28185-4-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V can expose the SEV-SNP feature to guests, and manages the
system-wide RMP (Reverse Map) table. The SNP implementation in the
kernel needs access to the rmptable for tracking pages and deciding
when/how to issue rmpupdate/psmash.  When running as a Hyper-V guest
with SNP support, an rmptable is allocated by the kernel during boot for
this purpose. Keep the table in sync with issued rmpupdate/psmash
instructions.

The logic for how to update the rmptable comes from "AMD64 Architecture
Programmer’s Manual, Volume 3" which describes the psmash and rmpupdate
instructions. To ensure correctness of the SNP host code, the most
important fields are "assigned" and "page size".

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/kernel/sev.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 95404c7e5150..edec1ccb80b1 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -26,6 +26,7 @@
 #include <linux/iommu.h>
 #include <linux/amd-iommu.h>
 
+#include <asm/mshyperv.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
@@ -2566,6 +2567,11 @@ int snp_lookup_rmpentry(u64 pfn, int *level)
 }
 EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
 
+static bool hv_no_rmp_table(void)
+{
+	return ms_hyperv.nested_features & HV_X64_NESTED_NO_RMP_TABLE;
+}
+
 static bool virt_snp_msr(void)
 {
 	return boot_cpu_has(X86_FEATURE_NESTED_VIRT_SNP_MSR);
@@ -2584,6 +2590,26 @@ static u64 virt_psmash(u64 paddr)
 	return ret;
 }
 
+static void snp_update_rmptable_psmash(u64 pfn)
+{
+	int level;
+	struct rmpentry *entry = __snp_lookup_rmpentry(pfn, &level);
+
+	if (WARN_ON(IS_ERR_OR_NULL(entry)))
+		return;
+
+	if (level == PG_LEVEL_2M) {
+		int i;
+
+		entry->info.pagesize = RMP_PG_SIZE_4K;
+		for (i = 1; i < PTRS_PER_PMD; i++) {
+			struct rmpentry *it = &entry[i];
+			*it = *entry;
+			it->info.gpa = entry->info.gpa + i * PAGE_SIZE;
+		}
+	}
+}
+
 /*
  * psmash is used to smash a 2MB aligned page into 4K
  * pages while preserving the Validated bit in the RMP.
@@ -2601,6 +2627,8 @@ int psmash(u64 pfn)
 
 	if (virt_snp_msr()) {
 		ret = virt_psmash(paddr);
+		if (!ret && hv_no_rmp_table())
+			snp_update_rmptable_psmash(pfn);
 	} else {
 		/* Binutils version 2.36 supports the PSMASH mnemonic. */
 		asm volatile(".byte 0xF3, 0x0F, 0x01, 0xFF"
@@ -2638,6 +2666,35 @@ static u64 virt_rmpupdate(unsigned long paddr, struct rmp_state *val)
 	return ret;
 }
 
+static void snp_update_rmptable_rmpupdate(u64 pfn, int level, struct rmp_state *val)
+{
+	int prev_level;
+	struct rmpentry *entry = __snp_lookup_rmpentry(pfn, &prev_level);
+
+	if (WARN_ON(IS_ERR_OR_NULL(entry)))
+		return;
+
+	if (level > PG_LEVEL_4K) {
+		int i;
+		struct rmpentry tmp_rmp = {
+			.info = {
+				.assigned = val->assigned,
+			},
+		};
+		for (i = 1; i < PTRS_PER_PMD; i++)
+			entry[i] = tmp_rmp;
+	}
+	if (!val->assigned) {
+		memset(entry, 0, sizeof(*entry));
+	} else {
+		entry->info.assigned = val->assigned;
+		entry->info.pagesize = val->pagesize;
+		entry->info.immutable = val->immutable;
+		entry->info.gpa = val->gpa;
+		entry->info.asid = val->asid;
+	}
+}
+
 static int rmpupdate(u64 pfn, struct rmp_state *val)
 {
 	unsigned long paddr = pfn << PAGE_SHIFT;
@@ -2666,6 +2723,8 @@ static int rmpupdate(u64 pfn, struct rmp_state *val)
 
 	if (virt_snp_msr()) {
 		ret = virt_rmpupdate(paddr, val);
+		if (!ret && hv_no_rmp_table())
+			snp_update_rmptable_rmpupdate(pfn, level, val);
 	} else {
 		/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
 		asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFE"
-- 
2.25.1

