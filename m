Return-Path: <linux-hyperv+bounces-8427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDNKCoxMcWkahAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8427-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:00:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EA03A5E6BE
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A3A67CE4F4
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 21:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CA43E49B;
	Wed, 21 Jan 2026 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OlGQH+MH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD152FD1DA;
	Wed, 21 Jan 2026 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031993; cv=none; b=GYv5AukfuurGXRcVBoccX9J0OznXFK1szUDOf9cVYXI/uyqrpp3YDLA3le4/FSaPYvZba3cqgjodnY3j4y059Z0bQt6TjBn53VxuxK/nf9IVW2nG87AH8B//FFawxRlWGuIZRWjMS6ovz1F3LytFDTWi53QfGtDoJEU0DuHknKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031993; c=relaxed/simple;
	bh=bMUQ6ErW4LOyMWnPhlhxytQKZWAZbrPqcv6+wXmvreo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W79U1g/q1i0QZuVOGwrqSk6P5ejFGR2phgtyNbfVYi8s5VDbdDIclETIg00ajRWqwalRQeplUkKz1Mrn/6iIfwqbLdG22FqlIe50TcwqOqVFcHy++kD/AmN6XRRi8G+U+5y1mf0YqdhY2tUHfl506jw1reJpj7ZxcuxnqUJA5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OlGQH+MH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 2E35620B7170; Wed, 21 Jan 2026 13:46:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E35620B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769031988;
	bh=KBX4kwJtyNLfS1S3utv19rfljBaM7TnrgHAZ8VX2LXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OlGQH+MHRwOXqP4YQD6m2xeB/ADiNDdWKhsVlGTTAFEYHm1tv+BuYXb/k+C/xuJQZ
	 T6DnX3abuuKAKCf+IlVxrJOxothYtbwGdLXQIEYvSbqgI90yJMv71EnaQyp1lCnSBf
	 m+bWfDkM1XbAvmIC/+l8Uc2s6W2JgcfgEXASGSng=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Jinank Jain <jinankjain@microsoft.com>
Subject: [PATCH v4 7/7] mshv: Add debugfs to view hypervisor statistics
Date: Wed, 21 Jan 2026 13:46:23 -0800
Message-ID: <20260121214623.76374-8-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8427-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: EA03A5E6BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce a debugfs interface to expose root and child partition stats
when running with mshv_root.

Create a debugfs directory "mshv" containing 'stats' files organized by
type and id. A stats file contains a number of counters depending on
its type. e.g. an excerpt from a VP stats file:

TotalRunTime                  : 1997602722
HypervisorRunTime             : 649671371
RemoteNodeRunTime             : 0
NormalizedRunTime             : 1997602721
IdealCpu                      : 0
HypercallsCount               : 1708169
HypercallsTime                : 111914774
PageInvalidationsCount        : 0
PageInvalidationsTime         : 0

On a root partition with some active child partitions, the entire
directory structure may look like:

mshv/
  stats             # hypervisor stats
  lp/               # logical processors
    0/              # LP id
      stats         # LP 0 stats
    1/
    2/
    3/
  partition/        # partition stats
    1/              # root partition id
      stats         # root partition stats
      vp/           # root virtual processors
        0/          # root VP id
          stats     # root VP 0 stats
        1/
        2/
        3/
    42/             # child partition id
      stats         # child partition stats
      vp/           # child VPs
        0/          # child VP id
          stats     # child VP 0 stats
        1/
    43/
    55/

On L1VH, some stats are not present as it does not own the hardware
like the root partition does:
- The hypervisor and lp stats are not present
- L1VH's partition directory is named "self" because it can't get its
  own id
- Some of L1VH's partition and VP stats fields are not populated, because
  it can't map its own HV_STATS_AREA_PARENT page.

Co-developed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Co-developed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Co-developed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Co-developed-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/Makefile         |   1 +
 drivers/hv/hv_counters.c    |   1 +
 drivers/hv/hv_synic.c       | 177 +++++++++
 drivers/hv/mshv_debugfs.c   | 703 ++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h      |  34 ++
 drivers/hv/mshv_root_main.c |  26 +-
 6 files changed, 940 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hv/hv_synic.c
 create mode 100644 drivers/hv/mshv_debugfs.c

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index a49f93c2d245..2593711c3628 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -15,6 +15,7 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
 	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
+mshv_root-$(CONFIG_DEBUG_FS) += mshv_debugfs.o
 mshv_vtl-y := mshv_vtl_main.o
 
 # Code that must be built-in
diff --git a/drivers/hv/hv_counters.c b/drivers/hv/hv_counters.c
index a8e07e72cc29..45ff3d663e56 100644
--- a/drivers/hv/hv_counters.c
+++ b/drivers/hv/hv_counters.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2026, Microsoft Corporation.
  *
  * Data for printing stats page counters via debugfs.
