Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011153948C9
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 May 2021 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhE1WpS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 May 2021 18:45:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55820 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhE1WpR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 May 2021 18:45:17 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5082A20B8008;
        Fri, 28 May 2021 15:43:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5082A20B8008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622241822;
        bh=n0W/IpLtNYs5Ye8Ih242OKx9bV/G9+H+++24kgu5OOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OID2VUUGx/ojJpQYxErlgwAoD7kfQsiOsYAR+BuJQLyHkAI6fh4D6Um8DilytCsgT
         hTOfdkAxsJqkDE7cP0ENLv9TzL859GsHE6VUlhgYKmNZ7jlIc5Tzaw2ebtYXKQOkSr
         X+6HrW6uQXII7nzXVnGPOj7VHKrnlEzBcfdBytMg=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
Subject: [PATCH 02/19] asm-generic/hyperv: convert hyperv statuses to strings
Date:   Fri, 28 May 2021 15:43:22 -0700
Message-Id: <1622241819-21155-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Allow hyperv hypercall failures to be debugged more easily with dmesg.
This will be used in the mshv module.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c         |  2 +-
 arch/x86/hyperv/hv_proc.c         | 10 +++---
 include/asm-generic/hyperv-tlfs.h | 52 ++++++++++++++++++-------------
 include/asm-generic/mshyperv.h    |  8 +++++
 4 files changed, 44 insertions(+), 28 deletions(-)

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
index 59cf9a9e0975..30951e778577 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -117,7 +117,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 				     page_count, 0, input_page, NULL);
 	local_irq_restore(flags);
 	if (!hv_result_success(status)) {
-		pr_err("Failed to deposit pages: %lld\n", status);
+		pr_err("Failed to deposit pages: %s\n", hv_status_to_string(status));
 		ret = hv_status_to_errno(status);
 		goto err_free_allocations;
 	}
@@ -172,8 +172,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 
 		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (!hv_result_success(status)) {
-				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
-				       lp_index, apic_id, status);
+				pr_err("%s: cpu %u apic ID %u, %s\n", __func__,
+				       lp_index, apic_id, hv_status_to_string(status));
 				ret = hv_status_to_errno(status);
 			}
 			break;
@@ -222,8 +222,8 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 
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
index 9a000ba2bb75..21fb71ca1ba9 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -59,6 +59,14 @@ static inline unsigned int hv_repcomp(u64 status)
 			 HV_HYPERCALL_REP_COMP_OFFSET;
 }
 
+static inline const char *hv_status_to_string(u64 hv_status)
+{
+	switch (hv_result(hv_status)) {
+	__HV_STATUS_DEF(__HV_MAKE_HV_STATUS_CASE)
+	default : return "Unknown";
+	}
+}
+
 /*
  * Rep hypercalls. Callers of this functions are supposed to ensure that
  * rep_count and varhead_size comply with Hyper-V hypercall definition.
-- 
2.25.1

