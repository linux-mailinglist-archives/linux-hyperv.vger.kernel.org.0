Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B565B362C77
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Apr 2021 02:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhDQAng (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 20:43:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55700 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQAng (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 20:43:36 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id EBAB720B8002;
        Fri, 16 Apr 2021 17:43:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EBAB720B8002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1618620191;
        bh=dxjZlNVkN5CIn0Va6fSTJlt69VPIXincVkJBqjJWZjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
        b=AJhUOtENcYoZ8d7SnJxzQauXxecwcGEiHpe3Q2Jgxz+gPS89E0LMmRDAyj0j6Z2sO
         LUO6Ggl0D5aUORU281pKgG9DPWSG0glwaXdeJL/z7kFbFlAYonzLTfIDeQuBuoeuJq
         tjWdfswf2e2vFncspCzyrZKyc9dYyEZayGrEMfB4=
From:   Joseph Salisbury <joseph.salisbury@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.salisbury@microsoft.com
Subject: [PATCH 2/2] drivers: hv: Create a consistent pattern for checking Hyper-V hypercall status 
Date:   Fri, 16 Apr 2021 17:43:03 -0700
Message-Id: <1618620183-9967-2-git-send-email-joseph.salisbury@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
References: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
Reply-To: joseph.salisbury@microsoft.com
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Joseph Salisbury <joseph.salisbury@microsoft.com>

There is not a consistent pattern for checking Hyper-V hypercall status.
Existing code uses a number of variants.  The variants work, but a consistent
pattern would improve the readability of the code, and be more conformant
to what the Hyper-V TLFS says about hypercall status.

Implemented new helper functions hv_result(), hv_result_success(), and
hv_repcomp().  Changed the places where hv_do_hypercall() and related variants
are used to use the helper functions.

Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c           | 16 +++++++++-------
 arch/x86/hyperv/hv_init.c           |  2 +-
 arch/x86/hyperv/hv_proc.c           | 25 ++++++++++---------------
 arch/x86/hyperv/irqdomain.c         |  6 +++---
 arch/x86/hyperv/mmu.c               |  8 ++++----
 arch/x86/hyperv/nested.c            |  8 ++++----
 arch/x86/include/asm/mshyperv.h     |  1 +
 drivers/hv/hv.c                     |  2 +-
 drivers/pci/controller/pci-hyperv.c |  2 +-
 include/asm-generic/mshyperv.h      | 25 ++++++++++++++++++++-----
 10 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 284e73661a18..ca581b24974a 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -103,7 +103,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 	struct hv_send_ipi_ex *ipi_arg;
 	unsigned long flags;
 	int nr_bank = 0;
-	int ret = 1;
+	u64 status = HV_STATUS_INVALID_PARAMETER;
 
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
 		return false;
@@ -128,19 +128,19 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 	if (!nr_bank)
 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
 
-	ret = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
+	status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
 			      ipi_arg, NULL);
 
 ipi_mask_ex_done:
 	local_irq_restore(flags);
-	return ((ret == 0) ? true : false);
+	return hv_result_success(status);
 }
 
 static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	int cur_cpu, vcpu;
 	struct hv_send_ipi ipi_arg;
-	int ret = 1;
+	u64 status;
 
 	trace_hyperv_send_ipi_mask(mask, vector);
 
@@ -184,9 +184,9 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 		__set_bit(vcpu, (unsigned long *)&ipi_arg.cpu_mask);
 	}
 
-	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
+	status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
 				     ipi_arg.cpu_mask);
-	return ((ret == 0) ? true : false);
+	return hv_result_success(status);
 
 do_ex_hypercall:
 	return __send_ipi_mask_ex(mask, vector);
