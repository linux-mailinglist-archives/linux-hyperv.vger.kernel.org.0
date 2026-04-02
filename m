Return-Path: <linux-hyperv+bounces-9927-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHBWL/yvzml+pQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9927-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:05:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A538CDF0
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C4183053DAB
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81353372EF5;
	Thu,  2 Apr 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XmxJqTzF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213342F9984;
	Thu,  2 Apr 2026 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153089; cv=none; b=ViAEKJhatvl0TpwIgHcZ6YmsxKrfX+4wm6srnSRcAhIp2hUmKJyJdR0Sy1lhbq3PPi0MdeX64G/l4NWymMt+Ba1aN+MIKnwAi3xY7xfUaCFixvaXMtzpDmMPxm2VzyNOsNWBqaOnpmjJNRj1VPU69nyeW111/KvBu8qCJjEyFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153089; c=relaxed/simple;
	bh=fbfL0/v+7qo7mv0gnAbkrhwO7hs1XYVU8AzMNym0Q+g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANUmjdUQXNW6zSmlZL+krYfNNTDjxO7SFzBQZywjNeQynoaMkBXDblXFBG0EUiFpEaxtVitJsqk5X/eVQlBdrfvShsjEDczrStitAbK/c69CkHUIKOwvdWBYvFMO+funPFLZPAceVDu8/4XGj9DVMEreht1fNL3CPMeiYv7ko4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XmxJqTzF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1600420B6F01;
	Thu,  2 Apr 2026 11:04:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1600420B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775153088;
	bh=koAje62s1aMvLlYX/gsWrBuxFXQpxW1JvZVoIT+KzUw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XmxJqTzFAjBpThHRufsI+ftr5RzwYQeKJ2vkGlrVzADRgIOza9Qj2wrvzcDyMBfRV
	 TDHrVNh710hZwnPffwrVqsmJHDTIFuZk+/VvfDruVXA/yab8qg5Z9xqt8ZTBmmlWgQ
	 UpGixh4wbV68iRF1DDr7+d4ptgB37JzrFXZdGoeo=
Subject: [PATCH v2 7/7] mshv: Allocate pfns array only for pinned regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 18:04:47 +0000
Message-ID: 
 <177515308750.119822.16255136807813733055.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9927-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 5E1A538CDF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert pfns to a pointer allocated only for pinned regions that
actually need it for share/unshare/evict operations. Unpinned
regions use NULL since HMM handles their mappings dynamically.

The pfns array was previously a flexible array member, forcing
allocation for all regions regardless of memory type. This wastes
significant memory for unpinned HMM-managed regions which don't
need persistent PFN tracking - a 1GB region wastes 2MB for an
unused array.

This also allows using kzalloc for the main structure instead of
vzalloc, improving allocation efficiency and cache locality.

Simplify unpinned region invalidation by calling the hypervisor
directly rather than tracking PFNs. The tradeoff of skipping huge
page optimization is acceptable since invalidation ranges are
typically small and not performance-critical.

