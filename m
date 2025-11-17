Return-Path: <linux-hyperv+bounces-7641-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD9FC659CC
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 42E9A2928F
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2897631064E;
	Mon, 17 Nov 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="kPdjrepY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E85930DED4;
	Mon, 17 Nov 2025 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401900; cv=pass; b=h2uvH7uX/e978GNsQNnmcbFBFIIpK8HwYP9PeXrO0T0MLlCJ33ZHTUsKXeaev+M64lywY0APzDlyrTu54otvS6iK6RBJeVYbGBOxI9QyPFC5TuUGVjYCQOfxRTCspajSVgmXZpJBQGJ9Sk/AIxkUwtJQpklX/mn6JLES5bingYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401900; c=relaxed/simple;
	bh=Uv+D5bejqgGtRZ1q/k10U5LkV31Dmo2quTF8crqPa6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NNG8/I64vp817ylnnvCR5Wed+DF9r0q3TANkqBs9Zyg6fqq4Iqp6pFDJ6h8tNAB01zXyS9xeXMJnK87BkfsUMTHrmub1gUdcL+2821lYlI/Clz4Ll6mmKk2YeY2OhSKKK9zDjUBcmb2QOYyOVYzZNzv3pB6AJZXGHJhGxb8kSSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=kPdjrepY; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1763401883; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RSfnqTTZbVsz56habPVJTZYDWLd0uzJi7C7+mA9WPQPm/gSqVHESG/0I8Mm1NhyToHxx/W0T/QLPCyiUUPmwhGscCmsoOrVD6DoF5G5yuSvLZbacYQHCSbmp4IneS2tND9J5ejskaKdWOS+0rfxRZMz3gT+6/arCZsROwzPFMFI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763401883; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RHmWuy7eVPC+v6RgdWqttCrJVkN8JE86hU+CLwssC4M=; 
	b=Pvr9n6KLzQFNitK67QztciZG3aYvZyZiK7v3LPPHIclwGx6xZVwKm407Mfo0L98/c3z/JMArhuahrd7uzDT0FcmFy4k3JPKt1BLgcs09BqiInML6j6PRYFeR5iD9TnzDWdji/kmZexZXW3kuABBNkv/gkprwxcl35ueH9doNZuw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763401882;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RHmWuy7eVPC+v6RgdWqttCrJVkN8JE86hU+CLwssC4M=;
	b=kPdjrepYkm+JisBXJpjItodroik6Km8DXN/yhGIgBVi1JRHnBiQeUaZAKTo6Yp/7
	42uOX9eIwkrysNuMEMYkRdZJX5Det5hWR+r+tLyiEehsFx+m+SlarGLqViV+0JH40xq
	uauhn1mwvbp8OhlREljPFLJl0IRGIeoOF6x3wMlY=
Received: by mx.zohomail.com with SMTPS id 1763401880225787.1597908687801;
	Mon, 17 Nov 2025 09:51:20 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: anirudh@anirudhrb.com,
	Jinank Jain <jinankjain@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: adjust interrupt control structure for ARM64
Date: Mon, 17 Nov 2025 17:50:53 +0000
Message-Id: <20251117175054.242889-1-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Jinank Jain <jinankjain@microsoft.com>

Interrupt control structure (union hv_interupt_control) has different
fields when it comes to x86 vs ARM64. Bring in the correct structure
from HyperV header files and adjust the existing interrupt routing
code accordingly.

Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_eventfd.c      | 6 ++++++
 drivers/hv/mshv_irq.c          | 4 ++++
 drivers/hv/mshv_root_hv_call.c | 6 ++++++
 include/hyperv/hvhdk.h         | 6 ++++++
 4 files changed, 22 insertions(+)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 2a80af1d610a..d93a18f09c76 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -163,8 +163,10 @@ static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
 	if (hv_scheduler_type != HV_SCHEDULER_TYPE_ROOT)
 		return -EOPNOTSUPP;
 