+ * Included directly in mshv_debugfs.c.
  *
  * Authors: Microsoft Linux virtualization team
  */
diff --git a/drivers/hv/hv_synic.c b/drivers/hv/hv_synic.c
new file mode 100644
index 000000000000..cc81d78887f2
--- /dev/null
+++ b/drivers/hv/hv_synic.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Microsoft Corporation.
+ *
+ * Authors: Microsoft Linux virtualization team
+ */
+
+/*
+	root	l1vh	vtl
+vmbus
+
+guest
+vmbus, nothing else
+
+vtl
+mshv_vtl uses intercept SINT, VTL2_VMBUS_SINT_INDEX (7, not in hvgdk_mini lol)
+vmbus
+
+bm root
+mshv_root, no vmbus
+
+nested root
+mshv_root uses L1
+vmbus uses L0 (NESTED regs)
+
+l1vh
+mshv_root and vmbus use same regs
+
+*/
+
+struct hv_synic_page {
+	u64 msr;
+	void *ptr;
+	struct kref refcount;
+};
+
+void *hv_get_synic_page(u32 msr) {
+	struct hv_synic_page *page_obj;
+	page_obj = kmalloc
+}
+
+
+#define HV_SYNIC_PAGE_STRUCT(type, name) \
+struct 
+
+/* UGH */
+struct hv_percpu_synic_cxt {
+	struct {
+		struct hv_message_page *ptr;
+		refcount_t pt_ref_count;
+	} hv_simp;
+	struct hv_message_page *hv_simp;
+	struct hv_synic_event_flags_page *hv_siefp;
+	struct hv_synic_event_ring_page *hv_sierp;
+};
+
+int hv_setup_sint(u32 sint_msr)
+{
+	union hv_synic_sint sint;
+
+	// TODO validate sint_msr
+
+	sint.as_uint64 = hv_get_msr(sint_msr);
+	sint.vector = vmbus_interrupt;
+	sint.masked = false;
+	sint.auto_eoi = hv_recommend_using_aeoi();
+
+	hv_set_msr(sint_msr, sint.as_uint64);
+
+	return 0;
+}
+
+void *hv_setup_synic_page(u32 msr)
+{
+	void *addr;
+	struct hv_synic_page synic_page;
+
+	// TODO validate msr
+
+	synic_page.as_uint64 = hv_get_msr(msr);
+	synic_page.enabled = 1;
+
+	if (ms_hyperv.paravisor_present || hv_root_partition()) {
+		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
+		u64 base = (synic_page.gpa << HV_HYP_PAGE_SHIFT) &
+			    ~ms_hyperv.shared_gpa_boundary;
+		addr = (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+		if (!addr) {
+			pr_err("%s: Fail to map synic page from %#x.\n",
+			       __func__, msr);
+			return NULL;
+		}
+	} else {
+		addr = (void *)__get_free_page(GFP_KERNEL);
+		if (!page)
+			return NULL;
+
+		memset(page, 0, PAGE_SIZE);
+		synic_page.gpa = virt_to_phys(addr) >> HV_HYP_PAGE_SHIFT;
+	}
+	hv_set_msr(msr, synic_page.as_uint64);
+
+	return addr;
+}
+
+/*
+ * hv_hyp_synic_enable_regs - Initialize the Synthetic Interrupt Controller
+ * with the hypervisor.
+ */
+void hv_hyp_synic_enable_regs(unsigned int cpu)
+{
+	struct hv_per_cpu_context *hv_cpu =
+		per_cpu_ptr(hv_context.cpu_context, cpu);
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+	union hv_synic_sint shared_sint;
+
+	/* Setup the Synic's message page with the hypervisor. */
+	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
+	simp.simp_enabled = 1;
+
+	if (ms_hyperv.paravisor_present || hv_root_partition()) {
+		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
+		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
+				~ms_hyperv.shared_gpa_boundary;
+		hv_cpu->hyp_synic_message_page =
+			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+		if (!hv_cpu->hyp_synic_message_page)
+			pr_err("Fail to map synic message page.\n");
+	} else {
+		simp.base_simp_gpa = virt_to_phys(hv_cpu->hyp_synic_message_page)
+			>> HV_HYP_PAGE_SHIFT;
+	}
+
+	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
+
+	/* Setup the Synic's event page with the hypervisor. */
+	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
+	siefp.siefp_enabled = 1;
+
+	if (ms_hyperv.paravisor_present || hv_root_partition()) {
+		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
+		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
+				~ms_hyperv.shared_gpa_boundary;
+		hv_cpu->hyp_synic_event_page =
+			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+		if (!hv_cpu->hyp_synic_event_page)
+			pr_err("Fail to map synic event page.\n");
+	} else {
+		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->hyp_synic_event_page)
+			>> HV_HYP_PAGE_SHIFT;
+	}
+
+	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
+
+	/* Setup the shared SINT. */
+	if (vmbus_irq != -1)
+		enable_percpu_irq(vmbus_irq, 0);
+	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
+
+	shared_sint.vector = vmbus_interrupt;
+	shared_sint.masked = false;
+	shared_sint.auto_eoi = hv_recommend_using_aeoi();
+	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+}
+
+static void hv_hyp_synic_enable_interrupts(void)
+{
+	union hv_synic_scontrol sctrl;
+
+	/* Enable the global synic bit */
+	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
+	sctrl.enable = 1;
+
+	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
+}
diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
new file mode 100644
index 000000000000..72eb0ae44e4b
--- /dev/null
+++ b/drivers/hv/mshv_debugfs.c
@@ -0,0 +1,703 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Microsoft Corporation.
+ *
+ * The /sys/kernel/debug/mshv directory contents.
+ * Contains various statistics data, provided by the hypervisor.
+ *
+ * Authors: Microsoft Linux virtualization team
+ */
+
+#include <linux/debugfs.h>
+#include <linux/stringify.h>
+#include <asm/mshyperv.h>
+#include <linux/slab.h>
+
+#include "mshv.h"
+#include "mshv_root.h"
+
+#include "hv_counters.c"
+
+#define U32_BUF_SZ 11
+#define U64_BUF_SZ 21
+#define NUM_STATS_AREAS (HV_STATS_AREA_PARENT + 1)
+
+static struct dentry *mshv_debugfs;
+static struct dentry *mshv_debugfs_partition;
+static struct dentry *mshv_debugfs_lp;
+static struct dentry **parent_vp_stats;
+static struct dentry *parent_partition_stats;
+
+static u64 mshv_lps_count;
+static struct hv_stats_page **mshv_lps_stats;
+
+static int lp_stats_show(struct seq_file *m, void *v)
+{
+	const struct hv_stats_page *stats = m->private;
+	struct hv_counter_entry *entry = hv_lp_counters;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hv_lp_counters); i++, entry++)
+		seq_printf(m, "%-29s: %llu\n", entry->name,
+			   stats->data[entry->idx]);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(lp_stats);
+
+static void mshv_lp_stats_unmap(u32 lp_index)
+{
+	union hv_stats_object_identity identity = {
+		.lp.lp_index = lp_index,
+		.lp.stats_area_type = HV_STATS_AREA_SELF,
+	};
+	int err;
+
+	err = hv_unmap_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR,
+				  mshv_lps_stats[lp_index], &identity);
+	if (err)
+		pr_err("%s: failed to unmap logical processor %u stats, err: %d\n",
+		       __func__, lp_index, err);
+}
+
+static struct hv_stats_page * __init mshv_lp_stats_map(u32 lp_index)
+{
+	union hv_stats_object_identity identity = {
+		.lp.lp_index = lp_index,
+		.lp.stats_area_type = HV_STATS_AREA_SELF,
+	};
+	struct hv_stats_page *stats;
+	int err;
+
+	err = hv_map_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR, &identity,
+				&stats);
+	if (err) {
+		pr_err("%s: failed to map logical processor %u stats, err: %d\n",
+		       __func__, lp_index, err);
+		return ERR_PTR(err);
+	}
+	mshv_lps_stats[lp_index] = stats;
+
+	return stats;
+}
+
+static struct hv_stats_page * __init lp_debugfs_stats_create(u32 lp_index,
+							     struct dentry *parent)
+{
+	struct dentry *dentry;
+	struct hv_stats_page *stats;
+
+	stats = mshv_lp_stats_map(lp_index);
+	if (IS_ERR(stats))
+		return stats;
+
+	dentry = debugfs_create_file("stats", 0400, parent,
+				     stats, &lp_stats_fops);
+	if (IS_ERR(dentry)) {
+		mshv_lp_stats_unmap(lp_index);
+		return ERR_CAST(dentry);
+	}
+	return stats;
+}
+
+static int __init lp_debugfs_create(u32 lp_index, struct dentry *parent)
+{
+	struct dentry *idx;
+	char lp_idx_str[U32_BUF_SZ];
+	struct hv_stats_page *stats;
+	int err;
+
+	sprintf(lp_idx_str, "%u", lp_index);
+
+	idx = debugfs_create_dir(lp_idx_str, parent);
+	if (IS_ERR(idx))
+		return PTR_ERR(idx);
+
+	stats = lp_debugfs_stats_create(lp_index, idx);
+	if (IS_ERR(stats)) {
+		err = PTR_ERR(stats);
+		goto remove_debugfs_lp_idx;
+	}
+
+	return 0;
+
+remove_debugfs_lp_idx:
+	debugfs_remove_recursive(idx);
+	return err;
+}
+
+static void mshv_debugfs_lp_remove(void)
+{
+	int lp_index;
+
+	debugfs_remove_recursive(mshv_debugfs_lp);
+
+	for (lp_index = 0; lp_index < mshv_lps_count; lp_index++)
+		mshv_lp_stats_unmap(lp_index);
+
+	kfree(mshv_lps_stats);
+	mshv_lps_stats = NULL;
+}
+
+static int __init mshv_debugfs_lp_create(struct dentry *parent)
+{
+	struct dentry *lp_dir;
+	int err, lp_index;
+
+	mshv_lps_stats = kcalloc(mshv_lps_count,
+				 sizeof(*mshv_lps_stats),
+				 GFP_KERNEL_ACCOUNT);
+
+	if (!mshv_lps_stats)
+		return -ENOMEM;
+
+	lp_dir = debugfs_create_dir("lp", parent);
+	if (IS_ERR(lp_dir)) {
+		err = PTR_ERR(lp_dir);
+		goto free_lp_stats;
+	}
+
+	for (lp_index = 0; lp_index < mshv_lps_count; lp_index++) {
+		err = lp_debugfs_create(lp_index, lp_dir);
+		if (err)
+			goto remove_debugfs_lps;
+	}
+
+	mshv_debugfs_lp = lp_dir;
+
+	return 0;
+
+remove_debugfs_lps:
+	for (lp_index -= 1; lp_index >= 0; lp_index--)
+		mshv_lp_stats_unmap(lp_index);
+	debugfs_remove_recursive(lp_dir);
+free_lp_stats:
+	kfree(mshv_lps_stats);
+
+	return err;
+}
+
+static int vp_stats_show(struct seq_file *m, void *v)
+{
+	const struct hv_stats_page **pstats = m->private;
+	struct hv_counter_entry *entry = hv_vp_counters;
+	int i;
+
+	/*
+	 * For VP and partition stats, there may be two stats areas mapped,
+	 * SELF and PARENT. These refer to the privilege level of the data in
+	 * each page. Some fields may be 0 in SELF and nonzero in PARENT, or
+	 * vice versa.
+	 *
+	 * Hence, prioritize printing from the PARENT page (more privileged
+	 * data), but use the value from the SELF page if the PARENT value is
+	 * 0.
+	 */
+
+	for (i = 0; i < ARRAY_SIZE(hv_vp_counters); i++, entry++) {
+		u64 parent_val = pstats[HV_STATS_AREA_PARENT]->data[entry->idx];
+		u64 self_val = pstats[HV_STATS_AREA_SELF]->data[entry->idx];
+
+		seq_printf(m, "%-43s: %llu\n", entry->name,
+			   parent_val ? parent_val : self_val);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(vp_stats);
+
+static void vp_debugfs_remove(struct dentry *vp_stats)
+{
+	debugfs_remove_recursive(vp_stats->d_parent);
+}
+
+static int vp_debugfs_create(u64 partition_id, u32 vp_index,
+			     struct hv_stats_page **pstats,
+			     struct dentry **vp_stats_ptr,
+			     struct dentry *parent)
+{
+	struct dentry *vp_idx_dir, *d;
+	char vp_idx_str[U32_BUF_SZ];
+	int err;
+
+	sprintf(vp_idx_str, "%u", vp_index);
+
+	vp_idx_dir = debugfs_create_dir(vp_idx_str, parent);
+	if (IS_ERR(vp_idx_dir))
+		return PTR_ERR(vp_idx_dir);
+
+	d = debugfs_create_file("stats", 0400, vp_idx_dir,
+				     pstats, &vp_stats_fops);
+	if (IS_ERR(d)) {
+		err = PTR_ERR(d);
+		goto remove_debugfs_vp_idx;
+	}
+
+	*vp_stats_ptr = d;
+
+	return 0;
+
+remove_debugfs_vp_idx:
+	debugfs_remove_recursive(vp_idx_dir);
+	return err;
+}
+
+static int partition_stats_show(struct seq_file *m, void *v)
+{
+	const struct hv_stats_page **pstats = m->private;
+	struct hv_counter_entry *entry = hv_partition_counters;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hv_partition_counters); i++, entry++) {
+		u64 parent_val = pstats[HV_STATS_AREA_PARENT]->data[entry->idx];
+		u64 self_val = pstats[HV_STATS_AREA_SELF]->data[entry->idx];
+
+		seq_printf(m, "%-32s: %llu\n", entry->name,
+			   parent_val ? parent_val : self_val);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(partition_stats);
+
+static void mshv_partition_stats_unmap(u64 partition_id,
+				       struct hv_stats_page *stats_page,
+				       enum hv_stats_area_type stats_area_type)
+{
+	union hv_stats_object_identity identity = {
+		.partition.partition_id = partition_id,
+		.partition.stats_area_type = stats_area_type,
+	};
+	int err;
+
+	err = hv_unmap_stats_page(HV_STATS_OBJECT_PARTITION, stats_page,
+				  &identity);
+	if (err)
+		pr_err("%s: failed to unmap partition %lld %s stats, err: %d\n",
+		       __func__, partition_id,
+		       (stats_area_type == HV_STATS_AREA_SELF) ? "self" : "parent",
+		       err);
+}
+
+static struct hv_stats_page *mshv_partition_stats_map(u64 partition_id,
+						      enum hv_stats_area_type stats_area_type)
+{
+	union hv_stats_object_identity identity = {
+		.partition.partition_id = partition_id,
+		.partition.stats_area_type = stats_area_type,
+	};
+	struct hv_stats_page *stats;
+	int err;
+
+	err = hv_map_stats_page(HV_STATS_OBJECT_PARTITION, &identity, &stats);
+	if (err) {
+		pr_err("%s: failed to map partition %lld %s stats, err: %d\n",
+		       __func__, partition_id,
+		       (stats_area_type == HV_STATS_AREA_SELF) ? "self" : "parent",
+		       err);
+		return ERR_PTR(err);
+	}
+	return stats;
+}
+
+static int mshv_debugfs_partition_stats_create(u64 partition_id,
+					    struct dentry **partition_stats_ptr,
+					    struct dentry *parent)
+{
+	struct dentry *dentry;
+	struct hv_stats_page **pstats;
+	int err;
+
+	pstats = kcalloc(NUM_STATS_AREAS, sizeof(struct hv_stats_page *),
+			 GFP_KERNEL_ACCOUNT);
+	if (!pstats)
+		return -ENOMEM;
+
+	pstats[HV_STATS_AREA_SELF] = mshv_partition_stats_map(partition_id,
+							      HV_STATS_AREA_SELF);
+	if (IS_ERR(pstats[HV_STATS_AREA_SELF])) {
+		err = PTR_ERR(pstats[HV_STATS_AREA_SELF]);
+		goto cleanup;
+	}
+
+	/*
+	 * L1VH partition cannot access its partition stats in parent area.
+	 */
+	if (is_l1vh_parent(partition_id)) {
+		pstats[HV_STATS_AREA_PARENT] = pstats[HV_STATS_AREA_SELF];
+	} else {
+		pstats[HV_STATS_AREA_PARENT] = mshv_partition_stats_map(partition_id,
+									HV_STATS_AREA_PARENT);
+		if (IS_ERR(pstats[HV_STATS_AREA_PARENT])) {
+			err = PTR_ERR(pstats[HV_STATS_AREA_PARENT]);
+			goto unmap_self;
+		}
+		if (!pstats[HV_STATS_AREA_PARENT])
+			pstats[HV_STATS_AREA_PARENT] = pstats[HV_STATS_AREA_SELF];
+	}
+
+	dentry = debugfs_create_file("stats", 0400, parent,
+				     pstats, &partition_stats_fops);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto unmap_partition_stats;
+	}
+
+	*partition_stats_ptr = dentry;
+	return 0;
+
+unmap_partition_stats:
+	if (pstats[HV_STATS_AREA_PARENT] != pstats[HV_STATS_AREA_SELF])
+		mshv_partition_stats_unmap(partition_id, pstats[HV_STATS_AREA_PARENT],
+					   HV_STATS_AREA_PARENT);
+unmap_self:
+	mshv_partition_stats_unmap(partition_id, pstats[HV_STATS_AREA_SELF],
+				   HV_STATS_AREA_SELF);
+cleanup:
+	kfree(pstats);
+	return err;
+}
+
+static void partition_debugfs_remove(u64 partition_id, struct dentry *dentry)
+{
+	struct hv_stats_page **pstats = NULL;
+
+	pstats = dentry->d_inode->i_private;
+
+	debugfs_remove_recursive(dentry->d_parent);
+
+	if (pstats[HV_STATS_AREA_PARENT] != pstats[HV_STATS_AREA_SELF]) {
+		mshv_partition_stats_unmap(partition_id,
+					   pstats[HV_STATS_AREA_PARENT],
+					   HV_STATS_AREA_PARENT);
+	}
+
+	mshv_partition_stats_unmap(partition_id,
+				   pstats[HV_STATS_AREA_SELF],
+				   HV_STATS_AREA_SELF);
+
+	kfree(pstats);
+}
+
+static int partition_debugfs_create(u64 partition_id,
+				    struct dentry **vp_dir_ptr,
+				    struct dentry **partition_stats_ptr,
+				    struct dentry *parent)
+{
+	char part_id_str[U64_BUF_SZ];
+	struct dentry *part_id_dir, *vp_dir;
+	int err;
+
+	if (is_l1vh_parent(partition_id))
+		sprintf(part_id_str, "self");
+	else
+		sprintf(part_id_str, "%llu", partition_id);
+
+	part_id_dir = debugfs_create_dir(part_id_str, parent);
+	if (IS_ERR(part_id_dir))
+		return PTR_ERR(part_id_dir);
+
+	vp_dir = debugfs_create_dir("vp", part_id_dir);
+	if (IS_ERR(vp_dir)) {
+		err = PTR_ERR(vp_dir);
+		goto remove_debugfs_partition_id;
+	}
+
+	err = mshv_debugfs_partition_stats_create(partition_id,
+						  partition_stats_ptr,
+						  part_id_dir);
+	if (err)
+		goto remove_debugfs_partition_id;
+
+	*vp_dir_ptr = vp_dir;
+
+	return 0;
+
+remove_debugfs_partition_id:
+	debugfs_remove_recursive(part_id_dir);
+	return err;
+}
+
+static void parent_vp_debugfs_remove(u32 vp_index,
+				     struct dentry *vp_stats_ptr)
+{
+	struct hv_stats_page **pstats;
+
+	pstats = vp_stats_ptr->d_inode->i_private;
+	vp_debugfs_remove(vp_stats_ptr);
+	mshv_vp_stats_unmap(hv_current_partition_id, vp_index, pstats);
+	kfree(pstats);
+}
+
+static void mshv_debugfs_parent_partition_remove(void)
+{
+	int idx;
+
+	for_each_online_cpu(idx)
+		parent_vp_debugfs_remove(idx,
+					 parent_vp_stats[idx]);
+
+	partition_debugfs_remove(hv_current_partition_id,
+				 parent_partition_stats);
+	kfree(parent_vp_stats);
+	parent_vp_stats = NULL;
+	parent_partition_stats = NULL;
+
+}
+
+static int __init parent_vp_debugfs_create(u32 vp_index,
+					   struct dentry **vp_stats_ptr,
+					   struct dentry *parent)
+{
+	struct hv_stats_page **pstats;
+	int err;
+
+	pstats = kcalloc(2, sizeof(struct hv_stats_page *), GFP_KERNEL_ACCOUNT);
+	if (!pstats)
+		return -ENOMEM;
+
+	err = mshv_vp_stats_map(hv_current_partition_id, vp_index, pstats);
+	if (err)
+		goto cleanup;
+
+	err = vp_debugfs_create(hv_current_partition_id, vp_index, pstats,
+				vp_stats_ptr, parent);
+	if (err)
+		goto unmap_vp_stats;
+
+	return 0;
+
+unmap_vp_stats:
+	mshv_vp_stats_unmap(hv_current_partition_id, vp_index, pstats);
+cleanup:
+	kfree(pstats);
+	return err;
+}
+
+static int __init mshv_debugfs_parent_partition_create(void)
+{
+	struct dentry *vp_dir;
+	int err, idx, i;
+
+	mshv_debugfs_partition = debugfs_create_dir("partition",
+						     mshv_debugfs);
+	if (IS_ERR(mshv_debugfs_partition))
+		return PTR_ERR(mshv_debugfs_partition);
+
+	err = partition_debugfs_create(hv_current_partition_id,
+				       &vp_dir,
+				       &parent_partition_stats,
+				       mshv_debugfs_partition);
+	if (err)
+		goto remove_debugfs_partition;
+
+	parent_vp_stats = kcalloc(num_possible_cpus(),
+				  sizeof(*parent_vp_stats),
+				  GFP_KERNEL);
+	if (!parent_vp_stats) {
+		err = -ENOMEM;
+		goto remove_debugfs_partition;
+	}
+
+	for_each_online_cpu(idx) {
+		err = parent_vp_debugfs_create(hv_vp_index[idx],
+					       &parent_vp_stats[idx],
+					       vp_dir);
+		if (err)
+			goto remove_debugfs_partition_vp;
+	}
+
+	return 0;
+
+remove_debugfs_partition_vp:
+	for_each_online_cpu(i) {
+		if (i >= idx)
+			break;
+		parent_vp_debugfs_remove(i, parent_vp_stats[i]);
+	}
+	partition_debugfs_remove(hv_current_partition_id,
+				 parent_partition_stats);
+
+	kfree(parent_vp_stats);
+	parent_vp_stats = NULL;
+	parent_partition_stats = NULL;
+
+remove_debugfs_partition:
+	debugfs_remove_recursive(mshv_debugfs_partition);
+	mshv_debugfs_partition = NULL;
+	return err;
+}
+
+static int hv_stats_show(struct seq_file *m, void *v)
+{
+	const struct hv_stats_page *stats = m->private;
+	struct hv_counter_entry *entry = hv_hypervisor_counters;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hv_hypervisor_counters); i++, entry++)
+		seq_printf(m, "%-25s: %llu\n", entry->name,
+			   stats->data[entry->idx]);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(hv_stats);
+
+static void mshv_hv_stats_unmap(void)
+{
+	union hv_stats_object_identity identity = {
+		.hv.stats_area_type = HV_STATS_AREA_SELF,
+	};
+	int err;
+
+	err = hv_unmap_stats_page(HV_STATS_OBJECT_HYPERVISOR, NULL, &identity);
+	if (err)
+		pr_err("%s: failed to unmap hypervisor stats: %d\n",
+		       __func__, err);
+}
+
+static void * __init mshv_hv_stats_map(void)
+{
+	union hv_stats_object_identity identity = {
+		.hv.stats_area_type = HV_STATS_AREA_SELF,
+	};
+	struct hv_stats_page *stats;
+	int err;
+
+	err = hv_map_stats_page(HV_STATS_OBJECT_HYPERVISOR, &identity, &stats);
+	if (err) {
+		pr_err("%s: failed to map hypervisor stats: %d\n",
+		       __func__, err);
+		return ERR_PTR(err);
+	}
+	return stats;
+}
+
+static int __init mshv_debugfs_hv_stats_create(struct dentry *parent)
+{
+	struct dentry *dentry;
+	u64 *stats;
+	int err;
+
+	stats = mshv_hv_stats_map();
+	if (IS_ERR(stats))
+		return PTR_ERR(stats);
+
+	dentry = debugfs_create_file("stats", 0400, parent,
+				     stats, &hv_stats_fops);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		pr_err("%s: failed to create hypervisor stats dentry: %d\n",
+		       __func__, err);
+		goto unmap_hv_stats;
+	}
+
+	mshv_lps_count = num_present_cpus();
+
+	return 0;
+
+unmap_hv_stats:
+	mshv_hv_stats_unmap();
+	return err;
+}
+
+int mshv_debugfs_vp_create(struct mshv_vp *vp)
+{
+	struct mshv_partition *p = vp->vp_partition;
+
+	if (!mshv_debugfs)
+		return 0;
+
+	return vp_debugfs_create(p->pt_id, vp->vp_index,
+				 vp->vp_stats_pages,
+				 &vp->vp_stats_dentry,
+				 p->pt_vp_dentry);
+}
+
+void mshv_debugfs_vp_remove(struct mshv_vp *vp)
+{
+	if (!mshv_debugfs)
+		return;
+
+	vp_debugfs_remove(vp->vp_stats_dentry);
+}
+
+int mshv_debugfs_partition_create(struct mshv_partition *partition)
+{
+	int err;
+
+	if (!mshv_debugfs)
+		return 0;
+
+	err = partition_debugfs_create(partition->pt_id,
+				       &partition->pt_vp_dentry,
+				       &partition->pt_stats_dentry,
+				       mshv_debugfs_partition);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+void mshv_debugfs_partition_remove(struct mshv_partition *partition)
+{
+	if (!mshv_debugfs)
+		return;
+
+	partition_debugfs_remove(partition->pt_id,
+				 partition->pt_stats_dentry);
+}
+
+int __init mshv_debugfs_init(void)
+{
+	int err;
+
+	mshv_debugfs = debugfs_create_dir("mshv", NULL);
+	if (IS_ERR(mshv_debugfs)) {
+		pr_err("%s: failed to create debugfs directory\n", __func__);
+		return PTR_ERR(mshv_debugfs);
+	}
+
+	if (hv_root_partition()) {
+		err = mshv_debugfs_hv_stats_create(mshv_debugfs);
+		if (err)
+			goto remove_mshv_dir;
+
+		err = mshv_debugfs_lp_create(mshv_debugfs);
+		if (err)
+			goto unmap_hv_stats;
+	}
+
+	err = mshv_debugfs_parent_partition_create();
+	if (err)
+		goto unmap_lp_stats;
+
+	return 0;
+
+unmap_lp_stats:
+	if (hv_root_partition()) {
+		mshv_debugfs_lp_remove();
+		mshv_debugfs_lp = NULL;
+	}
+unmap_hv_stats:
+	if (hv_root_partition())
+		mshv_hv_stats_unmap();
+remove_mshv_dir:
+	debugfs_remove_recursive(mshv_debugfs);
+	mshv_debugfs = NULL;
+	return err;
+}
+
+void mshv_debugfs_exit(void)
+{
+	mshv_debugfs_parent_partition_remove();
+
+	if (hv_root_partition()) {
+		mshv_debugfs_lp_remove();
+		mshv_debugfs_lp = NULL;
+		mshv_hv_stats_unmap();
+	}
+
+	debugfs_remove_recursive(mshv_debugfs);
+	mshv_debugfs = NULL;
+	mshv_debugfs_partition = NULL;
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index e4912b0618fa..7332d9af8373 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -52,6 +52,9 @@ struct mshv_vp {
 		unsigned int kicked_by_hv;
 		wait_queue_head_t vp_suspend_queue;
 	} run;
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct dentry *vp_stats_dentry;
+#endif
 };
 
 #define vp_fmt(fmt) "p%lluvp%u: " fmt
@@ -136,6 +139,10 @@ struct mshv_partition {
 	u64 isolation_type;
 	bool import_completed;
 	bool pt_initialized;
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct dentry *pt_stats_dentry;
+	struct dentry *pt_vp_dentry;
+#endif
 };
 
 #define pt_fmt(fmt) "p%llu: " fmt
@@ -327,6 +334,33 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,
 				      void *property_value, size_t property_value_sz);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+int __init mshv_debugfs_init(void);
