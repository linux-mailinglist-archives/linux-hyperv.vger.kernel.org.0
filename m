Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434DB39916D
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFBRW7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51206 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhFBRWz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:55 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 31F8F20B8025;
        Wed,  2 Jun 2021 10:21:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 31F8F20B8025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654472;
        bh=yKIl/UK14bGXrTBWX2GOe75AYA1qgrgayUaSe7jyIqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXIwv9Os+GeHjiJUOZsaiC9vVFFRQYGp+bWPkkm+SMzsrcjnTTCGFsoUP4wClLEel
         fz0AbDHeiLXWJt7seOubqopwYT6AIhRWneME4n01n0ABhNkTYkIx9A+uCULXqBbz7f
         1Z5noN2zFzw9fqBhp3X5FI9M/wtJch8nI2DLP+7I=
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
Subject: [PATCH 15/17] mshv: Level-triggered interrupt support for irqfd
Date:   Wed,  2 Jun 2021 17:21:00 +0000
Message-Id: <2c849e3cedd8e0a2555a732d51a82545b5a42481.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

To emulate level triggered interrupts, add a resample option to
MSHV_IRQFD. When specified, a new resamplefd is provided that notifies
the user when VM EOI a level-triggered interrupt. Also in this mode,
posting of an interrupt through an irqfd only asserts the interrupt.

Inspired from the KVM counterpart:
https://patchwork.kernel.org/project/kvm/patch/20120921175601.32604.63271.stgit@bling.home/

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/hv_eventfd.c      | 118 ++++++++++++++++++++++++++++++++++-
 drivers/hv/mshv_main.c       |   8 +++
 include/linux/mshv.h         |   4 ++
 include/linux/mshv_eventfd.h |  22 +++++++
 include/uapi/linux/mshv.h    |   4 +-
 5 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_eventfd.c b/drivers/hv/hv_eventfd.c
index 0bfb088dcb80..6404624b3bc6 100644
--- a/drivers/hv/hv_eventfd.c
+++ b/drivers/hv/hv_eventfd.c
@@ -60,16 +60,66 @@ mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi)
 	return acked;
 }
 
+static void
+irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
+{
+	struct mshv_kernel_irqfd_resampler *resampler;
+	struct mshv_partition *partition;
+	struct mshv_kernel_irqfd *irqfd;
+	int idx;
+
+	resampler = container_of(mian,
+			struct mshv_kernel_irqfd_resampler, notifier);
+	partition = resampler->partition;
+
+	idx = srcu_read_lock(&partition->irq_srcu);
+
+	list_for_each_entry_rcu(irqfd, &resampler->list, resampler_link) {
+		if (irqfd->lapic_irq.control.interrupt_type ==
+				HV_X64_INTERRUPT_TYPE_EXTINT)
+			hv_call_clear_virtual_interrupt(partition->id);
+
+		eventfd_signal(irqfd->resamplefd, 1);
+	}
+
+	srcu_read_unlock(&partition->irq_srcu, idx);
+}
+
 static void
 irqfd_inject(struct mshv_kernel_irqfd *irqfd)
 {
 	struct mshv_lapic_irq *irq = &irqfd->lapic_irq;
 
+	WARN_ON(irqfd->resampler &&
+		!irq->control.level_triggered);
 	hv_call_assert_virtual_interrupt(irqfd->partition->id,
 					 irq->vector, irq->apic_id,
 					 irq->control);
 }
 
