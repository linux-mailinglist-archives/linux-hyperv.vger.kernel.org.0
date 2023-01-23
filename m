Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4867823D
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jan 2023 17:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjAWQwC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Jan 2023 11:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjAWQwB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Jan 2023 11:52:01 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9A372C66B;
        Mon, 23 Jan 2023 08:51:58 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id D00BF20E1ABE;
        Mon, 23 Jan 2023 08:51:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D00BF20E1ABE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674492718;
        bh=1q0vUA/+bYaUkIbGuVZC66EHLWsufbPUd970kd1iRGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNcToS0zofw2NUVWyE80xtxIOj8gXwl2ndk42rbTQnKwVuvk18CJO2Xmi4gYMm7iS
         Ojue38bjS4dB2x6Y7jyVXeJqvE3fgs5EWQot99JevbHbWQqkR5fjInL3U1nTeZLjo3
         LWpe7t7Xfyk0ueoI5mxTQhkG98Fclix4IVqHfO/4=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@microsoft.com>,
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: [RFC PATCH v1 4/6] x86/amd: Configure necessary MSRs for SNP during CPU init when running as a guest
Date:   Mon, 23 Jan 2023 16:51:26 +0000
Message-Id: <20230123165128.28185-5-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
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

From: Jeremi Piotrowski <jpiotrowski@microsoft.com>

Hyper-V may expose the SEV/SEV-SNP CPU features to the guest, but it is
up to the guest to use them. early_detect_mem_encrypt() checks
SYSCFG[MEM_ENCRYPT] and HWCR[SMMLOCK] and if these are not set the
SEV-SNP features are cleared.  Check if we are running under a
hypervisor and if so - update SYSCFG and skip the HWCR check.

It would be great to make this check more specific (checking for
Hyper-V) but this code runs before hypervisor detection on the boot cpu.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/kernel/cpu/amd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index c7884198ad5b..17d91ac62937 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -565,6 +565,12 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 	 *   don't advertise the feature under CONFIG_X86_32.
 	 */
 	if (cpu_has(c, X86_FEATURE_SME) || cpu_has(c, X86_FEATURE_SEV)) {
+		if (cpu_has(c, X86_FEATURE_HYPERVISOR)) {
+			rdmsrl(MSR_AMD64_SYSCFG, msr);
+			msr |= MSR_AMD64_SYSCFG_MEM_ENCRYPT;
+			wrmsrl(MSR_AMD64_SYSCFG, msr);
+		}
+
 		/* Check if memory encryption is enabled */
 		rdmsrl(MSR_AMD64_SYSCFG, msr);
 		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
@@ -584,7 +590,7 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 			setup_clear_cpu_cap(X86_FEATURE_SME);
 
 		rdmsrl(MSR_K7_HWCR, msr);
-		if (!(msr & MSR_K7_HWCR_SMMLOCK))
+		if (!(msr & MSR_K7_HWCR_SMMLOCK) && !cpu_has(c, X86_FEATURE_HYPERVISOR))
 			goto clear_sev;
 
 		return;
-- 
2.25.1

