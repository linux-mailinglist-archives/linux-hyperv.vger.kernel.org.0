Return-Path: <linux-hyperv+bounces-11277-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDKmJsWPF2oUJQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11277-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B75EB54F
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95F0A3029A5C
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FD615A85A;
	Thu, 28 May 2026 00:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L1MrNbUn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229291C84AB;
	Thu, 28 May 2026 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928957; cv=none; b=I1XBTPQNK0WcRZQiT+QgcXj3rO1Wvco8rY0RS+V0l3NK7EKDGLi+1NisyY0HOrUO6Bgy8lRoOGWQLKWqEoyAOthUcoFMYGyS7xyzuwPDXvpx9V1I1BmJRzpNaUKoZfnwjb30p0oW/tY1aq/BvByhHhfqEvijFThQrsU246ZPF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928957; c=relaxed/simple;
	bh=biH2szOnhJg86IJ9VS9pW4GbnaB236hGzTOqjiGBt8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdoJyf5EOfhUbkI7LzyG+qHSWFIo6QyQbOi93bU+h/BQbj5yO1YFq/PcAhqx+Qv8IQZPn/WWVmdC0K98ek6eHt4iZfQmKFPIvde6NY2hW0iSp2qvvFXq22uTjso3yaefx5UTbsOlOuT4a2G1+IbhLwP44kN8Iw+pvy90jRcVNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L1MrNbUn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 8823120B717B; Wed, 27 May 2026 17:42:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8823120B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928938;
	bh=GXatuMO/Fdjo1jy8ticG6q7fzNlcTDCEPHvUu9k6XTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1MrNbUnl/bErE+GLw9HkkjzskqoK7iud5XrEq+OeWG2+T2sOAFJjOi2GFtbc2Yes
	 hm/RFZ8SG+bQV9DEktiBvoSAD2TJs48jxv/gP+eV9+5DDplNG7oFfqyxc+uKmPg8IQ
	 MmOtFPTJQnM1YU/9If1U44KJl0gWnwzDq7STNasM=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 10/20] kho: extended scratch
Date: Wed, 27 May 2026 17:41:52 -0700
Message-ID: <20260528004204.1484584-11-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,lists.infradead.org,vger.kernel.org,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11277-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 228B75EB54F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Motivation
==========

The scratch space is allocated by the first kernel in the KHO chain, and
is reused by all subsequent kernels. The size of the space is either set
via the commandline by the system administrator or by calculating the
amount of memory used by the kernel and adding a multiplier. In either
case, the scratch space is a heuristic and is liable to fill up and fail
allocation if a kernel uses more memory than expected.

In addition, gigantic huge pages (usually 1 GiB) are allocated via
memblock, and in a KHO boot that memory comes from the scratch space. In
hypervisors it is common to dedicate a major part of the system's memory
to gigantic hugepages for VM memory.

If this memory needs to come from scratch space, then scratch needs to
be greater than the memory needed for huge pages, which is impractical.
In addition, hugepages can be preserved memory. Allocating them from
scratch violates the assumption that scratch contains no preserved
memory.

Methodology
===========

Introduce extended scratch areas. These areas are discovered at boot by
walking the preserved memory radix tree and looking for free blocks of
memory. They then marked as scratch to allow allocations from them. This
makes KHO more resilient to memory pressure and allows supporting huge
page preservation.

Since the preserved memory radix tree mixes both physical address and
order into a single key, and does not track table pages, it is difficult
to identify free areas from it directly. Walk the tree and digest it
down into another radix tree. The latter tracks blocks of
KHO_EXT_SHIFT (1 GiB as of now) granularity. Then walk the digested tree
and mark the areas between the present keys as scratch.

Performance
===========

The discovery algorithm traverses the preserved memory radix tree
exactly once. While it does use memory for the digested radix tree,
since the blocks are split by 1 GiB, a single bitmap with 4k pages can
track up to 32 TiB of memory. So there are likely to be very few radix
tree pages used in this tracking. For systems with all physical memory
below 32 TiB, this should result in a total of 6 pages being
used (KHO_TREE_MAX_DEPTH == 6).

