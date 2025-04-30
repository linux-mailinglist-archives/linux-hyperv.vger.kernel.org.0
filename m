Return-Path: <linux-hyperv+bounces-5254-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63683AA5145
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 18:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD8E1C04120
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F382609EC;
	Wed, 30 Apr 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I7gbwUv0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3A3F9D2;
	Wed, 30 Apr 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029658; cv=none; b=l5LzgtZUa8k5vMZOBV+hiB6moJ3fPY/IoaMsJ+LFrtgSAUdTaXUH/EfqPEIPsibw0+P82R/f9hX7e+z0kFPynS5rIaWygZsYJUKNOhVJZEzKAium5C9qsuelZuUDn/MSBNSz3YtqsOLpIHQoS7OwVbp1oBAE2wbQ/rxS5wX94uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029658; c=relaxed/simple;
	bh=xpmQ+BGtx8m609EARhSYhsheeO7ZrcF2u+r1XAIFE0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/L/0Amz2kvI+9NBq85o5zAk1uCtMm0RXjABi/eQUkuF4DWf98juRZsQcvdOUC7iVr+kidIb4EPCVJMKQNTGCCWt6cLMi87omo9gl6hU7kPGKtS0X21rtDVLKdROZNlIM02unzG2/9xpnVVHh93/IcDUXJFPkGMFIi2v9qMiLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I7gbwUv0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 994BC20BCAD1;
	Wed, 30 Apr 2025 09:14:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 994BC20BCAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746029655;
	bh=vTj4i+3Z0et1oqhVuavrgSvDIAQcRm5A2DxSvwq3gY4=;
	h=From:To:Cc:Subject:Date:From;
	b=I7gbwUv0nb79WoAfkdo1OAACJxkXFidfW51TfLP+1mP6xeg4wkURaoJg6LODpcK2h
	 rGRO20YaeWo6g3vrsi0l540U5y3SVOAZVnrn8sY0TIOo6TtBrQnew8ykl+nddhQ2oW
	 hwzvbf/IXJvVpLLwFXS5D3oMQoHKPhQH/M8Nu+Kk=
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
Subject: [PATCH hyperv-next v2] arch/x86: Provide the CPU number in the wakeup AP callback
Date: Wed, 30 Apr 2025 09:14:13 -0700
Message-ID: <20250430161413.276759-1-romank@linux.microsoft.com>
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
The diff in ivm.c might catch your eye but that code mixes up the
APIC ID and the CPU number anyway. That is fixed in another patch:
https://lore.kernel.org/linux-hyperv/20250428182705.132755-1-romank@linux.microsoft.com/
independently of this one (being an optimization).
I separated the two as this one might be more disputatious due to
the change in the API (although it is a tiny one and comes with
the benefits).

[V2]
	- Remove the struct used in v1 in favor of passing the CPU number
	  directly to the callback not to increase complexity.
	** Thank you, Michael! **
[V1]
	https://lore.kernel.org/linux-hyperv/20250428225948.810147-1-romank@linux.microsoft.com/
---
 arch/x86/coco/sev/core.c           | 13 ++-----------
 arch/x86/hyperv/hv_vtl.c           | 12 ++----------
 arch/x86/hyperv/ivm.c              |  2 +-
 arch/x86/include/asm/apic.h        |  8 ++++----
 arch/x86/include/asm/mshyperv.h    |  4 ++--
 arch/x86/kernel/acpi/madt_wakeup.c |  2 +-
 arch/x86/kernel/apic/apic_noop.c   |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c |  2 +-
 arch/x86/kernel/smpboot.c          |  8 ++++----
 9 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492efc5d94..e7b6dba30a0a 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1179,7 +1179,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
 		free_page((unsigned long)vmsa);
 }
 
-static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
+static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, int cpu)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
 	struct ghcb_state state;
@@ -1187,7 +1187,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	unsigned long flags;
 	struct ghcb *ghcb;
 	u8 sipi_vector;
-	int cpu, ret;
+	int ret;
 	u64 cr4;
 
 	/*
@@ -1208,15 +1208,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 
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
index 582fe820e29c..5784b6c56ca4 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -237,17 +237,9 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 	return ret;
 }
 
-static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
+static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip, int cpu)
 {
-	int vp_id, cpu;
-
-	/* Find the logical CPU for the APIC ID */
-	for_each_present_cpu(cpu) {
-		if (arch_match_cpu_phys_id(cpu, apicid))
-			break;
-	}
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+	int vp_id;
 
 	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
 	vp_id = hv_vtl_apicid_to_vp_id(apicid);
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index c0039a90e9e0..ba744dbc22bb 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, int cpu)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index f21ff1932699..a480f7626847 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -313,9 +313,9 @@ struct apic {
 	u32	(*get_apic_id)(u32 id);
 
 	/* wakeup_secondary_cpu */
-	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip, int cpu);
 	/* wakeup secondary CPU using 64-bit wakeup point */
-	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, int cpu);
 
 	char	*name;
 };
@@ -333,8 +333,8 @@ struct apic_override {
 	void	(*send_IPI_self)(int vector);
 	u64	(*icr_read)(void);
 	void	(*icr_write)(u32 low, u32 high);
-	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
-	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip, int cpu);
+	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, int cpu);
 };
 
 /*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 07aadf0e839f..abca9d8d4a82 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -268,11 +268,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, int cpu);
 #else
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
-static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
+static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, int cpu) { return 0; }
 #endif
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index d5ef6215583b..d95c806f0e93 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -169,7 +169,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 	return 0;
 }
 
-static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
+static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip, int cpu)
 {
 	if (!acpi_mp_wake_mailbox_paddr) {
 		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index b5bb7a2e8340..cab7cac16f53 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -27,7 +27,7 @@ static void noop_send_IPI_allbutself(int vector) { }
 static void noop_send_IPI_all(int vector) { }
 static void noop_send_IPI_self(int vector) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
-static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
+static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip, int cpu) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
 static u32 noop_get_apic_id(u32 apicid) { return 0; }
 static void noop_apic_eoi(void) { }
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 7fef504ca508..f8000555127b 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -667,7 +667,7 @@ static __init void build_uv_gr_table(void)
 	}
 }
 
-static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
+static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip, int cpu)
 {
 	unsigned long val;
 	int pnode;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850ae6f09..4b514e485f9c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -715,7 +715,7 @@ static void send_init_sequence(u32 phys_apicid)
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
+static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip, int cpu)
 {
 	unsigned long send_status = 0, accept_status = 0;
 	int num_starts, j, maxlvt;
@@ -916,11 +916,11 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
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

base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
-- 
2.43.0


