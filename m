Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B52737478
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 20:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFTSko (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 14:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjFTSkm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 14:40:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C8C0DC;
        Tue, 20 Jun 2023 11:40:41 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1159)
        id 9BD3921C1E6D; Tue, 20 Jun 2023 11:40:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BD3921C1E6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687286438;
        bh=iCzyGwffGnwO8ZEB3IZCpwiNa8XaOywtNyIWOP4HGgo=;
        h=From:To:Cc:Subject:Date:From;
        b=sZD3vJiKM8LNDshcV5jtR/6F13HysN7P8u+JXev5GrKpOVQE1epnmacbMBCuVFa7X
         wY4rNjW8qpm//ADz0G7EH1Sr6gIQvx8xEZxjLfjkDq3INdIPdKQj85KttcYQHLk0mn
         uCwR/wDHA9ekB1MilHbPCT/PyCtI7ILjIFh3Q19s=
From:   Nischala Yelchuri <niyelchu@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, "K. Y. Srinivasan"@linux.microsoft.com,
        kys@microsoft.com, Haiyang@linux.microsoft.com,
        Zhang@linux.microsoft.com, haiyangz@microsoft.com,
        Wei@linux.microsoft.com, Liu@linux.microsoft.com,
        wei.liu@kernel.org, Dexuan@linux.microsoft.com,
        Cui@linux.microsoft.com, decui@microsoft.com,
        Thomas@linux.microsoft.com, Gleixner@linux.microsoft.com,
        tglx@linutronix.de, Ingo@linux.microsoft.com,
        Molnar@linux.microsoft.com, mingo@redhat.com,
        Borislav@linux.microsoft.com, Petkov@linux.microsoft.com,
        bp@alien8.de, Dave@linux.microsoft.com, Hansen@linux.microsoft.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        "H. Peter Anvin"@linux.microsoft.com, hpa@zytor.com,
        Tyler@linux.microsoft.com, Hicks@linux.microsoft.com,
        code@tyhicks.com, niyelchu@microsoft.com
Subject: [PATCH] x86/hyperv: Improve code for referencing hyperv_pcpu_input_arg
Date:   Tue, 20 Jun 2023 11:40:38 -0700
Message-Id: <1687286438-9421-1-git-send-email-niyelchu@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Several places in code for Hyper-V reference the
per-CPU variable hyperv_pcpu_input_arg. Older code uses a multi-line
sequence to reference the variable, and usually includes a cast.
Newer code does a much simpler direct assignment. The latter is
preferable as the complexity of the older code is unnecessary.

Update older code to use the simpler direct assignment.

Signed-off-by: Nischala Yelchuri <niyelchu@linux.microsoft.com>
---
 arch/x86/hyperv/hv_apic.c |  4 +---
 arch/x86/hyperv/ivm.c     |  7 +++----
 arch/x86/hyperv/mmu.c     | 12 ++----------
 arch/x86/hyperv/nested.c  | 11 ++---------
 drivers/hv/hv_balloon.c   |  2 +-
 5 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 1fbda2f94..b21335e6a 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -107,7 +107,6 @@ static bool cpu_is_self(int cpu)
 static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 		bool exclude_self)
 {
-	struct hv_send_ipi_ex **arg;
 	struct hv_send_ipi_ex *ipi_arg;
 	unsigned long flags;
 	int nr_bank = 0;
@@ -117,9 +116,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 		return false;
 
 	local_irq_save(flags);
-	arg = (struct hv_send_ipi_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	ipi_arg = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
-	ipi_arg = *arg;
 	if (unlikely(!ipi_arg))
 		goto ipi_mask_ex_done;
 
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 14f46ad2c..28be6df88 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -247,7 +247,7 @@ EXPORT_SYMBOL_GPL(hv_ghcb_msr_read);
 static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 			   enum hv_mem_host_visibility visibility)
 {
-	struct hv_gpa_range_for_visibility **input_pcpu, *input;
+	struct hv_gpa_range_for_visibility *input;
 	u16 pages_processed;
 	u64 hv_status;
 	unsigned long flags;
@@ -263,9 +263,8 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 	}
 
 	local_irq_save(flags);
-	input_pcpu = (struct hv_gpa_range_for_visibility **)
-			this_cpu_ptr(hyperv_pcpu_input_arg);
-	input = *input_pcpu;
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
 	if (unlikely(!input)) {
 		local_irq_restore(flags);
 		return -EINVAL;
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 8460bd35e..1cc113200 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -61,7 +61,6 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 				   const struct flush_tlb_info *info)
 {
 	int cpu, vcpu, gva_n, max_gvas;
-	struct hv_tlb_flush **flush_pcpu;
 	struct hv_tlb_flush *flush;
 	u64 status;
 	unsigned long flags;
@@ -74,10 +73,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 
 	local_irq_save(flags);
 
-	flush_pcpu = (struct hv_tlb_flush **)
-		     this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	flush = *flush_pcpu;
+	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	if (unlikely(!flush)) {
 		local_irq_restore(flags);
@@ -178,17 +174,13 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 				      const struct flush_tlb_info *info)
 {
 	int nr_bank = 0, max_gvas, gva_n;
-	struct hv_tlb_flush_ex **flush_pcpu;
 	struct hv_tlb_flush_ex *flush;
 	u64 status;
 
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
 		return HV_STATUS_INVALID_PARAMETER;
 
-	flush_pcpu = (struct hv_tlb_flush_ex **)
-		     this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	flush = *flush_pcpu;
+	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	if (info->mm) {
 		/*
diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 5d70968c8..9dc259fa3 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -19,7 +19,6 @@
 
 int hyperv_flush_guest_mapping(u64 as)
 {
-	struct hv_guest_mapping_flush **flush_pcpu;
 	struct hv_guest_mapping_flush *flush;
 	u64 status;
 	unsigned long flags;
@@ -30,10 +29,7 @@ int hyperv_flush_guest_mapping(u64 as)
 
 	local_irq_save(flags);
 
-	flush_pcpu = (struct hv_guest_mapping_flush **)
-		this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	flush = *flush_pcpu;
+	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	if (unlikely(!flush)) {
 		local_irq_restore(flags);
@@ -90,7 +86,6 @@ EXPORT_SYMBOL_GPL(hyperv_fill_flush_guest_mapping_list);
 int hyperv_flush_guest_mapping_range(u64 as,
 		hyperv_fill_flush_list_func fill_flush_list_func, void *data)
 {
-	struct hv_guest_mapping_flush_list **flush_pcpu;
 	struct hv_guest_mapping_flush_list *flush;
 	u64 status;
 	unsigned long flags;
@@ -102,10 +97,8 @@ int hyperv_flush_guest_mapping_range(u64 as,
 
 	local_irq_save(flags);
 
-	flush_pcpu = (struct hv_guest_mapping_flush_list **)
-		this_cpu_ptr(hyperv_pcpu_input_arg);
+	flush = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
-	flush = *flush_pcpu;
 	if (unlikely(!flush)) {
 		local_irq_restore(flags);
 		goto fault;
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index dffcc894f..0d7a3ba66 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1628,7 +1628,7 @@ static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
 	WARN_ON_ONCE(sgl->length < (HV_HYP_PAGE_SIZE << page_reporting_order));
 	local_irq_save(flags);
-	hint = *(struct hv_memory_hint **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	hint = *this_cpu_ptr(hyperv_pcpu_input_arg);
 	if (!hint) {
 		local_irq_restore(flags);
 		return -ENOSPC;
-- 
2.25.1

