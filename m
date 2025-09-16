Return-Path: <linux-hyperv+bounces-6903-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C755FB7E5BF
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7896D3B6D5D
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B122FD7B4;
	Tue, 16 Sep 2025 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SjYpjoMI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C652F0C7F;
	Tue, 16 Sep 2025 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066272; cv=none; b=IYcg7LFsZOfolFi6Q7sK8PBR7g9YIkeC9QIshbCRbLsNYIhw9rpEKZvgn33uC2yohdkfpPr/79l5Uh4sg5Nxb634m0gaDECph1EKoUntZxDUHhD0m47zkb2jHzZJBGTUMCp/WtzS2JAE2piSTffnYEwywKxSRHP7QZ20XitF9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066272; c=relaxed/simple;
	bh=G9HEfHljZx9K/X0ML0MbIDMDc/Hst7+KPE6JUWFLJQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jtXqDfprMpNbWUb9vjWok2W/x7qmOFbkrNtq9RC9Q92UXyhBWZv4NjELHOIHEBGejarFPTcFdPzTlZlKT+sfbvB0s6mwEnuo6E3wwcLPKjh/vCvWIK35KS7U/MVrf/fdMVpDweNKwCV5TJIguzOkI28KAO6sM1sN75ooc9V8lLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SjYpjoMI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 6C9242018E59; Tue, 16 Sep 2025 16:44:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C9242018E59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758066268;
	bh=AoQSxDxShccMD598jHrAzFmwd0byEOMlUbdMQCBphew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SjYpjoMIMtXceM16RWtVMRJwCytRYdccgFnaJ2bmVQhESPM9sz8QFUU81EHZ/9/QP
	 mu7W/3VokQ4rTQx5rYSNy04PUtnovpjTIxBWBB0ZRA1cc+I91OCX6HgsKUUOxOw00f
	 R8eSt+V+m4GYlgnjR0iLy7kvtyuDRcyuLKPkY7/M=
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
Subject: [PATCH v3 5/5] mshv: Introduce new hypercall to map stats page for L1VH partitions
Date: Tue, 16 Sep 2025 16:44:22 -0700
Message-Id: <1758066262-15477-6-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
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
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         | 10 ++--
 drivers/hv/mshv_root_hv_call.c | 89 ++++++++++++++++++++++++++++++++--
 drivers/hv/mshv_root_main.c    | 22 +++++----
 include/hyperv/hvgdk_mini.h    |  1 +
 include/hyperv/hvhdk_mini.h    |  7 +++
 5 files changed, 109 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index dbe2d1d0b22f..0dfccfbe6123 100644
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
index 98c6278ff151..7fb7072c071d 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -804,9 +804,47 @@ hv_call_notify_port_ring_empty(u32 sint_index)
 	return hv_result_to_errno(status);
 }
 
-int hv_call_map_stat_page(enum hv_stats_object_type type,
-			  const union hv_stats_object_identity *identity,
-			  void **addr)
+static int hv_call_map_stats_page2(enum hv_stats_object_type type,
+				   const union hv_stats_object_identity *identity,
+				   u64 map_location)
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
+static int hv_call_map_stats_page(enum hv_stats_object_type type,
+				  const union hv_stats_object_identity *identity,
+				  void **addr)
 {
 	unsigned long flags;
 	struct hv_input_map_stats_page *input;
@@ -845,8 +883,36 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
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
+static int hv_call_unmap_stats_page(enum hv_stats_object_type type,
+				    const union hv_stats_object_identity *identity)
 {
 	unsigned long flags;
 	struct hv_input_unmap_stats_page *input;
@@ -865,6 +931,19 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
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
index 52f69eace9b9..cf46f6772a89 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -841,7 +841,8 @@ mshv_vp_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
+static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
+				void *stats_pages[])
 {
 	union hv_stats_object_identity identity = {
 		.vp.partition_id = partition_id,
@@ -849,10 +850,10 @@ static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
 	};
 
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
-	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
+	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
 
 	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
-	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
+	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
 }
 
 static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
@@ -865,14 +866,14 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
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
 
@@ -880,7 +881,7 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 
 unmap_self:
 	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
-	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
+	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
 	return err;
 }
 
@@ -988,7 +989,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	kfree(vp);
 unmap_stats_pages:
 	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
+		mshv_vp_stats_unmap(partition->pt_id, args.vp_index, stats_pages);
 unmap_ghcb_page:
 	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
 		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
@@ -1740,7 +1741,8 @@ static void destroy_partition(struct mshv_partition *partition)
 				continue;
 
 			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
-				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
+				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
+						    (void **)vp->vp_stats_pages);
 
 			if (vp->vp_register_page) {
 				(void)hv_unmap_vp_state_page(partition->pt_id,
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index ff4325fb623a..f66565106d21 100644
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


