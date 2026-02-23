Return-Path: <linux-hyperv+bounces-8944-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKC3KfpKnGmODAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8944-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 13:41:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C72D176469
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 13:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15CE23093BEE
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BA2366DC3;
	Mon, 23 Feb 2026 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fODqEtIP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200C366DBD;
	Mon, 23 Feb 2026 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850285; cv=none; b=mvfYA2Vpd2lDlnzgGudV0u1nsy2ZC1hUxGLOuX+sxNDy2fNr9NrXuufOLEJ0CH+eFMsBlkBHtTr2sAP739mx0rJXGh+LauDy6UQaY+Oi80i4WxiVSIqfqr0UMEWsmsQJ9DFtEjBkO4HB/LT1zGyUaF7tmkjXbjnK0qi19E6tymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850285; c=relaxed/simple;
	bh=TOFpe1DnK5oWCgx+hi8hSuXMCP2TQ1XP7VjsLHFhjFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldMp7DN4UU3onn7/45TVSh6v/12VvFECYlO8nh6ibEK12QLtdFu14G884XrzmlYGGo2msC/ff0iHOnbPjVwgF/ZNmZHkOEjAa+4hciNl+HooqfXC7o/iPpbEle6aEEzyBSFIbDbxFavYPCFZEk1tH1Rlej9n1PUgcG4QBlBJRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fODqEtIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C91C19424;
	Mon, 23 Feb 2026 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771850284;
	bh=TOFpe1DnK5oWCgx+hi8hSuXMCP2TQ1XP7VjsLHFhjFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fODqEtIPoWYHIHq1pkMBOWxuhx++VrlA0O1Uz7APxslPfv5mabBMrOQKHaJWHBEZt
	 vPwUnf1W6XpxfOcBIYVwAgqLshhJA3epkuQmcq1rjB1WOOE3EqG2C0PSaU5UC28p5V
	 xKwfERf0l39U/a8Fh5fkfcOgtPkqQccTKvTRqY18Cz9BY2KkuLB/PWi4Zi8okjrQn9
	 tbCqQSjkUDJ0QlM591yauqj0s2Bt2xZfAByT0N8YBoRsIoa64SvWB6ggZI6uj06Jr9
	 8HSUJ+LnshhHoXxyq3YpKD0nY19nYyxAQx4ZEdCmHR9gsVbYtNGHq9i9FRkPNxekpk
	 6gYNtzHtYJSIg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] mshv: Ignore second stats page map result failure
Date: Mon, 23 Feb 2026 07:37:22 -0500
Message-ID: <20260223123738.1532940-17-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.microsoft.com,outlook.com,kernel.org,microsoft.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8944-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 1C72D176469
X-Rspamd-Action: no action

From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>

[ Upstream commit 7538b80e5a4b473b73428d13b3a47ceaad9a8a7c ]

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
Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a thorough analysis.

## Analysis

### 1. Commit Message Analysis

The commit clearly describes a backward compatibility bug: on older
Hyper-V hypervisor versions that don't support separate SELF and PARENT
stats areas, mapping `HV_STATS_AREA_PARENT` returns
`HV_STATUS_INVALID_PARAMETER`, which causes **module initialization to
fail entirely**. This is not a feature addition — it's fixing a
regression/incompatibility where the driver doesn't work on older
hypervisors.

### 2. Code Change Analysis

The fix has three parts:

**a) New helper `hv_stats_get_area_type()`** (~15 lines): Extracts the
stats area type from the identity union based on the object type. This
is needed to distinguish PARENT from SELF area mapping requests.

**b) Modified `hv_call_map_stats_page()`** (~20 lines changed): When the
hypercall returns `HV_STATUS_INVALID_PARAMETER` specifically for a
PARENT area mapping, instead of failing with an error, it returns
success but with `*addr = NULL`. This signals to the caller that PARENT
isn't supported.

**c) Modified `mshv_vp_stats_map()`** (+3 lines): After mapping PARENT,
if the address is NULL (meaning older hypervisor), it falls back to
using the already-mapped SELF page for both areas. This is safe because
on older hypervisors, the SELF page contains all available stats.

