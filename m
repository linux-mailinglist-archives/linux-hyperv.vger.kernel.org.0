Return-Path: <linux-hyperv+bounces-1024-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FACE7F4DAE
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 18:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406321C20839
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6083D3A5;
	Wed, 22 Nov 2023 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KCTatUdl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC0B3A4;
	Wed, 22 Nov 2023 09:01:32 -0800 (PST)
Received: from localhost.localdomain (77-166-152-30.fixed.kpn.net [77.166.152.30])
	by linux.microsoft.com (Postfix) with ESMTPSA id EFB6A20B74C0;
	Wed, 22 Nov 2023 09:01:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFB6A20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700672492;
	bh=SyJPVx2JrmsCqhSu/Lg/Nm3EngUrOFky3GEOUF76eKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KCTatUdliXlguFtxNBDUPDpF5OjuHuE4Yes3AcmnnhK9OcZuGnCuYmz2cFENbRZfX
	 4EAzk9gj68teUCXZxphaBMILXskzmpHtZvt5zGMEo5RIcVRq0RapsPdpezoS4OXMMh
	 gO4eh1mn0IkXvTK4hSSqGg5CueRvF1tVYCJaM2eo=
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Kelley <mhkelley58@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	x86@kernel.org,
	Dexuan Cui <decui@microsoft.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	stefan.bader@canonical.com,
	tim.gardner@canonical.com,
	roxana.nicolescu@canonical.com,
	cascardo@canonical.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early TDX init
Date: Wed, 22 Nov 2023 18:01:04 +0100
Message-Id: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for additional CPUID bits to identify TDX guests running with Trust
Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).

In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is visible
to Linux running as an L2 TD VM. This is because a majority of TDX facilities
are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
aware mechanisms for what's left. So currently such guests do not have
X86_FEATURE_TDX_GUEST set.

We want the kernel to have X86_FEATURE_TDX_GUEST set for all TDX guests so we
need to check these additional CPUID bits, but we skip further initialization
in the function as we aren't guaranteed access to TDX module calls.

Cc: <stable@vger.kernel.org> # v6.5+
Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/coco/tdx/tdx.c    | 29 ++++++++++++++++++++++++++---
 arch/x86/include/asm/tdx.h |  3 +++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..c7bbbaaf654d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <asm/coco.h>
+#include <asm/hyperv-tlfs.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 #include <asm/insn.h>
@@ -37,6 +38,8 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+bool tdx_partitioning_active;
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __tdx_hypercall_failed(void)
 {
@@ -757,19 +760,38 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return true;
 }
 
+
+static bool early_is_hv_tdx_partitioning(void)
+{
+	u32 eax, ebx, ecx, edx;
+	cpuid(HYPERV_CPUID_ISOLATION_CONFIG, &eax, &ebx, &ecx, &edx);
+	return eax & HV_PARAVISOR_PRESENT &&
+	       (ebx & HV_ISOLATION_TYPE) == HV_ISOLATION_TYPE_TDX;
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
 	u32 eax, sig[3];
 
 	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
-
-	if (memcmp(TDX_IDENT, sig, sizeof(sig)))
-		return;
+	if (memcmp(TDX_IDENT, sig, sizeof(sig))) {
+		tdx_partitioning_active = early_is_hv_tdx_partitioning();
+		if (!tdx_partitioning_active)
+			return;
+	}
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
 	cc_vendor = CC_VENDOR_INTEL;
+
+	/*
+	 * Need to defer cc_mask and page visibility callback initializations
+	 * to a TD-partitioning aware implementation.
+	 */
+	if (tdx_partitioning_active)
+		goto exit;
+
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
 
@@ -820,5 +842,6 @@ void __init tdx_early_init(void)
 	 */
 	x86_cpuinit.parallel_bringup = false;
 
+exit:
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 603e6d1e9d4a..fe22f8675859 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -52,6 +52,7 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
+extern bool tdx_partitioning_active;
 #else
 
 static inline void tdx_early_init(void) { };
@@ -71,6 +72,8 @@ static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
 {
 	return -ENODEV;
 }
+
+#define tdx_partitioning_active false
 #endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
-- 
2.39.2


