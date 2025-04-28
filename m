Return-Path: <linux-hyperv+bounces-5215-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E86BA9FD5F
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Apr 2025 01:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E611A8810D
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 23:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF1213E67;
	Mon, 28 Apr 2025 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HiiMjvnc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D331721505E;
	Mon, 28 Apr 2025 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881193; cv=none; b=oHXvHLgrXta4IARI7JTFUac2poMJXoHeoP/utZ9wzDKjS61FdWyC1JvmegRRZMuER5BSo3bHw0UI5PfSHgoR3yoe5c7LYSvvXj1bQm5U2fBs1P8Yr+iVd+CAYYq2Ti0iu0ndhc4quJ1Hwjjx3nTjUjMohme9CEowJcg/idpLl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881193; c=relaxed/simple;
	bh=L4te2qUMfMTITd5+XghShl31UbVtFM2OlQ00sskQCKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qxl0BU/pA0NrILk85O236KuHWFhL3Xh8uSSKkqEfva8+sIC1c3L4MjX40v16tKFTEddh6AdChR5LhKnM3A0YvdNmqcYglcWvhWfhr0b1fIadqbnDYaQ06AjTDwL0nzWwi3grnBPIDkpOoI152qG94cdbq+YVdb3ZQSzW9n3PDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HiiMjvnc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.183])
	by linux.microsoft.com (Postfix) with ESMTPSA id 348FB211AD04;
	Mon, 28 Apr 2025 15:59:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 348FB211AD04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745881191;
	bh=Ki5KeXAVraOSauDknkltjux3zzRVtw6GUNk+0cIhOFo=;
	h=From:To:Cc:Subject:Date:From;
	b=HiiMjvnc+CRiV2YRuVssXcQRX7YaNCzNgfj8iZi0/tVyaknO7v6obfSB9CuJAHtQm
	 2ZBx5jmQxdwbG82mGk5NiNosF8rmzfzjRYGFv8OkKhGKhmJmVUGZ/aUAzDgdB7p9VY
	 4QdnBzjObibxChNJWE+hfpVc3Z5ZLGJuTyTwltXs=
From: Roman Kisel <romank@linux.microsoft.com>
To: ardb@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	dimitri.sivanich@hpe.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	imran.f.khan@oracle.com,
	jacob.jun.pan@linux.intel.com,
	jgross@suse.com,
	justin.ernst@hpe.com,
	kprateek.nayak@amd.com,
	kyle.meyer@hpe.com,
	kys@microsoft.com,
	lenb@kernel.org,
	mingo@redhat.com,
	nikunj@amd.com,
	papaluri@amd.com,
	perry.yuan@amd.com,
	peterz@infradead.org,
	rafael@kernel.org,
	romank@linux.microsoft.com,
	russ.anderson@hpe.com,
	steve.wahl@hpe.com,
	tglx@linutronix.de,
	thomas.lendacky@amd.com,
	tim.c.chen@linux.intel.com,
	tony.luck@intel.com,
	wei.liu@kernel.org,
	xin@zytor.com,
	yuehaibing@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next] arch/x86: Provide the CPU number in the wakeup AP callback
Date: Mon, 28 Apr 2025 15:59:47 -0700
Message-ID: <20250428225948.810147-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
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
---
 arch/x86/coco/sev/core.c           | 18 ++++++++----------
 arch/x86/hyperv/hv_vtl.c           | 17 +++++++----------
 arch/x86/hyperv/ivm.c              |  8 +++++++-
 arch/x86/include/asm/apic.h        | 14 ++++++++++----
 arch/x86/include/asm/mshyperv.h    |  5 +++--
 arch/x86/kernel/acpi/madt_wakeup.c |  8 +++++++-
 arch/x86/kernel/apic/apic_noop.c   |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c |  7 ++++++-
 arch/x86/kernel/smpboot.c          | 19 +++++++++++++++----
 9 files changed, 64 insertions(+), 34 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492efc5d94..063f176854fd 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1179,17 +1179,24 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
 		free_page((unsigned long)vmsa);
 }
 
-static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
+static int wakeup_cpu_via_vmgexit(struct wakeup_secondary_cpu_data *wakeup)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
 	struct ghcb_state state;
+	unsigned long start_ip;
 	struct svsm_ca *caa;
 	unsigned long flags;
 	struct ghcb *ghcb;
 	u8 sipi_vector;
 	int cpu, ret;
+	u32 apic_id;
 	u64 cr4;
 
+
+	cpu = wakeup->cpu;
+	apic_id = wakeup->apicid;
+	start_ip = wakeup->start_ip;
+
 	/*
 	 * The hypervisor SNP feature support check has happened earlier, just check
 	 * the AP_CREATION one here.
@@ -1208,15 +1215,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 
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
index 582fe820e29c..7ed3c639d612 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -237,17 +237,14 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 	return ret;
 }
 
-static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
+static int hv_vtl_wakeup_secondary_cpu(struct wakeup_secondary_cpu_data *wakeup)
 {
-	int vp_id, cpu;
+	unsigned long start_ip;
+	u32 apicid;
+	int vp_id;
 
-	/* Find the logical CPU for the APIC ID */
-	for_each_present_cpu(cpu) {
-		if (arch_match_cpu_phys_id(cpu, apicid))
-			break;
-	}
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+	apicid = wakeup->apicid;
+	start_ip = wakeup->start_ip;
 
 	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
 	vp_id = hv_vtl_apicid_to_vp_id(apicid);
@@ -261,7 +258,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 		return -EINVAL;
 	}
 
