Return-Path: <linux-hyperv+bounces-5099-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4E4A9BA43
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 23:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F9A4A81E3
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CA0288CA3;
	Thu, 24 Apr 2025 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gnx8C//L"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BAB285401;
	Thu, 24 Apr 2025 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531870; cv=none; b=nTQg+WXBTU2dbSxtAeZI27pQHxORT2Qr9avCJlXk0ebcP4EaE4KM6Nkt+gamlfqh6AvK3lUdyqMolxwB6DiHWhLtnbRIWQKngLKLsvi7GjsKFMOrJR9Mx5W6e7gwpU0KIvIFtawNeOq+c6BeyRFZVc2njy5GWuGiMw2HyuSqNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531870; c=relaxed/simple;
	bh=JfOhJ0MchQZpsxLJVqYLz0c+hOchVxBXTi7+XN9mj4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhA1CW5rUOAE9cuC4QoO7YveTcKnNdJTS4VkMpDpV/rLtgbK2TbhGjRPe9fL4LlmcofXD0FPhx2RvQ0gY3bj2BDrnlmrOy6nd96PaEAWYXlFuQWkoy5F0OUlZS6dpwWpqhNFeiyUx4wr7RBpljf5px5dI2vs9WrPwyl/LJFtUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gnx8C//L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.147.157])
	by linux.microsoft.com (Postfix) with ESMTPSA id DF5F621130B1;
	Thu, 24 Apr 2025 14:57:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF5F621130B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745531868;
	bh=SS4fk0g4V1UJEyIHeUf6RMBXb0X+qVVY+q0Dv5OQQCA=;
	h=From:To:Cc:Subject:Date:From;
	b=gnx8C//LJ6GkZ+3YTFQ55JHpLCO7COOn8XGsZOlhfsgMTNBStfBK3iuwABYQJVpFc
	 PurVKD4tBssVBvX2Nw9i8X2W3T1F42XKTMYZmiNLWA29QtGCrhoEcA28m5aAXX3YMf
	 w91HRMxBv5Gi8evmTTMIRx4EBfaCHlQOZoQNJT2Y=
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
Subject: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP ID confusion in hv_snp_boot_ap()
Date: Thu, 24 Apr 2025 14:57:46 -0700
Message-ID: <20250424215746.467281-1-romank@linux.microsoft.com>
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
function uses that START_VP hypercall but passes as VP ID to it what
it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.

As those two aren't generally interchangeable, that may lead to hung
APs if VP IDs and APIC IDs don't match, e.g. APIC IDs might be sparse
whereas VP IDs never are.

Update the parameter names to avoid confusion as to what the parameter
is. Use the APIC ID to VP ID conversion to provide correct input to the
hypercall.

Cc: stable@vger.kernel.org
Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c       | 33 ++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_vtl.c        | 34 +--------------------------------
 arch/x86/hyperv/ivm.c           | 11 +++++++++--
 arch/x86/include/asm/mshyperv.h |  5 +++--
 4 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index ddeb40930bc8..23422342a091 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -706,3 +706,36 @@ bool hv_is_hyperv_initialized(void)
 	return hypercall_msr.enable;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+int hv_apicid_to_vp_id(u32 apic_id)
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
+	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
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
+EXPORT_SYMBOL_GPL(hv_apicid_to_vp_id);
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 582fe820e29c..8bc4f0121e5e 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -205,38 +205,6 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
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
 	int vp_id, cpu;
@@ -250,7 +218,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 		return -EINVAL;
 
 	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
-	vp_id = hv_vtl_apicid_to_vp_id(apicid);
+	vp_id = hv_apicid_to_vp_id(apicid);
 
 	if (vp_id < 0) {
 		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index c0039a90e9e0..e3c32bb0d0cf 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
@@ -297,10 +297,17 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	u64 ret, retry = 5;
 	struct hv_enable_vp_vtl *start_vp_input;
 	unsigned long flags;
+	int vp_id;
 
 	if (!vmsa)
 		return -ENOMEM;
 
+	vp_id = hv_apicid_to_vp_id(apic_id);
+
+	/* The BSP or an error */
+	if (vp_id <= 0)
+		return -EINVAL;
+
 	native_store_gdt(&gdtr);
 
 	vmsa->gdtr.base = gdtr.address;
@@ -348,7 +355,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
 	memset(start_vp_input, 0, sizeof(*start_vp_input));
 	start_vp_input->partition_id = -1;
-	start_vp_input->vp_index = cpu;
+	start_vp_input->vp_index = vp_id;
 	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
 	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 07aadf0e839f..ae62a34bfd1e 100644
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
@@ -329,6 +329,7 @@ static inline void hv_set_non_nested_msr(unsigned int reg, u64 value) { }
 static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
 #endif /* CONFIG_HYPERV */
 
+int hv_apicid_to_vp_id(u32 apic_id);
 
 #ifdef CONFIG_HYPERV_VTL_MODE
 void __init hv_vtl_init_platform(void);

base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
-- 
2.43.0


