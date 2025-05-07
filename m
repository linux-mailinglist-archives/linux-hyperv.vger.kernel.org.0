Return-Path: <linux-hyperv+bounces-5417-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0C3AAE8FA
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 20:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819E01BC3191
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B883228E596;
	Wed,  7 May 2025 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CJR5EipU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E2C28E570;
	Wed,  7 May 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642151; cv=none; b=dCWm4cryGZ4Pd5N2uihE1EvLmynLrX7E4kw/nOMZ7YZTb7xMJgfFE6qXIjtdhknb3KZ2lgsU4ckivEPYTHLjXP6p5/u5RzuKu62bdFeGXZxIjYsDu4bk2R4tPpg3jF8v0q9nVv2bsXlzQ0i1rN31NnG70O61LffZD2uOYf3pFfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642151; c=relaxed/simple;
	bh=gOJoeDZBwYCGxNFcf1eQMv5TSPw3T23p54y9V5IxFTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3bzyxK+csmiDTzNq9Tf1JFGJeYoR+RQP0HIiJPHWGngFn+LSqHACnUM92EbxY1e4xCm9CXc2VMD+J3EtAwTu17uHloCbX0Gx4tB/u56JeGSlH6roOKlgL8w64cikOFV/EXJBY30T9KddllWLB/9G8ZbmEnMyuT7VxbP28PDd0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CJR5EipU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 38DAA2115DDF;
	Wed,  7 May 2025 11:22:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38DAA2115DDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746642149;
	bh=D1+Uvez//hmF/Wdt0SWl0vRh9x1zf/s+EcLLuID038E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJR5EipUBL4dk/HQUZ71fX0AAFT7Y7BPw6V17bpVu3UujVHbwQeCZQWI2MOQjZhKw
	 aXTb57a4EQyXlicJ1M65/KwtzyEvueSHWSZNTD6X0wTnqRRVZTqVMJIu39rygiEgWS
	 XlDxTCdLQX5tIfeX6DCuheQN1UsYRijiSR8DTqYc=
From: Roman Kisel <romank@linux.microsoft.com>
To: ardb@kernel.org,
	bp@alien8.de,
	brgerst@gmail.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	dimitri.sivanich@hpe.com,
	gautham.shenoy@amd.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	imran.f.khan@oracle.com,
	jacob.jun.pan@linux.intel.com,
	jpoimboe@kernel.org,
	justin.ernst@hpe.com,
	kprateek.nayak@amd.com,
	kyle.meyer@hpe.com,
	kys@microsoft.com,
	lenb@kernel.org,
	mhklinux@outlook.com,
	mingo@redhat.com,
	nikunj@amd.com,
	papaluri@amd.com,
	patryk.wlazlyn@linux.intel.com,
	peterz@infradead.org,
	rafael@kernel.org,
	romank@linux.microsoft.com,
	russ.anderson@hpe.com,
	sohil.mehta@intel.com,
	steve.wahl@hpe.com,
	tglx@linutronix.de,
	thomas.lendacky@amd.com,
	tiala@microsoft.com,
	wei.liu@kernel.org,
	yuehaibing@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next 2/2] arch/x86: Provide the CPU number in the wakeup AP callback
Date: Wed,  7 May 2025 11:22:26 -0700
Message-ID: <20250507182227.7421-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507182227.7421-1-romank@linux.microsoft.com>
References: <20250507182227.7421-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When starting APs, confidential guests and paravisor guests
need to know the CPU number, and the pattern of using the linear
search has emerged in several places. With N processors that leads
to the O(N^2) time complexity.

Provide the CPU number in the AP wake up callback so that one can
get the CPU number in constant time.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/coco/sev/core.c             | 13 ++-----------
 arch/x86/hyperv/hv_vtl.c             | 12 ++----------
 arch/x86/hyperv/ivm.c                | 15 ++-------------
 arch/x86/include/asm/apic.h          |  8 ++++----
 arch/x86/include/asm/mshyperv.h      |  5 +++--
 arch/x86/kernel/acpi/madt_wakeup.c   |  2 +-
 arch/x86/kernel/apic/apic_noop.c     |  8 +++++++-
 arch/x86/kernel/apic/apic_numachip.c |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c   |  2 +-
 arch/x86/kernel/smpboot.c            | 10 +++++-----
 10 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b0c1a7a57497..7780d55d1833 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1177,7 +1177,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
 		free_page((unsigned long)vmsa);
 }
 
-static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
+static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
 	struct ghcb_state state;
@@ -1185,7 +1185,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	unsigned long flags;
 	struct ghcb *ghcb;
 	u8 sipi_vector;
-	int cpu, ret;
+	int ret;
 	u64 cr4;
 
 	/*
@@ -1206,15 +1206,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 
 	/* Override start_ip with known protected guest start IP */
 	start_ip = real_mode_header->sev_es_trampoline_start;