-	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
+	return hv_vtl_bringup_vcpu(vp_id, wakeup->cpu, start_ip);
 }
 
 int __init hv_vtl_early_init(void)
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index c0039a90e9e0..6037cabc1ae0 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <asm/apic.h>
 #include <asm/svm.h>
 #include <asm/sev.h>
 #include <asm/io.h>
@@ -288,7 +289,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
+int hv_snp_boot_ap(struct wakeup_secondary_cpu_data *wakeup)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
@@ -296,11 +297,16 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 	struct desc_ptr gdtr;
 	u64 ret, retry = 5;
 	struct hv_enable_vp_vtl *start_vp_input;
+	unsigned long start_ip;
 	unsigned long flags;
+	u32 cpu;
 
 	if (!vmsa)
 		return -ENOMEM;
 
+	cpu = wakeup->cpu;
+	start_ip = wakeup->apicid;
+
 	native_store_gdt(&gdtr);
 
 	vmsa->gdtr.base = gdtr.address;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index f21ff1932699..7e660125f749 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -262,6 +262,12 @@ extern void __init check_x2apic(void);
 
 struct irq_data;
 
+struct wakeup_secondary_cpu_data {
+	int cpu;
+	u32 apicid;
+	unsigned long start_ip;
+};
+
 /*
  * Copyright 2004 James Cleverdon, IBM.
  *
@@ -313,9 +319,9 @@ struct apic {
 	u32	(*get_apic_id)(u32 id);
 
 	/* wakeup_secondary_cpu */
-	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu)(struct wakeup_secondary_cpu_data *data);
 	/* wakeup secondary CPU using 64-bit wakeup point */
-	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu_64)(struct wakeup_secondary_cpu_data *data);
 
 	char	*name;
 };
@@ -333,8 +339,8 @@ struct apic_override {
 	void	(*send_IPI_self)(int vector);
 	u64	(*icr_read)(void);
 	void	(*icr_write)(u32 low, u32 high);
-	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
-	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu)(struct wakeup_secondary_cpu_data *data);
+	int	(*wakeup_secondary_cpu_64)(struct wakeup_secondary_cpu_data *data);
 };
 
 /*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 07aadf0e839f..62c64778ad01 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -6,6 +6,7 @@
 #include <linux/nmi.h>
 #include <linux/msi.h>
 #include <linux/io.h>
+#include <asm/apic.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
 #include <hyperv/hvhdk.h>
@@ -268,11 +269,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
+int hv_snp_boot_ap(struct wakeup_secondary_cpu_data *wakeup);
 #else
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
-static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
+static inline int hv_snp_boot_ap(struct wakeup_secondary_cpu_data *wakeup) { return 0; }
 #endif
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index d5ef6215583b..5de1bd4e49ed 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -169,8 +169,14 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 	return 0;
 }
 
-static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
+static int acpi_wakeup_cpu(struct wakeup_secondary_cpu_data *wakeup)
 {
+	unsigned long start_ip;
+	u32 apicid;
+
+	start_ip = wakeup->start_ip;
+	apicid = wakeup->apicid;
+
 	if (!acpi_mp_wake_mailbox_paddr) {
 		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
 		return -EOPNOTSUPP;
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index b5bb7a2e8340..dd4ba29042f9 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -27,7 +27,7 @@ static void noop_send_IPI_allbutself(int vector) { }
 static void noop_send_IPI_all(int vector) { }
 static void noop_send_IPI_self(int vector) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
-static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
+static int noop_wakeup_secondary_cpu(struct wakeup_secondary_cpu_data *data) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
 static u32 noop_get_apic_id(u32 apicid) { return 0; }
 static void noop_apic_eoi(void) { }
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 7fef504ca508..b76f865c31ef 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -667,11 +667,16 @@ static __init void build_uv_gr_table(void)
 	}
 }
 
-static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
+static int uv_wakeup_secondary(struct wakeup_secondary_cpu_data *wakeup)
 {
+	unsigned long start_rip;
 	unsigned long val;
+	u32 phys_apicid;
 	int pnode;
 
+	phys_apicid = wakeup->apicid;
+	start_rip = wakeup->start_ip;
+
 	pnode = uv_apicid_to_pnode(phys_apicid);
 
 	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850ae6f09..341620f1e1fe 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -715,8 +715,14 @@ static void send_init_sequence(u32 phys_apicid)
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
+static int wakeup_secondary_cpu_via_init(struct wakeup_secondary_cpu_data *wakeup)
 {
+	unsigned long start_eip;
+	u32 phys_apicid;
+
+	start_eip = wakeup->start_ip;
+	phys_apicid = wakeup->apicid;
+
 	unsigned long send_status = 0, accept_status = 0;
 	int num_starts, j, maxlvt;
 
@@ -865,6 +871,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
+	struct wakeup_secondary_cpu_data wakeup;
 	int ret;
 
 #ifdef CONFIG_X86_64
@@ -906,6 +913,10 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 		}
 	}
 
+	wakeup.cpu = cpu;
+	wakeup.apicid = apicid;
+	wakeup.start_ip = start_ip;
+
 	smp_mb();
 
 	/*
@@ -916,11 +927,11 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 	 * - Use an INIT boot APIC message
 	 */
 	if (apic->wakeup_secondary_cpu_64)
-		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
+		ret = apic->wakeup_secondary_cpu_64(&wakeup);
 	else if (apic->wakeup_secondary_cpu)
-		ret = apic->wakeup_secondary_cpu(apicid, start_ip);
+		ret = apic->wakeup_secondary_cpu(&wakeup);
 	else
-		ret = wakeup_secondary_cpu_via_init(apicid, start_ip);
+		ret = wakeup_secondary_cpu_via_init(&wakeup);
 
 	/* If the wakeup mechanism failed, cleanup the warm reset vector */
 	if (ret)

base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
-- 
2.43.0


