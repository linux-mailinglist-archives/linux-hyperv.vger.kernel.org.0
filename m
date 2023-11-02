Return-Path: <linux-hyperv+bounces-655-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886847DF25A
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Nov 2023 13:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF8FB211DE
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Nov 2023 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D101D18E01;
	Thu,  2 Nov 2023 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="a5Y5Keko"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626918E23
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Nov 2023 12:27:44 +0000 (UTC)
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B3E125;
	Thu,  2 Nov 2023 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1698928059;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rOPa6SsJffV8///cKRLOi92k77I71pT8DvN4OZJMNAE=;
  b=a5Y5KekoHD/4OMuutGEnFqRa/P3Wsy/q+S4m9sikc3uQ52XWixpAO1Bz
   Z/0X4OELsvG+AEed6aURtpR5kLlyFO/RvUeiWg2zhROVrdQ0o+x6nk9nz
   z6sDyXlcstFG7sKRkYiwvtJub+Rdi+r2Uq0Ulr5njwUr+/rEeUk14IfCr
   g=;
X-CSE-ConnectionGUID: pNIzOpSTTbaXx/hvRfdv1w==
X-CSE-MsgGUID: LKATxiLzTwO33wT25b6a+g==
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 126596382
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.159.70
X-Policy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:rdfd7KwIbs2uzHGBV7F6t+dQwCrEfRIJ4+MujC+fZmUNrF6WrkUPy
 jQWXmiObquCNDb3L49wOYni8kgF78ODzdA2TFRqpCAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjPzOHvykTrecZkidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EgHUMja4mtC5QVnPaoT4DcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KXlo1
 O4/MAsxUhqKt/LxwKyBROVy39t2eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyPVKfO3WjOX9OYH46tM6uimPybHtzr1WNqLBsy2PS0BZwwP7mN9+9ltmiHJ8LwxfG/
 TKcl4j/KjU5HeCPyB6Xzm2L3bTQoXmmUtwbV7Lto5aGh3XMnzdOWXX6T2CTouaRjk+4RsIZI
 EsRkgI0qqIy3E+mVN/wW1u/unHslhoEWtdKGuk78wClyafO5QudQG8eQVZpaNUnpcYwSi4C0
 16ChdTyAjJz9raSTBq19aaPhTazMjISNmgMeWkPSg5ty9Xuq5wyphfORcxkC6m7kpv+HjSY6
 yuWoTYzwaoajcoj1722u1vAhlqEpYnNQ0gw6xTaREql9g4/b4mgD6Sk6F3a8exBap2YUFCHv
 XMEs8iG4aYFCpTlvDaQW/5LFbel6uyeNzv0gUZiWZIm8lyF+WO4YYFWpjxkIlx1GsYcdHniZ
 0q7kRMBurdQMWGsYKsxZJi+Y+wyyaH8G9P/U7XYdNtQb4I0ZF/Z1D9haFTW3G33lkUo16YlN
 v+zdceqEGZfEa9m5CS5Sv1b0rIxwC06g2TJSvjTyxWhzKrbZG+NRK0bGEWBY/p/766epgjRt
 dFFOKOiwQ13Wen/by+Ht4IeRXgGJGY2Q5D/rddacMaHIwx7CCcgDePcxfUqfIkNt6RNn8/a7
 226QAlTz1+XrXjGLwqNQmpuZLPmQdB0qndTFSYsMFKn0nE4SYmo66gbet08erxP3PBsye5cS
 /gDZtmaBfJOWnLL9lw1YYf9pZZ+XBWtixiHMyesbH44ZZEIbwXP9s7Mfw3h7iACAyO788wkr
 NWI0gLdXIpGRAl4CsvSQOygwkn3vnUHnu92GUzSLbF7Z0jttoxrNgTyg+UxLsVKLg/MrgZ2z
 C7PX01e/7OU5dZooZ+W3chosrtFDcNmOGtIOHHg0Yq8PBnKuWq9+4FMTr+XKGW1uHzPxEmyW
 QlE56iiYa1XzQgW7tYU/6VDl/xku4W1z1NO5kE0RC+VMg7D5qZIeyHehaFyWrtxKqi1UOdcc
 mmI4NBecY6RIsLjH0V5yOENNb/biqh8dtU/950IzKTGCMxfpuHvvb16ZUXktcCkBOId3HkZ6
 ekgotUKzAe0lwAnNN2L5ggNqTXcfiJbDft55shKaGMOtubM4ggcCaEw9wevvcrRAzmyGhJCz
 sCoaFrq2O0Hmxuqn4sbHnnRx+tN7akzVORx5AZafTyhw4OV7sLbKTUNqVzbuCwJlEQYuw+yU
 0A3X3BIyVKmpmcx3pAaATD2RWmsxnSxoyTM9rfAr0WBJ2HAa4AHBDRV1TqllKzBz19hQw==
