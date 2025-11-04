Return-Path: <linux-hyperv+bounces-7405-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85613C332F0
	for <lists+linux-hyperv@lfdr.de>; Tue, 04 Nov 2025 23:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3279B34B8E0
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Nov 2025 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF6B346FB7;
	Tue,  4 Nov 2025 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B6IG88M6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC0346FA7;
	Tue,  4 Nov 2025 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294739; cv=none; b=P7H3zz+qo+UZ390q0hzleRtI8AuSfPL0+94MmvM3Poc0Kkkepiz/6XSY+9I4pToFBGPu8luQqOcrqR6hRPclzKElEnC/1kCawyOEIAtT18WXQc7q80e+9hDD0hATOlehhShpyzbnoB3ZtEgCja4AWWXMbXWoLkty+XHrm7FbJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294739; c=relaxed/simple;
	bh=TXrX5oV8mPwToJOMuvNtkS/D7kHlFn6sd2060dwajh0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=igxUVR4IYeoRRaysJm43CHEh8/wjrUWGSDGi+OMeltHCRtc5jgcFtyQ039+egx6jrBs3W+Vq31HDg7L7VD0uBaf+VgIdInE59veo3n1Q/EC65zLfQUUJB9TpxI6savQRX34FxnrgTspSPKSWdfjIWj17ES7BEXyYqqC1SrjdL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B6IG88M6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 61D8320120AF; Tue,  4 Nov 2025 14:18:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61D8320120AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762294737;
	bh=6unYkmbeitl40gBGHjkXLZR6PtjbQ2f/EzU5hFhbB9I=;
	h=From:To:Cc:Subject:Date:From;
	b=B6IG88M6t2lmJ3qDk1gpWZbbk8QQHZmNviruun3woNR+JXNO2J+8GQUMwpeIFL0/E
	 Dbsbmjoc+rszR6ueqIwH9pe/dMNT6htnM7HZFPzmYQ57mZzj+sHeFV3e7iCkh5u0qM
	 Gbsf2mJslG5MIgxPVvAP9jvqMyjzuCa23xOGuseE=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	magnuskulke@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	muislam@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH] mshv: Allow mappings that overlap in uaddr
Date: Tue,  4 Nov 2025 14:18:48 -0800
Message-Id: <1762294728-21721-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Currently the MSHV driver rejects mappings that would overlap in
userspace.

Some VMMs require the same memory to be mapped to different parts of
the guest's address space, and so working around this restriction is
difficult.

The hypervisor itself doesn't prohibit mappings that overlap in uaddr,
(really in SPA: system physical addresses), so supporting this in the
driver doesn't require any extra work, only the checks need to be
removed.

Since no userspace code up until has been able to overlap regions in
userspace, relaxing this constraint can't break any existing code.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 19 +------------------
 include/uapi/linux/mshv.h   |  2 +-
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 814465a0912d..e5da5f2ab6f7 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1206,21 +1206,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 	return NULL;
 }
 
-static struct mshv_mem_region *
-mshv_partition_region_by_uaddr(struct mshv_partition *partition, u64 uaddr)
-{
-	struct mshv_mem_region *region;
-
-	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
-		if (uaddr >= region->start_uaddr &&
-		    uaddr < region->start_uaddr +
-			    (region->nr_pages << HV_HYP_PAGE_SHIFT))
-			return region;
-	}
-
-	return NULL;
-}
-
 /*
  * NB: caller checks and makes sure mem->size is page aligned
  * Returns: 0 with regionpp updated on success, or -errno
@@ -1235,9 +1220,7 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 
 	/* Reject overlapping regions */
 	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
-	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1) ||
-	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr) ||
-	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr + mem->size - 1))
+	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1))
 		return -EEXIST;
 
 	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 9091946cba23..b10c8d1cb2ad 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -123,7 +123,7 @@ enum {
  * @rsvd: MBZ
  *
  * Map or unmap a region of userspace memory to Guest Physical Addresses (GPA).
- * Mappings can't overlap in GPA space or userspace.
+ * Mappings can't overlap in GPA space.
  * To unmap, these fields must match an existing mapping.
  */
 struct mshv_user_mem_region {
-- 
2.34.1


