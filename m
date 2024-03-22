Return-Path: <linux-hyperv+bounces-1816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923A288745B
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Mar 2024 22:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B58281EE3
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Mar 2024 21:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C157F7E8;
	Fri, 22 Mar 2024 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M0oRjUwK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ADC1E53A;
	Fri, 22 Mar 2024 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711141839; cv=none; b=n3nbQpZ1AOiM7JBf2n2cOZMSCQrDFL7bO3I1w1k4GhMoT7P/tyXArKasIokE4YbMJHrgHeGHYJHz2weqtrLwYSszkmaXyXy/8MfPkU0ophdRD8jNOsvZkUvDeYofMGg8WoLBpcdvjdScJT8WJe3OrYYf/6RUNAXyRo/uKiHYmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711141839; c=relaxed/simple;
	bh=XaH0KEv1nb9xus3VBqOrQLMz+j2srUYaIlBhhpkcHuE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hG81dneviLkxLa3ZRBp+kQiwyoK4JQs0DqJjvfqdY27k9awu5fa+XouPoa3ZWKQ6eFzCIg4lslHDxgZoEICHL2AaNKFMVIjkuRDHYNJDpdQsT9znJMBA/EWfeMjxH0M7H/iGDMLO7cPjBTv5TiuTXWEd6b0W/6xrXPbOIEkRzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M0oRjUwK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E06B620B74C0;
	Fri, 22 Mar 2024 14:10:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E06B620B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711141830;
	bh=Dgr5CP67sBUTg6Kr6ZXZRiRfX3GkWa3/d4YTRSxG8UY=;
	h=From:To:Cc:Subject:Date:From;
	b=M0oRjUwKht9JnvFcToP5N8QM1YmMRXHYePKI7iZ7eWLT5TjRU/vhTuTbAs15P5USF
	 BDfPbxbxPyH/rB3xuzivDY+PaKAjLku7uhbBIOOeVQ4CQRVY3NtKpVoZduLT9zNTTy
	 lmcV5+Uw09WQdJH+T/1SiGxJS8jGl3AWDAGoSmq8=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mhkelley58@gmail.com,
	mhklinux@outlook.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	arnd@arndb.de
Subject: [PATCH v3] mshyperv: Introduce hv_numa_node_to_pxm_info()
Date: Fri, 22 Mar 2024 14:10:26 -0700
Message-Id: <1711141826-9458-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Factor out logic for converting numa node to hv_proximity_domain_info
into a helper function.

Change hv_proximity_domain_info to a struct to improve readability.

While at it, rename hv_add_logical_processor_* structs to the correct
hv_input_/hv_output_ prefix, and remove the flags field which is not
present in the ABI.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>

---

Changes in v3:
* Shorten function name to hv_numa_node_to_pxm_info()
* Correct hv_add_logical_processor_* naming, and remove flags

Changes in v2:
* Change hv_proximity_domain_info from union to struct to improve
  readability [Dave Hanson]

---
 arch/x86/hyperv/hv_proc.c         | 22 ++++------------------
 include/asm-generic/hyperv-tlfs.h | 19 +++++++------------
 include/asm-generic/mshyperv.h    | 14 ++++++++++++++
 3 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 68a0843d4750..3fa1f2ee7b0d 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -3,7 +3,6 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/clockchips.h>
-#include <linux/acpi.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
@@ -116,12 +115,11 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 {
-	struct hv_add_logical_processor_in *input;
-	struct hv_add_logical_processor_out *output;
+	struct hv_input_add_logical_processor *input;
+	struct hv_output_add_logical_processor *output;
 	u64 status;
 	unsigned long flags;
 	int ret = HV_STATUS_SUCCESS;
-	int pxm = node_to_pxm(node);
 
 	/*
 	 * When adding a logical processor, the hypervisor may return
@@ -137,11 +135,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 
 		input->lp_index = lp_index;
 		input->apic_id = apic_id;
-		input->flags = 0;
-		input->proximity_domain_info.domain_id = pxm;
-		input->proximity_domain_info.flags.reserved = 0;
-		input->proximity_domain_info.flags.proximity_info_valid = 1;
-		input->proximity_domain_info.flags.proximity_preferred = 1;
+		input->proximity_domain_info = hv_numa_node_to_pxm_info(node);
 		status = hv_do_hypercall(HVCALL_ADD_LOGICAL_PROCESSOR,
 					 input, output);
 		local_irq_restore(flags);
@@ -166,7 +160,6 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 	u64 status;
 	unsigned long irq_flags;
 	int ret = HV_STATUS_SUCCESS;
-	int pxm = node_to_pxm(node);
 
 	/* Root VPs don't seem to need pages deposited */
 	if (partition_id != hv_current_partition_id) {
@@ -185,14 +178,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 		input->vp_index = vp_index;
 		input->flags = flags;
 		input->subnode_type = HvSubnodeAny;
-		if (node != NUMA_NO_NODE) {
-			input->proximity_domain_info.domain_id = pxm;
-			input->proximity_domain_info.flags.reserved = 0;
-			input->proximity_domain_info.flags.proximity_info_valid = 1;
-			input->proximity_domain_info.flags.proximity_preferred = 1;
-		} else {
-			input->proximity_domain_info.as_uint64 = 0;
-		}
+		input->proximity_domain_info = hv_numa_node_to_pxm_info(node);
 		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
 		local_irq_restore(irq_flags);
 
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 87e3d49a4e29..814207e7c37f 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -512,13 +512,9 @@ struct hv_proximity_domain_flags {
 	u32 proximity_info_valid : 1;
 } __packed;
 
-/* Not a union in windows but useful for zeroing */
-union hv_proximity_domain_info {
-	struct {
-		u32 domain_id;
-		struct hv_proximity_domain_flags flags;
-	};
-	u64 as_uint64;
+struct hv_proximity_domain_info {
+	u32 domain_id;
+	struct hv_proximity_domain_flags flags;
 } __packed;
 
 struct hv_lp_startup_status {
@@ -532,14 +528,13 @@ struct hv_lp_startup_status {
 } __packed;
 
 /* HvAddLogicalProcessor hypercall */
-struct hv_add_logical_processor_in {
+struct hv_input_add_logical_processor {
 	u32 lp_index;
 	u32 apic_id;
-	union hv_proximity_domain_info proximity_domain_info;
-	u64 flags;
+	struct hv_proximity_domain_info proximity_domain_info;
 } __packed;
 
-struct hv_add_logical_processor_out {
+struct hv_output_add_logical_processor {
 	struct hv_lp_startup_status startup_status;
 } __packed;
 
@@ -560,7 +555,7 @@ struct hv_create_vp {
 	u8 padding[3];
 	u8 subnode_type;
 	u64 subnode_id;
-	union hv_proximity_domain_info proximity_domain_info;
+	struct hv_proximity_domain_info proximity_domain_info;
 	u64 flags;
 } __packed;
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 99935779682d..8fe7aaab2599 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <acpi/acpi_numa.h>
 #include <linux/cpumask.h>
 #include <linux/nmi.h>
 #include <asm/ptrace.h>
@@ -67,6 +68,19 @@ extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 
+static inline struct hv_proximity_domain_info hv_numa_node_to_pxm_info(int node)
+{
+	struct hv_proximity_domain_info pxm_info = {};
+
+	if (node != NUMA_NO_NODE) {
+		pxm_info.domain_id = node_to_pxm(node);
+		pxm_info.flags.proximity_info_valid = 1;
+		pxm_info.flags.proximity_preferred = 1;
+	}
+
+	return pxm_info;
+}
+
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
 {
-- 
2.25.1


