Return-Path: <linux-hyperv+bounces-10276-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLrRNEeL52lY9wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10276-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:35:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F6543C1E4
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFBC83010B6F
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E43D9025;
	Tue, 21 Apr 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bmcuYYb3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39963D891B;
	Tue, 21 Apr 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782126; cv=none; b=ZAS3aWftbCIfwAScjNIePvz3ea1LTx6x8gzGY3apVyY0CnzDORX1KHSLXjS96G4nlERUH1n67yYyc4fr4U3/MEzKLRgRTA9Pa0OJzbhKohw79eIMdscileS0MV7uhrs6DvLJ5L3LjP8s23+l3MP2pSRsv6dIsz8z6pDaK3nu01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782126; c=relaxed/simple;
	bh=VLZjI5KOBFE5cDHTuj2OVHvxKvrmF+yJW6RgOSEFRoc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cpqg7Af79dkD8faaK8wHCCnTjx7dWjrus7N71MBTAIzjMscgQwpmiL+JcXZ1qYUDP7UkRfU+tPF9FI6mCey2hv+Imws8nQqQW7h3WlGuFqX5RU8aQAe8mXVbVlulcVlEJVfy4LdxpdpKd3nWw2FxlycBcKYB1MX2H3pwmPKAu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bmcuYYb3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82E9E20B6F01;
	Tue, 21 Apr 2026 07:35:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82E9E20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776782125;
	bh=4FDD7g1ExdsoE2Zx9YfOemgeeirSdFvphsqIdcmYHR0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bmcuYYb30WPxKojXlsXKwZX3v3rRhSP+WgtGx2PjBV1ytEx+qFHkgWXpvvm8OCJqD
	 dUwcn8OzLno86ALR1I0EnR0xOWxyR20dPeUKq3/vuSZawOmNZT7Jm0536WzcuI1MdH
	 qCZoZkpznMFL6ojDW8nHsmQ7bCWDcaZ8q+q1WRv0=
Subject: [PATCH v2 2/7] mshv: Add support to address range holes remapping
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Apr 2026 14:35:24 +0000
Message-ID: 
 <177678212475.13344.12375625100231539152.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10276-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: 97F6543C1E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/hv/mshv_regions.c |  104 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 1c8cc200e9c1..48f035ee0bc1 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -119,6 +119,57 @@ static long mshv_region_process_pfns(struct mshv_mem_region *region,
 	return count;
 }
 
+/**
+ * mshv_region_process_hole - Handle a hole (invalid PFNs) in a memory
+ *                            region
+ * @region    : Memory region containing the hole
+ * @flags     : Flags to pass to the handler function
+ * @pfn_offset: Starting PFN offset within the region
+ * @pfn_count : Number of PFNs in the hole
+ * @handler   : Callback function to invoke for the hole
+ *
+ * Invokes the handler function for a contiguous hole with the specified
+ * parameters.
+ *
+ * Return: Number of PFNs handled, or negative error code.
+ */
+static long mshv_region_process_hole(struct mshv_mem_region *region,
+				     u32 flags,
+				     u64 pfn_offset, u64 pfn_count,
+				     int (*handler)(struct mshv_mem_region *region,
+						    u32 flags,
+						    u64 pfn_offset,
+						    u64 pfn_count,
+						    bool huge_page))
+{
+	long ret;
+
+	ret = handler(region, flags, pfn_offset, pfn_count, 0);
+	if (ret)
+		return ret;
+
+	return pfn_count;
+}
+
+static long mshv_region_process_chunk(struct mshv_mem_region *region,
+				      u32 flags,
+				      u64 pfn_offset, u64 pfn_count,
+				      int (*handler)(struct mshv_mem_region *region,
+						     u32 flags,
+						     u64 pfn_offset,
+						     u64 pfn_count,
+						     bool huge_page))
+{
+	if (pfn_valid(region->mreg_pfns[pfn_offset]))
+		return mshv_region_process_pfns(region, flags,
+				pfn_offset, pfn_count,
+				handler);
+	else
+		return mshv_region_process_hole(region, flags,
+				pfn_offset, pfn_count,
+				handler);
+}
+
 /**
  * mshv_region_process_range - Processes a range of PFNs in a region.
  * @region    : Pointer to the memory region structure.
@@ -146,33 +197,47 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 						    u64 pfn_count,
 						    bool huge_page))
 {
-	u64 end;
+	u64 start, end;
 	long ret;
 
+	if (!pfn_count)
+		return 0;
+
 	if (check_add_overflow(pfn_offset, pfn_count, &end))
 		return -EOVERFLOW;
 
 	if (end > region->nr_pfns)
 		return -EINVAL;
 
-	while (pfn_count) {
-		/* Skip non-present pages */
-		if (!pfn_valid(region->mreg_pfns[pfn_offset])) {
-			pfn_offset++;
-			pfn_count--;
+	start = pfn_offset;
+	end = pfn_offset + 1;
+
+	while (end < pfn_offset + pfn_count) {
+		/*
+		 * Accumulate contiguous pfns with the same validity
+		 * (valid or not).
+		 */
+		if (pfn_valid(region->mreg_pfns[start]) ==
+		    pfn_valid(region->mreg_pfns[end])) {
+			end++;
 			continue;
 		}
 
-		ret = mshv_region_process_pfns(region, flags,
-					       pfn_offset, pfn_count,
-					       handler);
+		ret = mshv_region_process_chunk(region, flags,
+						start, end - start,
+						handler);
 		if (ret < 0)
 			return ret;
 
-		pfn_offset += ret;
-		pfn_count -= ret;
+		start += ret;
 	}
 
+	ret = mshv_region_process_chunk(region, flags,
+					start, end - start,
+					handler);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -208,6 +273,9 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
+	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+		return -EINVAL;
+
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
@@ -233,6 +301,9 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 				     u64 pfn_offset, u64 pfn_count,
 				     bool huge_page)
 {
+	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+		return -EINVAL;
+
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
@@ -256,6 +327,14 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
+	/*
+	 * Remap missing pages with no access to let the
+	 * hypervisor track dirty pages, enabling precopy live
+	 * migration.
+	 */
+	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+		flags = HV_MAP_GPA_NO_ACCESS;
+
 	if (huge_page)
 		flags |= HV_MAP_GPA_LARGE_PAGE;
 
@@ -357,6 +436,9 @@ static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 				   u64 pfn_offset, u64 pfn_count,
 				   bool huge_page)
 {
+	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
+		return 0;
+
 	if (huge_page)
 		flags |= HV_UNMAP_GPA_LARGE_PAGE;
 



