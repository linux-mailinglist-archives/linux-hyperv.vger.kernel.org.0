Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EE7399173
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhFBRXA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:23:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51196 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhFBRWz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:55 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id E008220B8020;
        Wed,  2 Jun 2021 10:21:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E008220B8020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654471;
        bh=M2y1V7PYw8WhRlxbfc0G+S9FvQCSVACgxFNI4Od2Rl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdy0xr1LXdX4KeMepSF7kSzXX3sMyd5a0RLI1ZAlYr4BSlBh2NbAs7lHFAUcTUOBB
         /IPQ3OXKzoFV4ibOwnKJ5lqxGg5KjMdUwlcUpJqWHrLRveszkaPL78J8KpxQ0dagP6
         CsQdJLYpAsccX09a1zKdAXflvkbyVjVU474MTqKE=
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
Subject: [PATCH 12/17] mshv: Add irqfd support for mshv
Date:   Wed,  2 Jun 2021 17:20:57 +0000
Message-Id: <257dab05f72d4d817783aeaf796b605b4cf99d1b.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

irqfd is a mechanism to inject a specific interrupt to a guest using a
decoupled eventfd mechnanism:  Any legal signal on the irqfd (using
eventfd semantics from either userspace or kernel) will translate into
an injected interrupt in the guest at the next available interrupt window.

This is the implementation of irqfd feature in kvm:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=721eecbf4fe995ca94a9edec0c9843b1cc0eaaf3

The basic framework code is taken as it its from the kvm implementation.
All credit goes to kvm irqfd/ioeventfd developers.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/Kconfig           |   1 +
 drivers/hv/Makefile          |   3 +-
 drivers/hv/hv_eventfd.c      | 299 +++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_main.c       |  26 +++
 include/linux/mshv.h         |  11 ++
 include/linux/mshv_eventfd.h |  35 ++++
 include/uapi/linux/mshv.h    |  15 ++
 7 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hv/hv_eventfd.c
 create mode 100644 include/linux/mshv_eventfd.h

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index d618b1fab2bb..3bf911aac5c7 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -30,6 +30,7 @@ config HYPERV_BALLOON
 config HYPERV_ROOT_API
 	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
 	depends on HYPERV
+	select EVENTFD
 	help
 	  Provides access to interfaces for managing guest virtual machines
 	  running under the Microsoft Hypervisor.
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 455a2c01f52c..5cb738c10a2d 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -13,4 +13,5 @@ hv_vmbus-y := vmbus_drv.o \
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
 
