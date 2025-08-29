Return-Path: <linux-hyperv+bounces-6663-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E057FB3AFFA
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 02:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2F31BA06EC
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 00:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2663D21171B;
	Fri, 29 Aug 2025 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bX1hfGvU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1091DB154;
	Fri, 29 Aug 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756428239; cv=none; b=azCi0MXFeA8UVOjDxBsvttIzjTYLT7sryUppOpHGTkkA87HzFeL4wFzLGrwW3YPpEJ5Hp2tThwMvd/pPGH1fv5IcUxN+hsobHGn4KkEcMlYZ1i8ccAg7Ku/lRIObWee7Z8ekWSAVszu1Y24ZlfVnMsamRbwYnQ3dQy14aiB6Kvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756428239; c=relaxed/simple;
	bh=XkHyPQZ+FXpILLRjieBXKtqQcJfXXe7xPe60jacxgbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SFIdumbTM4+LD0oKX4hsQSKFcWuyCTYU3eAjJk1U8qlIxksVFobEXihL7YDMviFRyPGUX3q+jhW9o48o4g/dRbUxfHspZsgm2xP3t2bEXnYxypppUCd6NqG4Ua5ir7dXhueO1l6Vy17Zlh8xRhwygi0gTSFAdylyFASmAUtVvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bX1hfGvU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 11274211081C; Thu, 28 Aug 2025 17:43:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11274211081C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756428237;
	bh=06KbI74Yraf1WL8Ldt2URb9/rjEq5OB8ukk3D+ufxWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bX1hfGvUfeDs4M+R9uP3j4QNEWekppvk5wph8oTduzZ5AaoHhxlgFifABccptR1mv
	 YsCDUscCGIwhY2DjpM9InE4lVoPgHn8tnOTMtvqsRrsfLE3uksVWtLq0Qb7IQ/MnQg
	 gxG8P3ArkUI2afLNtdNXDqTLtA6RBSjTAfcBxJF0=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Jinank Jain <jinankjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 6/6] mshv: Introduce new hypercall to map stats page for L1VH partitions
Date: Thu, 28 Aug 2025 17:43:50 -0700
Message-Id: <1756428230-3599-7-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Jinank Jain <jinankjain@linux.microsoft.com>

Introduce HVCALL_MAP_STATS_PAGE2 which provides a map location (GPFN)
to map the stats to. This hypercall is required for L1VH partitions,
depending on the hypervisor version. This uses the same check as the
state page map location; mshv_use_overlay_gpfn().

Add mshv_map_vp_state_page() helpers to use this new hypercall or the
old one depending on availability.

For unmapping, the original HVCALL_UNMAP_STATS_PAGE works for both
cases.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         | 10 ++--
 drivers/hv/mshv_root_hv_call.c | 92 ++++++++++++++++++++++++++++++++--
 drivers/hv/mshv_root_main.c    | 25 +++++----
 include/hyperv/hvgdk_mini.h    |  1 +
 include/hyperv/hvhdk_mini.h    |  7 +++
 5 files changed, 115 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index d7c9520ef788..d16a020ae0ee 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -297,11 +297,11 @@ int hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
 int hv_call_disconnect_port(u64 connection_partition_id,
 			    union hv_connection_id connection_id);
 int hv_call_notify_port_ring_empty(u32 sint_index);
-int hv_call_map_stat_page(enum hv_stats_object_type type,
-			  const union hv_stats_object_identity *identity,
-			  void **addr);
-int hv_call_unmap_stat_page(enum hv_stats_object_type type,
-			    const union hv_stats_object_identity *identity);
+int hv_map_stats_page(enum hv_stats_object_type type,
+		      const union hv_stats_object_identity *identity,
+		      void **addr);
+int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
+			const union hv_stats_object_identity *identity);
 int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 				   u64 page_struct_count, u32 host_access,
 				   u32 flags, u8 acquire);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 1882cc90f2f5..44013751cfc1 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -804,6 +804,45 @@ hv_call_notify_port_ring_empty(u32 sint_index)
 	return hv_result_to_errno(status);
 }
 
+static int
+hv_call_map_stats_page2(enum hv_stats_object_type type,
+			const union hv_stats_object_identity *identity,
+			u64 map_location)
+{
+	unsigned long flags;
+	struct hv_input_map_stats_page2 *input;
+	u64 status;
+	int ret;
+
+	if (!map_location || !mshv_use_overlay_gpfn())
+		return -EINVAL;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+		memset(input, 0, sizeof(*input));
+		input->type = type;
+		input->identity = *identity;
+		input->map_location = map_location;
+
+		status = hv_do_hypercall(HVCALL_MAP_STATS_PAGE2, input, NULL);
+
+		local_irq_restore(flags);
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (hv_result_success(status))
+				break;
+			hv_status_debug(status, "\n");
+			return hv_result_to_errno(status);
+		}
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    hv_current_partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
 static int
 hv_stats_get_area_type(enum hv_stats_object_type type,
 		       const union hv_stats_object_identity *identity)
