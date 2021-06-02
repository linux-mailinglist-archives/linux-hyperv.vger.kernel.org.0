Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D995399171
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFBRXA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:23:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51214 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhFBRWz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:55 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 48B3B20B8027;
        Wed,  2 Jun 2021 10:21:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48B3B20B8027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654472;
        bh=OWsnzgw6kc9j7w5nSEy/i27W92+i9kzayVieRd6mr+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/pbQDPHkq9E2FFTryPIp6AQ/kcAjFHrvYq61j3LQFi9XNVg5LeoFCB08NOrQ2jOx
         drl2VEMTucVnTOHkbF8hkM4GDJRo8n/vZe/7OLNeP3aoJ6jwkoWjWRnE+xQiuYRQOf
         VSrNzF2xvffBdnP76Fc/8SCJmOEzjFjoUZait4z8=
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
Subject: [PATCH 16/17] mshv: User space controlled MSI irq routing for mshv
Date:   Wed,  2 Jun 2021 17:21:01 +0000
Message-Id: <40818b1c53e91732fa77025f47cbee9d40684923.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implementation of an in-kernel MSI irq routing mechanism for mshv.

Inspired from the KVM irq routing implementation but adapted
only for MSI interrupts.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=399ec807ddc38ecccf8c06dbde04531cbdc63e11

All credit goes to kvm developers.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/Makefile       |   2 +-
 drivers/hv/mshv_main.c    |  34 ++++++++++
 drivers/hv/mshv_msi.c     | 127 ++++++++++++++++++++++++++++++++++++++
 include/linux/mshv.h      |  27 ++++++++
 include/uapi/linux/mshv.h |  13 ++++
 5 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hv/mshv_msi.c

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 5cb738c10a2d..370d126252ef 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -14,4 +14,4 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
 
 mshv-y                          += mshv_main.o hv_call.o hv_synic.o hv_portid_table.o  \
-					hv_eventfd.o
+					hv_eventfd.o mshv_msi.o
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 0f083447c553..f7ca0f082b75 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -852,6 +852,35 @@ mshv_partition_ioctl_irqfd(struct mshv_partition *partition,
 	return mshv_irqfd(partition, &args);
 }
 
+static long
+mshv_partition_ioctl_set_msi_routing(struct mshv_partition *partition,
+		void __user *user_args)
+{
+	struct mshv_msi_routing_entry *entries = NULL;
+	struct mshv_msi_routing args;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.nr > MSHV_MAX_MSI_ROUTES)
+		return -EINVAL;
+
+	if (args.nr) {
+		struct mshv_msi_routing __user *urouting = user_args;
+
+		entries = vmemdup_user(urouting->entries,
+				       array_size(sizeof(*entries),
+					       args.nr));
+		if (IS_ERR(entries))
+			return PTR_ERR(entries);
+	}
+	ret = mshv_set_msi_routing(partition, entries, args.nr);
+	kvfree(entries);
+
+	return ret;
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -898,6 +927,10 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		ret = mshv_partition_ioctl_ioeventfd(partition,
 						 (void __user *)arg);
 		break;
+	case MSHV_SET_MSI_ROUTING:
+		ret = mshv_partition_ioctl_set_msi_routing(partition,
+							   (void __user *)arg);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
@@ -965,6 +998,7 @@ destroy_partition(struct mshv_partition *partition)
 		vfree(region->pages);
 	}
 
+	mshv_free_msi_routing(partition);
 	kfree(partition);
 }
 
