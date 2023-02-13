Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB86942EB
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 11:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjBMKeg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 05:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBMKef (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 05:34:35 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C802DBF6;
        Mon, 13 Feb 2023 02:34:33 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 49EE420C8B73;
        Mon, 13 Feb 2023 02:34:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 49EE420C8B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676284472;
        bh=0f3V5nPDxmg11RJ8oq9LMHRMj/eCJ6zpTgfupRm3u00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsaUHTv6b+3sbEl+Ft5POXdghpjuPy5HJ3bT8pxUZgFfpsngZ5ECQ2Vfe6M6isvFm
         0r5KHxawxvb4R+ShERIl789T3wRdtpdvxGLCg4GPyRbs+tuKpMZLR6TlcH4nXVYc0g
         7NqDxwucntQp4sLJHs8txoMsKPVJLZ3yKBRp+/Tc=
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
Subject: [RFC PATCH v2 3/7] x86/sev: Maintain shadow rmptable on Hyper-V
Date:   Mon, 13 Feb 2023 10:33:58 +0000
Message-Id: <20230213103402.1189285-4-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
References: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
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
 arch/x86/include/asm/sev.h     |  4 ++
 arch/x86/kernel/cpu/mshyperv.c |  2 +
 arch/x86/kernel/sev.c          | 69 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index db5438663229..4d3591ebff5d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -218,6 +218,8 @@ int psmash(u64 pfn);
 int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, int asid, bool immutable);
 int rmp_make_shared(u64 pfn, enum pg_level level);
 void sev_dump_rmpentry(u64 pfn);
+bool snp_soft_rmptable(void);
+void __init snp_set_soft_rmptable(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -251,6 +253,8 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, int as
 }
 static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV; }
 static inline void sev_dump_rmpentry(u64 pfn) {}
+static inline bool snp_soft_rmptable(void) { return false; }
+static inline void __init snp_set_soft_rmptable(void) {}
 #endif
 
 #endif
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 777c9d812dfa..101c38e9cae7 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -530,6 +530,8 @@ static void __init ms_hyperv_init_mem_mapping(void)
 	wrmsrl(MSR_AMD64_RMP_BASE, rmp_res.start);
 	wrmsrl(MSR_AMD64_RMP_END, rmp_res.end);
 	insert_resource(&iomem_resource, &rmp_res);
+
+	snp_set_soft_rmptable();
 }
 
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index ad09dd3747a1..712f1a9623ce 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2566,6 +2566,22 @@ int snp_lookup_rmpentry(u64 pfn, int *level)
 }
 EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
 
+static bool soft_rmptable __ro_after_init;
+
+/*
+ * Test if the rmptable needs to be managed by software and is not maintained by
+ * (virtualized) hardware.
+ */
+bool snp_soft_rmptable(void)
+{
+	return soft_rmptable;
+}
+
+void __init snp_set_soft_rmptable(void)
+{
+	soft_rmptable = true;
+}
+
 static bool virt_snp_msr(void)
 {
 	return boot_cpu_has(X86_FEATURE_NESTED_VIRT_SNP_MSR);
@@ -2592,6 +2608,26 @@ static u64 virt_psmash(u64 paddr)
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
@@ -2609,6 +2645,8 @@ int psmash(u64 pfn)
 
 	if (virt_snp_msr()) {
 		ret = virt_psmash(paddr);
+		if (!ret && snp_soft_rmptable())
+			snp_update_rmptable_psmash(pfn);
 	} else {
 		/* Binutils version 2.36 supports the PSMASH mnemonic. */
 		asm volatile(".byte 0xF3, 0x0F, 0x01, 0xFF"
@@ -2656,6 +2694,35 @@ static u64 virt_rmpupdate(unsigned long paddr, struct rmp_state *val)
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
@@ -2684,6 +2751,8 @@ static int rmpupdate(u64 pfn, struct rmp_state *val)
 
 	if (virt_snp_msr()) {
 		ret = virt_rmpupdate(paddr, val);
+		if (!ret && snp_soft_rmptable())
+			snp_update_rmptable_rmpupdate(pfn, level, val);
 	} else {
 		/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
 		asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFE"
-- 
2.25.1

