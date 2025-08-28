Return-Path: <linux-hyperv+bounces-6651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C742B397F4
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 11:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B22B1BA83DA
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F7C20E715;
	Thu, 28 Aug 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJ5FY01k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3EA1EE033
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Aug 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372593; cv=none; b=JTdESBCeMUXbX/7dx/+IUM1AbHfGEgUPM2/DTUgPcESGsnMQuNJk1KsWysmbF+laDTW4REnT/0CIbLkjg2nzy8rvUr98QZh7cDyDded2P47bLE/yh9Ihj/DPY1iRfqjD+yhYAWWcNCBCh0MCrt/4TKPBaqI62gk0tj6CZ5ItVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372593; c=relaxed/simple;
	bh=83MPi7t3c6et/19BGf6NIja0Y+tkJ3A67wMIYcCaTiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Df/uPBAtGccpM9gTaOwzXq6QNp+9e0ZhVV5P4LZ+MXkUrN76Nrcg5tld4QcQdoR707ygOAM80Waam40i4mugWnF2nT9iD/Cc6pY5X5oZdV1FEc0YYBqnluYroigmXQHNY+2iJYjqi6YDuX5DQiPK4omFi0fltjQLgPa/fuaCosY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJ5FY01k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756372590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lMHoyR4t+VD2Hv4M+jrjEVqyNy3Cvds3HYHQtEfzQbo=;
	b=CJ5FY01kCbaF9/mD1mkZ8YCiKJQ8dW8SFzrIklzlw3H2PsDQVB3Gx9GMkx2NOo2LUOOppX
	T11k+VQPEoYXrjBYbtB6s2/Td+qbV1Fy9ilKHM8uvHJ53l3xZvNClWETEMCHngotRjdqz7
	SZRBlgskZ2YyoHO58m8ysVjSOD2bElE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-q5zZCpZ-Obilh92PJH4tFg-1; Thu,
 28 Aug 2025 05:16:26 -0400
X-MC-Unique: q5zZCpZ-Obilh92PJH4tFg-1
X-Mimecast-MFC-AGG-ID: q5zZCpZ-Obilh92PJH4tFg_1756372585
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 096051800286;
	Thu, 28 Aug 2025 09:16:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.68])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 799271800291;
	Thu, 28 Aug 2025 09:16:20 +0000 (UTC)
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
Subject: [PATCH v4] x86/hyperv: Fix kdump on Azure CVMs
Date: Thu, 28 Aug 2025 12:16:18 +0300
Message-ID: <20250828091618.884950-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v3 [Michael Kelley]:
 - Employ x86_platform.guest.enc_kexec_{begin,finish} hooks.
 - Don't use spinlock in what's now hv_vtom_kexec_finish().
 - Handle possible hypercall failures in hv_mark_gpa_visibility()
   symmetrically; change hv_list_enc_remove() to return -ENOMEM as well.
 - Rebase to the latest hyperv/next.
---
 arch/x86/hyperv/ivm.c | 211 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 210 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index ade6c665c97e..a4615b889f3e 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -462,6 +462,195 @@ void hv_ivm_msr_read(u64 msr, u64 *value)
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
+static int hv_list_enc_remove(const u64 *pfn_list, int count)
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
+		if (!ent)
+			return -ENOMEM;
+
+		ent->pfn = new_region.pfn;
+		ent->count = new_region.count;
+
+		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
+		list_add(&ent->list, &hv_list_enc);
+		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
+	}
+
+	return 0;
+}
+
+/* Stop new private<->shared conversions */
+static void hv_vtom_kexec_begin(void)
+{
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!set_memory_enc_stop_conversion())
+		pr_warn("Failed to stop shared<->private conversions\n");
+}
+
+static void hv_vtom_kexec_finish(void)
+{
+	struct hv_gpa_range_for_visibility *input;
+	struct hv_enc_pfn_region *ent;
+	unsigned long flags;
+	u64 hv_status;
+	int cur, i;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	if (unlikely(!input))
+		goto out;
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
+	}
+
+out:
+	local_irq_restore(flags);
+}
+
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
  *
@@ -475,6 +664,7 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 	struct hv_gpa_range_for_visibility *input;
 	u64 hv_status;
 	unsigned long flags;
+	int ret;
 
 	/* no-op if partition isolation is not enabled */
 	if (!hv_is_isolation_supported())
@@ -486,6 +676,13 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 		return -EINVAL;
 	}
 
+	if (visibility == VMBUS_PAGE_NOT_VISIBLE)
+		ret = hv_list_enc_remove(pfn, count);
+	else
+		ret = hv_list_enc_add(pfn, count);
+	if (ret)
+		return ret;
+
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
@@ -506,8 +703,18 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 
 	if (hv_result_success(hv_status))
 		return 0;
+
+	if (visibility == VMBUS_PAGE_NOT_VISIBLE)
+		ret = hv_list_enc_add(pfn, count);
 	else
-		return -EFAULT;
+		ret = hv_list_enc_remove(pfn, count);
+	/*
+	 * There's no good way to recover from -ENOMEM here, the accounting is
+	 * wrong either way.
+	 */
+	WARN_ON_ONCE(ret);
+
+	return -EFAULT;
 }
 
 /*
@@ -669,6 +876,8 @@ void __init hv_vtom_init(void)
 	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
 	x86_platform.guest.enc_status_change_prepare = hv_vtom_clear_present;
 	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
+	x86_platform.guest.enc_kexec_begin = hv_vtom_kexec_begin;
+	x86_platform.guest.enc_kexec_finish = hv_vtom_kexec_finish;
 
 	/* Set WB as the default cache mode. */
 	guest_force_mtrr_state(NULL, 0, MTRR_TYPE_WRBACK);
-- 
2.50.1


