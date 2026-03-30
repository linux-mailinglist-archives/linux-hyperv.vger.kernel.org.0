Return-Path: <linux-hyperv+bounces-9837-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EObPL2jYymmWAgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9837-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:09:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D832360D19
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCD803063A1B
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 20:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B8B395DB4;
	Mon, 30 Mar 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="STShVf81"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5F391E65;
	Mon, 30 Mar 2026 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901077; cv=none; b=E1l5L70J0sXEXCXWiBITMYe6HUDij9G22yLcuIoxgtRxxiCoW67B1dXDuIgxl1kzucyFc/K6d9iKOWGTJ6radVK/WuS2W0pBTSm6T4K7LdewXnW6wG/sxvNXeHFmdyFRKT4LPXT2VXQucA+FBh2hULL7oin8vAY+0TPADcjnXsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901077; c=relaxed/simple;
	bh=lyPo0yce3M5jhFVhgciLjV6VfgAI7nL1qylJJZ8glH4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZdSxR8mtbjKWRVHekx+9Kw4DzxXxJ7lg0WQ7IF5oCWe+sQz4WrcjNQQVBuNk7Y5UayB2pM4UTHRJFbnb5T2oU+Gzb0f4eUOti5wwOsXBKVcxkIy4E2rbnMZi+P6zbtcY+CIls3qBvFhk2NW2+Cz6zg/0tkPWrVigc5dNaamv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=STShVf81; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id C73EF20B6F08;
	Mon, 30 Mar 2026 13:04:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C73EF20B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774901075;
	bh=IXub7nFfNpUI5z8JNvwoBRdSeZzDGs6zuHzc7VWuBNg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=STShVf81hye1Gylx1FRhkhKbV27IpygGW7jaFkH0fF2Icb4UTWsz2szJMsue4I5fe
	 RUvmzKG9sup9quxqzu5c2inFKWCqF5Z/2TA4ijK2ozpczGbI+bgdoONmuhlGgQ1RCN
	 Ai7OZNDw21lEMoAM3Etx9vKNQuWwN9dPhERaOJN0=
Subject: [PATCH 4/7] mshv: Move pinned region setup to mshv_regions.c
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Mar 2026 20:04:35 +0000
Message-ID: 
 <177490107527.81669.7369876794303521630.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	TAGGED_FROM(0.00)[bounces-9837-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 1D832360D19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move mshv_prepare_pinned_region() from mshv_root_main.c to
mshv_regions.c and rename it to mshv_map_pinned_region(). This
co-locates the pinned region logic with the rest of the memory region
operations.

Make mshv_region_pin(), mshv_region_map(), mshv_region_share(),
mshv_region_unshare(), and mshv_region_invalidate() static, as they are
no longer called outside of mshv_regions.c.

Also fix a bug in the error handling where a mshv_region_map() failure
on a non-encrypted partition would be silently ignored, returning
success instead of propagating the error code.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c   |   79 ++++++++++++++++++++++++++++++++++++++++---
 drivers/hv/mshv_root.h      |    6 +--
 drivers/hv/mshv_root_main.c |   70 +-------------------------------------
 3 files changed, 76 insertions(+), 79 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 1bb1bfe177e2..133ec7771812 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -287,7 +287,7 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
 					      flags, true);
 }
 
-int mshv_region_share(struct mshv_mem_region *region)
+static int mshv_region_share(struct mshv_mem_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
 
@@ -313,7 +313,7 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 					      flags, false);
 }
 
-int mshv_region_unshare(struct mshv_mem_region *region)
+static int mshv_region_unshare(struct mshv_mem_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
 
@@ -353,7 +353,7 @@ static int mshv_region_remap_pfns(struct mshv_mem_region *region,
 					 mshv_region_chunk_remap);
 }
 
-int mshv_region_map(struct mshv_mem_region *region)
+static int mshv_region_map(struct mshv_mem_region *region)
 {
 	u32 map_flags = region->hv_map_flags;
 
@@ -377,12 +377,12 @@ static void mshv_region_invalidate_pfns(struct mshv_mem_region *region,
 	}
 }
 
-void mshv_region_invalidate(struct mshv_mem_region *region)
+static void mshv_region_invalidate(struct mshv_mem_region *region)
 {
 	mshv_region_invalidate_pfns(region, 0, region->nr_pfns);
 }
 
-int mshv_region_pin(struct mshv_mem_region *region)
+static int mshv_region_pin(struct mshv_mem_region *region)
 {
 	u64 done_count, nr_pfns, i;
 	unsigned long *pfns;
@@ -731,3 +731,72 @@ bool mshv_region_movable_init(struct mshv_mem_region *region)
 
 	return true;
 }
