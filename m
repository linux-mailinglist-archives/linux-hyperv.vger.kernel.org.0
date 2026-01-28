Return-Path: <linux-hyperv+bounces-8566-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH5JEFxLemkp5AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8566-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 18:46:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 937CBA719B
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 18:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 934E1301FFBB
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C04F3542C7;
	Wed, 28 Jan 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rkmMIl3B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A529A9C8;
	Wed, 28 Jan 2026 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622129; cv=none; b=f1GtWX1I+9RBY+nxxtyxrVkfNva4PNlf5GyPQJ4Jm3t3GaLL9Roi8Cdk6jOtcjrvdms8yEIzAmqiNNdxCueQqPRm//ZjP0zUjT2b0IXqfTSeCiJnFvVJxF03sHGI5bESk/8PVnbhz1vMPecrKsmwzgroogND8zHOUj7NnllsOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622129; c=relaxed/simple;
	bh=R728GykT0mKk50EI7t7Rs5ypSNVoxAjP4JNh5WmKO5A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbtRhF2kiCWuFYicfmokz6gUZsNxYq4PSfynlMm/oTdfubKgTpo0sMM11UKmsMbt4RJUDZu1tVqI93IHAX06o67diSnERumBh1lKj8Fw0e/+Zk/bDEg9T3aYO/oBTCiQfqGbTQmgv8mcRd3Y9Z2zGE+aZETNPFW421MO648b5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rkmMIl3B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8FBDC20B7168;
	Wed, 28 Jan 2026 09:42:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FBDC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769622127;
	bh=LAi9zJZG2jIStnXGpjhMs6XHFN9PFCQr6KHu2s3Qv/k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rkmMIl3BMIcBgMcsyuKgX0on3Z/2qKHfMABno5E2iXeAshGVEh5p1APYQsqiLLlmo
	 EhwMoM85GSZ2brEiSKrTBB064iTxzCJVB9p2tisEScmyhDfbKD+O+QWRBNDHa4+Q/6
	 ++p6lj9YL2zSkgWtxk+8fXGe0+3AbBBJGZ9KvMQI=
Subject: [PATCH 2/2] mshv: Add kexec blocking support
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 28 Jan 2026 17:42:07 +0000
Message-ID: 
 <176962212724.85424.5690118672585914211.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8566-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 937CBA719B
X-Rspamd-Action: no action

Add kexec notifier to prevent kexec when VMs are active or memory
is deposited. The notifier blocks kexec operations if:
- Active VMs exist in the partition table
- Pages are still deposited to the hypervisor

The kernel cannot access hypervisor deposited pages: any access
triggers a GPF. Until the deposited page state can be handed over
to the next kernel, kexec must be blocked if there is any shared
state between kernel and hypervisor.

For L1 host virtualization, attempt to withdraw all deposited memory before
allowing kexec to proceed. If withdrawal fails or pages remain deposited
block the kexec operation.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/Makefile            |    1 +
 drivers/hv/hv_proc.c           |    4 ++
 drivers/hv/mshv_kexec.c        |   66 ++++++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h         |   14 ++++++++
 drivers/hv/mshv_root_hv_call.c |    2 +
 drivers/hv/mshv_root_main.c    |    7 ++++
 6 files changed, 94 insertions(+)
 create mode 100644 drivers/hv/mshv_kexec.c

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index a49f93c2d245..bb72be5cc525 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -15,6 +15,7 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
 	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
+mshv_root-$(CONFIG_KEXEC) += mshv_kexec.o
 mshv_vtl-y := mshv_vtl_main.o
 
 # Code that must be built-in
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 89870c1b0087..39bbbedb0340 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -15,6 +15,8 @@
  */
 #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
 
+atomic_t hv_pages_deposited;
+
 /* Deposits exact number of pages. Must be called with interrupts enabled.  */
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 {
@@ -93,6 +95,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 		goto err_free_allocations;
 	}
 
+	atomic_add(page_count, &hv_pages_deposited);
+
 	ret = 0;
 	goto free_buf;
 
