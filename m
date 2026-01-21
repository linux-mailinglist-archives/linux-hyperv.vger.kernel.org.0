Return-Path: <linux-hyperv+bounces-8422-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOfEDXlMcWkahAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8422-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:00:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF155E6AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E250078BE8F
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 21:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76B3659EF;
	Wed, 21 Jan 2026 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qpDZqImn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822E224AE0;
	Wed, 21 Jan 2026 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031987; cv=none; b=m3iJZipR4YXt6DqR8lYqdY07SORt6PYEFI+8mtNU1CH9L35hwvDZr4eN+ll+rxganpDB+SHY+CmrIPa5bA0fltavgojHIO9GmUQHl3d9yTz6Oe1HrKaIvXhqcoz9q7NlbeAneq5VZirsiAL7OAouNFazPYT9M6icur7nKsvlWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031987; c=relaxed/simple;
	bh=HFNNVSweFvuB84DU2B4ROhCi6CUVW6aVVK9SMK14epw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twXEmYtFVnNjpf37yIw7ijA0KUsE2onY+DQfdg17ciGT7BflRFymeVcl1XAcl5/Q5qAmaoKHGJAAkJuHmhrEUnl/fYbXIVOXmYQoO9ufHjroMC2gh1dkETWUsOjPPnUJSjcVdrD7elHQ7IiCyIV5+Ygyhr/FGPAaElqjZ/y9yzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qpDZqImn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id CB96520B716B; Wed, 21 Jan 2026 13:46:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB96520B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769031985;
	bh=ARHwRQoJMl3xBLyBPZgcJm/EEXDHa34ijHjF+rMvoPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpDZqImnjh1tzEPUa0ryO4JBeNM5Do88PtRTzq6HdeLS8lA80uUws836pmVYI9Gh7
	 jGyKNX4SqSF3XtyghoUCuf2CFU5fQak98Uv4Pi+ExFKr6ZFMbz2TIA3F5i6zy9dt28
	 aaRbHVRzw1egQKtfKAAY6u6Ic6M8JSQkRrzeNDL8=
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
Subject: [PATCH v4 2/7] mshv: Use typed hv_stats_page pointers
Date: Wed, 21 Jan 2026 13:46:18 -0800
Message-ID: <20260121214623.76374-3-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8422-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: DCF155E6AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


