Return-Path: <linux-hyperv+bounces-6540-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DF6B280BA
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Aug 2025 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F69817D1EB
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Aug 2025 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962242FE565;
	Fri, 15 Aug 2025 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLMNHDfj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E422FB98C
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Aug 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265059; cv=none; b=SBB7L55pCemawVpucnI9M4V3YPiMNGkLdHAz7ArHYFcGOu5RwybAyRR7pi7EmBGunNxryQ53M8BgZmMcS90O6LA+qQBWaz1WXyOYJGoDbOq1fHRiTS4Js8OyMmcdpECGgmyge9nH2a9A7D/OwBVsmnupPdd51rtyJCe8PdhCkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265059; c=relaxed/simple;
	bh=EkukpV3FFtELRil9qkr6l2IlP8xkLNYzLp7/fC83roE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=REIuhutCFShbsEW13L8gR3CxgoH8dO7Ngo0qwrW0GtqVlCeqhnInfR2CElGPw3Vv6Yem89laeNj6spp7tWlemc8FMh7xWZ0r+ORCkDz+1P5j+rUPdfdaRNGgbPqUaVu6nf8a4Z9QVWSfpkVVw5blugcyKM0bNlhyBSi3qrSuLmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLMNHDfj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755265056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HAr1AlxPa2PLnBvFUB2yr2b+jA2FCI9CNGMzin6U/SU=;
	b=MLMNHDfj8/dDOL6nETJkB6VgEEletvSv7NFXtmOSE/pXBGjVsSJFtSXDuugFZt4Ha8YszR
	GG04zWktXrJrTO+Zr7zbmV7Wd7n3fK+XR8UyUbh2ihZb4GsSAz6Y+cxCQvkP9qqrvi8W+m
	HFq8VJqwnhCl2QP2rkzRWtErijFtLkg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-mYOouCPNMmae2ZzeMIP0fg-1; Fri,
 15 Aug 2025 09:37:32 -0400
X-MC-Unique: mYOouCPNMmae2ZzeMIP0fg-1
X-Mimecast-MFC-AGG-ID: mYOouCPNMmae2ZzeMIP0fg_1755265051
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E000A1954194;
	Fri, 15 Aug 2025 13:37:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.222])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DC2919327C0;
	Fri, 15 Aug 2025 13:37:26 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-hyperv@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Li Tian <litian@redhat.com>,
	Philipp Rudo <prudo@redhat.com>
Subject: [PATCH] x86/hyperv: Fix kdump on Azure CVMs
Date: Fri, 15 Aug 2025 15:37:25 +0200
Message-ID: <20250815133725.1591863-1-vkuznets@redhat.com>
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
 arch/x86/hyperv/ivm.c           | 153 ++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h |   2 +
 drivers/hv/vmbus_drv.c          |   2 +
 3 files changed, 157 insertions(+)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index ade6c665c97e..a6e614672836 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -462,6 +462,150 @@ void hv_ivm_msr_read(u64 msr, u64 *value)
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
+	bool found = false;
+	u64 pfn;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		pfn = pfn_list[i];
+
+		found = false;
+		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
+		list_for_each_entry(ent, &hv_list_enc, list) {
+			if ((ent->pfn <= pfn) && (ent->pfn + ent->count - 1 >= pfn)) {
+				/* Nothin to do - pfn is already in the list */
+				found = true;
+			} else if (ent->pfn + ent->count == pfn) {
+				/* Grow existing region up */
+				found = true;
+				ent->count++;
+			} else if (pfn + 1 == ent->pfn) {
+				/* Grow existing region down */
+				found = true;
+				ent->pfn--;
+				ent->count++;
+			}
+		};
+		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
+
+		if (found)
+			continue;
+
+		/* No adajacent region found -- creating a new one */
+		ent = kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
+		if (!ent)
+			return -ENOMEM;
+
+		ent->pfn = pfn;
+		ent->count = 1;
+
+		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
+		list_add(&ent->list, &hv_list_enc);
+		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
+	}
+
+	return 0;
+}
+
+static void hv_list_enc_remove(const u64 *pfn_list, int count)
+{
+	struct hv_enc_pfn_region *ent, *t;
+	unsigned long flags;
+	u64 pfn;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		pfn = pfn_list[i];
+
+		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
+		list_for_each_entry_safe(ent, t, &hv_list_enc, list) {
+			if (pfn == ent->pfn + count - 1) {
+				/* Removing tail pfn */
+				ent->count--;
+				if (!ent->count) {
+					list_del(&ent->list);
+					kfree(ent);
+				}
+			} else if (pfn == ent->pfn) {
+				/* Removing head pfn */
+				ent->count--;
+				ent->pfn++;
+				if (!ent->count) {
+					list_del(&ent->list);
+					kfree(ent);
+				}
+			}
+
+			/*
+			 * Removing PFNs in the middle of a region is not implemented; the
+			 * list is currently only used for cleanup upon kexec and there's
+			 * no harm done if we issue an extra unneeded hypercall making some
+			 * region encrypted when it already is.
+			 */
+		};
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
+	int cur, i;
+
+	if (!hv_is_isolation_supported())
+		return;
+
+	raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	if (!input)
+		goto unlock;
+
+	list_for_each_entry(ent, &hv_list_enc, list) {
+		for (i = 0, cur = 0; i < ent->count; i++) {
+			input->gpa_page_list[cur] = ent->pfn + i;
+			cur++;
+
+			if (cur == HV_MAX_MODIFY_GPA_REP_COUNT || i == ent->count - 1) {
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
@@ -475,6 +619,7 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 	struct hv_gpa_range_for_visibility *input;
 	u64 hv_status;
 	unsigned long flags;
+	int ret;
 
 	/* no-op if partition isolation is not enabled */
 	if (!hv_is_isolation_supported())
@@ -486,6 +631,14 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 		return -EINVAL;
 	}
 
+	if (visibility == VMBUS_PAGE_NOT_VISIBLE) {
+		hv_list_enc_remove(pfn, count);
+	} else {
+		ret = hv_list_enc_add(pfn, count);
+		if (ret)
+			return ret;
+	}
+
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
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
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2ed5a1e89d69..2e891e108218 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2784,6 +2784,7 @@ static void hv_kexec_handler(void)
 	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
 	mb();
 	cpuhp_remove_state(hyperv_cpuhp_online);
+	hv_ivm_clear_host_access();
 };
 
 static void hv_crash_handler(struct pt_regs *regs)
@@ -2799,6 +2800,7 @@ static void hv_crash_handler(struct pt_regs *regs)
 	cpu = smp_processor_id();
 	hv_stimer_cleanup(cpu);
 	hv_synic_disable_regs(cpu);
+	hv_ivm_clear_host_access();
 };
 
 static int hv_synic_suspend(void)
-- 
2.50.0


