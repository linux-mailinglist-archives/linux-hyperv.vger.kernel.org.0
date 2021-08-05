Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA813E1DDA
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 23:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbhHEVYw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 17:24:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46550 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhHEVYs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 17:24:48 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 73D8D20B36F3;
        Thu,  5 Aug 2021 14:24:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 73D8D20B36F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628198673;
        bh=im2TXdRDzvW2l4XgRg767FkRLUeGkZ+t7v3OVZNX1qY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYl0GH6W1WZ4hIpxd2bE6Yrd27Uu+rule2LAk+hA4AxumW151HLYasIX+onYLoGn1
         +Drrg0VoOSstSsyYi09PbctFrtKSivg+lCKEoLevkXNij5dMef+7YMkR4ztzPUUH4J
         WPzPAaiYqYBwYp1NuLM8Lzo82MknP3nB+q/2xG14=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH 07/19] drivers/hv: withdraw memory hypercall
Date:   Thu,  5 Aug 2021 14:23:49 -0700
Message-Id: <1628198641-791-8-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Withdraw the memory from a finalized partition and free the pages.
The partition is now cleaned up correctly when the fd is released.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/hv_call.c              | 53 +++++++++++++++++++++++++++++++
 drivers/hv/mshv.h                 |  6 ++++
 drivers/hv/mshv_main.c            |  5 +--
 include/asm-generic/hyperv-tlfs.h | 11 +++++++
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
index a96809792d63..a22b1cfb3563 100644
--- a/drivers/hv/hv_call.c
+++ b/drivers/hv/hv_call.c
@@ -14,6 +14,59 @@
 
 #include "mshv.h"
 
+int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
+{
+	struct hv_withdraw_memory_in *input_page;
+	struct hv_withdraw_memory_out *output_page;
+	struct page *page;
+	u16 completed;
+	unsigned long remaining = count;
+	u64 status;
+	int i;
+	unsigned long flags;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	output_page = page_address(page);
+
+	while (remaining) {
+		local_irq_save(flags);
+
+		input_page = (struct hv_withdraw_memory_in *)(*this_cpu_ptr(
+			hyperv_pcpu_input_arg));
+
+		input_page->partition_id = partition_id;
+		input_page->proximity_domain_info.as_uint64 = 0;
+		status = hv_do_rep_hypercall(
+			HVCALL_WITHDRAW_MEMORY,
+			min(remaining, HV_WITHDRAW_BATCH_SIZE), 0, input_page,
+			output_page);
+
+		local_irq_restore(flags);
+
+		completed = hv_repcomp(status);
+
+		for (i = 0; i < completed; i++)
+			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
+
+		if (!hv_result_success(status)) {
+			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
+				status = HV_STATUS_SUCCESS;
+			else
+				pr_err("%s: %s\n", __func__,
+				       hv_status_to_string(status));
+			break;
+		}
+
+		remaining -= completed;
+	}
+	free_page((unsigned long)output_page);
+
+	return hv_status_to_errno(status);
+}
+
+
 int hv_call_create_partition(
 		u64 flags,
 		struct hv_partition_creation_properties creation_properties,
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index 46121bd30592..cf48ec5840b7 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -11,12 +11,18 @@
 #ifndef _MSHV_H_
 #define _MSHV_H_
 
+#include<asm/hyperv-tlfs.h>
+
 /* Determined empirically */
 #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
 
+#define HV_WITHDRAW_BATCH_SIZE	(HV_HYP_PAGE_SIZE / sizeof(u64))
+
 /*
  * Hyper-V hypercalls
  */
+
+int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
 int hv_call_create_partition(
 		u64 flags,
 		struct hv_partition_creation_properties creation_properties,
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index d480b83316e1..67126afaa6e9 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/anon_inodes.h>
+#include <linux/mm.h>
 #include <linux/mshv.h>
 #include <asm/mshyperv.h>
 
@@ -52,7 +53,6 @@ static struct miscdevice mshv_dev = {
 	.mode = 0600,
 };
 
-
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -89,7 +89,8 @@ destroy_partition(struct mshv_partition *partition)
 
 	/* Deallocates and unmaps everything including vcpus, GPA mappings etc */
 	hv_call_finalize_partition(partition->id);
-	/* TODO: Withdraw and free all pages we deposited */
+	/* Withdraw and free all pages we deposited */
+	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->id);
 
 	hv_call_delete_partition(partition->id);
 
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 49099b7e0f71..2e1573978569 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -149,6 +149,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_DELETE_PARTITION			0x0043
 #define HVCALL_GET_PARTITION_ID			0x0046
 #define HVCALL_DEPOSIT_MEMORY			0x0048
+#define HVCALL_WITHDRAW_MEMORY			0x0049
 #define HVCALL_CREATE_VP			0x004e
 #define HVCALL_GET_VP_REGISTERS			0x0050
 #define HVCALL_SET_VP_REGISTERS			0x0051
@@ -515,6 +516,16 @@ union hv_proximity_domain_info {
 	u64 as_uint64;
 } __packed;
 
+struct hv_withdraw_memory_in {
+	u64 partition_id;
+	union hv_proximity_domain_info proximity_domain_info;
+} __packed;
+
+struct hv_withdraw_memory_out {
+	/* Hack - compiler doesn't like empty array size in struct with no other members */
+	u64 gpa_page_list[0];
+} __packed;
+
 struct hv_lp_startup_status {
 	u64 hv_status;
 	u64 substatus1;
-- 
2.23.4