+void mshv_debugfs_exit(void);
+
+int mshv_debugfs_partition_create(struct mshv_partition *partition);
+void mshv_debugfs_partition_remove(struct mshv_partition *partition);
+int mshv_debugfs_vp_create(struct mshv_vp *vp);
+void mshv_debugfs_vp_remove(struct mshv_vp *vp);
+#else
+static inline int __init mshv_debugfs_init(void)
+{
+	return 0;
+}
+static inline void mshv_debugfs_exit(void) { }
+
+static inline int mshv_debugfs_partition_create(struct mshv_partition *partition)
+{
+	return 0;
+}
+static inline void mshv_debugfs_partition_remove(struct mshv_partition *partition) { }
+static inline int mshv_debugfs_vp_create(struct mshv_vp *vp)
+{
+	return 0;
+}
+static inline void mshv_debugfs_vp_remove(struct mshv_vp *vp) { }
+#endif
+
 extern struct mshv_root mshv_root;
 extern enum hv_scheduler_type hv_scheduler_type;
 extern u8 * __percpu *hv_synic_eventring_tail;
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 12825666e21b..f4654fb8cd23 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1096,6 +1096,10 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 
 	memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
 
+	ret = mshv_debugfs_vp_create(vp);
+	if (ret)
+		goto put_partition;
+
 	/*
 	 * Keep anon_inode_getfd last: it installs fd in the file struct and
 	 * thus makes the state accessible in user space.
@@ -1103,7 +1107,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	ret = anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
 			       O_RDWR | O_CLOEXEC);
 	if (ret < 0)
-		goto put_partition;
+		goto remove_debugfs_vp;
 
 	/* already exclusive with the partition mutex for all ioctls */
 	partition->pt_vp_count++;
