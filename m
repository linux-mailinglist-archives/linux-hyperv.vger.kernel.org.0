Return-Path: <linux-hyperv+bounces-8302-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 574DBD21646
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 22:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8828D30703D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 21:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D137BE72;
	Wed, 14 Jan 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZITdm43C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268D236D50C;
	Wed, 14 Jan 2026 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426747; cv=none; b=Q90Ywy+DdAc8oCcynDnP3fcvw4+Hxe/zLM0T/qSqjWOtKx6ICxOCoWJwGfK1dRgFBZBT2fXEgohnysCNuJ/GhuvE7n/Lqq3DzWEVMdpNW8f464huNGCkJ4fGxweSxlhLQrANQHQ0PklR2COvuTUdMbVb3HUjJxslUhRjmamek6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426747; c=relaxed/simple;
	bh=HFNNVSweFvuB84DU2B4ROhCi6CUVW6aVVK9SMK14epw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBb4LjdqiheTef+FPxL9NygMe56cdUmTQAEBU1EpFxhKLcsLdPIYai9vBLgO27WuxZ/kQDV0cuMl47h5OXGD7YroVCkMkrjfJ0+Kjv+5ewjeXAfwAEiC8f1uhGDAwn5bJCdjQ0p6mqQpNDE8ABQJdq4byQpRhGikzM2lvunOqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZITdm43C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 7368D20B716E; Wed, 14 Jan 2026 13:38:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7368D20B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768426687;
	bh=ARHwRQoJMl3xBLyBPZgcJm/EEXDHa34ijHjF+rMvoPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZITdm43CISdgM+IH5lO97309apB8Pi6IPlQM8StHzE26qTnfc1fXFqKbSmq260ZZx
	 Sg6PoVZhl88Mff/sk85nrXOFe1R8j7UNN8+2jkxSdBPNlXdVqACnHBPBb602UeU2N/
	 yZKMfwjUwrlbmZfQ592TvQ6x1hoRZ7WWLhUEXk4M=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v3 2/6] mshv: Use typed hv_stats_page pointers
Date: Wed, 14 Jan 2026 13:37:59 -0800
Message-ID: <20260114213803.143486-3-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260114213803.143486-1-nunodasneves@linux.microsoft.com>
References: <20260114213803.143486-1-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Refactor all relevant functions to use struct hv_stats_page pointers
instead of void pointers for stats page mapping and unmapping thus
improving type safety and code clarity across the Hyper-V stats mapping
APIs.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         |  5 +++--
 drivers/hv/mshv_root_hv_call.c | 12 +++++++-----
 drivers/hv/mshv_root_main.c    |  8 ++++----
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 3c1d88b36741..05ba1f716f9e 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -307,8 +307,9 @@ int hv_call_disconnect_port(u64 connection_partition_id,
 int hv_call_notify_port_ring_empty(u32 sint_index);
 int hv_map_stats_page(enum hv_stats_object_type type,
 		      const union hv_stats_object_identity *identity,
-		      void **addr);
-int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
+		      struct hv_stats_page **addr);
+int hv_unmap_stats_page(enum hv_stats_object_type type,
+			struct hv_stats_page *page_addr,
 			const union hv_stats_object_identity *identity);
 int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 				   u64 page_struct_count, u32 host_access,
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 1f93b94d7580..daee036e48bc 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -890,9 +890,10 @@ hv_stats_get_area_type(enum hv_stats_object_type type,
  * caller should check for this case and instead fallback to the SELF area
  * alone.
  */
-static int hv_call_map_stats_page(enum hv_stats_object_type type,
-				  const union hv_stats_object_identity *identity,
-				  void **addr)
+static int
+hv_call_map_stats_page(enum hv_stats_object_type type,
+		       const union hv_stats_object_identity *identity,
+		       struct hv_stats_page **addr)
 {
 	unsigned long flags;
 	struct hv_input_map_stats_page *input;
@@ -942,7 +943,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
 
 int hv_map_stats_page(enum hv_stats_object_type type,
 		      const union hv_stats_object_identity *identity,
-		      void **addr)
+		      struct hv_stats_page **addr)
 {
 	int ret;
 	struct page *allocated_page = NULL;
@@ -990,7 +991,8 @@ static int hv_call_unmap_stats_page(enum hv_stats_object_type type,
 	return hv_result_to_errno(status);
 }
 
-int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
+int hv_unmap_stats_page(enum hv_stats_object_type type,
+			struct hv_stats_page *page_addr,
 			const union hv_stats_object_identity *identity)
 {
 	int ret;
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 1777778f84b8..be5ad0fbfbee 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -957,7 +957,7 @@ mshv_vp_release(struct inode *inode, struct file *filp)
 }
 
 static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
-				void *stats_pages[])
+				struct hv_stats_page *stats_pages[])
 {
 	union hv_stats_object_identity identity = {
 		.vp.partition_id = partition_id,
@@ -972,7 +972,7 @@ static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
 }
 
 static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
-			     void *stats_pages[])
+			     struct hv_stats_page *stats_pages[])
 {
 	union hv_stats_object_identity identity = {
 		.vp.partition_id = partition_id,
@@ -1010,7 +1010,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	struct mshv_create_vp args;
 	struct mshv_vp *vp;
 	struct page *intercept_msg_page, *register_page, *ghcb_page;
-	void *stats_pages[2];
+	struct hv_stats_page *stats_pages[2];
 	long ret;
 
 	if (copy_from_user(&args, arg, sizeof(args)))
@@ -1729,7 +1729,7 @@ static void destroy_partition(struct mshv_partition *partition)
 
 			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
-						    (void **)vp->vp_stats_pages);
+						    vp->vp_stats_pages);
 
 			if (vp->vp_register_page) {
 				(void)hv_unmap_vp_state_page(partition->pt_id,
-- 
2.34.1