IronPort-HdrOrdr: A9a23:dqNQ0Ksrw7zhQbipVYk5TQ3T7skD29V00zEX/kB9WHVpmwKj9v
 xG+85rsyMc6QxhP03I/OrrBEDuex7hHPJOjbX5eI3SPzUPVgOTXf1fBMjZskDd8xSXzJ8j6U
 4YSdkBNDSTNzhHZLfBkW2F+o0bsaC6GcmT7I+0854ud3AJV0gH1WhE422gYyhLrWd9a6bRPa
 Dsl/Zvln6PeWk3cs/+PXUMRe7Fzue77q7OUFopBwMH9ALLtj+j6Kf7Hx+Ety1uKA9n8PMN8X
 Xljwe83amos+i6xhjAk0ff4o9bgsGJ8KoxOOW8zuYUNxTxgUKTaINtV6bqhkFMnMij5Ew2kN
 7FvhcnON4b0QKgQl2I
X-Talos-CUID: 9a23:ZJ8ghGDrwN7Ensr6EzFB1VwzAvsZTnfU/GeXI1GCB2p3EaLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AnGNQYAzsbmO5r+vbiagUFTc/0BKaqICNIXwdkLE?=
 =?us-ascii?q?Uh9ajbndvB23Ahmq+AYByfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.03,271,1694750400"; 
   d="scan'208";a="126596382"
From: Andrew Cooper <andrew.cooper3@citrix.com>
Date: Thu, 2 Nov 2023 12:26:19 +0000
Subject: [PATCH 1/3] x86/apic: Drop apic::delivery_mode
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231102-x86-apic-v1-1-bf049a2a0ed6@citrix.com>
References: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
In-Reply-To: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Steve Wahl
	<steve.wahl@hpe.com>, Justin Ernst <justin.ernst@hpe.com>, Kyle Meyer
	<kyle.meyer@hpe.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, "Russ
 Anderson" <russ.anderson@hpe.com>, Darren Hart <dvhart@infradead.org>, "Andy
 Shevchenko" <andy@infradead.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "Dexuan
 Cui" <decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>
X-Mailer: b4 0.12.4

This field is set to APIC_DELIVERY_MODE_FIXED in all cases, and is read
exactly once.  Fold the constant in uv_program_mmr() and drop the field.

Searching for the origin of the stale HyperV comment reveals commit
a31e58e129f7 ("x86/apic: Switch all APICs to Fixed delivery mode") which
notes:

  As a consequence of this change, the apic::irq_delivery_mode field is
  now pointless, but this needs to be cleaned up in a separate patch.

