Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD9039916E
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFBRW7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51202 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFBRWz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:55 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 048CD20B8022;
        Wed,  2 Jun 2021 10:21:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 048CD20B8022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654472;
        bh=uHeRjnbWk07hCPrCh4+ckxgXfIHJZaPTLGauGMtGN4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdtZUGUvW4GnZOCAYs+FoAseLNFlRkyCuCSOXIHG+tz6LCOc87jfMNhgezso1i4ZZ
         iRIE7xmtw6n6FoszQQk4mKpm1ADx4yDYlkFmexptzNT4BTwa7cIsdEFNyWqDWs4Jaw
         s/7Ll+gD0VpYyTsoBQ0TYbWSp3iAmk66PLqfiiN0=
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
Subject: [PATCH 13/17] mshv: Add ioeventfd support for mshv
Date:   Wed,  2 Jun 2021 17:20:58 +0000
Message-Id: <2b663b68c0c7f568b03c029817ae9110a47311e9.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

ioeventfd is a mechanism to register PIO/MMIO regions to trigger an
eventfd signal when written to by a guest.  Host userspace can register
any arbitrary IO address with a corresponding eventfd and then pass the
eventfd to a specific end-point of interest for handling.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d34e6b175e61821026893ec5298cc8e7558df43a

Basic framework code is taken from kvm implementation. Credit goes to
kvm irqfd/ioeventfd developers.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/hv_eventfd.c      | 248 +++++++++++++++++++++++++++++++++--
 drivers/hv/mshv_main.c       |  20 ++-
 include/linux/mshv.h         |   4 +
 include/linux/mshv_eventfd.h |  21 ++-
 include/uapi/linux/mshv.h    |  26 +++-
 5 files changed, 300 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/hv_eventfd.c b/drivers/hv/hv_eventfd.c
index 11fcafd1df08..5ed77901fb0b 100644
--- a/drivers/hv/hv_eventfd.c
+++ b/drivers/hv/hv_eventfd.c
@@ -2,8 +2,8 @@
 /*
  * eventfd support for mshv
  *
- * Heavily inspired from KVM implementation of irqfd. The basic framework
- * code is taken from the kvm implementation.
+ * Heavily inspired from KVM implementation of irqfd/ioeventfd. The basic
+ * framework code is taken from the kvm implementation.
  *
  * All credits to kvm developers.
  */
@@ -210,13 +210,6 @@ mshv_irqfd_assign(struct mshv_partition *partition,
 	return ret;
 }
 
-void
-mshv_irqfd_init(struct mshv_partition *partition)
-{
-	spin_lock_init(&partition->irqfds.lock);
-	INIT_LIST_HEAD(&partition->irqfds.items);
-}
-
 /*
  * shutdown any irqfd's that match fd+gsi
  */
@@ -261,10 +254,10 @@ mshv_irqfd(struct mshv_partition *partition, struct mshv_irqfd *args)
 }
 
 /*
- * This function is called as the mshv VM fd is being released. Shutdown all
- * irqfds that still remain open
+ * This function is called as the mshv VM fd is being released.
+ * Shutdown all irqfds that still remain open
  */