@@ -822,9 +861,10 @@ hv_stats_get_area_type(enum hv_stats_object_type type,
 	return -EINVAL;
 }
 
-int hv_call_map_stat_page(enum hv_stats_object_type type,
-			  const union hv_stats_object_identity *identity,
-			  void **addr)
+static int
+hv_call_map_stats_page(enum hv_stats_object_type type,
+		       const union hv_stats_object_identity *identity,
+		       void **addr)
 {
 	unsigned long flags;
 	struct hv_input_map_stats_page *input;
@@ -880,8 +920,37 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
 	return ret;
 }
 
-int hv_call_unmap_stat_page(enum hv_stats_object_type type,
-			    const union hv_stats_object_identity *identity)
+int hv_map_stats_page(enum hv_stats_object_type type,
+		      const union hv_stats_object_identity *identity,
+		      void **addr)
+{
+	int ret;
+	struct page *allocated_page = NULL;
+
+	if (!addr)
+		return -EINVAL;
+
+	if (mshv_use_overlay_gpfn()) {
+		allocated_page = alloc_page(GFP_KERNEL);
+		if (!allocated_page)
+			return -ENOMEM;
+
+		ret = hv_call_map_stats_page2(type, identity,
+					      page_to_pfn(allocated_page));
+		*addr = page_address(allocated_page);
+	} else {
+		ret = hv_call_map_stats_page(type, identity, addr);
+	}
+
+	if (ret && allocated_page)
+		__free_page(allocated_page);
+
+	return ret;
+}
+
+static int
+hv_call_unmap_stats_page(enum hv_stats_object_type type,
+			 const union hv_stats_object_identity *identity)
 {
 	unsigned long flags;
 	struct hv_input_unmap_stats_page *input;
@@ -900,6 +969,19 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
 	return hv_result_to_errno(status);
 }
 
+int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
+			const union hv_stats_object_identity *identity)
+{
+	int ret;
+
+	ret = hv_call_unmap_stats_page(type, identity);
+
+	if (mshv_use_overlay_gpfn() && page_addr)
+		__free_page(virt_to_page(page_addr));
+
+	return ret;
+}
+
 int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 				   u64 page_struct_count, u32 host_access,
 				   u32 flags, u8 acquire)
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index f91880cc9e29..1699423cc524 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -894,7 +894,8 @@ mshv_vp_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
+static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
+				void *stats_pages[])
 {
 	union hv_stats_object_identity identity = {
 		.vp.partition_id = partition_id,
@@ -902,10 +903,13 @@ static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
 	};
 
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
-	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
+	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
+
+	if (stats_pages[HV_STATS_AREA_PARENT] == stats_pages[HV_STATS_AREA_SELF])
+		return;
 
 	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
-	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
+	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
 }
 
 static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
@@ -918,14 +922,14 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 	int err;
 
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
-	err = hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
-				    &stats_pages[HV_STATS_AREA_SELF]);
+	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
+				&stats_pages[HV_STATS_AREA_SELF]);
 	if (err)
 		return err;
 
 	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
-	err = hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
-				    &stats_pages[HV_STATS_AREA_PARENT]);
+	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
+				&stats_pages[HV_STATS_AREA_PARENT]);
 	if (err)
 		goto unmap_self;
 
@@ -936,7 +940,7 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 
 unmap_self:
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
-	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
+	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
 	return err;
 }
 
@@ -1044,7 +1048,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	kfree(vp);
 unmap_stats_pages:
 	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
+		mshv_vp_stats_unmap(partition->pt_id, args.vp_index, stats_pages);
 unmap_ghcb_page:
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
 		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
@@ -1796,7 +1800,8 @@ static void destroy_partition(struct mshv_partition *partition)
 				continue;
 
 			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
+				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
+						    (void **)vp->vp_stats_pages);
 
 			if (vp->vp_register_page) {
 				(void)hv_unmap_vp_state_page(partition->pt_id,
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 1bde0aa102ec..27652785e3f2 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -493,6 +493,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
 #define HVCALL_MMIO_READ				0x0106
 #define HVCALL_MMIO_WRITE				0x0107
+#define HVCALL_MAP_STATS_PAGE2				0x0131
 
 /* HV_HYPERCALL_INPUT */
 #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index bf2ce27dfcc5..064bf735cab6 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -177,6 +177,13 @@ struct hv_input_map_stats_page {
 	union hv_stats_object_identity identity;
 } __packed;
 
+struct hv_input_map_stats_page2 {
+	u32 type; /* enum hv_stats_object_type */
+	u32 padding;
+	union hv_stats_object_identity identity;
+	u64 map_location;
+} __packed;
+
 struct hv_output_map_stats_page {
 	u64 map_location;
 } __packed;
-- 
2.34.1


