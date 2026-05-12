Return-Path: <linux-hyperv+bounces-10782-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAQOGcCKAmq1uAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10782-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:04:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF5A5189E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7570B3054CF1
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062982D7DEA;
	Tue, 12 May 2026 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mc601FcS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669322DB795;
	Tue, 12 May 2026 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551419; cv=none; b=W699MS3b1UA15j1SQIAsl398gnEYFfXZX1e/ocqfIyWaHKPJ9IqRP4Hln17zp2uP9wT3qAq1puO/CfUR8uYLAELNSoAUvFHcthjYyKQqvXelVxepK+OvKROWvtLK4tSKKFRcdl8l+JQBtKw+fo72vZ5gvq9IitScOIlt53W17QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551419; c=relaxed/simple;
	bh=3TNU4EMnv17LluIqrnkhvD8xOvL+YdsPt3gnwRHpmUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgbAEBZIa0YSg4kwr/dKxgYS7YTx6/qpaqsThf744eknX8Dn1IbEwzg+L2+eTi4yO74YrwoWBG+nyt076hhvGJ/FLoqFdm0d4Qy8Mx0foWbpOpBW4w13OsZYwa+P3OiLGOIMHP3f2wVt9PtIggeCz9BeK5ssaNeKNG5xxXhMKyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mc601FcS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0527B20B7169;
	Mon, 11 May 2026 19:03:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0527B20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778551414;
	bh=84awl3Z2Kbawc6FZaMJAbg5OX/GvsOXiTuFqfIzdbWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mc601FcSJKcnbNuX0XLhOmQd4Fa+Tr8yZhF7P3o+j5+mHcR/i8/ixj1ybfZQ+XpEY
	 Jvr9POXq0IXP0ILrOGIEpHYLFMV8y+csHK6LaKjv0oZLVDRDc7ihNPa6GWhILMevZV
	 3pu6UfZOr2UYm099DMv4cqk1kdIbpuOToSXino0Y=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: [PATCH V3 10/11] mshv: Populate mmio mappings for PCI passthru
Date: Mon, 11 May 2026 19:02:58 -0700
Message-ID: <20260512020259.1678627-11-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEF5A5189E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10782-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

Upon guest access, in case of missing mmio mapping, the hypervisor
generates an unmapped gpa intercept. In this path, lookup the PCI
resource pfn for the guest gpa, and ask the hypervisor to map it
via hypercall. The PCI resource pfn is maintained by the VFIO driver,
and obtained via fixup_user_fault call (similar to KVM).

Also, VFIO no longer puts the mmio pfn in vma->vm_pgoff. So, remove
code that is using it to map mmio space. It is broken and will cause
panic.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 113 ++++++++++++++++++++++++++++++------
 1 file changed, 96 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 6ceb5f608589..a7864463961b 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -46,6 +46,9 @@ MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
 #define HV_VP_COUNTER_ROOT_DISPATCH_THREAD_BLOCKED 95
 #endif
 
+static bool hv_nofull_mmio;	/* don't map entire mmio region upon fault */
+module_param(hv_nofull_mmio, bool, 0644);
+
 struct mshv_root mshv_root;
 
 enum hv_scheduler_type hv_scheduler_type;
@@ -641,6 +644,94 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 	return region;
 }
 