-void
+static void
 mshv_irqfd_release(struct mshv_partition *partition)
 {
 	struct mshv_kernel_irqfd *irqfd, *tmp;
@@ -297,3 +290,234 @@ void mshv_irqfd_wq_cleanup(void)
 {
 	destroy_workqueue(irqfd_cleanup_wq);
 }
+
+/*
+ * --------------------------------------------------------------------
+ * ioeventfd: translate a MMIO memory write to an eventfd signal.
+ *
+ * userspace can register a MMIO address with an eventfd for receiving
+ * notification when the memory has been touched.
+ *
+ * TODO: Implement eventfd for PIO as well.
+ * --------------------------------------------------------------------
+ */
+
+static void
+ioeventfd_release(struct kernel_mshv_ioeventfd *p, u64 partition_id)
+{
+	if (p->doorbell_id > 0)
+		hv_unregister_doorbell(partition_id, p->doorbell_id);
+	eventfd_ctx_put(p->eventfd);
+	list_del(&p->list);
+	kfree(p);
+}
+
+/* MMIO writes trigger an event if the addr/val match */
+static void
+ioeventfd_mmio_write(int doorbell_id, void *data)
+{
+	struct mshv_partition *partition = (struct mshv_partition *)data;
+	struct kernel_mshv_ioeventfd *p;
+	unsigned long flags;
+
+	spin_lock_irqsave(&partition->ioeventfds.lock, flags);
+	list_for_each_entry(p, &partition->ioeventfds.items, list) {
+		if (p->doorbell_id == doorbell_id) {
+			eventfd_signal(p->eventfd, 1);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&partition->ioeventfds.lock, flags);
+}
+
+static bool
+ioeventfd_check_collision(struct mshv_partition *partition,
+			  struct kernel_mshv_ioeventfd *p)
+{
+	struct kernel_mshv_ioeventfd *_p;
+
+	list_for_each_entry(_p, &partition->ioeventfds.items, list)
+		if (_p->addr == p->addr && _p->length == p->length &&
+		    (_p->wildcard || p->wildcard ||
+		     _p->datamatch == p->datamatch))
+			return true;
+
+	return false;
+}
+
+static int
+mshv_assign_ioeventfd(struct mshv_partition *partition,
+		      struct mshv_ioeventfd *args)
+{
+	struct kernel_mshv_ioeventfd *p;
+	struct eventfd_ctx *eventfd;
+	u64 doorbell_flags = 0;
+	unsigned long irqflags;
+	int ret;
+
+	if (args->flags & MSHV_IOEVENTFD_FLAG_PIO)
+		return -EOPNOTSUPP;
+
+	/* must be natural-word sized */
+	switch (args->len) {
+	case 0:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_ANY;
+		break;
+	case 1:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE;
+		break;
+	case 2:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_WORD;
+		break;
+	case 4:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD;
+		break;
+	case 8:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD;
+		break;
+	default:
+		pr_warn("ioeventfd: invalid length specified\n");
+		return -EINVAL;
+	}
+
+	/* check for range overflow */
+	if (args->addr + args->len < args->addr)
+		return -EINVAL;
+
+	/* check for extra flags that we don't understand */
+	if (args->flags & ~MSHV_IOEVENTFD_VALID_FLAG_MASK)
+		return -EINVAL;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	INIT_LIST_HEAD(&p->list);
+	p->addr    = args->addr;
+	p->length  = args->len;
+	p->eventfd = eventfd;
+
+	/* The datamatch feature is optional, otherwise this is a wildcard */
+	if (args->flags & MSHV_IOEVENTFD_FLAG_DATAMATCH)
+		p->datamatch = args->datamatch;
+	else {
+		p->wildcard = true;
+		doorbell_flags |= HV_DOORBELL_FLAG_TRIGGER_ANY_VALUE;
+	}
+
+	spin_lock_irqsave(&partition->ioeventfds.lock, irqflags);
+
+	if (ioeventfd_check_collision(partition, p)) {
+		ret = -EEXIST;
+		goto unlock_fail;
+	}
+
+	ret = hv_register_doorbell(partition->id, ioeventfd_mmio_write,
+				   (void *)partition, p->addr,
+				   p->datamatch, doorbell_flags);
+	if (ret < 0) {
+		pr_err("Failed to register ioeventfd doorbell!\n");
+		goto unlock_fail;
+	}
+
+	p->doorbell_id = ret;
+	list_add_tail(&p->list, &partition->ioeventfds.items);
+
+	spin_unlock_irqrestore(&partition->ioeventfds.lock, irqflags);
+
+	return 0;
+
+unlock_fail:
+	spin_unlock_irqrestore(&partition->ioeventfds.lock, irqflags);
+
+	kfree(p);
+
+fail:
+	eventfd_ctx_put(eventfd);
+
+	return ret;
+}
+
+static int
+mshv_deassign_ioeventfd(struct mshv_partition *partition,
+			struct mshv_ioeventfd *args)
+{
+	struct kernel_mshv_ioeventfd *p, *tmp;
+	struct eventfd_ctx *eventfd;
+	unsigned long flags;
+	int ret = -ENOENT;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	spin_lock_irqsave(&partition->ioeventfds.lock, flags);
+
+	list_for_each_entry_safe(p, tmp, &partition->ioeventfds.items, list) {
+		bool wildcard = !(args->flags & MSHV_IOEVENTFD_FLAG_DATAMATCH);
+
+		if (p->eventfd != eventfd  ||
+		    p->addr != args->addr  ||
+		    p->length != args->len ||
+		    p->wildcard != wildcard)
+			continue;
+
+		if (!p->wildcard && p->datamatch != args->datamatch)
+			continue;
+
+		ioeventfd_release(p, partition->id);
+		ret = 0;
+		break;
+	}
+
+	spin_unlock_irqrestore(&partition->ioeventfds.lock, flags);
+
+	eventfd_ctx_put(eventfd);
+
+	return ret;
+}
+
+int
+mshv_ioeventfd(struct mshv_partition *partition,
+	       struct mshv_ioeventfd *args)
+{
+	/* PIO not yet implemented */
+	if (args->flags & MSHV_IOEVENTFD_FLAG_PIO)
+		return -EOPNOTSUPP;
+
+	if (args->flags & MSHV_IOEVENTFD_FLAG_DEASSIGN)
+		return mshv_deassign_ioeventfd(partition, args);
+
+	return mshv_assign_ioeventfd(partition, args);
+}
+
+void
+mshv_eventfd_init(struct mshv_partition *partition)
+{
+	spin_lock_init(&partition->irqfds.lock);
+	INIT_LIST_HEAD(&partition->irqfds.items);
+
+	spin_lock_init(&partition->ioeventfds.lock);
+	INIT_LIST_HEAD(&partition->ioeventfds.items);
+}
+
+void
+mshv_eventfd_release(struct mshv_partition *partition)
+{
+	struct kernel_mshv_ioeventfd *p, *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&partition->ioeventfds.lock, flags);
+	list_for_each_entry_safe(p, tmp, &partition->ioeventfds.items, list) {
+		ioeventfd_release(p, partition->id);
+	}
+	spin_unlock_irqrestore(&partition->ioeventfds.lock, flags);
+
+	mshv_irqfd_release(partition);
+}
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index e124119e65eb..e1caecd27f09 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -828,6 +828,18 @@ mshv_partition_ioctl_assert_interrupt(struct mshv_partition *partition,
 			args.control);
 }
 
