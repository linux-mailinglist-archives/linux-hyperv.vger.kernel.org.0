Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECDE2BBAF1
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgKUAav (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:30:51 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51220 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgKUAav (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:51 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D96AA20B8005;
        Fri, 20 Nov 2020 16:30:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D96AA20B8005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918649;
        bh=MKbhjwstqPHLn7u3UhLiCmhoj04WjaNH6iYL1wm04ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eg6y+pdcrqveCJF1DDMjI/7WmchIGcAE5EnAFbPo0GEdhBE3e7VFawQHODoMv+UtA
         RSa6uZw5N5zMZ755OhG/ub6iXnlO4nIiPPx0ws3l/W/PXVNHX05V5WG31sqxfweUG6
         wLko1y+M5a2OfDAb2qvPV1APTadhKvUaXzleym5A=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 07/18] virt/mshv: withdraw memory hypercall
Date:   Fri, 20 Nov 2020 16:30:26 -0800
Message-Id: <1605918637-12192-8-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Withdraw the memory from a finalized partition and free the pages.
The partition is now cleaned up correctly when the fd is released.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 include/asm-generic/hyperv-tlfs.h | 10 ++++++
 virt/mshv/mshv_main.c             | 54 ++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index ab6ae6c164f5..2a49503b7396 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -148,6 +148,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_DELETE_PARTITION			0x0043
 #define HVCALL_GET_PARTITION_ID			0x0046
 #define HVCALL_DEPOSIT_MEMORY			0x0048
+#define HVCALL_WITHDRAW_MEMORY			0x0049
 #define HVCALL_CREATE_VP			0x004e
 #define HVCALL_GET_VP_REGISTERS			0x0050
 #define HVCALL_SET_VP_REGISTERS			0x0051
@@ -472,6 +473,15 @@ union hv_proximity_domain_info {
 	u64 as_uint64;
 };
 
+struct hv_withdraw_memory_in {
+	u64 partition_id;
+	union hv_proximity_domain_info proximity_domain_info;
+};
+
+struct hv_withdraw_memory_out {
+	u64 gpa_page_list[0];
+};
+
 struct hv_lp_startup_status {
 	u64 hv_status;
 	u64 substatus1;
diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
index c4130a6508e5..162a1bb42a4a 100644
--- a/virt/mshv/mshv_main.c
+++ b/virt/mshv/mshv_main.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/anon_inodes.h>
+#include <linux/mm.h>
 #include <linux/mshv.h>
 #include <asm/mshyperv.h>
 
@@ -57,8 +58,58 @@ static struct miscdevice mshv_dev = {
 	.mode = 600,
 };
 
+#define HV_WITHDRAW_BATCH_SIZE	(PAGE_SIZE / sizeof(u64))
 #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
 
+static int
+hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
+{
+	struct hv_withdraw_memory_in *input_page;
+	struct hv_withdraw_memory_out *output_page;
+	u16 completed;
+	u64 hypercall_status;
+	unsigned long remaining = count;
+	int status;
+	int i;
+	unsigned long flags;
+
+	while (remaining) {
+		local_irq_save(flags);
+
+		input_page = (struct hv_withdraw_memory_in *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+		output_page = (struct hv_withdraw_memory_out *)(*this_cpu_ptr(
+			hyperv_pcpu_output_arg));
+
+		input_page->partition_id = partition_id;
+		input_page->proximity_domain_info.as_uint64 = 0;
+		hypercall_status = hv_do_rep_hypercall(
+			HVCALL_WITHDRAW_MEMORY,
+			min(remaining, HV_WITHDRAW_BATCH_SIZE), 0, input_page,
+			output_page);
+
+		completed = (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
+			    HV_HYPERCALL_REP_COMP_OFFSET;
+
+		for (i = 0; i < completed; i++)
+			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
+
+		local_irq_restore(flags);
+
+		status = hypercall_status & HV_HYPERCALL_RESULT_MASK;
+		if (status != HV_STATUS_SUCCESS) {
+			if (status != HV_STATUS_NO_RESOURCES)
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+			break;
+		}
+
+		remaining -= completed;
+	}
+
+	return -hv_status_to_errno(status);
+}
+
 static int
 hv_call_create_partition(
 		u64 flags,
@@ -230,7 +281,8 @@ destroy_partition(struct mshv_partition *partition)
 
 	/* Deallocates and unmaps everything including vcpus, GPA mappings etc */
 	hv_call_finalize_partition(partition->id);
-	/* TODO: Withdraw and free all pages we deposited */
+	/* Withdraw and free all pages we deposited */
+	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->id);
 
 	hv_call_delete_partition(partition->id);
 
-- 
2.25.1