@@ -1111,6 +1115,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 
 	return ret;
 
+remove_debugfs_vp:
+	mshv_debugfs_vp_remove(vp);
 put_partition:
 	mshv_partition_put(partition);
 free_vp:
@@ -1553,10 +1559,16 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 	if (ret)
 		goto withdraw_mem;
 
+	ret = mshv_debugfs_partition_create(partition);
+	if (ret)
+		goto finalize_partition;
+
 	partition->pt_initialized = true;
 
 	return 0;
 
+finalize_partition:
+	hv_call_finalize_partition(partition->pt_id);
 withdraw_mem:
 	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
 
@@ -1736,6 +1748,7 @@ static void destroy_partition(struct mshv_partition *partition)
 			if (!vp)
 				continue;
 
+			mshv_debugfs_vp_remove(vp);
 			mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
 					    vp->vp_stats_pages);
 
@@ -1769,6 +1782,8 @@ static void destroy_partition(struct mshv_partition *partition)
 			partition->pt_vp_array[i] = NULL;
 		}
 
+		mshv_debugfs_partition_remove(partition);
+
 		/* Deallocates and unmaps everything including vcpus, GPA mappings etc */
 		hv_call_finalize_partition(partition->pt_id);
 
@@ -2314,10 +2329,14 @@ static int __init mshv_parent_partition_init(void)
 
 	mshv_init_vmm_caps(dev);
 
-	ret = mshv_irqfd_wq_init();
+	ret = mshv_debugfs_init();
 	if (ret)
 		goto exit_partition;
 
+	ret = mshv_irqfd_wq_init();
+	if (ret)
+		goto exit_debugfs;
+
 	spin_lock_init(&mshv_root.pt_ht_lock);
 	hash_init(mshv_root.pt_htable);
 
@@ -2325,6 +2344,8 @@ static int __init mshv_parent_partition_init(void)
 
 	return 0;
 
+exit_debugfs:
+	mshv_debugfs_exit();
 exit_partition:
 	if (hv_root_partition())
 		mshv_root_partition_exit();
@@ -2341,6 +2362,7 @@ static void __exit mshv_parent_partition_exit(void)
 {
 	hv_setup_mshv_handler(NULL);
 	mshv_port_table_fini();
+	mshv_debugfs_exit();
 	misc_deregister(&mshv_dev);
 	mshv_irqfd_wq_cleanup();
 	if (hv_root_partition())
-- 
2.34.1


