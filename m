Return-Path: <linux-hyperv+bounces-7184-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67524BCEA63
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 23:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F5D44E6F8D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 21:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1FB3043BE;
	Fri, 10 Oct 2025 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g8+5SZv/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650E303C8A;
	Fri, 10 Oct 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760133357; cv=none; b=Bg+haUX8Gu0YsFsgxxT8BKw7g7a4uylwtZ6GnhSBXBg6WZa5XWrkNsWJSxVHhBIVBtIlI3Qs2z2a19Jb5+Fl2Xr+3ZzgkSfUzA/ymCwD5iok/X5bxvGfjz5vZgNuveuTQExHcVk5yCJwc25hsxvfioPVGIOQBu1h7mGaxY0G108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760133357; c=relaxed/simple;
	bh=9rrJHvRgmXC67zR+UHTWB0z6NpSq+N1W2ZQpD+kvowg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aYY3TOKFMi5hwRgwZzsyllFAQgfJSjcazwWUBmFE5ySr8XIMLP9lm7ia+Nr4UwdA9FmDfCWEHR5NErth6b/PNm/fZT0vc0a0/9DsoD5WxLeSlRIWl88d2D628dX7ZLYto8t1iMBYWf8+/uP9j5AB0MB36/oVqoKO44oVHf3+9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g8+5SZv/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 50ACC211C294; Fri, 10 Oct 2025 14:55:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50ACC211C294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760133355;
	bh=0wZLCYx2re7dQlIHFbC0ynLKs/8/btxDPHcbxVyIPGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8+5SZv/oH/cQi9DiZ8LDILzYgZgGVznCmcBsJplhRE6pnTw+J1JUger15mD/mnsh
	 ELas9eWTWxisU6zpLKB6LYeETVNAwetsb5qkU7LDZC3JDVr1GHw8EWkg+DTlAGiWp3
	 as6TrrjXxOwIm/dEMuy5F3dpgo/Wuube1hZufxUc=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com,
	anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	Jinank Jain <jinankjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v5 4/5] mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH
Date: Fri, 10 Oct 2025 14:55:50 -0700
Message-Id: <1760133351-6643-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1760133351-6643-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1760133351-6643-1-git-send-email-nunodasneves@linux.microsoft.com>
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
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/mshv_root.h         | 11 ++---
 drivers/hv/mshv_root_hv_call.c | 64 +++++++++++++++++++++++++---
 drivers/hv/mshv_root_main.c    | 76 +++++++++++++++++-----------------
 3 files changed, 101 insertions(+), 50 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 0cb1e2589fe1..dbe2d1d0b22f 100644
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
+			   struct page *state_page,
+			   union hv_input_vtl input_vtl);
 int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
 			u64 connection_partition_id, struct hv_port_info *port_info,
 			u8 port_vtl, u8 min_connection_vtl, int node);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 8049e51c45dc..6dac9fcc092c 100644
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
@@ -542,12 +542,20 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
 
+		memset(input, 0, sizeof(*input));
 		input->partition_id = partition_id;
 		input->vp_index = vp_index;
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
@@ -565,8 +573,41 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
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
+	if (ret && allocated_page) {
+		__free_page(allocated_page);
+		*state_page = NULL;
+	}
+
+	return ret;
+}
+
+static int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+				       union hv_input_vtl input_vtl)
 {
 	unsigned long flags;
 	u64 status;
@@ -590,6 +631,17 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 	return hv_result_to_errno(status);
 }
 
+int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+			   struct page *state_page, union hv_input_vtl input_vtl)
+{
+	int ret = hv_call_unmap_vp_state_page(partition_id, vp_index, type, input_vtl);
+
+	if (mshv_use_overlay_gpfn() && state_page)
+		__free_page(state_page);
+
+	return ret;
+}
+
 int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code,
 				      u64 arg, void *property_value,
 				      size_t property_value_sz)
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 94cc482c6c26..b1bd3e2a15ef 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -890,7 +890,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 {
 	struct mshv_create_vp args;
 	struct mshv_vp *vp;
-	struct page *intercept_message_page, *register_page, *ghcb_page;
+	struct page *intercept_msg_page, *register_page, *ghcb_page;
 	void *stats_pages[2];
 	long ret;
 
@@ -908,28 +908,25 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (ret)
 		return ret;
 
-	ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
-					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
-					input_vtl_zero,
-					&intercept_message_page);
+	ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
+				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
+				   input_vtl_zero, &intercept_msg_page);
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
@@ -960,7 +957,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	atomic64_set(&vp->run.vp_signaled_count, 0);
 
 	vp->vp_index = args.vp_index;
-	vp->vp_intercept_msg_page = page_to_virt(intercept_message_page);
+	vp->vp_intercept_msg_page = page_to_virt(intercept_msg_page);
 	if (!mshv_partition_encrypted(partition))
 		vp->vp_register_page = page_to_virt(register_page);
 
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
+				       HV_VP_STATE_PAGE_GHCB, ghcb_page,
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
+				       register_page, input_vtl_zero);
 unmap_intercept_message_page:
-	hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
-				    HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
-				    input_vtl_zero);
+	hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
+			       HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
+			       intercept_msg_page, input_vtl_zero);
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
+							     virt_to_page(vp->vp_register_page),
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
+						     virt_to_page(vp->vp_intercept_msg_page),
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
+							     virt_to_page(vp->vp_ghcb_page),
+							     input_vtl_normal);
 				vp->vp_ghcb_page = NULL;
 			}
 
-- 
2.34.1