@@ -195,6 +195,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 static bool __send_ipi_one(int cpu, int vector)
 {
 	int vp = hv_cpu_number_to_vp_number(cpu);
+	u64 status;
 
 	trace_hyperv_send_ipi_one(cpu, vector);
 
@@ -207,7 +208,8 @@ static bool __send_ipi_one(int cpu, int vector)
 	if (vp >= 64)
 		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
 
-	return !hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
+	status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
+	return hv_result_success(status);
 }
 
 static void hv_send_ipi(int cpu, int vector)
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b81047dec1da..a5b73584e2cc 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -369,7 +369,7 @@ static void __init hv_get_partition_id(void)
 	local_irq_save(flags);
 	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
 	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
-	if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS) {
+	if (!hv_result_success(status)) {
 		/* No point in proceeding if this failed */
 		pr_err("Failed to get partition ID: %lld\n", status);
 		BUG();
diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 60461e598239..f16234aef358 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -93,10 +93,9 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
 				     page_count, 0, input_page, NULL);
 	local_irq_restore(flags);
-
-	if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS) {
+	if (!hv_result_success(status)) {
 		pr_err("Failed to deposit pages: %lld\n", status);
-		ret = status;
+		ret = hv_result(status);
 		goto err_free_allocations;
 	}
 
@@ -122,7 +121,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 	struct hv_add_logical_processor_out *output;
 	u64 status;
 	unsigned long flags;
-	int ret = 0;
+	int ret = HV_STATUS_SUCCESS;
 	int pxm = node_to_pxm(node);
 
 	/*
@@ -148,13 +147,11 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 					 input, output);
 		local_irq_restore(flags);
 
-		status &= HV_HYPERCALL_RESULT_MASK;
-
-		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
-			if (status != HV_STATUS_SUCCESS) {
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status)) {
 				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
 				       lp_index, apic_id, status);
-				ret = status;
+				ret = hv_result(status);
 			}
 			break;
 		}
@@ -169,7 +166,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 	struct hv_create_vp *input;
 	u64 status;
 	unsigned long irq_flags;
-	int ret = 0;
+	int ret = HV_STATUS_SUCCESS;
 	int pxm = node_to_pxm(node);
 
 	/* Root VPs don't seem to need pages deposited */
@@ -200,13 +197,11 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
 		local_irq_restore(irq_flags);
 
-		status &= HV_HYPERCALL_RESULT_MASK;
-
-		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
-			if (status != HV_STATUS_SUCCESS) {
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status)) {
 				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
 				       vp_index, flags, status);
-				ret = status;
+				ret = hv_result(status);
 			}
 			break;
 		}
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 4421a8d92e23..514fc64e23d5 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -63,10 +63,10 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 
 	local_irq_restore(flags);
 
-	if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS)
+	if (!hv_result_success(status))
 		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
 
-	return status & HV_HYPERCALL_RESULT_MASK;
+	return hv_result(status);
 }
 
 static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
@@ -88,7 +88,7 @@ static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
 	status = hv_do_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, input, NULL);
 	local_irq_restore(flags);
 
-	return status & HV_HYPERCALL_RESULT_MASK;
+	return hv_result(status);
 }
 
 #ifdef CONFIG_PCI_MSI
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 2c87350c1fb0..c0ba8874d9cb 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -58,7 +58,7 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 	int cpu, vcpu, gva_n, max_gvas;
 	struct hv_tlb_flush **flush_pcpu;
 	struct hv_tlb_flush *flush;
-	u64 status = U64_MAX;
+	u64 status;
 	unsigned long flags;
 
 	trace_hyperv_mmu_flush_tlb_others(cpus, info);
@@ -161,7 +161,7 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 check_status:
 	local_irq_restore(flags);
 
-	if (!(status & HV_HYPERCALL_RESULT_MASK))
+	if (hv_result_success(status))
 		return;
 do_native:
 	native_flush_tlb_others(cpus, info);
@@ -176,7 +176,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	u64 status;
 
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
-		return U64_MAX;
+		return HV_STATUS_INVALID_PARAMETER;
 
 	flush_pcpu = (struct hv_tlb_flush_ex **)
 		     this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -201,7 +201,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 	nr_bank = cpumask_to_vpset(&(flush->hv_vp_set), cpus);
 	if (nr_bank < 0)
