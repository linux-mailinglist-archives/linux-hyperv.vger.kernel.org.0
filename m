Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE802BBAF0
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgKUAau (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:30:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51174 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgKUAau (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:50 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6D81520B718A;
        Fri, 20 Nov 2020 16:30:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D81520B718A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918649;
        bh=6QivuWa9n3wnISAXa8kupsu+iKOKHl9h4jOBpVcX1iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cPKPvGC4CafRw6OY4eMJsKiC5J4ChtVEhb0IBpb3SgR+44q7lAwwUD309/tqwwwj1
         PY+2vONhbzfehiz7g13hyB5OfbDpAeRmGLW3BdSsBF/ghBsQeNnvxn8qsp8NeGqBxM
         f9XOIhGUIEkLmBOBqgeV+zCgMbZk8yktEVskxleU=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 02/18] asm-generic/hyperv: convert hyperv statuses to strings
Date:   Fri, 20 Nov 2020 16:30:21 -0800
Message-Id: <1605918637-12192-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Allow hyperv hypercall failures to be debugged more easily with dmesg.
This will be used in the mshv module.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c         |  2 +-
 arch/x86/hyperv/hv_proc.c         | 10 +++---
 include/asm-generic/hyperv-tlfs.h | 60 +++++++++++++++++++------------
 3 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 2c2189832da7..2a8cd2cf0745 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -363,7 +363,7 @@ void __init hv_get_partition_id(void)
 	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
 		HV_HYPERCALL_RESULT_MASK;
 	if (status != HV_STATUS_SUCCESS)
-		pr_err("Failed to get partition ID: %d\n", status);
+		pr_err("Failed to get partition ID: %s\n", hv_status_to_string(status));
 	else
 		hv_current_partition_id = output_page->partition_id;
 	local_irq_restore(flags);
diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 8f86f8e86748..a88ed6873fbd 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -122,7 +122,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	local_irq_restore(flags);
 
 	if (status != HV_STATUS_SUCCESS) {
-		pr_err("Failed to deposit pages: %d\n", status);
+		pr_err("Failed to deposit pages: %s\n", hv_status_to_string(status));
 		ret = -hv_status_to_errno(status);
 		goto err_free_allocations;
 	}
@@ -177,8 +177,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 
 		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (status != HV_STATUS_SUCCESS) {
-				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
-				       lp_index, apic_id, status);
+				pr_err("%s: cpu %u apic ID %u, %s\n", __func__,
+				       lp_index, apic_id, hv_status_to_string(status));
 				ret = -hv_status_to_errno(status);
 			}
 			break;
@@ -225,8 +225,8 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 
 		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (status != HV_STATUS_SUCCESS) {
-				pr_err("%s: vcpu %u, lp %u, %d\n", __func__,
-				       vp_index, flags, status);
+				pr_err("%s: vcpu %u, lp %u, %s\n", __func__,
+				       vp_index, flags, hv_status_to_string(status));
 				ret = -hv_status_to_errno(status);
 			}
 			break;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 445244192fa4..05b9dc9896ab 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -181,28 +181,44 @@ enum HV_GENERIC_SET_FORMAT {
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
+
+static inline const char *hv_status_to_string(enum hv_status status)
+{
+	switch (status) {
+	__HV_STATUS_DEF(__HV_MAKE_HV_STATUS_CASE)
+	default : return "Unknown";
+	}
+}
 
 /*
  * The Hyper-V TimeRefCount register and the TSC
-- 
2.25.1

