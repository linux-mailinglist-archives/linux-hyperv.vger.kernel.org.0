Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9856942E8
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 11:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBMKee (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 05:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjBMKed (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 05:34:33 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58E35126D8;
        Mon, 13 Feb 2023 02:34:30 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5255E20C8B75;
        Mon, 13 Feb 2023 02:34:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5255E20C8B75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676284469;
        bh=JDn8a8015dAIvKwIsQKiqtgMDWEL4ycrKsqNeNuYORg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSfJD3ml/i9FfUkGd5YkJtKx1KgxuMKagB9LFqPLcln9xsKkdri2GvW53ddeUvHpZ
         vyFZWftQrXhNf9XV2tZUgKPTwD0XUg8L1zFS2DoP2HgFFatYo2Too0ZAjXeoM5CaN0
         lTy/8gDo8DV5QiXBGYOar9zRLQl2HL4/EQSsdIWQ=
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
Subject: [RFC PATCH v2 2/7] x86/sev: Add support for NestedVirtSnpMsr
Date:   Mon, 13 Feb 2023 10:33:57 +0000
Message-Id: <20230213103402.1189285-3-jpiotrowski@linux.microsoft.com>
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

The rmpupdate and psmash instructions, which are used in AMD's SEV-SNP
to update the RMP (Reverse Map) table, can't be trapped. For nested
scenarios, AMD defined MSR versions of these instructions which can
be trapped and must be emulated by the L0 hypervisor. One instance where
these MSRs are used are Hyper-V VMs which expose SNP hardware isolation
capabilities to the L1 guest.

The MSRs are defined in "AMD64 Architecture Programmer’s Manual, Volume 2:
System Programming", section 15.36.19.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  2 +
 arch/x86/kernel/sev.c              | 80 ++++++++++++++++++++++++++----
 3 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 480b4eaef310..e6e2e824f67b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -423,6 +423,7 @@
 #define X86_FEATURE_SEV_SNP		(19*32+ 4) /* AMD Secure Encrypted Virtualization - Secure Nested Paging */
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
+#define X86_FEATURE_NESTED_VIRT_SNP_MSR	(19*32+29) /* Virtualizable RMPUPDATE and PSMASH MSR available */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 35100c630617..d6103e607896 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -567,6 +567,8 @@
 #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
+#define MSR_AMD64_VIRT_RMPUPDATE	0xc001f001
+#define MSR_AMD64_VIRT_PSMASH		0xc001f002
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 7fa39dc17edd..ad09dd3747a1 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2566,6 +2566,32 @@ int snp_lookup_rmpentry(u64 pfn, int *level)
 }
 EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
 
+static bool virt_snp_msr(void)
+{
+	return boot_cpu_has(X86_FEATURE_NESTED_VIRT_SNP_MSR);
+}
+
+/*
+ * This version of psmash is not implemented in hardware but always
+ * traps to L0 hypervisor. It doesn't follow usual wrmsr conventions.
+ * Inputs:
+ *   rax: 2MB aligned GPA
+ * Outputs:
+ *   rax: psmash return code
+ */
+static u64 virt_psmash(u64 paddr)
+{
+	int ret;
+
+	asm volatile(
+		"wrmsr\n\t"
+		: "=a"(ret)
+		: "a"(paddr), "c"(MSR_AMD64_VIRT_PSMASH)
+		: "memory", "cc"
+	);
+	return ret;
+}
+
 /*
  * psmash is used to smash a 2MB aligned page into 4K
  * pages while preserving the Validated bit in the RMP.
@@ -2581,11 +2607,15 @@ int psmash(u64 pfn)
 	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
 		return -ENXIO;
 
-	/* Binutils version 2.36 supports the PSMASH mnemonic. */
-	asm volatile(".byte 0xF3, 0x0F, 0x01, 0xFF"
-		      : "=a"(ret)
-		      : "a"(paddr)
-		      : "memory", "cc");
+	if (virt_snp_msr()) {
+		ret = virt_psmash(paddr);
+	} else {
+		/* Binutils version 2.36 supports the PSMASH mnemonic. */
+		asm volatile(".byte 0xF3, 0x0F, 0x01, 0xFF"
+			      : "=a"(ret)
+			      : "a"(paddr)
+			      : "memory", "cc");
+	}
 
 	return ret;
 }
@@ -2601,6 +2631,31 @@ static int invalidate_direct_map(unsigned long pfn, int npages)
 	return set_memory_np((unsigned long)pfn_to_kaddr(pfn), npages);
 }
 
+/*
+ * This version of rmpupdate is not implemented in hardware but always
+ * traps to L0 hypervisor. It doesn't follow usual wrmsr conventions.
+ * Inputs:
+ *   rax: 4KB aligned GPA
+ *   rdx: bytes 7:0 of new rmp entry
+ *   r8:  bytes 15:8 of new rmp entry
+ * Outputs:
+ *   rax: rmpupdate return code
+ */
+static u64 virt_rmpupdate(unsigned long paddr, struct rmp_state *val)
+{
+	int ret;
+	register u64 hi asm("r8") = ((u64 *)val)[1];
+	register u64 lo asm("rdx") = ((u64 *)val)[0];
+
+	asm volatile(
+		"wrmsr\n\t"
+		: "=a"(ret)
+		: "a"(paddr), "c"(MSR_AMD64_VIRT_RMPUPDATE), "r"(lo), "r"(hi)
+		: "memory", "cc"
+	);
+	return ret;
+}
+
 static int rmpupdate(u64 pfn, struct rmp_state *val)
 {
 	unsigned long paddr = pfn << PAGE_SHIFT;
@@ -2626,11 +2681,16 @@ static int rmpupdate(u64 pfn, struct rmp_state *val)
 	}
 
 retry:
-	/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
-	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFE"
-		     : "=a"(ret)
-		     : "a"(paddr), "c"((unsigned long)val)
-		     : "memory", "cc");
+
+	if (virt_snp_msr()) {
+		ret = virt_rmpupdate(paddr, val);
+	} else {
+		/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
+		asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFE"
+			     : "=a"(ret)
+			     : "a"(paddr), "c"((unsigned long)val)
+			     : "memory", "cc");
+	}
 
 	if (ret) {
 		if (!retries) {
-- 
2.25.1

