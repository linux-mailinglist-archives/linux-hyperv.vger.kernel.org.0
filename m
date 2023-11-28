Return-Path: <linux-hyperv+bounces-1114-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB777FC6B2
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 22:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74145281830
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0035744370;
	Tue, 28 Nov 2023 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+orgIKu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA244366;
	Tue, 28 Nov 2023 21:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08B5C433C8;
	Tue, 28 Nov 2023 21:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205580;
	bh=KvPIR5/RgJS18Y9VyiocKdiV2Sj+qnkbBx9d3kX0Ja4=;
	h=From:To:Cc:Subject:Date:From;
	b=n+orgIKubMeVDKBTG693l8yMKXzWfgj7sLwYltDan58tZAz/5HAY752808RVuCvh0
	 j0lzgHF1XUiHP/VVrxHdNrGzv+ujE2WRq6+xNyl2XeLUnWiP7D+5FkinvvHKCreyub
	 d4kn6lo2dSIW0tCC+DP0XT6B2hamaKngynLefUdA8zL3xxJ1bcC0KF+FgKiyQIWPkA
	 Jgh2wRVmyoX2MJQxg8ZEWvVGqTNB4mpLEm7F1vYoB4ljK+Q6VhteLnnWqQetE4H0rR
	 f9cBGBfoPadHxPdSmew0CDp2MhET9lS5bw4/Mw8Oaf5deoE4gazFIRJmwDSA1ByFM0
	 rj2x84QvjATXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/40] x86/hyperv: Fix the detection of E820_TYPE_PRAM in a Gen2 VM
Date: Tue, 28 Nov 2023 16:05:07 -0500
Message-ID: <20231128210615.875085-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit 7e8037b099c0bbe8f2109dc452dbcab8d400fc53 ]

A Gen2 VM doesn't support legacy PCI/PCIe, so both raw_pci_ops and
raw_pci_ext_ops are NULL, and pci_subsys_init() -> pcibios_init()
doesn't call pcibios_resource_survey() -> e820__reserve_resources_late();
as a result, any emulated persistent memory of E820_TYPE_PRAM (12) via
the kernel parameter memmap=nn[KMG]!ss is not added into iomem_resource
and hence can't be detected by register_e820_pmem().

Fix this by directly calling e820__reserve_resources_late() in
hv_pci_init(), which is called from arch_initcall(pci_arch_init).

It's ok to move a Gen2 VM's e820__reserve_resources_late() from
subsys_initcall(pci_subsys_init) to arch_initcall(pci_arch_init) because
the code in-between doesn't depend on the E820 resources.
e820__reserve_resources_late() depends on e820__reserve_resources(),
which has been called earlier from setup_arch().

For a Gen-2 VM, the new hv_pci_init() also adds any memory of
E820_TYPE_PMEM (7) into iomem_resource, and acpi_nfit_register_region() ->
acpi_nfit_insert_resource() -> region_intersects() returns
REGION_INTERSECTS, so the memory of E820_TYPE_PMEM won't get added twice.

Changed the local variable "int gen2vm" to "bool gen2vm".

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <1699691867-9827-1-git-send-email-ssengar@linux.microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_init.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 21556ad87f4ba..8f3a4d16bb791 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
+#include <asm/e820/api.h>
 #include <asm/sev.h>
 #include <asm/ibt.h>
 #include <asm/hypervisor.h>
@@ -286,15 +287,31 @@ static int hv_cpu_die(unsigned int cpu)
 
 static int __init hv_pci_init(void)
 {
-	int gen2vm = efi_enabled(EFI_BOOT);
+	bool gen2vm = efi_enabled(EFI_BOOT);
 
 	/*
-	 * For Generation-2 VM, we exit from pci_arch_init() by returning 0.
-	 * The purpose is to suppress the harmless warning:
+	 * A Generation-2 VM doesn't support legacy PCI/PCIe, so both
+	 * raw_pci_ops and raw_pci_ext_ops are NULL, and pci_subsys_init() ->
+	 * pcibios_init() doesn't call pcibios_resource_survey() ->
+	 * e820__reserve_resources_late(); as a result, any emulated persistent
+	 * memory of E820_TYPE_PRAM (12) via the kernel parameter
+	 * memmap=nn[KMG]!ss is not added into iomem_resource and hence can't be
+	 * detected by register_e820_pmem(). Fix this by directly calling
+	 * e820__reserve_resources_late() here: e820__reserve_resources_late()
+	 * depends on e820__reserve_resources(), which has been called earlier
+	 * from setup_arch(). Note: e820__reserve_resources_late() also adds
+	 * any memory of E820_TYPE_PMEM (7) into iomem_resource, and
+	 * acpi_nfit_register_region() -> acpi_nfit_insert_resource() ->
+	 * region_intersects() returns REGION_INTERSECTS, so the memory of
+	 * E820_TYPE_PMEM won't get added twice.
+	 *
+	 * We return 0 here so that pci_arch_init() won't print the warning:
 	 * "PCI: Fatal: No config space access function found"
 	 */
-	if (gen2vm)
+	if (gen2vm) {
+		e820__reserve_resources_late();
 		return 0;
+	}
 
 	/* For Generation-1 VM, we'll proceed in pci_arch_init().  */
 	return 1;
-- 
2.42.0


