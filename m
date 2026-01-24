Return-Path: <linux-hyperv+bounces-8519-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K1/AqASdWkAAgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8519-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 19:42:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF67E81A
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 19:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D57DA3005A9C
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 18:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6F61E9B3F;
	Sat, 24 Jan 2026 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i4zAoeb2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D2724DD1F;
	Sat, 24 Jan 2026 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280148; cv=none; b=FWRi7+aZxjBLc6ts3Wv5grxu6kDw296slIYkL4bMsFzGhj5lLGoglpTEpM1fCLdjGW7eavGjTl6jgq9BgzoXVXTmE50c1SMnwNosMsBNK/y4MmjXkrIvlJOHLoR3Tfl5lkn1rASBOpd59daZWQXudx3l/R9d/XHrlbimcsB04mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280148; c=relaxed/simple;
	bh=b+niw3TVr453DSg14YIFxGYb597QXQrLNKcj+epc9lc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khmtdUYQI9xuT6v4dLRD03wo9NXZI2VuOtqyms2rvKdRfKbscBR5IWbWGLcN9i7qrFUATD07aKDJV1G1X2umFUFwdpG2u/1U6ObNKRyDaSNU3HtPe7Qd6j5q9bNdgGtP0a5WTFSZW1oiJuD9k877DwpVY9++TX+dnV0KmGmDPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i4zAoeb2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80FA920B7165;
	Sat, 24 Jan 2026 10:42:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80FA920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769280146;
	bh=h308bi5+er73P7cw3kjDIHF43wragB3maCUn3DZmXH4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=i4zAoeb27vsjnLg0dH3yFaNvZEfnOZ9ZsykC0uCUxQ+PK7WXnmxeeqNlmZlu7tocj
	 oBhJaX1hI7hBF9Dl3nrB+y1hEWRepuy/Sz9BZlLPrXc85PBh6dFFzYryUnCN725lR0
	 Ct23NK86tNPMpB9tdo73JDOiTzTuaDSry9Zm4dUo=
Subject: [RFC PATCH 3/3] mshv: Block kexec when hypervisor has pages deposited
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 24 Jan 2026 18:42:26 +0000
Message-ID: 
 <176928014633.26405.12867581880963943842.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176927917602.26405.4149319776242398706.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176927917602.26405.4149319776242398706.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8519-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 9EDF67E81A
X-Rspamd-Action: no action

Use the live update infrastructure to make kexec safe when Microsoft
Hypervisor is active.

The kernel cannot access hypervisor-deposited pages; any access triggers a
GPF. Until the deposited-page state can be handed over to the next kernel,
kexec must be blocked is there is any hsared state between kernel and
hypervisor.

During the freeze stage:
- Refuse the transition while VMs are running
- Withdraw all pages from L1VH host (guest pages are withdrawn
  upon guest shutdown)
- Verify no deposited pages remain

Abort kexec if any of the above checks fail.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 MAINTAINERS                  |    1 
 drivers/hv/Kconfig           |    1 
 drivers/hv/Makefile          |    1 
 drivers/hv/mshv_luo.c        |  113 ++++++++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h       |   13 +++++
 drivers/hv/mshv_root_main.c  |    7 +++
 include/linux/kho/abi/mshv.h |   14 +++++
 7 files changed, 150 insertions(+)
 create mode 100644 drivers/hv/mshv_luo.c
 create mode 100644 include/linux/kho/abi/mshv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..d625a1c111e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11756,6 +11756,7 @@ F:	include/hyperv/hvgdk_mini.h
 F:	include/hyperv/hvhdk.h
 F:	include/hyperv/hvhdk_mini.h
 F:	include/linux/hyperv.h
+F:	include/linux/kho/abi/mshv.h
 F:	include/net/mana
 F:	include/uapi/linux/hyperv.h
 F:	include/uapi/rdma/mana-abi.h
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 7937ac0cbd0f..94887b8b92b5 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -78,6 +78,7 @@ config MSHV_ROOT
 	select VIRT_XFER_TO_GUEST_WORK
 	select HMM_MIRROR
 	select MMU_NOTIFIER
+	select LIVEUPDATE
 	default n
 	help
 	  Select this option to enable support for booting and running as root
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index a49f93c2d245..73258fb811eb 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -15,6 +15,7 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
 	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
+mshv_root-$(CONFIG_LIVEUPDATE) += mshv_luo.o
 mshv_vtl-y := mshv_vtl_main.o
 
 # Code that must be built-in