+/*
+ * Check if uaddr is for mmio range. If yes, return 0 with mmio_pfn filled in
+ * else just return -errno.
+ */
+static int mshv_chk_get_mmio_start_pfn(u64 uaddr, u64 *mmio_pfnp)
+{
+	struct vm_area_struct *vma;
+	bool is_mmio;
+	struct follow_pfnmap_args pfnmap_args;
+	int rc = -EINVAL;
+
+	mmap_read_lock(current->mm);
+	vma = vma_lookup(current->mm, uaddr);
+	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
+	if (!is_mmio)
+		goto unlock_mmap_out;
+
+	pfnmap_args.vma = vma;
+	pfnmap_args.address = uaddr;
+
+	rc = follow_pfnmap_start(&pfnmap_args);
+	if (rc) {
+		rc = fixup_user_fault(current->mm, uaddr, FAULT_FLAG_WRITE,
+				      NULL);
+		if (rc)
+			goto unlock_mmap_out;
+
+		rc = follow_pfnmap_start(&pfnmap_args);
+		if (rc)
+			goto unlock_mmap_out;
+	}
+
+	*mmio_pfnp = pfnmap_args.pfn;
+	follow_pfnmap_end(&pfnmap_args);
+
+unlock_mmap_out:
+	mmap_read_unlock(current->mm);
+	return rc;
+}
+
+/*
+ * Check if the unmapped gpa belongs to mmio space. If yes, resolve it.
+ *
+ * Returns: True if valid mmio intercept and handled, else false.
+ */
+static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp)
+{
+	struct hv_message *hvmsg = vp->vp_intercept_msg_page;
+	u64 gfn, uaddr, mmio_spa, numpgs;
+	struct mshv_mem_region *rg;
+	int rc = -EINVAL;
+	struct mshv_partition *pt = vp->vp_partition;
+#if defined(CONFIG_X86_64)
+	struct hv_x64_memory_intercept_message *msg =
+		(struct hv_x64_memory_intercept_message *)hvmsg->u.payload;
+#elif defined(CONFIG_ARM64)
+	struct hv_arm64_memory_intercept_message *msg =
+		(struct hv_arm64_memory_intercept_message *)hvmsg->u.payload;
+#endif
+
+	gfn = msg->guest_physical_address >> HV_HYP_PAGE_SHIFT;
+
+	rg = mshv_partition_region_by_gfn_get(pt, gfn);
+	if (rg == NULL)
+		return false;
+	if (rg->mreg_type != MSHV_REGION_TYPE_MMIO)
+		goto put_rg_out;
+
+	uaddr = rg->start_uaddr + ((gfn - rg->start_gfn) << HV_HYP_PAGE_SHIFT);
+
+	rc = mshv_chk_get_mmio_start_pfn(uaddr, &mmio_spa);
+	if (rc)
+		goto put_rg_out;
+
+	if (!hv_nofull_mmio) {		/* default case */
+		mmio_spa = mmio_spa - (gfn - rg->start_gfn);
+		gfn = rg->start_gfn;
+		numpgs = rg->nr_pages;
+	} else
+		numpgs = 1;
+
+	rc = hv_call_map_mmio_pages(pt->pt_id, gfn, mmio_spa, numpgs);
+
+put_rg_out:
+	mshv_region_put(rg);
+	return rc == 0;
+}
+
 /**
  * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) intercepts.
  * @vp: Pointer to the virtual processor structure.
@@ -699,6 +790,8 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
 {
 	switch (vp->vp_intercept_msg_page->header.message_type) {
+	case HVMSG_UNMAPPED_GPA:
+		return mshv_handle_unmapped_gpa(vp);
 	case HVMSG_GPA_INTERCEPT:
 		return mshv_handle_gpa_intercept(vp);
 	}
@@ -1322,16 +1415,8 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 }
 
 /*
- * This maps two things: guest RAM and for pci passthru mmio space.
- *
- * mmio:
- *  - vfio overloads vm_pgoff to store the mmio start pfn/spa.
- *  - Two things need to happen for mapping mmio range:
- *	1. mapped in the uaddr so VMM can access it.
- *	2. mapped in the hwpt (gfn <-> mmio phys addr) so guest can access it.
- *
- *   This function takes care of the second. The first one is managed by vfio,
- *   and hence is taken care of via vfio_pci_mmap_fault().
+ * This is called for both user ram and mmio space. The mmio space is not
+ * mapped here, but later during intercept on demand.
  */
 static long
 mshv_map_user_memory(struct mshv_partition *partition,
@@ -1340,7 +1425,6 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	struct mshv_mem_region *region;
 	struct vm_area_struct *vma;
 	bool is_mmio;
-	ulong mmio_pfn;
 	long ret;
 
 	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
@@ -1350,7 +1434,6 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	mmap_read_lock(current->mm);
 	vma = vma_lookup(current->mm, mem->userspace_addr);
 	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
-	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
 	mmap_read_unlock(current->mm);
 
 	if (!vma)
@@ -1376,11 +1459,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 					    region->nr_pages,
 					    HV_MAP_GPA_NO_ACCESS, NULL);
 		break;
-	case MSHV_REGION_TYPE_MMIO:
-		ret = hv_call_map_mmio_pages(partition->pt_id,
-					     region->start_gfn,
-					     mmio_pfn,
-					     region->nr_pages);
+	default:
 		break;
 	}
 
-- 
2.51.2.vfs.0.1