diff --git a/drivers/hv/mshv_msi.c b/drivers/hv/mshv_msi.c
new file mode 100644
index 000000000000..ae25ed8dfef4
--- /dev/null
+++ b/drivers/hv/mshv_msi.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, Microsoft Corporation.
+ *
+ * Authors:
+ *   Vineeth Remanan Pillai <viremana@linux.microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/mshv.h>
+#include <linux/mshv_eventfd.h>
+#include <linux/hyperv.h>
+#include <asm/mshyperv.h>
+
+#include "mshv.h"
+
+MODULE_AUTHOR("Microsoft");
+MODULE_LICENSE("GPL");
+
+int mshv_set_msi_routing(struct mshv_partition *partition,
+		const struct mshv_msi_routing_entry *ue,
+		unsigned int nr)
+{
+	struct mshv_msi_routing_table *new = NULL, *old;
+	u32 i, nr_rt_entries = 0;
+	int r = 0;
+
+	if (nr == 0)
+		goto swap_routes;
+
+	for (i = 0; i < nr; i++) {
+		if (ue[i].gsi >= MSHV_MAX_MSI_ROUTES)
+			return -EINVAL;
+
+		if (ue[i].address_hi)
+			return -EINVAL;
+
+		nr_rt_entries = max(nr_rt_entries, ue[i].gsi);
+	}
+	nr_rt_entries += 1;
+
+	new = kzalloc(struct_size(new, entries, nr_rt_entries),
+		      GFP_KERNEL_ACCOUNT);
+	if (!new)
+		return -ENOMEM;
+
+	new->nr_rt_entries = nr_rt_entries;
+	for (i = 0; i < nr; i++) {
+		struct mshv_kernel_msi_routing_entry *e;
+
+		e = &new->entries[ue[i].gsi];
+
+		/*
+		 * Allow only one to one mapping between GSI and MSI routing.
+		 */
+		if (e->gsi != 0) {
+			r = -EINVAL;
+			goto out;
+		}
+
+		e->gsi = ue[i].gsi;
+		e->address_lo = ue[i].address_lo;
+		e->address_hi = ue[i].address_hi;
+		e->data = ue[i].data;
+		e->entry_valid = true;
+	}
+
+swap_routes:
+	spin_lock(&partition->irq_lock);
+	old = rcu_dereference_protected(partition->msi_routing, 1);
+	rcu_assign_pointer(partition->msi_routing, new);
+	spin_unlock(&partition->irq_lock);
+
+	synchronize_srcu_expedited(&partition->irq_srcu);
+	new = old;
+
+out:
+	kfree(new);
+
+	return r;
+}
+
+void mshv_free_msi_routing(struct mshv_partition *partition)
+{
+	/*
+	 * Called only during vm destruction.
+	 * Nobody can use the pointer at this stage
+	 */
+	struct mshv_msi_routing_table *rt = rcu_access_pointer(partition->msi_routing);
+
+	kfree(rt);
+}
+
+struct mshv_kernel_msi_routing_entry
+mshv_msi_map_gsi(struct mshv_partition *partition, u32 gsi)
+{
+	struct mshv_kernel_msi_routing_entry entry = { 0 };
+	struct mshv_msi_routing_table *msi_rt;
+
+	msi_rt = srcu_dereference_check(partition->msi_routing,
+					&partition->irq_srcu,
+					lockdep_is_held(&partition->irq_lock));
+	if (!msi_rt) {
+		pr_warn("No valid routing information found for gsi: %u\n",
+			gsi);
+		entry.gsi = gsi;
+		return entry;
+	}
+
+	return msi_rt->entries[gsi];
+}
+
+void mshv_set_msi_irq(struct mshv_kernel_msi_routing_entry *e,
+		      struct mshv_lapic_irq *irq)
+{
+	memset(irq, 0, sizeof(*irq));
+	if (!e || !e->entry_valid)
+		return;
+
+	irq->vector = e->data & 0xFF;
+	irq->apic_id = (e->address_lo >> 12) & 0xFF;
+	irq->control.interrupt_type = (e->data & 0x700) >> 8;
+	irq->control.level_triggered = (e->data >> 15) & 0x1;
+	irq->control.logical_dest_mode = (e->address_lo >> 2) & 0x1;
+}
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index 5968b49b9c27..ec349be0ba91 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -69,6 +69,7 @@ struct mshv_partition {
 		spinlock_t        lock;
 		struct list_head items;
 	} ioeventfds;
+	struct mshv_msi_routing_table __rcu *msi_routing;
 };
 
 struct mshv_lapic_irq {
@@ -77,6 +78,32 @@ struct mshv_lapic_irq {
 	union hv_interrupt_control control;
 };
 
+#define MSHV_MAX_MSI_ROUTES		4096
+
+struct mshv_kernel_msi_routing_entry {
+	u32 entry_valid;
+	u32 gsi;
+	u32 address_lo;
+	u32 address_hi;
+	u32 data;
+};
+
+struct mshv_msi_routing_table {
+	u32 nr_rt_entries;
+	struct mshv_kernel_msi_routing_entry entries[];
+};
+
+int mshv_set_msi_routing(struct mshv_partition *partition,
+		const struct mshv_msi_routing_entry *entries,
+		unsigned int nr);
+void mshv_free_msi_routing(struct mshv_partition *partition);
+
+struct mshv_kernel_msi_routing_entry mshv_msi_map_gsi(
+		struct mshv_partition *partition, u32 gsi);
+
+void mshv_set_msi_irq(struct mshv_kernel_msi_routing_entry *e,
+		      struct mshv_lapic_irq *irq);
+
 struct hv_synic_pages {
 	struct hv_message_page *synic_message_page;
 	struct hv_synic_event_flags_page *synic_event_flags_page;
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 008e68bde56d..ac58f2ded79c 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -117,6 +117,18 @@ struct mshv_ioeventfd {
 	__u8  pad[4];
 };
 
+struct mshv_msi_routing_entry {
+	__u32 gsi;
+	__u32 address_lo;
+	__u32 address_hi;
+	__u32 data;
+};
+
+struct mshv_msi_routing {
+	__u32 nr;
+	__u32 pad;
+	struct mshv_msi_routing_entry entries[0];
+};
 
 #define MSHV_IOCTL 0xB8
 
@@ -136,6 +148,7 @@ struct mshv_ioeventfd {
 				_IOWR(MSHV_IOCTL, 0xD, struct mshv_partition_property)
 #define MSHV_IRQFD		_IOW(MSHV_IOCTL, 0xE, struct mshv_irqfd)
 #define MSHV_IOEVENTFD		_IOW(MSHV_IOCTL, 0xF, struct mshv_ioeventfd)
+#define MSHV_SET_MSI_ROUTING	_IOW(MSHV_IOCTL, 0x11, struct mshv_msi_routing)
 
 /* vp device */
 #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
-- 
2.25.1