-		return U64_MAX;
+		return HV_STATUS_INVALID_PARAMETER;
 
 	/*
 	 * We can flush not more than max_gvas with one hypercall. Flush the
diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index dd0a843f766d..5d70968c8538 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -47,7 +47,7 @@ int hyperv_flush_guest_mapping(u64 as)
 				 flush, NULL);
 	local_irq_restore(flags);
 
-	if (!(status & HV_HYPERCALL_RESULT_MASK))
+	if (hv_result_success(status))
 		ret = 0;
 
 fault:
@@ -92,7 +92,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
 {
 	struct hv_guest_mapping_flush_list **flush_pcpu;
 	struct hv_guest_mapping_flush_list *flush;
-	u64 status = 0;
+	u64 status;
 	unsigned long flags;
 	int ret = -ENOTSUPP;
 	int gpa_n = 0;
@@ -125,10 +125,10 @@ int hyperv_flush_guest_mapping_range(u64 as,
 
 	local_irq_restore(flags);
 
-	if (!(status & HV_HYPERCALL_RESULT_MASK))
+	if (hv_result_success(status))
 		ret = 0;
 	else
-		ret = status;
+		ret = hv_result(status);
 fault:
 	trace_hyperv_nested_flush_guest_mapping_range(as, ret);
 	return ret;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index bfc98b490f07..759136f98e19 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -9,6 +9,7 @@
 #include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
+#include <asm/mshyperv.h>
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index f202ac7f4b3d..307fe26dd81a 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -68,7 +68,7 @@ int hv_post_message(union hv_connection_id connection_id,
 	 */
 	put_cpu_ptr(hv_cpu);
 
-	return status & 0xFFFF;
+	return hv_result(status);
 }
 
 int hv_synic_alloc(void)
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 27a17a1e4a7c..aa278005dea2 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1292,7 +1292,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	 * resumes, hv_pci_restore_msi_state() is able to correctly restore
 	 * the interrupt with the correct affinity.
 	 */
-	if (res && hbus->state != hv_pcibus_removing)
+	if (!hv_result_success(res) && hbus->state != hv_pcibus_removing)
 		dev_err(&hbus->hdev->device,
 			"%s() failed: %#llx", __func__, res);
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a5246a6ea02d..27d85d675e9a 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -41,6 +41,24 @@ extern struct ms_hyperv_info ms_hyperv;
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 
+/* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
+static inline int hv_result(u64 status)
+{
+	return status & HV_HYPERCALL_RESULT_MASK;
+}
+
+static inline bool hv_result_success(u64 status)
+{
+	return hv_result(status) == HV_STATUS_SUCCESS;
+}
+
+static inline unsigned int hv_repcomp(u64 status)
+{
+	/* Bits [43:32] of status have 'Reps completed' data. */
+	return (status & HV_HYPERCALL_REP_COMP_MASK) >>
+			 HV_HYPERCALL_REP_COMP_OFFSET;
+}
+
 /*
  * Rep hypercalls. Callers of this functions are supposed to ensure that
  * rep_count and varhead_size comply with Hyper-V hypercall definition.
@@ -57,12 +75,10 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 
 	do {
 		status = hv_do_hypercall(control, input, output);
-		if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS)
+		if (!hv_result_success(status))
 			return status;
 
-		/* Bits 32-43 of status have 'Reps completed' data. */
-		rep_comp = (status & HV_HYPERCALL_REP_COMP_MASK) >>
-			HV_HYPERCALL_REP_COMP_OFFSET;
+		rep_comp = hv_repcomp(status);
 
 		control &= ~HV_HYPERCALL_REP_START_MASK;
 		control |= (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
@@ -87,7 +103,6 @@ static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
 	return guest_id;
 }
 
-
 /* Free the message slot and signal end-of-message if required */
 static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 {
-- 
2.17.1

