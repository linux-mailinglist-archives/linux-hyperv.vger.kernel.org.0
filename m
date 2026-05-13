Return-Path: <linux-hyperv+bounces-10866-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DWaNtrLBGrMPAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10866-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:07:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D761D539953
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB258307CBF7
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B1E3B4EA7;
	Wed, 13 May 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Qj+OZLn7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4703AEB2D;
	Wed, 13 May 2026 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698511; cv=none; b=Z7mtIx0Oy/hiUAivov8RtaaWUGjR57Hucgngcwxm3h9j0wf9TtZVOU06S/nHhUO0g/ErkdHo303lNeyhHZPa373JxzrhaNziQLIHFNOoz/FOpJf1xSzuXQWpPA07OFf4a0MW6oCa69Mse4btmcEipuDoJkQtIRORAUB01Vpk4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698511; c=relaxed/simple;
	bh=6pte7KmgCrH2iOaG2CTCiWfcZdKewE+nR0allBerIaw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RogpoucvKkO0RKlLu3zD2Ee7Ha92//hFEfyO+9iSSYxrggB7ePC/tluJd7q1O0nxUXmzwZ+Ty5C4pBK/E+Ea+PBNhK3Mjro7fJ3NSPQRRwfeFmFLKL5IvhYwJ1s4Z8DEwHLCj2uwfJspygdkkmCSBdbIT/Wu73h4uiwwzsc8PB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Qj+OZLn7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id E60D820B7166;
	Wed, 13 May 2026 11:55:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E60D820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698505;
	bh=ub5RyE39AoYSdNY2B0DuEuBosvS0LlV4CMQwVjOaSi0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Qj+OZLn7gowIeKRdER9rjsWCgnD5jxGrYqvOVUPHaMIWs5LAwfN/BAkKhSA3RDvNA
	 tZNbcvcWSoIvoHNn+jsuoFDsqDaHA3h3KUuKCswpbH7ncTkq9XotxcmXzzd4ESbKbc
	 YX1jrkCcB1tBUgi6ip6/MuevY9FLoGKa1wevT8hA=
Subject: [PATCH v4 6/6] mshv: Allocate pfns array only for pinned regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:55:08 +0000
Message-ID: 
 <177869850857.19379.6952927255690476277.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177869833161.19379.1357399549586915698.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177869833161.19379.1357399549586915698.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D761D539953
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10866-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

The per-region pfns array is only used by pinned regions, where it records
the host PFNs returned by pin_user_pages() so they can later be unpinned,
shared, and unshared. Movable regions get their PFNs from HMM on every
fault, and MMIO regions need only a single base PFN. Keeping a 2 MiB-per-1
GiB flexible array around for region types that never read it is pure
overhead.

Convert mreg_pfns to a pointer and allocate it (via vmalloc_array, since it
can be large) only for MSHV_REGION_TYPE_MEM_PINNED. Place it in a union
with mreg_mmio_pfn so MMIO regions reuse the storage for the device base
PFN. Movable regions leave the pointer NULL.

With the flexible array gone, the struct itself becomes fixed-size and the
main allocation can move from vzalloc() to kzalloc().

Gate every mreg_pfns access on mreg_type == MSHV_REGION_TYPE_MEM_PINNED:
share/unshare/invalidate_pfns short-circuit for other types, and the
destructor frees the array only for pinned regions. A NULL check would not
be safe here because the union also stores MMIO regions' mmio_pfn, which is
typically non-zero.

The movable-region fault path no longer copies HMM-collected PFNs into
mreg_pfns; instead it post-processes the temporary HMM array in place
(stamping skipped slots with MSHV_INVALID_PFN) and hands it directly to the
remap helper. Movable regions are now stateless from the kernel's point of
view; the hypervisor's SLAT is the source of truth.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |   77 +++++++++++++++++++++++----------------------
 drivers/hv/mshv_root.h    |    7 ++--
 2 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index e20db61e9829f..a4bfec9279ede 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -42,8 +42,8 @@ static inline bool mshv_pfn_valid(unsigned long pfn)
 	return pfn != MSHV_INVALID_PFN;
 }
 