Add NULL checks where pfns array is required and update cleanup
to handle conditional allocation.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   61 ++++++++++++++++++++++++---------------------
 drivers/hv/mshv_root.h    |    6 +++-
 2 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 3c2a35f3bc31..cd28758ca494 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -243,7 +243,7 @@ struct mshv_region *mshv_region_create(enum mshv_region_type type,
 	int ret = 0;
 	u64 i;
 
-	region = vzalloc(sizeof(*region) + sizeof(unsigned long) * nr_pfns);
+	region = kzalloc_obj(*region);
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 
@@ -255,6 +255,13 @@ struct mshv_region *mshv_region_create(enum mshv_region_type type,
 						   &mshv_region_mni_ops);
 		break;
 	case MSHV_REGION_TYPE_MEM_PINNED:
+		region->mreg_pfns = vmalloc_array(nr_pfns, sizeof(unsigned long));
+		if (!region->mreg_pfns) {
+			ret = -ENOMEM;
+			break;
+		}
+		for (i = 0; i < nr_pfns; i++)
+			region->mreg_pfns[i] = MSHV_INVALID_PFN;
 		break;
 	case MSHV_REGION_TYPE_MMIO:
 		region->mreg_mmio_pfn = mmio_pfn;
@@ -276,16 +283,13 @@ struct mshv_region *mshv_region_create(enum mshv_region_type type,
 	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
 		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
 
-	for (i = 0; i < nr_pfns; i++)
-		region->mreg_pfns[i] = MSHV_INVALID_PFN;
-
 	mutex_init(&region->mreg_mutex);
 	kref_init(&region->mreg_refcount);
 
 	return region;
 
 free_region:
-	vfree(region);
+	kfree(region);
 	return ERR_PTR(ret);
 }
 
@@ -312,6 +316,9 @@ static int mshv_region_share(struct mshv_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
 
+	if (!region->mreg_pfns)
+		return -EINVAL;
+
 	return mshv_region_process_range(region, flags,
 					 0, region->nr_pfns,
 					 region->mreg_pfns,
@@ -340,6 +347,9 @@ static int mshv_region_unshare(struct mshv_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
 
+	if (!region->mreg_pfns)
+		return -EINVAL;
+
 	return mshv_region_process_range(region, flags,
 					 0, region->nr_pfns,
 					 region->mreg_pfns,
@@ -380,27 +390,19 @@ static int mshv_region_remap_pfns(struct mshv_region *region,
 					 mshv_region_chunk_remap);
 }
 
-static int mshv_region_map(struct mshv_region *region)
-{
-	u32 map_flags = region->hv_map_flags;
-
-	return mshv_region_remap_pfns(region, map_flags,
-				      0, region->nr_pfns,
-				      region->mreg_pfns);
-}
-
 static void mshv_region_invalidate_pfns(struct mshv_region *region,
 					u64 pfn_offset, u64 pfn_count)
 {
 	u64 i;
 
+	if (region->mreg_type != MSHV_REGION_TYPE_MEM_PINNED)
+		return;
+
 	for (i = pfn_offset; i < pfn_offset + pfn_count; i++) {
 		if (!pfn_valid(region->mreg_pfns[i]))
 			continue;
 
-		if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
-			unpin_user_page(pfn_to_page(region->mreg_pfns[i]));
-
+		unpin_user_page(pfn_to_page(region->mreg_pfns[i]));
 		region->mreg_pfns[i] = MSHV_INVALID_PFN;
 	}
 }
@@ -506,7 +508,9 @@ static void mshv_region_destroy(struct kref *ref)
 
 	mshv_region_invalidate(region);
 
-	vfree(region);
+	if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
+		vfree(region->mreg_pfns);
+	kfree(region);
 }
 
 void mshv_region_put(struct mshv_region *region)
@@ -616,10 +620,9 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_region *region,
  *   leaving missing pages as invalid PFN markers.
  *   Used for initial region setup.
  *
- * Collected PFNs are stored in region->mreg_pfns[] with HMM bookkeeping
- * flags cleared, then the range is mapped into the hypervisor. Present
- * PFNs get mapped with region access permissions; missing PFNs (zero
- * entries) get mapped with no-access permissions.
+ * HMM bookkeeping flags are stripped from collected PFNs before mapping.
+ * Present PFNs get mapped with region access permissions; missing PFNs
+ * (marked as MSHV_INVALID_PFN) get mapped with no-access permissions.
  *
  * Return: 0 on success, negative errno on failure.
  */
@@ -648,15 +651,17 @@ static int mshv_region_collect_and_map(struct mshv_region *region,
 		goto out;
 
 	for (i = 0; i < pfn_count; i++) {
-		if (!(pfns[i] & HMM_PFN_VALID))
+		if (!(pfns[i] & HMM_PFN_VALID)) {
+			pfns[i] = MSHV_INVALID_PFN;
 			continue;
+		}
 		/* Drop HMM_PFN_* flags to ensure PFNs are valid. */
-		region->mreg_pfns[pfn_offset + i] = pfns[i] & ~HMM_PFN_FLAGS;
+		pfns[i] &= ~HMM_PFN_FLAGS;
 	}
 
 	ret = mshv_region_remap_pfns(region, region->hv_map_flags,
 				     pfn_offset, pfn_count,
-				     region->mreg_pfns + pfn_offset);
+				     pfns);
 
 	mutex_unlock(&region->mreg_mutex);
 out:
@@ -770,8 +775,6 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	if (ret)
 		goto out_unlock;
 
-	mshv_region_invalidate_pfns(region, pfn_offset, pfn_count);
-
 	mutex_unlock(&region->mreg_mutex);
 
 	return true;
@@ -834,7 +837,9 @@ static int mshv_map_pinned_region(struct mshv_region *region)
 		}
 	}
 
-	ret = mshv_region_map(region);
+	ret = mshv_region_remap_pfns(region, region->hv_map_flags,
+				     0, region->nr_pfns,
+				     region->mreg_pfns);
 	if (!ret)
 		return 0;
 
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 97659ba55418..e43bdbf1ada8 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -92,8 +92,10 @@ struct mshv_region {
 	enum mshv_region_type mreg_type;
 	struct mmu_interval_notifier mreg_mni;
 	struct mutex mreg_mutex;	/* protects region PFNs remapping */
-	u64 mreg_mmio_pfn;
-	unsigned long mreg_pfns[];
+	union {
+		unsigned long *mreg_pfns;
+		u64 mreg_mmio_pfn;
+	};
 };
 
 struct mshv_irq_ack_notifier {



