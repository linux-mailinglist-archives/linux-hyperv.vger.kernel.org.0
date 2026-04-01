Return-Path: <linux-hyperv+bounces-9891-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMHLKK+azWkrfQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9891-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 00:22:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F23FD380E8A
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 00:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1C963033D24
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 22:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F532C316;
	Wed,  1 Apr 2026 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E9oVamny"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABF335DA5B;
	Wed,  1 Apr 2026 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081584; cv=none; b=HDOFPhRtg4VtmGKumnjK52dE9B9cedFfT0yXAn2kl15gBRLzhb36l2IkkwFMaHDEvXjeopui7IEHrGruq7PtvnvXuaTMMFcMke/n6snurUyE3Z9q/6ziD/GMFUTqHlHTK6uEoy0gzh6/QCJflB+8BgZxyUXFhNr2BkRuP5H3U5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081584; c=relaxed/simple;
	bh=MhHK0Qvjm3yTZy+VDWDKZiZELod5hFzSNwNwo4ThYC0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgD8peyupLKdEloJTmhEtc2+aArxTKRZCER/w6E0b2AJDaH+fl+LYCWIlP27Wy3YhFCM6/6vkE+sxYm8kNjTuWI8eIcpP2na+PDJ0df1vM/dS7JytisiWI/T88Q2JBipFNUVesdofa4FjY4afo94X3l+TaRtn6xmIMYbeQGUVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E9oVamny; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7193920B710C;
	Wed,  1 Apr 2026 15:13:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7193920B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775081583;
	bh=M+sXaCRj3rHUCpb535RsWEPZ9ckFUzWPDLWtLJNFCLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=E9oVamnyyABYwTYqSSb+FGXHcIuPjOXboRiwFFDgrodem6LXs1JHlnWBVPLyqCSNj
	 vJ6947j11nu07BADIbWfQTK41Nzc7KSTUlaS5OmSI8eNLrztdroNDBXBOksypNmKHX
	 qUPWQOv2HffpPioJKuzIVEdKseyJiLH7xH+caMF0=
Subject: [PATCH 7/7] mshv: Allocate pfns array only for pinned regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 01 Apr 2026 22:13:02 +0000
Message-ID: 
 <177508158289.215674.17408340412804558615.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9891-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F23FD380E8A
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
 drivers/hv/mshv_regions.c |   50 ++++++++++++++++++++++++++-------------------
 drivers/hv/mshv_root.h    |    6 ++++-
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 3c2a35f3bc31..e3a6ade4919e 100644
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
+		region->mreg_pfns = vzalloc(sizeof(unsigned long) * nr_pfns);
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
@@ -394,13 +404,11 @@ static void mshv_region_invalidate_pfns(struct mshv_region *region,
 {
 	u64 i;
 
-	for (i = pfn_offset; i < pfn_offset + pfn_count; i++) {
-		if (!pfn_valid(region->mreg_pfns[i]))
-			continue;
-
-		if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
-			unpin_user_page(pfn_to_page(region->mreg_pfns[i]));
+	if (region->mreg_type != MSHV_REGION_TYPE_MEM_PINNED)
+		return;
 
+	for (i = pfn_offset; i < pfn_offset + pfn_count; i++) {
+		unpin_user_page(pfn_to_page(region->mreg_pfns[i]));
 		region->mreg_pfns[i] = MSHV_INVALID_PFN;
 	}
 }
@@ -506,7 +514,8 @@ static void mshv_region_destroy(struct kref *ref)
 
 	mshv_region_invalidate(region);
 
-	vfree(region);
+	vfree(region->mreg_pfns);
+	kfree(region);
 }
 
 void mshv_region_put(struct mshv_region *region)
@@ -616,10 +625,9 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_region *region,
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
@@ -648,15 +656,17 @@ static int mshv_region_collect_and_map(struct mshv_region *region,
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
@@ -770,8 +780,6 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	if (ret)
 		goto out_unlock;
 
-	mshv_region_invalidate_pfns(region, pfn_offset, pfn_count);
-
 	mutex_unlock(&region->mreg_mutex);
 
 	return true;
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



