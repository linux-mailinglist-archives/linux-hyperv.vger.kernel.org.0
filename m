Return-Path: <linux-hyperv+bounces-5266-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3929AA560C
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 22:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290DF1BA4F9C
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 20:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C86295511;
	Wed, 30 Apr 2025 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GAmRbiKk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E722D0AA0;
	Wed, 30 Apr 2025 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046044; cv=none; b=cT/NyHM33OaFkRoDFD8CyxYA+uZhth3DYUtXtNME8Oh1HQj2+a3mQxNd3cBWb1S7EnXj/jYjKlykbSjJ/2PreAOnhlNsaJqWRQUPpbzxlH6m5ySrN4Iq/LV8Z6jYFBMmml8aFTU/Hyfi6eHYrj/tGVGpSgeSwVV/zveOP2G0HHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046044; c=relaxed/simple;
	bh=JFj3gqiYMHHkh1+V3IcupzITwZcKiX6yhKrNge0XZKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNtasX8dbpM9Kf3Q2j8VGx/E4leDO0iwdpKyVzqSTyQ2/CLGtOG+f97HMTGZfvVe0lQb9OnkXdEN6U5yZnTmFTWXYjb/IF1JU6tBF2JOj4sirj2VMbrRxQyHuaj68c7JzwLAEdJjgbajK5O/0G8ZtEg5EI9ERi20WOTbSvimI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GAmRbiKk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 49F38204E7F5;
	Wed, 30 Apr 2025 13:47:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 49F38204E7F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746046042;
	bh=CUs5AcUf2zpF9eBCn9jN4W1S8g6NqRFwkxNSbvV6Yz4=;
	h=From:To:Cc:Subject:Date:From;
	b=GAmRbiKksd9tKtXE6aPUA37zhWdu7dwsHjtA8xVRKokLFk08wOeVcVsUm8KdwP/8t
	 YfZnakFezCOwb0BRjoPb1Hbj6qEj4T3kH4vumftS1Wra6pCIRh19SI206VYONZg0Wb
	 MpkNtEDj4NFf8v/gl56DRGSbg2aaXIa7peWx85gU=
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
Subject: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the wakeup AP callback
Date: Wed, 30 Apr 2025 13:47:20 -0700
Message-ID: <20250430204720.108962-1-romank@linux.microsoft.com>
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
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
The diff in ivm.c might catch your eye but that code mixes up the
APIC ID and the CPU number anyway. That is fixed in another patch:
https://lore.kernel.org/linux-hyperv/20250428182705.132755-1-romank@linux.microsoft.com/
independently of this one (being an optimization).
I separated the two as this one might be more disputatious due to
the change in the API (although it is a tiny one and comes with
the benefits).

[V3]
	- Fixed the cpu nummber to be unsigned int within the patch and
	  in the do_boot_cpu() function.
	** Thank you, Thomas! **

[V2]
	https://lore.kernel.org/linux-hyperv/20250430161413.276759-1-romank@linux.microsoft.com/
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
 arch/x86/include/asm/mshyperv.h    |  5 +++--
 arch/x86/kernel/acpi/madt_wakeup.c |  2 +-
 arch/x86/kernel/apic/apic_noop.c   |  8 +++++++-
 arch/x86/kernel/apic/x2apic_uv_x.c |  2 +-
 arch/x86/kernel/smpboot.c          | 10 +++++-----
 9 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492efc5d94..8b6d310b61b9 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1179,7 +1179,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
 		free_page((unsigned long)vmsa);
 }
 
-static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
+static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned int cpu)
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
index 582fe820e29c..4d6e0e198041 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -237,17 +237,9 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 	return ret;
 }
 
-static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
+static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip, unsigned int cpu)
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
index c0039a90e9e0..6025da891a83 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index f21ff1932699..33f677e2db75 100644
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
index 07aadf0e839f..cab952f722e4 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -268,11 +268,12 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
-int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
+int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu);
 #else
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
-static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
+static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip,
+		unsigned int cpu) { return 0; }
 #endif
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index d5ef6215583b..f48581888d53 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -169,7 +169,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
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
index c10850ae6f09..b013296b100f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -715,7 +715,7 @@ static void send_init_sequence(u32 phys_apicid)
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
+static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip, unsigned int cpu)
 {
 	unsigned long send_status = 0, accept_status = 0;
 	int num_starts, j, maxlvt;
@@ -862,7 +862,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
  * Returns zero if startup was successfully sent, else error code from
  * ->wakeup_secondary_cpu.
  */
-static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
+static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
 	int ret;
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


