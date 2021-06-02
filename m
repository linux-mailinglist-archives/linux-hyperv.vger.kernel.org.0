Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42061399170
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFBRXA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:23:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51152 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhFBRWz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:55 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5F1AB20B8008;
        Wed,  2 Jun 2021 10:21:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F1AB20B8008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654472;
        bh=apVvgarWbUiZ/0RTa1u2ZxPL9qATfom0Ft+oeOR58pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwGVR3nRFvGeyJ8gFTzo3ahLSUawLFl11cPx8xtBFVgyqP/1aGFdQJ1+7qAUpwh/I
         xEXFv2i4VPHxYTBFRNn++9qQFdlnfbXIw7vsfYlZ0fzuEawpw1IeHQwiG3fTg6bnSp
         b8+3R14KcyLpTCZByURf/zDJacB4IVFzWMwEelio=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 17/17] mshv: Use in kernel MSI routing for irqfd
Date:   Wed,  2 Jun 2021 17:21:02 +0000
Message-Id: <af580a244ed01e8695fc2d705d56714ac5c85481.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Use the in-kernel routing information for irqfd interrupts.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/hv_eventfd.c      | 94 +++++++++++++++++++++++++++---------
 drivers/hv/mshv_msi.c        |  1 +
 include/linux/mshv.h         |  2 +
 include/linux/mshv_eventfd.h | 26 +++++-----
 include/uapi/linux/mshv.h    |  6 ---
 5 files changed, 87 insertions(+), 42 deletions(-)

diff --git a/drivers/hv/hv_eventfd.c b/drivers/hv/hv_eventfd.c
index 6404624b3bc6..729b5f67aa9a 100644
--- a/drivers/hv/hv_eventfd.c
+++ b/drivers/hv/hv_eventfd.c
@@ -88,13 +88,32 @@ irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
 static void
 irqfd_inject(struct mshv_kernel_irqfd *irqfd)
 {
+	struct mshv_partition *partition = irqfd->partition;
 	struct mshv_lapic_irq *irq = &irqfd->lapic_irq;
+	unsigned int seq;
+	int idx;
 
 	WARN_ON(irqfd->resampler &&
 		!irq->control.level_triggered);
+
+	idx = srcu_read_lock(&partition->irq_srcu);
+	if (irqfd->msi_entry.gsi) {
+		if (!irqfd->msi_entry.entry_valid) {
+			pr_warn("Invalid routing info for gsi %u",
+				irqfd->msi_entry.gsi);
+			srcu_read_unlock(&partition->irq_srcu, idx);
+			return;
+		}
+
+		do {
+			seq = read_seqcount_begin(&irqfd->msi_entry_sc);
+		} while (read_seqcount_retry(&irqfd->msi_entry_sc, seq));
+	}
+
 	hv_call_assert_virtual_interrupt(irqfd->partition->id,
 					 irq->vector, irq->apic_id,
 					 irq->control);
+	srcu_read_unlock(&partition->irq_srcu, idx);
 }
 
 static void
@@ -206,6 +225,27 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
 	return 0;
 }
 
+/* Must be called under irqfds.lock */
+static void irqfd_update(struct mshv_partition *partition,
+			 struct mshv_kernel_irqfd *irqfd)
+{
+	write_seqcount_begin(&irqfd->msi_entry_sc);
+	irqfd->msi_entry = mshv_msi_map_gsi(partition, irqfd->gsi);
+	mshv_set_msi_irq(&irqfd->msi_entry, &irqfd->lapic_irq);
+	write_seqcount_end(&irqfd->msi_entry_sc);
+}
+
+void mshv_irqfd_routing_update(struct mshv_partition *partition)
+{
+	struct mshv_kernel_irqfd *irqfd;
+
+	spin_lock_irq(&partition->irqfds.lock);
+	list_for_each_entry(irqfd, &partition->irqfds.items, list) {
+		irqfd_update(partition, irqfd);
+	}
+	spin_unlock_irq(&partition->irqfds.lock);
+}
+
 static void
 irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
 			poll_table *pt)
