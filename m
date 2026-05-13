Return-Path: <linux-hyperv+bounces-10853-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOZnMpjIBGodOgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10853-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:53:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5AE539541
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2ED53089840
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6242D3AE6FD;
	Wed, 13 May 2026 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jXCh9hBc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F23A7F4A;
	Wed, 13 May 2026 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698248; cv=none; b=qaLexLMq702Ld9hFi/ssVWvlN8vKggpbE6s3Uc56H/jg7e9hKY0s/oPxsmg2U7iILZ2Igoc/1v3X6jPCHi1Jza+LtbXp/e5FdYcguykqFhtvoO4RhvuJJ6L0YRqW1XSTaUxNfpkrAQhLB0dqY8rUtXQAVi/Pg8Wdx18dNoOgkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698248; c=relaxed/simple;
	bh=jxqsobnfJ/Z+LzXZVi6c2FEptlBkcaO3zo1J8r/3mj0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCu1Tqvp5OaTSDU1wfrXiqAddYkhYB4eXn2I9IzNUjHx+r5982w7n+P+JBeCUOguNv9pYK5oTdAjjepCy2R8A3j7LcjziQPbD1N8njFWk2A2gGpDOCYGDKkecV869AXKPK7cCJcZyycQvoEnnCR4wRMutHIyKPvoMt8Oht45quc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jXCh9hBc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B9CC20B7169;
	Wed, 13 May 2026 11:50:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B9CC20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698243;
	bh=RGSqKJcgCEhtMssDaEv9TkVM9E+ZR+9zZADXzOtrRaE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jXCh9hBcOvLVesWbDdDmabImn8PTUwI5yGcsTQkD9rZtUQtWqdHm3JjfvDJ/8UbH8
	 esD5Z8HO4DOPWYx4iC9p1j1XwYirFdWbn89O5jVGOuYNCyIRPIW1FtTyfk7bdTwjFc
	 z9Qd48d1t+PEaTmAxLWWocWu+PIgiEqpxccJe+KE=
Subject: [PATCH v3 05/11] mshv: Support address range holes in remapping
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:50:45 +0000
Message-ID: 
 <177869824588.18773.15557069054488920623.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3F5AE539541
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10853-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

Consolidate memory region processing to handle both valid and invalid PFNs
uniformly. This eliminates code duplication across remap, unmap, share, and
unshare operations by using a common range processing interface.

Holes are now remapped with no-access permissions to enable
hypervisor dirty page tracking for precopy live migration.

This refactoring is a precursor to an upcoming change that will map
present pages in movable regions upon region creation, requiring
consistent handling of both mapped and unmapped ranges.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   70 ++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 090c4052f0f4d..579a29f2924b8 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -81,30 +81,23 @@ static int mshv_chunk_stride(unsigned long pfn, u64 gfn, u64 pfn_count)
 }
 
 /**
- * mshv_region_chunk_size - Length of the next same-stride PFN run.
+ * mshv_region_chunk_size - Length of the next contiguous PFN run in a region.
  * @region    : Memory region whose PFN array is being walked.
- * @pfn_offset: Offset into region->mreg_pfns at which to start; the
- *              PFN at this offset must be valid.
- * @pfn_count : Upper bound on the run length (not necessarily the
- *              region's total length; typically the residual passed
- *              from mshv_region_process_range()).
- * @huge_page : Out-parameter set to true if the run is backed by
- *              PMD-order folios and may be dispatched as 2 MiB
- *              chunks; false for 4 KiB-stride dispatch.
+ * @pfn_offset: Offset into region->mreg_pfns at which to start.
+ * @pfn_count : Upper bound on the run length.
+ * @huge_page : Out-parameter set to true if the run may be dispatched
+ *              as a 2 MiB chunk; false for 4 KiB-stride dispatch.
  *
- * Walks the PFN array starting at @pfn_offset and returns the length
- * of the longest contiguous run that shares the stride classification
- * (4 KiB vs 2 MiB) of the first PFN.  An invalid PFN inside the run
- * terminates it.  The run is bounded above by @pfn_count.
- *
- * The caller may then dispatch [pfn_offset, pfn_offset + return) to a
- * handler with @huge_page indicating which stride applies.  After the
- * dispatch the caller advances by the returned length and re-invokes
- * this function for the next run.
+ * Returns the length of the longest contiguous run starting at @pfn_offset
+ * that shares the classification of the first PFN: either a same-stride run of
+ * valid PFNs (4 KiB or 2 MiB) or a hole of invalid PFNs. A hole that is
+ * huge-page aligned in @gfn space and at least PTRS_PER_PMD entries long is
+ * reported as a 2 MiB chunk (huge_page = true) so the caller can dispatch it
+ * as a single HV_MAP_GPA_NO_ACCESS huge mapping. The run is bounded above by
+ * @pfn_count.
  *
  * Return: Length of the run in PFNs, or a negative errno from
- *         mshv_chunk_stride() if the starting PFN is invalid or its
- *         backing folio order is unsupported.
+ *         mshv_chunk_stride() if the backing folio order is unsupported.
  */
 static long mshv_region_chunk_size(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count,
@@ -114,6 +107,22 @@ static long mshv_region_chunk_size(struct mshv_mem_region *region,
 	u64 gfn = region->start_gfn + pfn_offset;
 	u64 count = 0, stride;
 
+	if (!mshv_pfn_valid(pfns[0])) {
+		for (count = 1; count < pfn_count; count++) {
+			if (mshv_pfn_valid(pfns[count]))
+				break;
+		}
+
+		if (IS_ALIGNED(gfn, PTRS_PER_PMD) &&
+		    count >= PTRS_PER_PMD) {
+			*huge_page = true;
+			return ALIGN_DOWN(count, PTRS_PER_PMD);
+		}
+
+		*huge_page = false;
+		return count;
+	}
+
 	stride = mshv_chunk_stride(pfns[0], gfn, pfn_count);
 	if (stride < 0)
 		return stride;
@@ -170,13 +179,6 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 		bool huge_page;
 		long count;
 
-		/* Skip non-present pages */
-		if (!mshv_pfn_valid(region->mreg_pfns[pfn_offset])) {
-			pfn_offset++;
-			pfn_count--;
-			continue;
-		}
-
 		count = mshv_region_chunk_size(region, pfn_offset, pfn_count,
 					       &huge_page);
 		if (count < 0)
@@ -223,6 +225,9 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
+	if (!mshv_pfn_valid(region->mreg_pfns[pfn_offset]))
+		return -EINVAL;
+
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
@@ -248,6 +253,9 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 				     u64 pfn_offset, u64 pfn_count,
 				     bool huge_page)
 {
+	if (!mshv_pfn_valid(region->mreg_pfns[pfn_offset]))
+		return -EINVAL;
+
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
@@ -271,6 +279,14 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
+	/*
+	 * Remap missing pages with no access to let the
+	 * hypervisor track dirty pages, enabling precopy live
+	 * migration.
+	 */
+	if (!mshv_pfn_valid(region->mreg_pfns[pfn_offset]))
+		flags = HV_MAP_GPA_NO_ACCESS;
+
 	if (huge_page)
 		flags |= HV_MAP_GPA_LARGE_PAGE;
 