+static long
+mshv_partition_ioctl_ioeventfd(struct mshv_partition *partition,
+		void __user *user_args)
+{
+	struct mshv_ioeventfd args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return mshv_ioeventfd(partition, &args);
+}
+
 static long
 mshv_partition_ioctl_irqfd(struct mshv_partition *partition,
 		void __user *user_args)
@@ -882,6 +894,10 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		ret = mshv_partition_ioctl_irqfd(partition,
 						 (void __user *)arg);
 		break;
+	case MSHV_IOEVENTFD:
+		ret = mshv_partition_ioctl_ioeventfd(partition,
+						 (void __user *)arg);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
@@ -972,7 +988,7 @@ mshv_partition_release(struct inode *inode, struct file *filp)
 {
 	struct mshv_partition *partition = filp->private_data;
 
-	mshv_irqfd_release(partition);
+	mshv_eventfd_release(partition);
 
 	mshv_partition_put(partition);
 
@@ -1068,7 +1084,7 @@ mshv_ioctl_create_partition(void __user *user_arg)
 
 	fd_install(fd, file);
 
-	mshv_irqfd_init(partition);
+	mshv_eventfd_init(partition);
 
 	return fd;
 
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index 5707c457b72d..217c91725828 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -52,6 +52,10 @@ struct mshv_partition {
 		spinlock_t        lock;
 		struct list_head  items;
 	} irqfds;
+	struct {
+		spinlock_t        lock;
+		struct list_head items;
+	} ioeventfds;
 };
 
 struct mshv_lapic_irq {
diff --git a/include/linux/mshv_eventfd.h b/include/linux/mshv_eventfd.h
index 3e7b16d0717f..fd0012f72616 100644
--- a/include/linux/mshv_eventfd.h
+++ b/include/linux/mshv_eventfd.h
@@ -1,7 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *
- * irqfd: Allows an fd to be used to inject an interrupt to the guest
+ * irqfd: Allows an fd to be used to inject an interrupt to the guest.
+ * ioeventfd: Allow an fd to be used to receive a signal from the guest.
  * All credit goes to kvm developers.
  */
 
@@ -11,6 +12,9 @@
 #include <linux/mshv.h>
 #include <linux/poll.h>
 
+void mshv_eventfd_init(struct mshv_partition *partition);
+void mshv_eventfd_release(struct mshv_partition *partition);
+
 struct mshv_kernel_irqfd {
 	struct mshv_partition     *partition;
 	struct eventfd_ctx        *eventfd;
@@ -26,10 +30,19 @@ struct mshv_kernel_irqfd {
 int mshv_irqfd(struct mshv_partition *partition,
 		struct mshv_irqfd *args);
 
-void mshv_irqfd_init(struct mshv_partition *partition);
-void mshv_irqfd_release(struct mshv_partition *partition);
-
 int mshv_irqfd_wq_init(void);
 void mshv_irqfd_wq_cleanup(void);
 
+struct kernel_mshv_ioeventfd {
+	struct list_head     list;
+	u64                  addr;
+	int                  length;
+	struct eventfd_ctx  *eventfd;
+	u64                  datamatch;
+	int                  doorbell_id;
+	bool                 wildcard;
+};
+
+int mshv_ioeventfd(struct mshv_partition *kvm, struct mshv_ioeventfd *args);
+
 #endif /* __LINUX_MSHV_EVENTFD_H */
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 792844276134..e32dee679360 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -93,6 +93,29 @@ struct mshv_irqfd {
 	__u8  pad[2];
 };
 
+enum {
+	mshv_ioeventfd_flag_nr_datamatch,
+	mshv_ioeventfd_flag_nr_pio,
+	mshv_ioeventfd_flag_nr_deassign,
+	mshv_ioeventfd_flag_nr_max,
+};
+
+#define MSHV_IOEVENTFD_FLAG_DATAMATCH (1 << mshv_ioeventfd_flag_nr_datamatch)
+#define MSHV_IOEVENTFD_FLAG_PIO       (1 << mshv_ioeventfd_flag_nr_pio)
+#define MSHV_IOEVENTFD_FLAG_DEASSIGN  (1 << mshv_ioeventfd_flag_nr_deassign)
+
+#define MSHV_IOEVENTFD_VALID_FLAG_MASK  ((1 << mshv_ioeventfd_flag_nr_max) - 1)
+
+struct mshv_ioeventfd {
+	__u64 datamatch;
+	__u64 addr;        /* legal pio/mmio address */
+	__u32 len;         /* 1, 2, 4, or 8 bytes    */
+	__s32 fd;
+	__u32 flags;
+	__u8  pad[4];
+};
+
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
@@ -109,7 +132,8 @@ struct mshv_irqfd {
 				_IOW(MSHV_IOCTL, 0xC, struct mshv_partition_property)
 #define MSHV_GET_PARTITION_PROPERTY \
 				_IOWR(MSHV_IOCTL, 0xD, struct mshv_partition_property)
-#define MSHV_IRQFD              _IOW(MSHV_IOCTL, 0xE, struct mshv_irqfd)
+#define MSHV_IRQFD		_IOW(MSHV_IOCTL, 0xE, struct mshv_irqfd)
+#define MSHV_IOEVENTFD		_IOW(MSHV_IOCTL, 0xF, struct mshv_ioeventfd)
 
 /* vp device */
 #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
-- 
2.25.1

