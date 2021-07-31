Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C33DC5D6
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Jul 2021 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhGaMFp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 31 Jul 2021 08:05:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43920 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhGaMFo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 31 Jul 2021 08:05:44 -0400
Received: from localhost.localdomain (unknown [223.178.63.20])
        by linux.microsoft.com (Postfix) with ESMTPSA id D7532208AABC;
        Sat, 31 Jul 2021 05:05:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7532208AABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1627733138;
        bh=5sTyBcHaScpa7fGKFyjknvMr+JF7VV4Pke88UsBATl4=;
        h=From:To:Cc:Subject:Date:From;
        b=KIxpxnHTIQAbfFH6ToieJHhR8Cqo4N4VFvt0sIZj5dJljMbZV8RhLy9yNqKu7+d18
         A3hzjYZtidolft1Zg8k0B/rB4mb03e7GUvHtVE6KON66BJZGRv0JwHStBDiEdsqRnE
         LllLmhPveje5BwPBQHudpBAqPhf0Lf55EwCArpm8=
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com
Subject: [PATCH v5] hyperv: root partition faults writing to VP ASSIST MSR PAGE
Date:   Sat, 31 Jul 2021 17:35:19 +0530
Message-Id: <20210731120519.17154-1-kumarpraveen@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For Root partition the VP assist pages are pre-determined by the
hypervisor. The Root kernel is not allowed to change them to
different locations. And thus, we are getting below stack as in
current implementation Root is trying to perform write to specific
MSR.

[ 2.778197] unchecked MSR access error: WRMSR to 0x40000073 (tried to
write 0x0000000145ac5001) at rIP: 0xffffffff810c1084
(native_write_msr+0x4/0x30)
[ 2.784867] Call Trace:
[ 2.791507] hv_cpu_init+0xf1/0x1c0
[ 2.798144] ? hyperv_report_panic+0xd0/0xd0
[ 2.804806] cpuhp_invoke_callback+0x11a/0x440
[ 2.811465] ? hv_resume+0x90/0x90
[ 2.818137] cpuhp_issue_call+0x126/0x130
[ 2.824782] __cpuhp_setup_state_cpuslocked+0x102/0x2b0
[ 2.831427] ? hyperv_report_panic+0xd0/0xd0
[ 2.838075] ? hyperv_report_panic+0xd0/0xd0
[ 2.844723] ? hv_resume+0x90/0x90
[ 2.851375] __cpuhp_setup_state+0x3d/0x90
[ 2.858030] hyperv_init+0x14e/0x410
[ 2.864689] ? enable_IR_x2apic+0x190/0x1a0
[ 2.871349] apic_intr_mode_init+0x8b/0x100
[ 2.878017] x86_late_time_init+0x20/0x30
[ 2.884675] start_kernel+0x459/0x4fb
[ 2.891329] secondary_startup_64_no_verify+0xb0/0xbb

Since, the hypervisor already provides the VP assist page for root
partition, we need to memremap the memory from hypervisor for root
kernel to use. The mapping is done in hv_cpu_init during bringup and
is unmaped in hv_cpu_die during teardown.

Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c          | 64 ++++++++++++++++++++----------
 arch/x86/include/asm/hyperv-tlfs.h |  9 +++++
 2 files changed, 53 insertions(+), 20 deletions(-)

changelog:
v1: initial patch
v2: commit message changes, removal of HV_MSR_APIC_ACCESS_AVAILABLE
    check and addition of null check before reading the VP assist MSR
    for root partition
v3: added new data structure to handle VP ASSIST MSR page and done
    handling in hv_cpu_init and hv_cpu_die
v4: better code alignment, VP ASSIST handling correction for root
    partition in hv_cpu_die and renaming of hv_vp_assist_msr_contents
    attribute
v5: disable VP ASSIST page for root partition during hv_cpu_die
---
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6f247e7e07eb..a46bd92c532a 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -44,6 +44,7 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
 
 static int hv_cpu_init(unsigned int cpu)
 {
+	union hv_vp_assist_msr_contents msr = {0};
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 	int ret;
 
@@ -54,25 +55,34 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
 
-	/*
-	 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
-	 * 5.2.1 "GPA Overlay Pages"). Here it must be zeroed out to make sure
-	 * we always write the EOI MSR in hv_apic_eoi_write() *after* the
-	 * EOI optimization is disabled in hv_cpu_die(), otherwise a CPU may
-	 * not be stopped in the case of CPU offlining and the VM will hang.
-	 */
 	if (!*hvp) {
-		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
-	}
-
-	if (*hvp) {
-		u64 val;
-
-		val = vmalloc_to_pfn(*hvp);
-		val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
-			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
-
-		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
+		if (hv_root_partition) {
+			/*
+			 * For Root partition we get the hypervisor provided VP ASSIST
+			 * PAGE, instead of allocating a new page.
+			 */
+			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
+			*hvp = memremap(msr.pfn <<
+					HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
+					PAGE_SIZE, MEMREMAP_WB);
+		} else {
+			/*
+			 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's
+			 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
+			 * out to make sure we always write the EOI MSR in
+			 * hv_apic_eoi_write() *after* theEOI optimization is disabled
+			 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
+			 * case of CPU offlining and the VM will hang.
+			 */
+			*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
+			if (*hvp)
+				msr.pfn = vmalloc_to_pfn(*hvp);
+		}
+		WARN_ON(!(*hvp));
+		if (*hvp) {
+			msr.enable = 1;
+			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
+		}
 	}
 
 	return 0;
@@ -170,8 +180,22 @@ static int hv_cpu_die(unsigned int cpu)
 
 	hv_common_cpu_die(cpu);
 
-	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
-		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
+	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
+		union hv_vp_assist_msr_contents msr = {0};
+		if (hv_root_partition) {
+			/*
+			 * For Root partition the VP ASSIST page is mapped to
+			 * hypervisor provided page, and thus, we unmap the
+			 * page here and nullify it, so that in future we have
+			 * correct page address mapped in hv_cpu_init.
+			 */
+			memunmap(hv_vp_assist_page[cpu]);
+			hv_vp_assist_page[cpu] = NULL;
+			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
+			msr.enable = 0;
+		}
+		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
+	}
 
 	if (hv_reenlightenment_cb == NULL)
 		return 0;
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index f1366ce609e3..2322d6bd5883 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -288,6 +288,15 @@ union hv_x64_msr_hypercall_contents {
 	} __packed;
 };
 
+union hv_vp_assist_msr_contents {
+	u64 as_uint64;
+	struct {
+		u64 enable:1;
+		u64 reserved:11;
+		u64 pfn:52;
+	} __packed;
+};
+
 struct hv_reenlightenment_control {
 	__u64 vector:8;
 	__u64 reserved1:8;
-- 
2.25.1

