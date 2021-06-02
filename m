Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6039916F
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFBRW7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51150 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFBRWz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:55 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B0EF20B8023;
        Wed,  2 Jun 2021 10:21:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B0EF20B8023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654472;
        bh=J6msNIyKK0/+q1U/VmfUQ9JG0UnVqlopTzdS1PQWY1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbV/tqbwEeUT1Q/mrVjooE9AKV90pYmdGWW1KKUWaTJ/u907yszsBJHr46E6CfMMh
         3sIt1yAYgxKednqiU0VsFjnX4U/uLv8llnf8IKXuea65pHT3lkErESh/5yzF/p1j37
         HT5ym6M3otEzBQTEOg18Gmk2UUb25BBrpxSizAQw=
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
Subject: [PATCH 14/17] mshv: Notifier framework for EOI for level triggered interrupts
Date:   Wed,  2 Jun 2021 17:20:59 +0000
Message-Id: <491e84fc16c756e8d40ac877604cd13ddc9f0ece.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A simple in-kernel notifier framework for EOI. Callbacks can be
registered for EOI for level-triggered interrupts. This is to be
used for irqfd support for level-triggered interrupts.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/hv_eventfd.c      | 38 ++++++++++++++++++++++++++++++++++++
 drivers/hv/hv_synic.c        | 22 +++++++++++++++++++++
 drivers/hv/mshv_main.c       |  4 ++++
 include/linux/mshv.h         |  9 +++++++++
 include/linux/mshv_eventfd.h |  6 ++++++
 5 files changed, 79 insertions(+)

diff --git a/drivers/hv/hv_eventfd.c b/drivers/hv/hv_eventfd.c
index 5ed77901fb0b..0bfb088dcb80 100644
--- a/drivers/hv/hv_eventfd.c
+++ b/drivers/hv/hv_eventfd.c
@@ -22,6 +22,44 @@
 
 static struct workqueue_struct *irqfd_cleanup_wq;
 
+void
+mshv_register_irq_ack_notifier(struct mshv_partition *partition,
+			       struct mshv_irq_ack_notifier *mian)
+{
+	spin_lock(&partition->irq_lock);
+	hlist_add_head_rcu(&mian->link, &partition->irq_ack_notifier_list);
+	spin_unlock(&partition->irq_lock);
+}
+
+void
+mshv_unregister_irq_ack_notifier(struct mshv_partition *partition,
+				 struct mshv_irq_ack_notifier *mian)
+{
+	spin_lock(&partition->irq_lock);
+	hlist_del_init_rcu(&mian->link);
+	spin_unlock(&partition->irq_lock);
+	synchronize_rcu();
+}
+
+bool
+mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi)
+{
+	struct mshv_irq_ack_notifier *mian;
+	bool acked = false;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(mian, &partition->irq_ack_notifier_list,
+			link) {
+		if (mian->gsi == gsi) {
+			mian->irq_acked(mian);
+			acked = true;
+		}
+	}
+	rcu_read_unlock();
+
+	return acked;
+}
+
 static void
 irqfd_inject(struct mshv_kernel_irqfd *irqfd)
 {
diff --git a/drivers/hv/hv_synic.c b/drivers/hv/hv_synic.c
index af6653967209..1296928675e3 100644
--- a/drivers/hv/hv_synic.c
+++ b/drivers/hv/hv_synic.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/random.h>
 #include <linux/mshv.h>
+#include <linux/mshv_eventfd.h>
 #include <asm/mshyperv.h>
 
 #include "mshv.h"
@@ -158,6 +159,27 @@ mshv_intercept_isr(struct hv_message *msg)
 		goto unlock_out;
 	}
 
+	if (msg->header.message_type == HVMSG_X64_APIC_EOI) {
+		/*
+		 * Check if this gsi is registered in the
+		 * ack_notifier list and invoke the callback
+		 * if registered.
+		 */
+		struct hv_x64_apic_eoi_message *eoi_msg =
+			(struct hv_x64_apic_eoi_message *)msg->u.payload;
+
+		/*
+		 * If there is a notifier, the ack callback is supposed
+		 * to handle the VMEXIT. So we need not pass this message
+		 * to vcpu thread.
+		 */
+		if (mshv_notify_acked_gsi(partition,
+					eoi_msg->interrupt_vector)) {
+			handled = true;
+			goto unlock_out;
+		}
+	}
+
 	/*
 	 * Since we directly index the vp, and it has to exist for us to be here
 	 * (because the vp is only deleted when the partition is), no additional
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index e1caecd27f09..6f93813ad465 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -1047,6 +1047,10 @@ mshv_ioctl_create_partition(void __user *user_arg)
 
 	mutex_init(&partition->mutex);
 
+	spin_lock_init(&partition->irq_lock);
+
+	INIT_HLIST_HEAD(&partition->irq_ack_notifier_list);
+
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
 		ret = fd;
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index 217c91725828..2cee4832fc7f 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -35,6 +35,12 @@ struct mshv_mem_region {
 	struct page **pages;
 };
 
+struct mshv_irq_ack_notifier {
+	struct hlist_node link;
+	unsigned int gsi;
+	void (*irq_acked)(struct mshv_irq_ack_notifier *mian);
+};
+
 struct mshv_partition {
 	u64 id;
 	refcount_t ref_count;
@@ -48,6 +54,9 @@ struct mshv_partition {
 		struct mshv_vp *array[MSHV_MAX_VPS];
 	} vps;
 
+	spinlock_t irq_lock;
+	struct hlist_head irq_ack_notifier_list;
+
 	struct {
 		spinlock_t        lock;
 		struct list_head  items;
diff --git a/include/linux/mshv_eventfd.h b/include/linux/mshv_eventfd.h
index fd0012f72616..b4d587208294 100644
--- a/include/linux/mshv_eventfd.h
+++ b/include/linux/mshv_eventfd.h
@@ -15,6 +15,12 @@
 void mshv_eventfd_init(struct mshv_partition *partition);
 void mshv_eventfd_release(struct mshv_partition *partition);
 
+void mshv_register_irq_ack_notifier(struct mshv_partition *partition,
+				    struct mshv_irq_ack_notifier *mian);
+void mshv_unregister_irq_ack_notifier(struct mshv_partition *partition,
+			struct mshv_irq_ack_notifier *mian);
+bool mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi);
+
 struct mshv_kernel_irqfd {
 	struct mshv_partition     *partition;
 	struct eventfd_ctx        *eventfd;
-- 
2.25.1

