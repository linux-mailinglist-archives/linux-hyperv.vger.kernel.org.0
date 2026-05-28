Return-Path: <linux-hyperv+bounces-11275-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGxuC8KPF2oUJQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11275-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF725EB547
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CAD53051A73
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866AB231836;
	Thu, 28 May 2026 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XVCPSidA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F0229B12;
	Thu, 28 May 2026 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928957; cv=none; b=p9HvKeg0f7j7hsDPap9spOXt3wWa7LD9kHUdNQpbBkGR++zjvbMxfvMhNax/u07PCfT85a5qdRMRdaVEKF7OFn9V/6FGloWKehHVmZ8GXgLJttaGU+GqfTFHdEzGHd1v3ynlC90BIuyC00GVqFi/VBQz+NlVtDeG0KqZd6Obas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928957; c=relaxed/simple;
	bh=kVJRvL3fmxjQ5nGQ9PNwvAvuXzx0DnSQAZMGq+ML9p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dr1H62Jt2oRQoYj/FMIKiodsBCH3UlsiR4SGkH1/KQkKjnF1/Wwwu04AvwdvMEY+Eo4mmZG4TVItIlh8lgavLv4SR2vxBzGKFiGzbrnwLZ6wliZ9k3qPPW24j7jF4utQOBCIQ19QFN+Hslq1XHZkqhCCKZW34lzONzGsLBnH7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XVCPSidA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 1B1D820B7175; Wed, 27 May 2026 17:42:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B1D820B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928942;
	bh=w9dQKTBesfWptSkwPiRIMzAcNQuxg/BKJwCMO44AZfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVCPSidAnGdHB1XpCGnE5OzRo9wqEl3lK8az8GeJAkdMTDi6QvS5UgoQ9IgB915Pd
	 dlJU0HBIv+wFptvDvgMWvzcBah1eeYO7dGzeeoC4bVOKKk20uPM0w/8SyfDk1WOWkk
	 7ZoEp3xh9hJ0xuG840/IpGNcOfkm0h7aJbTCn+3M=
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
Subject: [RFC PATCH 14/20] kho: Add crash-kernel-safe radix tree presence check
Date: Wed, 27 May 2026 17:41:56 -0700
Message-ID: <20260528004204.1484584-15-jloeser@linux.microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-11275-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 9EF725EB547
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the crash kernel, the old kernel's memory is outside the direct
map. Add a read-only radix tree variant that memremaps nodes during
init so that subsequent page presence checks can traverse the tree
with plain pointer dereferencing.

This will be used by the MSHV driver to exclude hypervisor-owned pages
from /proc/vmcore via a pfn_is_ram() callback.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 include/linux/kho_radix_tree.h     |  30 +++++++
 kernel/liveupdate/kexec_handover.c | 124 +++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index 4fe2238e1e30..e906a874e612 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -49,6 +49,19 @@ struct kho_radix_walk_cb {
 	int (*table)(phys_addr_t phys, void *data);
 };
 
+/**
+ * struct kho_radix_crash_tree - Read-only radix tree for crash kernel use.
+ * @root: pointer to the remapped root node
+ *
+ * In the crash kernel, the old kernel's memory is not in the direct map.
+ * This variant uses memremap() during init to map the tree nodes and
+ * converts the physical address table entries to virtual addresses in-place,
+ * enabling efficient pointer-based traversal without per-lookup remapping.
+ */
+struct kho_radix_crash_tree {
+	struct kho_radix_node *root;
+};
+
 #ifdef CONFIG_KEXEC_HANDOVER
 
 int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
@@ -59,6 +72,11 @@ int kho_radix_init_tree(struct kho_radix_tree *tree, struct kho_radix_node *root
 void kho_radix_destroy_tree(struct kho_radix_tree *tree);
 int kho_radix_tree_freeze(struct kho_radix_tree *tree);
 
+int kho_radix_crash_init(struct kho_radix_crash_tree *tree, phys_addr_t root_pa);
+
+bool kho_radix_crash_contains_page(struct kho_radix_crash_tree *tree,
+				   unsigned long pfn, unsigned int order);
+
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
 
 static inline int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
@@ -91,6 +109,18 @@ static inline int kho_radix_tree_freeze(struct kho_radix_tree *tree)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_radix_crash_init(struct kho_radix_crash_tree *tree,
+				       phys_addr_t root_pa)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool kho_radix_crash_contains_page(
+					struct kho_radix_crash_tree *tree,
+					unsigned long pfn, unsigned int order)
+{
+	return false;
+}
 #endif /* #ifdef CONFIG_KEXEC_HANDOVER */
 
 #endif	/* _LINUX_KHO_RADIX_TREE_H */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 2e2b4e73f00d..0dfdf0f9781e 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -15,6 +15,7 @@
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
 #include <linux/kasan.h>
+#include <linux/io.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho_radix_tree.h>
@@ -396,6 +397,129 @@ void kho_radix_destroy_tree(struct kho_radix_tree *tree)
 }
 EXPORT_SYMBOL_GPL(kho_radix_destroy_tree);
 