@@ -221,29 +261,23 @@ static int
 mshv_irqfd_assign(struct mshv_partition *partition,
 		  struct mshv_irqfd *args)
 {
+	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
 	struct mshv_kernel_irqfd *irqfd, *tmp;
+	unsigned int events;
 	struct fd f;
-	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
 	int ret;
-	unsigned int events;
+	int idx;
 
 	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
 	if (!irqfd)
 		return -ENOMEM;
 
-	if (args->flags & MSHV_IRQFD_FLAG_RESAMPLE &&
-		!args->level_triggered)
-		return -EINVAL;
-
 	irqfd->partition = partition;
 	irqfd->gsi = args->gsi;
-	irqfd->lapic_irq.vector = args->vector;
-	irqfd->lapic_irq.apic_id = args->apic_id;
-	irqfd->lapic_irq.control.interrupt_type = args->interrupt_type;
-	irqfd->lapic_irq.control.level_triggered = args->level_triggered;
-	irqfd->lapic_irq.control.logical_dest_mode = args->logical_dest_mode;
 	INIT_LIST_HEAD(&irqfd->list);
 	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
+	seqcount_spinlock_init(&irqfd->msi_entry_sc,
+			       &partition->irqfds.lock);
 
 	f = fdget(args->fd);
 	if (!f.file) {
@@ -259,6 +293,31 @@ mshv_irqfd_assign(struct mshv_partition *partition,
 
 	irqfd->eventfd = eventfd;
 
+
+	spin_lock_irq(&partition->irqfds.lock);
+	idx = srcu_read_lock(&partition->irq_srcu);
+	irqfd_update(partition, irqfd);
+	srcu_read_unlock(&partition->irq_srcu, idx);
+
+	if (args->flags & MSHV_IRQFD_FLAG_RESAMPLE &&
+	    !irqfd->lapic_irq.control.level_triggered) {
+		spin_unlock_irq(&partition->irqfds.lock);
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	ret = 0;
+	list_for_each_entry(tmp, &partition->irqfds.items, list) {
+		if (irqfd->eventfd != tmp->eventfd)
+			continue;
+		/* This fd is used for another irq already. */
+		ret = -EBUSY;
+		spin_unlock_irq(&partition->irqfds.lock);
+		goto fail;
+	}
+	list_add_tail(&irqfd->list, &partition->irqfds.items);
+	spin_unlock_irq(&partition->irqfds.lock);
+
 	if (args->flags & MSHV_IRQFD_FLAG_RESAMPLE) {
 		struct mshv_kernel_irqfd_resampler *resampler;
 
@@ -314,19 +373,6 @@ mshv_irqfd_assign(struct mshv_partition *partition,
 	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
 	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
 
-	spin_lock_irq(&partition->irqfds.lock);
-	ret = 0;
-	list_for_each_entry(tmp, &partition->irqfds.items, list) {
-		if (irqfd->eventfd != tmp->eventfd)
-			continue;
-		/* This fd is used for another irq already. */
-		ret = -EBUSY;
-		spin_unlock_irq(&partition->irqfds.lock);
-		goto fail;
-	}
-	list_add_tail(&irqfd->list, &partition->irqfds.items);
-	spin_unlock_irq(&partition->irqfds.lock);
-
 	/*
 	 * Check if there was an event already pending on the eventfd
 	 * before we registered, and trigger it as if we didn't miss it.
diff --git a/drivers/hv/mshv_msi.c b/drivers/hv/mshv_msi.c
index ae25ed8dfef4..c5dc9c6fe4d5 100644
--- a/drivers/hv/mshv_msi.c
+++ b/drivers/hv/mshv_msi.c
@@ -71,6 +71,7 @@ int mshv_set_msi_routing(struct mshv_partition *partition,
 	spin_lock(&partition->irq_lock);
 	old = rcu_dereference_protected(partition->msi_routing, 1);
 	rcu_assign_pointer(partition->msi_routing, new);
+	mshv_irqfd_routing_update(partition);
 	spin_unlock(&partition->irq_lock);
 
 	synchronize_srcu_expedited(&partition->irq_srcu);
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index ec349be0ba91..fc655b60c5cd 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -104,6 +104,8 @@ struct mshv_kernel_msi_routing_entry mshv_msi_map_gsi(
 void mshv_set_msi_irq(struct mshv_kernel_msi_routing_entry *e,
 		      struct mshv_lapic_irq *irq);
 
+void mshv_irqfd_routing_update(struct mshv_partition *partition);
+
 struct hv_synic_pages {
 	struct hv_message_page *synic_message_page;
 	struct hv_synic_event_flags_page *synic_event_flags_page;
diff --git a/include/linux/mshv_eventfd.h b/include/linux/mshv_eventfd.h
index fa5d46d2eb85..a24ca167f3e9 100644
--- a/include/linux/mshv_eventfd.h
+++ b/include/linux/mshv_eventfd.h
@@ -39,20 +39,22 @@ struct mshv_kernel_irqfd_resampler {
 };
 
 struct mshv_kernel_irqfd {
-	struct mshv_partition     *partition;
-	struct eventfd_ctx        *eventfd;
-	u32                        gsi;
-	struct mshv_lapic_irq      lapic_irq;
-	struct list_head           list;
-	poll_table                 pt;
-	wait_queue_head_t         *wqh;
-	wait_queue_entry_t         wait;
-	struct work_struct         shutdown;
+	struct mshv_partition                *partition;
+	struct eventfd_ctx                   *eventfd;
+	struct mshv_kernel_msi_routing_entry msi_entry;
+	seqcount_spinlock_t                  msi_entry_sc;
+	u32                                  gsi;
+	struct mshv_lapic_irq                lapic_irq;
+	struct list_head                     list;
+	poll_table                           pt;
+	wait_queue_head_t                    *wqh;
+	wait_queue_entry_t                   wait;
+	struct work_struct                   shutdown;
 
 	/* Resampler related */
-	struct mshv_kernel_irqfd_resampler *resampler;
-	struct eventfd_ctx *resamplefd;
-	struct list_head resampler_link;
+	struct mshv_kernel_irqfd_resampler   *resampler;
+	struct eventfd_ctx                   *resamplefd;
+	struct list_head                     resampler_link;
 };
 
 int mshv_irqfd(struct mshv_partition *partition,
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index ac58f2ded79c..b5826120ba7c 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -83,16 +83,10 @@ struct mshv_translate_gva {
 #define MSHV_IRQFD_FLAG_RESAMPLE (1 << 1)
 
 struct mshv_irqfd {
-	__u64 apic_id;
 	__s32 fd;
 	__s32 resamplefd;
 	__u32 gsi;
-	__u32 vector;
-	__u32 interrupt_type;
 	__u32 flags;
-	__u8  level_triggered;
-	__u8  logical_dest_mode;
-	__u8  pad[6];
 };
 
 enum {
-- 
2.25.1

