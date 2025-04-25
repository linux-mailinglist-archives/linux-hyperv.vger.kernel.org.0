Return-Path: <linux-hyperv+bounces-5158-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D3FA9D433
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 23:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498C09A0B77
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4154A21D5BE;
	Fri, 25 Apr 2025 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Nv/ns0Y+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2445020C000;
	Fri, 25 Apr 2025 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745616917; cv=none; b=js6w6ZodfOhhjxIvD8TIsxRbr1mzAoKgri2+yN4SLTSoacrz7qzr6QHQS0uwfpQA8v9LrbhwHMi4feKnKJvi7Q5EAVRzgAqPv478RS5kmZNCyRQ0PbBxVBQ7yasJZ+qOdIXxINTZSkZJdsROh9tPca4i1NR1xxct83n3dLeP7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745616917; c=relaxed/simple;
	bh=ne82JsrMDGaH8uMFaq8PPYLGQrB6aj41awqQphp7sD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIL/nQd9KxK2wcPyGHnz7xL36/dtBI+pVjp1Gxkw4dHWbAqQ4Wwom1cLSNecegjYaMsoSmM1AC0hIG2KnbxJWmh+mjbqH732e26afXe52VcxNnSbVwT/1zLqaKWu7zjNSsch35ZWj3sNRYEA1WNQGooJYDvbI9cLoLNTw7unBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Nv/ns0Y+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.147.157])
	by linux.microsoft.com (Postfix) with ESMTPSA id 712822020972;
	Fri, 25 Apr 2025 14:35:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 712822020972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745616914;
	bh=8CS/yq/7CylYnZyoBQ6NrgsKTUAT+CwdgkliYXKMYaI=;
	h=From:To:Cc:Subject:Date:From;
	b=Nv/ns0Y+Ed7waM2QH3EFAo1SJgh9bJbK5ZKFuzjsgyX85Y6zKlzEb8qT6iZwcLaw7
	 tgUfZ1PlROWrzkqSccjf6ShH115HU+ZWRQ5umNRxr1BbrCzllwvuR/l7uVgHxNOpFQ
	 f0U2Cxw2S4HZIkgDd+YW7EgMgHhvUX0ZXuBTfXPc=
From: Roman Kisel <romank@linux.microsoft.com>
To: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mikelley@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	tiala@microsoft.com,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v2] x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()
Date: Fri, 25 Apr 2025 14:35:12 -0700
Message-ID: <20250425213512.1837061-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To start an application processor in SNP-isolated guest, a hypercall
is used that takes a virtual processor index. The hv_snp_boot_ap()
function uses that HVCALL_START_VP hypercall but passes as the VP index to it
what it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.

As those two aren't generally interchangeable, that may lead to hung
APs if the VP index and the APIC ID don't match up.

Update the parameter names to avoid confusion as to what the parameter
is. Use the APIC ID to the VP index conversion to provide the correct
input to the hypercall.

Cc: stable@vger.kernel.org
Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
The previous version broke the build, apologies! This version fixes
the break and has other improvements suggested by the reviewers.

[V2]
    - Fixed the terminology in the patch and other code to use
      the term "VP index" consistently
    ** Thank you, Michael! **

    - Missed not enabling the SNP-SEV options in the local testing,
      and sent a patch that breaks the build.
    ** Thank you, Saurabh! **

    - Added comments and getting the Linux kernel CPU number from
      the available data.

[V1]
  https://lore.kernel.org/linux-hyperv/20250424215746.467281-1-romank@linux.microsoft.com/
---
 arch/x86/hyperv/hv_init.c       | 33 +++++++++++++++++++++++++
 arch/x86/hyperv/hv_vtl.c        | 44 +++++----------------------------
 arch/x86/hyperv/ivm.c           | 32 ++++++++++++++++++++++--
 arch/x86/include/asm/mshyperv.h |  6 +++--
 include/hyperv/hvgdk_mini.h     |  2 +-
 5 files changed, 74 insertions(+), 43 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index ddeb40930bc8..611647bfff90 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -706,3 +706,36 @@ bool hv_is_hyperv_initialized(void)
 	return hypercall_msr.enable;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+int hv_apicid_to_vp_index(u32 apic_id)
