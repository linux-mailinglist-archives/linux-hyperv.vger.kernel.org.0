Return-Path: <linux-hyperv+bounces-10101-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOzEHljF12nQSwgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10101-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 17:27:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE403CCA62
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 17:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11890302305C
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Apr 2026 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4F13DFC90;
	Thu,  9 Apr 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A2GJZEkp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD2C3DEFFF;
	Thu,  9 Apr 2026 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748280; cv=none; b=oJPUfvEDnx92sFkyrqkL8GlPI0hrrNpa3W3zvwL7PSsQtnSsD0oX7hJC9MPu2FS+Icrn3GlvrN7VaEjBe7hmlReggtWyT14PcF/0FvmoHMfa3E+vXqoPKphVDvgxPUc0pvHtAS5ABXvtyiXNpHjmfPBnzHXI5oQIVp6AbEtSYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748280; c=relaxed/simple;
	bh=QVUxfijeL8FLehUaoA9G0hPl8PMy40DhxGLM8pfrOfE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1Lij5rD8aU2U4gIC4Tp18NHfVsmi9VA+NCxb5n8nv+zD87S1mbLdUOApBruV2wVcQLWuIvClkMEbPMoHQh+yAH2OUk8211qdU4oqfQ3upRKIyUv8ZAtO36HFIyRM9r8YOS+EtKxu4a/XyYLPLeWVG30+Fg4J+FOZ3h/gnt7FE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A2GJZEkp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 04DE120B6F01;
	Thu,  9 Apr 2026 08:24:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04DE120B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775748279;
	bh=zgKfbDC25EvpiE6wKDlKslXzHxrnF7Td8Zl9bE4lV2o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=A2GJZEkp9VpRZA444+R9V6VGn9gQy6393gvuQhjhzDW3hYS5+r8RKOwwNwJ9+TbRV
	 9obfx2Or6v3CyJcR+7G6hkYqDtxTAe6kS0agHhEK8WacuRl4nZhAfLpJaEzgr/0tad
	 SkAd7sTLmZK4NQwhWEy8NtMkBuK/Q2/6iXuAOsD8=
Subject: [PATCH v3 7/7] mshv: Allocate pfns array only for pinned regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 09 Apr 2026 15:24:38 +0000
Message-ID: 
 <177574827878.19719.8848649672964196791.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177574802240.19719.4873018419452139691.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177574802240.19719.4873018419452139691.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10101-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDE403CCA62
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
index 5a1a06ee83d2..44eb6dfd7142 100644
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
@@ -517,7 +519,9 @@ static void mshv_region_destroy(struct kref *ref)
 
 	mshv_region_invalidate(region);
 
-	vfree(region);
+	if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
+		vfree(region->mreg_pfns);
+	kfree(region);
 }
 
 void mshv_region_put(struct mshv_region *region)
@@ -627,10 +631,9 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_region *region,
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
@@ -659,15 +662,17 @@ static int mshv_region_collect_and_map(struct mshv_region *region,
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
@@ -792,8 +797,6 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	if (ret)
 		goto out_unlock;
 
-	mshv_region_invalidate_pfns(region, pfn_offset, pfn_count);
-
 	mutex_unlock(&region->mreg_mutex);
 
 	return true;
@@ -856,7 +859,9 @@ static int mshv_map_pinned_region(struct mshv_region *region)
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



