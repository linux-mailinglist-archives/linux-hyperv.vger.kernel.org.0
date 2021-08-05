Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62763E1DD2
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 23:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241895AbhHEVYt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 17:24:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46480 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhHEVYr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 17:24:47 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 064D7209F5EB;
        Thu,  5 Aug 2021 14:24:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 064D7209F5EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628198673;
        bh=q7WlIM5PWIF4fFrMf7eK/pN7DPHidfjW9JHWjSKdGeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cG9tPeCf2u4pu0qL7ZjXFbO8X0NhnpN1yJugWnhR6t4+AqG0Ai6x+6qC4609dSSW4
         nMxynAIwWHYUk28UMMTEKMJaIT2sBkUeeUV8ijtn42LmUjZcRg6ZMaJ8EpCUIKAXIR
         lLSHjpPtjbbN1JY9KdQ/2bB5eoEPXW+QJ2BcFtwM=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH 02/19] x86/hyperv: convert hyperv statuses to strings
Date:   Thu,  5 Aug 2021 14:23:44 -0700
Message-Id: <1628198641-791-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Allow hyperv hypercall failures to be debugged more easily with dmesg.
This will be used in the mshv module.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c         |  2 +-
 arch/x86/hyperv/hv_proc.c         | 19 ++++++++---
 include/asm-generic/hyperv-tlfs.h | 52 ++++++++++++++++++-------------
 include/asm-generic/mshyperv.h    |  1 +
 4 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index bb0ae4b5c00f..722bafdb2225 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -349,7 +349,7 @@ static void __init hv_get_partition_id(void)
 	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
 	if (!hv_result_success(status)) {
 		/* No point in proceeding if this failed */
-		pr_err("Failed to get partition ID: %lld\n", status);
+		pr_err("Failed to get partition ID: %s\n", hv_status_to_string(status));
 		BUG();
 	}
 	hv_current_partition_id = output_page->partition_id;
diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 59cf9a9e0975..e75c78a243e7 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -38,6 +38,15 @@ int hv_status_to_errno(u64 hv_status)
 }
 EXPORT_SYMBOL_GPL(hv_status_to_errno);
 
+const char *hv_status_to_string(u64 hv_status)
+{
+	switch (hv_result(hv_status)) {
+	__HV_STATUS_DEF(__HV_MAKE_HV_STATUS_CASE)
+	default : return "Unknown";
+	}
+}
+EXPORT_SYMBOL_GPL(hv_status_to_string);
+
 /*
  * See struct hv_deposit_memory. The first u64 is partition ID, the rest
  * are GPAs.
@@ -117,7 +126,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 				     page_count, 0, input_page, NULL);
 	local_irq_restore(flags);
 	if (!hv_result_success(status)) {
-		pr_err("Failed to deposit pages: %lld\n", status);
+		pr_err("Failed to deposit pages: %s\n", hv_status_to_string(status));
 		ret = hv_status_to_errno(status);
 		goto err_free_allocations;
 	}
@@ -172,8 +181,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 
 		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (!hv_result_success(status)) {
-				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
-				       lp_index, apic_id, status);
+				pr_err("%s: cpu %u apic ID %u, %s\n", __func__,
+				       lp_index, apic_id, hv_status_to_string(status));
 				ret = hv_status_to_errno(status);
 			}
 			break;
@@ -222,8 +231,8 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 
 		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (!hv_result_success(status)) {
-				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
-				       vp_index, flags, status);
+				pr_err("%s: vcpu %u, lp %u, %s\n", __func__,
+				       vp_index, flags, hv_status_to_string(status));
 				ret = hv_status_to_errno(status);
 			}
 			break;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index fe6d41d0b114..40ff7cdd4a2b 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -189,28 +189,36 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
 
 /* hypercall status code */
-#define HV_STATUS_SUCCESS			0x0
-#define HV_STATUS_INVALID_HYPERCALL_CODE	0x2
-#define HV_STATUS_INVALID_HYPERCALL_INPUT	0x3
-#define HV_STATUS_INVALID_ALIGNMENT		0x4
-#define HV_STATUS_INVALID_PARAMETER		0x5
-#define HV_STATUS_ACCESS_DENIED			0x6
-#define HV_STATUS_INVALID_PARTITION_STATE	0x7
-#define HV_STATUS_OPERATION_DENIED		0x8
-#define HV_STATUS_UNKNOWN_PROPERTY		0x9
-#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	0xA
-#define HV_STATUS_INSUFFICIENT_MEMORY		0xB
-#define HV_STATUS_INVALID_PARTITION_ID		0xD
-#define HV_STATUS_INVALID_VP_INDEX		0xE
-#define HV_STATUS_NOT_FOUND			0x10
-#define HV_STATUS_INVALID_PORT_ID		0x11
-#define HV_STATUS_INVALID_CONNECTION_ID		0x12
-#define HV_STATUS_INSUFFICIENT_BUFFERS		0x13
-#define HV_STATUS_NOT_ACKNOWLEDGED		0x14
-#define HV_STATUS_INVALID_VP_STATE		0x15
-#define HV_STATUS_NO_RESOURCES			0x1D
-#define HV_STATUS_INVALID_LP_INDEX		0x41
-#define HV_STATUS_INVALID_REGISTER_VALUE	0x50
+#define __HV_STATUS_DEF(OP) \
+	OP(HV_STATUS_SUCCESS,				0x0) \
+	OP(HV_STATUS_INVALID_HYPERCALL_CODE,		0x2) \
+	OP(HV_STATUS_INVALID_HYPERCALL_INPUT,		0x3) \
+	OP(HV_STATUS_INVALID_ALIGNMENT,			0x4) \
+	OP(HV_STATUS_INVALID_PARAMETER,			0x5) \
+	OP(HV_STATUS_ACCESS_DENIED,			0x6) \
+	OP(HV_STATUS_INVALID_PARTITION_STATE,		0x7) \
+	OP(HV_STATUS_OPERATION_DENIED,			0x8) \
+	OP(HV_STATUS_UNKNOWN_PROPERTY,			0x9) \
+	OP(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	0xA) \
+	OP(HV_STATUS_INSUFFICIENT_MEMORY,		0xB) \
+	OP(HV_STATUS_INVALID_PARTITION_ID,		0xD) \
+	OP(HV_STATUS_INVALID_VP_INDEX,			0xE) \
+	OP(HV_STATUS_NOT_FOUND,				0x10) \
+	OP(HV_STATUS_INVALID_PORT_ID,			0x11) \
+	OP(HV_STATUS_INVALID_CONNECTION_ID,		0x12) \
+	OP(HV_STATUS_INSUFFICIENT_BUFFERS,		0x13) \
+	OP(HV_STATUS_NOT_ACKNOWLEDGED,			0x14) \
+	OP(HV_STATUS_INVALID_VP_STATE,			0x15) \
+	OP(HV_STATUS_NO_RESOURCES,			0x1D) \
+	OP(HV_STATUS_INVALID_LP_INDEX,			0x41) \
+	OP(HV_STATUS_INVALID_REGISTER_VALUE,		0x50)
+
+#define __HV_MAKE_HV_STATUS_ENUM(NAME, VAL) NAME = (VAL),
+#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);
+
+enum hv_status {
+	__HV_STATUS_DEF(__HV_MAKE_HV_STATUS_ENUM)
+};
 
 /*
  * The Hyper-V TimeRefCount register and the TSC
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9a000ba2bb75..672b08f79dae 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -219,6 +219,7 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 	return nr_bank;
 }
 
+const char *hv_status_to_string(u64 hv_status);
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
-- 
2.23.4

