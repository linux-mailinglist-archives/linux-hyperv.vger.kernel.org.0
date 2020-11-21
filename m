Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F92BBB07
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgKUAbk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:31:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51170 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgKUAau (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:50 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 579B920B7186;
        Fri, 20 Nov 2020 16:30:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 579B920B7186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918649;
        bh=k9bsZ80Un+UJQ7SpEd3B9sgAvmcR8hVOnlrbDtThJvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B7I8s2djMZHUYbMJMuXPSikxwzHMz544RKEulBIcrMo8ujQLMAs4GYnub+KHI1MTv
         m1Dh0KwqvYZzDBZatb6Gcd3kzS1KSGvNi8jKq5gcaVfB+8QEmLhCSoguFiyyyO4ZPf
         LTVT3n/zgWIKLoGruho33scUuO4h2sQqPT0hb5ts=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 01/18] x86/hyperv: convert hyperv statuses to linux error codes
Date:   Fri, 20 Nov 2020 16:30:20 -0800
Message-Id: <1605918637-12192-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Return linux-friendly error codes from hypercall wrapper functions.
This will be needed in the mshv module.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/hv_proc.c         | 30 ++++++++++++++++++++++++++---
 arch/x86/include/asm/mshyperv.h   |  1 +
 include/asm-generic/hyperv-tlfs.h | 32 +++++++++++++++++++++----------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 0fd972c9129a..8f86f8e86748 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -18,6 +18,30 @@
 #define HV_DEPOSIT_MAX_ORDER (8)
 #define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
 
+int hv_status_to_errno(int hv_status)
+{
+	switch (hv_status) {
+	case HV_STATUS_SUCCESS:
+		return 0;
+	case HV_STATUS_INVALID_PARAMETER:
+	case HV_STATUS_UNKNOWN_PROPERTY:
+	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
+	case HV_STATUS_INVALID_VP_INDEX:
+	case HV_STATUS_INVALID_REGISTER_VALUE:
+	case HV_STATUS_INVALID_LP_INDEX:
+		return EINVAL;
+	case HV_STATUS_ACCESS_DENIED:
+	case HV_STATUS_OPERATION_DENIED:
+		return EACCES;
+	case HV_STATUS_NOT_ACKNOWLEDGED:
+	case HV_STATUS_INVALID_VP_STATE:
+	case HV_STATUS_INVALID_PARTITION_STATE:
+		return EBADFD;
+	}
+	return ENOTRECOVERABLE;
+}
+EXPORT_SYMBOL_GPL(hv_status_to_errno);
+
 /*
  * Deposits exact number of pages
  * Must be called with interrupts enabled
@@ -99,7 +123,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 
 	if (status != HV_STATUS_SUCCESS) {
 		pr_err("Failed to deposit pages: %d\n", status);
-		ret = status;
+		ret = -hv_status_to_errno(status);
 		goto err_free_allocations;
 	}
 
@@ -155,7 +179,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 			if (status != HV_STATUS_SUCCESS) {
 				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
 				       lp_index, apic_id, status);
-				ret = status;
+				ret = -hv_status_to_errno(status);
 			}
 			break;
 		}
@@ -203,7 +227,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 			if (status != HV_STATUS_SUCCESS) {
 				pr_err("%s: vcpu %u, lp %u, %d\n", __func__,
 				       vp_index, flags, status);
-				ret = status;
+				ret = -hv_status_to_errno(status);
 			}
 			break;
 		}
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index cbee72550a12..eb75faa4d4c5 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -243,6 +243,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
 int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
+int hv_status_to_errno(int hv_status);
 
 extern bool hv_root_partition;
 
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index dd385c6a71b5..445244192fa4 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -181,16 +181,28 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
 
 /* hypercall status code */
-#define HV_STATUS_SUCCESS			0
-#define HV_STATUS_INVALID_HYPERCALL_CODE	2
-#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
-#define HV_STATUS_INVALID_ALIGNMENT		4
-#define HV_STATUS_INVALID_PARAMETER		5
-#define HV_STATUS_OPERATION_DENIED		8
-#define HV_STATUS_INSUFFICIENT_MEMORY		11
-#define HV_STATUS_INVALID_PORT_ID		17
-#define HV_STATUS_INVALID_CONNECTION_ID		18
-#define HV_STATUS_INSUFFICIENT_BUFFERS		19
+#define HV_STATUS_SUCCESS			0x0
+#define HV_STATUS_INVALID_HYPERCALL_CODE	0x2
+#define HV_STATUS_INVALID_HYPERCALL_INPUT	0x3
+#define HV_STATUS_INVALID_ALIGNMENT		0x4
+#define HV_STATUS_INVALID_PARAMETER		0x5
+#define HV_STATUS_ACCESS_DENIED			0x6
+#define HV_STATUS_INVALID_PARTITION_STATE	0x7
+#define HV_STATUS_OPERATION_DENIED		0x8
+#define HV_STATUS_UNKNOWN_PROPERTY		0x9
+#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	0xA
+#define HV_STATUS_INSUFFICIENT_MEMORY		0xB
+#define HV_STATUS_INVALID_PARTITION_ID		0xD
+#define HV_STATUS_INVALID_VP_INDEX		0xE
+#define HV_STATUS_NOT_FOUND			0x10
+#define HV_STATUS_INVALID_PORT_ID		0x11
+#define HV_STATUS_INVALID_CONNECTION_ID		0x12
+#define HV_STATUS_INSUFFICIENT_BUFFERS		0x13
+#define HV_STATUS_NOT_ACKNOWLEDGED		0x14
+#define HV_STATUS_INVALID_VP_STATE		0x15
+#define HV_STATUS_NO_RESOURCES			0x1D
+#define HV_STATUS_INVALID_LP_INDEX		0x41
+#define HV_STATUS_INVALID_REGISTER_VALUE	0x50
 
 /*
  * The Hyper-V TimeRefCount register and the TSC
-- 
2.25.1