An alternate way of achieving this would be to call kho_mem_retrieve()
earlier in boot and mark all the KHO preservations as reserved. But that
can blow up memblock.reserved with a bunch of 4K pages scattered
everywhere, which will reduce performance of subsequent allocations.
Since the free blocks are tracked in chunks of 1 GiB, this won't blow up
memblock.memory as much.

Practical evaluation
====================

The testing is done on a x86_64 qemu VM running under KVM with 64G
memory and 12 CPUs. The machine pre-allocates 50 1G pages.

Since the performance scales with how busy the radix tree is, tests are
done with 2 preservation patterns: first with two 1M memfds, second with
two 1G memfds, both using 4k pages.

Test case 1 - 1M memfd
~~~~~~~~~~~~~~~~~~~~~~

This test case has two memfds with 1M memory each in 4k pages, plus
other preservations from LUO core and other KHO users.

This is how the radix tree stats look like:

    radix_nodes:       0x2f
    nr_preservations:  0x22d
    mem_preserved:     0xa2b000

    per order preservations:
    order  0:  0x215
    order  1:  0x9
    order  2:  0x1
    order  3:  0x2
    order  4:  0x5
    order  5:  0x1
    order  6:  0x2
    order  7:  0x2
    order  9:  0x1
    order 10:  0x1

and this is how long it takes to extend the scratch after KHO boot:

    kho_extend_scratch(): time taken: 88 us
    kho_extend_scratch(): total memory recovered: 0xf7ff7b000 (~62G)

Test case 2 - 1G memfd
~~~~~~~~~~~~~~~~~~~~~~

This test case has two memfds with 1G memory each in 4k pages, plus
other preservations from LUO core and other KHO users.

This is how the radix tree stats look like:

    radix_nodes:       0x45
    nr_preservations:  0x80832
    mem_preserved:     0x8102d000

    per order preservations:
    order  0:  0x80817
    order  1:  0x7
    order  2:  0x2
    order  3:  0x4
    order  4:  0x2
    order  5:  0x2
    order  6:  0x4
    order  7:  0x3
    order  8:  0x1
    order  9:  0x2

and this is how long it takes to extend the scratch after KHO boot:

    kho_extend_scratch(): time taken: 21769 us
    kho_extend_scratch(): total memory recovered: 0xe40000000 (57G)

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 include/linux/kexec_handover.h     |   1 +
 kernel/liveupdate/kexec_handover.c | 148 +++++++++++++++++++++++++----
 mm/mm_init.c                       |   1 +
 3 files changed, 133 insertions(+), 17 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 8968c56d2d73..6ce46f36ed99 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -37,6 +37,7 @@ void kho_remove_subtree(void *blob);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
 
 void kho_memory_init(void);
+void kho_extend_scratch(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b2d1572808eb..a006a883ee94 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -84,6 +84,23 @@ static struct kho_out kho_out = {
 	},
 };
 