+
+/**
+ * mshv_map_pinned_region - Pin and map memory regions
+ * @region: Pointer to the memory region structure
+ *
+ * This function processes memory regions that are explicitly marked as pinned.
+ * Pinned regions are preallocated, mapped upfront, and do not rely on fault-based
+ * population. The function ensures the region is properly populated, handles
+ * encryption requirements for SNP partitions if applicable, maps the region,
+ * and performs necessary sharing or eviction operations based on the mapping
+ * result.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int mshv_map_pinned_region(struct mshv_mem_region *region)
+{
+	struct mshv_partition *partition = region->partition;
+	int ret;
+
+	ret = mshv_region_pin(region);
+	if (ret) {
+		pt_err(partition, "Failed to pin memory region: %d\n",
+		       ret);
+		goto err_out;
+	}
+
+	/*
+	 * For an SNP partition it is a requirement that for every memory region
+	 * that we are going to map for this partition we should make sure that
+	 * host access to that region is released. This is ensured by doing an
+	 * additional hypercall which will update the SLAT to release host
+	 * access to guest memory regions.
+	 */
+	if (mshv_partition_encrypted(partition)) {
+		ret = mshv_region_unshare(region);
+		if (ret) {
+			pt_err(partition,
+			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
+			       region->start_gfn, ret);
+			goto invalidate_region;
+		}
+	}
+
+	ret = mshv_region_map(region);
+	if (!ret)
+		return 0;
+
+	if (mshv_partition_encrypted(partition)) {
+		int shrc;
+
+		shrc = mshv_region_share(region);
+		if (!shrc)
+			goto invalidate_region;
+
+		pt_err(partition,
+		       "Failed to share memory region (guest_pfn: %llu): %d\n",
+		       region->start_gfn, shrc);
+		/*
+		 * Don't unpin if marking shared failed because pages are no
+		 * longer mapped in the host, ie root, anymore.
+		 */
+		goto err_out;
+	}
+
+invalidate_region:
+	mshv_region_invalidate(region);
+err_out:
+	return ret;
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index f1d4bee97a3f..d2e65a137bf4 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -368,15 +368,11 @@ extern u8 * __percpu *hv_synic_eventring_tail;
 
 struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 					   u64 uaddr, u32 flags);
-int mshv_region_share(struct mshv_mem_region *region);
-int mshv_region_unshare(struct mshv_mem_region *region);
-int mshv_region_map(struct mshv_mem_region *region);
-void mshv_region_invalidate(struct mshv_mem_region *region);
-int mshv_region_pin(struct mshv_mem_region *region);
 void mshv_region_put(struct mshv_mem_region *region);
 int mshv_region_get(struct mshv_mem_region *region);
 bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
+int mshv_map_pinned_region(struct mshv_mem_region *region);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 685e4b562186..c393b5144e0b 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1254,74 +1254,6 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 	return 0;
 }
 
-/**
- * mshv_prepare_pinned_region - Pin and map memory regions
- * @region: Pointer to the memory region structure
- *
- * This function processes memory regions that are explicitly marked as pinned.
- * Pinned regions are preallocated, mapped upfront, and do not rely on fault-based
- * population. The function ensures the region is properly populated, handles
- * encryption requirements for SNP partitions if applicable, maps the region,
- * and performs necessary sharing or eviction operations based on the mapping
- * result.
- *
- * Return: 0 on success, negative error code on failure.
- */
-static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
-{
-	struct mshv_partition *partition = region->partition;
-	int ret;
-
-	ret = mshv_region_pin(region);
-	if (ret) {
-		pt_err(partition, "Failed to pin memory region: %d\n",
-		       ret);
-		goto err_out;
-	}
-
-	/*
-	 * For an SNP partition it is a requirement that for every memory region
-	 * that we are going to map for this partition we should make sure that
-	 * host access to that region is released. This is ensured by doing an
-	 * additional hypercall which will update the SLAT to release host
-	 * access to guest memory regions.
-	 */
-	if (mshv_partition_encrypted(partition)) {
-		ret = mshv_region_unshare(region);
-		if (ret) {
-			pt_err(partition,
-			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
-			       region->start_gfn, ret);
-			goto invalidate_region;
-		}
-	}
-
-	ret = mshv_region_map(region);
-	if (ret && mshv_partition_encrypted(partition)) {
-		int shrc;
-
-		shrc = mshv_region_share(region);
-		if (!shrc)
-			goto invalidate_region;
-
-		pt_err(partition,
-		       "Failed to share memory region (guest_pfn: %llu): %d\n",
-		       region->start_gfn, shrc);
-		/*
-		 * Don't unpin if marking shared failed because pages are no
-		 * longer mapped in the host, ie root, anymore.
-		 */
-		goto err_out;
-	}
-
-	return 0;
-
-invalidate_region:
-	mshv_region_invalidate(region);
-err_out:
-	return ret;
-}
-
 /*
  * This maps two things: guest RAM and for pci passthru mmio space.
  *
@@ -1364,7 +1296,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 
 	switch (region->mreg_type) {
 	case MSHV_REGION_TYPE_MEM_PINNED:
-		ret = mshv_prepare_pinned_region(region);
+		ret = mshv_map_pinned_region(region);
 		break;
 	case MSHV_REGION_TYPE_MEM_MOVABLE:
 		/*



