Return-Path: <linux-hyperv+bounces-6820-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0462B52499
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 01:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74D91C22F36
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Sep 2025 23:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DCE313529;
	Wed, 10 Sep 2025 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ow8yQQZ9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49045307482;
	Wed, 10 Sep 2025 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546095; cv=none; b=lo3drqK2nU3iWmetWgK7/o6g56URYY5fA1IWbCyYpNSO8TeEw217R9lIexGNDvnIrVf8D6rCE/uYaEpk/fZZ4TFaFitnaW6+ULxtYJb9pIrMsQy+rdtMYAbWTMZP3u6xQzUMo4d2zU/zQKpeQ6R4AgWclVmz5sAOUICMljAIVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546095; c=relaxed/simple;
	bh=uj50oLn4W9iWHkkYQDAPW8zCrvObomKxnCFUGAGVFT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gXfzi+Tw6wvx8nZa9Xfbcg30qgQ8csPurEix0OaG2/Z9dKnztiIDrj+fOzIBs8kwZc4g9zxVuqADvMBgCCBOI/Z6/wssbU9nBMJr2eRYigHCe+H4UGzOTJwJSTL1tXePBPE6ziDUA2fO7o2UL8M8pW06xmZtI8qckvpVXU6TRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ow8yQQZ9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 006BF2018E74; Wed, 10 Sep 2025 16:14:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 006BF2018E74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757546094;
	bh=03tUE7CG2ivdaFF099uiMNS7w+LteJOOTbhg5vbu3Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ow8yQQZ9lY9t35U3XryscEwDveWK96NNeuvVfER4qFD7mbXYl7KPERgeycDwiQxB4
	 f/DKsg9tWtjYuYTcVUMAL8xhDDbrYDiQ9UxbBJyeU+wsEJz/1Ho2bg9RgeIfSHZ8sS
	 4zPUy39G/D8RNK3gTbecPFQxbXk+W2uJlNShQwZo=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com,
	anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Jinank Jain <jinankjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2 4/5] mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH
Date: Wed, 10 Sep 2025 16:14:48 -0700
Message-Id: <1757546089-2002-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Jinank Jain <jinankjain@linux.microsoft.com>

Introduce mshv_use_overlay_gpfn() to check if a page needs to be
allocated and passed to the hypervisor to map VP state pages. This is
only needed on L1VH, and only on some (newer) versions of the
hypervisor, hence the need to check vmm_capabilities.

Introduce functions hv_map/unmap_vp_state_page() to handle the
allocation and freeing.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         | 11 +++---
 drivers/hv/mshv_root_hv_call.c | 61 +++++++++++++++++++++++++---
 drivers/hv/mshv_root_main.c    | 72 +++++++++++++++++-----------------
 3 files changed, 96 insertions(+), 48 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 0cb1e2589fe1..d7c9520ef788 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -279,11 +279,12 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
 			 /* Choose between pages and bytes */
 			 struct hv_vp_state_data state_data, u64 page_count,
 			 struct page **pages, u32 num_bytes, u8 *bytes);
-int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
-			      union hv_input_vtl input_vtl,
-			      struct page **state_page);
-int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
-				union hv_input_vtl input_vtl);
+int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+			 union hv_input_vtl input_vtl,
+			 struct page **state_page);
+int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+			   void *page_addr,
+			   union hv_input_vtl input_vtl);
 int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
 			u64 connection_partition_id, struct hv_port_info *port_info,
 			u8 port_vtl, u8 min_connection_vtl, int node);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 3fd3cce23f69..1132ba7b2399 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -526,9 +526,9 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
 	return ret;
 }
 
-int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
-			      union hv_input_vtl input_vtl,
-			      struct page **state_page)
+static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+				     union hv_input_vtl input_vtl,
+				     struct page **state_page)
 {
 	struct hv_input_map_vp_state_page *input;
 	struct hv_output_map_vp_state_page *output;
@@ -547,7 +547,14 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 		input->type = type;
 		input->input_vtl = input_vtl;
 
-		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input, output);
+		if (*state_page) {
+			input->flags.map_location_provided = 1;
+			input->requested_map_location =
+				page_to_pfn(*state_page);
+		}
+
+		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input,
+					 output);
 
 		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (hv_result_success(status))
@@ -565,8 +572,39 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 	return ret;
 }
 
