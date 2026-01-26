Return-Path: <linux-hyperv+bounces-8531-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEeQHtfVd2mFlwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8531-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 22:00:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2398C8D681
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 22:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5FA130160C2
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jan 2026 20:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160B2D876A;
	Mon, 26 Jan 2026 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eDwaG/BX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73EE258EDB;
	Mon, 26 Jan 2026 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460966; cv=none; b=jfEAxUEHHI+aJ8XKsU+LmAu3ROW78Vv6Izwi9lR4mvCfEp/uYd4CpTngYif+KlHV526xnL/y9nn1TNztYlRC0JLVrmSdJX0LdyQ/t9wF489yRt1tqKzNTKuOTIntNXYpmzkpxlyEWZRALrrEqtFKs1Xarw23ZwYN3R5edaUac/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460966; c=relaxed/simple;
	bh=uzeRuEk6mtsIaTnRbzrMVlLOgjMqQcPry4umGAax9Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taGOrzRh5vx6D/7AF+NoIN9ZKOm9CPm6GBo3KSGs9OiqZwJQiU+HPaCojmabXFGYvZycNUYj+m+v7Kn5kEZGFi/pY1erLq51n1tAQs2hBzw5r0QIuAUlwTzHHYsr3SeEWsErLm2xwnBf5nN+eWbuA8wfHO3gkzZr/XEXL9BXmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eDwaG/BX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id CD7FD20B7167; Mon, 26 Jan 2026 12:56:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD7FD20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769460964;
	bh=z2o6YdqfB0oQMRtuk5ZapbPpFV9AcJv3FrMTfcI1w9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDwaG/BXm+XurSqo6TYHSNozb7gzTwmhT9zG4//zHptMP2/K+aeyUOBihfDgB8e7s
	 Xxhs7DWlxYqLUHmk4AjTwOCgSVPIeOwZfnjOHjW2Fosqf2nim+frBiZcfT/ZYmfyHM
	 vpjwc3T4B+ctsI5PXakXN4F+abWkNPZZjkeXYU10=
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
Subject: [PATCH v5 1/7] mshv: Ignore second stats page map result failure
Date: Mon, 26 Jan 2026 12:55:57 -0800
Message-ID: <20260126205603.404655-2-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260126205603.404655-1-nunodasneves@linux.microsoft.com>
References: <20260126205603.404655-1-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8531-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2398C8D681
X-Rspamd-Action: no action

From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>

Older versions of the hypervisor do not have a concept of separate SELF
and PARENT stats areas. In this case, mapping the HV_STATS_AREA_SELF page
is sufficient - it's the only page and it contains all available stats.

Mapping HV_STATS_AREA_PARENT returns HV_STATUS_INVALID_PARAMETER which
currently causes module init to fail on older hypevisor versions.

Detect this case and gracefully fall back to populating
stats_pages[HV_STATS_AREA_PARENT] with the already-mapped SELF page.

Add comments to clarify the behavior, including a clarification of why
this isn't needed for hv_call_map_stats_page2() which always supports
PARENT and SELF areas.

Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c | 52 +++++++++++++++++++++++++++++++---
 drivers/hv/mshv_root_main.c    |  3 ++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 598eaff4ff29..1f93b94d7580 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -813,6 +813,13 @@ hv_call_notify_port_ring_empty(u32 sint_index)
 	return hv_result_to_errno(status);
 }
 
+/*
+ * Equivalent of hv_call_map_stats_page() for cases when the caller provides
+ * the map location.
+ *
+ * NOTE: This is a newer hypercall that always supports SELF and PARENT stats
+ * areas, unlike hv_call_map_stats_page().
+ */
 static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 				   const union hv_stats_object_identity *identity,
 				   u64 map_location)
@@ -855,6 +862,34 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 	return ret;
 }
 
+static int
+hv_stats_get_area_type(enum hv_stats_object_type type,
+		       const union hv_stats_object_identity *identity)
+{
+	switch (type) {
+	case HV_STATS_OBJECT_HYPERVISOR:
+		return identity->hv.stats_area_type;
+	case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
+		return identity->lp.stats_area_type;
+	case HV_STATS_OBJECT_PARTITION:
+		return identity->partition.stats_area_type;
+	case HV_STATS_OBJECT_VP:
+		return identity->vp.stats_area_type;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * Map a stats page, where the page location is provided by the hypervisor.
+ *
+ * NOTE: The concept of separate SELF and PARENT stats areas does not exist on
+ * older hypervisor versions. All the available stats information can be found
+ * on the SELF page. When attempting to map the PARENT area on a hypervisor
+ * that doesn't support it, return "success" but with a NULL address. The
+ * caller should check for this case and instead fallback to the SELF area
+ * alone.
+ */
 static int hv_call_map_stats_page(enum hv_stats_object_type type,
 				  const union hv_stats_object_identity *identity,
 				  void **addr)
@@ -863,7 +898,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
 	struct hv_input_map_stats_page *input;
 	struct hv_output_map_stats_page *output;
 	u64 status, pfn;
-	int ret = 0;
+	int hv_status, ret = 0;
 
 	do {
 		local_irq_save(flags);
@@ -878,11 +913,20 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
 		pfn = output->map_location;
 
 		local_irq_restore(flags);
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
-			ret = hv_result_to_errno(status);
+
+		hv_status = hv_result(status);
+		if (hv_status != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (hv_result_success(status))
 				break;
-			return ret;
+
+			if (hv_stats_get_area_type(type, identity) == HV_STATS_AREA_PARENT &&
+			    hv_status == HV_STATUS_INVALID_PARAMETER) {
+				*addr = NULL;
+				return 0;
+			}
+
+			hv_status_debug(status, "\n");
+			return hv_result_to_errno(status);
 		}
 
 		ret = hv_call_deposit_pages(NUMA_NO_NODE,
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 1134a82c7881..1777778f84b8 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -992,6 +992,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 	if (err)
 		goto unmap_self;
 
+	if (!stats_pages[HV_STATS_AREA_PARENT])
+		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
+
 	return 0;
 
 unmap_self:
-- 
2.34.1


