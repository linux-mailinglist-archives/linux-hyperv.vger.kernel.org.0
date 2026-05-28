Return-Path: <linux-hyperv+bounces-11269-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOYsGaOQF2rkJQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11269-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:47:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE9E5EB61B
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45E6D315C864
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 00:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237E21A680F;
	Thu, 28 May 2026 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bp34lIni"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF991A0B15;
	Thu, 28 May 2026 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928948; cv=none; b=TEZdLIYt+44RBJGq5tQOu4XgfymJZrM6hGDqTSkwLqFqFbfeX8AVX8pAIkK8NITnlIFUwenaDVtBpxghkZfN9XECs0+2mbpAe5+nvrE8yGkMfCENTssPd5PzTlQLCEZa+D6eGdWGx9tlfe6bHcdCorblrPRG0QnSnWDdy0Z4Pxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928948; c=relaxed/simple;
	bh=g/amd3wyILjuFDEfmU6gXK+A7Dop+uIHBRXcymoLhAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9vHAyADroLwmDuDNfeFFifSvvmo73Vv+lvDjWdXHcOF2z7mDKKQwALej2R0+o2pNbOZp+EXwWeteBgwiseyQ+6rXH43wC0ZSthByGdF2/bbKClf7qyI4K1YFaKj48w1Ta4ig34cJQh9CapVBEtqnuuaAdyhWmX8XfYdWChkU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bp34lIni; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 0F05620B7172; Wed, 27 May 2026 17:42:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F05620B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928934;
	bh=J0h8gL8oeiYOkTla/NXs28W2cqoxPWC9xdMqpesgNs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bp34lIniJvhoyH3OAvlDa8UBFuDbwE4WyLr0nUq53yto3zOxzO98Nh5+zW35NQyOi
	 AWoc5aUOfSx0bpnjf9q/TWyi/sXx3cdKU9GEMor/ruRJ+UnKadXc8pz+Rwrek/nPDF
	 3LKQcLdzKcZQVEwFPsrztbrAmGTcKgX5+JVDG8SU=
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
Subject: [RFC PATCH 05/20] kho: add data argument to radix walk callback
Date: Wed, 27 May 2026 17:41:47 -0700
Message-ID: <20260528004204.1484584-6-jloeser@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,lists.infradead.org,vger.kernel.org,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11269-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EDE9E5EB61B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Add an opaque data pointer argument to kho_radix_walk_cb_t. This can be
used for callers to pass extra information to the callback.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 include/linux/kho_radix_tree.h     |  8 ++++----
 kernel/liveupdate/kexec_handover.c | 24 +++++++++++++-----------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index fe7151d89361..6c0f7d82716b 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -44,8 +44,8 @@ struct kho_radix_tree {
  * return value is directly returned to the caller.
  */
 struct kho_radix_walk_cb {
-	int (*key)(unsigned long key);
-	int (*table)(phys_addr_t phys);
+	int (*key)(unsigned long key, void *data);
+	int (*table)(phys_addr_t phys, void *data);
 };
 
 #ifdef CONFIG_KEXEC_HANDOVER
@@ -53,7 +53,7 @@ struct kho_radix_walk_cb {
 int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
 void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
-			const struct kho_radix_walk_cb *cb);
+			const struct kho_radix_walk_cb *cb, void *data);
 
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
 
@@ -66,7 +66,7 @@ static inline void kho_radix_del_key(struct kho_radix_tree *tree,
 				     unsigned long key) { }
 
 static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
-				      const struct kho_radix_walk_cb *cb)
+				      const struct kho_radix_walk_cb *cb, void *data)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 0f8d058f1a27..f6de6bf63226 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -267,14 +267,14 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 EXPORT_SYMBOL_GPL(kho_radix_del_key);
 
 static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
-			       const struct kho_radix_walk_cb *cb)
+			       const struct kho_radix_walk_cb *cb, void *data)
 {
 	unsigned long *bitmap = (unsigned long *)leaf;
 	unsigned int i;
 	int err;
 
 	if (cb->table) {
-		err = cb->table(virt_to_phys(leaf));
+		err = cb->table(virt_to_phys(leaf), data);
 		if (err)
 			return err;
 	}
@@ -283,7 +283,7 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 		return 0;
 
 	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
-		err = cb->key(key | i);
+		err = cb->key(key | i, data);
 		if (err)
 			return err;
 	}
@@ -293,7 +293,7 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 
 static int __kho_radix_walk_tree(struct kho_radix_node *root,
 				 unsigned int level, unsigned long start,
-				 const struct kho_radix_walk_cb *cb)
+				 const struct kho_radix_walk_cb *cb, void *data)
 {
 	struct kho_radix_node *node;
 	struct kho_radix_leaf *leaf;
@@ -302,7 +302,7 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
 	int err;
 
 	if (cb->table) {
-		err = cb->table(virt_to_phys(root));
+		err = cb->table(virt_to_phys(root), data);
 		if (err)
 			return err;
 	}
@@ -323,10 +323,10 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
 			 * node is pointing to the level 0 bitmap.
 			 */
 			leaf = (struct kho_radix_leaf *)node;
-			err = kho_radix_walk_leaf(leaf, key, cb);
+			err = kho_radix_walk_leaf(leaf, key, cb, data);
 		} else {
 			err  = __kho_radix_walk_tree(node, level - 1,
-						     key, cb);
+						     key, cb, data);
 		}
 
 		if (err)
@@ -340,6 +340,7 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
  * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each key.
  * @tree: A pointer to the KHO radix tree to walk.
  * @cb:   Set of callbacks to be invoked during the tree walk.
+ * @data: Opaque data pointer passed to each callback in @cb.
  *
  * This function walks the radix tree, searching from the top level down to the
  * lowest level (level 0), invoking the appropriate callbacks.
@@ -348,14 +349,15 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
  *         value from the callback that stopped the walk.
  */
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
-			const struct kho_radix_walk_cb *cb)
+			const struct kho_radix_walk_cb *cb, void *data)
 {
 	if (WARN_ON_ONCE(!tree->root))
 		return -EINVAL;
 
 	guard(mutex)(&tree->lock);
 
-	return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, 0, cb);
+	return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, 0, cb,
+				     data);
 }
 EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
 
@@ -486,7 +488,7 @@ static struct page *__init kho_get_preserved_page(phys_addr_t phys,
 	return pfn_to_page(pfn);
 }
 
-static int __init kho_preserved_memory_reserve(unsigned long key)
+static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
 {
 	union kho_page_info info;
 	struct page *page;
@@ -1414,7 +1416,7 @@ static int __init kho_mem_retrieve(const void *fdt)
 
 	kho_in.radix_tree.root = phys_to_virt(kho_get_mem_map_phys(fdt));
 	mutex_init(&kho_in.radix_tree.lock);
-	return kho_radix_walk_tree(&kho_in.radix_tree, &cb);
+	return kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL);
 }
 
 static __init int kho_out_fdt_setup(void)
-- 
2.43.0