-
-	/* Find the logical CPU for the APIC ID */
-	for_each_present_cpu(cpu) {
-		if (arch_match_cpu_phys_id(cpu, apic_id))
-			break;
-	}
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
-
 	cur_vmsa = per_cpu(sev_vmsa, cpu);
 
 	/*
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 2f32ac1ae40e..3d149a2ca4c8 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -211,17 +211,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 	return ret;
 }
 
-static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
+static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip, unsigned int cpu)
 {
-	int vp_index, cpu;
-
-	/* Find the logical CPU for the APIC ID */
-	for_each_present_cpu(cpu) {
-		if (arch_match_cpu_phys_id(cpu, apicid))
-			break;
-	}
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+	int vp_index;
 
 	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
 	vp_index = hv_apicid_to_vp_index(apicid);
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 0cc239cdb4da..e21557b24d19 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -289,7 +289,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
@@ -298,7 +298,7 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
 	u64 ret, retry = 5;
 	struct hv_enable_vp_vtl *start_vp_input;
 	unsigned long flags;
-	int cpu, vp_index;
+	int vp_index;
 
 	if (!vmsa)
 		return -ENOMEM;
@@ -308,17 +308,6 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
 	if (vp_index < 0 || vp_index > ms_hyperv.max_vp_index)
 		return -EINVAL;
 
-	/*
-	 * Find the Linux CPU number for addressing the per-CPU data, and it
-	 * might not be the same as APIC ID.
-	 */
-	for_each_present_cpu(cpu) {
-		if (arch_match_cpu_phys_id(cpu, apic_id))
-			break;
-	}
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
-
 	native_store_gdt(&gdtr);
 
 	vmsa->gdtr.base = gdtr.address;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index c903d358405d..eaf43d446203 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -313,9 +313,9 @@ struct apic {
 	u32	(*get_apic_id)(u32 id);
 
 	/* wakeup_secondary_cpu */
-	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip, unsigned int cpu);
 	/* wakeup secondary CPU using 64-bit wakeup point */
-	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, unsigned int cpu);
 
 	char	*name;
 };
@@ -333,8 +333,8 @@ struct apic_override {
 	void	(*send_IPI_self)(int vector);
 	u64	(*icr_read)(void);
 	void	(*icr_write)(u32 low, u32 high);
-	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
-	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip, unsigned int cpu);
+	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, unsigned int cpu);
 };
 
 /*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 0b9a3a307d06..5ec92e3e2e37 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -268,11 +268,12 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
-int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip);
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu);
 #else
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
-static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip) { return 0; }
+static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip,
+		unsigned int cpu) { return 0; }
 #endif
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index f36f28405dcc..6d7603511f52 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -126,7 +126,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 	return 0;
 }
 
-static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
+static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip, unsigned int cpu)
 {
 	if (!acpi_mp_wake_mailbox_paddr) {
 		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index b5bb7a2e8340..58abb941c45b 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -27,7 +27,13 @@ static void noop_send_IPI_allbutself(int vector) { }
 static void noop_send_IPI_all(int vector) { }
 static void noop_send_IPI_self(int vector) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
-static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
+
+static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip,
+	unsigned int cpu)
+{
+	return -1;
+}
+
 static u64 noop_apic_icr_read(void) { return 0; }
 static u32 noop_get_apic_id(u32 apicid) { return 0; }
 static void noop_apic_eoi(void) { }
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 16410f087b7a..333536b89bde 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,7 +56,7 @@ static void numachip2_apic_icr_write(int apicid, unsigned int val)
 	numachip2_write32_lcsr(NUMACHIP2_APIC_ICR, (apicid << 12) | val);
 }
 
-static int numachip_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
+static int numachip_wakeup_secondary(u32 phys_apicid, unsigned long start_rip, unsigned int cpu)
 {
 	numachip_apic_icr_write(phys_apicid, APIC_DM_INIT);
 	numachip_apic_icr_write(phys_apicid, APIC_DM_STARTUP |
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 7fef504ca508..15209f220e1f 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -667,7 +667,7 @@ static __init void build_uv_gr_table(void)
 	}
 }
 
-static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
+static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip, unsigned int cpu)
 {
 	unsigned long val;
 	int pnode;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d6cf1e23c2a3..d52e9238e9fd 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -695,7 +695,7 @@ static void send_init_sequence(u32 phys_apicid)
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
+static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip, unsigned int cpu)
 {
 	unsigned long send_status = 0, accept_status = 0;
 	int num_starts, j, maxlvt;
@@ -842,7 +842,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
  * Returns zero if startup was successfully sent, else error code from
  * ->wakeup_secondary_cpu.
  */
-static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
+static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
 	int ret;
@@ -896,11 +896,11 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 	 * - Use an INIT boot APIC message
 	 */
 	if (apic->wakeup_secondary_cpu_64)
-		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
+		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip, cpu);
 	else if (apic->wakeup_secondary_cpu)
-		ret = apic->wakeup_secondary_cpu(apicid, start_ip);
+		ret = apic->wakeup_secondary_cpu(apicid, start_ip, cpu);
 	else
-		ret = wakeup_secondary_cpu_via_init(apicid, start_ip);
+		ret = wakeup_secondary_cpu_via_init(apicid, start_ip, cpu);
 
 	/* If the wakeup mechanism failed, cleanup the warm reset vector */
 	if (ret)
-- 
2.43.0