+struct kho_in {
+	phys_addr_t fdt_phys;
+	phys_addr_t scratch_phys;
+	char previous_release[__NEW_UTS_LEN + 1];
+	u32 kexec_count;
+	struct kho_debugfs dbg;
+	struct kho_radix_tree radix_tree;
+};
+
+static struct kho_in kho_in = {
+};
+
+static const void *kho_get_fdt(void)
+{
+	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
+}
+
 /**
  * kho_encode_radix_key - Encodes a physical address and order into a radix key.
  * @phys: The physical address of the page.
@@ -825,6 +842,120 @@ static void __init kho_reserve_scratch(void)
 	kho_enable = false;
 }
 
+#define KHO_EXT_SHIFT 30 /* 1 GiB */
+
+static int __init kho_ext_walk_key(unsigned long key, void *data)
+{
+	struct kho_radix_tree *tree = data;
+	phys_addr_t start, end;
+	unsigned int order;
+	int err;
+
+	start = kho_decode_radix_key(key, &order);
+	end = start + (1UL << (order + PAGE_SHIFT));
+
+	while (start < end) {
+		err = kho_radix_add_key(tree, start >> KHO_EXT_SHIFT);
+		if (err)
+			return err;
+
+		start += (1UL << KHO_EXT_SHIFT);
+	}
+
+	return 0;
+}
+
+static int __init kho_ext_walk_table(phys_addr_t phys, void *data)
+{
+	struct kho_radix_tree *tree = data;
+
+	return kho_radix_add_key(tree, phys >> KHO_EXT_SHIFT);
+}
+
+static int __init kho_ext_mark_scratch(unsigned long key, void *data)
+{
+	phys_addr_t *prev_end = data;
+	phys_addr_t start = key << KHO_EXT_SHIFT;
+	int err;
+
+	if (start > *prev_end) {
+		err = memblock_mark_kho_scratch_ext(*prev_end, start - *prev_end);
+		if (err)
+			return err;
+	}
+
+	*prev_end = start + (1UL << KHO_EXT_SHIFT);
+	return 0;
+}
+
+/**
+ * kho_extend_scratch - Extend the scratch regions
+ *
+ * The KHO radix tree mixes both physical address and order into a single key.
+ * This makes it hard to look for free ranges directly. This function first
+ * walks the radix tree and digests it down into another radix tree, whose keys
+ * identify blocks of KHO_EXT_SHIFT which contain preserved memory.
+ *
+ * Then it walks the digested radix tree and marks everything that doesn't have
+ * preserved memory as scratch.
+ *
+ * NOTE: This function allocates memory so it should be called when scratch has
+ * available space.
+ *
+ * NOTE: The pages of the KHO radix tree tables are not marked as preserved in
+ * the KHO tree. But they are expected to remain untouched until the tree is
+ * fully parsed. So this function also considers them to be "preserved memory"
+ * and marks their blocks as busy.
+ */
+void __init kho_extend_scratch(void)
+{
+	const struct kho_radix_walk_cb kho_cb = {
+		.key = kho_ext_walk_key,
+		.table = kho_ext_walk_table,
+	};
+	const struct kho_radix_walk_cb ext_cb = {
+		.key = kho_ext_mark_scratch,
+	};
+	struct kho_radix_tree radix;
+	phys_addr_t prev_end = 0, mem_map_phys;
+	int err = 0;
+
+	if (!is_kho_boot())
+		return;
+
+	/* Make sure the KHO radix tree is initialized. */
+	mem_map_phys = kho_get_mem_map_phys(kho_get_fdt());
+	err = kho_radix_init_tree(&kho_in.radix_tree, phys_to_virt(mem_map_phys));
+	if (err)
+		goto print;
+
+	err = kho_radix_init_tree(&radix, NULL);
+	if (err)
+		goto print;
+
+	/* Walk the KHO radix tree to find busy blocks. */
+	err = kho_radix_walk_tree(&kho_in.radix_tree, &kho_cb, &radix);
+	if (err)
+		goto out;
+
+	/* Walk the blocks and mark everything between keys as scratch. */
+	err = kho_radix_walk_tree(&radix, &ext_cb, &prev_end);
+	if (err)
+		goto out;
+
+	/* Mark everything from last busy block to end of DRAM. */
+	if (prev_end < memblock_end_of_DRAM())
+		err = memblock_mark_kho_scratch_ext(prev_end,
+						    memblock_end_of_DRAM() - prev_end);
+
+	/* fallthrough */
+out:
+	kho_radix_destroy_tree(&radix);
+print:
+	if (err)
+		pr_err("Failed to extend scratch: %pe\n", ERR_PTR(err));
+}
+
 /**
  * kho_add_subtree - record the physical address of a sub blob in KHO root tree.
  * @name: name of the sub tree.
@@ -1406,23 +1537,6 @@ void kho_restore_free(void *mem)
 }
 EXPORT_SYMBOL_GPL(kho_restore_free);
 
-struct kho_in {
-	phys_addr_t fdt_phys;
-	phys_addr_t scratch_phys;
-	char previous_release[__NEW_UTS_LEN + 1];
-	u32 kexec_count;
-	struct kho_debugfs dbg;
-	struct kho_radix_tree radix_tree;
-};
-
-static struct kho_in kho_in = {
-};
-
-static const void *kho_get_fdt(void)
-{
-	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
-}
-
 /**
  * is_kho_boot - check if current kernel was booted via KHO-enabled
  * kexec
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 6de3a77eb9ae..bbca4cc9b912 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2702,6 +2702,7 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
+	kho_extend_scratch();
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 
-- 
2.43.0