-int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
-				union hv_input_vtl input_vtl)
+static bool mshv_use_overlay_gpfn(void)
+{
+	return hv_l1vh_partition() &&
+	       mshv_root.vmm_caps.vmm_can_provide_overlay_gpfn;
+}
+
+int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+			 union hv_input_vtl input_vtl,
+			 struct page **state_page)
+{
+	int ret = 0;
+	struct page *allocated_page = NULL;
+
+	if (mshv_use_overlay_gpfn()) {
+		allocated_page = alloc_page(GFP_KERNEL);
+		if (!allocated_page)
+			return -ENOMEM;
+		*state_page = allocated_page;
+	} else {
+		*state_page = NULL;
+	}
+
+	ret = hv_call_map_vp_state_page(partition_id, vp_index, type, input_vtl,
+					state_page);
+
+	if (ret && allocated_page)
+		__free_page(allocated_page);
+
+	return ret;
+}
+
+static int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+				       union hv_input_vtl input_vtl)
 {
 	unsigned long flags;
 	u64 status;
@@ -590,6 +628,17 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 	return hv_result_to_errno(status);
 }
 
+int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+			   void *page_addr, union hv_input_vtl input_vtl)
+{
+	int ret = hv_call_unmap_vp_state_page(partition_id, vp_index, type, input_vtl);
+
+	if (mshv_use_overlay_gpfn() && page_addr)
+		__free_page(virt_to_page(page_addr));
+
+	return ret;
+}
+
 int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code,
 				      u64 arg, void *property_value,
 				      size_t property_value_sz)
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index f7738cefbdf3..7352c4f9652e 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -908,28 +908,25 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (ret)
 		return ret;
 
-	ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
-					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
-					input_vtl_zero,
-					&intercept_message_page);
+	ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
+				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
+				   input_vtl_zero, &intercept_message_page);
 	if (ret)
 		goto destroy_vp;
 
 	if (!mshv_partition_encrypted(partition)) {
-		ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
-						HV_VP_STATE_PAGE_REGISTERS,
-						input_vtl_zero,
-						&register_page);
+		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
+					   HV_VP_STATE_PAGE_REGISTERS,
+					   input_vtl_zero, &register_page);
 		if (ret)
 			goto unmap_intercept_message_page;
 	}
 
 	if (mshv_partition_encrypted(partition) &&
 	    is_ghcb_mapping_available()) {
-		ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
-						HV_VP_STATE_PAGE_GHCB,
-						input_vtl_normal,
-						&ghcb_page);
+		ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
+					   HV_VP_STATE_PAGE_GHCB,
+					   input_vtl_normal, &ghcb_page);
 		if (ret)
 			goto unmap_register_page;
 	}
@@ -993,21 +990,19 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
 unmap_ghcb_page:
-	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
-		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
-					    HV_VP_STATE_PAGE_GHCB,
-					    input_vtl_normal);
-	}
+	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
+		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
+				       HV_VP_STATE_PAGE_GHCB, vp->vp_ghcb_page,
+				       input_vtl_normal);
 unmap_register_page:
-	if (!mshv_partition_encrypted(partition)) {
-		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
-					    HV_VP_STATE_PAGE_REGISTERS,
-					    input_vtl_zero);
-	}
+	if (!mshv_partition_encrypted(partition))
+		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
+				       HV_VP_STATE_PAGE_REGISTERS,
+				       vp->vp_register_page, input_vtl_zero);
 unmap_intercept_message_page:
-	hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
-				    HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
-				    input_vtl_zero);
+	hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
+			       HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
+			       vp->vp_intercept_msg_page, input_vtl_zero);
 destroy_vp:
 	hv_call_delete_vp(partition->pt_id, args.vp_index);
 	return ret;
@@ -1748,24 +1743,27 @@ static void destroy_partition(struct mshv_partition *partition)
 				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
 
 			if (vp->vp_register_page) {
-				(void)hv_call_unmap_vp_state_page(partition->pt_id,
-								  vp->vp_index,
-								  HV_VP_STATE_PAGE_REGISTERS,
-								  input_vtl_zero);
+				(void)hv_unmap_vp_state_page(partition->pt_id,
+							     vp->vp_index,
+							     HV_VP_STATE_PAGE_REGISTERS,
+							     vp->vp_register_page,
+							     input_vtl_zero);
 				vp->vp_register_page = NULL;
 			}
 
-			(void)hv_call_unmap_vp_state_page(partition->pt_id,
-							  vp->vp_index,
-							  HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
-							  input_vtl_zero);
+			(void)hv_unmap_vp_state_page(partition->pt_id,
+						     vp->vp_index,
+						     HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
+						     vp->vp_intercept_msg_page,
+						     input_vtl_zero);
 			vp->vp_intercept_msg_page = NULL;
 
 			if (vp->vp_ghcb_page) {
-				(void)hv_call_unmap_vp_state_page(partition->pt_id,
-								  vp->vp_index,
-								  HV_VP_STATE_PAGE_GHCB,
-								  input_vtl_normal);
+				(void)hv_unmap_vp_state_page(partition->pt_id,
+							     vp->vp_index,
+							     HV_VP_STATE_PAGE_GHCB,
+							     vp->vp_ghcb_page,
+							     input_vtl_normal);
 				vp->vp_ghcb_page = NULL;
 			}
 
-- 
2.34.1