-static void mshv_region_init_pfns_range(struct mshv_region *region,
-					u64 pfn_offset, u64 pfn_count)
+static void mshv_region_init_pfns(struct mshv_region *region,
+				  u64 pfn_offset, u64 pfn_count)
 {
 	u64 i;
 
@@ -51,11 +51,6 @@ static void mshv_region_init_pfns_range(struct mshv_region *region,
 		region->mreg_pfns[i] = MSHV_INVALID_PFN;
 }
 
-void mshv_region_init_pfns(struct mshv_region *region)
-{
-	mshv_region_init_pfns_range(region, 0, region->nr_pfns);
-}
-
 /**
  * mshv_chunk_stride - Compute stride for mapping guest memory
  * @pfn      : The PFN to check for huge page backing
@@ -220,7 +215,7 @@ struct mshv_region *mshv_region_create(struct mshv_partition *partition,
 	struct mshv_region *region;
 	int ret = 0;
 
-	region = vzalloc(struct_size(region, mreg_pfns, nr_pfns));
+	region = kzalloc_obj(struct mshv_region);
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 
@@ -235,8 +230,6 @@ struct mshv_region *mshv_region_create(struct mshv_partition *partition,
 	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
 		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
 
-	mshv_region_init_pfns(region);
-
 	mutex_init(&region->mreg_mutex);
 	kref_init(&region->mreg_refcount);
 
@@ -248,6 +241,12 @@ struct mshv_region *mshv_region_create(struct mshv_partition *partition,
 						   &mshv_region_mni_ops);
 		break;
 	case MSHV_REGION_TYPE_MEM_PINNED:
+		region->mreg_pfns = vmalloc_array(nr_pfns, sizeof(unsigned long));
+		if (!region->mreg_pfns) {
+			ret = -ENOMEM;
+			break;
+		}
+		mshv_region_init_pfns(region, 0, region->nr_pfns);
 		break;
 	case MSHV_REGION_TYPE_MMIO:
 		region->mreg_mmio_pfn = mmio_pfn;
@@ -262,7 +261,7 @@ struct mshv_region *mshv_region_create(struct mshv_partition *partition,
 	return region;
 
 free_region:
-	vfree(region);
+	kfree(region);
 	return ERR_PTR(ret);
 }
 
@@ -289,6 +288,9 @@ static int mshv_region_share(struct mshv_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
 
+	if (region->mreg_type != MSHV_REGION_TYPE_MEM_PINNED)
+		return -EINVAL;
+
 	return mshv_region_process_range(region, flags,
 					 0, region->nr_pfns,
 					 region->mreg_pfns,
@@ -317,6 +319,9 @@ static int mshv_region_unshare(struct mshv_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
 
+	if (region->mreg_type != MSHV_REGION_TYPE_MEM_PINNED)
+		return -EINVAL;
+
 	return mshv_region_process_range(region, flags,
 					 0, region->nr_pfns,
 					 region->mreg_pfns,
@@ -357,29 +362,20 @@ static int mshv_region_remap_pfns(struct mshv_region *region,
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
 
-	for (i = pfn_offset; i < pfn_offset + pfn_count; i++) {
-		if (!mshv_pfn_valid(region->mreg_pfns[i]))
-			continue;
+	if (region->mreg_type != MSHV_REGION_TYPE_MEM_PINNED)
+		return;
 
-		if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
+	for (i = pfn_offset; i < pfn_offset + pfn_count; i++) {
+		if (mshv_pfn_valid(region->mreg_pfns[i]))
 			unpin_user_page(pfn_to_page(region->mreg_pfns[i]));
 	}
 
-	mshv_region_init_pfns_range(region, pfn_offset, pfn_count);
+	mshv_region_init_pfns(region, pfn_offset, pfn_count);
 }
 
 static void mshv_region_invalidate(struct mshv_region *region)
@@ -516,7 +512,9 @@ static void mshv_region_destroy(struct kref *ref)
 
 	mshv_region_invalidate(region);
 
-	vfree(region);
+	if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
+		vfree(region->mreg_pfns);
+	kfree(region);
 }
 
 void mshv_region_put(struct mshv_region *region)
@@ -634,10 +632,9 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_region *region,
  *   leaving missing pages as invalid PFN markers.
  *   Used for initial region setup.
  *
- * Collected PFNs are stored in region->mreg_pfns[] with HMM bookkeeping
- * flags cleared, then the range is mapped into the hypervisor. Present
- * PFNs get mapped with region access permissions; missing PFNs (invalid
- * entries) get mapped with no-access permissions.
+ * HMM bookkeeping flags are stripped from collected PFNs before mapping.
+ * Present PFNs get mapped with region access permissions; missing PFNs
+ * (marked as MSHV_INVALID_PFN) get mapped with no-access permissions.
  *
  * Return: 0 on success, negative errno on failure.
  */
@@ -666,20 +663,24 @@ static int mshv_region_collect_and_map(struct mshv_region *region,
 		goto out;
 
 	for (i = 0; i < pfn_count; i++) {
-		if (!(pfns[i] & HMM_PFN_VALID))
+		if (!(pfns[i] & HMM_PFN_VALID)) {
+			pfns[i] = MSHV_INVALID_PFN;
 			continue;
+		}
 		/* Skip read-only pages to avoid bypassing COW */
 		if (!do_fault &&
 		    (region->hv_map_flags & HV_MAP_GPA_WRITABLE) &&
-		    !(pfns[i] & HMM_PFN_WRITE))
+		    !(pfns[i] & HMM_PFN_WRITE)) {
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
@@ -781,8 +782,6 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	if (ret)
 		goto out_unlock;
 
-	mshv_region_invalidate_pfns(region, pfn_offset, pfn_count);
-
 	mutex_unlock(&region->mreg_mutex);
 
 	return true;
@@ -845,7 +844,9 @@ static int mshv_map_pinned_region(struct mshv_region *region)
 		}
 	}
 
-	ret = mshv_region_map(region);
+	ret = mshv_region_remap_pfns(region, region->hv_map_flags,
+				     0, region->nr_pfns,
+				     region->mreg_pfns);
 	if (ret)
 		goto share_region;
 
@@ -869,7 +870,7 @@ static int mshv_map_pinned_region(struct mshv_region *region)
 		 * is intentional; unpinning host-inaccessible pages would be
 		 * unsafe).
 		 */
-		mshv_region_init_pfns(region);
+		mshv_region_init_pfns(region, 0, region->nr_pfns);
 		goto err_out;
 	}
 err_out:
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index e9bd18013b486..d79dfaac88af9 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -93,8 +93,10 @@ struct mshv_region {
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
@@ -375,7 +377,6 @@ struct mshv_region *mshv_region_create(struct mshv_partition *partition,
 				       u64 guest_pfn, u64 nr_pfns,
 				       u64 uaddr, u32 flags,
 				       unsigned long mmio_pfn);
-void mshv_region_init_pfns(struct mshv_region *region);
 void mshv_region_put(struct mshv_region *region);
 int mshv_region_get(struct mshv_region *region);
 bool mshv_region_handle_gfn_fault(struct mshv_region *region, u64 gfn);