+/*
+ * Convert a crash tree node's children from PA to VA in-place via memremap().
+ * On failure, already-remapped pages are not cleaned up -- the crash kernel
+ * is short-lived and will reboot after dump collection, so the leak is
+ * inconsequential.
+ */
+static int kho_radix_crash_convert_node(struct kho_radix_node *node,
+					unsigned int level)
+{
+	struct kho_radix_node *child;
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < (1 << KHO_TABLE_SIZE_LOG2); i++) {
+		if (!node->table[i])
+			continue;
+
+		/* Validate: PA must have bit 63 clear and be page-aligned */
+		if ((node->table[i] & BIT_ULL(63)) ||
+		    (node->table[i] & (PAGE_SIZE - 1)))
+			return -EINVAL;
+
+		child = memremap(node->table[i], PAGE_SIZE, MEMREMAP_WB);
+		if (!child)
+			return -ENOMEM;
+
+		/* Overwrite PA with VA in-place */
+		node->table[i] = (u64)(uintptr_t)child;
+
+		/* Recurse for intermediate levels; level 1 children are leaves */
+		if (level > 1) {
+			err = kho_radix_crash_convert_node(child, level - 1);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * kho_radix_crash_init - Initialize a crash-kernel view of a KHO radix tree.
+ * @tree: The crash tree to initialize.
+ * @root_pa: Physical address of the radix tree root from the old kernel.
+ *
+ * Maps the old kernel's radix tree into the crash kernel's address space
+ * by memremapping each node and converting table entries from physical to
+ * virtual addresses in-place. After successful initialization, the tree
+ * can be traversed with kho_radix_crash_contains_page() using direct
+ * pointer dereferencing.
+ *
+ * This function is intended for use in the crash kernel where the old
+ * kernel's memory is not in the direct map. No locking is used as the
+ * crash kernel is effectively single-threaded during dump collection.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kho_radix_crash_init(struct kho_radix_crash_tree *tree, phys_addr_t root_pa)
+{
+	struct kho_radix_node *root;
+	int err;
+
+	tree->root = NULL;
+
+	if (!root_pa || (root_pa & (PAGE_SIZE - 1)))
+		return -EINVAL;
+
+	root = memremap(root_pa, PAGE_SIZE, MEMREMAP_WB);
+	if (!root)
+		return -ENOMEM;
+
+	err = kho_radix_crash_convert_node(root, KHO_TREE_MAX_DEPTH - 1);
+	if (err)
+		return err;
+
+	tree->root = root;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_radix_crash_init);
+
+/**
+ * kho_radix_crash_contains_page - Check if a page is in a crash-kernel radix tree.
+ * @tree: The crash tree, previously initialized with kho_radix_crash_init().
+ * @pfn: The page frame number to check.
+ * @order: The order of the page.
+ *
+ * Traverses the radix tree using direct pointer dereferencing (the table
+ * entries were converted from PA to VA during init). No locking is used as the
+ * crash kernel is effectively single-threaded during dump collection.
+ *
+ * Note: This function checks specifically for the presence of the page at the
+ * given order. If a larger order page that encompasses this page is preserved,
+ * this function will return false.
+ *
+ * Return: true if the page is present in the tree, false otherwise.
+ */
+bool kho_radix_crash_contains_page(struct kho_radix_crash_tree *tree,
+				   unsigned long pfn, unsigned int order)
+{
+	unsigned long key = kho_encode_radix_key(PFN_PHYS(pfn), order);
+	struct kho_radix_node *node = tree->root;
+	struct kho_radix_leaf *leaf;
+	unsigned int i, idx;
+
+	if (!tree->root)
+		return false;
+
+	/* Traverse using VA pointers stored in table[] */
+	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
+		idx = kho_radix_get_table_index(key, i);
+
+		if (!node->table[idx])
+			return false;
+
+		node = (struct kho_radix_node *)(uintptr_t)node->table[idx];
+	}
+
+	leaf = (struct kho_radix_leaf *)node;
+	idx = kho_radix_get_bitmap_index(key);
+	return test_bit(idx, leaf->bitmap);
+}
+EXPORT_SYMBOL_GPL(kho_radix_crash_contains_page);
+
 static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 			       const struct kho_radix_walk_cb *cb, void *data)
 {
-- 
2.43.0