+{
+	u64 control;
+	u64 status;
+	unsigned long irq_flags;
+	struct hv_get_vp_from_apic_id_in *input;
+	u32 *output, ret;
+
+	local_irq_save(irq_flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->apic_ids[0] = apic_id;
+
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_INDEX_FROM_APIC_ID;
+	status = hv_do_hypercall(control, input, output);
+	ret = output[0];
+
+	local_irq_restore(irq_flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("failed to get vp id from apic id %d, status %#llx\n",
+		       apic_id, status);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hv_apicid_to_vp_index);
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 582fe820e29c..dba10a34c180 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -205,41 +205,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 	return ret;
 }
 
-static int hv_vtl_apicid_to_vp_id(u32 apic_id)
-{
-	u64 control;
-	u64 status;
-	unsigned long irq_flags;
-	struct hv_get_vp_from_apic_id_in *input;
-	u32 *output, ret;
-
-	local_irq_save(irq_flags);
-
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(input, 0, sizeof(*input));
-	input->partition_id = HV_PARTITION_ID_SELF;
-	input->apic_ids[0] = apic_id;
-
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
-
-	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
-	status = hv_do_hypercall(control, input, output);
-	ret = output[0];
-
-	local_irq_restore(irq_flags);
-
-	if (!hv_result_success(status)) {
-		pr_err("failed to get vp id from apic id %d, status %#llx\n",
-		       apic_id, status);
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
 static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 {
-	int vp_id, cpu;
+	int vp_index, cpu;
 
 	/* Find the logical CPU for the APIC ID */
 	for_each_present_cpu(cpu) {
@@ -250,18 +218,18 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 		return -EINVAL;
 
 	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
-	vp_id = hv_vtl_apicid_to_vp_id(apicid);
+	vp_index = hv_apicid_to_vp_index(apicid);
 
-	if (vp_id < 0) {
+	if (vp_index < 0) {
 		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
 		return -EINVAL;
 	}
-	if (vp_id > ms_hyperv.max_vp_index) {
-		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_id, apicid);
+	if (vp_index > ms_hyperv.max_vp_index) {
+		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_index, apicid);
 		return -EINVAL;
 	}
 
-	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
+	return hv_vtl_bringup_vcpu(vp_index, cpu, start_eip);
 }
 
 int __init hv_vtl_early_init(void)
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index c0039a90e9e0..eb2c67e80423 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 #include <asm/svm.h>
 #include <asm/sev.h>
 #include <asm/io.h>
@@ -288,7 +289,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
@@ -297,10 +298,37 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	u64 ret, retry = 5;
 	struct hv_enable_vp_vtl *start_vp_input;
 	unsigned long flags;
+	int cpu, vp_index;
 
 	if (!vmsa)
 		return -ENOMEM;
 
+	/* Find the Hyper-V VP index which might be not the same as APIC ID */
+	vp_index = hv_apicid_to_vp_index(apic_id);
+	if (vp_index < 0 || vp_index > ms_hyperv.max_vp_index)
+		return -EINVAL;
+
+	/*
+	 * Find the Linux CPU number for addressing the per-CPU data, and it
+	 * might not be the same as APIC ID.
+	 *
+	 * "APIC ID != VP index" is rare/pathological and might be observed with
+	 * more than 16 non power-of-two number of virtual processors. This is not
+	 * something backed up by the TLFS, just a heuristic. We'd like to move this
+	 * code over to the place the CPU number is known rather than has to be
+	 * computed via the linear scan like is done here.
+	 */
+	if (unlikely(apic_id != vp_index)) {
+		for_each_present_cpu(cpu) {
+			if (arch_match_cpu_phys_id(cpu, apic_id))
+				break;
+		}
+	} else {
+		cpu = apic_id;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
 	native_store_gdt(&gdtr);
 
 	vmsa->gdtr.base = gdtr.address;
@@ -348,7 +376,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
 	memset(start_vp_input, 0, sizeof(*start_vp_input));
 	start_vp_input->partition_id = -1;
-	start_vp_input->vp_index = cpu;
+	start_vp_input->vp_index = vp_index;
 	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
 	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 07aadf0e839f..323132f5e2f0 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -268,11 +268,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip);
 #else
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
-static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
+static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip) { return 0; }
 #endif
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
@@ -306,6 +306,7 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
 {
 	return __rdmsr(reg);
 }
+int hv_apicid_to_vp_index(u32 apic_id);
 
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
@@ -327,6 +328,7 @@ static inline void hv_set_msr(unsigned int reg, u64 value) { }
 static inline u64 hv_get_msr(unsigned int reg) { return 0; }
 static inline void hv_set_non_nested_msr(unsigned int reg, u64 value) { }
 static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
+static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
 #endif /* CONFIG_HYPERV */
 
 
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index abf0bd76e370..6f5976aca3e8 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -475,7 +475,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_CREATE_PORT				0x0095
 #define HVCALL_CONNECT_PORT				0x0096
 #define HVCALL_START_VP					0x0099
-#define HVCALL_GET_VP_ID_FROM_APIC_ID			0x009a
+#define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
 #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0

base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
-- 
2.43.0


