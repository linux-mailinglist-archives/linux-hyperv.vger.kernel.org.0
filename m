Return-Path: <linux-hyperv+bounces-9126-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JkUN4l3p2kchwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9126-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:06:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4DD1F8B01
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D3E2303D7C6
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 00:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E161624D5;
	Wed,  4 Mar 2026 00:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RMIagKsP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC138FA3;
	Wed,  4 Mar 2026 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582600; cv=none; b=XjiXvueZYzhaJHYcfwB7qt25YpQcFjURzpPXsErgYRM33QtNcso5/Je60WWF0vx9HQsxXi3lrcFHFOlKDweKCpR1WGTKimKmEH9Reag80IwdGSNm5pBuUblu+xUk/RDC2q36L1PF9hK7Yx4sTtkGICylw2cauugUuAcdcaYRWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582600; c=relaxed/simple;
	bh=6GaZuFhmftQHAUxdpC1gZIHlQULpClQG5SbDtHEGyFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTB29JkfF8jv1+fUJXMsTLXqulHSPqqKjE9UAXxgIqzTaNkZ6MArmR4cTyHrMgDoQ8hnrhrzoztjftG/sqPJv46MCnkWp6pey2EQvKTS30vlHimlK1UctokRzXGy3mYc9DtMIAIpaGuHAubLFIwzcLkN+w7eGQFP8BerATYqPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RMIagKsP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id F027620B6F03;
	Tue,  3 Mar 2026 16:03:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F027620B6F03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772582598;
	bh=ZopeEBedtQG63vsneWr7udCfjJmgOUVeAC4qQFoqiyw=;
	h=From:To:Cc:Subject:Date:From;
	b=RMIagKsPt/XSVkGgKnRSf37XAI2QFyUaiNQbvHexXg5hKCyLP0Y1pvm7KI58oAMR+
	 bq29zu0f+xOQGzHWSYcvyeayaqrUqA30yPOpy19E6mQCGUN3mMVPy9AKCUiRE5L+f7
	 bfRkqzEixn/Gc/CEpQxmsTuvdG/PAVqzBwlGtvxg=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wei.liu@kernel.org
Subject: [PATCH V0] mshv: pass struct mshv_user_mem_region by reference
Date: Tue,  3 Mar 2026 16:02:51 -0800
Message-ID: <20260304000251.2625375-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB4DD1F8B01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9126-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

For unstated reasons, function mshv_partition_ioctl_set_memory passes
struct mshv_user_mem_region by value instead of by reference. Change
it to pass by reference.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e6509c980763..87c5ffd2528d 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1289,7 +1289,7 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
  */
 static long
 mshv_map_user_memory(struct mshv_partition *partition,
-		     struct mshv_user_mem_region mem)
+		     struct mshv_user_mem_region *mem)
 {
 	struct mshv_mem_region *region;
 	struct vm_area_struct *vma;
@@ -1297,12 +1297,12 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	ulong mmio_pfn;
 	long ret;
 
-	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
-	    !access_ok((const void __user *)mem.userspace_addr, mem.size))
+	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
+	    !access_ok((const void __user *)mem->userspace_addr, mem->size))
 		return -EINVAL;
 
 	mmap_read_lock(current->mm);
-	vma = vma_lookup(current->mm, mem.userspace_addr);
+	vma = vma_lookup(current->mm, mem->userspace_addr);
 	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
 	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
 	mmap_read_unlock(current->mm);
@@ -1310,7 +1310,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	if (!vma)
 		return -EINVAL;
 
-	ret = mshv_partition_create_region(partition, &mem, &region,
+	ret = mshv_partition_create_region(partition, mem, &region,
 					   is_mmio);
 	if (ret)
 		return ret;
@@ -1355,25 +1355,25 @@ mshv_map_user_memory(struct mshv_partition *partition,
 /* Called for unmapping both the guest ram and the mmio space */
 static long
 mshv_unmap_user_memory(struct mshv_partition *partition,
-		       struct mshv_user_mem_region mem)
+		       struct mshv_user_mem_region *mem)
 {
 	struct mshv_mem_region *region;
 
-	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
+	if (!(mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
 		return -EINVAL;
 
 	spin_lock(&partition->pt_mem_regions_lock);
 
-	region = mshv_partition_region_by_gfn(partition, mem.guest_pfn);
+	region = mshv_partition_region_by_gfn(partition, mem->guest_pfn);
 	if (!region) {
 		spin_unlock(&partition->pt_mem_regions_lock);
 		return -ENOENT;
 	}
 
 	/* Paranoia check */
-	if (region->start_uaddr != mem.userspace_addr ||
-	    region->start_gfn != mem.guest_pfn ||
-	    region->nr_pages != HVPFN_DOWN(mem.size)) {
+	if (region->start_uaddr != mem->userspace_addr ||
+	    region->start_gfn != mem->guest_pfn ||
+	    region->nr_pages != HVPFN_DOWN(mem->size)) {
 		spin_unlock(&partition->pt_mem_regions_lock);
 		return -EINVAL;
 	}
@@ -1404,9 +1404,9 @@ mshv_partition_ioctl_set_memory(struct mshv_partition *partition,
 		return -EINVAL;
 
 	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
-		return mshv_unmap_user_memory(partition, mem);
+		return mshv_unmap_user_memory(partition, &mem);
 
-	return mshv_map_user_memory(partition, mem);
+	return mshv_map_user_memory(partition, &mem);
 }
 
 static long
-- 
2.51.2.vfs.0.1


