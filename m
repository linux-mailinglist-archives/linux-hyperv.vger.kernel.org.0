Return-Path: <linux-hyperv+bounces-1670-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530C3874547
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 01:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06040283FB6
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 00:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BD1859;
	Thu,  7 Mar 2024 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bBBXU/Ng"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8364C61;
	Thu,  7 Mar 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772460; cv=none; b=SbAqxoaO4JbbgjuUR6w2C0f6KmGLvALjlRs9USBhqdaT159ZE6WIFW8NCL7D//ibC2lG3ZA9E7Ud4/G2EyxhP1KWO/jDNkliKrPCSR4cVR27PbOK6If0A0i0/IZ2AXan9OY/oacjapdLTgb+1xk5dwBIdWCN5jl3nWLEV3cfmuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772460; c=relaxed/simple;
	bh=oOInWFxvhByo2zBfLCcwTpadkEUFfCmGXhrK5+CpyDM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=toJKKrzBM7yJeHppwmXIVu0zQNyFLVBtsx7ulK8fVi00S58IH/ACTDLgPlwVeTX8dcoSEVveWHIr/zkws2b/S8T/Cw9OIV9qCsYd9TTaL9KaqoGzlci39zyfCSp9Wa90nC6eD2Guwq0QgOlcYtCVYZomgNkPPnsm8vP2J/AI6n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bBBXU/Ng; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4319D20B74C0;
	Wed,  6 Mar 2024 16:47:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4319D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709772458;
	bh=pEn/hH9loE4lKfp7HHBXz6sgeltsHbVfRercOCDfPkw=;
	h=From:To:Cc:Subject:Date:From;
	b=bBBXU/NgVgP2GrPxc6IXY93e0aerTlX6qVa3q6lw+nwq3rHAAeFwZ+TzkD2WCkFNc
	 omv1NEbSLhIjUs71y+uLVw/J9H+JfKvntTtE3NJsg/q/FrthImnCgAI1wQHHQhGnES
	 zQY+luftJ+Y1DJo8fm/hKU+U9Z5m54U+PuNEm7uU=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mhkelley58@gmail.com,
	haiyangz@microsoft.com,
	mhklinux@outlook.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	arnd@arndb.de
Subject: [PATCH] mshyperv: Introduce hv_get_hypervisor_version function
Date: Wed,  6 Mar 2024 16:47:34 -0800
Message-Id: <1709772454-861-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Introduce x86_64 and arm64 functions for getting the hypervisor version
information and storing it in a structure for simpler parsing.

Use the new function to get and parse the version at boot time. While at
it, print the version in the same format for each architecture, and move
the printing code to hv_common_init() so it is not duplicated.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
---
 arch/arm64/hyperv/mshyperv.c      | 19 ++++++++---------
 arch/x86/kernel/cpu/mshyperv.c    | 35 ++++++++++++++-----------------
 drivers/hv/hv_common.c            |  9 ++++++++
 include/asm-generic/hyperv-tlfs.h | 23 ++++++++++++++++++++
 include/asm-generic/mshyperv.h    |  2 ++
 5 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index f1b8a04ee9f2..55dc224d466d 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -19,10 +19,18 @@
 
 static bool hyperv_initialized;
 
+int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
+{
+	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
+			 (struct hv_get_vp_registers_output *)info);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
+
 static int __init hyperv_init(void)
 {
 	struct hv_get_vp_registers_output	result;
-	u32	a, b, c, d;
 	u64	guest_id;
 	int	ret;
 
@@ -54,15 +62,6 @@ static int __init hyperv_init(void)
 		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
 		ms_hyperv.misc_features);
 
-	/* Get information about the Hyper-V host version */
-	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
-	a = result.as32.a;
-	b = result.as32.b;
-	c = result.as32.c;
-	d = result.as32.d;
-	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
-		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
-
 	ret = hv_common_init();
 	if (ret)
 		return ret;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index d306f6184cee..03a3445faf7a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -350,13 +350,25 @@ static void __init reduced_hw_init(void)
 	x86_init.irqs.pre_vector_init	= x86_init_noop;
 }
 
+int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
+{
+	unsigned int hv_max_functions;
+
+	hv_max_functions = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
+	if (hv_max_functions < HYPERV_CPUID_VERSION) {
+		pr_err("%s: Could not detect Hyper-V version\n", __func__);
+		return -ENODEV;
+	}
+
+	cpuid(HYPERV_CPUID_VERSION, &info->eax, &info->ebx, &info->ecx, &info->edx);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
+
 static void __init ms_hyperv_init_platform(void)
 {
 	int hv_max_functions_eax;
-	int hv_host_info_eax;
-	int hv_host_info_ebx;
-	int hv_host_info_ecx;
-	int hv_host_info_edx;
 
 #ifdef CONFIG_PARAVIRT
 	pv_info.name = "Hyper-V";
@@ -407,21 +419,6 @@ static void __init ms_hyperv_init_platform(void)
 		pr_info("Hyper-V: running on a nested hypervisor\n");
 	}
 
-	/*
-	 * Extract host information.
-	 */
-	if (hv_max_functions_eax >= HYPERV_CPUID_VERSION) {
-		hv_host_info_eax = cpuid_eax(HYPERV_CPUID_VERSION);
-		hv_host_info_ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
-		hv_host_info_ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
-		hv_host_info_edx = cpuid_edx(HYPERV_CPUID_VERSION);
-
-		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
-			hv_host_info_ebx >> 16, hv_host_info_ebx & 0xFFFF,
-			hv_host_info_eax, hv_host_info_edx & 0xFFFFFF,
-			hv_host_info_ecx, hv_host_info_edx >> 24);
-	}
-
 	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 2f1dd4b07f9a..4d72c528af68 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -278,6 +278,15 @@ static void hv_kmsg_dump_register(void)
 int __init hv_common_init(void)
 {
 	int i;
+	union hv_hypervisor_version_info version;
+
+	/* Get information about the Hyper-V host version */
+	if (hv_get_hypervisor_version(&version) == 0) {
+		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
+			version.major_version, version.minor_version,
+			version.build_number, version.service_number,
+			version.service_pack, version.service_branch);
+	}
 
 	if (hv_is_isolation_supported())
 		sysctl_record_panic_msg = 0;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 3d1b31f90ed6..32514a870b98 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -817,6 +817,29 @@ struct hv_input_unmap_device_interrupt {
 #define HV_SOURCE_SHADOW_NONE               0x0
 #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
 
+/*
+ * Version info reported by hypervisor
+ */
+union hv_hypervisor_version_info {
+	struct {
+		u32 build_number;
+
+		u32 minor_version : 16;
+		u32 major_version : 16;
+
+		u32 service_pack;
+
+		u32 service_number : 24;
+		u32 service_branch : 8;
+	};
+	struct {
+		u32 eax;
+		u32 ebx;
+		u32 ecx;
+		u32 edx;
+	};
+};
+
 /*
  * The whole argument should fit in a page to be able to pass to the hypervisor
  * in one hypercall.
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 04424a446bb7..452b7c089b71 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -161,6 +161,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 	}
 }
 
+int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
+
 void hv_setup_vmbus_handler(void (*handler)(void));
 void hv_remove_vmbus_handler(void);
 void hv_setup_stimer0_handler(void (*handler)(void));
-- 
2.25.1