-mshv-y                          += mshv_main.o hv_call.o hv_synic.o hv_portid_table.o
+mshv-y                          += mshv_main.o hv_call.o hv_synic.o hv_portid_table.o  \
+					hv_eventfd.o
diff --git a/drivers/hv/hv_eventfd.c b/drivers/hv/hv_eventfd.c
new file mode 100644
index 000000000000..11fcafd1df08
--- /dev/null
+++ b/drivers/hv/hv_eventfd.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * eventfd support for mshv
+ *
+ * Heavily inspired from KVM implementation of irqfd. The basic framework
+ * code is taken from the kvm implementation.
+ *
+ * All credits to kvm developers.
+ */
+
+#include <linux/syscalls.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/file.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/eventfd.h>
+#include <linux/mshv.h>
+#include <linux/mshv_eventfd.h>
+
+#include "mshv.h"
+
+static struct workqueue_struct *irqfd_cleanup_wq;
+
+static void
+irqfd_inject(struct mshv_kernel_irqfd *irqfd)
+{
+	struct mshv_lapic_irq *irq = &irqfd->lapic_irq;
+
+	hv_call_assert_virtual_interrupt(irqfd->partition->id,
+					 irq->vector, irq->apic_id,
+					 irq->control);
+}
+
+static void
+irqfd_shutdown(struct work_struct *work)
+{
+	struct mshv_kernel_irqfd *irqfd =
+		container_of(work, struct mshv_kernel_irqfd, shutdown);
+
+	/*
+	 * Synchronize with the wait-queue and unhook ourselves to prevent
+	 * further events.
+	 */
+	remove_wait_queue(irqfd->wqh, &irqfd->wait);
+
+	/*
+	 * It is now safe to release the object's resources
+	 */
+	eventfd_ctx_put(irqfd->eventfd);
+	kfree(irqfd);
+}
+
+/* assumes partition->irqfds.lock is held */
+static bool
+irqfd_is_active(struct mshv_kernel_irqfd *irqfd)
+{
+	return list_empty(&irqfd->list) ? false : true;
+}
+
+/*
+ * Mark the irqfd as inactive and schedule it for removal
+ *
+ * assumes partition->irqfds.lock is held
+ */
+static void
+irqfd_deactivate(struct mshv_kernel_irqfd *irqfd)
+{
+	BUG_ON(!irqfd_is_active(irqfd));
+
+	list_del_init(&irqfd->list);
+
+	queue_work(irqfd_cleanup_wq, &irqfd->shutdown);
+}
+
+/*
+ * Called with wqh->lock held and interrupts disabled
+ */
+static int
+irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
+		int sync, void *key)
+{
+	struct mshv_kernel_irqfd *irqfd =
+		container_of(wait, struct mshv_kernel_irqfd, wait);
+	unsigned long flags = (unsigned long)key;
+
+	if (flags & POLLIN)
+		/* An event has been signaled, inject an interrupt */
+		irqfd_inject(irqfd);
+
+	if (flags & POLLHUP) {
+		/* The eventfd is closing, detach from Partition */
+		struct mshv_partition *partition = irqfd->partition;
+		unsigned long flags;
+
+		spin_lock_irqsave(&partition->irqfds.lock, flags);
+
+		/*
+		 * We must check if someone deactivated the irqfd before
+		 * we could acquire the irqfds.lock since the item is
+		 * deactivated from the mshv side before it is unhooked from
+		 * the wait-queue.  If it is already deactivated, we can
+		 * simply return knowing the other side will cleanup for us.
+		 * We cannot race against the irqfd going away since the
+		 * other side is required to acquire wqh->lock, which we hold
+		 */
+		if (irqfd_is_active(irqfd))
+			irqfd_deactivate(irqfd);
+
+		spin_unlock_irqrestore(&partition->irqfds.lock, flags);
+	}
+
+	return 0;
+}
+
+static void
+irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
+			poll_table *pt)
+{
+	struct mshv_kernel_irqfd *irqfd =
+		container_of(pt, struct mshv_kernel_irqfd, pt);
+
+	irqfd->wqh = wqh;
+	add_wait_queue(wqh, &irqfd->wait);
+}
+
+static int
+mshv_irqfd_assign(struct mshv_partition *partition,
+		  struct mshv_irqfd *args)
+{
+	struct mshv_kernel_irqfd *irqfd, *tmp;
+	struct fd f;
+	struct eventfd_ctx *eventfd = NULL;
+	int ret;
+	unsigned int events;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->partition = partition;
+	irqfd->gsi = args->gsi;
+	irqfd->lapic_irq.vector = args->vector;
+	irqfd->lapic_irq.apic_id = args->apic_id;
+	irqfd->lapic_irq.control.interrupt_type = args->interrupt_type;
+	irqfd->lapic_irq.control.level_triggered = args->level_triggered;
+	irqfd->lapic_irq.control.logical_dest_mode = args->logical_dest_mode;
+	INIT_LIST_HEAD(&irqfd->list);
+	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
+
+	f = fdget(args->fd);
+	if (!f.file) {
+		ret = -EBADF;
+		goto out;
+	}
+
+	eventfd = eventfd_ctx_fileget(f.file);
+	if (IS_ERR(eventfd)) {
+		ret = PTR_ERR(eventfd);
+		goto fail;
+	}
+
+	irqfd->eventfd = eventfd;
+
+	/*
+	 * Install our own custom wake-up handling so we are notified via
+	 * a callback whenever someone signals the underlying eventfd
+	 */
+	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
+	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
+
+	spin_lock_irq(&partition->irqfds.lock);
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
+	/*
+	 * Check if there was an event already pending on the eventfd
+	 * before we registered, and trigger it as if we didn't miss it.
+	 */
+	events = vfs_poll(f.file, &irqfd->pt);
+
+	if (events & POLLIN)
+		irqfd_inject(irqfd);
+
+	/*
+	 * do not drop the file until the irqfd is fully initialized, otherwise
+	 * we might race against the POLLHUP
+	 */
+	fdput(f);
+
+	return 0;
+
+fail:
+	if (eventfd && !IS_ERR(eventfd))
+		eventfd_ctx_put(eventfd);
+
+	fdput(f);
+
+out:
+	kfree(irqfd);
+	return ret;
+}
+
+void
+mshv_irqfd_init(struct mshv_partition *partition)
+{
+	spin_lock_init(&partition->irqfds.lock);
+	INIT_LIST_HEAD(&partition->irqfds.items);
+}
+
+/*
+ * shutdown any irqfd's that match fd+gsi
+ */
+static int
+mshv_irqfd_deassign(struct mshv_partition *partition,
+		    struct mshv_irqfd *args)
+{
+	struct mshv_kernel_irqfd *irqfd, *tmp;
+	struct eventfd_ctx *eventfd;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	spin_lock_irq(&partition->irqfds.lock);
+
+	list_for_each_entry_safe(irqfd, tmp, &partition->irqfds.items, list) {
+		if (irqfd->eventfd == eventfd && irqfd->gsi == args->gsi)
+			irqfd_deactivate(irqfd);
+	}
+
+	spin_unlock_irq(&partition->irqfds.lock);
+	eventfd_ctx_put(eventfd);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed
+	 * so that we guarantee there will not be any more interrupts on this
+	 * gsi once this deassign function returns.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+
+	return 0;
+}
+
+int
+mshv_irqfd(struct mshv_partition *partition, struct mshv_irqfd *args)
+{
+	if (args->flags & MSHV_IRQFD_FLAG_DEASSIGN)
+		return mshv_irqfd_deassign(partition, args);
+
+	return mshv_irqfd_assign(partition, args);
+}
+
+/*
+ * This function is called as the mshv VM fd is being released. Shutdown all
+ * irqfds that still remain open
+ */
+void
+mshv_irqfd_release(struct mshv_partition *partition)
+{
+	struct mshv_kernel_irqfd *irqfd, *tmp;
+
+	spin_lock_irq(&partition->irqfds.lock);
+
+	list_for_each_entry_safe(irqfd, tmp, &partition->irqfds.items, list)
+		irqfd_deactivate(irqfd);
+
+	spin_unlock_irq(&partition->irqfds.lock);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed
+	 * since we do not take a mshv_partition* reference.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+
+}
+
+int mshv_irqfd_wq_init(void)
+{
+	irqfd_cleanup_wq = alloc_workqueue("mshv-irqfd-cleanup", 0, 0);
+	if (!irqfd_cleanup_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void mshv_irqfd_wq_cleanup(void)
+{
+	destroy_workqueue(irqfd_cleanup_wq);
+}
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index ccf0971d0d39..e124119e65eb 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -19,6 +19,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/random.h>
 #include <linux/mshv.h>
+#include <linux/mshv_eventfd.h>
 #include <asm/mshyperv.h>
 
 #include "mshv.h"
@@ -827,6 +828,18 @@ mshv_partition_ioctl_assert_interrupt(struct mshv_partition *partition,
 			args.control);
 }
 
+static long
+mshv_partition_ioctl_irqfd(struct mshv_partition *partition,
+		void __user *user_args)
+{
+	struct mshv_irqfd args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return mshv_irqfd(partition, &args);
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -865,6 +878,10 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		ret = mshv_partition_ioctl_set_property(partition,
 							(void __user *)arg);
 		break;
+	case MSHV_IRQFD:
+		ret = mshv_partition_ioctl_irqfd(partition,
+						 (void __user *)arg);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
@@ -955,6 +972,8 @@ mshv_partition_release(struct inode *inode, struct file *filp)
 {
 	struct mshv_partition *partition = filp->private_data;
 
+	mshv_irqfd_release(partition);
+
 	mshv_partition_put(partition);
 
 	return 0;
@@ -1049,6 +1068,8 @@ mshv_ioctl_create_partition(void __user *user_arg)
 
 	fd_install(fd, file);
 
+	mshv_irqfd_init(partition);
+
 	return fd;
 
 release_file:
@@ -1137,12 +1158,17 @@ __init mshv_init(void)
 	mshv_cpuhp_online = ret;
 	spin_lock_init(&mshv.partitions.lock);
 
+	if (mshv_irqfd_wq_init())
+		mshv_irqfd_wq_cleanup();
+
 	return 0;
 }
 
 static void
 __exit mshv_exit(void)
 {
+	mshv_irqfd_wq_cleanup();
+
 	cpuhp_remove_state(mshv_cpuhp_online);
 	free_percpu(mshv.synic_pages);
 
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index 679aa3fa8cdb..5707c457b72d 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -47,6 +47,17 @@ struct mshv_partition {
 		u32 count;
 		struct mshv_vp *array[MSHV_MAX_VPS];
 	} vps;
+
+	struct {
+		spinlock_t        lock;
+		struct list_head  items;
+	} irqfds;
+};
+
+struct mshv_lapic_irq {
+	u32 vector;
+	u64 apic_id;
+	union hv_interrupt_control control;
 };
 
 struct hv_synic_pages {
diff --git a/include/linux/mshv_eventfd.h b/include/linux/mshv_eventfd.h
new file mode 100644
index 000000000000..3e7b16d0717f
--- /dev/null
+++ b/include/linux/mshv_eventfd.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *
+ * irqfd: Allows an fd to be used to inject an interrupt to the guest
+ * All credit goes to kvm developers.
+ */
+
+#ifndef __LINUX_MSHV_EVENTFD_H
+#define __LINUX_MSHV_EVENTFD_H
+
+#include <linux/mshv.h>
+#include <linux/poll.h>
+
+struct mshv_kernel_irqfd {
+	struct mshv_partition     *partition;
+	struct eventfd_ctx        *eventfd;
+	u32                        gsi;
+	struct mshv_lapic_irq      lapic_irq;
+	struct list_head           list;
+	poll_table                 pt;
+	wait_queue_head_t         *wqh;
+	wait_queue_entry_t         wait;
+	struct work_struct         shutdown;
+};
+
+int mshv_irqfd(struct mshv_partition *partition,
+		struct mshv_irqfd *args);
+
+void mshv_irqfd_init(struct mshv_partition *partition);
+void mshv_irqfd_release(struct mshv_partition *partition);
+
+int mshv_irqfd_wq_init(void);
+void mshv_irqfd_wq_cleanup(void);
+
+#endif /* __LINUX_MSHV_EVENTFD_H */
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 0c46ce77cbb3..792844276134 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -79,6 +79,20 @@ struct mshv_translate_gva {
 	__u64 *gpa;
 };
 
+#define MSHV_IRQFD_FLAG_DEASSIGN (1 << 0)
+
+struct mshv_irqfd {
+	__u64 apic_id;
+	__s32 fd;
+	__u32 gsi;
+	__u32 vector;
+	__u32 interrupt_type;
+	__u32 flags;
+	__u8  level_triggered;
+	__u8  logical_dest_mode;
+	__u8  pad[2];
+};
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
@@ -95,6 +109,7 @@ struct mshv_translate_gva {
 				_IOW(MSHV_IOCTL, 0xC, struct mshv_partition_property)
 #define MSHV_GET_PARTITION_PROPERTY \
 				_IOWR(MSHV_IOCTL, 0xD, struct mshv_partition_property)
+#define MSHV_IRQFD              _IOW(MSHV_IOCTL, 0xE, struct mshv_irqfd)
 
 /* vp device */
 #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
-- 
2.25.1