diff --git a/drivers/hv/mshv_luo.c b/drivers/hv/mshv_luo.c
new file mode 100644
index 000000000000..eed7755fc27e
--- /dev/null
+++ b/drivers/hv/mshv_luo.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Microsoft Corporation.
+ *
+ * Live update orchestration management for mshv_root module.
+ *
+ * Author: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/liveupdate.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kho/abi/mshv.h>
+#include <asm/mshyperv.h>
+#include "mshv_root.h"
+
+static struct file *mshv_luo_file;
+
+static void mshv_luo_finish(struct liveupdate_file_op_args *args)
+{
+}
+
+static int mshv_luo_retrieve(struct liveupdate_file_op_args *args)
+{
+	return 0;
+}
+
+static int mshv_luo_freeze(struct liveupdate_file_op_args *args)
+{
+	if (!hash_empty(mshv_root.pt_htable)) {
+		pr_warn("mshv: Cannot perform live update while VMs are active\n");
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
+			pr_err("mshv: Failed to withdraw memory from L1 virtualization: %d\n", err);
+			return err;
+		}
+	}
+
+	if (atomic_read(&hv_pages_deposited)) {
+		pr_warn("mshv: Cannot perform live update while pages are deposited\n");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static void mshv_luo_unpreserve(struct liveupdate_file_op_args *args)
+{
+}
+
+static int mshv_luo_preserve(struct liveupdate_file_op_args *args)
+{
+	return 0;
+}
+
+static bool mshv_luo_can_preserve(struct liveupdate_file_handler *handler,
+				  struct file *file)
+{
+	return file == mshv_luo_file;
+}
+
+static const struct liveupdate_file_ops mshv_luo_file_ops = {
+	.can_preserve = mshv_luo_can_preserve,
+	.preserve = mshv_luo_preserve,
+	.unpreserve = mshv_luo_unpreserve,
+	.retrieve = mshv_luo_retrieve,
+	.freeze = mshv_luo_freeze,
+	.finish = mshv_luo_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler mshv_luo_handler = {
+	.ops = &mshv_luo_file_ops,
+	.compatible = MSHV_LUO_FH_COMPATIBLE,
+};
+
+int __init mshv_luo_init(void)
+{
+	int err;
+
+	err = liveupdate_register_file_handler(&mshv_luo_handler);
+	if (err && err != -EOPNOTSUPP) {
+		pr_err("Could not register luo filesystem handler: %pe\n",
+		       ERR_PTR(err));
+		return err;
+	}
+
+	err = liveupdate_session_create("mshv_root", &mshv_luo_file);
+	if (err)
+		goto err_session;
+
+	pr_info("mshv_root live update handler registered\n");
+	return 0;
+
+err_session:
+	liveupdate_unregister_file_handler(&mshv_luo_handler);
+	return err;
+}
+
+void __exit mshv_luo_exit(void)
+{
+	if (mshv_luo_file)
+		fput(mshv_luo_file);
+	liveupdate_unregister_file_handler(&mshv_luo_handler);
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index c792afce0839..89d5ece0b538 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -17,6 +17,7 @@
 #include <linux/build_bug.h>
 #include <linux/mmu_notifier.h>
 #include <uapi/linux/mshv.h>
+#include <hyperv/hvhdk.h>
 
 /*
  * Hypervisor must be between these version numbers (inclusive)
@@ -334,4 +335,16 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 
+#if IS_ENABLED(CONFIG_LIVEUPDATE)
+int __init mshv_luo_init(void);
+void __exit mshv_luo_exit(void);
+#else
+static inline int mshv_luo_init(void)
+{
+	return 0;
+}
+
+static inline void mshv_luo_exit(void) { }
+#endif
+
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 5fc572e31cd7..c0274bbc65ac 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2330,6 +2330,10 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto deinit_root_scheduler;
 
+	ret = mshv_luo_init();
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
+	mshv_luo_exit();
 	mshv_irqfd_wq_cleanup();
 	root_scheduler_deinit();
 	if (hv_root_partition())
diff --git a/include/linux/kho/abi/mshv.h b/include/linux/kho/abi/mshv.h
new file mode 100644
index 000000000000..e6ae5a731802
--- /dev/null
+++ b/include/linux/kho/abi/mshv.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, Microsoft Corporation.
+ *
+ * Author: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_MSHV_H
+#define _LINUX_KHO_ABI_MSHV_H
+
+/* The compatibility string for mshv file handler */
+#define MSHV_LUO_FH_COMPATIBLE "mshv-v1"
+
+#endif /* _LINUX_KHO_ABI_MSHV_H */