6 years is long enough for this technical debt to have survived.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
 arch/x86/include/asm/apic.h           | 2 --
 arch/x86/kernel/apic/apic_flat_64.c   | 2 --
 arch/x86/kernel/apic/apic_noop.c      | 1 -
 arch/x86/kernel/apic/apic_numachip.c  | 2 --
 arch/x86/kernel/apic/bigsmp_32.c      | 1 -
 arch/x86/kernel/apic/probe_32.c       | 1 -
 arch/x86/kernel/apic/x2apic_cluster.c | 1 -
 arch/x86/kernel/apic/x2apic_phys.c    | 1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    | 1 -
 arch/x86/platform/uv/uv_irq.c         | 2 +-
 drivers/pci/controller/pci-hyperv.c   | 7 -------
 11 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 5af4ec1a0f71..841afbd7bfe7 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -272,8 +272,6 @@ struct apic {
 	void	(*send_IPI_all)(int vector);
 	void	(*send_IPI_self)(int vector);
 
-	enum apic_delivery_modes delivery_mode;
-
 	u32	disable_esr		: 1,
 		dest_mode_logical	: 1,
 		x2apic_set_max_apicid	: 1;
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 032a84e2c3cc..e526b226910b 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -82,7 +82,6 @@ static struct apic apic_flat __ro_after_init = {
 	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
 	.apic_id_registered		= default_apic_id_registered,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
@@ -153,7 +152,6 @@ static struct apic apic_physflat __ro_after_init = {
 	.acpi_madt_oem_check		= physflat_acpi_madt_oem_check,
 	.apic_id_registered		= default_apic_id_registered,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 966d7cf10b95..70e7dfc3cc84 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -45,7 +45,6 @@ static void noop_apic_write(u32 reg, u32 val)
 struct apic apic_noop __ro_after_init = {
 	.name				= "noop",
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 63f3d7be9dc7..8f5a42ad1f9f 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -222,7 +222,6 @@ static const struct apic apic_numachip1 __refconst = {
 	.probe				= numachip1_probe,
 	.acpi_madt_oem_check		= numachip1_acpi_madt_oem_check,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
@@ -259,7 +258,6 @@ static const struct apic apic_numachip2 __refconst = {
 	.probe				= numachip2_probe,
 	.acpi_madt_oem_check		= numachip2_acpi_madt_oem_check,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 0e5535add4b5..863c3002a574 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -80,7 +80,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.name				= "bigsmp",
 	.probe				= probe_bigsmp,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 1,
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 9a06df6cdd68..f851ccf1e14f 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -35,7 +35,6 @@ static struct apic apic_default __ro_after_init = {
 	.probe				= probe_default,
 	.apic_id_registered		= default_apic_id_registered,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index affbff65e497..7d15f6c3b718 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -227,7 +227,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.probe				= x2apic_cluster_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 788cdb4ee394..8bb740e22b7d 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -145,7 +145,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.probe				= x2apic_phys_probe,
 	.acpi_madt_oem_check		= x2apic_acpi_madt_oem_check,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 7d304ef1a7f5..ae4f0c1a7b43 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -805,7 +805,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.probe				= uv_probe,
 	.acpi_madt_oem_check		= uv_acpi_madt_oem_check,
 
-	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 4221259a5870..a379501b7a69 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -35,7 +35,7 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 	mmr_value = 0;
 	entry = (struct uv_IO_APIC_route_entry *)&mmr_value;
 	entry->vector		= cfg->vector;
-	entry->delivery_mode	= apic->delivery_mode;
+	entry->delivery_mode	= APIC_DELIVERY_MODE_FIXED;
 	entry->dest_mode	= apic->dest_mode_logical;
 	entry->polarity		= 0;
 	entry->trigger		= 0;
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index bed3cefdaf19..f5d2ef8572e7 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -650,13 +650,6 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 			   PCI_FUNC(pdev->devfn);
 	params->int_target.vector = hv_msi_get_int_vector(data);
 
-	/*
-	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
-	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
-	 * spurious interrupt storm. Not doing so does not seem to have a
-	 * negative effect (yet?).
-	 */
-
 	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
 		/*
 		 * PCI_PROTOCOL_VERSION_1_2 supports the VP_SET version of the

-- 
2.30.2