+static void
+irqfd_resampler_shutdown(struct mshv_kernel_irqfd *irqfd)
+{
+	struct mshv_kernel_irqfd_resampler *resampler = irqfd->resampler;
+	struct mshv_partition *partition = resampler->partition;
+
+	mutex_lock(&partition->irqfds.resampler_lock);
+
+	list_del_rcu(&irqfd->resampler_link);
+	synchronize_srcu(&partition->irq_srcu);
+
+	if (list_empty(&resampler->list)) {
+		list_del(&resampler->link);
+		mshv_unregister_irq_ack_notifier(partition, &resampler->notifier);
+		kfree(resampler);
+	}
+
+	mutex_unlock(&partition->irqfds.resampler_lock);
+}
+
+/*
+ * Race-free decouple logic (ordering is critical)
+ */
 static void
 irqfd_shutdown(struct work_struct *work)
 {
@@ -82,6 +132,11 @@ irqfd_shutdown(struct work_struct *work)
 	 */
 	remove_wait_queue(irqfd->wqh, &irqfd->wait);
 
+	if (irqfd->resampler) {
+		irqfd_resampler_shutdown(irqfd);
+		eventfd_ctx_put(irqfd->resamplefd);
+	}
+
 	/*
 	 * It is now safe to release the object's resources
 	 */
@@ -168,7 +223,7 @@ mshv_irqfd_assign(struct mshv_partition *partition,
 {
 	struct mshv_kernel_irqfd *irqfd, *tmp;
 	struct fd f;
-	struct eventfd_ctx *eventfd = NULL;
+	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
 	int ret;
 	unsigned int events;
 
@@ -176,6 +231,10 @@ mshv_irqfd_assign(struct mshv_partition *partition,
 	if (!irqfd)
 		return -ENOMEM;
 
+	if (args->flags & MSHV_IRQFD_FLAG_RESAMPLE &&
+		!args->level_triggered)
+		return -EINVAL;
+
 	irqfd->partition = partition;
 	irqfd->gsi = args->gsi;
 	irqfd->lapic_irq.vector = args->vector;
@@ -200,6 +259,54 @@ mshv_irqfd_assign(struct mshv_partition *partition,
 
 	irqfd->eventfd = eventfd;
 
+	if (args->flags & MSHV_IRQFD_FLAG_RESAMPLE) {
+		struct mshv_kernel_irqfd_resampler *resampler;
+
+		resamplefd = eventfd_ctx_fdget(args->resamplefd);
+		if (IS_ERR(resamplefd)) {
+			ret = PTR_ERR(resamplefd);
+			goto fail;
+		}
+
+		irqfd->resamplefd = resamplefd;
+		INIT_LIST_HEAD(&irqfd->resampler_link);
+
+		mutex_lock(&partition->irqfds.resampler_lock);
+
+		list_for_each_entry(resampler,
+				    &partition->irqfds.resampler_list, link) {
+			if (resampler->notifier.gsi == irqfd->gsi) {
+				irqfd->resampler = resampler;
+				break;
+			}
+		}
+
+		if (!irqfd->resampler) {
+			resampler = kzalloc(sizeof(*resampler),
+					    GFP_KERNEL_ACCOUNT);
+			if (!resampler) {
+				ret = -ENOMEM;
+				mutex_unlock(&partition->irqfds.resampler_lock);
+				goto fail;
+			}
+
+			resampler->partition = partition;
+			INIT_LIST_HEAD(&resampler->list);
+			resampler->notifier.gsi = irqfd->gsi;
+			resampler->notifier.irq_acked = irqfd_resampler_ack;
+			INIT_LIST_HEAD(&resampler->link);
+
+			list_add(&resampler->link, &partition->irqfds.resampler_list);
+			mshv_register_irq_ack_notifier(partition,
+						      &resampler->notifier);
+			irqfd->resampler = resampler;
+		}
+
+		list_add_rcu(&irqfd->resampler_link, &irqfd->resampler->list);
+
+		mutex_unlock(&partition->irqfds.resampler_lock);
+	}
+
 	/*
 	 * Install our own custom wake-up handling so we are notified via
 	 * a callback whenever someone signals the underlying eventfd
@@ -238,6 +345,12 @@ mshv_irqfd_assign(struct mshv_partition *partition,
 	return 0;
 
 fail:
+	if (irqfd->resampler)
+		irqfd_resampler_shutdown(irqfd);
+
+	if (resamplefd && !IS_ERR(resamplefd))
+		eventfd_ctx_put(resamplefd);
+
 	if (eventfd && !IS_ERR(eventfd))
 		eventfd_ctx_put(eventfd);
 
@@ -541,6 +654,9 @@ mshv_eventfd_init(struct mshv_partition *partition)
 	spin_lock_init(&partition->irqfds.lock);
 	INIT_LIST_HEAD(&partition->irqfds.items);
 
+	INIT_LIST_HEAD(&partition->irqfds.resampler_list);
+	mutex_init(&partition->irqfds.resampler_lock);
+
 	spin_lock_init(&partition->ioeventfds.lock);
 	INIT_LIST_HEAD(&partition->ioeventfds.items);
 }
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 6f93813ad465..0f083447c553 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -990,6 +990,8 @@ mshv_partition_release(struct inode *inode, struct file *filp)
 
 	mshv_eventfd_release(partition);
 
+	cleanup_srcu_struct(&partition->irq_srcu);
+
 	mshv_partition_put(partition);
 
 	return 0;
@@ -1088,10 +1090,16 @@ mshv_ioctl_create_partition(void __user *user_arg)
 
 	fd_install(fd, file);
 
+	ret = init_srcu_struct(&partition->irq_srcu);
+	if (ret)
+		goto cleanup_irq_srcu;
+
 	mshv_eventfd_init(partition);
 
 	return fd;
 
+cleanup_irq_srcu:
+	cleanup_srcu_struct(&partition->irq_srcu);
 release_file:
 	file->f_op->release(file->f_inode, file);
 finalize_partition:
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index 2cee4832fc7f..5968b49b9c27 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/semaphore.h>
 #include <linux/sched.h>
+#include <linux/srcu.h>
 #include <uapi/linux/mshv.h>
 
 #define MSHV_MAX_PARTITIONS		128
@@ -55,11 +56,14 @@ struct mshv_partition {
 	} vps;
 
 	spinlock_t irq_lock;
+	struct srcu_struct irq_srcu;
 	struct hlist_head irq_ack_notifier_list;
 
 	struct {
 		spinlock_t        lock;
 		struct list_head  items;
+		struct mutex resampler_lock;
+		struct list_head  resampler_list;
 	} irqfds;
 	struct {
 		spinlock_t        lock;
diff --git a/include/linux/mshv_eventfd.h b/include/linux/mshv_eventfd.h
index b4d587208294..fa5d46d2eb85 100644
--- a/include/linux/mshv_eventfd.h
+++ b/include/linux/mshv_eventfd.h
@@ -21,6 +21,23 @@ void mshv_unregister_irq_ack_notifier(struct mshv_partition *partition,
 			struct mshv_irq_ack_notifier *mian);
 bool mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi);
 
+struct mshv_kernel_irqfd_resampler {
+	struct mshv_partition *partition;
+	/*
+	 * List of irqfds sharing this gsi.
+	 * Protected by irqfds.resampler_lock
+	 * and irq_srcu.
+	 */
+	struct list_head list;
+	struct mshv_irq_ack_notifier notifier;
+	/*
+	 * Entry in the list of partition->irqfd.resampler_list.
+	 * Protected by irqfds.resampler_lock
+	 *
+	 */
+	struct list_head link;
+};
+
 struct mshv_kernel_irqfd {
 	struct mshv_partition     *partition;
 	struct eventfd_ctx        *eventfd;
@@ -31,6 +48,11 @@ struct mshv_kernel_irqfd {
 	wait_queue_head_t         *wqh;
 	wait_queue_entry_t         wait;
 	struct work_struct         shutdown;
+
+	/* Resampler related */
+	struct mshv_kernel_irqfd_resampler *resampler;
+	struct eventfd_ctx *resamplefd;
+	struct list_head resampler_link;
 };
 
 int mshv_irqfd(struct mshv_partition *partition,
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index e32dee679360..008e68bde56d 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -80,17 +80,19 @@ struct mshv_translate_gva {
 };
 
 #define MSHV_IRQFD_FLAG_DEASSIGN (1 << 0)
+#define MSHV_IRQFD_FLAG_RESAMPLE (1 << 1)
 
 struct mshv_irqfd {
 	__u64 apic_id;
 	__s32 fd;
+	__s32 resamplefd;
 	__u32 gsi;
 	__u32 vector;
 	__u32 interrupt_type;
 	__u32 flags;
 	__u8  level_triggered;
 	__u8  logical_dest_mode;
-	__u8  pad[2];
+	__u8  pad[6];
 };
 
 enum {
-- 
2.25.1

