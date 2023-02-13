Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8926942EE
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 11:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBMKem (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 05:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBMKek (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 05:34:40 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47D0813D43;
        Mon, 13 Feb 2023 02:34:36 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4230D20C8B77;
        Mon, 13 Feb 2023 02:34:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4230D20C8B77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676284475;
        bh=CIr41cGlWZ1wcUio7O4orsXVmz7isVmQd0woUBuuPcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZuD2qOdLSqqQlqTCLW+rbKY2cD2ILv4r1ZtjIm6EYBdmnPkrjoqpk9XbeOH4+KU+T
         wUTy6JgOYK1C43KXXSFTkOgjsDRTxYsYO+VpudE08dh9LxCDkbvzvljC/J/Ab3fyEq
         O4m/GxEwmM46BOs0rxLIZsaDqgOE37FrrS6V8K7I=
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
Subject: [RFC PATCH v2 4/7] x86/amd: Configure necessary MSRs for SNP during CPU init when running as a guest
Date:   Mon, 13 Feb 2023 10:33:59 +0000
Message-Id: <20230213103402.1189285-5-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
References: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
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

Hyper-V may expose the SEV-SNP CPU features to the guest, but it is the
guests kernel's responsibility to configure them.
early_detect_mem_encrypt() checks SYSCFG[MEM_ENCRYPT] and HWCR[SMMLOCK]
and if these are not set the SEV-SNP CPU flags are cleared. These checks
are only really necessary on baremetal and provide no value when running
virtualized. They prevent further initialization from happening, so
check if we are running under a hypervisor and if so - update SYSCFG and
skip the HWCR check.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/kernel/cpu/amd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index c7884198ad5b..4418a418109b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -565,6 +565,9 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 	 *   don't advertise the feature under CONFIG_X86_32.
 	 */
 	if (cpu_has(c, X86_FEATURE_SME) || cpu_has(c, X86_FEATURE_SEV)) {
+		if (cpu_has(c, X86_FEATURE_HYPERVISOR))
+			msr_set_bit(MSR_AMD64_SYSCFG, MSR_AMD64_SYSCFG_MEM_ENCRYPT_BIT);
+
 		/* Check if memory encryption is enabled */
 		rdmsrl(MSR_AMD64_SYSCFG, msr);
 		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
@@ -584,7 +587,7 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 			setup_clear_cpu_cap(X86_FEATURE_SME);
 
 		rdmsrl(MSR_K7_HWCR, msr);
-		if (!(msr & MSR_K7_HWCR_SMMLOCK))
+		if (!(msr & MSR_K7_HWCR_SMMLOCK) && !cpu_has(c, X86_FEATURE_HYPERVISOR))
 			goto clear_sev;
 
 		return;
-- 
2.25.1