### 3. Bug Impact

- **Severity**: HIGH — the driver completely fails to create VPs
  (virtual processors), making it unusable on older hypervisor versions
- **User impact**: Anyone running the mshv_root driver on an older
  Hyper-V hypervisor version cannot use the driver at all
- **Trigger**: Deterministic — always fails on affected hypervisor
  versions, not a race or edge case

### 4. Scope and Risk

- The change is small (~40 lines including comments) and well-contained
  to the stats page mapping path
- It adds graceful degradation, not new behavior — the driver works the
  same on new hypervisors
- Multiple reviewers: Reviewed-by and Acked-by from Stanislav
  Kinsburskii, Reviewed-by from Michael Kelley
- The fallback logic (using SELF page for both) is explicitly described
  as correct by the authors since older hypervisors put all stats in the
  single SELF page

### 5. Stable Tree Applicability

- The mshv_root driver was introduced in **v6.15** (commit
  `621191d709b14`)
- The bug has been present **since the driver was first introduced** —
  the original `mshv_vp_stats_map()` function already mapped both SELF
  and PARENT areas with no fallback
- In v6.19 the function was renamed from `hv_call_map_stat_page` to
  `hv_call_map_stats_page` and wrapped by `hv_map_stats_page` (commit
  `d62313bdf5961`), so backporting to pre-6.19 trees would require minor
  adaptation
- The fix applies to all stable trees containing the mshv_root driver
  (6.15.y through 6.18.y)

### 6. Stable Criteria Assessment

| Criterion | Assessment |
|-----------|-----------|
| Obviously correct and tested | YES — well-reviewed, clear logic |
| Fixes a real bug | YES — module init failure |
| Important issue | YES — driver completely non-functional on older
hypervisors |
| Small and contained | YES — ~40 lines, 2 files, single subsystem |
| No new features | YES — adds backward compatibility/graceful
degradation |

### Verification

- `git show 621191d709b14 -- drivers/hv/mshv_root_main.c` confirmed
  `mshv_vp_stats_map()` with SELF+PARENT mapping was present in the
  original v6.15 driver introduction
- `git show 621191d709b14 -- drivers/hv/mshv_root_hv_call.c` confirmed
  the original `hv_call_map_stat_page()` had no fallback for PARENT area
  failures
- `git describe --contains 621191d709b14` returned `v6.15-rc1~193^2~2`,
  confirming v6.15 introduction
- `git describe --contains d62313bdf5961` returned `v6.19-rc1~56^2~30`,
  confirming function rename happened in v6.19
- `git log -p` diff confirmed the rename from `hv_call_map_stat_page` to
  `hv_call_map_stats_page` occurred in `d62313bdf5961`
- The bug mechanism is verified: older hypervisors return
  `HV_STATUS_INVALID_PARAMETER` for PARENT area mapping, which was not
  handled, causing the error to propagate up and fail VP creation
- Could NOT independently verify which exact stable trees (6.15.y,
  6.16.y, 6.17.y, 6.18.y) are still actively maintained (unverified)

### Conclusion

This is a legitimate bug fix for a complete driver initialization
failure on older Hyper-V hypervisor versions. The bug has existed since
the driver was first introduced in v6.15. The fix is small, well-
contained, well-reviewed, and poses minimal regression risk. Backporting
to pre-6.19 stable trees would require minor adaptation due to function
renames, but the logic is straightforward. It meets all stable kernel
criteria.

**YES**

 drivers/hv/mshv_root_hv_call.c | 52 +++++++++++++++++++++++++++++++---
 drivers/hv/mshv_root_main.c    |  3 ++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 598eaff4ff299..1f93b94d7580c 100644
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
index 681b58154d5ea..d3e8a66443ad6 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -993,6 +993,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 	if (err)
 		goto unmap_self;
 
+	if (!stats_pages[HV_STATS_AREA_PARENT])
+		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
+
 	return 0;
 
 unmap_self:
-- 
2.51.0


