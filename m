Return-Path: <linux-hyperv+bounces-2089-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D854C8C2873
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 18:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677251F25FF2
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EE3172BC5;
	Fri, 10 May 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Cp5/OUtA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1485172760;
	Fri, 10 May 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357188; cv=none; b=P/LXZoRVGtmmDNirzHa0CnsB8QIaxGu3s1tM4iBe2XpDAVKKrgUd9CBPvJqaBCAOMm1j4UkwOQHav0p3h7bvyiWO+Xcn/IH1GT7+FSAsj+vJsHBXeYTJjD9c0GTq+edNg1Tx7nnlFBkI78PzUpdJ9+J6nc2DhH44LVen8lHrA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357188; c=relaxed/simple;
	bh=ZvOkhTYeEJUhrZuTJhXQBbK3PBG0ruNlKJ4Scqql/xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7KXNYiniVq9o28RzZmru8Lsp1b9IEJ5N1E5fmrfCl+LwKBtWb2sLJe9HjEMNnCAmN0YyG+WnAwIccdb23kiuY4jRdSJPlUl0CvDwtcHrq7WAYvg4Zed3bgv24u71QzaqSeA2N+4H0ZPLl9X9sfBHpqhdA1XKcV3tK1dOWfb0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Cp5/OUtA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id B3CAA2091232;
	Fri, 10 May 2024 09:06:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3CAA2091232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715357180;
	bh=pc0a3SlDT85Dg313a1oZrrllyZZVotNtjF2PY6tBjF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cp5/OUtAQ4b9a/4mwY7/n/JvwZN6EOyusSUrizKkAbaBI7auIdP/cgA3zoGL5e+zd
	 RkufMtQMWEawsqPIvLou8anIWGXfJY2z6ncg9RaUH1fyuZKS8HWTLeFsMxkV23gKZr
	 Zq42qYNbJdLTlqXg4//e0Fqhjvn49AxEreKAw9Io=
From: romank@linux.microsoft.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Cc: ssengar@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH 4/6] drivers/hv: arch-neutral implementation of get_vtl()
Date: Fri, 10 May 2024 09:05:03 -0700
Message-ID: <20240510160602.1311352-5-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510160602.1311352-1-romank@linux.microsoft.com>
References: <20240510160602.1311352-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Kisel <romank@linux.microsoft.com>

This change generalizes the x86-specific implementation
of get_vtl() so that it can be used on arm64.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c          | 34 -----------------------
 arch/x86/include/asm/hyperv-tlfs.h |  7 -----
 drivers/hv/hv_common.c             | 43 ++++++++++++++++++++++++++++++
 include/asm-generic/hyperv-tlfs.h  |  7 +++++
 include/asm-generic/mshyperv.h     |  6 +++++
 5 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 17a71e92a343..c350fa05ee59 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -413,40 +413,6 @@ static void __init hv_get_partition_id(void)
 	local_irq_restore(flags);
 }
 
-#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
-static u8 __init get_vtl(void)
-{
-	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
-	struct hv_get_vp_registers_input *input;
-	struct hv_get_vp_registers_output *output;
-	unsigned long flags;
-	u64 ret;
-
-	local_irq_save(flags);
-	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = (struct hv_get_vp_registers_output *)input;
-
-	memset(input, 0, struct_size(input, element, 1));
-	input->header.partitionid = HV_PARTITION_ID_SELF;
-	input->header.vpindex = HV_VP_INDEX_SELF;
-	input->header.inputvtl = 0;
-	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
-
-	ret = hv_do_hypercall(control, input, output);
-	if (hv_result_success(ret)) {
-		ret = output->as64.low & HV_X64_VTL_MASK;
-	} else {
-		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
-		BUG();
-	}
-
-	local_irq_restore(flags);
-	return ret;
-}
-#else
-static inline u8 get_vtl(void) { return 0; }
-#endif
-
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 3787d26810c1..9ee68eb8e6ff 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -309,13 +309,6 @@ enum hv_isolation_type {
 #define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
 #define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
 
-/*
- * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
- * there is not associated MSR address.
- */
-#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
-#define	HV_X64_VTL_MASK			GENMASK(3, 0)
-
 /* Hyper-V memory host visibility */
 enum hv_mem_host_visibility {
 	VMBUS_PAGE_NOT_VISIBLE		= 0,
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index dde3f9b6871a..d4cf477a4d0c 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -660,3 +660,46 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 	return HV_STATUS_INVALID_PARAMETER;
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
+
+#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
+u8 __init get_vtl(void)
+{
+	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
+	struct hv_get_vp_registers_input *input;
+	struct hv_get_vp_registers_output *output;
+	unsigned long flags;
+	u64 ret;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = (struct hv_get_vp_registers_output *)input;
+
+	memset(input, 0, struct_size(input, element, 1));
+	input->header.partitionid = HV_PARTITION_ID_SELF;
+	input->header.vpindex = HV_VP_INDEX_SELF;
+	input->header.inputvtl = 0;
+	input->element[0].name0 = HV_REGISTER_VSM_VP_STATUS;
+
+	ret = hv_do_hypercall(control, input, output);
+	if (hv_result_success(ret)) {
+		ret = output->as64.low & HV_VTL_MASK;
+	} else {
+		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
+
+		/*
+		 * This is a dead end, something fundamental is broken.
+		 *
+		 * There is no sensible way of continuing as the Hyper-V drivers
+		 * transitively depend via the vmbus driver on knowing which VTL
+		 * they run in to establish communication with the host. The kernel
+		 * is going to be worse off if continued booting than a panicked one,
+		 * just hung and stuck, producing second-order failures, with neither
+		 * a way to recover nor to provide expected services.
+		 */
+		BUG();
+	}
+
+	local_irq_restore(flags);
+	return ret;
+}
+#endif
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 87e3d49a4e29..682bcda3124f 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -75,6 +75,13 @@
 /* AccessTscInvariantControls privilege */
 #define HV_ACCESS_TSC_INVARIANT			BIT(15)
 
+/*
+ * This synthetic register is only accessible via the HVCALL_GET_VP_REGISTERS
+ * hvcall, and there is no an associated MSR on x86.
+ */
+#define	HV_REGISTER_VSM_VP_STATUS	0x000D0003
+#define	HV_VTL_MASK			GENMASK(3, 0)
+
 /*
  * Group B features.
  */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 99935779682d..ea434186d765 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -301,4 +301,10 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
 }
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
+u8 __init get_vtl(void);
+#else
+static inline u8 get_vtl(void) { return 0; }
+#endif
+
 #endif
-- 
2.45.0