+#if IS_ENABLED(CONFIG_X86)
 	if (irq->lapic_control.logical_dest_mode)
 		return -EOPNOTSUPP;
+#endif
 
 	vp = partition->pt_vp_array[irq->lapic_apic_id];
 
@@ -196,8 +198,10 @@ static void mshv_assert_irq_slow(struct mshv_irqfd *irqfd)
 	unsigned int seq;
 	int idx;
 
+#if IS_ENABLED(CONFIG_X86)
 	WARN_ON(irqfd->irqfd_resampler &&
 		!irq->lapic_control.level_triggered);
+#endif
 
 	idx = srcu_read_lock(&partition->pt_irq_srcu);
 	if (irqfd->irqfd_girq_ent.guest_irq_num) {
@@ -469,6 +473,7 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 	init_poll_funcptr(&irqfd->irqfd_polltbl, mshv_irqfd_queue_proc);
 
 	spin_lock_irq(&pt->pt_irqfds_lock);
+#if IS_ENABLED(CONFIG_X86)
 	if (args->flags & BIT(MSHV_IRQFD_BIT_RESAMPLE) &&
 	    !irqfd->irqfd_lapic_irq.lapic_control.level_triggered) {
 		/*
@@ -479,6 +484,7 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 		ret = -EINVAL;
 		goto fail;
 	}
+#endif
 	ret = 0;
 	hlist_for_each_entry(tmp, &pt->pt_irqfds_list, irqfd_hnode) {
 		if (irqfd->irqfd_eventfd_ctx != tmp->irqfd_eventfd_ctx)
diff --git a/drivers/hv/mshv_irq.c b/drivers/hv/mshv_irq.c
index d0fb9ef734f4..798e7e1ab06e 100644
--- a/drivers/hv/mshv_irq.c
+++ b/drivers/hv/mshv_irq.c
@@ -119,6 +119,10 @@ void mshv_copy_girq_info(struct mshv_guest_irq_ent *ent,
 	lirq->lapic_vector = ent->girq_irq_data & 0xFF;
 	lirq->lapic_apic_id = (ent->girq_addr_lo >> 12) & 0xFF;
 	lirq->lapic_control.interrupt_type = (ent->girq_irq_data & 0x700) >> 8;
+#if IS_ENABLED(CONFIG_X86)
 	lirq->lapic_control.level_triggered = (ent->girq_irq_data >> 15) & 0x1;
 	lirq->lapic_control.logical_dest_mode = (ent->girq_addr_lo >> 2) & 0x1;
+#elif IS_ENABLED(CONFIG_ARM64)
+	lirq->lapic_control.asserted = 1;
+#endif
 }
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index caf02cfa49c9..598eaff4ff29 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -388,7 +388,13 @@ int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
 	memset(input, 0, sizeof(*input));
 	input->partition_id = partition_id;
 	input->vector = vector;
+	/*
+	 * NOTE: dest_addr only needs to be provided while asserting an
+	 * interrupt on x86 platform
+	 */
+#if IS_ENABLED(CONFIG_X86)
 	input->dest_addr = dest_addr;
+#endif
 	input->control = control;
 	status = hv_do_hypercall(HVCALL_ASSERT_VIRTUAL_INTERRUPT, input, NULL);
 	local_irq_restore(flags);
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 416c0d45b793..469186df7826 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -579,9 +579,15 @@ union hv_interrupt_control {
 	u64 as_uint64;
 	struct {
 		u32 interrupt_type; /* enum hv_interrupt_type */
+#if IS_ENABLED(CONFIG_X86)
 		u32 level_triggered : 1;
 		u32 logical_dest_mode : 1;
 		u32 rsvd : 30;
+#elif IS_ENABLED(CONFIG_ARM64)
+		u32 rsvd1 : 2;
+		u32 asserted : 1;
+		u32 rsvd2 : 29;
+#endif
 	} __packed;
 };
 

base-commit: db7df69995ffbe806d60ad46d5fb9d959da9e549
-- 
2.34.1