diff --git a/drivers/hv/mshv_kexec.c b/drivers/hv/mshv_kexec.c
new file mode 100644
index 000000000000..5222b2e4ff97
--- /dev/null
+++ b/drivers/hv/mshv_kexec.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Microsoft Corporation.
+ *
+ * Live update orchestration management for mshv_root module.
+ *
+ * Author: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
+ */
+
+#include <linux/kexec.h>
+#include <linux/notifier.h>
+#include <asm/mshyperv.h>
+#include "mshv_root.h"
+
+static BLOCKING_NOTIFIER_HEAD(overlay_notify_chain);
+
+static int mshv_block_kexec_notify(struct notifier_block *nb,
+				   unsigned long action, void *arg)
+{
+	if (!hash_empty(mshv_root.pt_htable)) {
+		pr_warn("mshv: Cannot perform kexec while VMs are active\n");
+		return -EBUSY;
+	}
+
+	if (hv_l1vh_partition()) {
+		int err;
+
+		/* Attempt to withdraw all the deposited pages */
+		err = hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE,
+					      hv_current_partition_id);
+		if (err) {
+			pr_err("mshv: Failed to withdraw memory from L1 virtualization: %d\n",
+			       err);
+			return err;
+		}
+	}
+
+	if (atomic_read(&hv_pages_deposited)) {
+		pr_warn("mshv: Cannot perform kexec while pages are deposited\n");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static struct notifier_block mshv_kexec_notifier = {
+	.notifier_call = mshv_block_kexec_notify,
+};
+
+int __init mshv_kexec_init(void)
+{
+	int err;
+
+	err = kexec_block_notifier_register(&mshv_kexec_notifier);
+	if (err) {
+		pr_err("mshv: Could not register kexec notifier: %pe\n",
+		       ERR_PTR(err));
+		return err;
+	}
+
+	return 0;
+}
+
+void __exit mshv_kexec_exit(void)
+{
+	(void)kexec_block_notifier_unregister(&mshv_kexec_notifier);
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 3c1d88b36741..311f76262d10 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -17,6 +17,7 @@
 #include <linux/build_bug.h>
 #include <linux/mmu_notifier.h>
 #include <uapi/linux/mshv.h>
+#include <hyperv/hvhdk.h>
 
 /*
  * Hypervisor must be between these version numbers (inclusive)
@@ -319,6 +320,7 @@ int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 a
 extern struct mshv_root mshv_root;
 extern enum hv_scheduler_type hv_scheduler_type;
 extern u8 * __percpu *hv_synic_eventring_tail;
+extern atomic_t hv_pages_deposited;
 
 struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 					   u64 uaddr, u32 flags);
@@ -333,4 +335,16 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 
+#if IS_ENABLED(CONFIG_KEXEC)
+int mshv_kexec_init(void);
+void mshv_kexec_exit(void);
+#else
+static inline int mshv_kexec_init(void)
+{
+	return 0;
+}
+
+static inline void mshv_kexec_exit(void) { }
+#endif
+
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 06f2bac8039d..4203af5190ee 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -73,6 +73,8 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 		for (i = 0; i < completed; i++)
 			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
 
+		atomic_sub(completed, &hv_pages_deposited);
+
 		if (!hv_result_success(status)) {
 			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
 				status = HV_STATUS_SUCCESS;
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 5fc572e31cd7..d55aa69d130c 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2330,6 +2330,10 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto deinit_root_scheduler;
 
+	ret = mshv_kexec_init();
+	if (ret)
+		goto deinit_irqfd_wq;
+
 	spin_lock_init(&mshv_root.pt_ht_lock);
 	hash_init(mshv_root.pt_htable);
 
@@ -2337,6 +2341,8 @@ static int __init mshv_parent_partition_init(void)
 
 	return 0;
 
+deinit_irqfd_wq:
+	mshv_irqfd_wq_cleanup();
 deinit_root_scheduler:
 	root_scheduler_deinit();
 exit_partition:
@@ -2356,6 +2362,7 @@ static void __exit mshv_parent_partition_exit(void)
 	hv_setup_mshv_handler(NULL);
 	mshv_port_table_fini();
 	misc_deregister(&mshv_dev);
+	mshv_kexec_exit();
 	mshv_irqfd_wq_cleanup();
 	root_scheduler_deinit();
 	if (hv_root_partition())



