Return-Path: <linux-hyperv+bounces-10856-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA6UEi/KBGp2OwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10856-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:59:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC3539724
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17DC031227DE
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10AF3A9D9F;
	Wed, 13 May 2026 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A0xbR8Gq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD63AE6E2;
	Wed, 13 May 2026 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698264; cv=none; b=kJoL5lq8Ukx3u+JQSzAa4qlnOQF8g3MC5c1LubGuMsyG8/gfIZkAWq1HCFxGaCjQ0jqiUjA+sFspFLfKvTc4pCrU/PVlQU6cASmeO4QdawxFBiajgA8I4SuTwtpDsu42yzlda58Q8wU93Dqsra33A+/0MJiwgjQG/2Pmpz80yWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698264; c=relaxed/simple;
	bh=qI+zjRWrS9PH2slHRJopkakAR1GfJ0MiYlSuNjzQ/Qw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNEs+4dw10dMn4Mkx2aVQiPbS5bnaU7VadqMhUxz41blxkBtIOgoJ2zkNtto38CYDUppDUJ82PaixGhRXwsY2BKJf8D6SmaHoUwfGuABVpNbitLayc5cZeT7V5uKwcTDiF9cRgb1qMsdk4XCycIK9+bOWgE4NKwxb86yMEEiBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A0xbR8Gq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0CE8B20B7167;
	Wed, 13 May 2026 11:51:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CE8B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698260;
	bh=YFwyJ1rlluTsU2S2QdyiXGQ/mYHPgczt2tbm1wLMenA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=A0xbR8GqUPwGZ9C5hZrLzMp7GQuW2tPh3khPvLlhGOo+8gvoT/iirIjBjUeGCNaHi
	 LDULz31cUUqNK4j0+E9Pq8NByZXZLosIGGz4zBg5hYkvYScDpUd1EEOzAx9L9KbOLr
	 +F9GfNIH7jXJAvPHeVjARE36U5BcyaGkhR1Xx9Po=
Subject: [PATCH v3 08/11] mshv: Move pinned region setup to mshv_regions.c
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:51:02 +0000
Message-ID: 
 <177869826266.18773.18137946316071055263.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FDC3539724
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10856-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Move mshv_prepare_pinned_region() from mshv_root_main.c to
mshv_regions.c and rename it to mshv_map_pinned_region(). This
co-locates the pinned region logic with the rest of the memory region
operations.

Make mshv_region_pin(), mshv_region_map(), mshv_region_share(),
mshv_region_unshare(), and mshv_region_invalidate() static, as they are
no longer called outside of mshv_regions.c.

No functional change.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c   |   83 ++++++++++++++++++++++++++++++++++++++++---
 drivers/hv/mshv_root.h      |    6 +--
 drivers/hv/mshv_root_main.c |   75 +--------------------------------------
 3 files changed, 80 insertions(+), 84 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 057fc83895d37..d9e33e9ef8550 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -240,7 +240,7 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
 					      flags, true);
 }
 
-int mshv_region_share(struct mshv_mem_region *region)
+static int mshv_region_share(struct mshv_mem_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
 
@@ -266,7 +266,7 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 					      flags, false);
 }
 
-int mshv_region_unshare(struct mshv_mem_region *region)
+static int mshv_region_unshare(struct mshv_mem_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
 
@@ -306,7 +306,7 @@ static int mshv_region_remap_pfns(struct mshv_mem_region *region,
 					 mshv_region_chunk_remap);
 }
 
-int mshv_region_map(struct mshv_mem_region *region)
+static int mshv_region_map(struct mshv_mem_region *region)
 {
 	u32 map_flags = region->hv_map_flags;
 
@@ -330,12 +330,12 @@ static void mshv_region_invalidate_pfns(struct mshv_mem_region *region,
 	mshv_region_init_pfns_range(region, pfn_offset, pfn_count);
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
@@ -691,3 +691,76 @@ bool mshv_region_movable_init(struct mshv_mem_region *region)
 
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
+			goto err_out;
+		}
+	}
+
+	ret = mshv_region_map(region);
+	if (ret)
+		goto share_region;
+
+	return 0;
+
+share_region:
+	if (mshv_partition_encrypted(partition)) {
+		int shrc;
+
+		shrc = mshv_region_share(region);
+		if (!shrc)
+			goto err_out;
+
+		pt_err(partition,
+		       "Failed to share memory region (guest_pfn: %llu): %d\n",
+		       region->start_gfn, shrc);
+		/*
+		 * Re-sharing failed — the pages remain inaccessible to the
+		 * host.  Zero the page array so that mshv_region_destroy()
+		 * won't attempt to unpin them (leaking the page references
+		 * is intentional; unpinning host-inaccessible pages would be
+		 * unsafe).
+		 */
+		mshv_region_init_pfns(region);
+		goto err_out;
+	}
+err_out:
+	return ret;
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 34c9b57c50f47..2a4eff27917f2 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -371,16 +371,12 @@ extern u8 * __percpu *hv_synic_eventring_tail;
 
 struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 					   u64 uaddr, u32 flags);
-int mshv_region_share(struct mshv_mem_region *region);
-int mshv_region_unshare(struct mshv_mem_region *region);
-int mshv_region_map(struct mshv_mem_region *region);
-void mshv_region_invalidate(struct mshv_mem_region *region);
 void mshv_region_init_pfns(struct mshv_mem_region *region);
-int mshv_region_pin(struct mshv_mem_region *region);
 void mshv_region_put(struct mshv_mem_region *region);
 int mshv_region_get(struct mshv_mem_region *region);
 bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
+int mshv_map_pinned_region(struct mshv_mem_region *region);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 986cb9a4c428e..4af2b98738ee2 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1346,79 +1346,6 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
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
-			goto err_out;
-		}
-	}
-
-	ret = mshv_region_map(region);
-	if (ret)
-		goto share_region;
-
-	return 0;
-
-share_region:
-	if (mshv_partition_encrypted(partition)) {
-		int shrc;
-
-		shrc = mshv_region_share(region);
-		if (!shrc)
-			goto err_out;
-
-		pt_err(partition,
-		       "Failed to share memory region (guest_pfn: %llu): %d\n",
-		       region->start_gfn, shrc);
-		/*
-		 * Re-sharing failed — the pages remain inaccessible to the
-		 * host.  Zero the page array so that mshv_region_destroy()
-		 * won't attempt to unpin them (leaking the page references
-		 * is intentional; unpinning host-inaccessible pages would be
-		 * unsafe).
-		 */
-		mshv_region_init_pfns(region);
-		goto err_out;
-	}
-err_out:
-	return ret;
-}
-
 /*
  * This maps two things: guest RAM and for pci passthru mmio space.
  *
@@ -1461,7 +1388,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 
 	switch (region->mreg_type) {
 	case MSHV_REGION_TYPE_MEM_PINNED:
-		ret = mshv_prepare_pinned_region(region);
+		ret = mshv_map_pinned_region(region);
 		break;
 	case MSHV_REGION_TYPE_MEM_MOVABLE:
 		/*



