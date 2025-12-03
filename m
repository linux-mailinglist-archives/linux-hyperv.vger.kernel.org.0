Return-Path: <linux-hyperv+bounces-7926-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40552CA0E07
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 19:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 224773008566
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 18:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0533893C;
	Wed,  3 Dec 2025 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ORoJniv5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44166335BAA;
	Wed,  3 Dec 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784417; cv=none; b=U918CLj9MG7tBTgGjqqDdAoWVHCXhf7cUBdTZ93f3YjeNhCTv/rQAtNezXL/gyX1slDOgAN8/CXqasJp1KfBMdUGlKQbvtuTUIGo1+K/LNeFfR1n44adS+lY02Clc5sCzvY8SKhWLkn051OXMKYr8dHl30HKxYR4jA9afx1Ceis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784417; c=relaxed/simple;
	bh=12XZYvzmQ8xerRfUgNh/uG0r0gnQ5KuuPPT3uGEMBSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rIWG9A6EEp3CKsjEZLiNML/5pihSjFn+FtqFGiTC7y4haTEPjwC30fcu6mVLsXBCwgWzPuxWOFMfkI0goWDeUDVJFoZfBhI0vI6i4IUD0pufHF9tE+X8BOgdSk+jqk/bp4TX6Kcni9xkknNa3rFPv3FmDYY7/uGBePQfAbd476c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ORoJniv5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 053D52120E85; Wed,  3 Dec 2025 09:53:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 053D52120E85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764784415;
	bh=a664UpK5BufAwzvSCyLXFV7knytIDK2zeQMZjZf3yTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORoJniv5DCPeG/RXqB0pxQ8dTd4q8FtSAgGetlPFe1B45cfqdbV0euD2gx78BXp2y
	 J0+rfsdxVLYgNg9+gSTvCcttXx1k1YdWSeysadFLkl+0ZtPI9bDWkxtHuitRO2ixzy
	 j4YULJVrnlUuXlt2XzXjwu/k3y7hgFYQt6OsamnY=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Jinank Jain <jinankjain@microsoft.com>
Subject: [PATCH 3/3] mshv: Add debugfs to view hypervisor statistics
Date: Wed,  3 Dec 2025 09:53:25 -0800
Message-Id: <1764784405-4484-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

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
---
 drivers/hv/Makefile         |    1 +
 drivers/hv/mshv_debugfs.c   | 1122 +++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h      |   34 ++
 drivers/hv/mshv_root_main.c |   32 +-
 4 files changed, 1185 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hv/mshv_debugfs.c

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 58b8d07639f3..36278c936914 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -15,6 +15,7 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
 	       mshv_root_hv_call.o mshv_portid_table.o
+mshv_root-$(CONFIG_DEBUG_FS) += mshv_debugfs.o
 mshv_vtl-y := mshv_vtl_main.o
 
 # Code that must be built-in
diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
new file mode 100644
index 000000000000..581018690a27
--- /dev/null
+++ b/drivers/hv/mshv_debugfs.c
@@ -0,0 +1,1122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Microsoft Corporation.
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
+#define U32_BUF_SZ 11
+#define U64_BUF_SZ 21
+
+static struct dentry *mshv_debugfs;
+static struct dentry *mshv_debugfs_partition;
+static struct dentry *mshv_debugfs_lp;
+
+static u64 mshv_lps_count;
+
+static bool is_l1vh_parent(u64 partition_id)
+{
+	return hv_l1vh_partition() && (partition_id == HV_PARTITION_ID_SELF);
+}
+
+static int lp_stats_show(struct seq_file *m, void *v)
+{
+	const struct hv_stats_page *stats = m->private;
+
+#define LP_SEQ_PRINTF(cnt)		\
+	seq_printf(m, "%-29s: %llu\n", __stringify(cnt), stats->lp_cntrs[Lp##cnt])
+
+	LP_SEQ_PRINTF(GlobalTime);
+	LP_SEQ_PRINTF(TotalRunTime);
+	LP_SEQ_PRINTF(HypervisorRunTime);
+	LP_SEQ_PRINTF(HardwareInterrupts);
+	LP_SEQ_PRINTF(ContextSwitches);
+	LP_SEQ_PRINTF(InterProcessorInterrupts);
+	LP_SEQ_PRINTF(SchedulerInterrupts);
+	LP_SEQ_PRINTF(TimerInterrupts);
+	LP_SEQ_PRINTF(InterProcessorInterruptsSent);
+	LP_SEQ_PRINTF(ProcessorHalts);
+	LP_SEQ_PRINTF(MonitorTransitionCost);
+	LP_SEQ_PRINTF(ContextSwitchTime);
+	LP_SEQ_PRINTF(C1TransitionsCount);
+	LP_SEQ_PRINTF(C1RunTime);
+	LP_SEQ_PRINTF(C2TransitionsCount);
+	LP_SEQ_PRINTF(C2RunTime);
+	LP_SEQ_PRINTF(C3TransitionsCount);
+	LP_SEQ_PRINTF(C3RunTime);
+	LP_SEQ_PRINTF(RootVpIndex);
+	LP_SEQ_PRINTF(IdleSequenceNumber);
+	LP_SEQ_PRINTF(GlobalTscCount);
+	LP_SEQ_PRINTF(ActiveTscCount);
+	LP_SEQ_PRINTF(IdleAccumulation);
+	LP_SEQ_PRINTF(ReferenceCycleCount0);
+	LP_SEQ_PRINTF(ActualCycleCount0);
+	LP_SEQ_PRINTF(ReferenceCycleCount1);
+	LP_SEQ_PRINTF(ActualCycleCount1);
+	LP_SEQ_PRINTF(ProximityDomainId);
+	LP_SEQ_PRINTF(PostedInterruptNotifications);
+	LP_SEQ_PRINTF(BranchPredictorFlushes);
+#if IS_ENABLED(CONFIG_X86_64)
+	LP_SEQ_PRINTF(L1DataCacheFlushes);
+	LP_SEQ_PRINTF(ImmediateL1DataCacheFlushes);
+	LP_SEQ_PRINTF(MbFlushes);
+	LP_SEQ_PRINTF(CounterRefreshSequenceNumber);
+	LP_SEQ_PRINTF(CounterRefreshReferenceTime);
+	LP_SEQ_PRINTF(IdleAccumulationSnapshot);
+	LP_SEQ_PRINTF(ActiveTscCountSnapshot);
+	LP_SEQ_PRINTF(HwpRequestContextSwitches);
+	LP_SEQ_PRINTF(Placeholder1);
+	LP_SEQ_PRINTF(Placeholder2);
+	LP_SEQ_PRINTF(Placeholder3);
+	LP_SEQ_PRINTF(Placeholder4);
+	LP_SEQ_PRINTF(Placeholder5);
+	LP_SEQ_PRINTF(Placeholder6);
+	LP_SEQ_PRINTF(Placeholder7);
+	LP_SEQ_PRINTF(Placeholder8);
+	LP_SEQ_PRINTF(Placeholder9);
+	LP_SEQ_PRINTF(Placeholder10);
+	LP_SEQ_PRINTF(ReserveGroupId);
+	LP_SEQ_PRINTF(RunningPriority);
+	LP_SEQ_PRINTF(PerfmonInterruptCount);
+#elif IS_ENABLED(CONFIG_ARM64)
+	LP_SEQ_PRINTF(CounterRefreshSequenceNumber);
+	LP_SEQ_PRINTF(CounterRefreshReferenceTime);
+	LP_SEQ_PRINTF(IdleAccumulationSnapshot);
+	LP_SEQ_PRINTF(ActiveTscCountSnapshot);
+	LP_SEQ_PRINTF(HwpRequestContextSwitches);
+	LP_SEQ_PRINTF(Placeholder2);
+	LP_SEQ_PRINTF(Placeholder3);
+	LP_SEQ_PRINTF(Placeholder4);
+	LP_SEQ_PRINTF(Placeholder5);
+	LP_SEQ_PRINTF(Placeholder6);
+	LP_SEQ_PRINTF(Placeholder7);
+	LP_SEQ_PRINTF(Placeholder8);
+	LP_SEQ_PRINTF(Placeholder9);
+	LP_SEQ_PRINTF(SchLocalRunListSize);
+	LP_SEQ_PRINTF(ReserveGroupId);
+	LP_SEQ_PRINTF(RunningPriority);
+#endif
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(lp_stats);
+
+static void mshv_lp_stats_unmap(u32 lp_index, void *stats_page_addr)
+{
+	union hv_stats_object_identity identity = {
+		.lp.lp_index = lp_index,
+		.lp.stats_area_type = HV_STATS_AREA_SELF,
+	};
+	int err;
+
+	err = hv_unmap_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR,
+				  stats_page_addr, &identity);
+	if (err)
+		pr_err("%s: failed to unmap logical processor %u stats, err: %d\n",
+		       __func__, lp_index, err);
+}
+
+static void __init *mshv_lp_stats_map(u32 lp_index)
+{
+	union hv_stats_object_identity identity = {
+		.lp.lp_index = lp_index,
+		.lp.stats_area_type = HV_STATS_AREA_SELF,
+	};
+	void *stats;
+	int err;
+
+	err = hv_map_stats_page(HV_STATS_OBJECT_LOGICAL_PROCESSOR, &identity,
+				&stats);
+	if (err) {
+		pr_err("%s: failed to map logical processor %u stats, err: %d\n",
+		       __func__, lp_index, err);
+		return ERR_PTR(err);
+	}
+
+	return stats;
+}
+
+static void __init *lp_debugfs_stats_create(u32 lp_index, struct dentry *parent)
+{
+	struct dentry *dentry;
+	void *stats;
+
+	stats = mshv_lp_stats_map(lp_index);
+	if (IS_ERR(stats))
+		return stats;
+
+	dentry = debugfs_create_file("stats", 0400, parent,
+				     stats, &lp_stats_fops);
+	if (IS_ERR(dentry)) {
+		mshv_lp_stats_unmap(lp_index, stats);
+		return dentry;
+	}
+	return stats;
+}
+
+static int __init lp_debugfs_create(u32 lp_index, struct dentry *parent)
+{
+	struct dentry *idx;
+	char lp_idx_str[U32_BUF_SZ];
+	void *stats;
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
+		mshv_lp_stats_unmap(lp_index, NULL);
+}
+
+static int __init mshv_debugfs_lp_create(struct dentry *parent)
+{
+	struct dentry *lp_dir;
+	int err, lp_index;
+
+	lp_dir = debugfs_create_dir("lp", parent);
+	if (IS_ERR(lp_dir))
+		return PTR_ERR(lp_dir);
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
+		mshv_lp_stats_unmap(lp_index, NULL);
+	debugfs_remove_recursive(lp_dir);
+	return err;
+}
+
+static int vp_stats_show(struct seq_file *m, void *v)
+{
+	const struct hv_stats_page **pstats = m->private;
+
+#define VP_SEQ_PRINTF(cnt)				 \
+do {								 \
+	if (pstats[HV_STATS_AREA_SELF]->vp_cntrs[Vp##cnt]) \
+		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
+			pstats[HV_STATS_AREA_SELF]->vp_cntrs[Vp##cnt]); \
+	else \
+		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
+			pstats[HV_STATS_AREA_PARENT]->vp_cntrs[Vp##cnt]); \
+} while (0)
+
+	VP_SEQ_PRINTF(TotalRunTime);
+	VP_SEQ_PRINTF(HypervisorRunTime);
+	VP_SEQ_PRINTF(RemoteNodeRunTime);
+	VP_SEQ_PRINTF(NormalizedRunTime);
+	VP_SEQ_PRINTF(IdealCpu);
+	VP_SEQ_PRINTF(HypercallsCount);
+	VP_SEQ_PRINTF(HypercallsTime);
+#if IS_ENABLED(CONFIG_X86_64)
+	VP_SEQ_PRINTF(PageInvalidationsCount);
+	VP_SEQ_PRINTF(PageInvalidationsTime);
+	VP_SEQ_PRINTF(ControlRegisterAccessesCount);
+	VP_SEQ_PRINTF(ControlRegisterAccessesTime);
+	VP_SEQ_PRINTF(IoInstructionsCount);
+	VP_SEQ_PRINTF(IoInstructionsTime);
+	VP_SEQ_PRINTF(HltInstructionsCount);
+	VP_SEQ_PRINTF(HltInstructionsTime);
+	VP_SEQ_PRINTF(MwaitInstructionsCount);
+	VP_SEQ_PRINTF(MwaitInstructionsTime);
+	VP_SEQ_PRINTF(CpuidInstructionsCount);
+	VP_SEQ_PRINTF(CpuidInstructionsTime);
+	VP_SEQ_PRINTF(MsrAccessesCount);
+	VP_SEQ_PRINTF(MsrAccessesTime);
+	VP_SEQ_PRINTF(OtherInterceptsCount);
+	VP_SEQ_PRINTF(OtherInterceptsTime);
+	VP_SEQ_PRINTF(ExternalInterruptsCount);
+	VP_SEQ_PRINTF(ExternalInterruptsTime);
+	VP_SEQ_PRINTF(PendingInterruptsCount);
+	VP_SEQ_PRINTF(PendingInterruptsTime);
+	VP_SEQ_PRINTF(EmulatedInstructionsCount);
+	VP_SEQ_PRINTF(EmulatedInstructionsTime);
+	VP_SEQ_PRINTF(DebugRegisterAccessesCount);
+	VP_SEQ_PRINTF(DebugRegisterAccessesTime);
+	VP_SEQ_PRINTF(PageFaultInterceptsCount);
+	VP_SEQ_PRINTF(PageFaultInterceptsTime);
+	VP_SEQ_PRINTF(GuestPageTableMaps);
+	VP_SEQ_PRINTF(LargePageTlbFills);
+	VP_SEQ_PRINTF(SmallPageTlbFills);
+	VP_SEQ_PRINTF(ReflectedGuestPageFaults);
+	VP_SEQ_PRINTF(ApicMmioAccesses);
+	VP_SEQ_PRINTF(IoInterceptMessages);
+	VP_SEQ_PRINTF(MemoryInterceptMessages);
+	VP_SEQ_PRINTF(ApicEoiAccesses);
+	VP_SEQ_PRINTF(OtherMessages);
+	VP_SEQ_PRINTF(PageTableAllocations);
+	VP_SEQ_PRINTF(LogicalProcessorMigrations);
+	VP_SEQ_PRINTF(AddressSpaceEvictions);
+	VP_SEQ_PRINTF(AddressSpaceSwitches);
+	VP_SEQ_PRINTF(AddressDomainFlushes);
+	VP_SEQ_PRINTF(AddressSpaceFlushes);
+	VP_SEQ_PRINTF(GlobalGvaRangeFlushes);
+	VP_SEQ_PRINTF(LocalGvaRangeFlushes);
+	VP_SEQ_PRINTF(PageTableEvictions);
+	VP_SEQ_PRINTF(PageTableReclamations);
+	VP_SEQ_PRINTF(PageTableResets);
+	VP_SEQ_PRINTF(PageTableValidations);
+	VP_SEQ_PRINTF(ApicTprAccesses);
+	VP_SEQ_PRINTF(PageTableWriteIntercepts);
+	VP_SEQ_PRINTF(SyntheticInterrupts);
+	VP_SEQ_PRINTF(VirtualInterrupts);
+	VP_SEQ_PRINTF(ApicIpisSent);
+	VP_SEQ_PRINTF(ApicSelfIpisSent);
+	VP_SEQ_PRINTF(GpaSpaceHypercalls);
+	VP_SEQ_PRINTF(LogicalProcessorHypercalls);
+	VP_SEQ_PRINTF(LongSpinWaitHypercalls);
+	VP_SEQ_PRINTF(OtherHypercalls);
+	VP_SEQ_PRINTF(SyntheticInterruptHypercalls);
+	VP_SEQ_PRINTF(VirtualInterruptHypercalls);
+	VP_SEQ_PRINTF(VirtualMmuHypercalls);
+	VP_SEQ_PRINTF(VirtualProcessorHypercalls);
+	VP_SEQ_PRINTF(HardwareInterrupts);
+	VP_SEQ_PRINTF(NestedPageFaultInterceptsCount);
+	VP_SEQ_PRINTF(NestedPageFaultInterceptsTime);
+	VP_SEQ_PRINTF(PageScans);
+	VP_SEQ_PRINTF(LogicalProcessorDispatches);
+	VP_SEQ_PRINTF(WaitingForCpuTime);
+	VP_SEQ_PRINTF(ExtendedHypercalls);
+	VP_SEQ_PRINTF(ExtendedHypercallInterceptMessages);
+	VP_SEQ_PRINTF(MbecNestedPageTableSwitches);
+	VP_SEQ_PRINTF(OtherReflectedGuestExceptions);
+	VP_SEQ_PRINTF(GlobalIoTlbFlushes);
+	VP_SEQ_PRINTF(GlobalIoTlbFlushCost);
+	VP_SEQ_PRINTF(LocalIoTlbFlushes);
+	VP_SEQ_PRINTF(LocalIoTlbFlushCost);
+	VP_SEQ_PRINTF(HypercallsForwardedCount);
+	VP_SEQ_PRINTF(HypercallsForwardingTime);
+	VP_SEQ_PRINTF(PageInvalidationsForwardedCount);
+	VP_SEQ_PRINTF(PageInvalidationsForwardingTime);
+	VP_SEQ_PRINTF(ControlRegisterAccessesForwardedCount);
+	VP_SEQ_PRINTF(ControlRegisterAccessesForwardingTime);
+	VP_SEQ_PRINTF(IoInstructionsForwardedCount);
+	VP_SEQ_PRINTF(IoInstructionsForwardingTime);
+	VP_SEQ_PRINTF(HltInstructionsForwardedCount);
+	VP_SEQ_PRINTF(HltInstructionsForwardingTime);
+	VP_SEQ_PRINTF(MwaitInstructionsForwardedCount);
+	VP_SEQ_PRINTF(MwaitInstructionsForwardingTime);
+	VP_SEQ_PRINTF(CpuidInstructionsForwardedCount);
+	VP_SEQ_PRINTF(CpuidInstructionsForwardingTime);
+	VP_SEQ_PRINTF(MsrAccessesForwardedCount);
+	VP_SEQ_PRINTF(MsrAccessesForwardingTime);
+	VP_SEQ_PRINTF(OtherInterceptsForwardedCount);
+	VP_SEQ_PRINTF(OtherInterceptsForwardingTime);
+	VP_SEQ_PRINTF(ExternalInterruptsForwardedCount);
+	VP_SEQ_PRINTF(ExternalInterruptsForwardingTime);
+	VP_SEQ_PRINTF(PendingInterruptsForwardedCount);
+	VP_SEQ_PRINTF(PendingInterruptsForwardingTime);
+	VP_SEQ_PRINTF(EmulatedInstructionsForwardedCount);
+	VP_SEQ_PRINTF(EmulatedInstructionsForwardingTime);
+	VP_SEQ_PRINTF(DebugRegisterAccessesForwardedCount);
+	VP_SEQ_PRINTF(DebugRegisterAccessesForwardingTime);
+	VP_SEQ_PRINTF(PageFaultInterceptsForwardedCount);
+	VP_SEQ_PRINTF(PageFaultInterceptsForwardingTime);
+	VP_SEQ_PRINTF(VmclearEmulationCount);
+	VP_SEQ_PRINTF(VmclearEmulationTime);
+	VP_SEQ_PRINTF(VmptrldEmulationCount);
+	VP_SEQ_PRINTF(VmptrldEmulationTime);
+	VP_SEQ_PRINTF(VmptrstEmulationCount);
+	VP_SEQ_PRINTF(VmptrstEmulationTime);
+	VP_SEQ_PRINTF(VmreadEmulationCount);
+	VP_SEQ_PRINTF(VmreadEmulationTime);
+	VP_SEQ_PRINTF(VmwriteEmulationCount);
+	VP_SEQ_PRINTF(VmwriteEmulationTime);
+	VP_SEQ_PRINTF(VmxoffEmulationCount);
+	VP_SEQ_PRINTF(VmxoffEmulationTime);
+	VP_SEQ_PRINTF(VmxonEmulationCount);
+	VP_SEQ_PRINTF(VmxonEmulationTime);
+	VP_SEQ_PRINTF(NestedVMEntriesCount);
+	VP_SEQ_PRINTF(NestedVMEntriesTime);
+	VP_SEQ_PRINTF(NestedSLATSoftPageFaultsCount);
+	VP_SEQ_PRINTF(NestedSLATSoftPageFaultsTime);
+	VP_SEQ_PRINTF(NestedSLATHardPageFaultsCount);
+	VP_SEQ_PRINTF(NestedSLATHardPageFaultsTime);
+	VP_SEQ_PRINTF(InvEptAllContextEmulationCount);
+	VP_SEQ_PRINTF(InvEptAllContextEmulationTime);
+	VP_SEQ_PRINTF(InvEptSingleContextEmulationCount);
+	VP_SEQ_PRINTF(InvEptSingleContextEmulationTime);
+	VP_SEQ_PRINTF(InvVpidAllContextEmulationCount);
+	VP_SEQ_PRINTF(InvVpidAllContextEmulationTime);
+	VP_SEQ_PRINTF(InvVpidSingleContextEmulationCount);
+	VP_SEQ_PRINTF(InvVpidSingleContextEmulationTime);
+	VP_SEQ_PRINTF(InvVpidSingleAddressEmulationCount);
+	VP_SEQ_PRINTF(InvVpidSingleAddressEmulationTime);
+	VP_SEQ_PRINTF(NestedTlbPageTableReclamations);
+	VP_SEQ_PRINTF(NestedTlbPageTableEvictions);
+	VP_SEQ_PRINTF(FlushGuestPhysicalAddressSpaceHypercalls);
+	VP_SEQ_PRINTF(FlushGuestPhysicalAddressListHypercalls);
+	VP_SEQ_PRINTF(PostedInterruptNotifications);
+	VP_SEQ_PRINTF(PostedInterruptScans);
+	VP_SEQ_PRINTF(TotalCoreRunTime);
+	VP_SEQ_PRINTF(MaximumRunTime);
+	VP_SEQ_PRINTF(HwpRequestContextSwitches);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket0);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket1);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket2);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket3);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket4);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket5);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket6);
+	VP_SEQ_PRINTF(VmloadEmulationCount);
+	VP_SEQ_PRINTF(VmloadEmulationTime);
+	VP_SEQ_PRINTF(VmsaveEmulationCount);
+	VP_SEQ_PRINTF(VmsaveEmulationTime);
+	VP_SEQ_PRINTF(GifInstructionEmulationCount);
+	VP_SEQ_PRINTF(GifInstructionEmulationTime);
+	VP_SEQ_PRINTF(EmulatedErrataSvmInstructions);
+	VP_SEQ_PRINTF(Placeholder1);
+	VP_SEQ_PRINTF(Placeholder2);
+	VP_SEQ_PRINTF(Placeholder3);
+	VP_SEQ_PRINTF(Placeholder4);
+	VP_SEQ_PRINTF(Placeholder5);
+	VP_SEQ_PRINTF(Placeholder6);
+	VP_SEQ_PRINTF(Placeholder7);
+	VP_SEQ_PRINTF(Placeholder8);
+	VP_SEQ_PRINTF(Placeholder9);
+	VP_SEQ_PRINTF(Placeholder10);
+	VP_SEQ_PRINTF(SchedulingPriority);
+	VP_SEQ_PRINTF(RdpmcInstructionsCount);
+	VP_SEQ_PRINTF(RdpmcInstructionsTime);
+	VP_SEQ_PRINTF(PerfmonPmuMsrAccessesCount);
+	VP_SEQ_PRINTF(PerfmonLbrMsrAccessesCount);
+	VP_SEQ_PRINTF(PerfmonIptMsrAccessesCount);
+	VP_SEQ_PRINTF(PerfmonInterruptCount);
+	VP_SEQ_PRINTF(Vtl1DispatchCount);
+	VP_SEQ_PRINTF(Vtl2DispatchCount);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket0);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket1);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket2);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket3);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket4);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket5);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket6);
+	VP_SEQ_PRINTF(Vtl1RunTime);
+	VP_SEQ_PRINTF(Vtl2RunTime);
+	VP_SEQ_PRINTF(IommuHypercalls);
+	VP_SEQ_PRINTF(CpuGroupHypercalls);
+	VP_SEQ_PRINTF(VsmHypercalls);
+	VP_SEQ_PRINTF(EventLogHypercalls);
+	VP_SEQ_PRINTF(DeviceDomainHypercalls);
+	VP_SEQ_PRINTF(DepositHypercalls);
+	VP_SEQ_PRINTF(SvmHypercalls);
+	VP_SEQ_PRINTF(BusLockAcquisitionCount);
+#elif IS_ENABLED(CONFIG_ARM64)
+	VP_SEQ_PRINTF(SysRegAccessesCount);
+	VP_SEQ_PRINTF(SysRegAccessesTime);
+	VP_SEQ_PRINTF(SmcInstructionsCount);
+	VP_SEQ_PRINTF(SmcInstructionsTime);
+	VP_SEQ_PRINTF(OtherInterceptsCount);
+	VP_SEQ_PRINTF(OtherInterceptsTime);
+	VP_SEQ_PRINTF(ExternalInterruptsCount);
+	VP_SEQ_PRINTF(ExternalInterruptsTime);
+	VP_SEQ_PRINTF(PendingInterruptsCount);
+	VP_SEQ_PRINTF(PendingInterruptsTime);
+	VP_SEQ_PRINTF(GuestPageTableMaps);
+	VP_SEQ_PRINTF(LargePageTlbFills);
+	VP_SEQ_PRINTF(SmallPageTlbFills);
+	VP_SEQ_PRINTF(ReflectedGuestPageFaults);
+	VP_SEQ_PRINTF(MemoryInterceptMessages);
+	VP_SEQ_PRINTF(OtherMessages);
+	VP_SEQ_PRINTF(LogicalProcessorMigrations);
+	VP_SEQ_PRINTF(AddressDomainFlushes);
+	VP_SEQ_PRINTF(AddressSpaceFlushes);
+	VP_SEQ_PRINTF(SyntheticInterrupts);
+	VP_SEQ_PRINTF(VirtualInterrupts);
+	VP_SEQ_PRINTF(ApicSelfIpisSent);
+	VP_SEQ_PRINTF(GpaSpaceHypercalls);
+	VP_SEQ_PRINTF(LogicalProcessorHypercalls);
+	VP_SEQ_PRINTF(LongSpinWaitHypercalls);
+	VP_SEQ_PRINTF(OtherHypercalls);
+	VP_SEQ_PRINTF(SyntheticInterruptHypercalls);
+	VP_SEQ_PRINTF(VirtualInterruptHypercalls);
+	VP_SEQ_PRINTF(VirtualMmuHypercalls);
+	VP_SEQ_PRINTF(VirtualProcessorHypercalls);
+	VP_SEQ_PRINTF(HardwareInterrupts);
+	VP_SEQ_PRINTF(NestedPageFaultInterceptsCount);
+	VP_SEQ_PRINTF(NestedPageFaultInterceptsTime);
+	VP_SEQ_PRINTF(LogicalProcessorDispatches);
+	VP_SEQ_PRINTF(WaitingForCpuTime);
+	VP_SEQ_PRINTF(ExtendedHypercalls);
+	VP_SEQ_PRINTF(ExtendedHypercallInterceptMessages);
+	VP_SEQ_PRINTF(MbecNestedPageTableSwitches);
+	VP_SEQ_PRINTF(OtherReflectedGuestExceptions);
+	VP_SEQ_PRINTF(GlobalIoTlbFlushes);
+	VP_SEQ_PRINTF(GlobalIoTlbFlushCost);
+	VP_SEQ_PRINTF(LocalIoTlbFlushes);
+	VP_SEQ_PRINTF(LocalIoTlbFlushCost);
+	VP_SEQ_PRINTF(FlushGuestPhysicalAddressSpaceHypercalls);
+	VP_SEQ_PRINTF(FlushGuestPhysicalAddressListHypercalls);
+	VP_SEQ_PRINTF(PostedInterruptNotifications);
+	VP_SEQ_PRINTF(PostedInterruptScans);
+	VP_SEQ_PRINTF(TotalCoreRunTime);
+	VP_SEQ_PRINTF(MaximumRunTime);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket0);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket1);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket2);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket3);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket4);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket5);
+	VP_SEQ_PRINTF(WaitingForCpuTimeBucket6);
+	VP_SEQ_PRINTF(HwpRequestContextSwitches);
+	VP_SEQ_PRINTF(Placeholder2);
+	VP_SEQ_PRINTF(Placeholder3);
+	VP_SEQ_PRINTF(Placeholder4);
+	VP_SEQ_PRINTF(Placeholder5);
+	VP_SEQ_PRINTF(Placeholder6);
+	VP_SEQ_PRINTF(Placeholder7);
+	VP_SEQ_PRINTF(Placeholder8);
+	VP_SEQ_PRINTF(ContentionTime);
+	VP_SEQ_PRINTF(WakeUpTime);
+	VP_SEQ_PRINTF(SchedulingPriority);
+	VP_SEQ_PRINTF(Vtl1DispatchCount);
+	VP_SEQ_PRINTF(Vtl2DispatchCount);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket0);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket1);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket2);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket3);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket4);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket5);
+	VP_SEQ_PRINTF(Vtl2DispatchBucket6);
+	VP_SEQ_PRINTF(Vtl1RunTime);
+	VP_SEQ_PRINTF(Vtl2RunTime);
+	VP_SEQ_PRINTF(IommuHypercalls);
+	VP_SEQ_PRINTF(CpuGroupHypercalls);
+	VP_SEQ_PRINTF(VsmHypercalls);
+	VP_SEQ_PRINTF(EventLogHypercalls);
+	VP_SEQ_PRINTF(DeviceDomainHypercalls);
+	VP_SEQ_PRINTF(DepositHypercalls);
+	VP_SEQ_PRINTF(SvmHypercalls);
+#endif
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(vp_stats);
+
+static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index, void *stats_page_addr,
+				enum hv_stats_area_type stats_area_type)
+{
+	union hv_stats_object_identity identity = {
+		.vp.partition_id = partition_id,
+		.vp.vp_index = vp_index,
+		.vp.stats_area_type = stats_area_type,
+	};
+	int err;
+
+	err = hv_unmap_stats_page(HV_STATS_OBJECT_VP, stats_page_addr, &identity);
+	if (err)
+		pr_err("%s: failed to unmap partition %llu vp %u %s stats, err: %d\n",
+		       __func__, partition_id, vp_index,
+		       (stats_area_type == HV_STATS_AREA_SELF) ? "self" : "parent",
+		       err);
+}
+
+static void *mshv_vp_stats_map(u64 partition_id, u32 vp_index,
+			       enum hv_stats_area_type stats_area_type)
+{
+	union hv_stats_object_identity identity = {
+		.vp.partition_id = partition_id,
+		.vp.vp_index = vp_index,
+		.vp.stats_area_type = stats_area_type,
+	};
+	void *stats;
+	int err;
+
+	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity, &stats);
+	if (err) {
+		pr_err("%s: failed to map partition %llu vp %u %s stats, err: %d\n",
+		       __func__, partition_id, vp_index,
+		       (stats_area_type == HV_STATS_AREA_SELF) ? "self" : "parent",
+		       err);
+		return ERR_PTR(err);
+	}
+	return stats;
+}
+
+static int vp_debugfs_stats_create(u64 partition_id, u32 vp_index,
+				   struct dentry **vp_stats_ptr,
+				   struct dentry *parent)
+{
+	struct dentry *dentry;
+	struct hv_stats_page **pstats;
+	int err;
+
+	pstats = kcalloc(2, sizeof(struct hv_stats_page *), GFP_KERNEL_ACCOUNT);
+	if (!pstats)
+		return -ENOMEM;
+
+	pstats[HV_STATS_AREA_SELF] = mshv_vp_stats_map(partition_id, vp_index,
+						       HV_STATS_AREA_SELF);
+	if (IS_ERR(pstats[HV_STATS_AREA_SELF])) {
+		err = PTR_ERR(pstats[HV_STATS_AREA_SELF]);
+		goto cleanup;
+	}
+
+	/*
+	 * L1VH partition cannot access its vp stats in parent area.
+	 */
+	if (is_l1vh_parent(partition_id)) {
+		pstats[HV_STATS_AREA_PARENT] = pstats[HV_STATS_AREA_SELF];
+	} else {
+		pstats[HV_STATS_AREA_PARENT] = mshv_vp_stats_map(
+			partition_id, vp_index, HV_STATS_AREA_PARENT);
+		if (IS_ERR(pstats[HV_STATS_AREA_PARENT])) {
+			err = PTR_ERR(pstats[HV_STATS_AREA_PARENT]);
+			goto unmap_self;
+		}
+		if (!pstats[HV_STATS_AREA_PARENT])
+			pstats[HV_STATS_AREA_PARENT] = pstats[HV_STATS_AREA_SELF];
+	}
+
+	dentry = debugfs_create_file("stats", 0400, parent,
+				     pstats, &vp_stats_fops);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto unmap_vp_stats;
+	}
+
+	*vp_stats_ptr = dentry;
+	return 0;
+
+unmap_vp_stats:
+	if (pstats[HV_STATS_AREA_PARENT] != pstats[HV_STATS_AREA_SELF])
+		mshv_vp_stats_unmap(partition_id, vp_index, pstats[HV_STATS_AREA_PARENT],
+				    HV_STATS_AREA_PARENT);
+unmap_self:
+	mshv_vp_stats_unmap(partition_id, vp_index, pstats[HV_STATS_AREA_SELF],
+			    HV_STATS_AREA_SELF);
+cleanup:
+	kfree(pstats);
+	return err;
+}
+
+static void vp_debugfs_remove(u64 partition_id, u32 vp_index,
+			      struct dentry *vp_stats)
+{
+	struct hv_stats_page **pstats = NULL;
+	void *stats;
+
+	pstats = vp_stats->d_inode->i_private;
+	debugfs_remove_recursive(vp_stats->d_parent);
+	if (pstats[HV_STATS_AREA_PARENT] != pstats[HV_STATS_AREA_SELF]) {
+		stats = pstats[HV_STATS_AREA_PARENT];
+		mshv_vp_stats_unmap(partition_id, vp_index, stats,
+				    HV_STATS_AREA_PARENT);
+	}
+
+	stats = pstats[HV_STATS_AREA_SELF];
+	mshv_vp_stats_unmap(partition_id, vp_index, stats, HV_STATS_AREA_SELF);
+
+	kfree(pstats);
+}
+
+static int vp_debugfs_create(u64 partition_id, u32 vp_index,
+			     struct dentry **vp_stats_ptr,
+			     struct dentry *parent)
+{
+	struct dentry *vp_idx_dir;
+	char vp_idx_str[U32_BUF_SZ];
+	int err;
+
+	sprintf(vp_idx_str, "%u", vp_index);
+
+	vp_idx_dir = debugfs_create_dir(vp_idx_str, parent);
+	if (IS_ERR(vp_idx_dir))
+		return PTR_ERR(vp_idx_dir);
+
+	err = vp_debugfs_stats_create(partition_id, vp_index, vp_stats_ptr,
+				      vp_idx_dir);
+	if (err)
+		goto remove_debugfs_vp_idx;
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
+
+#define PARTITION_SEQ_PRINTF(cnt)				 \
+do {								 \
+	if (pstats[HV_STATS_AREA_SELF]->pt_cntrs[Partition##cnt]) \
+		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
+			pstats[HV_STATS_AREA_SELF]->pt_cntrs[Partition##cnt]); \
+	else \
+		seq_printf(m, "%-30s: %llu\n", __stringify(cnt), \
+			pstats[HV_STATS_AREA_PARENT]->pt_cntrs[Partition##cnt]); \
+} while (0)
+
+	PARTITION_SEQ_PRINTF(VirtualProcessors);
+	PARTITION_SEQ_PRINTF(TlbSize);
+	PARTITION_SEQ_PRINTF(AddressSpaces);
+	PARTITION_SEQ_PRINTF(DepositedPages);
+	PARTITION_SEQ_PRINTF(GpaPages);
+	PARTITION_SEQ_PRINTF(GpaSpaceModifications);
+	PARTITION_SEQ_PRINTF(VirtualTlbFlushEntires);
+	PARTITION_SEQ_PRINTF(RecommendedTlbSize);
+	PARTITION_SEQ_PRINTF(GpaPages4K);
+	PARTITION_SEQ_PRINTF(GpaPages2M);
+	PARTITION_SEQ_PRINTF(GpaPages1G);
+	PARTITION_SEQ_PRINTF(GpaPages512G);
+	PARTITION_SEQ_PRINTF(DevicePages4K);
+	PARTITION_SEQ_PRINTF(DevicePages2M);
+	PARTITION_SEQ_PRINTF(DevicePages1G);
+	PARTITION_SEQ_PRINTF(DevicePages512G);
+	PARTITION_SEQ_PRINTF(AttachedDevices);
+	PARTITION_SEQ_PRINTF(DeviceInterruptMappings);
+	PARTITION_SEQ_PRINTF(IoTlbFlushes);
+	PARTITION_SEQ_PRINTF(IoTlbFlushCost);
+	PARTITION_SEQ_PRINTF(DeviceInterruptErrors);
+	PARTITION_SEQ_PRINTF(DeviceDmaErrors);
+	PARTITION_SEQ_PRINTF(DeviceInterruptThrottleEvents);
+	PARTITION_SEQ_PRINTF(SkippedTimerTicks);
+	PARTITION_SEQ_PRINTF(PartitionId);
+#if IS_ENABLED(CONFIG_X86_64)
+	PARTITION_SEQ_PRINTF(NestedTlbSize);
+	PARTITION_SEQ_PRINTF(RecommendedNestedTlbSize);
+	PARTITION_SEQ_PRINTF(NestedTlbFreeListSize);
+	PARTITION_SEQ_PRINTF(NestedTlbTrimmedPages);
+	PARTITION_SEQ_PRINTF(PagesShattered);
+	PARTITION_SEQ_PRINTF(PagesRecombined);
+	PARTITION_SEQ_PRINTF(HwpRequestValue);
+#elif IS_ENABLED(CONFIG_ARM64)
+	PARTITION_SEQ_PRINTF(HwpRequestValue);
+#endif
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(partition_stats);
+
+static void mshv_partition_stats_unmap(u64 partition_id, void *stats_page_addr,
+				       enum hv_stats_area_type stats_area_type)
+{
+	union hv_stats_object_identity identity = {
+		.partition.partition_id = partition_id,
+		.partition.stats_area_type = stats_area_type,
+	};
+	int err;
+
+	err = hv_unmap_stats_page(HV_STATS_OBJECT_PARTITION, stats_page_addr,
+				  &identity);
+	if (err) {
+		pr_err("%s: failed to unmap partition %lld %s stats, err: %d\n",
+		       __func__, partition_id,
+		       (stats_area_type == HV_STATS_AREA_SELF) ? "self" : "parent",
+		       err);
+	}
+}
+
+static void *mshv_partition_stats_map(u64 partition_id,
+				      enum hv_stats_area_type stats_area_type)
+{
+	union hv_stats_object_identity identity = {
+		.partition.partition_id = partition_id,
+		.partition.stats_area_type = stats_area_type,
+	};
+	void *stats;
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
+	pstats = kcalloc(2, sizeof(struct hv_stats_page *), GFP_KERNEL_ACCOUNT);
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
+	void *stats;
+
+	pstats = dentry->d_inode->i_private;
+
+	debugfs_remove_recursive(dentry->d_parent);
+
+	if (pstats[HV_STATS_AREA_PARENT] != pstats[HV_STATS_AREA_SELF]) {
+		stats = pstats[HV_STATS_AREA_PARENT];
+		mshv_partition_stats_unmap(partition_id, stats, HV_STATS_AREA_PARENT);
+	}
+
+	stats = pstats[HV_STATS_AREA_SELF];
+	mshv_partition_stats_unmap(partition_id, stats, HV_STATS_AREA_SELF);
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
+static void mshv_debugfs_parent_partition_remove(void)
+{
+	int idx;
+
+	for_each_online_cpu(idx)
+		vp_debugfs_remove(hv_current_partition_id, idx, NULL);
+
+	partition_debugfs_remove(hv_current_partition_id, NULL);
+}
+
+static int __init mshv_debugfs_parent_partition_create(void)
+{
+	struct dentry *partition_stats, *vp_dir;
+	int err, idx, i;
+
+	mshv_debugfs_partition = debugfs_create_dir("partition",
+						     mshv_debugfs);
+	if (IS_ERR(mshv_debugfs_partition))
+		return PTR_ERR(mshv_debugfs_partition);
+
+	err = partition_debugfs_create(hv_current_partition_id,
+				       &vp_dir,
+				       &partition_stats,
+				       mshv_debugfs_partition);
+	if (err)
+		goto remove_debugfs_partition;
+
+	for_each_online_cpu(idx) {
+		struct dentry *vp_stats;
+
+		err = vp_debugfs_create(hv_current_partition_id,
+					hv_vp_index[idx],
+					&vp_stats,
+					vp_dir);
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
+		vp_debugfs_remove(hv_current_partition_id, i, NULL);
+	}
+	partition_debugfs_remove(hv_current_partition_id, NULL);
+remove_debugfs_partition:
+	debugfs_remove_recursive(mshv_debugfs_partition);
+	return err;
+}
+
+static int hv_stats_show(struct seq_file *m, void *v)
+{
+	const struct hv_stats_page *stats = m->private;
+
+#define HV_SEQ_PRINTF(cnt)		\
+	seq_printf(m, "%-25s: %llu\n", __stringify(cnt), stats->hv_cntrs[Hv##cnt])
+
+	HV_SEQ_PRINTF(LogicalProcessors);
+	HV_SEQ_PRINTF(Partitions);
+	HV_SEQ_PRINTF(TotalPages);
+	HV_SEQ_PRINTF(VirtualProcessors);
+	HV_SEQ_PRINTF(MonitoredNotifications);
+	HV_SEQ_PRINTF(ModernStandbyEntries);
+	HV_SEQ_PRINTF(PlatformIdleTransitions);
+	HV_SEQ_PRINTF(HypervisorStartupCost);
+	HV_SEQ_PRINTF(IOSpacePages);
+	HV_SEQ_PRINTF(NonEssentialPagesForDump);
+	HV_SEQ_PRINTF(SubsumedPages);
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
+	void *stats;
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
+	mshv_lps_count = stats[HvLogicalProcessors];
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
+	int err;
+
+	if (!mshv_debugfs)
+		return 0;
+
+	err = vp_debugfs_create(p->pt_id, vp->vp_index,
+				&vp->vp_debugfs_stats_dentry,
+				p->pt_debugfs_vp_dentry);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+void mshv_debugfs_vp_remove(struct mshv_vp *vp)
+{
+	if (!mshv_debugfs)
+		return;
+
+	vp_debugfs_remove(vp->vp_partition->pt_id, vp->vp_index,
+			  vp->vp_debugfs_stats_dentry);
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
+				       &partition->pt_debugfs_vp_dentry,
+				       &partition->pt_debugfs_stats_dentry,
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
+				 partition->pt_debugfs_stats_dentry);
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
+	if (hv_root_partition())
+		mshv_debugfs_lp_remove();
+unmap_hv_stats:
+	if (hv_root_partition())
+		mshv_hv_stats_unmap();
+remove_mshv_dir:
+	debugfs_remove_recursive(mshv_debugfs);
+	return err;
+}
+
+void mshv_debugfs_exit(void)
+{
+	mshv_debugfs_parent_partition_remove();
+
+	if (hv_root_partition()) {
+		mshv_debugfs_lp_remove();
+		mshv_hv_stats_unmap();
+	}
+
+	debugfs_remove_recursive(mshv_debugfs);
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 3eb815011b46..1f1b1984449b 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -51,6 +51,9 @@ struct mshv_vp {
 		unsigned int kicked_by_hv;
 		wait_queue_head_t vp_suspend_queue;
 	} run;
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct dentry *vp_debugfs_stats_dentry;
+#endif
 };
 
 #define vp_fmt(fmt) "p%lluvp%u: " fmt
@@ -128,6 +131,10 @@ struct mshv_partition {
 	u64 isolation_type;
 	bool import_completed;
 	bool pt_initialized;
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct dentry *pt_debugfs_stats_dentry;
+	struct dentry *pt_debugfs_vp_dentry;
+#endif
 };
 
 #define pt_fmt(fmt) "p%llu: " fmt
@@ -308,6 +315,33 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
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
index 19006b788e85..152fcd9b45e6 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -982,6 +982,10 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
 
+	ret = mshv_debugfs_vp_create(vp);
+	if (ret)
+		goto put_partition;
+
 	/*
 	 * Keep anon_inode_getfd last: it installs fd in the file struct and
 	 * thus makes the state accessible in user space.
@@ -989,7 +993,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 	ret = anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
 			       O_RDWR | O_CLOEXEC);
 	if (ret < 0)
-		goto put_partition;
+		goto remove_debugfs_vp;
 
 	/* already exclusive with the partition mutex for all ioctls */
 	partition->pt_vp_count++;
@@ -997,6 +1001,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 
 	return ret;
 
+remove_debugfs_vp:
+	mshv_debugfs_vp_remove(vp);
 put_partition:
 	mshv_partition_put(partition);
 free_vp:
@@ -1556,13 +1562,18 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 
 	ret = hv_call_initialize_partition(partition->pt_id);
 	if (ret)
-		goto withdraw_mem;
+		return ret;
+
+	ret = mshv_debugfs_partition_create(partition);
+	if (ret)
+		goto finalize_partition;
 
 	partition->pt_initialized = true;
 
 	return 0;
 
-withdraw_mem:
+finalize_partition:
+	hv_call_finalize_partition(partition->pt_id);
 	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
 
 	return ret;
@@ -1741,6 +1752,8 @@ static void destroy_partition(struct mshv_partition *partition)
 			if (!vp)
 				continue;
 
+			mshv_debugfs_vp_remove(vp);
+
 			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
 						    (void **)vp->vp_stats_pages);
@@ -1775,6 +1788,8 @@ static void destroy_partition(struct mshv_partition *partition)
 			partition->pt_vp_array[i] = NULL;
 		}
 
+		mshv_debugfs_partition_remove(partition);
+
 		/* Deallocates and unmaps everything including vcpus, GPA mappings etc */
 		hv_call_finalize_partition(partition->pt_id);
 
@@ -2351,10 +2366,14 @@ static int __init mshv_parent_partition_init(void)
 
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
 
@@ -2362,6 +2381,10 @@ static int __init mshv_parent_partition_init(void)
 
 	return 0;
 
+destroy_irqds_wq:
+	mshv_irqfd_wq_cleanup();
+exit_debugfs:
+	mshv_debugfs_exit();
 exit_partition:
 	if (hv_root_partition())
 		mshv_root_partition_exit();
@@ -2378,6 +2401,7 @@ static void __exit mshv_parent_partition_exit(void)
 {
 	hv_setup_mshv_handler(NULL);
 	mshv_port_table_fini();
+	mshv_debugfs_exit();
 	misc_deregister(&mshv_dev);
 	mshv_irqfd_wq_cleanup();
 	if (hv_root_partition())
-- 
2.34.1


