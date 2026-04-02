Return-Path: <linux-hyperv+bounces-9926-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O/pLY6wzml+pQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9926-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:08:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E8A38CE44
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DF733025F1A
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C3436F40D;
	Thu,  2 Apr 2026 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V307Y82j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EB2370D48;
	Thu,  2 Apr 2026 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153083; cv=none; b=sMUaReKOKlhsg+IO2z7glbSIFlFoYpGocp+I1mscPp18LkXX7rH2z5U+93MXpwKCShWtvt05kSfyrTDZ8IyfajSmpXz8fGAO2MnusT3UdJfmvAI1wGbnin52X1EoFuQF7jSrCUbtFgUDV8nizTlotUxsSB0To+TLa0IY1Nm0DjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153083; c=relaxed/simple;
	bh=CzxXAuMe0S+7sWyJZq4isDZy9CwLZUMt1gTI0R5Slhw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgFvJl33eOhc024Jy8juU25hWZVcAqkaSyzcI03KmB7QcuSTeXnltLc9EylSqxad3gWpeMJ4pxyCgnpgWNvMtEzWG6VkHgUoQK1Wob0NrzO1LSJNPIOzqaZFf/VMDahZOPp7NfVBvUdEG45Nn1V6qshg3RJAkUzWjcoNqyFmH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V307Y82j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9EF6B20B6F0C;
	Thu,  2 Apr 2026 11:04:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9EF6B20B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775153082;
	bh=qUdKR/mGxmnhqsAY1UCig/542TiQEFn+AYhQmXVR4mE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=V307Y82jvNZJS3jjahJkTR6MhcjYamnTVDpbIvd9/Am2az98tm3/ajAENlIHNgtu/
	 oOlH71pgoU39Dfy8OdcV577sDqR+GSmRZxmJs5paMTVX++s8T3AIfYZ3adDY/qc9K5
	 BnMSpABnh/aBCWZJv06NRRiEaVpJNua5wU5FCEdA=
Subject: [PATCH v2 6/7] mshv: Simplify pfn array handling in region processing
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 18:04:42 +0000
Message-ID: 
 <177515308205.119822.13763900629031291081.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177515251087.119822.1940529498624181326.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177515251087.119822.1940529498624181326.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9926-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0E8A38CE44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current code requires passing both the full pfn array and an offset
parameter to region processing functions, forcing callees to manually
index into arrays. This approach is inflexible and makes it difficult
to work with different sources of pfn arrays.

Upcoming changes will need to pass pfn arrays obtained from the HMM
framework directly to these functions. The HMM framework returns arrays
that represent specific ranges rather than full region arrays with
offsets, making the current offset-based indexing pattern incompatible.

Refactor by having callers pass pre-offset pointers to pfn arrays and
removing offset-based indexing from callees. This allows functions to
work with any pfn array starting at index 0, regardless of its source,
and prepares the code for HMM integration.

No functional change intended.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 120ce2588501..3c2a35f3bc31 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -92,7 +92,7 @@ static long mshv_region_process_pfns(struct mshv_region *region,
 	unsigned long pfn;
 	int stride, ret;
 
-	pfn = pfns[pfn_offset];
+	pfn = pfns[0];
 	if (!pfn_valid(pfn))
 		return -EINVAL;
 
@@ -102,7 +102,7 @@ static long mshv_region_process_pfns(struct mshv_region *region,
 
 	/* Start at stride since the first stride is validated */
 	for (count = stride; count < pfn_count ; count += stride) {
-		pfn = pfns[pfn_offset + count];
+		pfn = pfns[count];
 
 		/* Break if current pfn is invalid */
 		if (!pfn_valid(pfn))
@@ -157,7 +157,7 @@ static long mshv_region_process_chunk(struct mshv_region *region,
 				      unsigned long *pfns,
 				      pfn_handler_t handler)
 {
-	if (pfn_valid(pfns[pfn_offset]))
+	if (pfn_valid(pfns[0]))
 		return mshv_region_process_pfns(region, flags,
 				pfn_offset, pfn_count, pfns,
 				handler);
@@ -204,10 +204,7 @@ static int mshv_region_process_range(struct mshv_region *region,
 	if (end > region->nr_pfns)
 		return -EINVAL;
 
-	start = pfn_offset;
-	end = pfn_offset + 1;
-
-	while (end < pfn_offset + pfn_count) {
+	for (start = 0, end = 1; end < pfn_count; ) {
 		/*
 		 * Accumulate contiguous pfns with the same validity
 		 * (valid or not).
@@ -218,8 +215,9 @@ static int mshv_region_process_range(struct mshv_region *region,
 		}
 
 		ret = mshv_region_process_chunk(region, flags,
-						start, end - start,
-						pfns, handler);
+						pfn_offset + start,
+						end - start,
+						pfns + start, handler);
 		if (ret < 0)
 			return ret;
 
@@ -227,8 +225,9 @@ static int mshv_region_process_range(struct mshv_region *region,
 	}
 
 	ret = mshv_region_process_chunk(region, flags,
-					start, end - start,
-					pfns, handler);
+					pfn_offset + start,
+					end - start,
+					pfns + start, handler);
 	if (ret < 0)
 		return ret;
 
@@ -296,15 +295,14 @@ static int mshv_region_chunk_share(struct mshv_region *region,
 				   unsigned long *pfns,
 				   bool huge_page)
 {
-	if (!pfn_valid(pfns[pfn_offset]))
+	if (!pfn_valid(pfns[0]))
 		return -EINVAL;
 
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      pfns + pfn_offset,
-					      pfn_count,
+					      pfns, pfn_count,
 					      HV_MAP_GPA_READABLE |
 					      HV_MAP_GPA_WRITABLE,
 					      flags, true);
@@ -326,15 +324,15 @@ static int mshv_region_chunk_unshare(struct mshv_region *region,
 				     unsigned long *pfns,
 				     bool huge_page)
 {
-	if (!pfn_valid(pfns[pfn_offset]))
+	if (!pfn_valid(pfns[0]))
 		return -EINVAL;
 
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      pfns + pfn_offset,
-					      pfn_count, 0,
+					      pfns, pfn_count,
+					      0,
 					      flags, false);
 }
 
@@ -359,7 +357,7 @@ static int mshv_region_chunk_remap(struct mshv_region *region,
 	 * hypervisor track dirty pages, enabling precopy live
 	 * migration.
 	 */
-	if (!pfn_valid(pfns[pfn_offset]))
+	if (!pfn_valid(pfns[0]))
 		flags = HV_MAP_GPA_NO_ACCESS;
 
 	if (huge_page)
@@ -368,7 +366,7 @@ static int mshv_region_chunk_remap(struct mshv_region *region,
 	return hv_call_map_ram_pfns(region->partition->pt_id,
 				    region->start_gfn + pfn_offset,
 				    pfn_count, flags,
-				    pfns + pfn_offset);
+				    pfns);
 }
 
 static int mshv_region_remap_pfns(struct mshv_region *region,
@@ -658,7 +656,7 @@ static int mshv_region_collect_and_map(struct mshv_region *region,
 
 	ret = mshv_region_remap_pfns(region, region->hv_map_flags,
 				     pfn_offset, pfn_count,
-				     region->mreg_pfns);
+				     region->mreg_pfns + pfn_offset);
 
 	mutex_unlock(&region->mreg_mutex);
 out:



