Return-Path: <linux-hyperv+bounces-6573-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75050B2FE31
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Aug 2025 17:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7178E560373
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Aug 2025 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655D926E704;
	Thu, 21 Aug 2025 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a055MS+5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF74188CC9
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Aug 2025 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789436; cv=none; b=FaQtl0fd98L0k7vMQciYg4BWJZ1E3UPtyATEOlT+5YY+ikdmxxpo5XeCoPSUddVMM2GRaBSwoJjBtMkdIFFdJ4GtWaLYmtlKPnQGVqUIAVsvniFbZPXtg9+sQcws8SplCmwQcTg622KZggsyvF02KLDIj53lvPzyrNyL4pTl/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789436; c=relaxed/simple;
	bh=0SlTH8DzYKTd5bC9/K7EPoIykb1RZYTurVkLTi5AST0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eupwqcbrP2BR4trrsjajlp32HujqjT4s9PxvcP9f5BImFA2rY4eV5MEeexZg0pAiG2QFD8qyl/o4aPhITDDZa2GDzq4CkpBCllocXmLL+ZbxHgsQtEYsTZQwxdd3VSQSSQ3JRJQPano2V36hQxyJbwRbtqKLBs5mHUYQ2OqcwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a055MS+5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755789433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9MHI9cmaSGzsUAHu3JeD3WxOHSfcmFEXlgGpdm5OhPI=;
	b=a055MS+5zRMBrjouJbUoicIWbPaKy6A8wfnVtysy+I68oBe5617hirlbrTCVek3sAc2z/z
	tJu3lJORIG7CGbfSNnXDggRxdILaXx38bcEr7gbYNcRrxUe/vGo4RzVF/ZDftKqwdpxz7o
	GrDRTPjIuKbkhaA+QH2oNb7q2EB9Uy8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-wWaMV3iKNaaarbOPVHtjPg-1; Thu,
 21 Aug 2025 11:17:08 -0400
X-MC-Unique: wWaMV3iKNaaarbOPVHtjPg-1
X-Mimecast-MFC-AGG-ID: wWaMV3iKNaaarbOPVHtjPg_1755789426
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBC321800296;
	Thu, 21 Aug 2025 15:17:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.131])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19B00197768C;
	Thu, 21 Aug 2025 15:17:01 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-hyperv@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Li Tian <litian@redhat.com>,
	Philipp Rudo <prudo@redhat.com>
Subject: [PATCH v3] x86/hyperv: Fix kdump on Azure CVMs
Date: Thu, 21 Aug 2025 17:16:55 +0200
Message-ID: <20250821151655.3051386-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Azure CVM instance types featuring a paravisor hang upon kdump. The
investigation shows that makedumpfile causes a hang when it steps on a page
which was previously share with the host
(HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY). The new kernel has no
knowledge of these 'special' regions (which are Vmbus connection pages,
GPADL buffers, ...). There are several ways to approach the issue:
- Convey the knowledge about these regions to the new kernel somehow.
- Unshare these regions before accessing in the new kernel (it is unclear
if there's a way to query the status for a given GPA range).
- Unshare these regions before jumping to the new kernel (which this patch
implements).

To make the procedure as robust as possible, store PFN ranges of shared
regions in a linked list instead of storing GVAs and re-using
hv_vtom_set_host_visibility(). This also allows to avoid memory allocation
on the kdump/kexec path.

The patch skips implementing weird corner case in hv_list_enc_remove()
when a PFN in the middle of a region is unshared. First, it is unlikely
that such requests happen. Second, it is not a big problem if
hv_list_enc_remove() doesn't actually remove some regions as this will
only result in an extra hypercall doing nothing upon kexec/kdump; there's
no need to be perfect.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v2 [Michael Kelley]:
 - Rebase to hyperv-next.
 - Move hv_ivm_clear_host_access() call to hyperv_cleanup(). This also
   makes ARM stub unneeded.
 - Implement the missing corner case in hv_list_enc_remove(). With this,
   the math should (hopefully!) always be correct so we don't rely on
   the idempotency of HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY
   hypercall. As the case is not something we see, I tested the code
   with a few synthetic tests.
 - Fix the math in hv_list_enc_remove() (count -> ent->count).
 - Typos.
---
 arch/x86/hyperv/hv_init.c       |   3 +
 arch/x86/hyperv/ivm.c           | 213 ++++++++++++++++++++++++++++++--
 arch/x86/include/asm/mshyperv.h |   2 +
 3 files changed, 210 insertions(+), 8 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 2979d15223cf..4bb1578237eb 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -596,6 +596,9 @@ void hyperv_cleanup(void)
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	union hv_reference_tsc_msr tsc_msr;
 
+	/* Retract host access to shared memory in case of isolation */
+	hv_ivm_clear_host_access();
+
 	/* Reset our OS id */
 	wrmsrq(HV_X64_MSR_GUEST_OS_ID, 0);
 	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 3084ae8a3eed..0d74156ad6a7 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -462,6 +462,188 @@ void hv_ivm_msr_read(u64 msr, u64 *value)
 		hv_ghcb_msr_read(msr, value);
 }
 
+/*
+ * Keep track of the PFN regions which were shared with the host. The access
+ * must be revoked upon kexec/kdump (see hv_ivm_clear_host_access()).
+ */
+struct hv_enc_pfn_region {
+	struct list_head list;
+	u64 pfn;
+	int count;
+};
+
+static LIST_HEAD(hv_list_enc);
+static DEFINE_RAW_SPINLOCK(hv_list_enc_lock);
+
+static int hv_list_enc_add(const u64 *pfn_list, int count)
+{
+	struct hv_enc_pfn_region *ent;
+	unsigned long flags;
+	u64 pfn;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		pfn = pfn_list[i];
+
+		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
+		/* Check if the PFN already exists in some region first */
+		list_for_each_entry(ent, &hv_list_enc, list) {
+			if ((ent->pfn <= pfn) && (ent->pfn + ent->count - 1 >= pfn))
+				/* Nothing to do - pfn is already in the list */
+				goto unlock_done;
+		}
+
+		/*
+		 * Check if the PFN is adjacent to an existing region. Growing
+		 * a region can make it adjacent to another one but merging is
+		 * not (yet) implemented for simplicity. A PFN cannot be added
+		 * to two regions to keep the logic in hv_list_enc_remove()
+		 * correct.
+		 */
+		list_for_each_entry(ent, &hv_list_enc, list) {
+			if (ent->pfn + ent->count == pfn) {
+				/* Grow existing region up */
+				ent->count++;
+				goto unlock_done;
+			} else if (pfn + 1 == ent->pfn) {
+				/* Grow existing region down */
+				ent->pfn--;
+				ent->count++;
+				goto unlock_done;
+			}
+		}
+		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
+
+		/* No adjacent region found -- create a new one */
+		ent = kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
+		if (!ent)
+			return -ENOMEM;
+
+		ent->pfn = pfn;
+		ent->count = 1;
+
+		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
+		list_add(&ent->list, &hv_list_enc);
+
+unlock_done:
+		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
+	}
+
+	return 0;
+}
+
+static void hv_list_enc_remove(const u64 *pfn_list, int count)
+{
+	struct hv_enc_pfn_region *ent, *t;
+	struct hv_enc_pfn_region new_region;
+	unsigned long flags;
+	u64 pfn;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		pfn = pfn_list[i];
+
+		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
+		list_for_each_entry_safe(ent, t, &hv_list_enc, list) {
+			if (pfn == ent->pfn + ent->count - 1) {
+				/* Removing tail pfn */
+				ent->count--;
+				if (!ent->count) {
+					list_del(&ent->list);
+					kfree(ent);
+				}
+				goto unlock_done;
+			} else if (pfn == ent->pfn) {
+				/* Removing head pfn */
+				ent->count--;
+				ent->pfn++;
+				if (!ent->count) {
+					list_del(&ent->list);
+					kfree(ent);
+				}
+				goto unlock_done;
+			} else if (pfn > ent->pfn && pfn < ent->pfn + ent->count - 1) {
+				/*
+				 * Removing a pfn in the middle. Cut off the tail
+				 * of the existing region and create a template for
+				 * the new one.
+				 */
+				new_region.pfn = pfn + 1;
+				new_region.count = ent->count - (pfn - ent->pfn + 1);
+				ent->count = pfn - ent->pfn;
+				goto unlock_split;
+			}
+
+		}
+unlock_done:
+		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
+		continue;
+
+unlock_split:
+		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
+
+		ent = kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
+		/*
+		 * There is no apparent good way to recover from -ENOMEM
+		 * situation, the accouting is going to be wrong either way.
+		 * Proceed with the rest of the list to make it 'less wrong'.
+		 */
+		if (WARN_ON_ONCE(!ent))
+			continue;
+
+		ent->pfn = new_region.pfn;
+		ent->count = new_region.count;
+
+		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
+		list_add(&ent->list, &hv_list_enc);
+		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
+	}
+}
+
+void hv_ivm_clear_host_access(void)
+{
+	struct hv_gpa_range_for_visibility *input;
+	struct hv_enc_pfn_region *ent;
+	unsigned long flags;
+	u64 hv_status;
+	int batch_size, cur, i;
+
+	if (!hv_is_isolation_supported())
+		return;
+
+	raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
+
+	batch_size = MIN(hv_setup_in_array(&input, sizeof(*input),
+					   sizeof(input->gpa_page_list[0])),
+			 HV_MAX_MODIFY_GPA_REP_COUNT);
+	if (unlikely(!input))
+		goto unlock;
+
+	list_for_each_entry(ent, &hv_list_enc, list) {
+		for (i = 0, cur = 0; i < ent->count; i++) {
+			input->gpa_page_list[cur] = ent->pfn + i;
+			cur++;
+
+			if (cur == batch_size || i == ent->count - 1) {
+				input->partition_id = HV_PARTITION_ID_SELF;
+				input->host_visibility = VMBUS_PAGE_NOT_VISIBLE;
+				input->reserved0 = 0;
+				input->reserved1 = 0;
+				hv_status = hv_do_rep_hypercall(
+					HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY,
+					cur, 0, input, NULL);
+				WARN_ON_ONCE(!hv_result_success(hv_status));
+				cur = 0;
+			}
+		}
+
+	};
+
+unlock:
+	raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
+}
+EXPORT_SYMBOL_GPL(hv_ivm_clear_host_access);
+
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
  *
@@ -476,24 +658,33 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 	u64 hv_status;
 	int batch_size;
 	unsigned long flags;
+	int ret;
 
 	/* no-op if partition isolation is not enabled */
 	if (!hv_is_isolation_supported())
 		return 0;
 
+	if (visibility == VMBUS_PAGE_NOT_VISIBLE) {
+		hv_list_enc_remove(pfn, count);
+	} else {
+		ret = hv_list_enc_add(pfn, count);
+		if (ret)
+			return ret;
+	}
+
 	local_irq_save(flags);
 	batch_size = hv_setup_in_array(&input, sizeof(*input),
 					sizeof(input->gpa_page_list[0]));
 	if (unlikely(!input)) {
-		local_irq_restore(flags);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto unlock;
 	}
 
 	if (count > batch_size) {
 		pr_err("Hyper-V: GPA count:%d exceeds supported:%u\n", count,
 		       batch_size);
-		local_irq_restore(flags);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto unlock;
 	}
 
 	input->partition_id = HV_PARTITION_ID_SELF;
@@ -502,12 +693,18 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 	hv_status = hv_do_rep_hypercall(
 			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
 			0, input, NULL);
-	local_irq_restore(flags);
-
 	if (hv_result_success(hv_status))
-		return 0;
+		ret = 0;
 	else
-		return -EFAULT;
+		ret = -EFAULT;
+
+unlock:
+	local_irq_restore(flags);
+
+	if (ret)
+		hv_list_enc_remove(pfn, count);
+
+	return ret;
 }
 
 /*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index abc4659f5809..6a988001e46f 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -263,10 +263,12 @@ static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip,
 void hv_vtom_init(void);
 void hv_ivm_msr_write(u64 msr, u64 value);
 void hv_ivm_msr_read(u64 msr, u64 *value);
+void hv_ivm_clear_host_access(void);
 #else
 static inline void hv_vtom_init(void) {}
 static inline void hv_ivm_msr_write(u64 msr, u64 value) {}
 static inline void hv_ivm_msr_read(u64 msr, u64 *value) {}
+static inline void hv_ivm_clear_host_access(void) {}
 #endif
 
 static inline bool hv_is_synic_msr(unsigned int reg)
-- 
2.50.1


