Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D5C3E1DD3
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 23:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhHEVYt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 17:24:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46472 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhHEVYr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 17:24:47 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id E4417209F5E9;
        Thu,  5 Aug 2021 14:24:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4417209F5E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628198672;
        bh=Jb/4EJOHHKdh6FAdUgdy6VAxKnd2ITp389c0XjRnl9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aObq+lsQ8w/sLozMPAqyX0gGCHgRjmctfAAXDdKqMP958GIfSJeumHlSPHavP7Imk
         QTq4NbQqttXrOinkTcKgbssuhmRec8xBSBzbSZJzShGMVDJhIZFsx8rpglnYXYuLoZ
         qaNGHMX6hBsiBdUHyOI6lz8QD1slFOsquCEm5Vps=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH 01/19] x86/hyperv: convert hyperv statuses to linux error codes
Date:   Thu,  5 Aug 2021 14:23:43 -0700
Message-Id: <1628198641-791-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Return linux-friendly error codes from hypercall wrapper functions.
This will be needed in the mshv module.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 arch/x86/hyperv/hv_proc.c         | 30 ++++++++++++++++++++++++++---
 arch/x86/include/asm/mshyperv.h   |  1 +
 include/asm-generic/hyperv-tlfs.h | 32 +++++++++++++++++++++----------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 68a0843d4750..59cf9a9e0975 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -14,6 +14,30 @@
 
 #include <asm/trace/hyperv.h>
 
+int hv_status_to_errno(u64 hv_status)
+{
+	switch (hv_result(hv_status)) {
+	case HV_STATUS_SUCCESS:
+		return 0;
+	case HV_STATUS_INVALID_PARAMETER:
+	case HV_STATUS_UNKNOWN_PROPERTY:
+	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
+	case HV_STATUS_INVALID_VP_INDEX:
+	case HV_STATUS_INVALID_REGISTER_VALUE:
+	case HV_STATUS_INVALID_LP_INDEX:
+		return -EINVAL;
+	case HV_STATUS_ACCESS_DENIED:
+	case HV_STATUS_OPERATION_DENIED:
+		return -EACCES;
+	case HV_STATUS_NOT_ACKNOWLEDGED:
+	case HV_STATUS_INVALID_VP_STATE:
+	case HV_STATUS_INVALID_PARTITION_STATE:
+		return -EBADFD;
+	}
+	return -ENOTRECOVERABLE;
+}
+EXPORT_SYMBOL_GPL(hv_status_to_errno);
+
 /*
  * See struct hv_deposit_memory. The first u64 is partition ID, the rest
  * are GPAs.
@@ -94,7 +118,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	local_irq_restore(flags);
 	if (!hv_result_success(status)) {
 		pr_err("Failed to deposit pages: %lld\n", status);
-		ret = hv_result(status);
+		ret = hv_status_to_errno(status);
 		goto err_free_allocations;
 	}
 
@@ -150,7 +174,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 			if (!hv_result_success(status)) {
 				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
 				       lp_index, apic_id, status);
-				ret = hv_result(status);
+				ret = hv_status_to_errno(status);
 			}
 			break;
 		}
@@ -200,7 +224,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 			if (!hv_result_success(status)) {
 				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
 				       vp_index, flags, status);
-				ret = hv_result(status);
+				ret = hv_status_to_errno(status);
 			}
 			break;
 		}
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 67ff0d637e55..c6eb01f3864d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -169,6 +169,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
 int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
+int hv_status_to_errno(u64 hv_status);
 
 extern bool hv_root_partition;
 
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 515c3fb06ab3..fe6d41d0b114 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -189,16 +189,28 @@ enum HV_GENERIC_SET_FORMAT {
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
2.23.4

