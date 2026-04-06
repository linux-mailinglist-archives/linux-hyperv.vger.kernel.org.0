Return-Path: <linux-hyperv+bounces-10003-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIVUEvd702koigcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10003-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 11:25:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9375F3A29D7
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 11:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C862730055A2
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8885A31DD96;
	Mon,  6 Apr 2026 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nhx36ioS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFEF31F9AC;
	Mon,  6 Apr 2026 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775467508; cv=none; b=OY5G+EIIInf95s6MtFNd83JyFi2zeoxEd5rz3c9ROyuNmtaAbYesAjBRAQ4MXqUf1KYMZ0DEe/yUg0a5odUzYTUHiwrigArwe41dXMDgbCcFqhjuv/y8TQ+i5W82X7tJe95LEGFZwOg+p0nTtcurUbJk9STRoNXpFAe3wxXP6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775467508; c=relaxed/simple;
	bh=KQpKLgBupMwnDdsdqlJx5NDRJhB2oM8eYccrpmjzjSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzSecBLu62xMldier4sU4mzK5GhXWr1lzWFpecfRPTzlk26Qub4nx233pYSSf2qyai9fjtcXLqJmOewACqPVjK6T1F+upNF6mfjUxohSyLRimz8aBK50BZ0TmCCwkRHEXdgbhvdlNaMBD7QyN6XBBWnk7q4OQRwjfNrQUWZPVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nhx36ioS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.17])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9F1E420B6F01;
	Mon,  6 Apr 2026 02:25:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F1E420B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775467506;
	bh=Z3FGcRzA+nZnu4ks4lo/AnmQ7tl69LZBu2YTk7BYIAE=;
	h=From:To:Cc:Subject:Date:From;
	b=nhx36ioSEjJKDD2XRPWRoQwJQr68RZrb0+9acjHrSwugXSus1fZLmrqHyAPNBvPpt
	 ygQ2TGjJgx3VA3bYczx930YuTBk59wjZUFiBwsLDo19BerM1k0Y2Gq1cqseOygwbQb
	 7qylHK4zpOkehbLUrkzILCqNNEObD6YMtohWRH5A=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mshv_vtl: Fix vmemmap_shift exceeding MAX_FOLIO_ORDER
Date: Mon,  6 Apr 2026 09:24:59 +0000
Message-ID: <20260406092459.2351028-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10003-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9375F3A29D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When registering VTL0 memory via MSHV_ADD_VTL0_MEMORY, the kernel
computes pgmap->vmemmap_shift as the number of trailing zeros in the
OR of start_pfn and last_pfn, intending to use the largest compound
page order both endpoints are aligned to.

However, this value is not clamped to MAX_FOLIO_ORDER, so a
sufficiently aligned range (e.g. physical range
[0x800000000000, 0x800080000000), corresponding to start_pfn=0x800000000
with 35 trailing zeros) can produce a shift larger than what
memremap_pages() accepts, triggering a WARN and returning -EINVAL:

  WARNING: ... memremap_pages+0x512/0x650
  requested folio size unsupported

The MAX_FOLIO_ORDER check was added by
commit 646b67d57589 ("mm/memremap: reject unreasonable folio/compound
page sizes in memremap_pages()").

Fix this by clamping vmemmap_shift to MAX_FOLIO_ORDER so we always
request the largest order the kernel supports, in those cases, rather
than an out-of-range value.

Also fix the error path to propagate the actual error code from
devm_memremap_pages() instead of hard-coding -EFAULT, which was
masking the real -EINVAL return.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
Changes since v1:
https://lore.kernel.org/all/20260401054005.1532381-1-namjain@linux.microsoft.com/
Addressed Michael's comments:
* remove MAX_FOLIO_ORDER value related text in commit msg
* Change change summary to keep prefix "mshv_vtl:"
* Add comments regarding last_pfn to avoid confusion
* use min instead of min_t
---
 drivers/hv/mshv_vtl_main.c | 12 +++++++++---
 include/uapi/linux/mshv.h  |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 5856975f32e1..c19400701467 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -386,7 +386,6 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
 
 	if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
 		return -EFAULT;
-	/* vtl0_mem.last_pfn is excluded in the pagemap range for VTL0 as per design */
 	if (vtl0_mem.last_pfn <= vtl0_mem.start_pfn) {
 		dev_err(vtl->module_dev, "range start pfn (%llx) > end pfn (%llx)\n",
 			vtl0_mem.start_pfn, vtl0_mem.last_pfn);
@@ -397,6 +396,10 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
 	if (!pgmap)
 		return -ENOMEM;
 
+	/*
+	 * vtl0_mem.last_pfn is excluded in the pagemap range for VTL0 as per design.
+	 * last_pfn is not reserved or wasted, and reflects 'start_pfn + size' of pagemap range.
+	 */
 	pgmap->ranges[0].start = PFN_PHYS(vtl0_mem.start_pfn);
 	pgmap->ranges[0].end = PFN_PHYS(vtl0_mem.last_pfn) - 1;
 	pgmap->nr_range = 1;
@@ -405,8 +408,11 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
 	/*
 	 * Determine the highest page order that can be used for the given memory range.
 	 * This works best when the range is aligned; i.e. both the start and the length.
+	 * Clamp to MAX_FOLIO_ORDER to avoid a WARN in memremap_pages() when the range
+	 * alignment exceeds the maximum supported folio order for this kernel config.
 	 */
-	pgmap->vmemmap_shift = count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn);
+	pgmap->vmemmap_shift = min(count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn),
+				   MAX_FOLIO_ORDER);
 	dev_dbg(vtl->module_dev,
 		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
 		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
@@ -415,7 +421,7 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
 	if (IS_ERR(addr)) {
 		dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", PTR_ERR(addr));
 		kfree(pgmap);
-		return -EFAULT;
+		return PTR_ERR(addr);
 	}
 
 	/* Don't free pgmap, since it has to stick around until the memory
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index e0645a34b55b..32ff92b6342b 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -357,7 +357,7 @@ struct mshv_vtl_sint_post_msg {
 
 struct mshv_vtl_ram_disposition {
 	__u64 start_pfn;
-	__u64 last_pfn;
+	__u64 last_pfn; /* last_pfn is excluded from the range [start_pfn, last_pfn) */
 };
 
 struct mshv_vtl_set_poll_file {
-- 
2.43.0


